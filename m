Return-Path: <linux-fsdevel+bounces-22295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4E491608D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71BB1F24102
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 08:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC761474A3;
	Tue, 25 Jun 2024 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVb1Vx58"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C7E2572;
	Tue, 25 Jun 2024 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719302398; cv=none; b=RnJ5/mE6cq3IVZX3+oA15eseV5IF2VGfGDu6q/lCGAtyiT6Ktm0YVF673gGJn2BYurPTcm9s9C9qyy4AVyrhTD3IyegeY86H2Q5JXqMnowJII9pUCzcJeOVcwMRifhwe2Oo+66hsNWjNpLAwL46wHtDaVrJ/GYijIg6GJ3QKYn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719302398; c=relaxed/simple;
	bh=gGTnt7kgAHESvN4glUsKEh7J/3FnyXZoYJL56AfR++E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8+oqLtyqYree91ubHID3pVgcCVsMQbeqOSKd1N0K3q2kOgjW+Tg85qyuJsp4O2oSbYbgds5UeKSOGIITswozRm692z5wdV/T2Pce2cGd+QS5WubK3KiW/9DgSxtE0618NMtWVPcRC0L+ULLB+Ku3IiuC6sXvldjL3pVSMVTWIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVb1Vx58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D23C32781;
	Tue, 25 Jun 2024 07:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719302398;
	bh=gGTnt7kgAHESvN4glUsKEh7J/3FnyXZoYJL56AfR++E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVb1Vx58zF4krIFHUGyBD+f8i41UaW7TUHJKtf4NeF3c242pn4AIyeWtx2j4EEvwl
	 pPiBzTzUeYDEXxSg+N67eW1p0rKYTPatEHH+5i18cWzvWLyi6c3IdgIWO0zD1q/29W
	 cFcn7cFQdTzmQHXNN/VcekgWUn3whA2LEjGMkLtNeMh+jLnQS/fjVs89gE213vbh6l
	 sSQ5+F99BXfYu2/9e7gCLy/JZoFBqCO3cTgQOiBuRnANFWQ2eMik+s4FsCqnhMLhvc
	 aq7a9NX6l0N7w//U12COhQCg/0+Vkh1Dq6oDDW0IoOpGQecKzKy98H4yuuIZAQAPR0
	 M1fYBD9HPR/hA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH v2] vfs: remove redundant smp_mb for thp handling in do_dentry_open
Date: Tue, 25 Jun 2024 09:59:50 +0200
Message-ID: <20240625-freut-geometrie-f11b610f94f0@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624085402.493630-1-mjguzik@gmail.com>
References: <20240624085402.493630-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026; i=brauner@kernel.org; h=from:subject:message-id; bh=gGTnt7kgAHESvN4glUsKEh7J/3FnyXZoYJL56AfR++E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRVVXzzT/8pZqK+6aWrtVr/6fti3VZvQ3xWuU9+cf3m2 hV/03ed7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI8QqG/yk+hwp+auxwv590 9B/nwb7P21w5NX/4H+z6uM4h+cT3TZKMDPdP7T+6WddxYujic4Z7P9UE3m0/EqL3X23blKyL911 +X2QHAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 24 Jun 2024 10:54:02 +0200, Mateusz Guzik wrote:
> opening for write performs:
> 
> if (f->f_mode & FMODE_WRITE) {
> [snip]
>         smp_mb();
>         if (filemap_nr_thps(inode->i_mapping)) {
> [snip]
>         }
> }
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] vfs: remove redundant smp_mb for thp handling in do_dentry_open
      https://git.kernel.org/vfs/vfs/c/badb54d62002

