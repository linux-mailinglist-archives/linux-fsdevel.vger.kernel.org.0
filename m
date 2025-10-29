Return-Path: <linux-fsdevel+bounces-66167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB89C17EB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AE01885EAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4442DC35A;
	Wed, 29 Oct 2025 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0kxmKrf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCFA2DA762;
	Wed, 29 Oct 2025 01:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701279; cv=none; b=WOw2hpBfbz8tWXiSH+Nlcn6NUK56tEYl/tmbFgLCEidSGnDJYFDYHJwvgarzHqOCmxCR5UoVaXGdaBkon1ipxdG3IT4WhAKxMsaeBBBgAcfBKD4dtCNyREMGrODdseroTXvEXqH+F4lYaGXa+Twuo5lkDF3Q24YKe1dZiWTDfjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701279; c=relaxed/simple;
	bh=gYg3xJmroh4AWpwLCWJU4+6aAJwC7hj8Vb77PM5YnZQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dI2FW707TYNTeb1QAOjPRaeCaYSOep5GMKcXF+fmhYpDyxp0oV8F9VQa+u4QzRcNN0G1ZUD53a9VT1tvCa5cfcymQv2qIPEgqyRHOajAQ4K2IHo/6LtgfkliUeQBCwVrCY4qo7Zi1PjtSdnrpqDiHyS8ADXOyBATI+Cuyq3xjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0kxmKrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBE2C4CEE7;
	Wed, 29 Oct 2025 01:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701279;
	bh=gYg3xJmroh4AWpwLCWJU4+6aAJwC7hj8Vb77PM5YnZQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=h0kxmKrf2EZvJfBwRx9yMXMjns7WxsZNJ7P4HRc2CkjNpK7dWZ5ly24l+fpfjhcAX
	 yuufFbrMFrBtoJQH/Pna8PoRz4fXNvIbNzNh4R5EZfnEkBHJLuJRgFUSaTCUF7OXgJ
	 St7WE/yIBy5Pr7Ys8AIH58WPRmskEqLOT+vGxZR7yQKmKmL0qJGvzzRf9pZTBzeZGo
	 MWL1lwerwcpsi6vPHgn4o7zm4wTGD08s4bJwrskN5CoUFiIqNhsRzuGmHejvvx0nCX
	 /0y5AtusciwallvY8P4yDXj+//aRvYOTRb0ueCas1aCPhS9oFqJWRz4vsNo3pRg0JL
	 xOgXwa2TGf2wA==
Date: Tue, 28 Oct 2025 18:27:58 -0700
Subject: [PATCH 29/33] ext4/006: fix this test
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: fstests@vger.kernel.org, neal@gompa.dev, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820517.1433624.3685054089532382459.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

This test fails with:

    --- tests/ext4/006.out      2025-04-30 16:20:44.427339499 -0700
    +++ /var/tmp/fstests/ext4/006.out.bad       2025-09-12 14:46:22.697238872 -0700
    @@ -1,3 +1,4 @@
     QA output created by 006
     See interesting results in RESULT_DIR/006.full
    +e2fsck did not fix everything
     finished fuzzing

The reason for this is that the $ROUND2_LOG file has five lines in it:

    ++ mount image (2)
    ++ chattr -R -i
    ++ test scratch
    ++ modify scratch
    +++ stressing filesystem
    ++ unmount

When I wrote this test there were more things that common/fuzzy tried to
do.  Commit 9bab148bb3c7db reduced the _scratch_fuzz_modify output from
3 lines to 1, which accounts for the discrepancy.

Fix this by counting the lines that do /not/ start with two pluses and
failing if there's at least one such line.

Cc: <fstests@vger.kernel.org> # v2023.02.26
Fixes: 9bab148bb3c7db ("common/fuzzy: exercise the filesystem a little harder after repairing")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/ext4/006 |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


diff --git a/tests/ext4/006 b/tests/ext4/006
index 2ece22a4bd1ed8..3379ab77de30fb 100755
--- a/tests/ext4/006
+++ b/tests/ext4/006
@@ -125,13 +125,15 @@ _scratch_fuzz_modify >> $ROUND2_LOG 2>&1
 echo "++ unmount" >> $ROUND2_LOG
 umount "${SCRATCH_MNT}" >> $ROUND2_LOG 2>&1
 
+echo "======= round2" >> $seqres.full
 cat "$ROUND2_LOG" >> $seqres.full
+echo "=======" >> $seqres.full
 
 echo "++ check fs (2)" >> $seqres.full
 _check_scratch_fs >> $seqres.full 2>&1
 
 grep -E -q '(did not fix|makes no progress)' $seqres.full && echo "e2fsck failed" | tee -a $seqres.full
-if [ "$(wc -l < "$ROUND2_LOG")" -ne 7 ]; then
+if [ "$(grep -v '^++' "$ROUND2_LOG" | wc -l)" -gt 0 ]; then
 	echo "e2fsck did not fix everything" | tee -a $seqres.full
 fi
 echo "finished fuzzing" | tee -a "$seqres.full"


