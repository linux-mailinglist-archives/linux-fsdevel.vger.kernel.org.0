Return-Path: <linux-fsdevel+bounces-67375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EABC3D589
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 21:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DACB351346
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 20:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE912F998A;
	Thu,  6 Nov 2025 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4JL8aP7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56672F83B8;
	Thu,  6 Nov 2025 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762460800; cv=none; b=rcdT6eqxs07kljd7yhDcfydFePSJDis/NVk0kQGKQOjqBx1NHaSiFmmCQ4DsIPo3cJE8dtEHOVzlb0GG9BlVgShrztFZ46071GeAPg49ZKYkmdSI09lyBlwWVFfrakaNSJTHmK8fGXzMd407NURkUKNaTrLwIFuST1yIwGFUNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762460800; c=relaxed/simple;
	bh=G5+JFHN9pF0pfKeMBtPHehPbGANjfz2YxWFZBSN6yuU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VM/Ep4CubFVVSAIHNUQSIkbsK6pc+9uVrq6pGQGmeHiWYiKMCD6oyKK+GNW57ij9GgGoG4iZ5eFhEf382wCCWNidbGD2g7cHe0mkFaCXrret6G6f7b1xVMeeCD7RNnc3nZ+zykr9DctK8NhWLeQxPnmqLsA3kvkcXQa9/ojUh4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4JL8aP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7037C4CEF7;
	Thu,  6 Nov 2025 20:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762460800;
	bh=G5+JFHN9pF0pfKeMBtPHehPbGANjfz2YxWFZBSN6yuU=;
	h=Date:From:To:Cc:Subject:From;
	b=k4JL8aP7g3emW8K/WZvE0ZM2dTj76VdsE2erzADNRJ0g0nK2Zy0+FO0/90r/bz4pL
	 RHZhSc8mt04soUjBv/tFZ+X33fFy7fydtwv3C0+Yo/D/2PAntrfoTeCNFHuNVasTep
	 2kR94GaP2pqY2tWUIoOb98rY7DgipXqSprX2wFCiTfbsTL/b3kta8m7jmOicaDqyce
	 WBT5ngTQ0TOG0AfpAw2SeBvyBv4a6/3MmCDAekz9hvP19vn4ZcZNeMzEosshsnRS/B
	 q3WVXhHA5oyeL4f0k3kx9r1golXRvHmHMAU+eDvbNxITbugUA3LNDvCRY0tqH7QaCI
	 NlJAK1yVbTiPg==
Date: Thu, 6 Nov 2025 12:26:37 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [GIT PULL] fscrypt fix for v6.18-rc5
Message-ID: <20251106202637.GA7015@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6146a0f1dfae5d37442a9ddcba012add260bceb0:

  Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

for you to fetch changes up to 1e39da974ce621ed874c6d3aaf65ad14848c9f0d:

  fscrypt: fix left shift underflow when inode->i_blkbits > PAGE_SHIFT (2025-11-04 16:37:38 -0800)

----------------------------------------------------------------

Fix an UBSAN warning that started occurring when the block layer started
supporting logical_block_size > PAGE_SIZE.

----------------------------------------------------------------
Yongpeng Yang (1):
      fscrypt: fix left shift underflow when inode->i_blkbits > PAGE_SHIFT

 fs/crypto/inline_crypt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

