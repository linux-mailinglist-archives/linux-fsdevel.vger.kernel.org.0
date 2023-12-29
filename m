Return-Path: <linux-fsdevel+bounces-7016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE79481FE34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 09:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443092825CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 08:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC3879CD;
	Fri, 29 Dec 2023 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GTEGRq7E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26517487;
	Fri, 29 Dec 2023 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703839128; x=1704443928; i=markus.elfring@web.de;
	bh=W6yrPNc43adz34gAMxMy30lvqPV/Eba8/b5dIfUxezo=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=GTEGRq7E43WbnsOExZ3FmdrD+SQrDWgukQPygQzUBqPN0GgsmOK2QX/n/trtOu9J
	 Tg1rESZnVGczPK8Y3R6s1iAWKE1Q7irHKp87HxjlOeyKNuemn0BWqiduqdiaw1Vum
	 3AKU3gFM9ruGWLNqPKNemD583a1YVvGjGF1gvRFyuCQlqa8IX6FTJ7kxYaUhEs5Mb
	 WsQlloqImi8SckEc4QtVI6E+s19XbbpliOjlt4/dHDNsyHvUrjU1oWTpn8IeqeNQj
	 2vG7JFbPWMz89emLGcOtoOFymeohYdkdArN8685qj78fgCQkIXKVLOXOlfJG5QCwe
	 to1v45rjUEzmKBSSzA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKdLM-1rXVTg0Ew8-00LPOS; Fri, 29
 Dec 2023 09:38:48 +0100
Message-ID: <5745d81c-3c06-4871-9785-12a469870934@web.de>
Date: Fri, 29 Dec 2023 09:38:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] virtiofs: Improve error handling in virtio_fs_get_tree()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <c5c14b02-660a-46e1-9eb3-1a16d7c84922@web.de>
In-Reply-To: <c5c14b02-660a-46e1-9eb3-1a16d7c84922@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dIIBJp/wUeMxRDCbjzb05hZ0LyYzeW7/8EGr8swHME9Epop0uR0
 XZKg5ysWpkbun+8jJjsN7ht/i7ypbe0HQ9ZbUd7jOZ+RUUT2kztJ9fsQoaYrs3dCBIj3YbO
 /5HbvkTEjiqjrOvLCRhz42fQgN8hkKr9jaHgkwh4lFtDk08OpaOUKx3+89gRGu3Wehu1nuT
 OlY9TOZhtJhF+e8yiCqhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rMTlxTdEg3Y=;mT6F3lBfUJnD7ni8owTQkOy+hlo
 8kC2lDaDeta2038RkVjnn0wJr3oJRh1Kg4d/RGJ8dRkmEkM4xRWBOvd4DM7flB8RdCJbh7wLB
 vqk9DfK5d29E4k6c1RPShkYkRZxNsC01sH6j+ncv4U3A7OKe6zz4k3JCY270XCpJFYu7MTUgA
 YYnUhlIr/ZYQ1Zq4xYVkb3thHOmPGWJM0t8iL+ePMOXOPH05z1UKitcRxTn3TqhIQWkdOl3IR
 iZBvfVIKj1WjGvlO+42BkKLvF7rQtT8kW0wRJPiKk8HMmS9pQ1Rv+5Ljrc0layX0UwPiWzG4t
 TMFXxoA/YOBYHawpxsv0GlsHBQns1G+8GxiJtDqB52D0IXi1X+Ch2ul+64wCF7HTDWBVs4W69
 BqeU7Q4icFO6bjJ8MoNa73DS/wv67GfD0GTwAQksme6kks0bGA/Sk8yczi7jBtKcZFhqdb8qW
 GVadJ3FXlkx9pDZ8wtbD5/FNtTbnBSdtjSTsgdkafNRbPA6F9FU993L0YpdKqi72DIpqAFNwk
 WPJCZXZqP1q1X1cSceIaVYTY8wGR5oa+XycGCfsf5R/mUXrtWvMkX6zkWqYIHhXHl2664Xfug
 5y8CZ16DbfkMZorabZCc6Skxv6xLKdE2/tsdNV7o+G1y0QO7a8ZKchzSX/pV/BzhdAkF7zcqV
 mP/oISwJnQCDpCNLgVrgGe999E+JrDs+J2gEejxb047zNIGgEx9g+zz4OpyyT2+bTNAx0lJwn
 R1bWuS78HlpjZ8IndQoiylOxxrKMhVJwe+t9B24Vxks88BKLFfuT0iMza0v1ZimFOQWeP2Bj4
 PjAr1kFT+XJl2dVXxWYwEbI7KfY5GU2e7n4aZiM4zuT/uBmIPnaos8xoV+E+moOnrXkCpj9gv
 QgrqabNuqIVYpO1Cnj9fSKPN50eHryQRhjhN5qk3xACU1t8hfJXWpf57GqiBMYZ0CUQOtYjr/
 KQq6kQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 29 Dec 2023 09:15:07 +0100

The kfree() function was called in two cases by
the virtio_fs_get_tree() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus use another label.

* Move an error code assignment into an if branch.

* Delete an initialisation (for the variable =E2=80=9Cfc=E2=80=9D)
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/fuse/virtio_fs.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 2f8ba9254c1e..0746f54ec743 100644
=2D-- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1415,10 +1415,10 @@ static int virtio_fs_get_tree(struct fs_context *f=
sc)
 {
 	struct virtio_fs *fs;
 	struct super_block *sb;
-	struct fuse_conn *fc =3D NULL;
+	struct fuse_conn *fc;
 	struct fuse_mount *fm;
 	unsigned int virtqueue_size;
-	int err =3D -EIO;
+	int err;

 	/* This gets a reference on virtio_fs object. This ptr gets installed
 	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
@@ -1431,13 +1431,15 @@ static int virtio_fs_get_tree(struct fs_context *f=
sc)
 	}

 	virtqueue_size =3D virtqueue_get_vring_size(fs->vqs[VQ_REQUEST].vq);
-	if (WARN_ON(virtqueue_size <=3D FUSE_HEADER_OVERHEAD))
-		goto out_err;
+	if (WARN_ON(virtqueue_size <=3D FUSE_HEADER_OVERHEAD)) {
+		err =3D -EIO;
+		goto lock_mutex;
+	}

 	err =3D -ENOMEM;
 	fc =3D kzalloc(sizeof(*fc), GFP_KERNEL);
 	if (!fc)
-		goto out_err;
+		goto lock_mutex;

 	fm =3D kzalloc(sizeof(*fm), GFP_KERNEL);
 	if (!fm)
@@ -1476,6 +1478,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc=
)

 out_err:
 	kfree(fc);
+lock_mutex:
 	mutex_lock(&virtio_fs_mutex);
 	virtio_fs_put(fs);
 	mutex_unlock(&virtio_fs_mutex);
=2D-
2.43.0


