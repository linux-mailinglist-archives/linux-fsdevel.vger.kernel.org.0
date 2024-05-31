Return-Path: <linux-fsdevel+bounces-20611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F5E8D5FC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 12:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FED31C223F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 10:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25C2155CA8;
	Fri, 31 May 2024 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2QZpNnn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329FB1514E3
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717151719; cv=none; b=M2/vgXx9TJqw0B0slNhXWMnZJSOrLFnQcZwjXPkKg8SCiXb9nQ/sfXseaUJnnIVUdmCCpZ/6s47NVZuTqGO1XSW7rbZgoW+q4mAc7MojJNXi+H/HWzJSvTwI5NC7wHolQFHAyfKepgHikgUoQqi3peGy4B+r1lrO26AbskOhU0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717151719; c=relaxed/simple;
	bh=rR+DbhyVda2VFKFEcKVA1rQTHaNgffNlZACEN+9U8ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIXw0InPQZk7zHVX8GFWiyiozWm/6oEvsPuOxjtXOLFqaJra5lPaoA8Pow5JZwbwrP5GbpORPQQp+W0gqQW96nT2xBYer3dyzCaQDmMX51npvCpjYBvJS3HmIi1G/FVNywL0VEMfI54GEHtYYBmHoEoIMYgSLGdhU+15vZXoXyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2QZpNnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0874FC116B1;
	Fri, 31 May 2024 10:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717151719;
	bh=rR+DbhyVda2VFKFEcKVA1rQTHaNgffNlZACEN+9U8ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u2QZpNnnO5hdje5hcmw8rLWVCHsOPWPIrDocqyfXqfSOzjzHkcK5LgDg00+319nAZ
	 2Tq86yvCBSHDuxKATarwpscnUb7KCF5JRcL4ZsMFoBqJ7/8OB4jI585LXVRAuhnJ+d
	 KDL251uNvKVYFtXeO+nFDU78Hszp9Z7ov/FP1wVL4ich8stH0SsB58wf+44ZvCnYii
	 yEL98+bG86m0i6joVv5KGJjqdFU1UYirn8euB9JeIo+Ek2cEfyBXHi3CMgQHkJ3upe
	 G84/GUKqF4VDWjHWi7iyw6dE5MIbXb83vf2qwBbKhHHRrCJHMXjTk6MYLnEYTy6F0f
	 sEn1P1Z8Dez9w==
From: Christian Brauner <brauner@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/16] Prepare to remove PG_error
Date: Fri, 31 May 2024 12:34:49 +0200
Message-ID: <20240531-verlassen-leidwesen-ddfdaf6fb8cf@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530202110.2653630-1-willy@infradead.org>
References: <20240530202110.2653630-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3331; i=brauner@kernel.org; h=from:subject:message-id; bh=rR+DbhyVda2VFKFEcKVA1rQTHaNgffNlZACEN+9U8ZU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRFLn8o0Lyt34Ah1ab1681/D94e/KmYlvh757PZ0vzZ3 WU+9VlTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSe4uRoUFsYfGb1HWfe15l 9cpd9Iu4Vn12ao2aWv6nZlepP5J/JjMybJ7bxcrv9M+5yNjTcX1MAZf/W2OR1AlrfYTc3+8tiTv MAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 30 May 2024 21:20:52 +0100, Matthew Wilcox (Oracle) wrote:
> These patches remove almost all remaining uses of PG_error from
> filesystems and filesystem helper libraries.  In Linus' tree right now,
> there is one place which tests the PG_error bit, and that is removed in
> the jfs-next tree.  Thus, it is safe to remove all places which set or
> clear the PG_error bit since it is not tested.
> 
> The ntfs3 patches are allegedly in progress:
> https://lore.kernel.org/linux-fsdevel/85317479-4f03-4896-a2e1-d16b912e8b91@paragon-software.com/
> so I haven't included a patch here for them.  We also need to remove one
> spot in memory-failure that still sets it, so I haven't gone as far as
> deleting PG_error yet.  I guess that's for next merge window.
> 
> [...]

Nice cleanup!

---

Applied to the vfs.pg_error branch of the vfs/vfs.git tree.
Patches in the vfs.pg_error branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.pg_error

[01/16] befs: Convert befs_symlink_read_folio() to use folio_end_read()
        https://git.kernel.org/vfs/vfs/c/263cf5780497
[02/16] coda: Convert coda_symlink_filler() to use folio_end_read()
        https://git.kernel.org/vfs/vfs/c/8c30a7344abe
[03/16] cramfs: Convert cramfs_read_folio to use a folio
        https://git.kernel.org/vfs/vfs/c/def27a205420
[04/16] efs: Convert efs_symlink_read_folio to use a folio
        https://git.kernel.org/vfs/vfs/c/09da047e554d
[05/16] hpfs: Convert hpfs_symlink_read_folio to use a folio
        https://git.kernel.org/vfs/vfs/c/4c59e914ef1a
[06/16] isofs: Convert rock_ridge_symlink_read_folio to use a folio
        https://git.kernel.org/vfs/vfs/c/4df37c5f0882
[07/16] hostfs: Convert hostfs_read_folio() to use a folio
        https://git.kernel.org/vfs/vfs/c/e3ec0fe944d2
[08/16] jffs2: Remove calls to set/clear the folio error flag
        https://git.kernel.org/vfs/vfs/c/d15b00b1e588
[09/16] nfs: Remove calls to folio_set_error
        https://git.kernel.org/vfs/vfs/c/8f3ab6e4bebe
[10/16] orangefs: Remove calls to set/clear the error flag
        https://git.kernel.org/vfs/vfs/c/86b3d5f6df0e
[11/16] reiserfs: Remove call to folio_set_error()
        https://git.kernel.org/vfs/vfs/c/f4c51473d22a
[12/16] romfs: Convert romfs_read_folio() to use a folio
        https://git.kernel.org/vfs/vfs/c/d86f2de026c5
[13/16] ufs: Remove call to set the folio error flag
        https://git.kernel.org/vfs/vfs/c/ca7d585639b5
[14/16] vboxsf: Convert vboxsf_read_folio() to use a folio
        https://git.kernel.org/vfs/vfs/c/55050b6873c6
[15/16] iomap: Remove calls to set and clear folio error flag
        https://git.kernel.org/vfs/vfs/c/1f56eedf7ff7
[16/16] buffer: Remove calls to set and clear the folio error flag
        https://git.kernel.org/vfs/vfs/c/7ad635ea8270

