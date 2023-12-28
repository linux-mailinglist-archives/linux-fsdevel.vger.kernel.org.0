Return-Path: <linux-fsdevel+bounces-7008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A422281FB49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 22:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3611C210B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 21:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858D110951;
	Thu, 28 Dec 2023 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="h1XN08sq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F68107B8;
	Thu, 28 Dec 2023 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703797333; x=1704402133; i=markus.elfring@web.de;
	bh=zCoJyL9Lw4BVM5kJ+m1jFQlSFuHfKA5ZkN/ugCaGkpc=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=h1XN08sqdVCVFxsP7TYketpXPUaKnK1+M0EdcqABxTYqmQD1sm2wA9JXSH2zRTms
	 z5enO3BSwZz2Dp0wjSsUFAnXSxLwUo+y6PMawu74k0aTvm8o+JlR7Oy7W/aaMMlMo
	 ShkRlcxI+dm847VBWVxmszSwD3W+YueSu5syaciftS5w/pC0Nj8n9/hSGCeH+5lF3
	 8TlMsyNZ0fXwu+DzltBcBEG0ebcMIfREBkiFD8DijLpPw3XGhcKAVrGuSB+kBZS0t
	 830/0GPfL5unmeNyZpvG2GL8d5EUp07UXJgM2A7ETV8t5A/fKBDxXHWnD2Qg8cBWG
	 R5n9WDRvAF5QoI47uA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuSe-1qmwgD2V0e-00eyTS; Thu, 28
 Dec 2023 22:02:13 +0100
Message-ID: <70ebc121-4332-4c64-9a20-29837758aa19@web.de>
Date: Thu, 28 Dec 2023 22:02:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] fuse: Improve error handling in two functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sHkI+Rrr7HyBvSt5sCxNI/wtzr9ipPp2/2/6P80wlBkN3nQbGSa
 Pw8eCfF+LdglRxo1FTd7N+ircSHEN5pTeCjCbQ4HOPx0DAspdALzJR+Vy9U3ghX/2kl/E8h
 Ffv58CG14w3dWhInpWq7/8AF5jZF/mEfAOh2Kd4TyPy+r2K0GpOUiaCaWo9AnVD2DokyjpH
 2PHCtpW4IpdzwdxZQi+lw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:STsuKzCbHW8=;Wxxtfx1zyOZ52rRYSBkfa/Yl100
 dCwVvtn/F+YONzPwvQbiHmNetoF+3NOTfnHTK7AXuSM31nifq+OgH3RbZxu3EfRXwSKWGvY1D
 7wdBR1+CilJVvWKVkJZIFG2ZZoXqOEW6KwHqRJuXEe5DxgtpPqBRa0T5T/RSbtNt9bIGwdubw
 MSUkdU23oU5Elc+/IDBae1dk8+ZJc0jMr6QhvPo0Ve4YrN66OE7eTwVXQdkUWyUBo6lvKJjE6
 aF5bzsD7HzDCQckGIjsR6RrWPNlsqf9VJNFy222/B9f/INZB6yAuxoO2+b/ayrHPTertRqO3f
 SncHB0+LWe12u7Hg4v7kgxBdkyfiHbb0wHB/R437FhAnNs/L0Sz/wUZSmtMki0DBEMKyfU/oD
 0Gov5iNtsY9zFAT3yiUeK4bgug0HaDFmIe3ZLc6ewZN7e7Yqeuw5Gql/dtUQipqearRe/qKZN
 LPreTFHkU6QlazV/Huq5NHQDk4SdlNanPRpvq40wxeTnEmvYEsD8FC+iRdG1XPpi7P0YRG2Ca
 XvMZbWdqF5JgnWftQjmltHSWuEIy/r2lF5sBlS1UkiMPeHTb5+qk0SZy4e58BFHstkk0bTVr8
 2Qxih6GwQ4IAKzbx4+kGq5jMqBnEBJizwUcMtB4OiPMPbgrV01qHVFznXPZ6zlwzcfigfyhlP
 2A2zwiGEqYKeAMfe6TRuzG5FayiL8SdzXtjeDqC+QOF0No+H0EKj47cMSO0WUAcQvvo+A01gt
 4awQetcFgRlbrwqln0CHdcoZnZjJ7iCZ2zb1Vl82xtUlo9ai6o7RML8jHATq+HwaGbTqtieyS
 YMp8SJv35QX1pqlkkjHtTHQrKIh8k534EwdJ6nfQH3ZbFqFa9fbEqjnTTU1RhQRaPjwbNoPXZ
 Y5ejcOAOsgOC0wd1vfeaX7Lkf8bCf9FULNvzh935sepOGq9oYjcnZILDLkot8pCCmno9swct0
 INueJWRTGj84w4IkTcmFCoEGXUQ=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 28 Dec 2023 21:57:00 +0100

The kfree() function was called in two cases during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus use additional labels.

* Move error code assignments into if branches.

* Delete initialisations (for the variable =E2=80=9Cerr=E2=80=9D)
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/fuse/dev.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1a8f82f478cb..8f2975b1aed3 100644
=2D-- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1468,29 +1468,30 @@ static int fuse_notify_inval_entry(struct fuse_con=
n *fc, unsigned int size,
 				   struct fuse_copy_state *cs)
 {
 	struct fuse_notify_inval_entry_out outarg;
-	int err =3D -ENOMEM;
+	int err;
 	char *buf;
 	struct qstr name;

 	buf =3D kzalloc(FUSE_NAME_MAX + 1, GFP_KERNEL);
-	if (!buf)
-		goto err;
+	if (!buf) {
+		err =3D -ENOMEM;
+		goto finish_copy;
+	}

-	err =3D -EINVAL;
 	if (size < sizeof(outarg))
-		goto err;
+		goto e_inval;

 	err =3D fuse_copy_one(cs, &outarg, sizeof(outarg));
 	if (err)
 		goto err;

-	err =3D -ENAMETOOLONG;
-	if (outarg.namelen > FUSE_NAME_MAX)
+	if (outarg.namelen > FUSE_NAME_MAX) {
+		err =3D -ENAMETOOLONG;
 		goto err;
+	}

-	err =3D -EINVAL;
 	if (size !=3D sizeof(outarg) + outarg.namelen + 1)
-		goto err;
+		goto e_inval;

 	name.name =3D buf;
 	name.len =3D outarg.namelen;
@@ -1506,8 +1507,11 @@ static int fuse_notify_inval_entry(struct fuse_conn=
 *fc, unsigned int size,
 	kfree(buf);
 	return err;

+e_inval:
+	err =3D -EINVAL;
 err:
 	kfree(buf);
+finish_copy:
 	fuse_copy_finish(cs);
 	return err;
 }
@@ -1516,29 +1520,30 @@ static int fuse_notify_delete(struct fuse_conn *fc=
, unsigned int size,
 			      struct fuse_copy_state *cs)
 {
 	struct fuse_notify_delete_out outarg;
-	int err =3D -ENOMEM;
+	int err;
 	char *buf;
 	struct qstr name;

 	buf =3D kzalloc(FUSE_NAME_MAX + 1, GFP_KERNEL);
-	if (!buf)
-		goto err;
+	if (!buf) {
+		err =3D -ENOMEM;
+		goto finish_copy;
+	}

-	err =3D -EINVAL;
 	if (size < sizeof(outarg))
-		goto err;
+		goto e_inval;

 	err =3D fuse_copy_one(cs, &outarg, sizeof(outarg));
 	if (err)
 		goto err;

-	err =3D -ENAMETOOLONG;
-	if (outarg.namelen > FUSE_NAME_MAX)
+	if (outarg.namelen > FUSE_NAME_MAX) {
+		err =3D -ENAMETOOLONG;
 		goto err;
+	}

-	err =3D -EINVAL;
 	if (size !=3D sizeof(outarg) + outarg.namelen + 1)
-		goto err;
+		goto e_inval;

 	name.name =3D buf;
 	name.len =3D outarg.namelen;
@@ -1554,8 +1559,11 @@ static int fuse_notify_delete(struct fuse_conn *fc,=
 unsigned int size,
 	kfree(buf);
 	return err;

+e_inval:
+	err =3D -EINVAL;
 err:
 	kfree(buf);
+finish_copy:
 	fuse_copy_finish(cs);
 	return err;
 }
=2D-
2.43.0


