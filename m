Return-Path: <linux-fsdevel+bounces-66157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF45C17E2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11E764FFE85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DB52D9ED8;
	Wed, 29 Oct 2025 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZmnDIiD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2BD17B50F;
	Wed, 29 Oct 2025 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701123; cv=none; b=spgcRPZ9KxzsAMc34vHr5Csj7AIKnPW/86voKPVIbNmKaWvZl8SBIZcPhh8ONu0Eq4qQhzk3ypT5NU02MEy3ctlZfdf1Jgfl5X2/L4zT3jc+2EUymERar8tKmlK+PSqnBEad3WKWoHVwfnV8RoHTB7qqYWvKGL7rvS5xElSLkUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701123; c=relaxed/simple;
	bh=HbjdJjbr1HrNUs5EwpAM9CoIjerHgkWB3FFp0rKj3Pw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q22/ftJlHIVbCigJszJRFHLtHDh3CxIX/gDFkrNq25eoXAAV56cTngeoj9dV5yioR0Kana/LwXOc1Y4lsghisgpiYtSpH61fgAAS5Sv+SlahY9yT+K5YcXjC66JCSpRrhP6mJ0k4JYBwGvNo2hYHx+IFmG14Qr/nJV1xFIFXjUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZmnDIiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE8EC4CEE7;
	Wed, 29 Oct 2025 01:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701123;
	bh=HbjdJjbr1HrNUs5EwpAM9CoIjerHgkWB3FFp0rKj3Pw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CZmnDIiD5mDdkqPqTf045Rl2wyAQ8SjX0B3blYhuU3cxYY3Dcpkd7/lkrNQQfWdWj
	 elrUPewMfTHb232dO6vehbBVf2eppO+Qa7wEKpXCaMQ8bF5qq2tmg+9+J3P1AnYZ23
	 TUg8Ne60iD8r9/NLek12dGzMSr1q9+cNtFbh3NBAPM/yJQ16O9lhBvKI7bb4+ex9yT
	 gdtcAUCPI4EvE7h2+MgaUNcv3PWl7z9LQu4VSdAeQf0f2IBsb+K9B2ArcYTmnlPo7X
	 vF56gxxJCVeWG5YAM8dE7RrzzdgQOqDNIqPyxngKouhLZLch0Cc9pmNV3SB5l4RVjh
	 iQ6UfoOduuUCw==
Date: Tue, 28 Oct 2025 18:25:22 -0700
Subject: [PATCH 19/33] generic/563: fuse doesn't support cgroup-aware
 writeback accounting
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820334.1433624.1868204402938471160.stgit@frogsfrogsfrogs>
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

fuse_bdi_init disables writeback accounting on its bdi, so there's no
point in trying to measure the accounting for any block devices that the
fuse server might have open.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/563 |    2 ++
 1 file changed, 2 insertions(+)


diff --git a/tests/generic/563 b/tests/generic/563
index 1246226d9430ce..1fd2a81cdffa5d 100755
--- a/tests/generic/563
+++ b/tests/generic/563
@@ -34,6 +34,8 @@ _cleanup()
 _require_scratch_nocheck
 _require_cgroup2 io
 _require_loop
+[[ "$FSTYP" =~ fuse* ]] && \
+	_notrun "fuse doesn't support cgroup writeback accounting"
 
 # cgroup v2 writeback is only support on block devices so far
 _require_block_device $SCRATCH_DEV


