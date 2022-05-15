Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14223527529
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 May 2022 05:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiEODa3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 May 2022 23:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiEODa2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 May 2022 23:30:28 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E101A81B
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 May 2022 20:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nhtb/vVbNQi7KT7E2xFSvwNUPK42pr4+EHZksIUi5v8=; b=mfJ5T/10VRMNvSTmTSFG0pHEQ4
        x8+NnJB1rOyavfSGOkGy2o4IiemW3/rJ4U1aAvjWqCVdlgu+jM6qd/kWrDQTuAJlNBmESwPZbQfVx
        TfZ5RNIQY0AytMHBDaGyV8e3JbZDemHnjjabfxSgnbMp2FIY1G8/6BpvzsmpRIYWExJG5qX+QziVm
        bKmwxw7LFaMEj1D2WWs9pvA0y0zBOp6pThN9jYta2Tw/kAlhAwS9tcE9yzPODLUDzKAe40q7zTY2f
        3kz0OS6yJmM6T7buOwFN3Wjvvq1SKZRdUcxLV6N6oJXBXkW5+9z/QcNPctqiLbuFvz0eqQqvMaTgW
        Dd/SRJYQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nq4xb-00F3o9-V7; Sun, 15 May 2022 03:30:24 +0000
Date:   Sun, 15 May 2022 03:30:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [BUG] double fget() in vhost/net (was Re: [PATCH] vfs: move fdput()
 to right place in ksys_sync_file_range())
Message-ID: <YoBzzxlYHYXEP3qj@zeniv-ca.linux.org.uk>
References: <20220511154503.28365-1-cgxu519@mykernel.net>
 <YnvbhmRUxPxWU2S3@casper.infradead.org>
 <YnwIDpkIBem+MeeC@gmail.com>
 <YnwuEt2Xm1iPjW7S@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnwuEt2Xm1iPjW7S@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[tun/tap and vhost folks Cc'd]

here's another piece of code assuming that repeated fget() will yield the
same opened file: in vhost_net_set_backend() we have

        sock = get_socket(fd);
        if (IS_ERR(sock)) {
                r = PTR_ERR(sock);
                goto err_vq;
        }

        /* start polling new socket */
        oldsock = vhost_vq_get_backend(vq);
        if (sock != oldsock) {
...
                vhost_vq_set_backend(vq, sock);
...
                if (index == VHOST_NET_VQ_RX)
                        nvq->rx_ring = get_tap_ptr_ring(fd);

with
static struct socket *get_socket(int fd)
{
        struct socket *sock;

        /* special case to disable backend */
        if (fd == -1)
                return NULL;
        sock = get_raw_socket(fd);
        if (!IS_ERR(sock))
                return sock;
        sock = get_tap_socket(fd);
        if (!IS_ERR(sock))
                return sock;
        return ERR_PTR(-ENOTSOCK);
}
and
static struct ptr_ring *get_tap_ptr_ring(int fd)
{
        struct ptr_ring *ring;
        struct file *file = fget(fd);

        if (!file)
                return NULL;
        ring = tun_get_tx_ring(file);
        if (!IS_ERR(ring))
                goto out;
        ring = tap_get_ptr_ring(file);
        if (!IS_ERR(ring))
                goto out;
        ring = NULL;
out:
        fput(file);
        return ring;
}

Again, there is no promise that fd will resolve to the same thing for
lookups in get_socket() and in get_tap_ptr_ring().  I'm not familiar
enough with the guts of drivers/vhost to tell how easy it is to turn
into attack, but it looks like trouble.  If nothing else, the pointer
returned by tun_get_tx_ring() is not guaranteed to be pinned down by
anything - the reference to sock will _usually_ suffice, but that
doesn't help any if we get a different socket on that second fget().

One possible way to fix it would be the patch below; objections?

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 792ab5f23647..86ea7695241e 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1450,13 +1450,9 @@ static struct socket *get_raw_socket(int fd)
 	return ERR_PTR(r);
 }
 
-static struct ptr_ring *get_tap_ptr_ring(int fd)
+static struct ptr_ring *get_tap_ptr_ring(struct file *file)
 {
 	struct ptr_ring *ring;
-	struct file *file = fget(fd);
-
-	if (!file)
-		return NULL;
 	ring = tun_get_tx_ring(file);
 	if (!IS_ERR(ring))
 		goto out;
@@ -1465,7 +1461,6 @@ static struct ptr_ring *get_tap_ptr_ring(int fd)
 		goto out;
 	ring = NULL;
 out:
-	fput(file);
 	return ring;
 }
 
@@ -1553,7 +1548,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 		if (r)
 			goto err_used;
 		if (index == VHOST_NET_VQ_RX)
-			nvq->rx_ring = get_tap_ptr_ring(fd);
+			nvq->rx_ring = get_tap_ptr_ring(sock->file);
 
 		oldubufs = nvq->ubufs;
 		nvq->ubufs = ubufs;
