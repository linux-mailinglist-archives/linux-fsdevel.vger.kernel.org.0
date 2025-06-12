Return-Path: <linux-fsdevel+bounces-51473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D16AD71DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6554417A12B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37A92571BD;
	Thu, 12 Jun 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tjetws9n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6080F25A2DE
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734755; cv=none; b=pQuAB6E/W2UaV7RwpWLsW8mo1OVjAG+KOmS0KXhrHAfX5VNkexOwZhOJ3V27ld6H9df133Cd2Zi7Yrrgiv75unb6Gyzj3EEeB3zlgKv8LxYtOyHC2TxU5bnD8R/0F/M7t00Lso1v9WLyc3cr0CIntncz33Nx2L9lHedOCw/wcHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734755; c=relaxed/simple;
	bh=Fk5w6rADt7PNlOxHrK2jKCbYeeVkcmLmcuphGSLSTCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0rWSTJRyy/WqkT+rj806E7TumrvUZehsXAHYzYuj4aXnncX4Fc0KAkQnhmOuENblcNj/vIIdL1FGsUQx2Od7hjYFk/AEoLNw/B4l0s01IrJjAiBtS45O1nrvaz9TBq0fb0v1WrqvpEbilwzr0xXs5kfNA3a/hQYJnwcFopwFqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tjetws9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A68C4CEEB;
	Thu, 12 Jun 2025 13:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734755;
	bh=Fk5w6rADt7PNlOxHrK2jKCbYeeVkcmLmcuphGSLSTCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tjetws9neoYFN2uWSTqX0qFyZhxoRjSbqBYs0rQrbX5yWJyzERTqXw+/695oDHMsi
	 LfCHCMShzElp2fcRUyLStESNjfy7QuHpSZA60okmCeBKm3/4eCLuuX4mnttAl4yhFX
	 ciHccx6pXnEWCjTltNdE74cpJg5M+KtoY3FqpZ9t1E+HCflYlFZFWrlU/6tg8/90Ii
	 Bq876xZ4ssTlIK+4SHnoTr2rgQiSHBUDyLEOclOKImJcomAb5R2zLJEBHqrzad7C3f
	 NgyxBVEd7sTRtOUmeL9AGB/pTtHIx6vjpdN6aSQQdE/ltpBgFsSFQx8JTx1SM63xP8
	 ELATPQxT0A7SQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:26 +0200
Subject: [PATCH 12/24] coredump: move core_pipe_count to global variable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-12-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Fk5w6rADt7PNlOxHrK2jKCbYeeVkcmLmcuphGSLSTCE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXVX2ypQI+EwP08z6UxB/9kVrX1nAmNXc++yTK+uq
 pkew3ino5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKfrzL8s3T4uPqhR3xq2OP7
 /ef8jBwn3ZjI3zN1+599WRIH/q79/5ThN4vn5KS1/jx5nwRmPQ/nv7xe78PtM0IrbGbuWbElh4n
 1LzsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The pipe coredump counter is a static local variable instead of a global
variable like all of the rest. Move it to a global variable so it's all
consistent.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 4afaf792a12e..c863e053b1f8 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -82,6 +82,7 @@ static unsigned int core_sort_vma;
 static char core_pattern[CORENAME_MAX_SIZE] = "core";
 static int core_name_size = CORENAME_MAX_SIZE;
 unsigned int core_file_note_size_limit = CORE_FILE_NOTE_SIZE_DEFAULT;
+static atomic_t core_pipe_count = ATOMIC_INIT(0);
 
 enum coredump_type_t {
 	COREDUMP_FILE		= 1,
@@ -981,7 +982,6 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	size_t *argv = NULL;
 	int argc = 0;
 	bool core_dumped = false;
-	static atomic_t core_dump_count = ATOMIC_INIT(0);
 	struct coredump_params cprm = {
 		.siginfo = siginfo,
 		.limit = rlimit(RLIMIT_CORE),
@@ -1057,7 +1057,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 		}
 		cprm.limit = RLIM_INFINITY;
 
-		cn.core_pipe_limit = atomic_inc_return(&core_dump_count);
+		cn.core_pipe_limit = atomic_inc_return(&core_pipe_count);
 		if (core_pipe_limit && (core_pipe_limit < cn.core_pipe_limit)) {
 			coredump_report_failure("over core_pipe_limit, skipping core dump");
 			goto close_fail;
@@ -1171,7 +1171,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 		filp_close(cprm.file, NULL);
 	if (cn.core_pipe_limit) {
 		VFS_WARN_ON_ONCE(cn.core_type != COREDUMP_PIPE);
-		atomic_dec(&core_dump_count);
+		atomic_dec(&core_pipe_count);
 	}
 fail_unlock:
 	kfree(argv);

-- 
2.47.2


