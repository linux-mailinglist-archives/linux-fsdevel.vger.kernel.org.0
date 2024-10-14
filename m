Return-Path: <linux-fsdevel+bounces-31898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AE899CF80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 16:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3FE1F21D28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 14:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C441AE876;
	Mon, 14 Oct 2024 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVAcsYcR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC21ABEA1;
	Mon, 14 Oct 2024 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917547; cv=none; b=Yc0a2P/pYkCOR90LrP3j084FT/fPdbdt6jMuSyB4D3wF0lt5FlU0djRpS2JihhugymLpJV5hrK5KE9s2zBA4x/mVXnn6PmF6v9rKe8Hk+5pf28innIWER1ytvZpMTjIHLTcbYp2aujK4om65QENrJr9ecDMo1klV+KeJSl8vRZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917547; c=relaxed/simple;
	bh=b3J/8+uVKd506+tG92/OScywiPp2zfEA7v8OVWRBegs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9CzS56hcqY7HULsgrfYhc2ztxcFTlpPf51sFm2rd5HC1tM4j0KGq6Sw7L0PFTvBU3ADjXRuQMNzToKP6tKsr7PcWGAnxfyCf3GXBvQCPjHkjQSPWD5bgR3AhPt0A5eaYtRlqE+g2znX+UllbLnWRg430RXIWRKNHYFghPGI4qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVAcsYcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B78C4CEC7;
	Mon, 14 Oct 2024 14:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728917546;
	bh=b3J/8+uVKd506+tG92/OScywiPp2zfEA7v8OVWRBegs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FVAcsYcRTYfTmhs2BJXaqsfU4v5XkfeUN5LmuW/+bjREGILdIYk8K4nnrqX9CFYeN
	 8XgSS6FGVWZXhOsjpcVa+HdMXgWFzhOZbVRuDPEocduL/vQ2Sp16yiE1QXY/Ey0ckP
	 SuNjqLV3MIxkOiNVH73UA6B1foRBKJk4YdPAcmS9f2MM0osu6iU9MGJr6KcM+SzBOS
	 yS3unmmYKD9g81DNbCRHdlviGnhwN/H/n/Melv3xmAH7HkaO9jun2Rz5hyTpncoyoa
	 NE3Awd3/hT3RbOe1HrlV8fGSmPfHqwzYN8DFeshaY5AlmfJ/7VKSkr+8bMQzfPdjgX
	 b5bBG/ru7U5SA==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 0/3] API for exporting connectable file handles to userspace
Date: Mon, 14 Oct 2024 16:52:19 +0200
Message-ID: <20241014-loswerden-schrubben-3104ed04e382@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241011090023.655623-1-amir73il@gmail.com>
References: <20241011090023.655623-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1299; i=brauner@kernel.org; h=from:subject:message-id; bh=b3J/8+uVKd506+tG92/OScywiPp2zfEA7v8OVWRBegs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTzGqjI9V2ZNb/y34yjEbbSW/6dTOleeK94SmCvz+K8b 494mdb+7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI4ZuMDBN/MJiFnf8de0n3 86qCXnYWgS0Lnl3/ZibMdXQR87LdXx8y/E9Sufun+LVI2d67nddmtkhXcB4L61itLpTM9YDl1v9 T+7gB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 11 Oct 2024 11:00:20 +0200, Amir Goldstein wrote:
> Christian,
> 
> These patches bring the NFS connectable file handles feature to
> userspace servers.
> 
> They rely on your and Aleksa's changes recently merged to v6.12.
> 
> [...]

Applied to the vfs.exportfs branch of the vfs/vfs.git tree.
Patches in the vfs.exportfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.exportfs

[1/3] fs: prepare for "explicit connectable" file handles
      https://git.kernel.org/vfs/vfs/c/7f0e6b304c6c
[2/3] fs: name_to_handle_at() support for "explicit connectable" file handles
      https://git.kernel.org/vfs/vfs/c/4142418cafc9
[3/3] fs: open_by_handle_at() support for decoding "explicit connectable" file handles
      https://git.kernel.org/vfs/vfs/c/81667fcf9b82

