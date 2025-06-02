Return-Path: <linux-fsdevel+bounces-50320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A5FACADD6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D07E19604B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 12:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92145215181;
	Mon,  2 Jun 2025 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AApXLK/y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA80210184;
	Mon,  2 Jun 2025 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748866496; cv=none; b=XEr5w8Vz1BWzh/J+qpKw87eTvKFlVCnQv1+KzORnYNcMDhu+p5xYaTLz5FVpDAv5vdtvUad0sISKkSPnIaS7sIFcfYEmSQ0GQx5jIYRWVbcb77DuD3j/c0tWbSCKbvVGbafoMCoNYc9z0lMZPHn5Lig6lM9LTBb89SaInvqeIrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748866496; c=relaxed/simple;
	bh=4Ul8K3x8UQ2RkZ/IVbXwniJH9SavwdqncKIw/+W0l/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUxow8ySLt4zGzpqAUvJ1f/Qyab1r/4Ufp964nPzINjLWVTTKhWE+P2stRJ2P0gio/vpaHJACPfJ2dpsSahSgxQjkDI/ta2rqSg+qrYs2XSOKvv/nnm4nxJVy4uTVBUXkFHocjD2HLHUNDPBAMxhNfVBBnEJdcjrY8QlWcNeYIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AApXLK/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCF1C4CEED;
	Mon,  2 Jun 2025 12:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748866495;
	bh=4Ul8K3x8UQ2RkZ/IVbXwniJH9SavwdqncKIw/+W0l/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AApXLK/yjuQD9NOnNYZyFiU7JsMSnS00XWgULmm/6SFZlNW70nOV98PRCf5CHcWDH
	 O4fWkGBlVFDvZuMsfcrgYw3IPMbuZTDRntrK1+V0Qz/zYNdfd3Rffgls6jvN/1dZ3r
	 6bWfKLTf3pnPDmGm1vjduTucbORZAS48syrc3BBQ2FqWvSBW3DpMyzgdoRx7FePsf3
	 b38PaYJBD0DvGRWU3xm0KTjQXJg1ilFKtd9wq1z8GphsZKbSeTVGWJs6/UwSYAWcEn
	 BGLq6hoTL6mRClRgMV4f8joIdGrUODSxuSnAGRP+DCKQpo4e0exhHxC6yRWITtKZrV
	 Cz9VM+JzWQM+Q==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] filelock: add new locks_wake_up_waiter() helper
Date: Mon,  2 Jun 2025 14:14:43 +0200
Message-ID: <20250602-unstimmigkeiten-schimpansen-fe4ff1b32156@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250602-filelock-6-16-v1-1-7da5b2c930fd@kernel.org>
References: <20250602-filelock-6-16-v1-1-7da5b2c930fd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=brauner@kernel.org; h=from:subject:message-id; bh=4Ul8K3x8UQ2RkZ/IVbXwniJH9SavwdqncKIw/+W0l/8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTYTt0ls8c9Kq1Bx+y+SkJq49tJqbHtvxb9LWNctSsxX 3BW9q73HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5cJKR4W/xGrHT3UXa8067 fd7eWLlsdecXK+HKCRzlJg9fzsvUyGZk+G2gLL0r0+qdKddpq8CbEz+r9D7amzF7Z4BK277mXaw 6DAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 02 Jun 2025 07:58:54 -0400, Jeff Layton wrote:
> Currently the function that does this takes a struct file_lock, but
> __locks_wake_up_blocks() deals with both locks and leases. Currently
> this works because both file_lock and file_lease have the file_lock_core
> at the beginning of the struct, but it's fragile to rely on that.
> 
> Add a new locks_wake_up_waiter() function and call that from
> __locks_wake_up_blocks().
> 
> [...]

Applied to the vfs-6.17.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.misc

[1/1] filelock: add new locks_wake_up_waiter() helper
      https://git.kernel.org/vfs/vfs/c/cc69995fd8e9

