Return-Path: <linux-fsdevel+bounces-46260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6152A85FCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 15:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A1D174BCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F781F099A;
	Fri, 11 Apr 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7AA+9LZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975441D95B3;
	Fri, 11 Apr 2025 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379916; cv=none; b=kXjOWOsAA6p14HkWyzF8KTI0Eua9S7nIOGyDmAuPAVkkQmqEFrjTsFMMgOyxUmNN9NGooGv4rDn/b22uqOgIOvShw8etYExKac2yEreMzqoxlMFHN3bR60XHWqmZ5Qv5TauCkkijqufGJaiKqkGCfYJF2VkCSQXUBOLS2MzB0X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379916; c=relaxed/simple;
	bh=7jfJLxNz+75TKFJkLMa0WrQoJfMUmvBHFZtXXnypmhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U90kznVs5yxqlJLTxOHqlNUQpOphjHVUk4VsJ4RhkQ7ywK73TTF10WLXBA6d96F+EOsQK6UELEsnBKtrTBQ0K6oK2zgSez2C4DLDzEaAnPbDO9qYaIUlgHQyN3Nux65/9pHdgJED6vxhTLxsEwN9lnzQJSz9JyHfGB7dQWT/dIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7AA+9LZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77D8C4CEE8;
	Fri, 11 Apr 2025 13:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744379916;
	bh=7jfJLxNz+75TKFJkLMa0WrQoJfMUmvBHFZtXXnypmhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R7AA+9LZkh4CR5UFyxNwnROUVOVSoQEhj/xzDw51C/WRCyMqEcJlZ4uDjwx+VdYdd
	 NDWUoMCMuxzDV4+ktxOx+kKxkLNm2R9H6WWjgxkZHN1xD9Q7UU6KodyBZNYgFVzbIW
	 AwEBspmwagxBFURVoVYi+yBZfxsyduS+nQ6SyjcItx/LBjIZ0tY7rjwIEATSDuWFa5
	 CYznPwqYxMW6SPbDxOtSSeTuPF9Gzwz1/f/W8ZMJKJKBu89abxr3bck9D4lN+y54Tk
	 wr4tFUytGDJT5BLSzz3iG1S6BUyKsVnZFXIZ1pnm+fW7mIOJbHBIrEl7pHe45kvuTW
	 +bfgpebs6VYCg==
From: Christian Brauner <brauner@kernel.org>
To: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Song Liu <song@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	dhowells@redhat.com,
	pc@manguebit.com,
	kernel-team@fb.com
Subject: Re: [PATCH v2] netfs: Only create /proc/fs/netfs with CONFIG_PROC_FS
Date: Fri, 11 Apr 2025 15:58:29 +0200
Message-ID: <20250411-mixen-pelzmantel-b93173535d83@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250409170015.2651829-1-song@kernel.org>
References: <20250409170015.2651829-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=brauner@kernel.org; h=from:subject:message-id; bh=7jfJLxNz+75TKFJkLMa0WrQoJfMUmvBHFZtXXnypmhg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/VGArT//8lvFl9C8Gj5bfl/zn/vl38zVH2FL9trlv5 pzdk5pf31HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRthKG/+7xzSxH/pj4zX+9 ac1raTf/B4va1u/1ePLxxQPGKwLCJ34x/I/YerA+9suufbe2z7oWYbZLc/7j9ulFlbs44/7pft2 ju4YPAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 09 Apr 2025 10:00:15 -0700, Song Liu wrote:
> When testing a special config:
> 
> CONFIG_NETFS_SUPPORTS=y
> CONFIG_PROC_FS=n
> 
> The system crashes with something like:
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

[1/1] netfs: Only create /proc/fs/netfs with CONFIG_PROC_FS
      https://git.kernel.org/vfs/vfs/c/40cb48eba3b4

