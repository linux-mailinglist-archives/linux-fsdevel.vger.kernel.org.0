Return-Path: <linux-fsdevel+bounces-16437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD4089D8F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 14:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280BD288576
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 12:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5991D12BF2D;
	Tue,  9 Apr 2024 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="04kGovor"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731CB12A160;
	Tue,  9 Apr 2024 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664690; cv=none; b=IW3pBxIdrshjTOddmwGYQmdS7OT3gyEDC1v5ON9HzzR07QcnBCujvD6cB3zK5Agd0r+aiVj34LpYAbe93PJcdTgVYz2R5ZFxXFa+Kv616FyODikeL5RQGZ0Of8uuoM+xLdBEGrrO7OhBKzbBqhpnVW/28t9ei7pUnu27VCs8jXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664690; c=relaxed/simple;
	bh=f93CKdgSfkG/oRcGf2E+C75lMAPrpHFDvXEVi5v8Wjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sw1tg65+e2WpPKf6IE7lNtRwKFvGoD5YnJ1Y/qX71o6UiCYP33dqaUarwalg74cm8nuVtuLFVQwxBHB87sYKMQc6RY7iD8iGXWk7d2dIg4SYurcnLf7qlWYCHe3IaUe9lTt5O6njDRgqP2EG36UVnl1sa5m38qqa7UuAdUC8NrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=04kGovor; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VDPv75ynqzpnp;
	Tue,  9 Apr 2024 14:11:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712664675;
	bh=f93CKdgSfkG/oRcGf2E+C75lMAPrpHFDvXEVi5v8Wjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=04kGovorDo813Ypc1syKH1WNfJQYTW4YZCfIGniqXT/FJlEr9r7RGumcvmflhdy3u
	 I0Di8EqRhxlG/yXR2fZ6ZUqoHYkWrnTl2mNb8D6deGfN+GXs0zXc1xwO/hZP2skWSj
	 PcWQcmq8uGzQ7jEifTEWtZWWVGmgTYXkqbyaTI9U=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VDPv63tLnzVZ;
	Tue,  9 Apr 2024 14:11:14 +0200 (CEST)
Date: Tue, 9 Apr 2024 14:11:13 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: gnoack@google.com, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	Kent Overstreet <kent.overstreet@linux.dev>, Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	Josef Bacik <josef@toxicpanda.com>, linux-security-module@vger.kernel.org
Subject: Re: (subset) [PATCH v14 01/12] fs: Return ENOTTY directly if
 FS_IOC_GETUUID or FS_IOC_GETFSSYSFSPATH fail
Message-ID: <20240409.einge5rai8Ee@digikod.net>
References: <20240405214040.101396-1-gnoack@google.com>
 <20240405214040.101396-2-gnoack@google.com>
 <20240409-bauelemente-erging-af2ad307f86e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409-bauelemente-erging-af2ad307f86e@brauner>
X-Infomaniak-Routing: alpha

On Tue, Apr 09, 2024 at 12:08:23PM +0200, Christian Brauner wrote:
> On Fri, 05 Apr 2024 21:40:29 +0000, Günther Noack wrote:
> > These IOCTL commands should be implemented by setting attributes on the
> > superblock, rather than in the IOCTL hooks in struct file_operations.
> > 
> > By returning -ENOTTY instead of -ENOIOCTLCMD, we instruct the fs/ioctl.c
> > logic to return -ENOTTY immediately, rather than attempting to call
> > f_op->unlocked_ioctl() or f_op->compat_ioctl() as a fallback.
> > 
> > [...]
> 
> Taking this as a bugfix for this cycle.

Looks good.

FYI, I added the following tags and re-formated the commit message in my
next branch, so it is already in linux-next (but I'll remove it when
yours will be merged):
https://git.kernel.org/mic/c/5b5c05340e67d1127a3839d1ccb7d7acbb7b9a82

Fixes: 41bcbe59c3b3 ("fs: FS_IOC_GETUUID")
Fixes: ae8c51175730 ("fs: add FS_IOC_GETFSSYSFSPATH")

You can also add:
Acked-by: Mickaël Salaün <mic@digikod.net>

> 
> ---
> 
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
> 
> [01/12] fs: Return ENOTTY directly if FS_IOC_GETUUID or FS_IOC_GETFSSYSFSPATH fail
>         https://git.kernel.org/vfs/vfs/c/abe6acfa7d7b
> 

