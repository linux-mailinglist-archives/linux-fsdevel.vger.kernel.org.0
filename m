Return-Path: <linux-fsdevel+bounces-3818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78987F8BED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 16:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FBE2B211B0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 15:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB5428E01;
	Sat, 25 Nov 2023 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6m/Q3m2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CFF12E7E
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 15:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46699C433C8;
	Sat, 25 Nov 2023 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700924856;
	bh=/q54+mS73n57N6iwq9jTkLf9YVzPjCrTltEnmyKnZTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6m/Q3m2C9dv/x1IrvMwUpR8bpLlJNc24Gp3v/Vc2ovKIDlh0vNRu2OEmZtSizOKf
	 PAy35UaIxh08a5Mu13pW51gdbl7Re9EVHipdFS+kl4oAmzE1dXWBIgu6HAFPzX/TaA
	 qnZk21Rr/tFPxpjYcqN+Eoti28DB6PsoSLwwW3oOowf+guc95M96Jx0ov5G0Sfebd0
	 6bEE6s8dIZ6RyzqH10Yp1Fiwr1wUzq5TW1uaosYT0s0qxlMhrQXFCfpnV/wq+Gb3kG
	 luMgV2ANlxx46DG1bGRPoHSg7bbeUKi4uzW98rmnQbJt1sZaDQuHRWAvB0udThpC9E
	 ps6nvUJ51ysGQ==
From: Christian Brauner <brauner@kernel.org>
To: dhowells@redhat.com,
	Jia Zhu <zhujia.zj@bytedance.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jefflexu@linux.alibaba.com,
	Gao Xiang <xiang@kernel.org>,
	linux-cachefs@redhat.com
Subject: Re: [PATCH V6 RESEND 0/5] cachefiles: Introduce failover mechanism for on-demand mode
Date: Sat, 25 Nov 2023 16:06:34 +0100
Message-ID: <20231125-latschen-bierkrug-d3bad5531859@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120041422.75170-1-zhujia.zj@bytedance.com>
References: <20231120041422.75170-1-zhujia.zj@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=brauner@kernel.org; h=from:subject:message-id; bh=/q54+mS73n57N6iwq9jTkLf9YVzPjCrTltEnmyKnZTc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQm8Va+zrfe2JXb8Ig7bXpieu4x03bGd/5nbIKfnvP9d yv7TvbNjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkI72JkOPD/TmjayXeu3hn3 mrh/1vBJrpO1NHA1emn49sWU2YuX8jAy7Itw154XdWgxD/tLWUb93q6V7DYMQVIF575kt51ZJdP BCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 20 Nov 2023 12:14:17 +0800, Jia Zhu wrote:
> Changes since v5:
> In cachefiles_daemon_poll(), replace xa_for_each_marked with xas_for_each_marked.
> 
> [Background]
> ============
> In the on-demand read mode, if user daemon unexpectedly closes an on-demand fd
> (for example, due to daemon crashing), subsequent read operations and inflight
> requests relying on these fd will result in a return value of -EIO, indicating
> an I/O error.
> While this situation might be tolerable for individual personal users, it
> becomes a significant concern when it occurs in a real public cloud service
> production environment (like us).  Such I/O errors will be propagated to cloud
> service users, potentially impacting the execution of their jobs and
> compromising the overall stability of the cloud service.  Besides, we have no
> way to recover this.
> 
> [...]

Applied to the vfs.fscache branch of the vfs/vfs.git tree.
Patches in the vfs.fscache branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fscache

[1/5] cachefiles: introduce object ondemand state
      https://git.kernel.org/vfs/vfs/c/357a18d03314
[2/5] cachefiles: extract ondemand info field from cachefiles_object
      https://git.kernel.org/vfs/vfs/c/3c5ecfe16e76
[3/5] cachefiles: resend an open request if the read request's object is closed
      https://git.kernel.org/vfs/vfs/c/0a7e54c1959c
[4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
      https://git.kernel.org/vfs/vfs/c/b817e22b2e91
[5/5] cachefiles: add restore command to recover inflight ondemand read requests
      https://git.kernel.org/vfs/vfs/c/e73fa11a356c

