Return-Path: <linux-fsdevel+bounces-73213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE30D11B8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 11:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1365A30142CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A828F948;
	Mon, 12 Jan 2026 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQZBxTfK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75DD26A0A7;
	Mon, 12 Jan 2026 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212482; cv=none; b=olVlpqEWaiJR/O7ieQtw8IQj3LWiNZS6POaWoDdgc53mxu7x2TsVV/5wP1RWh9eC4n3rl8pRPK4vVGbB1FG9GGBIct3TY6XYpoOGoe9lwaRIyJb3FRAdMYshKYmc5H0wWNGRTHeCXRAdbqBTkRGisFio15ajjgF3QgAF20rnOEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212482; c=relaxed/simple;
	bh=yNu2Vc+LgrhmfzwnGMLQM6JoboubbqaKl7ZgfHRTRJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/PGRjWMqpwoS6Op13xfZbZl+a2ZCFzLy087SOF/hzD2KTYWZ3n5yog6JhjUBREpeswLPdGTk2fMblZ+5pB4KdX245hLAc9upj2qLpOo0ou5nl8XeOzFgfRdSw6DI+TJ+Hn6DE19vVKVs/Bg4MAxtTSTNbUnZimxkLZOPtOd/Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQZBxTfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BABC16AAE;
	Mon, 12 Jan 2026 10:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768212481;
	bh=yNu2Vc+LgrhmfzwnGMLQM6JoboubbqaKl7ZgfHRTRJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQZBxTfKDUZpgcGnXHueOEbhIiqZ/VRNldMM38WawyFuuzZfm/u+JlVSr3UJ4krZM
	 riR3nmKdjB8Z6K6zQytG+E+LSORKTSUrheMPMgekpr9x0P2oeNIFPIpDKQhvVQvyr+
	 2kYJ1mSa4ZMF6czyTkXisJlVLaVzy95Z/skWByckO0DKXKb1WDD+Q/vj/L2W5tWcwa
	 vnG+hmCbu0qjP1gS94zKVxvFTiTE9M7VfpyYx4hDwBMU7lpPC49cCQR+s6iv5pvFcR
	 t1Gp8Yu4YWcs2T3WjRoK2i3V+vzSsihjrQvK6CP8J1VEvu6roNTZA90GNWlB2clcPY
	 c/GNcAqeMt9OQ==
From: Christian Brauner <brauner@kernel.org>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	tytso@mit.edu,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 0/2] Fix vm.dirtytime_expire_seconds=0 causing 100% CPU
Date: Mon, 12 Jan 2026 11:07:50 +0100
Message-ID: <20260112-erlesen-befanden-3f875582b84d@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106145059.543282-1-laveeshb@laveeshbansal.com>
References: <20260106145059.543282-1-laveeshb@laveeshbansal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398; i=brauner@kernel.org; h=from:subject:message-id; bh=yNu2Vc+LgrhmfzwnGMLQM6JoboubbqaKl7ZgfHRTRJU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmHP/7VKbOZ1FC46fTWQbdq16/XHJx3sGGn19UWdfuV T3r/f/6zo5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ3C9gZFjXrdd2c3/5Qw8D CY9bSls49zyVX3yO2c2W/+E+TuuU1esZGea0JAZd/KK7/sJc9a17bEIef9U3rtE0iv3P+GbL5ua bRzgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 06 Jan 2026 14:50:57 +0000, Laveesh Bansal wrote:
> Setting vm.dirtytime_expire_seconds to 0 causes wakeup_dirtytime_writeback()
> to reschedule itself with a delay of 0, creating an infinite busy loop that
> spins kworker at 100% CPU.
> 
> This series:
> - Patch 1: Fixes the bug by handling interval=0 as "disable writeback"
>            (consistent with dirty_writeback_centisecs behavior)
> - Patch 2: Documents that setting the value to 0 disables writeback
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

[1/2] writeback: fix 100% CPU usage when dirtytime_expire_interval is 0
      https://git.kernel.org/vfs/vfs/c/543467d6fe97
[2/2] docs: clarify that dirtytime_expire_seconds=0 disables writeback
      https://git.kernel.org/vfs/vfs/c/30ef9a20f1fd

