Return-Path: <linux-fsdevel+bounces-2089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555717E2248
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 13:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868E81C20AFC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 12:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5FC1A71D;
	Mon,  6 Nov 2023 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkGpAO9g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E042FB3
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 12:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41612C433C8;
	Mon,  6 Nov 2023 12:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699275108;
	bh=iD4LAzHHDQhIkwFfR56kB3BCY4Ta3YKbFjnA8Ha/w8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FkGpAO9gt+bUk2jr1phBDaqhdLV0c6yVs+bC+9dF77FzdFeb1O6gPJWSGb+f8vkX2
	 ROOExUrMoEBcRML9aQ+IiEC42lKlHj5EQBLpDP/BaHC/xnKz0hLFgQA20MTIklzHKm
	 lhGh0+ZbKYqbGeHyySFuoYrSJMrwTcfLmtZK2m7ROZBUWWqy8xaN8nzfbhgJzQjW/p
	 ltMmjk0fMx/KEHyYJ2yokPYHZPOLZwE3NFH9QeGZQrHRmv1C8wF+/IUgdbH47nvyBT
	 Zzn2fqCCtDVWVjX9TGSQul0A+Q25oGesd9J7aWLoGj0nymZ4AL41o14l4HuGT+IPaO
	 lyriINgfMZjmw==
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <dchinner@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Handle multi device freezing
Date: Mon,  6 Nov 2023 13:49:56 +0100
Message-Id: <20231106-vfs-multi-device-freeze-ty-5b5b69626eac@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104-vfs-multi-device-freeze-v2-0-5b5b69626eac@kernel.org>
References: <20231104-vfs-multi-device-freeze-v2-0-5b5b69626eac@kernel.org> <20231104-vfs-multi-device-freeze-v2-1-5b5b69626eac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=brauner@kernel.org; h=from:subject:message-id; bh=iD4LAzHHDQhIkwFfR56kB3BCY4Ta3YKbFjnA8Ha/w8o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR6PHizonR2RIeanfOhn68mLDH4Nyn/345owzjnmwu2bIl2 WMqn0FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARY3VGhk0zTVg0jqUFbH14PjLy6/ xmaf+35VeZ8nX/VVz98ferzHKGv5KbFq/wuBlmV3k3xKjxQeTTV23L8k/35k3f0V67fEefMS8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 04 Nov 2023 15:00:12 +0100, Christian Brauner wrote:
> Above we call super_lock_excl() which waits until the superblock is
> SB_BORN and since SB_BORN is never unset once set this check can never
> fire. Plus, we also hold an active reference at this point already so
> this superblock can't even be shutdown.
> 
> 

Applied to the vfs.super branch of the vfs/vfs.git tree.
Patches in the vfs.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.super

[1/2] fs: remove dead check
      https://git.kernel.org/vfs/vfs/c/9745915cc5e0
[2/2] fs: handle freezing from multiple devices
      https://git.kernel.org/vfs/vfs/c/03630940f622

