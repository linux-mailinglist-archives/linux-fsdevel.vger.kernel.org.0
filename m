Return-Path: <linux-fsdevel+bounces-73202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DBED11966
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65963301F32F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBD22765C4;
	Mon, 12 Jan 2026 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUeEQbxO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4FF26FDBF;
	Mon, 12 Jan 2026 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768211146; cv=none; b=Zpu7aumk7FrxXDUkusCAL/axkiNItv9nqcLPB8t4GW0Q3XzwKZ0SnJ4G0QdNPFA8x8SSwuQFAmLcNXMuxASAuxI4q5sSMzvPye9+Y7LZe06KvoxocWT14itzbYRu/YjaGfwpKnASrlHYQUHUthtF1uP3Kc4R91heqCtc/Tm8cMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768211146; c=relaxed/simple;
	bh=DxZZGzK74wIR5W3ofx2JM6E8wyCgaH8nZoYwWgX+eR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KK1tySqf/RA2cpWWpA/AZWNYS5ClU0Ec5mWt++mHODuOMLxjX150D8O8RPeSzenEA3mDr25wXGT98Mz3Punj9E8NZrutLYCB4QaYvBDQFqMtGTzSAh/JmQvaCe59tVU3pCWs0ojhjAD/gTsyGSeRSd8RNGueyT+4+HRKfGBtk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUeEQbxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05681C19422;
	Mon, 12 Jan 2026 09:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768211146;
	bh=DxZZGzK74wIR5W3ofx2JM6E8wyCgaH8nZoYwWgX+eR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUeEQbxO/1bJOSJmWeCdO+VjleNy8B0ViluvHBno5gr59qB8VEEYWEF1rbAie3EAq
	 0lBRAdHEvYyqkAHaFwEQSYJO7qICSgJMwVU+ZEnKnom6kmsD+MVv/kP2W50TNqRina
	 kmDueNMdchfAb950mTM+K2bF8wYvPkz2bL6iZxf1vIrUkGWdBvVMPGbx9pJEtEUBfV
	 IM3Dxy7GJeSsVnoP849ryUv7V8KBbcs5OYRuU/u3ZZJmvVfKYLY9RHyEOjm2pR6/Iw
	 silI5tXIpzTrN8O2PvgT967TZ9iXPpt9mOUwWRmfeNSwvLi1wbJ+xb2XzRmSgGte9Z
	 9hI9tmM6jxdEA==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@ownmail.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
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
	Val Packett <val@packett.cool>
Subject: Re: [PATCH] fuse: fix conversion of fuse_reverse_inval_entry() to start_removing()
Date: Mon, 12 Jan 2026 10:45:29 +0100
Message-ID: <20260112-sonnen-diagramm-ae37279f315f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <176454037897.634289.3566631742434963788@noble.neil.brown.name>
References: <176454037897.634289.3566631742434963788@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363; i=brauner@kernel.org; h=from:subject:message-id; bh=DxZZGzK74wIR5W3ofx2JM6E8wyCgaH8nZoYwWgX+eR8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmHNp3YLliou6j/3Ff/idODOBi2hrnHJFm6HLce0lit usnvUPLO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbStoDhf+ApldVTH+9ump0Q 4sQyPVufZcfFQim/qg0H5pYcsWTsvsPIsItlrpnjleU7v1yNkzy16KEws3jZzJDTbjWb3t+wXH5 wHicA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 01 Dec 2025 09:06:18 +1100, NeilBrown wrote:
> The recent conversion of fuse_reverse_inval_entry() to use
> start_removing() was wrong.
> As Val Packett points out the original code did not call ->lookup
> while the new code does.  This can lead to a deadlock.
> 
> Rather than using full_name_hash() and d_lookup() as the old code
> did, we can use try_lookup_noperm() which combines these.  Then
> the result can be given to start_removing_dentry() to get the required
> locks for removal.  We then double check that the name hasn't
> changed.
> 
> [...]

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

[1/1] fuse: fix conversion of fuse_reverse_inval_entry() to start_removing()
      https://git.kernel.org/vfs/vfs/c/cab012375122

