Return-Path: <linux-fsdevel+bounces-70638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7D6CA2FB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 10:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E58EE30DE07C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 09:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9997E33CE86;
	Thu,  4 Dec 2025 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frBWDxOg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CCE33C53B;
	Thu,  4 Dec 2025 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764839656; cv=none; b=ZjN2D9jxfQXN+Bow3ASPtfHDinQ4pEcBlEj0EogjXE9SZkLdYLxmqAlhIkoD1koIdO9IRJgB4EkCfj2NGN8XuEtVXwwkrywkiH15eIsgwgOlAKpEe/O1PxOIBxNE1JxZnCOESxwwxPoy0ph7hNg2dJ0vGLd5thynouk6p6gD2Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764839656; c=relaxed/simple;
	bh=VzGRR37z9Ga1SI//Dd/SRF1/jUD2isMWsHLrXWvMWos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ss+Nq9qhdUbCBkyffE0RN/7KD6Hr6OBKGKhjTECX6W6RsNJVwMGF+pDNHTNNRnxQ4oHMbaITaBx9kyXsaReWglJ3c69pFaM5fHZ/wurjVuei0lt6VYMLbpUJoYiHtHjANGxCe5OiitbTsS9o/3CjZ34AMWPGlhRBzLxnv7Fbnw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frBWDxOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1304C116C6;
	Thu,  4 Dec 2025 09:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764839655;
	bh=VzGRR37z9Ga1SI//Dd/SRF1/jUD2isMWsHLrXWvMWos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=frBWDxOgiw05dnow+w06x+Hrv1F7i/zKRKxxXnFoP0kPJdKxP8yRg69y6iJTH5ArD
	 38S2Sv5bGxXz3qVvKhA3q6EMJHQN1er3P+eTH0i5ZqFlm5FqU5IAcxQzFEs5JGjC5A
	 uI06H1lHQC1IUe2PjfzUVQ/SrzCL+XRH9NmzCe2c/+IQF6BBtNWSNqI6dBym8uUeW7
	 ID9qHRkmPfdGNhAzp9LP4kvEwBaXPFpqonDjUO5wFsO5jEryuA+KwFIljQvCGim18d
	 ZpcuZOiTTC7NBSafpc9wI02SevhlwUBTCPj/VIdLR1YNPMGeuKBVnDTxaIS0JhZ+Bx
	 0M/aMV/we9baw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v4 1/2] filelock: use a consume fence in locks_inode_context()
Date: Thu,  4 Dec 2025 10:14:09 +0100
Message-ID: <20251204-flurbeleuchtung-lager-7960aaee15c1@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203094837.290654-1-mjguzik@gmail.com>
References: <20251203094837.290654-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=brauner@kernel.org; h=from:subject:message-id; bh=VzGRR37z9Ga1SI//Dd/SRF1/jUD2isMWsHLrXWvMWos=; b=kA0DAAoWkcYbwGV43KIByyZiAGkxUOKjcGudXoAI1m6MAOJBlYtu071qkOw4URWU3EXNFkWyG Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmkxUOIACgkQkcYbwGV43KJ+6AEAlfK6 HqytTsy4dMirPF1PqVCk857hatYe5Ty9kG9qnyEBAL3olpnG6M6llknDLvOIcTYgPWQrJ0jgi5J Y7SU0tdEP
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 03 Dec 2025 10:48:36 +0100, Mateusz Guzik wrote:
> Matches the idiom of storing a pointer with a release fence and safely
> getting the content with a consume fence after.
> 
> Eliminates an actual fence on some archs.
> 
> 

Applied to the vfs-6.20.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.20.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.20.misc

[1/2] filelock: use a consume fence in locks_inode_context()
      https://git.kernel.org/vfs/vfs/c/dc6f30a29da7
[2/2] fs: track the inode having file locks with a flag in ->i_opflags
      https://git.kernel.org/vfs/vfs/c/26193099d06f

