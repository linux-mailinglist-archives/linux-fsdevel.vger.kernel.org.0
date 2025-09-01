Return-Path: <linux-fsdevel+bounces-59785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2581BB3E111
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C6216214B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9157A310783;
	Mon,  1 Sep 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGYpsjpC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE972FABF9;
	Mon,  1 Sep 2025 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724903; cv=none; b=Dt4ucUmtDIJh1JVUmvqlpGELwV9lu4wiVPqQ/yYgnV/Dh+cg9yTO9dX3uaElVq+KBwyhEq0cdD0PmIgGSRsbWAgkH/dGC6gJTTxskv+u1BhylVcZKbNy0RZOL7eOVNHnZctYRpEUHjz85W0L7RlTOiwn+wJzTvLChXZ7OoeFjmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724903; c=relaxed/simple;
	bh=W6qDZNjnaacEEGY0j9rmXXyYfk5VcyDKi3Z9QiP9Xhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgvUJc9pW+1YqEBdCWEYQfqiVGJRGq/1e/qyb5Kf7MEB0odoJ889nTvWD/63gEdXs4yWGS1MrcqpRXG2/6w6kuuEuCINE5qyI7zPbImXn80hj8xENoDAqIpGH62gZzigUmU2JoxNN5ZqOOeglGyplOLe6HBUQb9puSCPHteOpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGYpsjpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B73C4CEF0;
	Mon,  1 Sep 2025 11:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756724901;
	bh=W6qDZNjnaacEEGY0j9rmXXyYfk5VcyDKi3Z9QiP9Xhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGYpsjpC2WbpM20NXfXBlZHd5NaziYxGL6XeZ4cjn9QHckMgWinYqk6J42KYG/UUF
	 qLeHZstigAAH2/7DHKeF+TCXS5vu9kKQoOWW1DqP117lcivjPLKt9O7wXBcOF1YTCP
	 uoyNtt+G3qTFZCflKfBUoXaR+AOHY8o5xTmwcC7X3SoMLSCWlWVVoYFCswG3GIQclu
	 HclOghTNN9bTrOzz9WroWCQYA9nPw1ptCPvW7ojyAViVnY8eYFO1PXh3TsrR70gsMl
	 V4KN80ChMqZilFgw3CxVaA/x25fMRGZT9t7GGUL9A8QtX4CmHvvpkkKMRLSbfjUIeZ
	 MwNX0BOvP46Sw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: remove vfs_ioctl export
Date: Mon,  1 Sep 2025 13:08:14 +0200
Message-ID: <20250901-rodeln-rennen-b9f48d3e4c76@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025083038-carving-amuck-a4ae@gregkh>
References: <2025083038-carving-amuck-a4ae@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=958; i=brauner@kernel.org; h=from:subject:message-id; bh=W6qDZNjnaacEEGY0j9rmXXyYfk5VcyDKi3Z9QiP9Xhc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRsrVtY3hfm27bFvr7w64dbkT9ObP9g5yH3RlS7ytLZ6 FdDq/zejlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInsWMDI8DF1gXvw+a2P53nK Vz54MTHv1/lL7XlvFTIZD0eXpc7d9pnhn/m8KSZdm8xKHjzlUv2qwB/T22EgfDag4+6+pIb09tY b7AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 30 Aug 2025 12:55:39 +0200, Greg Kroah-Hartman wrote:
> vfs_ioctl() is no longer called by anything outside of fs/ioctl.c, so
> remove the global symbol and export as it is not needed.
> 
> 

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] fs: remove vfs_ioctl export
      https://git.kernel.org/vfs/vfs/c/e5bca063c150

