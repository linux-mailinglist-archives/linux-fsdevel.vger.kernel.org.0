Return-Path: <linux-fsdevel+bounces-39662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6012A16B6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 12:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D979B3A9603
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 11:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9B31DEFFE;
	Mon, 20 Jan 2025 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acN/9nqd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0E91B4146
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372057; cv=none; b=abx55EoY1NEJOn+2vqqTorvdn2whqHwHB1Hvb7dCv3kvQrDqNUAFUamjjDvHnfBfoefukK0eSvgGoWGf/R1xV9Eu0DsFon26Qg6z79A7dfbjVVn4HCYxT62/EOj4JBE5mn0kWEd0eR0kLJ04ea4HmuH3S9zyFqgeYQeXoPS0IG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372057; c=relaxed/simple;
	bh=sioYk2o8L4G8cGA9D2oIyP98paPQd0TRqL7hMt/dRpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntxE/SOEmcurCPzWu3Inx7LcGPkKsDMU7+9L+Iijvngp/ltRyxz8UG3YRUeNYlK49bJyG5IQvm57d8+Ia70OmkwhbzFUOXX0JesKJnK8bV6ljQo54PklTPICuh29Ru8iuXZljVPKL1wNHUPzIg65Nij43a3xvY3NT2BbmnvBsZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acN/9nqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702B8C4CEE0;
	Mon, 20 Jan 2025 11:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737372056;
	bh=sioYk2o8L4G8cGA9D2oIyP98paPQd0TRqL7hMt/dRpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=acN/9nqdxH7YV8Q+Fm3xfF7bW9E6FIumzPiBiFk+A1svJI4FDNYj1Ruw4Q0P0f4Gn
	 hq334XzWWBh6R3WdilG61uAgxQrqsyhzhfsw5SWwBBtkvmOonldjzVxC8zlKnkegOw
	 3QTWt+2OHVjCUnUhdhNHwDzKWPQcapSZlZ9g25Oe9cTiXYYdESJNWaldTea7ZG07/z
	 DsmR+dlSxW2+Zbq/aICsVB26Tgw4Mmihg7H75NDMZ4pNNGZUkWlcE6CnGwDtHJ74xK
	 iOst5QI8aJG2fG7mBfbd5mOtkSBDXR307A04XwqjJgcV4PC3ankf+vkoTeiZFn6O/d
	 mxTewf1hQNVqw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH][RFC] make use of anon_inode_getfile_fmode()
Date: Mon, 20 Jan 2025 12:20:44 +0100
Message-ID: <20250120-einlud-waldlauf-772d7f346a00@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250118014434.GT1977892@ZenIV>
References: <20250118014434.GT1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1024; i=brauner@kernel.org; h=from:subject:message-id; bh=sioYk2o8L4G8cGA9D2oIyP98paPQd0TRqL7hMt/dRpE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT3GU6yvTvN/7TY8+zj34NPTkr/saTdaNrdxNY/5+MYn 9cxGr+w7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIhiojw7ucH09PvmObZWUq UT037lXF3u8pT/9c4GTYcmD74foF7lcY/gdteJS3O7TlpJJl+cKTuttORvKZ1+tVdCcVv3inf4T Lmx8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 18 Jan 2025 01:44:34 +0000, Al Viro wrote:
> ["fallen through the cracks" misc stuff]
> 
> A bunch of anon_inode_getfile() callers follow it with adjusting
> ->f_mode; we have a helper doing that now, so let's make use
> of it.
> 
> 
> [...]

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] make use of anon_inode_getfile_fmode()
      https://git.kernel.org/vfs/vfs/c/2f4cccd32a0d

