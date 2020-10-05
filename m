Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A7E283DB2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Oct 2020 19:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgJERpp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 13:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbgJERpo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601919943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QOkVtGCRchNdZfPN4mCXl9IwLRbvn/W1CIxobW81qOA=;
        b=gF7gUYRrUn3nrSeN7kQA9tTOZ8oy37QnIcN0TgBQp9P1KN5izRKutzHz8TU02Z1ftoKAz1
        ad8w1g/pD8e6IFI/m1q1K5Z0lAPmSnErK2OlAJwCVtNN2OLrL1zY1QRnPfdXwfTm5eQsTt
        SZHNStVhflIBKWsxFagLqAs0EbjNnQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-NZ7F8Q29P0O-3hWMkOZ_eA-1; Mon, 05 Oct 2020 13:45:41 -0400
X-MC-Unique: NZ7F8Q29P0O-3hWMkOZ_eA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3611107ACF5;
        Mon,  5 Oct 2020 17:45:40 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-167.rdu2.redhat.com [10.10.114.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AC0710013BD;
        Mon,  5 Oct 2020 17:45:31 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 440B1220AD7; Mon,  5 Oct 2020 13:45:31 -0400 (EDT)
Date:   Mon, 5 Oct 2020 13:45:31 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        virtio-fs-list <virtio-fs@redhat.com>,
        CAI Qian <caiqian@redhat.com>
Subject: [PATCH] virtiofs: Fix false positive warning
Message-ID: <20201005174531.GB4302@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

virtiofs currently maps various buffers in scatter gather list and it looks
at number of pages (ap->pages) and assumes that same number of pages will
be used both for input and output (sg_count_fuse_req()), and calculates
total number of scatterlist elements accordingly.

But looks like this assumption is not valid in all the cases. For example,
Cai Qian reported that trinity, triggers warning with virtiofs sometimes.
A closer look revealed that if one calls ioctl(fd, 0x5a004000, buf), it
will trigger following warning.

WARN_ON(out_sgs + in_sgs != total_sgs)

In this case, total_sgs = 8, out_sgs=4, in_sgs=3. Number of pages is 2
(ap->pages), but out_sgs are using both the pages but in_sgs are using
only one page. (fuse_do_ioctl() sets out_size to one page).

So existing WARN_ON() seems to be wrong. Instead of total_sgs, it should
be max_sgs and make sure out_sgs and in_sgs don't cross max_sgs. This
will allow input and output pages numbers to be different.

Reported-by: Qian Cai <cai@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Link: https://lore.kernel.org/linux-fsdevel/5ea77e9f6cb8c2db43b09fbd4158ab2d8c066a0a.camel@redhat.com/
---
 fs/fuse/virtio_fs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index da3ede268604..3f4f2fa0bb96 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1110,17 +1110,17 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	unsigned int argbuf_used = 0;
 	unsigned int out_sgs = 0;
 	unsigned int in_sgs = 0;
-	unsigned int total_sgs;
+	unsigned int  max_sgs;
 	unsigned int i;
 	int ret;
 	bool notify;
 	struct fuse_pqueue *fpq;
 
 	/* Does the sglist fit on the stack? */
-	total_sgs = sg_count_fuse_req(req);
-	if (total_sgs > ARRAY_SIZE(stack_sgs)) {
-		sgs = kmalloc_array(total_sgs, sizeof(sgs[0]), GFP_ATOMIC);
-		sg = kmalloc_array(total_sgs, sizeof(sg[0]), GFP_ATOMIC);
+	max_sgs = sg_count_fuse_req(req);
+	if (max_sgs > ARRAY_SIZE(stack_sgs)) {
+		sgs = kmalloc_array(max_sgs, sizeof(sgs[0]), GFP_ATOMIC);
+		sg = kmalloc_array(max_sgs, sizeof(sg[0]), GFP_ATOMIC);
 		if (!sgs || !sg) {
 			ret = -ENOMEM;
 			goto out;
@@ -1149,9 +1149,9 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 					    req->argbuf + argbuf_used, NULL);
 	}
 
-	WARN_ON(out_sgs + in_sgs != total_sgs);
+	WARN_ON(out_sgs + in_sgs > max_sgs);
 
-	for (i = 0; i < total_sgs; i++)
+	for (i = 0; i < (out_sgs + in_sgs); i++)
 		sgs[i] = &sg[i];
 
 	spin_lock(&fsvq->lock);
-- 
2.25.4

