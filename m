Return-Path: <linux-fsdevel+bounces-31078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D11A9919DB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 21:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC661C2157A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 19:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B97158D96;
	Sat,  5 Oct 2024 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmeLagP5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11805231C90
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728155848; cv=none; b=dV+GlJHdRQP91LVWh3Q1/LkjZzcmLnyvwfvfhJrKcwWDhJg3dkKFOnHGPl0WHmE4bHClCL9y4GucGJTo/JqCyhL8VPAEswMn0Uqs43xGkwo8zx0xI7WgqRFNFSAmMVyokD7+DYKtILg2by9bLyNuYnqJSaVO1qbCAIDzRm2hu5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728155848; c=relaxed/simple;
	bh=hiIQ4xmmKL6fwBjndiI5i6u8tN17hB9vgokNY+JavC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L8A+NBH3CjdS2kQ2NdYuTgUZOdEp1yqOYzjaTWTE/g9SF85+YeFWfiqcbSSUBM+MimBLYtYj1z7G44WLTu8ZFKV9ucoLbOLt73bl42XyDxbPdudxn3JyDWDqQwXx0ecGuB41oBVgAYsT1xap9vwni4KzVQY18NfZGjZph8eOzvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmeLagP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93548C4CECC;
	Sat,  5 Oct 2024 19:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728155847;
	bh=hiIQ4xmmKL6fwBjndiI5i6u8tN17hB9vgokNY+JavC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kmeLagP56LFM6e9SYvwvu5G46zsmCyToG0Ef7c1zhwDo7/w1KXkLTBb1osdAPVo5n
	 AG//YP6cZwPaCzBWeMAdsBeB1AgwSjVaaaQZj3+f6zm31MYURb06raE+gsgUDSGsWR
	 I1Ar+aYcWak18TXlHEG5j4DW9KdB5RgklIOUNowFFDZWJIKA5pItBsE1J1x5OOYdTy
	 W4h/hKq2VB0v3p71YEwKJh6iSGsp/Ov5hdxc8I7CR//hjpSrq+gZuGQJ+OIMWjXwnA
	 5wChrLNriV7k0GKQDNPct0D4tCPfWQRLI/C6HB71Amk8fMlOWrpVhapCuPJeYlpjDE
	 /c7s7JmwqikWw==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 05 Oct 2024 21:16:45 +0200
Subject: [PATCH RFC 2/4] types: add rcuref_long_t
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-brauner-file-rcuref-v1-2-725d5e713c86@kernel.org>
References: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
In-Reply-To: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
 Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=869; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hiIQ4xmmKL6fwBjndiI5i6u8tN17hB9vgokNY+JavC8=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGcBkMKjoN1zKoAJ776MromzcjRaLGrtbl8DhEvi6soHt46v7
 4h1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmcBkMIACgkQkcYbwGV43KIwWwD/QJ4c
 uCE9FVTIqeFUsS1W7hS8CsPvrMghHwj8twO5rWQA/3jSyMdY+lmHvbqqfPQEQMCFiQ3oc2nHYWb
 PuwjZwwEC
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a variant of rcuref that operates on atomic_long_t instead of
atomic_t so it can be used for data structures that require
atomic_long_t.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/types.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/types.h b/include/linux/types.h
index 2bc8766ba20cab014a380f02e5644bd0d772ec67..b10bf351f3e4d1f1c1ca16248199470306de4aa0 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -190,6 +190,16 @@ typedef struct {
 
 #define RCUREF_INIT(i)	{ .refcnt = ATOMIC_INIT(i - 1) }
 
+typedef struct {
+#ifdef CONFIG_64BIT
+	atomic64_t refcnt;
+#else
+	atomic_t refcnt;
+#endif
+} rcuref_long_t;
+
+#define RCUREF_LONG_INIT(i)	{ .refcnt = ATOMIC_LONG_INIT(i - 1) }
+
 struct list_head {
 	struct list_head *next, *prev;
 };

-- 
2.45.2


