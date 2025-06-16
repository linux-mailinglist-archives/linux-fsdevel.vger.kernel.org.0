Return-Path: <linux-fsdevel+bounces-51774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2986CADB3DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CC607A1A4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4661FF1C8;
	Mon, 16 Jun 2025 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNY68t13"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27613126F0A;
	Mon, 16 Jun 2025 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084303; cv=none; b=Jx0cMM5XC7R9BaSTdtBjJrRmUfjlRBzKjUIm14Y3jJmjZ6JxFLe7vPEJ9+1vs/RlvHHOwaNrR/rVO4gLj68WjVCjF5azxhOiEAajn/Bh1vkBIwzboGQfKV7vRBFZ39kr6vTmsgm+k68rYZa9e+pNCJBW9FqalFIU4Vx7pJA+cm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084303; c=relaxed/simple;
	bh=WulBjw8ArzfQyf38C3shN1EE4DycRB8irg80xQNbZ2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbVMVDMjVi6uaLVZzLmPNt92uXoMDl5fWazn9/pfBtjkveQQrf9+OEpxEVfjtradoXywaUxwCfwIz7qhIVv6WhWZDcx4hdBhAihNii0H7duUgoaTqhLGguc+HzUqW+XAN6NqRyBjcpqGnZKh9OUq/01VwCApGPG7octuqU6weIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNY68t13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0B9C4CEEA;
	Mon, 16 Jun 2025 14:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750084302;
	bh=WulBjw8ArzfQyf38C3shN1EE4DycRB8irg80xQNbZ2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNY68t131j2sbE+wrh/9hFO/9Y6RIDXstIu70Eaxz5LP3nuynE6eJTlLPTJZw3Dz6
	 uK1mmHGzPxr//YXp3ZzTbNsIrhSQwPvGBnCTEnUdlmUwnZj9Vw+Mum81Nk8tdn+w9N
	 9Zfq6xRVMs4ngsURFm9Lh4lfkm1MELs6H+bJgrodMmhUry7LKrSI1yQk4E+VnPBExc
	 OuQlCCHZsvlYcIkssLi0VvLUFTtD4+WO56nEiMN5yjmb7DiWo79KcHBXchDmJMemcM
	 8lDIs8aDGxdc2rDGfZcPnnhlJXaGZhLjqkax7MUPIpNzbalzTB7skInSacujqByJU4
	 YoqEjkina0ULw==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Tyler Hicks <code@tyhicks.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] VFS: change old_dir and new_dir in struct renamedata to dentrys
Date: Mon, 16 Jun 2025 16:31:26 +0200
Message-ID: <20250616-kopfende-seilbahn-cdd8b52e8b2a@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174977089072.608730.4244531834577097454@noble.neil.brown.name>
References: <174977089072.608730.4244531834577097454@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=brauner@kernel.org; h=from:subject:message-id; bh=WulBjw8ArzfQyf38C3shN1EE4DycRB8irg80xQNbZ2c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEaB3r/skkzG/dU7zq7OYZB2SP/H3J2bay5X+S9Hxnq x7DU+sEO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyJYHhv59k+Svl0KXhUxjZ iu/PF1ued/OkguBbn67p/MqT1ZX8rzD8D9t6ISvTuPp1iuevd8rSq2KDco019lqp/93E9rzx0tE jzAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 13 Jun 2025 09:28:10 +1000, NeilBrown wrote:
> all users of 'struct renamedata' have the dentry for the old and new
> directories, and often have no use for the inode except to store it in
> the renamedata.
> 
> This patch changes struct renamedata to hold the dentry, rather than
> the inode, for the old and new directories, and changes callers to
> match.  The names are also changed from a _dir suffix to _parent.  This
> is consistent with other usage in namei.c and elsewhere.
> 
> [...]

Applied to the vfs-6.17.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.misc

[1/1] VFS: change old_dir and new_dir in struct renamedata to dentrys
      https://git.kernel.org/vfs/vfs/c/bc9241367aac

