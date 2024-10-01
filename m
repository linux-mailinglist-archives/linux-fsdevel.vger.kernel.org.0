Return-Path: <linux-fsdevel+bounces-30587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A7F98C8CD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4F61F216CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9051CEEBD;
	Tue,  1 Oct 2024 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qxl1dc4f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CAF2207A;
	Tue,  1 Oct 2024 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823749; cv=none; b=ko1LUt19oCi4OHBENEKMD5My0fIbEgsrgcrJzcVlhf1b0PLhXPcZYq9vf332eem/3L2hQoZ5vUJsMsYyL0drWThkGIU9jfNkkEzV4rAnDs6qw61Mr0tjDjqReJm1LJ+XZCqFD49AJe7EjQYXP5/jSWwavZ9qRJDf+I8kuAh3U+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823749; c=relaxed/simple;
	bh=DSXKD8gW4ItG/UhRbAzYa8PqcmIvUc0qAR0WYsCLZoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m9IGqI3DqlqkN7fjNsaYXg1eY0NgsinaWspMsV9Y4I5NpRHW8V2UHVKarv18n9THpeA1EsQpLDcCTX9NrQUkSSfJu8tTU+lWs8nJhms5svnEJWBtwPoxijTtrqtbWgWbJybsmv3kFkf8iZqkJ4/VDE5MQhOOu1gd0No1j/Iqtzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qxl1dc4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C518C4CED8;
	Tue,  1 Oct 2024 23:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823748;
	bh=DSXKD8gW4ItG/UhRbAzYa8PqcmIvUc0qAR0WYsCLZoQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qxl1dc4f4chve9ceCv7x7HrnMjbe3+bj0kBlmSGkywXHx/YFH1F4fWYSGOTzq2Jj1
	 7YPuEbpy1zVUPFmIpGZVuVMCQDSIrz1lvAGH9OG9LpP+52gsCmSSb6WZZ+VDR13xib
	 meOJhANTA6AH6Jib9RiKmujGbrD+wB2KbCrqYM95jtiXFIqIZ7ajdoJMOBhvDeWmi8
	 6QvuJHcC8UWZ0WuDlbzm3tIcDOqtW9xPLfx0u6xUNewhfaaQxsY2wOhvkFUBm3M09u
	 jxOnI/RjxxiuXetU23l6bX0Oznw9TEWB+Vi5pT5Gs1Fuf1TmkmHTrJK+n/7Xg6wA01
	 SFND3170B8plQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:58:53 +0100
Subject: [PATCH v13 14/40] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-14-222b78d87eee@kernel.org>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
In-Reply-To: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Ross Burton <ross.burton@arm.com>, David Spickett <david.spickett@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1576; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DSXKD8gW4ItG/UhRbAzYa8PqcmIvUc0qAR0WYsCLZoQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7PxDti5AFEq17Xq2PV0KS2RA+1FHmja+AU6Q78
 PJq1JeSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+zwAKCRAk1otyXVSH0Lg5B/
 0dbOlRzFreX+wW/DcvXTnsPqnbTvc6TKCMr3ypMT24HSTNXmTk1oXZvj6SkxqEIPW7OLRjM6JqCX2d
 Gxv0JxWUhgRiQNJtNR/8GozrVMllWWEiUMqPEdfQHU5QQojC4rvm9bEOwnUEFmaNkz4KJ3mYntbgoR
 SENEnmTh4wgFW1GXN6zmAkZYEiQE0qKXj6csZpSQxvgcyk5TMKyWJOSZaEBZpUP8DXYb5ITQk93O02
 ChdK2ZeGYiCCMA/bHxEC47tZJ9gU9cEP/+1Ia7sC2btjq5wuYcvMaGTexhSA+HW+Du+5Eat7SUuVNi
 rzCuOvArXgCjMKyOF/1L92CtCNX6J2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Use VM_HIGH_ARCH_5 for guarded control stack pages.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/filesystems/proc.rst |  2 +-
 include/linux/mm.h                 | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index e834779d9611..6a882c57a7e7 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -579,7 +579,7 @@ encoded manner. The codes are the following:
     mt    arm64 MTE allocation tags are enabled
     um    userfaultfd missing tracking
     uw    userfaultfd wr-protect tracking
-    ss    shadow stack page
+    ss    shadow/guarded control stack page
     sl    sealed
     ==    =======================================
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 56654306a832..8852c39c7695 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -367,7 +367,17 @@ extern unsigned int kobjsize(const void *objp);
  * for more details on the guard size.
  */
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
-#else
+#endif
+
+#if defined(CONFIG_ARM64_GCS)
+/*
+ * arm64's Guarded Control Stack implements similar functionality and
+ * has similar constraints to shadow stacks.
+ */
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_6
+#endif
+
+#ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
 #endif
 

-- 
2.39.2


