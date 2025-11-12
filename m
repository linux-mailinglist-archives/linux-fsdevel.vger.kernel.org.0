Return-Path: <linux-fsdevel+bounces-68116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F008FC54B6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 23:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A05914E03A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 22:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1852EACE2;
	Wed, 12 Nov 2025 22:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUp2mjpK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88B935CBB2;
	Wed, 12 Nov 2025 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762986561; cv=none; b=jlmFDex4OiV7Mw5VefhytGWcCt3UrBIg5jegQ97De7t93gHEQrxkpvt7VfDZ+O3E31QM/kbsXnYy9OVimbva6W9BtriexI5aCif4ZESALCoPGIhWpn8e0mJ2Eipk41muNaWdoylSptk7gEzQGhqoohzVpVQCGj8ODB2PokYMC/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762986561; c=relaxed/simple;
	bh=usrjYj7mtzjrvGjswJhH+ucxIQYkVTxMWhNDGaxXMA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omQTOak6/i0v9vJEmr51Qptkvf1TjiZ/Jyhd+GGUxar+79ipA4spXlcXgrgpJiJ06W9LnrKMrI2mPykB2s6sEIHXTVuhBWPeJNQJH+bEL7A9AC925bgruq/k7MG6/B2eY2hYV/EoOmY2dFm/0g0vspceiX7ALHt9ybVwxfRBQmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUp2mjpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AF9C4CEF8;
	Wed, 12 Nov 2025 22:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762986561;
	bh=usrjYj7mtzjrvGjswJhH+ucxIQYkVTxMWhNDGaxXMA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hUp2mjpKWxoyAZHiw+zsJgD/h+UEqB1gKmb3KFfipwna09NsMucDzYXdj5l231066
	 96njTmZ5UQXmTksTTj+lJj9rP+C8W6xTvSbRXCSlSJwqd0llcIGxCzNarfuD8BGGqn
	 eCIBzXw8Su9XMQ4iMZc10QIIo+9ZpKHeTlx1iJZCRcGhWGBFM7IRPles9eqbKIpv6r
	 y6m28NqBEFU5mu9UOMnWwghEjmTQoeW8d+HYA3PFewhQmH5OggIVqrEhfmEHboQ3t/
	 +2qIThBSkBMz0qRqbBYOcPCdz1TUB1zgurAut74wg0jDRl0Im3E808IHwxHE2EIedU
	 WfU3sfSaHTu+Q==
Date: Wed, 12 Nov 2025 14:29:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Baokun Li <libaokun1@huawei.com>, zlang@redhat.com, neal@gompa.dev,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com,
	bernd@bsbernd.com
Subject: [PATCH v6.1 04/33] common/rc: skip test if swapon doesn't work
Message-ID: <20251112222920.GO196358@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169820051.1433624.4158113392739761085.stgit@frogsfrogsfrogs>
 <016f51ff-6129-4265-827e-3c2ae8314fe1@huawei.com>
 <20251112182617.GH196366@frogsfrogsfrogs>
 <20251112200540.GD3131573@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112200540.GD3131573@mit.edu>

From: Darrick J. Wong <djwong@kernel.org>

In _require_scratch_swapfile, skip the test if swapon fails for whatever
reason, just like all the other filesystems.  There are certain ext4
configurations where swapon isn't supported, such as S_DAX files on
pmem, and (for now) blocksize > pagesize filesystems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
v6.1: clobber all the ext-specific stuff
---
 common/rc |   25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/common/rc b/common/rc
index b62e21f778d938..564235ea2e995c 100644
--- a/common/rc
+++ b/common/rc
@@ -3268,27 +3268,10 @@ _require_scratch_swapfile()
 	# Minimum size for mkswap is 10 pages
 	_format_swapfile "$SCRATCH_MNT/swap" $(($(_get_page_size) * 10)) > /dev/null
 
-	# ext* has supported all variants of swap files since their
-	# introduction, so swapon should not fail.
-	case "$FSTYP" in
-	ext2|ext3|ext4)
-		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
-			if _check_s_dax "$SCRATCH_MNT/swap" 1 >/dev/null; then
-				_scratch_unmount
-				_notrun "swapfiles are not supported"
-			else
-				_scratch_unmount
-				_fail "swapon failed for $FSTYP"
-			fi
-		fi
-		;;
-	*)
-		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
-			_scratch_unmount
-			_notrun "swapfiles are not supported"
-		fi
-		;;
-	esac
+	if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
+		_scratch_unmount
+		_notrun "swapon failed for $FSTYP"
+	fi
 
 	swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
 	_scratch_unmount

