Return-Path: <linux-fsdevel+bounces-73510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B42FD1B1A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 20:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0707F30318E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6418C3491C7;
	Tue, 13 Jan 2026 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YJgWeCx5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309833126C2
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333693; cv=none; b=em+DVF5kN1k1t2tiGeHsJGmpZeU7GSWTA0aNxFQ7gLb0fbQfYJV4s8uSjAzkqpRt44j9hx5OY5AaxhP8Ie3vum27UeCOtR27UK8k1OH8Hd1GPFvs1pDglCbwnd/XY8ouR3k82aOX/QE8uaf8xsE4g9KY2o8/vhaResJboP2XOv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333693; c=relaxed/simple;
	bh=MuEJ/lvaNOAA9bhSFzP9w2fhccVtKgiDbgRx3JzqOxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UD8Hz11k61vWnFKh1iqqNsDAXPoxc9Fb9SQpxIKbkXTXDuDgCj1Bh+VyHNl+3cnCwCGL4hIxFQbaRh5eNjJkUntsQFoCg/U37k5rXjLtKohasZpMeu5R8VXhjK/aJYRmpduqcamNw7L45lExT6OND8hCuj/bOjtj5YYNphnkkb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YJgWeCx5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=fHylp8jH5KZ7OVUeiARBt6GlHeZR7Ql4vpJE35s0Duo=; b=YJgWeCx5kzaJOdCT3m3j5DsSHC
	sJxUmacx9GHzzwINBV46c2/J7LtkqIR/8BtY2u/AFvR3rExrNJfT2vm3kNMGSIB1iZYdazY+1Vd+R
	56oMLvA+ah3NTTjBpACZgXLNWD3FrXm3xaz4gPHSvtkm0d1bMBY98+1avt6SF+/HsefbrMAGtubAC
	AeLZ+CG/D16ermNcB8kijBDxeQ/nVb1QYKOjXnTzleBPvYgRWvXdLqhDGFmDHFrrHuVSbA8NIWbOE
	QnE+UVO1BfMnnJirW6n/jZ82SxFku3ahMm78o6BnaLAf3PJz2uvAk+c6VB8pccgawJJkTHQ5kMG5f
	NkkcxkcA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vfkOW-0000000FX0e-3NHr;
	Tue, 13 Jan 2026 19:49:37 +0000
Date: Tue, 13 Jan 2026 19:49:36 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: ltp@lists.linux.it
Cc: linux-fsdevel@vger.kernel.org
Subject: [LTP][PATCH] lack of ENAMETOOLONG testcases for pathnames longer
 than PATH_MAX
Message-ID: <20260113194936.GQ3634291@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	There are different causes of ENAMETOOLONG.  It might come from
filesystem rejecting an excessively long pathname component, but there's
also "pathname is longer than PATH_MAX bytes, including terminating NUL"
and that doesn't get checked anywhere.

	Ran into that when a braino in kernel patch broke that logics
(ending up with cutoff too low) and that didn't get caught by LTP run.

	Patch below adds the checks to one of the tests that do deal
with the other source of ENAMETOOLONG; it almost certainly not the
right use of infrastructure, though.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/testcases/kernel/syscalls/chdir/chdir04.c b/testcases/kernel/syscalls/chdir/chdir04.c
index 6e53b7fef..e8dd5121d 100644
--- a/testcases/kernel/syscalls/chdir/chdir04.c
+++ b/testcases/kernel/syscalls/chdir/chdir04.c
@@ -11,6 +11,8 @@
 #include "tst_test.h"
 
 static char long_dir[] = "abcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
+static char long_path[PATH_MAX+1];
+static char shorter_path[PATH_MAX];
 static char noexist_dir[] = "noexistdir";
 
 static struct tcase {
@@ -20,16 +22,23 @@ static struct tcase {
 	{long_dir, ENAMETOOLONG},
 	{noexist_dir, ENOENT},
 	{0, EFAULT}, // bad_addr
+	{long_path, ENAMETOOLONG},
+	{shorter_path, 0},
 };
 
 static void verify_chdir(unsigned int i)
 {
-	TST_EXP_FAIL(chdir(tcases[i].dir), tcases[i].exp_errno, "chdir()");
+	if (tcases[i].exp_errno)
+		TST_EXP_FAIL(chdir(tcases[i].dir), tcases[i].exp_errno, "chdir()");
+	else
+		TST_EXP_PASS(chdir(tcases[i].dir), "chdir()");
 }
 
 static void setup(void)
 {
 	tcases[2].dir = tst_get_bad_addr(NULL);
+	memset(long_path, '/', PATH_MAX);
+	memset(shorter_path, '/', PATH_MAX - 1);
 }
 
 static struct tst_test test = {

