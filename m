Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F8C63F4D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 17:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiLAQIT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 11:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiLAQIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:08:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1084AB5DBF
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 08:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669910792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PamKx232vfxvsaWPi1/5x3ys13CWorTpvsS3jNFLNq0=;
        b=JZ3c8RwL1iXOaDs98FMrhQFu7IMuPvDippByulywqkHOkR/An3mSzFjMaSM2HMumxDl4mF
        GKO3P3cpPfw0DUcqOcGCTA90XmQYgAWOFgLE4l9ejc7El0mtsMP9vdiLnCa+X61OS7/Wqu
        VYF04IFRXWPps0+teHNFzFd5bcg/Qm0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-4kkp5bLeOxOLIRlBDC_4bg-1; Thu, 01 Dec 2022 11:06:23 -0500
X-MC-Unique: 4kkp5bLeOxOLIRlBDC_4bg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A233858F13;
        Thu,  1 Dec 2022 16:06:22 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-141.brq.redhat.com [10.40.192.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DE53111E3FA;
        Thu,  1 Dec 2022 16:06:19 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: [RFC 0/3] Turn iomap_page_ops into iomap_folio_ops
Date:   Thu,  1 Dec 2022 17:06:16 +0100
Message-Id: <20221201160619.1247788-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

we're seeing a race between journaled data writes and the shrinker on
gfs2.  What's happening is that gfs2_iomap_page_done() is called after
the page has been unlocked, so try_to_free_buffers() can come in and
free the buffers while gfs2_iomap_page_done() is trying to add them to
the transaction.  Not good.

This is a proposal to change iomap_page_ops so that page_prepare()
prepares the write and grabs the locked page, and page_done() unlocks
and puts that page again.  While at it, this also converts the hooks
from pages to folios.

To move the pagecache_isize_extended() call in iomap_write_end() out of
the way, a new folio_may_straddle_isize() helper is introduced that
takes a locked folio.  That is then used when the inode size is updated,
before the folio is unlocked.

I've also converted the other applicable folio_may_straddle_isize()
users, namely generic_write_end(), ext4_write_end(), and
ext4_journalled_write_end().

Any thoughts?

Thanks,
Andreas

Andreas Gruenbacher (3):
  fs: Add folio_may_straddle_isize helper
  iomap: Turn iomap_page_ops into iomap_folio_ops
  gfs2: Fix race between shrinker and gfs2_iomap_folio_done

 fs/buffer.c            |  5 ++---
 fs/ext4/inode.c        | 13 +++++------
 fs/gfs2/bmap.c         | 39 +++++++++++++++++++++++---------
 fs/iomap/buffered-io.c | 51 +++++++++++++++++++++---------------------
 include/linux/iomap.h  | 24 ++++++++++----------
 include/linux/mm.h     |  2 ++
 mm/truncate.c          | 34 ++++++++++++++++++++++++++++
 7 files changed, 110 insertions(+), 58 deletions(-)

-- 
2.38.1

