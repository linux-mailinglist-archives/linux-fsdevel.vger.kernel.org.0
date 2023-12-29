Return-Path: <linux-fsdevel+bounces-7015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDD081FE30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 09:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95ABC282406
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237FC79CD;
	Fri, 29 Dec 2023 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Z/oPI3az"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3189A7487;
	Fri, 29 Dec 2023 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703838996; x=1704443796; i=markus.elfring@web.de;
	bh=EoV9yLqj2IKlvd3kf0dcQWQx2nrQ9IxzgPGR8PzE6gk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Z/oPI3azC3HJv1dDkXwpJ6y+y1ZXORefODhZkdQmPC/o8G6JvkwCIbdL8N/idiZd
	 vPifSJqtlGPbdMVa99vx4Qp3z9mizut3WV5LHa/j5VY2MmGLuo51ZlyC4ILmSMAF7
	 3kfLzPW6U9MnoTArmFknLUNqcw0qO4OXKjwWNwR9vatw1zezfEM4ygORwEjMwrRsZ
	 391ksx4EQ8oON3K6lGn67mk2ToZWnYAOOCEGx7FxDiJnuD3cLhtK9G35IP7G1v/ji
	 rBo9Eh/bv2CYurwtgPuvLEXLtzirOEG6pzc1k0XKUDCufEAYek352ehdRdNM8RUSb
	 S29s1xeQotkrSXXU1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQxs3-1rdqAF30lD-00Ntio; Fri, 29
 Dec 2023 09:36:36 +0100
Message-ID: <02fe18da-55f5-47c5-a297-58411edbb78b@web.de>
Date: Fri, 29 Dec 2023 09:36:36 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] virtiofs: Improve three size determinations
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
X-Provags-ID: V03:K1:wr5P/Bg9PxNgJIoMgfNzDUkyUJzJDLFq8qyCn+DoP/ZmDJNaPgr
 LGvRriMUINRI8yNKGzgo2Se4snoKcqsP7uNsGz4lj4lMTbaFYczcfgR6Gmik32RTFSMDMUO
 8AHm242rwxLVhEOFcDbxak31RD5rVwoLqTEl/3Y15Xv8uA6c2gc4dJwfa+aCgUiYZ7hNbwE
 x7po+0SYR+dNYEW1aCClQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PTLJh/rv7EE=;XPTFsDCeIhprv+w64gnTHhnRgWk
 Vorh+H7NvdWvL4QBjJVp2rHmHHdJiuPWrXarQvs8VPavUI9t/7tYlKtmadBTi4dAx4psLExdX
 b8u1qaS5ElAQEhcopVwP6xcZenBurB9v4ah8MTlcgszJdYrhXHJmow9sRIqj/s1NBt3xXNF/m
 YzU4b4+c6OY9zOWQ0G4QFoFNGvpkunP7Zrk9OVhiFkiytECWtQBCuNAKsdu0lkp+l+QOAppQv
 g3CM+dgPiOJnyV+eXU2Aj3f7aTLs53zQDRvJYZNt7zMFCkb+jDDYG3NVs7GGGSgtMEMnkS6qe
 WXrKY/HhNWo3l1KZY3io/GWZenYqPEcVbuhn55SYWO4vKN/7FiFii35tboFLjNuXOUxGoHtsi
 uKiGXmnTh3bvtGYzt/K8fCyKgdTpcLaW7SHUtp93zYaZU0Z68CT47qvzzC8LtFPUaOv+Z4zqK
 8H9nvYxgOy5E1M1lDoStYnGp62lsaqa5S47kI7ji/4u5GZXrI7hQso3Ep3eE/+gA2HKOgmTm9
 CvmdLcljIWacnsop5wlsikgM96DRT8iJpZZDXrVPOX/UYf+cwbICOhvluUdzcSVPgmRx4Dp/D
 40RZXj/YB5mvM/dBfGFJbCPpM7e1bpjSyy80gjXInThK/xfNfy5IiznSKK0i/JPQOHLRSR3zl
 I8oSRaIAFOgLkHAEOSSNc+uRfoaNCwVDGUrmHXU486nEn3lqtd9jx738ohfZXHIcau+PHvaHd
 xFTFy09jRfM4DCGrz+BpfORArkG2oulfkMQW/1Mgca1K2Hyeo3VHCkCQTbUmIHxU58q3V85Ib
 JtI0urFD/R5/cPkpAnDAAWuNsq6aGAm0f32k6HkdzbPkuo8QlXrsfpkTjwGgTp1feAvDIKafF
 4wOVbVf+Q6ASPb64KTP9Cd/FmjFoaL4LZceZFN5/8Z3oTZxBQ1PkxchUQDhF7nZaHgF51KKAN
 PBQxwXmesP7aa59JyaMCTLZbAzE=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 29 Dec 2023 08:42:04 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator =E2=80=9Csizeof=E2=80=9D to make the cor=
responding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/fuse/virtio_fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 5f1be1da92ce..2f8ba9254c1e 100644
=2D-- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1435,11 +1435,11 @@ static int virtio_fs_get_tree(struct fs_context *f=
sc)
 		goto out_err;

 	err =3D -ENOMEM;
-	fc =3D kzalloc(sizeof(struct fuse_conn), GFP_KERNEL);
+	fc =3D kzalloc(sizeof(*fc), GFP_KERNEL);
 	if (!fc)
 		goto out_err;

-	fm =3D kzalloc(sizeof(struct fuse_mount), GFP_KERNEL);
+	fm =3D kzalloc(sizeof(*fm), GFP_KERNEL);
 	if (!fm)
 		goto out_err;

@@ -1495,7 +1495,7 @@ static int virtio_fs_init_fs_context(struct fs_conte=
xt *fsc)
 	if (fsc->purpose =3D=3D FS_CONTEXT_FOR_SUBMOUNT)
 		return fuse_init_fs_context_submount(fsc);

-	ctx =3D kzalloc(sizeof(struct fuse_fs_context), GFP_KERNEL);
+	ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 	fsc->fs_private =3D ctx;
=2D-
2.43.0


