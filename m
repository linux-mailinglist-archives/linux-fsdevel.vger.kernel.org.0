Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A44B4181B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Sep 2021 13:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244550AbhIYLpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Sep 2021 07:45:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:59933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232363AbhIYLpJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Sep 2021 07:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632570210;
        bh=/zVNgQmryVA4k3e45CiCaw6IxcHSDeffj98fMqgaE6A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=bAWI5mFiHaXY8FMRckvJtbeD/t4hKQBNsSI0ng2+mv5DITKHzOGobD1F10x5iEoj6
         J5fuBM8VQbaNOX9ftNwPKBQFXt7IJ0DcfaGSjKb/XxVttiY2nS1614Lk8L+JXL8lHt
         xpQ/uaUWmGqxBzzP2fhMXRx5Bqi4k90Rvj4FUm9g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N79yG-1mvqiD3jQK-017SQE; Sat, 25 Sep 2021 13:43:30 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] writeback: prefer struct_size over open coded arithmetic
Date:   Sat, 25 Sep 2021 13:43:08 +0200
Message-Id: <20210925114308.11455-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UgePny2MsPa0UaX6WMhndso+fvJ4dp1sHEVaBNCXxtmvCRKpZMJ
 /8NJZk16YV7cFI3tVYkMOyGRBLF5Se1TCudVnP6WHW/j3LyMxDY3mUFdGNEa1YemeUTfsg5
 JfIauXX6YbI2A3xKkIx68RV5IUvvs5YtFet0jQEoNzLmNNlf1lzg69qBu18WQWJ3Xz4YOBS
 ITalQTrRowDwolyNuBn3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yBHF46CKjB8=:bVIKrlHJ3G7BlOYhcfFjqq
 pKEP1pkMHiXCUjYqgc2UTGighUmZfJ31xCho1Ntft6+7Xm03Ktbj4tjmWj2YqaBvJNQbERgHm
 Fw++sfk9D5CzTsChvDj5lmOo0EptkYQSKNU6FYnosetszltdgWWb//aBmph1FxfHuYn8VkgFf
 XBE9M5y6VO8+Z+5ulQl5J01NjIbjPEMYzr72e7Bk0g6mlOJB970qSdq0r3i7rIKjSRQu1gtdK
 sgdqcIzf5b2HWH098x++F2y9tABS9KUl8998vNrs6PVe9lMuxT5B6k1DGVCKc3nFU9xDYi8XE
 fKgocq32w0nSwieeAU9RWdNJNLoXQyLGXgb1346lNO5ZCJMXzkkHeMxAvvR765aGBnutgDInp
 36OoiPTACd5kFw5IqUmixJwnrxUkaoclYLpHqo7s2vyw3PMF5x3rUi7rf9AhGSTjif73ja3Bk
 sTH/kCBA3u/fz6pEsi3Mcy3TZZQPj2vr9Vxt6FGGyyxngi+ikef2i5lkrID+54WZWodhVUVr+
 xYLRqR/2KCscSSF8vxP/3FgDP+fV+Aof5DRzJiI+FiPL/ei3QKjjJNyrQnmUHDaVZbMCHRra4
 /VGMX5lFm17+NUuSD7K2zai3ZllP2hKunw4Kh13QtmxQZp/3WLuJQ36boyMF7ycTArw0PQljI
 SZpUr4q3W//fSrj17UmLT695BXcpWMscQGzGu9iWem86rmLIxx+7z+wpro751cQyLfn50ZmVF
 1FNlePLmdkBCAqO3+xVZClTt4v5Y+t5Rr995obXKMw6uHd0KeOBOVBFki1cTgEjlnmvff5x/6
 X6RAN8k7dTczYaMwwGVV9+Fsa2NX/EHo5hRl5tAxg4I8YtJdZAWnDz9VWrl/l1meZlXdCGnOH
 n2JbT3vnGiaP4syVY1mB76TzXWCOu2gPhj0ubranoYidvBCe34h0yoN58UVOnvG2GpRGrG+rg
 0snraO+ILTkG8b7sOAxVoLgHHwaHu49ih1ULoYwiTiZVoXOBRXRRfXvQfv8Z6l8OKR/f4TBxd
 5j2VojiPHUAa8ANEXk3PBFlA6Q8SccA6M+X8+XooH8skVSD8mRD8w3BxOpJzgKIpuIibxD4io
 3MjIRILnmlCfOA=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

In this case these are not actually dynamic sizes: all the operands
involved in the calculation are constant values. However it is better to
refactor them anyway, just to keep the open-coded math idiom out of
code.

So, use the struct_size() helper to do the arithmetic instead of the
argument "size + count * size" in the kzalloc() functions.

This code was detected with the help of Coccinelle and audited and fixed
manually.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
Changelog v1 -> v2
- Rebase against v5.15-rc2
- Refactor another instance in the same file (Gustavo A. R. Silva).
- Update the commit changelog to inform that this code was detected
  using a Coccinelle script (Gustavo A. R. Silva).

 fs/fs-writeback.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 81ec192ce067..5eb0ada7468c 100644
=2D-- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -566,7 +566,7 @@ static void inode_switch_wbs(struct inode *inode, int =
new_wb_id)
 	if (atomic_read(&isw_nr_in_flight) > WB_FRN_MAX_IN_FLIGHT)
 		return;

-	isw =3D kzalloc(sizeof(*isw) + 2 * sizeof(struct inode *), GFP_ATOMIC);
+	isw =3D kzalloc(struct_size(isw, inodes, 2), GFP_ATOMIC);
 	if (!isw)
 		return;

@@ -624,8 +624,8 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 	int nr;
 	bool restart =3D false;

-	isw =3D kzalloc(sizeof(*isw) + WB_MAX_INODES_PER_ISW *
-		      sizeof(struct inode *), GFP_KERNEL);
+	isw =3D kzalloc(struct_size(isw, inodes, WB_MAX_INODES_PER_ISW),
+		      GFP_KERNEL);
 	if (!isw)
 		return restart;

=2D-
2.25.1

