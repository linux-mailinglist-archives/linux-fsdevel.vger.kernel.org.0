Return-Path: <linux-fsdevel+bounces-14640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D81D87DEEC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A512814A5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D889E1CAB1;
	Sun, 17 Mar 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNQ9V18F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AF41CA87;
	Sun, 17 Mar 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693590; cv=none; b=TTPkTsTtu0JkZJT0nhmUReXUOG2JPBmDcetgCx/74lJveu9UCsPuwuZt54juiIW+l96iDnQsHiGrmktDM2AM/4bG0oylanriT5gPCQ4vPjn5ZIHSz1avfWMs2OTVFNQsOhKgcSXcSNA/59lNNhtpyspQ6l5apn2Wv7/xIG5pOE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693590; c=relaxed/simple;
	bh=tbVDTT9yipK8GZjcwshsu0g1SJYd7tjWpGAO062ZMTU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpJJICbxbdTzQyPTjsnEA2/FFb+q28V/kWh6ZUpRqzI/gTsdY+UIEZ3WKqHOLXQtwT1cb+ECiLJrq3wi2ntLszRNLJXG16xf7YJsqz/BAqpVJRIoYKqnRAfTet2zKkhcD0F/K7l1MDpF/yJkN+Hq+MBwtcV7NC0VkT8+mbqvoXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNQ9V18F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D792C433C7;
	Sun, 17 Mar 2024 16:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693590;
	bh=tbVDTT9yipK8GZjcwshsu0g1SJYd7tjWpGAO062ZMTU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qNQ9V18FxZtfv39DzSiuY3D67+/ix2uDsFUVsUZEtI8gvghBA1+c61dhlGFjcuqid
	 pCPP/lmxiu40cfSTGyGj+E9y6wxtGeWwKWNUNJjZEvD7d+Bxdhay+fxNLlf1jpRclo
	 drgVIpY2BnIKg3lRBDaNy/NqjL1X0CCycnZKpFyrJbc3K1HHVTjFRna3pICe9F/P5N
	 0Gctmq9D/fsPdcNUr2dCVzxq3b6JZXEf/B+Se91heN5Q5nOe+sqVn33LhiwkEEiofp
	 3u6BwNEmXTOInzYKM5FuhwToUA/pld8bT9k7z0C+UEt/GPmqnXjWYUwYWjwNi1DSB9
	 TEkVNQs+yXzgw==
Date: Sun, 17 Mar 2024 09:39:49 -0700
Subject: [PATCH 3/3] common/populate: add verity files to populate xfs images
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org,
 zlang@redhat.com
Cc: fsverity@lists.linux.dev, fstests@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, guan@eryu.me, linux-xfs@vger.kernel.org
Message-ID: <171069248879.2687004.6949510262710192001.stgit@frogsfrogsfrogs>
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

From: Darrick J. Wong <djwong@kernel.org>

If verity is enabled on a filesystem, we should create some sample
verity files.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 common/populate |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)


diff --git a/common/populate b/common/populate
index 35071f4210..3f3ec0480d 100644
--- a/common/populate
+++ b/common/populate
@@ -520,6 +520,27 @@ _scratch_xfs_populate() {
 		done
 	fi
 
+	# verity merkle trees
+	is_verity="$(_xfs_has_feature "$SCRATCH_MNT" verity -v)"
+	if [ $is_verity -gt 0 ]; then
+		echo "+ fsverity"
+
+		# Create a biggish file with all zeroes, because metadump
+		# won't preserve data blocks and we don't want the hashes to
+		# stop working for our sample fs.
+		for ((pos = 0, i = 88; pos < 23456789; pos += 234567, i++)); do
+			$XFS_IO_PROG -f -c "pwrite -S 0 $pos 234567" "$SCRATCH_MNT/verity"
+		done
+
+		fsverity enable "$SCRATCH_MNT/verity"
+
+		# Create a sparse file
+		$XFS_IO_PROG -f -c "pwrite -S 0 0 3" "$SCRATCH_MNT/sparse_verity"
+		truncate -s 23456789 "$SCRATCH_MNT/sparse_verity"
+		$XFS_IO_PROG -f -c "pwrite -S 0 23456789 3" "$SCRATCH_MNT/sparse_verity"
+		fsverity enable "$SCRATCH_MNT/sparse_verity"
+	fi
+
 	# Copy some real files (xfs tests, I guess...)
 	echo "+ real files"
 	test $fill -ne 0 && __populate_fill_fs "${SCRATCH_MNT}" 5


