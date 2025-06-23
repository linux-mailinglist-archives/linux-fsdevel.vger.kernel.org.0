Return-Path: <linux-fsdevel+bounces-52519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0DBAE3CF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42951898241
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E1824BBEB;
	Mon, 23 Jun 2025 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBgxPFn0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB323A566;
	Mon, 23 Jun 2025 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675001; cv=none; b=OhLDQE/POPqH0qebQRXvUuZnQ0H9jR8QY26cj2paZNQeWwUtOS2r+T69vhvZ0jtDANBVsbkU4K3DGeWlc53U2Dbk1btWHueiRKZdWrWFK5M78exgjJOwXdHMDaL+dWaSNbE7JljiiMaQ0eHBJM31Y5ne6WIg6NMdCEGa8Qv3kdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675001; c=relaxed/simple;
	bh=w6pvwl3k5rkevGAqH21SXhWyXflGQudzwBjIPtzZN6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GiBvzuVL61ayfK4SyQNsXkfpJs8Z655DEC9HT2qg1aj5/xRQe0t862mvoMe/LzmIgtp2uvlwZ+nLfIa56R+uggKm7I95+PGNPifuV0L1xW62eter2PDcJXeqYurWZwrggDdowUpRxaxd4QQ5y7XRwiZafjUzscLKP1jVrSBt3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBgxPFn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30500C4CEF0;
	Mon, 23 Jun 2025 10:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750675000;
	bh=w6pvwl3k5rkevGAqH21SXhWyXflGQudzwBjIPtzZN6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBgxPFn0/oyWnNb5RevlYjEc+qF7N56LGvRp2mZMyHftFyNppP9S46UucePgr7tME
	 rO3GIyLefgNv1z2uj/X0TxXVfWW6meqEfa4VYzi0A2v21Z0CGKAuJ1xLWyRF3NDSn9
	 rwA9Ha9E2gH83p3gh+sBR/p4UTlxcI8z40JWmSnvbT+vyG5hh9kHwAmN/6HdgjZL1M
	 yhx2slsO80w9eZ8QaLSch1VAMv+gFvTnOMyr8uKNkOMKQF2OoQ0QD0OfQnjirExUpe
	 Z0Y4KCKsbnaYIvbWZlsjS97hdDLEho8wU00tYAd7gjUiw5HunxTFAOLsa+kWM0yY2a
	 7CeTjMm8wfCLw==
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jan Kara <jack@suse.cz>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Jann Horn <jannh@google.com>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Roman Kisel <romank@linux.microsoft.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] coredump: reduce stack usage in vfs_coredump()
Date: Mon, 23 Jun 2025 12:36:23 +0200
Message-ID: <20250623-handschuhe-insgeheim-3a47bbb06367@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250620112105.3396149-1-arnd@kernel.org>
References: <20250620112105.3396149-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; i=brauner@kernel.org; h=from:subject:message-id; bh=w6pvwl3k5rkevGAqH21SXhWyXflGQudzwBjIPtzZN6c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRE6hnufaF8z0Y+eMecWwXLm0+IHvbIMWHeXFARdOQw8 5R3mflxHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5cJSRoWvpactyJskzixT8 Furx8vN7s6SXTuHpmM+Rf7lealHSR4b/mTGZSSdCPz9rXHU+yabh8PEvbvva7V5KL2IsfuHFppX LDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 20 Jun 2025 13:21:01 +0200, Arnd Bergmann wrote:
> The newly added socket coredump code runs into some corner cases
> with KASAN that end up needing a lot of stack space:
> 
> fs/coredump.c:1206:1: error: the frame size of 1680 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]
> 
> Mark the socket helper function as noinline_for_stack so its stack
> usage does not leak out to the other code paths. This also seems to
> help with register pressure, and the resulting combined stack usage of
> vfs_coredump() and coredump_socket() is actually lower than the inlined
> version.
> 
> [...]

Applied to the vfs-6.17.coredump branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.coredump branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.coredump

[1/1] coredump: reduce stack usage in vfs_coredump()
      https://git.kernel.org/vfs/vfs/c/fb82645d3f72

