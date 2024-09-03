Return-Path: <linux-fsdevel+bounces-28368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD11969E97
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218931F24D75
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E991A42CB;
	Tue,  3 Sep 2024 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOffpb6+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A366D1CA6A7;
	Tue,  3 Sep 2024 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368553; cv=none; b=en59xM6x8FdhPw7/yumnX9skS4K0g0XJpvkxyBSo4Jpwxh6bMgb4kNnu6Ec52OLP90sGlN9WzhNVIRyZoVwPRikAtdww4R+E7ixtJwq2Z/ACEjrSA6DoN3yS4nbfMtRbH9xwyel6jxqLwNoU0ASdzON139x4mwbxnnhmI2WFG0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368553; c=relaxed/simple;
	bh=RKYmQLjTh3bRw4tiaBfejmcaMdebUhnCWWkQpyck+Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvyiimNzgSK1g/azH+Wawg196qqbQZe7I6QwzWipoOd6QVWYCnpAJRj0WN/77bgtI4H/HMr/o3s/ce0jlpqfRItZ/17MqZvHQ2RWpIP11BnhqZXKTNAsp79qipfBLTdc4lnIanQmEYt8zd/eNZ+5NLOIfwShu3PfjGHxqcV4ZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOffpb6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2D5C4CEC4;
	Tue,  3 Sep 2024 13:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725368553;
	bh=RKYmQLjTh3bRw4tiaBfejmcaMdebUhnCWWkQpyck+Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pOffpb6+LnfBUArZklZYCwOU5i5AMuFoyWKkx+96cGxXEix1CRJgCloiBKZL60O2v
	 3eZ7yBJL69y55ZBOvrEBHSl9impqPpOG7fofC7/ZdF4xGQbayClrp8VvvmgVy2cyTA
	 XjFRhKirB5oHIhmH8pvTkXXXxEczsmwUWNHib82/vrYD47OksKIn4cyW7xVIBui7mn
	 bGrS4Cz9hJPPtofIf0XJWCy0WTmk3EFwy2vbQqt300f8NKzFAOKuTbjnIyAK0Jl73k
	 P8PQNnGYYVM3+CeV4WsL8qtrCCN9PQd1JKk+9CROWlK5ojqOA/IIDCBj0auykufmtX
	 gh6wd7B31l6iA==
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH] xfs: Fix format specifier for max_folio_size in xfs_fs_fill_super()
Date: Tue,  3 Sep 2024 15:02:25 +0200
Message-ID: <20240903-bergdorf-vierkantholz-d085836abbe1@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240827-xfs-fix-wformat-bs-gt-ps-v1-1-aec6717609e0@kernel.org>
References: <20240827-xfs-fix-wformat-bs-gt-ps-v1-1-aec6717609e0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2491; i=brauner@kernel.org; h=from:subject:message-id; bh=RKYmQLjTh3bRw4tiaBfejmcaMdebUhnCWWkQpyck+Pw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRd53ikXqG9VWavo1DGzi8XDpwXkzY/M0n4ifDBypKV0 hFC29dM7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIsTjD/2hpzwrjOXVJEuWh v99HSbRb3va59+xnTo7yskMC15wKlzP8ldd+WKSfVur10vGN4gFfl1clCgqmSQvqlH8eab39dos fMwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 27 Aug 2024 16:15:05 -0700, Nathan Chancellor wrote:
> When building for a 32-bit architecture, where 'size_t' is 'unsigned
> int', there is a warning due to use of '%ld', the specifier for a 'long
> int':
> 
>   In file included from fs/xfs/xfs_linux.h:82,
>                    from fs/xfs/xfs.h:26,
>                    from fs/xfs/xfs_super.c:7:
>   fs/xfs/xfs_super.c: In function 'xfs_fs_fill_super':
>   fs/xfs/xfs_super.c:1654:1: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>    1654 | "block size (%u bytes) not supported; Only block size (%ld) or less is supported",
>         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1655 |                                 mp->m_sb.sb_blocksize, max_folio_size);
>         |                                                        ~~~~~~~~~~~~~~
>         |                                                        |
>         |                                                        size_t {aka unsigned int}
>   ...
>   fs/xfs/xfs_super.c:1654:58: note: format string is defined here
>    1654 | "block size (%u bytes) not supported; Only block size (%ld) or less is supported",
>         |                                                        ~~^
>         |                                                          |
>         |                                                          long int
>         |                                                        %d
> 
> [...]

The fix has been folded into the commit it fixes and a Link tag has been added
noting that this patch has been folded. Thanks!

---

Applied to the vfs.blocksize branch of the vfs/vfs.git tree.
Patches in the vfs.blocksize branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.blocksize

[1/1] xfs: Fix format specifier for max_folio_size in xfs_fs_fill_super()
      (no commit info)

