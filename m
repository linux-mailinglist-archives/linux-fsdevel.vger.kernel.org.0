Return-Path: <linux-fsdevel+bounces-44844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFB4A6D116
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 21:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50EA07A7202
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 20:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AA71A841A;
	Sun, 23 Mar 2025 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqMgEYW5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD2A1A5BBF
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Mar 2025 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742762447; cv=none; b=LaSA06FkXiklS+moFuQpdFLf4NqPtQrhBmnRiDW51Yg1jc7j4xWsHQW049Vn5jUw/ckd0cYWiqMh39/W71YhED5IFyNmRaKbucSq2JEyxVHHDDf7/4gzOqbhY6sXAPJJE/pIhSkQFyuVQW+2XaWgC/QKIH6q58Q2USWRTTMJFaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742762447; c=relaxed/simple;
	bh=+/Xz8LtzUwpk8KE4PhwRRIyW9p+1Hy/47BdoSXGm8ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSACC6Tjk1I3t9dG35iV4lvRPqRITcG/uRdaxhvqQT4Vf9dxaDwEmwRWtvGuA4Hk9j+OLj6QvDVsHnkNkFneMd9BYFXvhylT1mCiBPTAQxluJBCMWEt/q/FVgwn25/DReFBWsk4I/ibezISNXR/t8ijYqaZIznRo56mz42vuQr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqMgEYW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6A7C4CEEE;
	Sun, 23 Mar 2025 20:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742762447;
	bh=+/Xz8LtzUwpk8KE4PhwRRIyW9p+1Hy/47BdoSXGm8ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WqMgEYW5z+5gabQWYQ0ft77uld6/2CKtNN67H675fs0sGQQJmV4FDpT+M9/Wg7pp+
	 wHmr1LGCzmboUaevJOv+ik6pgxXffANBsLmzAXfB3ZW6aTFUlm0AvNuEojXXUpoHk+
	 OPgkRdo9BEM2FT2NXdxXMhhh008JDxgoUDF6xHL/BmIR3B9us0UoNf+MNv5lNwTSrv
	 1rAQSB9xpUAczABYQ+CkXIDzpXy8jCtdHkXiJuvpn9TJ3B/ufb8ElzCtihdO4cimfv
	 ThlxuN7MSEB1p2ZNKBHOL1PPw+oLErTFzPVCU9Pd8tz2TIb0iSONCciTL+m2Tf1bSA
	 3ETu5qTqU9dnA==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH] pidfs: cleanup the usage of do_notify_pidfd()
Date: Sun, 23 Mar 2025 21:40:38 +0100
Message-ID: <20250323-marginal-stich-5343e5f7c7e7@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250323171955.GA834@redhat.com>
References: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org> <20250323171955.GA834@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=brauner@kernel.org; h=from:subject:message-id; bh=+/Xz8LtzUwpk8KE4PhwRRIyW9p+1Hy/47BdoSXGm8ho=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/KDzzMqnSfPf+J34b4rZO/i93S7/v+5IUES//P1ejZ /iybOr401HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRXW2MDM9zAl88WvZf2lSK dZLMkSfP9hbaH2l7rSw5M9Xf9LAVNxsjQ89PyeofP1r0ZAXPRRvW81zQtpH+f53n+6s1L/wT1or PZwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 23 Mar 2025 18:19:55 +0100, Oleg Nesterov wrote:
> If a single-threaded process exits do_notify_pidfd() will be called twice,
> from exit_notify() and right after that from do_notify_parent().
> 
> 1. Change exit_notify() to call do_notify_pidfd() if the exiting task is
>    not ptraced and it is not a group leader.
> 
> 2. Change do_notify_parent() to call do_notify_pidfd() unconditionally.
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

[1/1] pidfs: cleanup the usage of do_notify_pidfd()
      https://git.kernel.org/vfs/vfs/c/98ce463bc6f4
[1/1] selftests/pidfd: (Was: [PATCH] pidfs: cleanup the usage of do_notify_pidfd())
      https://git.kernel.org/vfs/vfs/c/cc8c2e338a25

