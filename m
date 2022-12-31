Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F70465A556
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 16:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiLaPKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Dec 2022 10:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbiLaPKP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Dec 2022 10:10:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C366E642D
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Dec 2022 07:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672499366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=S46GJjFnRtEs4ZF4WLB+hxVTgfYfNE/hUwjLY/tXs74=;
        b=Z/AJSC7EtFcNmWK0DA1z93mSqXGCzNPmxnolVH54lTacsCJqmOZiKQITfb/euDQlZosj68
        qA0geRgun+VW31TjFUrNprYGcKnEpq8t8lMNt5O8Q6D1MRa62ysRPiSdAdb+tQnYTS8Tfi
        7tnIycLHoPp07O04Mep431ftpyXObVc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-6d9x8k0TNpuKVA_6fvvkaw-1; Sat, 31 Dec 2022 10:09:23 -0500
X-MC-Unique: 6d9x8k0TNpuKVA_6fvvkaw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E89D58F6E80;
        Sat, 31 Dec 2022 15:09:22 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-3.brq.redhat.com [10.40.192.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7AE9492B00;
        Sat, 31 Dec 2022 15:09:20 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: [PATCH v5 0/9] Turn iomap_page_ops into iomap_folio_ops
Date:   Sat, 31 Dec 2022 16:09:10 +0100
Message-Id: <20221231150919.659533-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's an updated version of this patch queue.  Changes since v4 [*]:

* I've removed "fs: Add folio_may_straddle_isize helper" as I couldn't
  get any feedback from Al Viro; the patch isn't essential for this
  patch queue.

* The iomap_folio_ops operations have been renamed to ->get_folio() and
  ->put_folio(), and the helpers have been renamed to iomap_get_folio()
  and iomap_put_folio().

* Patch "xfs: Make xfs_iomap_folio_ops static" has been added at the
  end.

The patches are split up into relatively small pieces.  That may seem
unnecessary, but at least it makes reviewing the patches easier.

If there are no more objections, can this go into iomap-for-next?

Thanks,
Andreas

[*] https://lore.kernel.org/linux-xfs/20221218221054.3946886-1-agruenba@redhat.com/

Andreas Gruenbacher (9):
  iomap: Add iomap_put_folio helper
  iomap/gfs2: Unlock and put folio in page_done handler
  iomap: Rename page_done handler to put_folio
  iomap: Add iomap_get_folio helper
  iomap/gfs2: Get page in page_prepare handler
  iomap: Rename page_prepare handler to get_folio
  iomap/xfs: Eliminate the iomap_valid handler
  iomap: Rename page_ops to folio_ops
  xfs: Make xfs_iomap_folio_ops static

 fs/gfs2/bmap.c         | 38 ++++++++++------
 fs/iomap/buffered-io.c | 98 ++++++++++++++++++++++--------------------
 fs/xfs/xfs_iomap.c     | 41 ++++++++++++------
 include/linux/iomap.h  | 51 +++++++++-------------
 4 files changed, 127 insertions(+), 101 deletions(-)

-- 
2.38.1

