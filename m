Return-Path: <linux-fsdevel+bounces-16430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B2289D652
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 12:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC54281F99
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5EE8120D;
	Tue,  9 Apr 2024 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHlpUCq1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902427D3E8;
	Tue,  9 Apr 2024 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657355; cv=none; b=bfXawKDi8vZFFBwJ8aNFSPvXpRwImoUF5TviFjNxv1HxhUlKIU+w/TU+kubpbgGWyU6EPd0RZ08WojMKm9PaPHz1Z2lf3K/D1hlar5pTdrTU7zBhR0y4WnZw29rFno69QgFmRLJiaeYF/gddYP33LeGeGwxVAcdAFkGvM0K7PBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657355; c=relaxed/simple;
	bh=V9+KBAh2mipvBmRAYiJ2CLNFm9iexE2KB9YFk5e8KJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5dSYuzDOUt+CCuBixtq7tNZaOyXYncD0M7a60oo4lvrl6S25GK2y4ZsUrWFGPRf1IZJ5hgLMPI7mEkKIAQE+7NdcIIYiCtQqJ53qlZt+l1a7/aKdUPqdyE1rmS6+QeQZlmo1Vu4AX1S4DqK3p85oUMUKfc7ZQKLgJ6713Bte4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHlpUCq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE8DC433F1;
	Tue,  9 Apr 2024 10:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712657355;
	bh=V9+KBAh2mipvBmRAYiJ2CLNFm9iexE2KB9YFk5e8KJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHlpUCq1TrAt9drJ3DBxQsZsLYlWQ7o3Gb124/Aa+J2nyoPJKJD7tFPci9Jfhn5le
	 Z2/dVZOYQXQyroYTfHlgLr1jaGpAJc3xV3a338LHFxRMkmT8X6Iv2ul2KtYZaWkA/k
	 ZypaE9OfoktafGAlwVZPvr1AvqaQwpxditgggR+taBvEVVBk8xlDr+75lydGzjIwm2
	 SU+nLdInWQsCJIfiNgL7Lkot15E0v/o2tKv2rzA36kmIUmJi1MsDy+hdktlj0uhso1
	 XqEyjDKGVo5xwRWh7JPyEDuIGf9F2WIfMw39HHC3YOaAaAHrusWr2NQ+rDq/G/D71h
	 XvxoLyvinP/sA==
From: Christian Brauner <brauner@kernel.org>
To: gnoack@google.com
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Xu <jeffxu@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jorge Lucangeli Obes <jorgelo@chromium.org>,
	Allen Webb <allenwebb@google.com>,
	Dmitry Torokhov <dtor@google.com>,
	Paul Moore <paul@paul-moore.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-security-module@vger.kernel.org,
	mic@digikod.net
Subject: Re: (subset) [PATCH v14 01/12] fs: Return ENOTTY directly if FS_IOC_GETUUID or FS_IOC_GETFSSYSFSPATH fail
Date: Tue,  9 Apr 2024 12:08:23 +0200
Message-ID: <20240409-bauelemente-erging-af2ad307f86e@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240405214040.101396-2-gnoack@google.com>
References: <20240405214040.101396-1-gnoack@google.com> <20240405214040.101396-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229; i=brauner@kernel.org; h=from:subject:message-id; bh=W1PcE9PG3NW9cH/p+fiZKvu7lNvYvVqWeRcMqfltMU0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSJCs+Qqv6TsvzDhurjFn9vL5GwUi85s/fU1j8nwsrSe zK2T7XY2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR02xGht8HFXtW/yovmWzU VHN6+T5lGZenS979X1UX+MXv5SYh4yeMDN3bVN7uaq3MThd7eeE4Q/dRyej0/olGG1VlJIr/HWn LYgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 05 Apr 2024 21:40:29 +0000, Günther Noack wrote:
> These IOCTL commands should be implemented by setting attributes on the
> superblock, rather than in the IOCTL hooks in struct file_operations.
> 
> By returning -ENOTTY instead of -ENOIOCTLCMD, we instruct the fs/ioctl.c
> logic to return -ENOTTY immediately, rather than attempting to call
> f_op->unlocked_ioctl() or f_op->compat_ioctl() as a fallback.
> 
> [...]

Taking this as a bugfix for this cycle.

---

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

[01/12] fs: Return ENOTTY directly if FS_IOC_GETUUID or FS_IOC_GETFSSYSFSPATH fail
        https://git.kernel.org/vfs/vfs/c/abe6acfa7d7b

