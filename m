Return-Path: <linux-fsdevel+bounces-16243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418E889A6C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 23:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE59BB223F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 21:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8D0178CD3;
	Fri,  5 Apr 2024 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bDcbKld4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E32217555E
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712354075; cv=none; b=CAgAMAWOuSCaksQHVyRYtQQ3WQXY3w5yiN+XofKZ6JzZw6jMJYzeRAXjDJm5Z8vTwE+iPgO71/BelHpdjwt3FnF7lNhliEuS6Aks4RbVRXVxqxTua2DeoFczoswEakNdYREmk8N1ufg8wHsbedJVnf98Tyn2gH20wPkcrx7eZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712354075; c=relaxed/simple;
	bh=vC65z3rwzcSneaY8X3nq+X2fBQv/ug7Lk0KdYSyEm50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuaZrAIP7460aBUi6Q34Fv2T9ka3NKun76YVS4BXlrjbWlIUtLzur2Fpy5rYcRYLN7FddjVC4EUD3fHT1zoRdsAUW2RwZcXJZ1RyhqAzYE+mvggo9Hs/y5bsmLpGtB/+SC+PCPVlxj8TaghKgHAUCW55d130XjQ+UHbe1++1BIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bDcbKld4; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Apr 2024 17:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712354070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PWmOWNfLF5BxlfyBF30S3CHHxBco4YzpcxUcDZkFkBk=;
	b=bDcbKld46ENpruobDPG9TITNDTuiueTTWLk04AMOh9kT+LAxAWc6b2kebNYNO5uJB4EenT
	URLzU61ge0TqTjbV3SnxFioaZQHAOucIYGYo4JDps0l9cXIdxhyiGV/oGZfd2+WrFYxt0R
	MTEnsvJMPFKh49v8X6XC0ZcJ93FFhmY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Dave Chinner <dchinner@redhat.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Theodore Ts'o <tytso@mit.edu>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v14 01/12] fs: Return ENOTTY directly if FS_IOC_GETUUID
 or FS_IOC_GETFSSYSFSPATH fail
Message-ID: <ck44cgv2misqfbwtatvrlf5bj4ga7iinqwpxb4ncuxprdfbex2@5trtmyoys3zl>
References: <20240405214040.101396-1-gnoack@google.com>
 <20240405214040.101396-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240405214040.101396-2-gnoack@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 05, 2024 at 09:40:29PM +0000, Günther Noack wrote:
> These IOCTL commands should be implemented by setting attributes on the
> superblock, rather than in the IOCTL hooks in struct file_operations.
> 
> By returning -ENOTTY instead of -ENOIOCTLCMD, we instruct the fs/ioctl.c
> logic to return -ENOTTY immediately, rather than attempting to call
> f_op->unlocked_ioctl() or f_op->compat_ioctl() as a fallback.
> 
> Why this is safe:
> 
> Before this change, fs/ioctl.c would unsuccessfully attempt calling the
> IOCTL hooks, and then return -ENOTTY.  By returning -ENOTTY directly, we
> return the same error code immediately, but save ourselves the fallback
> attempt.
> 
> Motivation:
> 
> This simplifies the logic for these IOCTL commands and lets us reason about
> the side effects of these IOCTLs more easily.  It will be possible to
> permit these IOCTLs under LSM IOCTL policies, without having to worry about
> them getting dispatched to problematic device drivers (which sometimes do
> work before looking at the IOCTL command number).
> 
> Link: https://lore.kernel.org/all/cnwpkeovzbumhprco7q2c2y6zxzmxfpwpwe3tyy6c3gg2szgqd@vfzjaw5v5imr/
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Günther Noack <gnoack@google.com>

Acked-by: Kent Overstreet <kent.overstreet@linux.dev>

> ---
>  fs/ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 1d5abfdf0f22..fb0628e680c4 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -769,7 +769,7 @@ static int ioctl_getfsuuid(struct file *file, void __user *argp)
>  	struct fsuuid2 u = { .len = sb->s_uuid_len, };
>  
>  	if (!sb->s_uuid_len)
> -		return -ENOIOCTLCMD;
> +		return -ENOTTY;
>  
>  	memcpy(&u.uuid[0], &sb->s_uuid, sb->s_uuid_len);
>  
> @@ -781,7 +781,7 @@ static int ioctl_get_fs_sysfs_path(struct file *file, void __user *argp)
>  	struct super_block *sb = file_inode(file)->i_sb;
>  
>  	if (!strlen(sb->s_sysfs_name))
> -		return -ENOIOCTLCMD;
> +		return -ENOTTY;
>  
>  	struct fs_sysfs_path u = {};
>  
> -- 
> 2.44.0.478.gd926399ef9-goog
> 

