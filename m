Return-Path: <linux-fsdevel+bounces-21528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 955C590523C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 14:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE311F21EC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 12:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3D116F84E;
	Wed, 12 Jun 2024 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZyReB3q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D367216F28F;
	Wed, 12 Jun 2024 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194649; cv=none; b=LihkEOpzhWrI9y5xoxKNy7lawpkQNxTH3VoZaOUXDq25tvS0b7N+dcmMdgjGVaBsSPL5fEy9+ezrfhmRMWR+uunQeAVVgkG5dmMjKWubUFSHEClhbklsnQ1/KNbxmVI5ocBW6Spu9IaXZeqQdxPLIDFhagAMDrlRRzRtJr5J2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194649; c=relaxed/simple;
	bh=xEZhoVghiD4MH1Y9FepPtZMXniLWLXIG9q/MjDeoGZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxqqnmEFZXyCbP5AKqnUJV2BlIaUXwOfRAG6bqsQMgvUStD1u8YlG3vbX0CheMlr1rTbRmGD03gfqcAE7Lsi5+UEh/WVxgbN+vLVvMY6kpLjR+D9Odf0OazStCWnsIDKXbGlsE3UucdDmlas85q+/RKBHL9DdeFeMecTZliL04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZyReB3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E577C3277B;
	Wed, 12 Jun 2024 12:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718194648;
	bh=xEZhoVghiD4MH1Y9FepPtZMXniLWLXIG9q/MjDeoGZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CZyReB3qwQXWHs1+oOyB2WXLb/ZstQbO/W1VkzOWQsJLgS/GuaMPFL4Wx3ewbZ4md
	 LXbHilcnlUfNxBpAYcni8ixfllfUMg2QH2LBatg1HMzTvfZECY4SgZyvIO+N3T8Tsu
	 KGmkJkYZJaapoCSSbqKaCr0+SQNXaMYCm0fjMVLjZY6AF8B47JEqDLmzIKhAjOYcnS
	 GIcVVMTzGgGBjJcwWve3gBuJoNTucXXgwu9WleuO66eHb/+DK5e9wKbRJPC3xj8Jg1
	 p9HaPNFKk7+cdKpn4VP9MjOhqnZGDmtSE8mrqo/nJCJ+2rnNeh48TsLefN4LO+UB1z
	 seGfSDWUfWSAw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	kent.overstreet@linux.dev,
	linux-xfs@vger.kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v2 0/4] inode_init_always zeroing i_state
Date: Wed, 12 Jun 2024 14:17:20 +0200
Message-ID: <20240612-mithelfen-kursziel-780e238b5243@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611120626.513952-1-mjguzik@gmail.com>
References: <20240611120626.513952-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1749; i=brauner@kernel.org; h=from:subject:message-id; bh=xEZhoVghiD4MH1Y9FepPtZMXniLWLXIG9q/MjDeoGZQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRlTryoNjvlw9vzXoZPb7bku+7TWn5nhzw7h01A6u+j7 DVsGWt/dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk5QYjw77IJr1CtXa5aocb TwM2hB4TttqgZ2g5beWhog3fZb5I/GZkaPll8j9vU6yt1p+Yy4Yf5vz382BxPDBl3vP0o+qT1+5 U5gEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 11 Jun 2024 14:06:22 +0200, Mateusz Guzik wrote:
> As requested by Jan this is a 4-part series.
> 
> I diffed this against fs-next + my inode hash patch v3 as it adds one
> i_state = 0 case. Should that hash thing not be accepted this bit is
> trivially droppable from the patch.
> 
> Mateusz Guzik (4):
>   xfs: preserve i_state around inode_init_always in xfs_reinit_inode
>   vfs: partially sanitize i_state zeroing on inode creation
>   xfs: remove now spurious i_state initialization in xfs_inode_alloc
>   bcachefs: remove now spurious i_state initialization
> 
> [...]

Applied to the vfs.inode.rcu branch of the vfs/vfs.git tree.
Patches in the vfs.inode.rcu branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.inode.rcu

[1/4] xfs: preserve i_state around inode_init_always in xfs_reinit_inode
      https://git.kernel.org/vfs/vfs/c/f6f496712632
[2/4] vfs: partially sanitize i_state zeroing on inode creation
      https://git.kernel.org/vfs/vfs/c/1fddfb5628e4
[3/4] xfs: remove now spurious i_state initialization in xfs_inode_alloc
      https://git.kernel.org/vfs/vfs/c/c0a6bf1d02d8
[4/4] bcachefs: remove now spurious i_state initialization
      https://git.kernel.org/vfs/vfs/c/9ed6c60e6053

