Return-Path: <linux-fsdevel+bounces-64922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D06BF69C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AC318C6E3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2015338904;
	Tue, 21 Oct 2025 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSyWXcSX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FC233858C;
	Tue, 21 Oct 2025 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051598; cv=none; b=Iqx+5fA606AAeAxmy2byR2DSFGPYpErXykDsBLpv+oDFrjza5FTUHmvVu+rB0N0p8dTwiVeyiiCBYPOXCJhniD/5cco+ZJQ9clwdiN/TkUTMlEcpi2CZ5YI7qNyjoYMZ6CWCe6SNP7K09YjG81gdThG2UDsOwFVWS4rHK8eUl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051598; c=relaxed/simple;
	bh=g+MwokVCtBQhfzcdbPLrXUJmGtJrE4rOxHEp+iUZ664=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2U6p93a8TWENsfyb7A/2mLGk5S+1t+KKXaeN0Ut4tnqBtb0cBP8rzusTqoSsFMZAGkTX0nQN+37lFbO4JWXYtGrRS6wFAk5Ia/MLPC1nmh8C/krr7E0zOtzTCn/yOJCeRVGgSIMG4HVE3O1/d/E7xsX4xL/Jr+4N+GqdIHYAUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSyWXcSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA57C4CEFF;
	Tue, 21 Oct 2025 12:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761051597;
	bh=g+MwokVCtBQhfzcdbPLrXUJmGtJrE4rOxHEp+iUZ664=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sSyWXcSXLybw8WXqY6tXyM7a6Bopf6qqPN4rdcjvEdcfI/zUtp6rs7X+qd4ttrMD5
	 oDHrLToFzgzsL0GtN2fywqv9OYey9nAJxxKhTCHuw4m8pGRqpPYV4iBUGMtHTgz10h
	 A37VHMkz3/gpp1Oy4KMZMMeOqrFEdvNzOiPkPOPdiaSk40LSkZjKD6WphLLdNHCLX7
	 hzNmIJFRqQH9X8uW39cQ0dt/zXXYvpuZxCJ/olOHelpPcviTScDc5itz4+KbXfGJVw
	 smzT++vQ6y5t6iu8099fBArHdy1RHLIKk9KhAGNdbg+bz+3h/XJtbbLvRvxiU2rvNw
	 v7uTj6zuOWqEA==
From: Christian Brauner <brauner@kernel.org>
To: ecryptfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Tyler Hicks <code@tyhicks.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: Use MD5 library instead of crypto_shash
Date: Tue, 21 Oct 2025 14:59:52 +0200
Message-ID: <20251021-implosion-ambivalent-bfc95c0b3c5e@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251011200010.193140-1-ebiggers@kernel.org>
References: <20251011200010.193140-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437; i=brauner@kernel.org; h=from:subject:message-id; bh=g+MwokVCtBQhfzcdbPLrXUJmGtJrE4rOxHEp+iUZ664=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8bz4Z+c1m19cvOc9UFOWvnnhv9uHWB7mwjfy8OUlPa 12ORLTydJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkSC7Df99CQw+T4I3/wvJW Lg/6/z7o2N39Aj1BdbeXBJV/mvGUax4jw75v5kcYu3IvP3n7obSw5LBQjYicllLPo6Vummvb7Lx aOQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 11 Oct 2025 13:00:10 -0700, Eric Biggers wrote:
> eCryptfs uses MD5 for a couple unusual purposes: to "mix" the key into
> the IVs for file contents encryption (similar to ESSIV), and to prepend
> some key-dependent bytes to the plaintext when encrypting filenames
> (which is useless since eCryptfs encrypts the filenames with ECB).
> 
> Currently, eCryptfs computes these MD5 hashes using the crypto_shash
> API.  Update it to instead use the MD5 library API.  This is simpler and
> faster: the library doesn't require memory allocations, can't fail, and
> provides direct access to MD5 without overhead such as indirect calls.
> 
> [...]

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/1] ecryptfs: Use MD5 library instead of crypto_shash
      https://git.kernel.org/vfs/vfs/c/7f77fe73421f

