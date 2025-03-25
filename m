Return-Path: <linux-fsdevel+bounces-45032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E3EA70463
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 15:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6DEC3AAE02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C72825BADA;
	Tue, 25 Mar 2025 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlgCtgWi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB5B25BAC7
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914629; cv=none; b=pA8mb/dJHXtXpwVPilMzSGEgPMy+2uYshqk4eTQShjlslL2bqjToIg+MPakG/saiWjiruHesMm197NV68ydnhd1+ZeuYeDGjZo5mS0xTZVG+5ykiYRnDHrbYFAIW9P/U+z8uSRsrfnvjIaOoDYnWDkAC5MlwOLOlO9UxyrpN+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914629; c=relaxed/simple;
	bh=DnHcVrZ46dwF91W+cXf8malWjX5idgoBQtx46r8DDYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFmSdpoaKIXyBlhhTMLwYiU0gofR8Wg9IvHZTKPh6d1NhrujKnSc7Q9qOzHUke76GXfFXWLClr0qkzyQVLiGHOXpfD0mgzlUYLZnVBoYhNVQrsNVpAKl16dpuZq92jjtIOBihaZW+9QBoUWFl1ifzBK6Y6IkLaX/IATC3AO6Uxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlgCtgWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CFFC4CEF1;
	Tue, 25 Mar 2025 14:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742914629;
	bh=DnHcVrZ46dwF91W+cXf8malWjX5idgoBQtx46r8DDYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AlgCtgWib7d3XGvTaeFsGklFjx9GDMX9UE2DDy2QY+a2OWbcu8ZQ1q8QEJce2/8m0
	 E5WbFLaKMoJhRvAlH82FxO2VLm/2gstrjtuPWLI9p+rvFQFq7Fmkhr07a1ZQm+pRpL
	 6428ghV4zMTGfZHTAUixFJay83NzNPWplb4s7+GiqESKzTrv8uGAqB93XNVkxpA7KS
	 3JTbe1el5Kcls4j4tgYpXEHS/aBjbQYd3Lkd9AK3/oamdUPERr0JG14FzYFMpCtlT1
	 Yu3B1Z0O36Iv4uTvuJXzsIWFFieg7stfFMNANw5xIEPi4kIs35O3etnLKDNdV3/7Pj
	 UO06DddJir7vw==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH] exit: fix the usage of delay_group_leader->exit_code in do_notify_parent() and pidfs_exit()
Date: Tue, 25 Mar 2025 15:57:00 +0100
Message-ID: <20250325-gemacht-artefakte-b27c3b51cbae@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250324171941.GA13114@redhat.com>
References: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org> <20250324171941.GA13114@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1429; i=brauner@kernel.org; h=from:subject:message-id; bh=DnHcVrZ46dwF91W+cXf8malWjX5idgoBQtx46r8DDYQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/OuLoaqp0fe7TRW1xvRLHugStFTjYTG4sqNCVW7aqx e2LM+ubjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMb2FkeGQwIYLl0vXZUy57 N2mYbj696Jfz4pacH57mzTycTwV2/GT4X8Wbq7u6x1tSI37/M1e+7cWS7BFh1aIsvc4m7brsoWp sAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 24 Mar 2025 18:19:41 +0100, Oleg Nesterov wrote:
> Consider a process with a group leader L and a sub-thread T.
> L does sys_exit(1), then T does sys_exit_group(2).
> 
> In this case wait_task_zombie(L) will notice SIGNAL_GROUP_EXIT and use
> L->signal->group_exit_code, this is correct.
> 
> But, before that, do_notify_parent(L) called by release_task(T) will use
> L->exit_code != L->signal->group_exit_code, and this is not consistent.
> We don't really care, I think that nobody relies on the info which comes
> with SIGCHLD, if nothing else SIGCHLD < SIGRTMIN can be queued only once.
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

[1/1] exit: fix the usage of delay_group_leader->exit_code in do_notify_parent() and pidfs_exit()
      https://git.kernel.org/vfs/vfs/c/9133607de37a

