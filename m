Return-Path: <linux-fsdevel+bounces-14639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0CE87DEEA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA88B20BA9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDA71CAB1;
	Sun, 17 Mar 2024 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCUiIyMR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D0F1CA87;
	Sun, 17 Mar 2024 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693574; cv=none; b=u+jCtYfa2mLCHFR6cmRXo5zw0q6Rxa7qaEJPD77dCl2VvWKBUCoqrM9Mih13pOLHLoXZxBPzOyvNOLVBOJbIVPVqgpQ+AYDbrVfsbDbqwt928+3aYUbQfu0LP3c7/l4T3KM12WD46kRyPxsi3nf7Nu0X4c7/8fpL3gKejGOgRow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693574; c=relaxed/simple;
	bh=uPUaxD4rjARHFn8+5tfCguPT+oSw2DgMHoTuBM/TGU0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSKTF3Yt5/urc8UQqGKf36O2w6bui3yCP3/8SE1bkkoADzOjMqb0W6F5B8+uAX8LGKdkQ0LXzNCRA4twGQBilPer+2wP/52lwp8R7bkP3E4TzV5SkoD+w4uwODzrwnNoDo2y2+Os9H58hXYygPnGMF9/Bqdsu/Lc0uusz5BIN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCUiIyMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6D0C433F1;
	Sun, 17 Mar 2024 16:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693574;
	bh=uPUaxD4rjARHFn8+5tfCguPT+oSw2DgMHoTuBM/TGU0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VCUiIyMR5PfC3vJWB5a0QnPtCZUSw1nzqRE1du7aIubKiBFvqXCg5MOOV/v7z6UoJ
	 SQTlsWbt02PBWDXjpkh3HoXwk4A0WCjJ6RkvrglF4R5KQ8mnqoyGKmGT4n+jBssA02
	 VFN7tKM+WWGC1HPUy9qorKtZi/a8Sx3xLqV+xnSyxJgfAc8iKQI8oF2ZBxDXJ/u1qs
	 d9SJdXT3P2OBp2/GSuNB7U4ymzqR4rYclfkyXn3dC156nQv1R8sStfr285YNltfTiT
	 yK+K71Q3DVPHSI5z8M3/61FlgmJ7eakApViRPBMKJmHnlJR/ow9p68m7fOLvD+WQou
	 +xdtMWVorD5iA==
Date: Sun, 17 Mar 2024 09:39:33 -0700
Subject: [PATCH 2/3] xfs/{021,122}: adapt to fsverity xattrs
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org,
 zlang@redhat.com
Cc: fsverity@lists.linux.dev, fstests@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, guan@eryu.me, linux-xfs@vger.kernel.org
Message-ID: <171069248865.2687004.1285202749756679401.stgit@frogsfrogsfrogs>
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

Adjust these tests to accomdate the use of xattrs to store fsverity
metadata.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/xfs/021     |    3 +++
 tests/xfs/122.out |    1 +
 2 files changed, 4 insertions(+)


diff --git a/tests/xfs/021 b/tests/xfs/021
index ef307fc064..dcecf41958 100755
--- a/tests/xfs/021
+++ b/tests/xfs/021
@@ -118,6 +118,7 @@ _scratch_xfs_db -r -c "inode $inum_1" -c "print a.sfattr"  | \
 	perl -ne '
 /\.secure/ && next;
 /\.parent/ && next;
+/\.verity/ && next;
 	print unless /^\d+:\[.*/;'
 
 echo "*** dump attributes (2)"
@@ -128,6 +129,7 @@ _scratch_xfs_db -r -c "inode $inum_2" -c "a a.bmx[0].startblock" -c print  \
 	| perl -ne '
 s/,secure//;
 s/,parent//;
+s/,verity//;
 s/info.hdr/info/;
 /hdr.info.crc/ && next;
 /hdr.info.bno/ && next;
@@ -135,6 +137,7 @@ s/info.hdr/info/;
 /hdr.info.lsn/ && next;
 /hdr.info.owner/ && next;
 /\.parent/ && next;
+/\.verity/ && next;
 s/^(hdr.info.magic =) 0x3bee/\1 0xfbee/;
 s/^(hdr.firstused =) (\d+)/\1 FIRSTUSED/;
 s/^(hdr.freemap\[0-2] = \[base,size]).*/\1 [FREEMAP..]/;
diff --git a/tests/xfs/122.out b/tests/xfs/122.out
index 3a99ce77bb..ff886b4eec 100644
--- a/tests/xfs/122.out
+++ b/tests/xfs/122.out
@@ -141,6 +141,7 @@ sizeof(struct xfs_scrub_vec) = 16
 sizeof(struct xfs_scrub_vec_head) = 32
 sizeof(struct xfs_swap_extent) = 64
 sizeof(struct xfs_unmount_log_format) = 8
+sizeof(struct xfs_verity_merkle_key) = 8
 sizeof(struct xfs_xmd_log_format) = 16
 sizeof(struct xfs_xmi_log_format) = 80
 sizeof(union xfs_rtword_raw) = 4


