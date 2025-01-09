Return-Path: <linux-fsdevel+bounces-38754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02001A07D56
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 17:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08C887A11BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 16:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DA0218E92;
	Thu,  9 Jan 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfWjlB1J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DD47FD;
	Thu,  9 Jan 2025 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439636; cv=none; b=Ft4svO5uB0RoiUBZFdPEnCsTvdCp3c3QjKScJQSxmgKIJwRmzREQMBFDXa3woXjfeg7ljqbp6/hr5Z3oOijDQGp6pylHZ+j3lvFFaIBDPY8LeIUnXtaRFYLgv9800bTzIHsrNe7mWODuQWDFRymwz77nk6gguAj0cWR/1vL8MtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439636; c=relaxed/simple;
	bh=sldwzxvW/R8iRVqJ/OHt6eFeo28DreIZbrstzILl5Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfjyEmDhRlDv659xTnsqekk7W3rFVLFtp4/xivDPqAzVhTgehoM//1hTkH0IdvkoxvLia77yO5+omr93xEZIbSyOuOWp7FGhr0ycpdL4b6Hjp1LScZkgrhE3wIzUr1byijEgA+Nfp2c0a2FzLgN1XdxQDUz3z2KGzgs8/E08BD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfWjlB1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CAEC4CED2;
	Thu,  9 Jan 2025 16:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736439635;
	bh=sldwzxvW/R8iRVqJ/OHt6eFeo28DreIZbrstzILl5Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BfWjlB1JWGCaHAm7YrOhtNouvLTW7+x0R9QVemDM+bv3Iq8+nXtl/+gb5ODk7GL63
	 tzFQp2NRBnkYM2qD9zG1B4eKTi/M03XAPa2rgFcF1IAws4g46zZSandhawGdMFv8xy
	 ccsol6LTMWsZDMdNwGM6PzMngWzTzywnoQTECMyi/Pmkl/sIwyE+BCEtSBHyoe+4fD
	 naOpkN+An8jr6XOqKsa+HCh/G3L5Noe/wsxjoKoqvHAD5WnppswpDFCul8ZXsF9gC8
	 7srjhtL6sH6hEUzmKv98s+kigbNSiRpiqJQC7qKV7PlLEtvj4arhyXeTQ1VPJHzZ7K
	 MlIDILge0DYOA==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix read-retry for fs with no ->prepare_read()
Date: Thu,  9 Jan 2025 17:20:27 +0100
Message-ID: <20250109-falter-idiotensicher-13fee5d55a4a@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <529329.1736261010@warthog.procyon.org.uk>
References: <529329.1736261010@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; i=brauner@kernel.org; h=from:subject:message-id; bh=sldwzxvW/R8iRVqJ/OHt6eFeo28DreIZbrstzILl5Ns=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTXf/dpexD9Vej2lJj8DvELuednNOzcZDOrLehP+cEt2 tITLz9V6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIYQDDXzGNSM8N4s8Cpfx5 aiaXvlPIeHQrL0uy8FzZ9TtKp1kfFTH8D7qyPef21B09vdPfr+uy42Rj9WG76efAe2K9wYlpW6c YcwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 07 Jan 2025 14:43:30 +0000, David Howells wrote:
> Fix netfslib's read-retry to only call ->prepare_read() in the backing
> filesystem such a function is provided.  We can get to this point if a
> there's an active cache as failed reads from the cache need negotiating
> with the server instead.
> 
> 

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] netfs: Fix read-retry for fs with no ->prepare_read()
      https://git.kernel.org/vfs/vfs/c/904abff4b1b9

