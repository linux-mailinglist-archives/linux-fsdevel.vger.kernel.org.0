Return-Path: <linux-fsdevel+bounces-64913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67540BF6703
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A0584F4E0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9FA32E73E;
	Tue, 21 Oct 2025 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgZLOeVb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B046332B99B;
	Tue, 21 Oct 2025 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049603; cv=none; b=fTHUgyMkVaJyQGQGhrs4K4GuhL85x2/wNQIWLosS6a27X4W3WptnMM9lCOVqh491TAAhYzPHMGemCbzyPiLqUKneoXAE0oDbaDhOwgwksLzW1coUApiqT3ADrOmpxq/NeMVSFAmlB+9L1v7KwpAbDklaeUObp1Y4cFiQwBu2E5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049603; c=relaxed/simple;
	bh=caNiKIiu7NfzX6xfeFGsba+STi7x7LD8wG+lIGArjj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptae77untxx7WnaUGtRlA0Wo2frf2pEi8LSzQd2jaZ2oX+yUFG8MKdmJaySQkCI69gdvXDgVCRFkVchOEIxkKv/ww3AUb5UFsm3aoKeFNLkH0UqOoQ2rorILxj13Z3Rhbfe/VgjChbp1pw8aeZJeHk0VbFpzWIBenr0L/4talMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgZLOeVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8615FC4CEF5;
	Tue, 21 Oct 2025 12:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761049603;
	bh=caNiKIiu7NfzX6xfeFGsba+STi7x7LD8wG+lIGArjj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dgZLOeVbc10iPn+gxqRfid52BLcMvln9BJNTMHdtquAUUO42/TEmCerKQVMyGlmq1
	 cOYUsJf6m065fByg3U0Lh8URjdA4Rj2L5xt0RFU5azmwsnrI/2sXmo78yXSOq9pQ7S
	 nBNIWSQnmY7gz1/wsmcw+lA6/w+A90Bym/qi6FGGwEbmjITu50ijfUsmLxHr3Umfva
	 LytdJQ0+uZgTuHoSlMWvf7DSTuUCE1fUUfTPnUTXZZ7T3hs6RUiTKelP3iHCeHPHDf
	 ppXk+HnUoxouuhWE1R5kjdDPXwki4G0U+vud0SimlIPmuE41JGw+JDyMMB9nQ7foy7
	 +OXERrmQuhQ5A==
From: Christian Brauner <brauner@kernel.org>
To: ecryptfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Tyler Hicks <code@tyhicks.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: Use MD5 library instead of crypto_shash
Date: Tue, 21 Oct 2025 14:26:35 +0200
Message-ID: <20251021-umfunktionieren-parkraum-9d1b6190b74d@brauner>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437; i=brauner@kernel.org; h=from:subject:message-id; bh=caNiKIiu7NfzX6xfeFGsba+STi7x7LD8wG+lIGArjj8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8r/7XsYhRx//yua3f1A/PntDzTeXkEk3T1VP5xSdZr j7oIn0qsaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAis5wZGR4FPfwhYKr4XNJ3 b0BKREbNxYsOqjziJ/MmTXx48O/Ud20M/xOnZTzkX8gUUi/22WzC9TU8jovqXzgcUf8yhaNuQZp gMS8A
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

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] ecryptfs: Use MD5 library instead of crypto_shash
      https://git.kernel.org/vfs/vfs/c/b5ebe9744540

