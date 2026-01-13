Return-Path: <linux-fsdevel+bounces-73391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3DED17692
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F18543014107
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E104837FF58;
	Tue, 13 Jan 2026 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Egi3ZcXO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525234F46A;
	Tue, 13 Jan 2026 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294548; cv=none; b=X+eyHT84e1tPPmW1bGMCDB37+fIKYMOYf2LSIPplI84n8oPH5kiwVCpCVUYGUQydmX39KJ3Ng0ZUvX3QpwA6xr1g/+3kQqnkA+LcIz9ldePqfKxe8G0G+0fJyasIbG5+IR+XYrMVDCZ+qRW1djKW8vCNIibVn0V2oxhFAnmccKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294548; c=relaxed/simple;
	bh=ubIhtxc62kKOv47py1OSCr6R0E+GPYcmvbbOhenHNk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/BxuE69YmLyT5JchbREx8O1553XveWXA6Q+yn+pfoVqE9xzz17thWxn3KwUaXRFqwVN1IgpOe6WSpyxHAgPFcRTHQUhl9hRs7PhaNjck5jwCkUyMQXy+N7iNMLrCMFGV7pihQyuWojzunySxzlgZVpIi/63MzOjrW98lSYPr0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Egi3ZcXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E160C116C6;
	Tue, 13 Jan 2026 08:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768294547;
	bh=ubIhtxc62kKOv47py1OSCr6R0E+GPYcmvbbOhenHNk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Egi3ZcXOJpN/67vkVi+92EY0A07vDeQuTF2uPoRHKdKUXMaMEuBhFmxbAR1VcrVMl
	 gHX8HvXPCVSAgMAZowLRp6a96rEL/KSfqjOP/5Ed1yWbNoSikzFyNxbidy457K0iPh
	 eI2jOQeqAN8mQByUPfZG9A2C2x/vEjijIUHR3t3cXnWtQdoAa3WOpOkU8h2cCpVQkn
	 M5zTHekE7ZyIVo2BLJwqCUqk/n27k9r5ilhyyG+lQF8Ne1W7nDCloBLsUeXN1iWftN
	 EpLAjE1DqJ4iHf9iLbmBFzO5/jVTWWq739zAK1Px4+ihRxS1pxu5irF6kYyQAuRoBx
	 MyZCu4yHTLcNQ==
From: Christian Brauner <brauner@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	slava@dubeyko.com,
	syzbot <syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com>,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [PATCH v3] hfsplus: pretend special inodes as regular files
Date: Tue, 13 Jan 2026 09:55:33 +0100
Message-ID: <20260113-lecken-belichtet-d10ec1dfccc3@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <da5dde25-e54e-42a4-8ce6-fa74973895c5@I-love.SAKURA.ne.jp>
References: <da5dde25-e54e-42a4-8ce6-fa74973895c5@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040; i=brauner@kernel.org; h=from:subject:message-id; bh=ubIhtxc62kKOv47py1OSCr6R0E+GPYcmvbbOhenHNk4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmcfRuzZltcnNrQ2KdjtOFefznbpiFXVio7RGzOnDu4 tC+oyEsHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJeszw35X53Ms4CZuFK2IN Zs19+PRv4HL1k/0mBa4qJ94v3GG/lYGRYfm72JaoqXn12f5GEyb55z/OWjh/o8eNztPRO/Uuied zcQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 12 Jan 2026 18:39:23 +0900, Tetsuo Handa wrote:
> Since commit af153bb63a33 ("vfs: catch invalid modes in may_open()")
> requires any inode be one of S_IFDIR/S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/
> S_IFIFO/S_IFSOCK type, use S_IFREG for special inodes.
> 
> 

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] hfsplus: pretend special inodes as regular files
      https://git.kernel.org/vfs/vfs/c/68186fa198f1

