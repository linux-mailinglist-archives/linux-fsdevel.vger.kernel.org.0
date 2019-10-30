Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 886B1E9E6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 16:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfJ3PIA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 11:08:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21120 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727051AbfJ3PH7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572448078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sOEwas89nJkqsGmIKgnOb7SyquuodU2BlF653zxQHMc=;
        b=Skx34UyZ3yyGA1oC4TxhM8YpQobyIYYW+tRlTeeFf1z5mnOBvZRutY08DE3J07/BOyo5Ui
        nljIiR7HTB9WV6r7jnYQKh7I9+XmcIx2CtrRwHCNfG/KofkPvpthfYHOBLLjrN/uR52ayP
        SYMwRxemCLP8U8LZ4J4LnTG/JbVE7F4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-YKMwK29qOfSnBVTuxpoyKA-1; Wed, 30 Oct 2019 11:07:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF857800C61;
        Wed, 30 Oct 2019 15:07:44 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B25C5DA70;
        Wed, 30 Oct 2019 15:07:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id DBFFE223A56; Wed, 30 Oct 2019 11:07:38 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     virtualization@lists.linux-foundation.org, vgoyal@redhat.com,
        miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com
Subject: [PATCH 2/3] virtiofs: Do not send forget request "struct list_head" element
Date:   Wed, 30 Oct 2019 11:07:18 -0400
Message-Id: <20191030150719.29048-3-vgoyal@redhat.com>
In-Reply-To: <20191030150719.29048-1-vgoyal@redhat.com>
References: <20191030150719.29048-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: YKMwK29qOfSnBVTuxpoyKA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We are sending whole of virtio_fs_foreget struct to the other end over
virtqueue. Other end does not need to see elements like "struct list".
That's internal detail of guest kernel. Fix it.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 6cc7be170cb8..43224db8d9ed 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -48,11 +48,15 @@ struct virtio_fs {
 =09unsigned int num_request_queues; /* number of request queues */
 };
=20
-struct virtio_fs_forget {
+struct virtio_fs_forget_req {
 =09struct fuse_in_header ih;
 =09struct fuse_forget_in arg;
+};
+
+struct virtio_fs_forget {
 =09/* This request can be temporarily queued on virt queue */
 =09struct list_head list;
+=09struct virtio_fs_forget_req req;
 };
=20
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
@@ -325,6 +329,7 @@ static int send_forget_request(struct virtio_fs_vq *fsv=
q,
 =09struct virtqueue *vq;
 =09int ret =3D 0;
 =09bool notify;
+=09struct virtio_fs_forget_req *req =3D &forget->req;
=20
 =09spin_lock(&fsvq->lock);
 =09if (!fsvq->connected) {
@@ -334,7 +339,7 @@ static int send_forget_request(struct virtio_fs_vq *fsv=
q,
 =09=09goto out;
 =09}
=20
-=09sg_init_one(&sg, forget, sizeof(*forget));
+=09sg_init_one(&sg, req, sizeof(*req));
 =09vq =3D fsvq->vq;
 =09dev_dbg(&vq->vdev->dev, "%s\n", __func__);
=20
@@ -730,6 +735,7 @@ __releases(fiq->lock)
 {
 =09struct fuse_forget_link *link;
 =09struct virtio_fs_forget *forget;
+=09struct virtio_fs_forget_req *req;
 =09struct virtio_fs *fs;
 =09struct virtio_fs_vq *fsvq;
 =09u64 unique;
@@ -743,14 +749,15 @@ __releases(fiq->lock)
=20
 =09/* Allocate a buffer for the request */
 =09forget =3D kmalloc(sizeof(*forget), GFP_NOFS | __GFP_NOFAIL);
+=09req =3D &forget->req;
=20
-=09forget->ih =3D (struct fuse_in_header){
+=09req->ih =3D (struct fuse_in_header){
 =09=09.opcode =3D FUSE_FORGET,
 =09=09.nodeid =3D link->forget_one.nodeid,
 =09=09.unique =3D unique,
-=09=09.len =3D sizeof(*forget),
+=09=09.len =3D sizeof(*req),
 =09};
-=09forget->arg =3D (struct fuse_forget_in){
+=09req->arg =3D (struct fuse_forget_in){
 =09=09.nlookup =3D link->forget_one.nlookup,
 =09};
=20
--=20
2.20.1

