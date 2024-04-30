Return-Path: <linux-fsdevel+bounces-18300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E04F08B692E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19055B22302
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEC111187;
	Tue, 30 Apr 2024 03:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnsV80QO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E778DDA6;
	Tue, 30 Apr 2024 03:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448542; cv=none; b=SGjUKPB8ZvivxFKtRizIuXuSbQinxqnpoTR/q7VQamMejHhlz4n8MuavAK5ixi/tSxz8yAe34dQsvifI0Bq/2AvYLSzPdJDhMOi1ixrRIj/wNtXEXfIqdJpGFFIfPkOTbmFodyKd7c/3EKrM3QbIDJsXY5e82WOiaAmo0sC+1nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448542; c=relaxed/simple;
	bh=jbApkDvEWvvkWcdeshF4HBowOWeIkefxLeuhyJUzYvA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sc9iHD98S70wljFjagyFGcCPAWxrZvPhAtNYAd+YTiV8sqtTqgNSyM5Fj3TVbiEoIg3U/kvYf9UN2yy783UPJmTIpRztf2ZU5orhqfih7COmKxvd5hhD5kR8cgeSerhzSDhcv1w1aL5/3i6XS85xNpPNaURN3FAmmXOtS3hdc8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnsV80QO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24874C116B1;
	Tue, 30 Apr 2024 03:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448542;
	bh=jbApkDvEWvvkWcdeshF4HBowOWeIkefxLeuhyJUzYvA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FnsV80QOgYyl6gGrhdpVmULSAHxSHejT4TlWbMOjf1SsOrkmGJZ7GmUt/D7aY+IJf
	 +Vi43sxd4SUygIVlrl9VVcqe0w8MtJCQKbEBh8uA30hD5YnMfgYb7bcfVcP21ezEre
	 ggq4EO5G9dRo09OP9SNNiFquasY2qziGj9bo1mP24V5qco0lyVP6oV1NBHGofa2214
	 VqoeD9x3+WXuEFI7j0MCCYBppCmqqkra15TImCKYFc33hqkvBFQ8WJ5mfAfRkF9P/P
	 y9KnNE9sT32sG6kXrq3e7+1FK6yPakABl+WXUHNWQwRSe/ITCqB/PIFOfszTaVo6vj
	 MlzG1xVZ2YUog==
Date: Mon, 29 Apr 2024 20:42:21 -0700
Subject: [PATCH 6/6] common/populate: add verity files to populate xfs images
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, zlang@redhat.com, ebiggers@kernel.org,
 djwong@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, guan@eryu.me,
 linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Message-ID: <171444688070.962488.15915265664424203708.stgit@frogsfrogsfrogs>
In-Reply-To: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
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
 common/populate |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)


diff --git a/common/populate b/common/populate
index 35071f4210..ab9495e739 100644
--- a/common/populate
+++ b/common/populate
@@ -520,6 +520,30 @@ _scratch_xfs_populate() {
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
+		$XFS_IO_PROG -f -c "pwrite -S 0 0 3" -c "pwrite -S 0 23456789 3" "$SCRATCH_MNT/sparse_verity"
+		fsverity enable "$SCRATCH_MNT/sparse_verity"
+
+		# Create a salted sparse file
+		$XFS_IO_PROG -f -c "pwrite -S 0 0 3" -c "pwrite -S 0 23456789 3" "$SCRATCH_MNT/salted_verity"
+		local salt="5846532066696e616c6c7920686173206461746120636865636b73756d732121"	# XFS finally has data checksums!!
+		fsverity enable --salt="$salt" "$SCRATCH_MNT/salted_verity"
+	fi
+
 	# Copy some real files (xfs tests, I guess...)
 	echo "+ real files"
 	test $fill -ne 0 && __populate_fill_fs "${SCRATCH_MNT}" 5


