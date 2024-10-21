Return-Path: <linux-fsdevel+bounces-32492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C479A6C7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 16:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6DF1F2148C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D9A1FAC44;
	Mon, 21 Oct 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjyMsvML"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B811FAC38;
	Mon, 21 Oct 2024 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521969; cv=none; b=hE30ltl59I0+jiiDx9V6JUFZ3/3p4LRHaFCPYYndQU8d9XY3xeWPjdx8+SlLX456Sh+dvrqQbDwkRnv+WIsH5KCkJEEpBy3C1KMmKqCS6B+k7X0bbTqdVXYW4TkZ4e+kAm5xTECl+E6wqd9SwJbsunYpVg08NAcstX+ULUrfoKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521969; c=relaxed/simple;
	bh=Sw7cSXm9EpyX+c9azldUEdZILDN8Yb+WOiQsimH/O8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipIGym1YXdj6OPc0C1vL5q5Nv0VvnnvcWbDvagQmPMAaIXgOq50SJOh7JHhNrPyI+Egunxnsvn2A3cI9p2tvwHpqo6vVQoLlaIOJJ07Shu6+gdwnCerNqUsMLKJ6Hz4574ylUCHi3d5BLyY2OkFB2XXGXjK7+IagJDZjos1vnRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjyMsvML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC40C4CEE4;
	Mon, 21 Oct 2024 14:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729521968;
	bh=Sw7cSXm9EpyX+c9azldUEdZILDN8Yb+WOiQsimH/O8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RjyMsvMLsy09mLn1wKEqg9IX9Otm410RPO79HhJP0sDhtaqojwzEfusaFYh6/tLRW
	 3ptLUpXvVNI5YguCcjxcU0pLSrxxJGjpyueevOC7HVffdo84mBuqGYJc5EDVJDXf2E
	 57Hu4ZOwujY4Dio+4JegikxRmGh7enPWF4K1DnOt5/TcDJAUSHl+e7VZs7e+2GP7M1
	 5weW53zbe0MvqiG1RucQ2rbwFDrRhluopFPHH/C5EdXmJNoLs4fs/TDbvBGr+aM17A
	 DA05efav16PXUW4NXEn1GMHlDA+ArlTwoXkOywb0FTtErNQtOHeAHgXeLyL4tr9Pvk
	 CmZt0VmRsNnJw==
From: Christian Brauner <brauner@kernel.org>
To: luca.boccassi@gmail.com
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	oleg@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v11] pidfd: add ioctl to retrieve pid info
Date: Mon, 21 Oct 2024 16:45:23 +0200
Message-ID: <20241021-warten-ozonwerte-0e7b2326a566@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010155401.2268522-1-luca.boccassi@gmail.com>
References: <20241010155401.2268522-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=brauner@kernel.org; h=from:subject:message-id; bh=9CadsZ2Z1aw2hnXOf9IXM8u+GQsiszDp2+uSXlr0hLI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSLZTKbpv29F6XyJ9A1rET7sG/U5elXTHbVGdZlbhV4l l+3YPKbjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlYhzL8r1lexBx9j1XHeFrI /vQa7olLHKbfL0/7v32Fpg/X9XPTVBl+syc75f7v3cc9e/IT434J6y+3GqNtdBjdF6kfMBfaddG aGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 10 Oct 2024 16:52:32 +0100, luca.boccassi@gmail.com wrote:
> A common pattern when using pid fds is having to get information
> about the process, which currently requires /proc being mounted,
> resolving the fd to a pid, and then do manual string parsing of
> /proc/N/status and friends. This needs to be reimplemented over
> and over in all userspace projects (e.g.: I have reimplemented
> resolving in systemd, dbus, dbus-daemon, polkit so far), and
> requires additional care in checking that the fd is still valid
> after having parsed the data, to avoid races.
> 
> [...]

Applied with some minor changes as mentioned elsewhere.

---

Applied to the vfs.pidfs branch of the vfs/vfs.git tree.
Patches in the vfs.pidfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.pidfs

[1/1] pidfd: add ioctl to retrieve pid info
      https://git.kernel.org/vfs/vfs/c/12506679be68

