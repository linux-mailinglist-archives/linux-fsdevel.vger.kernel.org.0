Return-Path: <linux-fsdevel+bounces-29658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4492997BDD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02ECC285EA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FED18C907;
	Wed, 18 Sep 2024 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5wfDs9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579DE18B464;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668769; cv=none; b=ZFF0QEjeVnaIO/l2kqdLkeVXmrtBpXHfbO0EpS0O8XCeTLXXlaCfxdiIEWdVh0iGG7gySQXk88KPiZ983pCgbMAEfldd9Q2xcmY4mUFqCC0XJktQZXqnELie3I4txGiiF/66nCv7DdwUR0DSlH9Y89NqIsk5FA+S1l4r23G/AYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668769; c=relaxed/simple;
	bh=CYL78L9ih/Kr5eLuAqMgq+8E+45km9xjtzZNPt4WYs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rMB+lpp7MhU/RZBOguioo7DmSPQSUViHcSjzqF9ub2oNuZ8BqD4L3XFfLG7w5s9FhpETwXAdDE1egiZeSnWCB/VGc2dAnoqIRSPHu+TISgeawccvjwDxMIZnVFg4eqM2vq+7E1Px+3v3gyLNRTKuDF8QrTBLfVEo9t85rWFjiQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5wfDs9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 382F1C4CED7;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668769;
	bh=CYL78L9ih/Kr5eLuAqMgq+8E+45km9xjtzZNPt4WYs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=W5wfDs9legPCf7O/PJbjKV7yQaeXHHsrQ7/szrdKXIgzgMpHxcZenTSVatf+Trgjf
	 69xxRlcFrQtrCpaLcl3D9/K7acaMh7GFgJtWYpzKVjw9F7kHhT3tZyf7fz19Zzlb+M
	 jF2x8eAHiEFzMya1CqVmJ8NqWR8z3ivKXJs0l/T8sOYJY/besq59ZyGheIDSMU7WSS
	 PDS7UlYCuMe77l3181HbJVcMq8bTTXHWexxAjsfgnDeRyBOFLhXwRpwxj0mvgfoTPZ
	 p1Qzv6U/pqR4iFZY+aA//hN0JS+K/MuaUGigu8XxN863fxfMpI/vO9MZ3rUqTQoyzI
	 F3vrTM5j+GOSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314B3CCD1AB;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 22:12:25 +0800
Subject: [PATCH v5.4-v4.19 6/6] vfs: support statx(..., NULL,
 AT_EMPTY_PATH, ...)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-statx-stable-linux-5-4-y-v1-6-8a771c9bbe5f@gmail.com>
References: <20240918-statx-stable-linux-5-4-y-v1-0-8a771c9bbe5f@gmail.com>
In-Reply-To: <20240918-statx-stable-linux-5-4-y-v1-0-8a771c9bbe5f@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>, 
 Mateusz Guzik <mjguzik@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3164;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=Mz70ynn0QmOv4iQYlvx/dmX1Pkma9wGWlUEA7jcK4og=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t/dGuOjI9aYmI1LQfgwrbw0dZPMapB67Fl5U
 Px5kKe2npWJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurf3QAKCRCwMePKe/7Z
 bh8DD/9HS5BdVsTPeo/HHJUotxCRxYTUhGJighDBkTNcGK0dO63iAVafsGuImCuoSdjKdvUC9rE
 3TRGLdB+VaxHyxnCcSfxDuXeIIS+CUBLcvI1oLAOOGgCNIN5r3gRUxLPnIeugyQ+awOZg3qHRko
 VJNHxjFtvW0AMI2Nj8XcEiC8b/vMFTiouia0Gx3K9hi9vDdgkVmRFKmtBsJDc1tQIw4I/QVXPTj
 y4hUXpHn6loOlcSBp1bOw40d+8kKWhsskqku3VqwIdMkV7J+QmjfhXaAXvRXWpncOcV7qAqP+cr
 FImQj89feRMFc+QGThtbz/VYqHgsxjXYIj1T6skMrfByzPVsgSC8B6JDl6HFAGe1p/zWEGBxY4X
 jf9ZG9Bv8JwBVylB1FxGklA+y71fXJ9tTpeCJMN6Y3/OTyYaytVNHmSBDNprppNrT+m8st8TQCk
 G6+rfxxkm0+Y2l0WenX+Z2mk1RxmVYmysNwEHvpLPhXbE0VGJXpjWqDbRhacKeyXzB5kBwYWNBk
 mdv2eqvr12fsi8tDXBgzFl3JxgSJrSxtHAykMiqon9Kee74M/7al1rWzt2oGQyM3Z7XXH31tDNH
 NBFp0zhz5heTqevgk4qLUifLEe4l+Mw/fK5GILEVdnp4Sst7608jqxzOLTAKHuWap8L/2Sn1udK
 jkaaUscsYWWbFGA==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

From: Mateusz Guzik <mjguzik@gmail.com>

commit 0ef625b upstream.

The newly used helper also checks for empty ("") paths.

NULL paths with any flag value other than AT_EMPTY_PATH go the usual
route and end up with -EFAULT to retain compatibility (Rust is abusing
calls of the sort to detect availability of statx).

This avoids path lookup code, lockref management, memory allocation and
in case of NULL path userspace memory access (which can be quite
expensive with SMAP on x86_64).

Benchmarked with statx(..., AT_EMPTY_PATH, ...) running on Sapphire
Rapids, with the "" path for the first two cases and NULL for the last
one.

Results in ops/s:
stock:     4231237
pre-check: 5944063 (+40%)
NULL path: 6601619 (+11%/+56%)

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Link: https://lore.kernel.org/r/20240625151807.620812-1-mjguzik@gmail.com
Tested-by: Xi Ruoyao <xry111@xry111.site>
[brauner: use path_mounted() and other tweaks]
Signed-off-by: Christian Brauner <brauner@kernel.org>

Cc: <stable@vger.kernel.org> # 4.19.x-5.4.x
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 fs/stat.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 1aaa5d847db8..111443789ced 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -590,13 +590,14 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 /**
  * sys_statx - System call to get enhanced stats
  * @dfd: Base directory to pathwalk from *or* fd to stat.
- * @filename: File to stat or "" with AT_EMPTY_PATH
+ * @filename: File to stat or either NULL or "" with AT_EMPTY_PATH
  * @flags: AT_* flags to control pathwalk.
  * @mask: Parts of statx struct actually required.
  * @buffer: Result buffer.
  *
  * Note that fstat() can be emulated by setting dfd to the fd of interest,
- * supplying "" as the filename and setting AT_EMPTY_PATH in the flags.
+ * supplying "" (or preferably NULL) as the filename and setting AT_EMPTY_PATH
+ * in the flags.
  */
 SYSCALL_DEFINE5(statx,
 		int, dfd, const char __user *, filename, unsigned, flags,
@@ -605,13 +606,29 @@ SYSCALL_DEFINE5(statx,
 {
 	struct kstat stat;
 	int error;
+	unsigned lflags;
 
 	if (mask & STATX__RESERVED)
 		return -EINVAL;
 	if ((flags & AT_STATX_SYNC_TYPE) == AT_STATX_SYNC_TYPE)
 		return -EINVAL;
 
-	error = vfs_statx(dfd, filename, flags, &stat, mask);
+	/*
+	 * Short-circuit handling of NULL and "" paths.
+	 *
+	 * For a NULL path we require and accept only the AT_EMPTY_PATH flag
+	 * (possibly |'d with AT_STATX flags).
+	 *
+	 * However, glibc on 32-bit architectures implements fstatat as statx
+	 * with the "" pathname and AT_NO_AUTOMOUNT | AT_EMPTY_PATH flags.
+	 * Supporting this results in the uglification below.
+	 */
+	lflags = flags & ~(AT_NO_AUTOMOUNT | AT_STATX_SYNC_TYPE);
+	if (lflags == AT_EMPTY_PATH && vfs_empty_path(dfd, filename))
+		error = vfs_statx_fd(dfd, &stat, mask,
+				    flags & ~(AT_NO_AUTOMOUNT | AT_EMPTY_PATH));
+	else
+		error = vfs_statx(dfd, filename, flags, &stat, mask);
 	if (error)
 		return error;
 

-- 
2.43.0



