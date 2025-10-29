Return-Path: <linux-fsdevel+bounces-66145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C27C17DFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D1E3B5B3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AD42DC79E;
	Wed, 29 Oct 2025 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Skz3YnwE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536A22DC32C;
	Wed, 29 Oct 2025 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700936; cv=none; b=o646ufsZFdcrHCOpaorS5izmTBT4S/LKOCHEmweaWSVI9bfWfeIG8G9d42qit28SAFSoMViCVdscpZRcVAE3LtAshRt8fYnzJbek5aW3hOzotg4o/wsTjUq/Hoe+cstSA3HaM45UtDGpUGpcEtATW4Mi1NdzcE2taH7nuJLn1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700936; c=relaxed/simple;
	bh=xEeX/XYGe/Kji/h9+8hZkecVMIhuSxLXzim5MVpsKMw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8TZxWS8WvilWVQgLN4N4VJqbBIPjZsb6DuRh8m7wdwycsIee0+qerEBicDDv4/lObNaSRPckrq2+qm0fR/yvD69zFaQz3t+jR0SZyo4LxoEROj9JFmkXPp5UbQqUBnDRPwaQSY8vRHWm21nX/luAuRn3QmjzWZd8tN6M4C/6u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Skz3YnwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29BAC4CEE7;
	Wed, 29 Oct 2025 01:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700936;
	bh=xEeX/XYGe/Kji/h9+8hZkecVMIhuSxLXzim5MVpsKMw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Skz3YnwEtJW7z0FaVO1A9663PsWzsfEMSMi9IPl8wVJSbRfg+8vMVHqOlLCJpewNh
	 cdOeXmmBHBJAX/WcNjEpSupaxFhsPfmIK19CndMxEbYHU7/68ytc0fVNj58aGLO8sA
	 rB30ifL+zGD37JfQioVyyMSs+cDMwEqmnEBtjZa/7BlSCCQBUTS8Z0ouOrzhZHjxy6
	 iOS9U2zUvCl+mrwOCC4AXh2S7dxypD0RWCFF557RvC6fbFUTDsseSXURMmtYvokgSk
	 xwJVohSxpFqsFGHXQF5IaImxhu+ThJ4IJHXoRHSNpKM8z/XVXMb2zgYuC3Ytb5d2j1
	 xuaT58TsaMZeQ==
Date: Tue, 28 Oct 2025 18:22:15 -0700
Subject: [PATCH 07/33] populate: don't check for htree directories on
 fuse.ext4
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820107.1433624.302243104848471945.stgit@frogsfrogsfrogs>
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

libext2fs doesn't know how to create the htree indexes for a directory,
so fuse2fs doesn't either.  Amend common/populate not to check for
htree.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/ext4     |   12 ++++++++++++
 common/populate |    1 +
 tests/ext4/052  |    3 +--
 3 files changed, 14 insertions(+), 2 deletions(-)


diff --git a/common/ext4 b/common/ext4
index a2ce456d4ec761..69fcbc188dd066 100644
--- a/common/ext4
+++ b/common/ext4
@@ -242,3 +242,15 @@ _ext4_get_inum_iflags() {
 	debugfs -R "stat <${inumber}>" "${dev}" 2> /dev/null | \
 			sed -n 's/^.*Flags: \([0-9a-fx]*\).*$/\1/p'
 }
+
+_ext4_supports_htree() {
+	# fuse2fs doesn't create htree indexes, ever
+	case "$FSTYP" in
+	fuse.ext[234]|ext2|ext3)
+		return 1
+		;;
+	*)
+		return 0
+		;;
+	esac
+}
diff --git a/common/populate b/common/populate
index 6ca4a68b129806..fea2ff167167ae 100644
--- a/common/populate
+++ b/common/populate
@@ -942,6 +942,7 @@ __populate_check_ext4_dir() {
 		(test "${inline}" -eq 0 && test "${htree}" -eq 0) || __populate_fail "failed to create ${dtype} dir ino ${inode} htree ${htree} inline ${inline}"
 		;;
 	"htree")
+		_ext4_supports_htree || return 0
 		(test "${inline}" -eq 0 && test "${htree}" -eq 1) || __populate_fail "failed to create ${dtype} dir ino ${inode} htree ${htree} inline ${inline}"
 		;;
 	*)
diff --git a/tests/ext4/052 b/tests/ext4/052
index 18b2599f43c7ba..05dd30edf70c9b 100755
--- a/tests/ext4/052
+++ b/tests/ext4/052
@@ -29,8 +29,7 @@ _cleanup()
 
 
 # Modify as appropriate.
-_exclude_fs ext2
-_exclude_fs ext3
+_ext4_supports_htree || _notrun "htree not supported on $FSTYP"
 _require_test
 _require_loop
 _require_test_program "dirstress"


