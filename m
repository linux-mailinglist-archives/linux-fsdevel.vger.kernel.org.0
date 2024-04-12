Return-Path: <linux-fsdevel+bounces-16815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1241C8A3264
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 17:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93B29B27890
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 15:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E352147C7D;
	Fri, 12 Apr 2024 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZdZtnUvo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4D143899
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935546; cv=none; b=g1+SG3rkeogEW0Z6Dsrvfrk4PMzoeraK2b9kJQnVdWRY8BUPvNacx/wyIGQISwsDEdMrqfO7cCcvE2DLJGk564Z+bBsccUdQ5vpZNVNCEP8bLt2kVx+5vybse5Xh5YvnMAt/QZqc3YjWkctG3QEuvSsuUx0hpSpIcgPiuCFb8X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935546; c=relaxed/simple;
	bh=DJiraOZMDp379CkBujxqNMaJDhKumWZkMrU0YsjFVdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoHolYQijUuZyzOSWabnPv8DwSKF/xysVhHTW7Qtg+rbvku63CSvlu8CZ9QDylKYiU90EqplOoPFhl108dfa8z5rXtyCpB1sfb+SWWaboQemjAAv0DJun50QikiL2pqfX6FdnJCAK0+tdPvtCiEvT3Sc9WwCLWMmRdQfTUCWaIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZdZtnUvo; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VGKtM0Kq5zJF2;
	Fri, 12 Apr 2024 17:17:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712935034;
	bh=DJiraOZMDp379CkBujxqNMaJDhKumWZkMrU0YsjFVdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZdZtnUvoWjjsmAoTR0ubXd+KdfOjwM8jxrmxG+vSjCOa192HQPbn2Byr3DoWaOA3g
	 1MjpjzUK/80rOMgHU+9AD43vDM9AmSFm93ZCyYH+5teDRl6p2jaIkDXxmCBt5AUXrh
	 ymTTaHQnJnpovo/1KihVQbVifaPj6/dKd8Uws40E=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VGKtL1xJtzkM7;
	Fri, 12 Apr 2024 17:17:14 +0200 (CEST)
Date: Fri, 12 Apr 2024 17:17:13 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	Kent Overstreet <kent.overstreet@linux.dev>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Dave Chinner <dchinner@redhat.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Theodore Ts'o <tytso@mit.edu>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v14 01/12] fs: Return ENOTTY directly if FS_IOC_GETUUID
 or FS_IOC_GETFSSYSFSPATH fail
Message-ID: <20240412.Eevae2airae1@digikod.net>
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
X-Infomaniak-Routing: alpha

Could we have a test that failed if this patch is not applied?  I'm not
sure this is possible because it would require a device file to handle
FS_IOC_GETUUID, which wouldn't be worth it implementing for this test.


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
> 

