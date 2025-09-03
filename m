Return-Path: <linux-fsdevel+bounces-60165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64C6B42511
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 17:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E70165A33
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72149238178;
	Wed,  3 Sep 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7BVS+mw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE09232368;
	Wed,  3 Sep 2025 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913017; cv=none; b=m1BkGViHBtzpRusVCBLxU4mDJO05lH3DiquHo2ExJEOnyKUNkj/aPfnHwlKoxRkAVu6A0rudS9xaXD3XnwVtzGq844gztJlCE051y2ynw3DnZmNImKC+1j35RWDDmXVJzk7gmgYa7VRNLrMeXk837vbPjvS0AkNZ4WBVhbvYJ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913017; c=relaxed/simple;
	bh=sR/g2uDkVabuXgdRBG8EWSqLFCTiQUXeDjTcBr0yBpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rsGv60itLwE04uGvx4K9qjgM7nqcVVD/9c1Yasnn2AJ2svTkIxSrcapKMlQw5hqnzaekUO3PqfNphG72opV4kyOm9Cwh4TyHnZxR1/exA/w7VOdu0jpn8eiVKvMRmgejdv8tUxhRkY5mnK4C3r4/RxHMBX8LOwXkNd4AVktXSUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7BVS+mw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1497C4CEE7;
	Wed,  3 Sep 2025 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756913017;
	bh=sR/g2uDkVabuXgdRBG8EWSqLFCTiQUXeDjTcBr0yBpA=;
	h=From:Date:Subject:To:Cc:From;
	b=W7BVS+mwEX6WWNSbqIWIpjvSN6k1VE8obi8En1DvtWMG7kCFj7klWt5Hx6ZbhbT/Y
	 1o1F3LWjqsvl4782x9nvzshf0UvSpj3VVStaYrP7NVM8PxXHVstIa6iwNHr8RLiGqO
	 7rFN6VjfCJiIgmPxKNFbqLRl3TLuQR2sTc1Iqn7mWRMbvS/JUaxgCQlEfNb2+O9pMu
	 6LffkACBuGjp3V2lloL01UA6KvDt+8nV69Z9L6Tj/7qFtpygyhbZOxNJZrnEQrR7tU
	 hpeKwFUvYlPmMUMAmaK6D4KY5JgMsHdaRP0IA0Adct8NggqWBmfRP6XcS0pik/CuEz
	 R/MsCUQd0Ai4w==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 03 Sep 2025 11:23:33 -0400
Subject: [PATCH] filelock: add FL_RECLAIM to show_fl_flags() macro
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-filelock-v1-1-f2926902962d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHRduGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwNj3bTMnNSc/ORs3aQkQ4OUZNNkM3MjCyWg8oKi1LTMCrBR0bG1tQC
 z1y4oWgAAAA==
X-Change-ID: 20250903-filelock-bb10dc5c6728
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sR/g2uDkVabuXgdRBG8EWSqLFCTiQUXeDjTcBr0yBpA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBouF14DNxlwizHO74ZdRrzGJYeKMGF+eLzZp0L1
 Vm5uQ+G4R2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaLhdeAAKCRAADmhBGVaC
 Fcr+D/0XTD+TSlfPUE/T64Ej6u/pNbs3FfF0rT6zX4cASX29oVG0d4jja4zPRIYKZCCMnztPYoO
 hixLmZYGv4q5LlwkRG1WqWRWlmIsbdPO171HAP8M/OEVweXQBhDv4VhC9KQVS2xAB5GgV2Xruls
 HFxRsDcT3g12jkPh6IjzMpu2t6fb/VrU2ipyxeAOl/zzy0jgzJ3cyXAAdY6NA4zcFdXNsfV4Mp3
 tTwPAPtWTN9lCClb/mt3DCJuVV12WIDLXUuoGtmJKBfKrBUnUkeSsuMkD7zusjZtVEGpnHlkLAx
 CBcl0gR73f/aiO+ZyzGs+vDH3bj4KnGsV+SoyE27VYjHgnK+zCz+2+cPPMEl+4ylKai8z2Mhga5
 FJT6OmcP6SScguJUGEN0c/CxR0Mkw5Jpb+vZ33L4v+HY5ywtsRwjHNX0JjJi7ama2jIwnf5yMwh
 GX+rJxlCENZshpkCOSfnAT+Su/nF3XFcpsmpu1UksuiY/xPvBDqKIEFxni8YD0aQr+/U8bNvdci
 PS6QUDE0G+J6IQ7lJHRFoYWOV+6Qq2iPSw0saaUcnw6YKu/6EIobGSxak9DFhtmE7y5zO2Ub1lq
 pWe83GeAZmvhSY5KuI371Ht5FACUdxX3tNW/NzjQ5nNHCZ15orLQ5K4pNBHqh+MxGseRp4/L2dA
 xKfKRToULbB4x/w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Show the FL_RECLAIM flag symbolically in tracepoints.

Fixes: bb0a55bb7148 ("nfs: don't allow reexport reclaims")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Just a nit I noticed while working on directory delegations.
---
 include/trace/events/filelock.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index b8d1e00a7982c9ef966f414ee279ed91663bf550..2dfeb158e848a528b7d9c0d5f8872c5060df1bf6 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -27,7 +27,8 @@
 		{ FL_SLEEP,		"FL_SLEEP" },			\
 		{ FL_DOWNGRADE_PENDING,	"FL_DOWNGRADE_PENDING" },	\
 		{ FL_UNLOCK_PENDING,	"FL_UNLOCK_PENDING" },		\
-		{ FL_OFDLCK,		"FL_OFDLCK" })
+		{ FL_OFDLCK,		"FL_OFDLCK" },			\
+		{ FL_RECLAIM,		"FL_RECLAIM"})
 
 #define show_fl_type(val)				\
 	__print_symbolic(val,				\

---
base-commit: e6b9dce0aeeb91dfc0974ab87f02454e24566182
change-id: 20250903-filelock-bb10dc5c6728

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


