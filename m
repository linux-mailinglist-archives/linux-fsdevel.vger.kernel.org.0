Return-Path: <linux-fsdevel+bounces-24294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DA393CE8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 09:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22C61F24536
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 07:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AF6176AB3;
	Fri, 26 Jul 2024 07:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jpda7qNz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A44176AA3;
	Fri, 26 Jul 2024 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721977781; cv=none; b=HQ4wZcgrUxkOzXF1BBKZvopVURcZp1qJDLlyKSwlR9TgOVWj7s7z6tIkp9cDvtyRmIqVC2cV06qO3zBagE/DrJ3AAQGhLklqghkFMAqSyQJQZesuI/6OYeXoTh03xZ7c5GLzCnaU2dRX7kVxRT0TUkGYqWdfHfEkActhqEAYSyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721977781; c=relaxed/simple;
	bh=kOk8RQ7+QZDSJa5zRJm434yR0H1nS6n8GbHjIO96/A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCVK4ira82vLKwUUYmWfaWU6Y5GFAsX+a2FCzA70LANVFhu6rUiH2jOheKoeMQMzmJZPh8UtQNYw7jj9bigolDw0Bc13lWhQ5sjN9K7RL+1bH1xTWz/9wvrFf1mEXFg2UPG+3Y6+ocsdt61xUWFV4ybiEU6SjZCNS2dcdwtGi3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jpda7qNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51789C32782;
	Fri, 26 Jul 2024 07:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721977780;
	bh=kOk8RQ7+QZDSJa5zRJm434yR0H1nS6n8GbHjIO96/A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jpda7qNzReze9z57zf1WjTTQPcIszDaefHruQPpBSAbXUEuBwHv52MMzG7UVRHudQ
	 6usrWFGR+U5hHdEnWd61Qk9sZJ6tTLHWzlwe1ob7aDI8ajJ2KnxzDQ3wzNPpbTAw77
	 V08TxDtDhzUfjX4oAZYWtvW5JUHqfEeJkVfvmFGeROoPISLBcpNezLdUfLZGZ9OppX
	 qmcMkVaWm/b9AX9/ZUn5bLetviTwZP2uEAup/DwwtnsBp9+igheqpktaNOze0cwrh3
	 T+nz7vEsJfKcaa7asTX1aMuj2jn8Hp8fJJ2+FRqbKf4GgkAEM/1Gi4TixsUfOMbj/H
	 F3g8JMN4kWrjQ==
From: Christian Brauner <brauner@kernel.org>
To: jack@suse.cz,
	Haifeng Xu <haifeng.xu@shopee.com>
Cc: Christian Brauner <brauner@kernel.org>,
	axboe@kernel.dk,
	tj@kernel.org,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: don't flush in-flight wb switches for superblocks without cgroup writeback
Date: Fri, 26 Jul 2024 09:09:26 +0200
Message-ID: <20240726-ermuntern-seeblick-5a1add765522@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240726030525.180330-1-haifeng.xu@shopee.com>
References: <20240725084232.bj7apjqqowae575c@quack3> <20240726030525.180330-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1351; i=brauner@kernel.org; h=from:subject:message-id; bh=kOk8RQ7+QZDSJa5zRJm434yR0H1nS6n8GbHjIO96/A8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQt9l7tOTm1JnfXjdVxx7K+Hjkxd9mPnb1ftAwbt3y3X JP9z62qp6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiFdYM/xQ+qjOIna995L1x QmU1s3CAeYLz2713Jj35HTCrWShYnpXhv3Ol79qzF2b6Xo686c1QEmYy/6abePbiDM5bi953f51 /iQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 26 Jul 2024 11:05:25 +0800, Haifeng Xu wrote:
> When deactivating any type of superblock, it had to wait for the in-flight
> wb switches to be completed. wb switches are executed in inode_switch_wbs_work_fn()
> which needs to acquire the wb_switch_rwsem and races against sync_inodes_sb().
> If there are too much dirty data in the superblock, the waiting time may increase
> significantly.
> 
> For superblocks without cgroup writeback such as tmpfs, they have nothing to
> do with the wb swithes, so the flushing can be avoided.
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

[1/1] fs: don't flush in-flight wb switches for superblocks without cgroup writeback
      https://git.kernel.org/vfs/vfs/c/5f307d17dc72

