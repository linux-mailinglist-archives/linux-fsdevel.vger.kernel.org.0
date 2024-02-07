Return-Path: <linux-fsdevel+bounces-10541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB7E84C14D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 01:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4599C1C214B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 00:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA414689;
	Wed,  7 Feb 2024 00:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="owOPz0Ft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984CC320A
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 00:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707265248; cv=none; b=WU7+eS4cMy8Ed4KyIIBnTYWcB9awsaQtdq0Nd9doGAKLKSah64eg0LjlzFtn8dIpcucwqop3SW3kklTtRg49mLfQf8y5khsA0qgSFy5SdSsRrtuEY2PnVni/oI0wzQEkXdmdYOYLDnMXEZ6b2VWwwiZCbjr08Hfr4Um3cmZr2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707265248; c=relaxed/simple;
	bh=ClMmOPCFmH/6Ksgfa+SOlxvhUma7Q2HOGymy3+SEnec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQMR5OCtduviUV0U9TYFPC5fbz8USwhflgDxWy3o+IcA4ty7O5uwA15B9J41XiU9rW6k87DgUMCywxeKXdIp23E/bOFUnqWxWMGS2FgUY3gV5YZsMNPodM/pUkA2VVF1W28DK7nztwQwQLe0S1Cxxj2J/5d8XXxFAsAIqMMnnJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=owOPz0Ft; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ce942efda5so11240a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 16:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707265246; x=1707870046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xurpwFdNldy5a43C8x3u+zLZtuzGTp5D1pD7HBDvZoc=;
        b=owOPz0FtatUSBKltM/eCgtG+lE3sMC/AYgegW7NkiROgDfRlXOoCcBv+LxDfTyQcXT
         K1Jpf1zQS8vXcE/T25CVQ1YEkGD4dv0uY7CVBB+UVz7fsqCK800yihCoKosUd8SaSJsX
         xzOCUy+vf3Ev93P8LOr9cL2RfupL6dzZJHXPueh6ZtJPxIYPKiaHQE2Wc6emyqPBFvkB
         wMi2st9n8Ps7Cs0Jz0hwkXaHILF8lyHhAEg10uakj69OO4Rlfe9l8kpQyjlTvdZDB+lI
         V6VZraMQALjTmtyRECa9xkrbLdO+IKovgxerPV3AxnmmcSQK1RKhgIYAnZXjnojLI7qu
         hoaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707265246; x=1707870046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xurpwFdNldy5a43C8x3u+zLZtuzGTp5D1pD7HBDvZoc=;
        b=fWWiPVo29KwvcSAfpdar2TjSgd9B5ncyH9NpKX7Vht2oegMOlfC6mN1U+Bm432z64Q
         M3JMPcWowEBslaX9j8Xp6M1WN918ZGpWizHjM0oH7u3qTWb1wzsvafHYCDkbHDXY1H0U
         P0sXgMi2mwgb1hvgL5hebKy/6Hvn966rg84kyhUkaNytK6CUBWjY9jmoTUdId8YIga91
         3hi/t7IBnV2mFGKaVVcUvec+9EF5AQQ6NSMzXXvfu2RP1u8o+XoZbsxfK1ILUzqcSZ0v
         cmPU7bzHnzQ7738kTKgAKC4/Xd1Ml6Eg+mY52gC21p19Dip8/5yYRwU2kkbU3Wq1Quc2
         QbYw==
X-Gm-Message-State: AOJu0YzkBjLnbN9Lxp+53Tcf4FK+fF4OhGVdVm2gcyyWweXc8gCMR70q
	AeSWXkvZdbp8sA8VPVWn1yUFnQnxWuWRk61rXzU3NflNrC6uzFhpFRle9rkz7mo=
X-Google-Smtp-Source: AGHT+IF8twI7ftb08mDIR98Af5TRgbBRPMHph5yBr+fYyqBAwVo5BvfgXqyCRrLPcFKAg6PsVZgW6A==
X-Received: by 2002:a05:6a21:339d:b0:19c:aba2:69e5 with SMTP id yy29-20020a056a21339d00b0019caba269e5mr3572946pzb.45.1707265245829;
        Tue, 06 Feb 2024 16:20:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXl4DRRtp4/GlKt7mHd4EOTMTbXwbjSRdRoMPgx4uuppxHN2Apvk65L5wczgD0dn5kGdTTiNp9v0RPYnhtp1/GDmYpD85kJYY26k/+HLsVWUaSM7nyyTMbAA2cJOK0V92wjTeQQjO8ynnygv4seb5bOG8WqY36b2IOTltX56OS0MZL9aE5bDJ6PB91ol3cH++d2YC7FLuoE6I6tKC2Yrbx88I3mdK9c/IwLh05qVN52dbKD0MgNn1jxvYbjoKbguVQCfem4sKI5sHmkWGhMYA==
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id hq6-20020a056a00680600b006e03be933cesm89563pfb.96.2024.02.06.16.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 16:20:45 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rXVgA-0032zx-2J;
	Wed, 07 Feb 2024 11:20:42 +1100
Date: Wed, 7 Feb 2024 11:20:42 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.or
Subject: Re: [PATCH v2 3/7] fs: FS_IOC_GETUUID
Message-ID: <ZcLM2t11U86twC/Y@dread.disaster.area>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240206201858.952303-4-kent.overstreet@linux.dev>
 <ZcKsIbRRfeXfCObl@dread.disaster.area>
 <cm4wbdmpuq6mlyfqrb3qqwyysa3qao6t5sc2eq3ykmgb4ptpab@qkyberqtvrtt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cm4wbdmpuq6mlyfqrb3qqwyysa3qao6t5sc2eq3ykmgb4ptpab@qkyberqtvrtt>

On Tue, Feb 06, 2024 at 05:37:22PM -0500, Kent Overstreet wrote:
> On Wed, Feb 07, 2024 at 09:01:05AM +1100, Dave Chinner wrote:
> > On Tue, Feb 06, 2024 at 03:18:51PM -0500, Kent Overstreet wrote:
> > > +static int ioctl_getfsuuid(struct file *file, void __user *argp)
> > > +{
> > > +	struct super_block *sb = file_inode(file)->i_sb;
> > > +
> > > +	if (!sb->s_uuid_len)
> > > +		return -ENOIOCTLCMD;
> > > +
> > > +	struct fsuuid2 u = { .len = sb->s_uuid_len, };
> > > +	memcpy(&u.uuid[0], &sb->s_uuid, sb->s_uuid_len);
> > > +
> > > +	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
> > > +}
> > 
> > Can we please keep the declarations separate from the code? I always
> > find this sort of implicit scoping of variables both difficult to
> > read (especially in larger functions) and a landmine waiting to be
> > tripped over. This could easily just be:
> > 
> > static int ioctl_getfsuuid(struct file *file, void __user *argp)
> > {
> > 	struct super_block *sb = file_inode(file)->i_sb;
> > 	struct fsuuid2 u = { .len = sb->s_uuid_len, };
> > 
> > 	....
> > 
> > and then it's consistent with all the rest of the code...
> 
> The way I'm doing it here is actually what I'm transitioning my own code
> to - the big reason being that always declaring variables at the tops of
> functions leads to separating declaration and initialization, and worse
> it leads people to declaring a variable once and reusing it for multiple
> things (I've seen that be a source of real bugs too many times).
> 
> But I won't push that in this patch, we can just keep the style
> consistent for now.
> 
> > > +/* Returns the external filesystem UUID, the same one blkid returns */
> > > +#define FS_IOC_GETFSUUID		_IOR(0x12, 142, struct fsuuid2)
> > > +
> > 
> > Can you add a comment somewhere in the file saying that new VFS
> > ioctls should use the "0x12" namespace in the range 142-255, and
> > mention that BLK ioctls should be kept within the 0x12 {0-141}
> > range?
> 
> Well, if we're going to try to keep the BLK_ and FS_IOC_ ioctls in
> separate ranges, then FS_IOC_ needs to move to something else becasue
> otherwise BLK_ won't have a way to expand.

The BLK range can grow downwards towards zero, I think. It starts at
93 and goes to 136, so there's heaps of space for it to grow from 92
to 0....

> So what else -
> 
> ioctl-number.rst has a bunch of other ranges listed for fs.h, but 0x12
> appears to be the only one without conflicts - all the other ranges seem
> to have originated with other filesystems.

*nod*

> So perhaps I will take Darrick's nak (0x15) suggestion after all.

That works, too.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

