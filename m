Return-Path: <linux-fsdevel+bounces-18285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCFB8B6909
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E86C8B233C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A828610A36;
	Tue, 30 Apr 2024 03:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDSFRUOq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C44816426;
	Tue, 30 Apr 2024 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448308; cv=none; b=lmzzAfBAygi1NIGmhiIKpaeJ+vf48zmsG5dbte5qOrfZGqlclzL4yeGjTdESBKzymM0n0xaTAicmXee5aU7zfP8BPypOZJBgHjvUJ32cMxsVp1fEGsZIx7+WD/Vt+ACTbFwewOxxKG6VT3R05+cEx05TJmPGBm349jnMGEoK3F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448308; c=relaxed/simple;
	bh=jY9iwZqrWyPrh2KA9qwCcm9YXe3C9G43Ql2TL+PHD8M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZB6xhMnRzwOcSQ6CE37BHRdSDyfiyK1DVejUtYu+JLu0k51n/71ByIpVbSlSFywSO4waI/ZCbOlxONRXXSJ5XoPakl1Reu7cnwD9t8ycYh2cPwVWcZcxjqN63Pay7OgRGp5laxBrW4hwDT3EUCas8E67cEDszE/BXO6zdaSHwkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDSFRUOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD2EC4AF14;
	Tue, 30 Apr 2024 03:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448307;
	bh=jY9iwZqrWyPrh2KA9qwCcm9YXe3C9G43Ql2TL+PHD8M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HDSFRUOqNJsje4ZClDoQSGSycyQHpdIkZiDUPPMj4us18jrEkdcEBCJXzgJiwNisE
	 /QF6jTv8E+0QbYnSe6RfE+Th+cTGBNY/tFv3Xb5zYzAZJRG/gQB/UR5PCO2650fB29
	 nQM2wYW/Rbar9j4eZPUSNKneTPWZRGQnD8pkUBNpz2aJU4OJGwP9SvnBPewn8s2zGZ
	 wDf4RyHlPHSLuYc9+yAIkaTbB0Z4ycmIKpx/pZ8fz845s/tTIg509kdA4geYv87VjS
	 vniUr+W8Eni5puhEdwJh0flP7Ax7gwgNLAO2gnxElvKdmgo48axrTB/MVy/dp1lC7B
	 eNxv2cLgzWUcw==
Date: Mon, 29 Apr 2024 20:38:27 -0700
Subject: [PATCH 29/38] xfs_repair: clear verity iflag when verity isn't
 supported
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683556.960383.9295825042846564069.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Clear the fsverity inode flag if the filesystem doesn't support it or if
the file is not a regular file.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 repair/dinode.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)


diff --git a/repair/dinode.c b/repair/dinode.c
index 4e39e5e76e90..bbb2db5c8e23 100644
--- a/repair/dinode.c
+++ b/repair/dinode.c
@@ -3324,6 +3324,34 @@ _("bad (negative) size %" PRId64 " on inode %" PRIu64 "\n"),
 				*dirty = 1;
 		}
 
+		if ((flags2 & XFS_DIFLAG2_VERITY) &&
+		    !xfs_has_verity(mp)) {
+			if (!uncertain) {
+				do_warn(
+	_("inode %" PRIu64 " is marked verity but file system does not support fs-verity\n"),
+					lino);
+			}
+
+			flags2 &= ~XFS_DIFLAG2_VERITY;
+			if (!no_modify)
+				*dirty = 1;
+		}
+
+		if (flags2 & XFS_DIFLAG2_VERITY) {
+			/* must be a file */
+			if (di_mode && !S_ISREG(di_mode)) {
+				if (!uncertain) {
+					do_warn(
+	_("verity flag set on non-file inode %" PRIu64 "\n"),
+						lino);
+				}
+
+				flags2 &= ~XFS_DIFLAG2_VERITY;
+				if (!no_modify)
+					*dirty = 1;
+			}
+		}
+
 		if (xfs_dinode_has_large_extent_counts(dino)) {
 			if (dino->di_nrext64_pad) {
 				if (!no_modify) {


