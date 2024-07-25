Return-Path: <linux-fsdevel+bounces-24230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E053793BDDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 10:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 689DAB20F75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 08:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05B0173351;
	Thu, 25 Jul 2024 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmhssq1n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CBB1CD11;
	Thu, 25 Jul 2024 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721895611; cv=none; b=qVAk8q7nC/PKE6ip87tMlNoEDEENYZbsd835NUUCLBlPRxMzGM6ofpaW+bSdrdnL7gTvZpfxkyGAiqCBJGIIFtvGLkiwvuwtxgjcVoU68gYjptMmRD1Q9NpB2bM2/fn5ajRvmn5U9tBANz4kduesqprSJ4TAOTtwoWUhH6FI0EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721895611; c=relaxed/simple;
	bh=lIzu2GmQN/9W0mBQGLcX8S4gHdxpAdRdEae2a7l92xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAhHOHMrP39COOz+2nTgC3p0PJlpxbhX/k/rU+C+78Z/MdH0dBmUswZVED//4BSXNFhlTnRqMT3lUMGaudCGtQNoDMh9z76pYjgYdj3B+vBma4gUeOSfDEzRA43GOJ9fzsAGESyIIvotnAXnV2gmvxJxUKvgbY/Iec9wlEU7s7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmhssq1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DFFC116B1;
	Thu, 25 Jul 2024 08:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721895610;
	bh=lIzu2GmQN/9W0mBQGLcX8S4gHdxpAdRdEae2a7l92xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gmhssq1ng0p/k2kDL5Xs8d8qWZjDeT9SNCSHxtMgn+IyVJZ8CfewYi/Nhlw6jLkr3
	 2d1p0rVkp5GxA0nc+wKzqJdHt6vhYSkFwS8RCst2FyYQpKfz3z2adLg9s9ijyQqTYH
	 YHbAYqsjrSH/niPZlI/7wFMphFNv7GxW/rAn5Op1KF/EATtu6QyfFcmVFekOF4QMHn
	 ZU/4V2FQkoJkkLYSxT8jntvcO2dv0ow9GqjmDpNN6zDha0+Am3SI7YzLegMWsMftR9
	 /E0dDWAptO8gBfZJbd9Nwdyabw2BLJ1V3n298FWOWshtdfxxhpL6JLEsUVww9Y6vLw
	 cgD7TBmXkR7UQ==
From: Christian Brauner <brauner@kernel.org>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: don't allow non-init s_user_ns for filesystems without FS_USERNS_MOUNT
Date: Thu, 25 Jul 2024 10:19:50 +0200
Message-ID: <20240725-milieu-jungautor-1e7bf7cf98fe@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724-s_user_ns-fix-v1-1-895d07c94701@kernel.org>
References: <20240724-s_user_ns-fix-v1-1-895d07c94701@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395; i=brauner@kernel.org; h=from:subject:message-id; bh=lIzu2GmQN/9W0mBQGLcX8S4gHdxpAdRdEae2a7l92xI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQt4loefOhF+rYJXk5bDL9v46y+tOJ6jbKx2JdVTKt0D IyXe/n1dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEYQfD/wzxhRPmfJkh+Ybz b9KCi7mpn7YfiyteNllHp9sq22B2SiIjw0E/v00KJuuCr6xSfuz8ZFnx6hqX4HU1SQEvbLOWd9j oMQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 24 Jul 2024 09:53:59 -0500, Seth Forshee (DigitalOcean) wrote:
> Christian noticed that it is possible for a privileged user to mount
> most filesystems with a non-initial user namespace in sb->s_user_ns.
> When fsopen() is called in a non-init namespace the caller's namespace
> is recorded in fs_context->user_ns. If the returned file descriptor is
> then passed to a process priviliged in init_user_ns, that process can
> call fsconfig(fd_fs, FSCONFIG_CMD_CREATE), creating a new superblock
> with sb->s_user_ns set to the namespace of the process which called
> fsopen().
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

[1/1] fs: don't allow non-init s_user_ns for filesystems without FS_USERNS_MOUNT
      https://git.kernel.org/vfs/vfs/c/f7c589ccd630

