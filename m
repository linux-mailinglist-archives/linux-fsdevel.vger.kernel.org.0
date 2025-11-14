Return-Path: <linux-fsdevel+bounces-68483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA08AC5D239
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9107E4E05F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE635233155;
	Fri, 14 Nov 2025 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMQD5HcG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27CB70814;
	Fri, 14 Nov 2025 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763123260; cv=none; b=MrapQir0vxYTQ7urk51LiIUig6K64u+GRFar/XVQKqyB0JYtsa98ypgtrXhxRvZ7M+21TNGtwvqiHCUpTD2DQoLrNtYwxweYQFczYx5CCL71r9Kt+rZS1ahaPGxaCvcZF1M6s3sQdKekQrMHEEbfUI7nFmlxQRZY2azcmlviilQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763123260; c=relaxed/simple;
	bh=QtW3pIcizzKexpU9fz3Mn6XhYVCJ0IvGG+fMc/v2tu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YevJXSFr07KUWIZyS4/18AbmE2fkEqIdp9jM0M8ZKPDWi88m2hOr+YgwXrDMfdW1u4Cot5aaMN7uMLvB9Ei0F2jNgdJCxVvfByyNaeNlbibsSb7C5Lw23t3t3On/r59LU6q2q3ugOO0Ynps6gUEE/K+X7rJzYzU5+1JkPEifMNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMQD5HcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44684C4CEF1;
	Fri, 14 Nov 2025 12:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763123259;
	bh=QtW3pIcizzKexpU9fz3Mn6XhYVCJ0IvGG+fMc/v2tu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FMQD5HcG1ffTWXT8Xo2OKDgOSP+sIJvH7CZn7AJBTrq0c7/YiBKxn7agHnwyzQHyr
	 cGq9QLldky/rXqNJTecpRl63snIhwj0yMx2RfY9LOyFToZRKxUOzos8LrUwLQbEwos
	 wO78E3u2todLW/YXRHsaxHppzJgMdENH4klpYWJSGxoNsnk0r93uBQ3QpevldKX40U
	 eB/Suk11cWJqUxrq+uTS5IdSVBom+9Q+WQbGUtvsX4eK1zVfu3DPrjjnkQdz/XlRxa
	 EPDcoZc3bR/HHBhyB9buCIGkgU4n6ajy5oBPPhyEcnGv79EiNFL/etbevd3L/I9VKU
	 Lh2B6zgqwL5xg==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@ownmail.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v6 00/15] Create and use APIs to centralise locking for directory ops.
Date: Fri, 14 Nov 2025 13:27:18 +0100
Message-ID: <20251114-zweifach-schrebergarten-a49fa00bcfc5@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113002050.676694-1-neilb@ownmail.net>
References: <20251113002050.676694-1-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2736; i=brauner@kernel.org; h=from:subject:message-id; bh=QtW3pIcizzKexpU9fz3Mn6XhYVCJ0IvGG+fMc/v2tu8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKK+g9CNad3XLpuvKKDY8aeY7vMktbWx69Sdl+3Uc3g /dHlb4JdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkhI3hf4CaY3qJwLfFDDf3 TWQR9nlwdocQW/NbFtsr0uenrXzbYsPIsGvJZNG119cwTFzxXv3QEi7ZQ3HpLrnxWa980lrmieT 84gMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 13 Nov 2025 11:18:23 +1100, NeilBrown wrote:
> Following is a new version of this series:
>  - fixed a bug found by syzbot
>  - cleanup suggested by Stephen Smalley
>  - added patch for missing updates in smb/server - thanks Jeff Layton
>  - various s-o-b
> 
> 
> [...]

Applied to the vfs-6.19.directory.locking branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.directory.locking branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.directory.locking

[01/15] debugfs: rename end_creating() to debugfs_end_creating()
        https://git.kernel.org/vfs/vfs/c/8b45b9a88233
[02/15] VFS: introduce start_dirop() and end_dirop()
        https://git.kernel.org/vfs/vfs/c/4037d966f034
[03/15] VFS: tidy up do_unlinkat()
        https://git.kernel.org/vfs/vfs/c/3661a7887462
[04/15] VFS/nfsd/cachefiles/ovl: add start_creating() and end_creating()
        https://git.kernel.org/vfs/vfs/c/7ab96df840e6
[05/15] VFS/nfsd/cachefiles/ovl: introduce start_removing() and end_removing()
        https://git.kernel.org/vfs/vfs/c/bd6ede8a06e8
[06/15] VFS: introduce start_creating_noperm() and start_removing_noperm()
        https://git.kernel.org/vfs/vfs/c/c9ba789dad15
[07/15] smb/server: use end_removing_noperm for for target of smb2_create_link()
        https://git.kernel.org/vfs/vfs/c/1ead2213dd7d
[08/15] VFS: introduce start_removing_dentry()
        https://git.kernel.org/vfs/vfs/c/7bb1eb45e43c
[09/15] VFS: add start_creating_killable() and start_removing_killable()
        https://git.kernel.org/vfs/vfs/c/ff7c4ea11a05
[10/15] VFS/nfsd/ovl: introduce start_renaming() and end_renaming()
        https://git.kernel.org/vfs/vfs/c/5c8752729970
[11/15] VFS/ovl/smb: introduce start_renaming_dentry()
        https://git.kernel.org/vfs/vfs/c/ac50950ca143
[12/15] Add start_renaming_two_dentries()
        https://git.kernel.org/vfs/vfs/c/833d2b3a072f
[13/15] ecryptfs: use new start_creating/start_removing APIs
        https://git.kernel.org/vfs/vfs/c/f046fbb4d81d
[14/15] VFS: change vfs_mkdir() to unlock on failure.
        https://git.kernel.org/vfs/vfs/c/fe497f0759e0
[15/15] VFS: introduce end_creating_keep()
        https://git.kernel.org/vfs/vfs/c/cf296b294c3b

