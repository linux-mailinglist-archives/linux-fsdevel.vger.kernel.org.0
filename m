Return-Path: <linux-fsdevel+bounces-67105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C97C35600
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 12:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0959C1A20052
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4C5302CC1;
	Wed,  5 Nov 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G40HXxK9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639A92D7DE8;
	Wed,  5 Nov 2025 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342440; cv=none; b=cGkiN69K9TXgRDQVfdMIVYTGemPr9asD8iiG6OlPm5qlL/FRH/alqon1TF88cdv9nhPJjdxI3zDd942aXCx2vvE/pSF0zY2j7QP1T++HSHDVCutrgKLZoR4AhHRmWhNF4R1npeh6PDfGWFFqT53dsy/kUrGOhY0QP+TUeZi9+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342440; c=relaxed/simple;
	bh=0XvtGTeN7AOqr5WkLS2LE1tbvwsKwewmddDVHX8InLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pk1nW4Lw6T59XT9d1YFzLSTeoO6hTtVZdI2UjpMpiWcVAyhPayFi2On7UNLPdjjBuv2fzLN929PYTItyPejCyOzE6VC1CPwBRZYAE6UvJnVCVAEhwpE2iTZQrOPGt8wvXn+P/A033Qw0z1EfC06p/YvTlOTueCz5nfSctF6J7dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G40HXxK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669DEC16AAE;
	Wed,  5 Nov 2025 11:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762342439;
	bh=0XvtGTeN7AOqr5WkLS2LE1tbvwsKwewmddDVHX8InLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G40HXxK9CxjwFdzeqeUwSVGI7nIXx0w48chwsjwDv1mP8fBTzNUnzCaHPbA8IIG0f
	 hsdjX+xt6zz3TFnHBfp88fEw1QmBev+w7U5CdtqtFWWnEWh1Zh29PmNR0raflLrocp
	 nYGdu/NN6XdiEcm24jrFjM2AYnCjXefcNTRzmRZLEqG+Eoc35jgG58Ge+ZkIFjfPqu
	 8yBtqzdpNU79f2d/OhfR+PRajTRa6ZZ40nYkfJvN+Ki8vk+1gsB3Kj1Sd2E50qZiDK
	 YGi88EgUqcPunaS8Iza+8IWVWcKTA1dn4ncPRSdarumQDaCw8N+QXEdVk2hpcSAR13
	 EypK2HUxJIZqw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fs: push list presence check into inode_io_list_del()
Date: Wed,  5 Nov 2025 12:33:54 +0100
Message-ID: <20251105-karawane-anpreisen-424ae5993ab3@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103230911.516866-1-mjguzik@gmail.com>
References: <20251103230911.516866-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=brauner@kernel.org; h=from:subject:message-id; bh=0XvtGTeN7AOqr5WkLS2LE1tbvwsKwewmddDVHX8InLg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRymylLOF8JuJY2a++HVSunrfrdwfWp6/LVeebbPz1pe LPWKszvSEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEpk5n+CvOtfHV2v6GmKZz CmwRYic3h6Y/ebhqUlDrqtBej58KU7wZ/tf7iblJ3TFkvizaa7k5/FuN092N+nGRc4OTjzrp1Ba qcAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 04 Nov 2025 00:09:11 +0100, Mateusz Guzik wrote:
> For consistency with sb routines.
> 
> ext4 is the only consumer outside of evict(). Damage-controlling it is
> outside of the scope of this cleanup.
> 
> 

Applied to the vfs-6.19.inode branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.inode branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.inode

[1/1] fs: push list presence check into inode_io_list_del()
      https://git.kernel.org/vfs/vfs/c/f6fe56e7a34e

