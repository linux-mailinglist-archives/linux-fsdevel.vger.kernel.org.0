Return-Path: <linux-fsdevel+bounces-39052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F1BA0BBBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 16:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FF03A27E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5981C3034;
	Mon, 13 Jan 2025 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtD06kRj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2C24025E
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781882; cv=none; b=k61KOSTdynwk7miAvE1irRjOmH/4bY2uKMX53LHhd7Cu874gp3YWY4tOxbSDhIAL+oCDX5UIwQyp/kH5BKQaoxPZ81/csABsGotpo8YYuZWcea5M+yrm1rihDggBo4QtD8qfQmhrg0IhgaJHnyGvXvpYm0furpfzKyp6e7CEbo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781882; c=relaxed/simple;
	bh=vthFnwXoa+f2qz76huP0+IT9Wx38kE91PY5hnXToedc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKPzTzUStWDSG0H1hIxVlDMoPY98+/2QJe8rlCtm2y0bqUrxC0Q248euo/sD/qI5RjVC6yOTE31i1Z5fF4THJa6U76lVAwHMpdC5N9foThXpLmrl6WkTfg7N3H/5ZzfysRvPyfu+WhFMbbg6tihMhRTs3j25W0UMH3dLDL5e4PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtD06kRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C397FC4CEE2;
	Mon, 13 Jan 2025 15:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736781881;
	bh=vthFnwXoa+f2qz76huP0+IT9Wx38kE91PY5hnXToedc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qtD06kRjaOgbS+6b9wlOaP+Xnvbyk872R9j7JB7ebI+vvvwV/DoYr2hNxdfhjBQFV
	 wE56qjjI6E1j53odFnW8oTp/so0hhF3hH38vn7qXidxDxb7XB7AQGuFGmnE+jj8w+F
	 S0q4z8KEsv4kpRFibJZfkpk+b73jGhgUxmLzANuvX6R+yudhpP1c9cVdTPst7ZzHMx
	 0OEQ0zmvo9zqp4EZEsd/6gEHBqd1kK5XbKkskk8kI61FE7Y936GlqMPptN3sJId2QU
	 VwgeE8RqYEbc5snG2/zaBrCmZKl2Dz5oISCJaBTNB1Le8XSja/NkYYUf/G0RQmgDr0
	 UPZ1g7hlOOekg==
From: Christian Brauner <brauner@kernel.org>
To: Sentaro Onizuka <sentaro@amazon.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Fix return type of do_mount() from long to int
Date: Mon, 13 Jan 2025 16:24:30 +0100
Message-ID: <20250113-sehnsucht-denkweise-ab349537f9f8@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250113151400.55512-1-sentaro@amazon.com>
References: <20250113151400.55512-1-sentaro@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1266; i=brauner@kernel.org; h=from:subject:message-id; bh=vthFnwXoa+f2qz76huP0+IT9Wx38kE91PY5hnXToedc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS3GhjbBelqHAxflrhf1vSG3ynrnHNtfCIbhApUby2NK 3OsOtzRUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJFVcgz/g7+2KNxluLxfs2zp ngeHnmyc+GxFMqOz7QulpFLVkN95HQz/E9f8rDnJsTyXaV7URPlP79afs3x31NQ64EdkH/fLtbs 7OAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 14 Jan 2025 00:14:00 +0900, Sentaro Onizuka wrote:
> Fix the return type of do_mount() function from long to int to match its ac
> tual behavior. The function only returns int values, and all callers, inclu
> ding those in fs/namespace.c and arch/alpha/kernel/osf_sys.c, already treat
>  the return value as int. This change improves type consistency across the
> filesystem code and aligns the function signature with its existing impleme
> ntation and usage.
> 
> [...]

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[1/1] fs: Fix return type of do_mount() from long to int
      https://git.kernel.org/vfs/vfs/c/cd1db3448474

