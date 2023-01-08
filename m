Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1A36618A8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 20:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjAHTld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 14:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjAHTla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 14:41:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E27B85C
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jan 2023 11:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673206844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RnHdpHKPjRbgtteLZNatBvGeLtifDpTNmLxdoQh5COI=;
        b=UMRebtbuPHqEGbJCrbQjoXGrGabhNqWeqXCGXHBrDKfB95uWFcaOBNUwcDA0r4t6ugtySl
        xhsMOW7nLscDEjnUbnD4s+lFdM1YxfrNMlGQRF110/iyGc6ElpBxKxFEboXRW/x3ckV9Xv
        cQ2C7jcJ6TcUW95OQ8FsCvFW+CXUPvw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-FF6jQcO5NGGDMftbRaivlQ-1; Sun, 08 Jan 2023 14:40:38 -0500
X-MC-Unique: FF6jQcO5NGGDMftbRaivlQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0185F3C02B59;
        Sun,  8 Jan 2023 19:40:38 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-3.brq.redhat.com [10.40.192.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE474492B06;
        Sun,  8 Jan 2023 19:40:35 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: [RFC v6 00/10] Turn iomap_page_ops into iomap_folio_ops
Date:   Sun,  8 Jan 2023 20:40:24 +0100
Message-Id: <20230108194034.1444764-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's an updated version of this patch queue.  Changes since v5 [*]:

* A new iomap-internal __iomap_get_folio() helper was added.

* The previous iomap-internal iomap_put_folio() helper was renamed to
  __iomap_put_folio() to mirror __iomap_get_folio().

* The comment describing struct iomap_folio_ops was still referring to
  pages instead of folios in two places.

Is this good enough for iomap-for-next now, please?

Thanks,
Andreas

[*] https://lore.kernel.org/linux-xfs/20221231150919.659533-1-agruenba@redhat.com/

Andreas Gruenbacher (10):
  iomap: Add __iomap_put_folio helper
  iomap/gfs2: Unlock and put folio in page_done handler
  iomap: Rename page_done handler to put_folio
  iomap: Add iomap_get_folio helper
  iomap/gfs2: Get page in page_prepare handler
  iomap: Add __iomap_get_folio helper
  iomap: Rename page_prepare handler to get_folio
  iomap/xfs: Eliminate the iomap_valid handler
  iomap: Rename page_ops to folio_ops
  xfs: Make xfs_iomap_folio_ops static

 fs/gfs2/bmap.c         |  38 ++++++++++-----
 fs/iomap/buffered-io.c | 105 +++++++++++++++++++++++------------------
 fs/xfs/xfs_iomap.c     |  41 +++++++++++-----
 include/linux/iomap.h  |  50 +++++++++-----------
 4 files changed, 134 insertions(+), 100 deletions(-)

-- 
2.38.1

