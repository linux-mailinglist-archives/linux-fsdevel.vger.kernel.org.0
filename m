Return-Path: <linux-fsdevel+bounces-61488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3F6B5891D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26BF16B438
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8AC1A00F0;
	Tue, 16 Sep 2025 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twcz8aO4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65DF625;
	Tue, 16 Sep 2025 00:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982179; cv=none; b=TFBpmG25NwhbW3dVOgFqFqqACgDAopW3MW5ghJSO0vMhFuLuY9vLltGPALcvsk8tNdLxMdrYpubLrujODWsHP+nlblQDehwx+vB1tlV8uEAIjN+bYb6b8yEKxuiw9TpnEgBa72zKx9+LrRXwvRfdeV/1MzDq5Npi3xmgpFaPUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982179; c=relaxed/simple;
	bh=f7B2QDHKljcoszDJLPLXRrVwB45VlUcD5YZabfxi0UM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqODPu4RrpgWDC4+2d/rFIw0I2cUP0KPOMSUgKdEMRPZPGHr+YooVsKCsoxzHCsFm3ySpoRHioYy8MlITSk0o2x9qdROph2kyl4nZIwuBxSJWZG4sAhX4PA+4QoqlL7g6SiS8bfmCZsSbtgkqmZvzFU65Fwx+knkiUBxOiptbHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twcz8aO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6F7C4CEF1;
	Tue, 16 Sep 2025 00:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982179;
	bh=f7B2QDHKljcoszDJLPLXRrVwB45VlUcD5YZabfxi0UM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=twcz8aO4ow4c+C8MFpCQZ5HZGP041W/PNfo4KhKN063CZwwBQQe4EzRTxY32JXiUs
	 +LidHKmSGekrh2b+lwp7kLIbPTgzIqC4rwWHyn1fc/KTRAk4PGYctulNAAzvuzvyJp
	 YVmy5uItF18azTDoZhoXkAZoYsBGavSUtB8jzqfgeP1T/nsw3fDN7FZlzPsVfx9Ixc
	 17gNzDYSTplH4dvYGfDXeVdZobUexBdaiakKGeapeaZ3moBOXG5fYg9Hh9c2GumoMy
	 SD+KwmrM7eKceJQ/u71Ij37CgfMm+Rgh5C+QFUVzIw/A9RiWzPbCG0qxmQYmOMG8ft
	 5+Fd45Yh6AoGQ==
Date: Mon, 15 Sep 2025 17:22:59 -0700
Subject: [PATCHSET RFC v5 5/9] fuse4fs: specify the root node id
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162150.391172.13020654147286034076.stgit@frogsfrogsfrogs>
In-Reply-To: <20250916000759.GA8080@frogsfrogsfrogs>
References: <20250916000759.GA8080@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,


If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-root-nodeid
---
Commits in this patchset:
 * fuse4fs: don't use inode number translation when possible
---
 fuse4fs/fuse4fs.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)


