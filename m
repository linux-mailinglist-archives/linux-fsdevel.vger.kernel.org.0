Return-Path: <linux-fsdevel+bounces-72051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE688CDC405
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 13:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E668630777BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E897F3375DC;
	Wed, 24 Dec 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4DX+RWw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CFF336EC0;
	Wed, 24 Dec 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766579541; cv=none; b=q0fjoYdJz2Ox6EV3HiyGOvdNzb6lvoDBCjFqiZQXX+XyFsbTCTBttFm3kVbaRmgfCXnobJuPFXEXCLSlbi360/+HGZe+CNfgI+h+x646HBNu+nyalixZJxGWRxlofgxzvi8TpMbK2vS0MaU/FkDU7iAAN3wrscSO9kvAEnP4KF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766579541; c=relaxed/simple;
	bh=1IJIqelldDL1bCCmgph7G45ztJGB2Oe0IAskJUdNTe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bf0+tZl62ThfBaIRPbxDUOhTGJbz7hi/aQQOT39Pnvuk3V/AROtr1ZCw2xQN56PWySsI3fWCRHK7dFdHqxWaaP8YKN28V9cWRYy6LmdnAqY6tlbHqMuhwv4xYgO81piMw15FW16M4AlTGGbPsUqTH7YQB/mT+TBRQUzlktcZJkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4DX+RWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3098FC4CEFB;
	Wed, 24 Dec 2025 12:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766579540;
	bh=1IJIqelldDL1bCCmgph7G45ztJGB2Oe0IAskJUdNTe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U4DX+RWwy2DNdBR2Vk3/ledHYYb3hYkjyt/G8mO0jPuvEzmLrBzbs48fv4+adAN6P
	 vil37aJET58mniS2km+9u3Fh+oeAH+icxs8DG1FrBIsXfRLcfiH+KXyIjsMoJ6iAjy
	 P7keg1C2894YtlNqgl5U7guKlM79f3Md3ZNANpCfsiZuGQO5UVRNnUo/qCqZJ7Q+K3
	 NYSvNH0omczx5K+5mtIR16CT0SwLcc1xn7QXisIaXVlx7mPcSHGQKpsPLHsVbsouA1
	 J+1s4xHJihvgkMJQuCyNp07NtVUZN5A56oTk4YMcHrDVClwJwM2BkxpI4Qd9PsBsP8
	 tsvv8mesLiplQ==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	clm@meta.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3] fs: make sure to fail try_to_unlazy() and try_to_unlazy() for LOOKUP_CACHED
Date: Wed, 24 Dec 2025 13:32:10 +0100
Message-ID: <20251224-zunichte-hautnah-57728a08cb13@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251220054023.142134-1-mjguzik@gmail.com>
References: <20251220054023.142134-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=brauner@kernel.org; h=from:subject:message-id; bh=1IJIqelldDL1bCCmgph7G45ztJGB2Oe0IAskJUdNTe4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR63w0ILw1Imnf86a/wY97RE27tYlUTFd1W/vf2Ft8lz o43T0zx6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIv0ZGhlcTc2dO+LJa9vT9 7X3hKeskRKddCm/bb33+05o1US7R038x/GZtZJkbGn1VcJlhLWfPCr/rqcE5jAsXXlYzl9lgezQ kgg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 20 Dec 2025 06:40:22 +0100, Mateusz Guzik wrote:
> Otherwise the slowpath can be taken by the caller, defeating the flag.
> 
> This regressed after calls to legitimize_links() started being
> conditionally elided and stems from the routine always failing
> after seeing the flag, regardless if there were any links.
> 
> In order to address both the bug and the weird semantics make it illegal
> to call legitimize_links() with LOOKUP_CACHED and handle the problem at
> the two callsites.
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

[1/1] fs: make sure to fail try_to_unlazy() and try_to_unlazy() for LOOKUP_CACHED
      https://git.kernel.org/vfs/vfs/c/46af9ae1305f

