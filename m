Return-Path: <linux-fsdevel+bounces-29649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0767C97BDC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C472628502B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A8D18C919;
	Wed, 18 Sep 2024 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr0HIoFs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A4518B480;
	Wed, 18 Sep 2024 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668651; cv=none; b=dPio8DTvi+zpsDFndn1TGMfHksq2nRHska4K4RvVP4RFy35yf2+Z7EtVaeDE/esMdceQ+NX3bPss33odZHVbvRTgO3BLszH+LN7Jjs6Uf6szaWeVnnmZCmArDP5Ez9c8nCukb1EF4PDiESXv8gK54v/Ae6a2KKW6jNpkb9fmlfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668651; c=relaxed/simple;
	bh=viNC/wQCouVDr26WK+RdCH9qzhVRbfqkoP/FkrpBbLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yaf30L/llWwiftDz+yYcH8NOna8jVsKVIQSXkAgEH5uMdAccL6MQgHPuDCJqPGZmft6kr1a2h9tVkNrn3SIfcQPker9Lt8VJqSAhCN3uSDHv2SSRGN14LREBqQDjdnAhO25LME/9NJL4FUIDuq2iICdvUGZGmO9a/dOAO5oyZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sr0HIoFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68E3FC4CECE;
	Wed, 18 Sep 2024 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668651;
	bh=viNC/wQCouVDr26WK+RdCH9qzhVRbfqkoP/FkrpBbLE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sr0HIoFsyptK3l4S0MX+9D61RyI0M5DDmCDZqwKIFhhcdV7ME4kUVMkH92S68lgeD
	 Du67BqrRsPGnSSFikiYOhGhONr9yZYvT+rdR9CpZyN16QgtBNg6+kRd999M3icW8dG
	 rrz6tNaXBtc6D4qFxnabPfbMIfPET/sYzd1vwM4x7K8/wJbJf6MyEBJQS03GZgwV75
	 sCfZxeZiUIyu+yQMWMcg/9pPmwKleGY1f0bGsh5oml1KuLACFR1U6l9HaP5kj3Gu/i
	 VK0G2R9+xPIqT2CzHFqqUQUsjZElBx74mdaG3DgrpU+o2A2UFVgAikkUKnhvlvNcT/
	 IpmbWXknl+4Kw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56100CCD1AF;
	Wed, 18 Sep 2024 14:10:51 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 22:10:37 +0800
Subject: [PATCH v5.15-v5.10 1/4] vfs: mostly undo glibc turning 'fstat()'
 into 'fstatat(AT_EMPTY_PATH)'
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-statx-stable-linux-5-15-y-v1-1-5afb4401ddbe@gmail.com>
References: <20240918-statx-stable-linux-5-15-y-v1-0-5afb4401ddbe@gmail.com>
In-Reply-To: <20240918-statx-stable-linux-5-15-y-v1-0-5afb4401ddbe@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Mateusz Guzik <mjguzik@gmail.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2834;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=shkXBk+gnzTIPbC7R2tboulSE67SGBTGhMLzTghvzw8=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t9oZdUD+fMtZyQknzM2S2xZgTNBVpkCHtZ+Q
 fSp0U4g5NOJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurfaAAKCRCwMePKe/7Z
 bhyZD/9ArmkkoE+BhMIr5PdZk1Or/Jt3JiCI4dy/eyIMnFtlx1f2V7HTvzahJ8iQ/Lg/Twc8Mdp
 80zqxSJgmUgfStce539KCLS7CTNKfdSfZ/eJCxwbA1l+Pe04MXt/LdhDxciqRp+yksv/PSMsgoP
 lf2VF2XOHjSinhIdyx5vd7FyLsHYSufgxV2S5+g3WLScx1mGWiqzR+gfzFAA+dDrkw/DtEYYzGQ
 PwkyStOG+S3GLbHxOxiumeAYyM05jwLnA7EFTInEPlfUTrjjL3aA2ehbBE/yeqtRaiuh8X86vCT
 zbOSJ745nS4LAiDF68uMu2VU1K/gn0scxmV7ON7qnzAPmomhsEaPictBlCyHpfjFILbITHlZTvb
 Rxvgqys781+l2J8T+7e6P1CineXHfYQAkIJq0atq+MVlk7qvA5edeyoucyc0y4cRIQBBVrLOtH6
 sJZq0A+k4jwHRy0+H889eDbDiUT5bm35W2jdoJ2PVF/z6gPEVngnUfx7avzPXJEXR0aZL8KQ5Qd
 PSx0PpinuE99O4QAkeb10TMXNFz5mkexEiRgiR0r5eZ5+ChlBB5fdZZ9muxq4iT2vojUXr2IGn+
 QJeNclB7Jcxh5BBxyXcRHG/0mRHl93Rdt68p1yZmSi9x3LskINSOSYSGEPhAEU2rPKH5UEbmBv/
 GDlMb2VRDdh01ag==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 9013c51 upstream.

Mateusz reports that glibc turns 'fstat()' calls into 'fstatat()', and
that seems to have been going on for quite a long time due to glibc
having tried to simplify its stat logic into just one point.

This turns out to cause completely unnecessary overhead, where we then
go off and allocate the kernel side pathname, and actually look up the
empty path.  Sure, our path lookup is quite optimized, but it still
causes a fair bit of allocation overhead and a couple of completely
unnecessary rounds of lockref accesses etc.

This is all hopefully getting fixed in user space, and there is a patch
floating around for just having glibc use the native fstat() system
call.  But even with the current situation we can at least improve on
things by catching the situation and short-circuiting it.

Note that this is still measurably slower than just a plain 'fstat()',
since just checking that the filename is actually empty is somewhat
expensive due to inevitable user space access overhead from the kernel
(ie verifying pointers, and SMAP on x86).  But it's still quite a bit
faster than actually looking up the path for real.

To quote numers from Mateusz:
 "Sapphire Rapids, will-it-scale, ops/s

  stock fstat	5088199
  patched fstat	7625244	(+49%)
  real fstat	8540383	(+67% / +12%)"

where that 'stock fstat' is the glibc translation of fstat into
fstatat() with an empty path, the 'patched fstat' is with this short
circuiting of the path lookup, and the 'real fstat' is the actual native
fstat() system call with none of this overhead.

Link: https://lore.kernel.org/lkml/20230903204858.lv7i3kqvw6eamhgz@f/
Reported-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Cc: <stable@vger.kernel.org> # 5.10.x-5.15.x
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 fs/stat.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/stat.c b/fs/stat.c
index 246d138ec066..9669f3268286 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -240,6 +240,22 @@ static int vfs_statx(int dfd, const char __user *filename, int flags,
 int vfs_fstatat(int dfd, const char __user *filename,
 			      struct kstat *stat, int flags)
 {
+	/*
+	 * Work around glibc turning fstat() into fstatat(AT_EMPTY_PATH)
+	 *
+	 * If AT_EMPTY_PATH is set, we expect the common case to be that
+	 * empty path, and avoid doing all the extra pathname work.
+	 */
+	if (dfd >= 0 && flags == AT_EMPTY_PATH) {
+		char c;
+
+		ret = get_user(c, filename);
+		if (unlikely(ret))
+			return ret;
+
+		if (likely(!c))
+			return vfs_fstat(dfd, stat);
+	}
 	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
 			 stat, STATX_BASIC_STATS);
 }

-- 
2.43.0



