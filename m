Return-Path: <linux-fsdevel+bounces-14638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2591087DEE7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B721F21079
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856931CAB1;
	Sun, 17 Mar 2024 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6C7gOdA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE651CA87;
	Sun, 17 Mar 2024 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693559; cv=none; b=RNSmtrYIP+NDCj/wyMQS+t4ydZjXjD8GHeRPOQMxaJbmttI1Jc10Uw81X7Cc1MWrIGWqApdHV7WH5I1oVS4iXcVCa8fffOIZehxCeceOpgUJtN8lysnMThy58U+oZENOKayyIKI3SOxeEpqzxE4QAm4akb/UzdXbfXRknk2ISvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693559; c=relaxed/simple;
	bh=XK9GqXralr4+IiJ50cBl84PJADfWi3fhstXWHq38QcU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJp5zAQ5YauL3GjG1j/3Ys8ugm8iQbuNCB9GMlyaRDW2F8egafgwIt5iW4GNn/0HnBL/6HdvfgrUm+bVVCHPl1acWpmfZMnbfYh3LKCrZlKCu4eg610aboc8fprKIW14w+tsnGdRsLJlKGXb6CFBXJReYz4yCghCbzRE6ggiWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6C7gOdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29B9C433C7;
	Sun, 17 Mar 2024 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693558;
	bh=XK9GqXralr4+IiJ50cBl84PJADfWi3fhstXWHq38QcU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=G6C7gOdA7PJt/sF4XwiheIUD175NRZXOzto455cx4e/0RZGL1SwWDWxVTO5EH3OWr
	 8eDkZ4mMKkLvvPNag+KbG2MRfRYMdmkxger06etzcTJ8i//P7Pn91nl2WMN+lMwnQL
	 6UFI9oA9hAXJQHHjuoEPCgXPKDJh9NE5rmLWQkMGYt4Dz7wkxC/L43mofBl2SBdUDB
	 Nd8kh/So0M0YPBAgWUYEce4y99sKlBJ/ghmn3AdeuSPBem3oYcZJVFe0URuLI08DDG
	 6qh4JebMpXyqC/VP4TTsoEK496nlJ4CqxUfZNxHxWIY3zWPPAvZzuzab6foUsAUFj6
	 QDj99dCOOSNNw==
Date: Sun, 17 Mar 2024 09:39:18 -0700
Subject: [PATCH 1/3] common/verity: enable fsverity for XFS
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org,
 zlang@redhat.com
Cc: Andrey Albershteyn <andrey.albershteyn@gmail.com>,
 fsverity@lists.linux.dev, fstests@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, guan@eryu.me, linux-xfs@vger.kernel.org
Message-ID: <171069248850.2687004.5662408567138574298.stgit@frogsfrogsfrogs>
In-Reply-To: <171069248832.2687004.7611830288449050659.stgit@frogsfrogsfrogs>
References: <171069248832.2687004.7611830288449050659.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Andrey Albershteyn <aalbersh@redhat.com>

XFS supports verity and can be enabled for -g verity group.

Signed-off-by: Andrey Albershteyn <andrey.albershteyn@gmail.com>
---
 common/verity |   29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)


diff --git a/common/verity b/common/verity
index 03d175ce1b..df4eb5dee7 100644
--- a/common/verity
+++ b/common/verity
@@ -43,7 +43,16 @@ _require_scratch_verity()
 
 	# The filesystem may be aware of fs-verity but have it disabled by
 	# CONFIG_FS_VERITY=n.  Detect support via sysfs.
-	if [ ! -e /sys/fs/$fstyp/features/verity ]; then
+	case $FSTYP in
+	xfs)
+		_scratch_unmount
+		_check_scratch_xfs_features VERITY &>>$seqres.full
+		_scratch_mount
+	;;
+	*)
+		test -e /sys/fs/$fstyp/features/verity
+	esac
+	if [ ! $? ]; then
 		_notrun "kernel $fstyp isn't configured with verity support"
 	fi
 
@@ -201,6 +210,9 @@ _scratch_mkfs_verity()
 	ext4|f2fs)
 		_scratch_mkfs -O verity
 		;;
+	xfs)
+		_scratch_mkfs -i verity
+		;;
 	btrfs)
 		_scratch_mkfs
 		;;
@@ -407,6 +419,21 @@ _fsv_scratch_corrupt_merkle_tree()
 		done
 		_scratch_mount
 		;;
+	xfs)
+		local ino=$(stat -c '%i' $file)
+		local attr_offset=$(( $offset % $FSV_BLOCK_SIZE ))
+		local attr_index=$(printf "%08d" $(( offset - attr_offset )))
+		_scratch_unmount
+		# Attribute name is 8 bytes long (index of Merkle tree page)
+		_scratch_xfs_db -x -c "inode $ino" \
+			-c "attr_modify -f -m 8 -o $attr_offset $attr_index \"BUG\"" \
+			>>$seqres.full
+		# In case bsize == 4096 and merkle block size == 1024, by
+		# modifying attribute with 'attr_modify we can corrupt quota
+		# account. Let's repair it
+		_scratch_xfs_repair > $seqres.full 2>&1
+		_scratch_mount
+		;;
 	*)
 		_fail "_fsv_scratch_corrupt_merkle_tree() unimplemented on $FSTYP"
 		;;


