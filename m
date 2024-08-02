Return-Path: <linux-fsdevel+bounces-24890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DB294612C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 18:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34272835E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 16:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C4D166F0A;
	Fri,  2 Aug 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="lH5mMHAX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1101537C6
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Aug 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614345; cv=none; b=I18fOu6Tp4r/c93tLGNOCMnYco00djSorcqxepcLHxncMuOuNTsgPLxvfVfxCshzgNuYEatG7iDrCbfBZG/DKJ8GQuoacVcrToHMyVIkx+oNrZi7W2w53yvTQ02igsA7XKLPN5i2DtNgMB7g5aL2AM8DOD0IBCtv3j4ZNSK9Vsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614345; c=relaxed/simple;
	bh=K7V2bYIOSvHVC1lJhx2wo3CbfVszEZTl5iQkYkWZAbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtCI1ypG0PzGFfURbpJBlRILI9nmVuCy2BEsdh0O/jpzC++ZrNWVwwt+9JTF/T2duZsuyPIfwgt1YcpSMlkbD4avD2zLD03SpJOnr4LVBNs8r76SyWiojHZYnf3ZrXqy0a7zBnEQH0SqRtMwe1uDqufIRZDFQN8TJMl7zEgQ3/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=lH5mMHAX; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-67682149265so70360367b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Aug 2024 08:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722614341; x=1723219141; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=411U8k9mMC3IZL6s6SMQtlI1/hffpCMVW4TK9o1PCQs=;
        b=lH5mMHAXAAXNyNnVGBR6daimhYUwjIy5AtEIt4BpVWsvpEBL1BLTWlaQKKvQNNyyT4
         fSYmKKEQG9r9FFsd+DJlsysI2h+WeDVkqzg4P8tXD/qFgwbJibIDrmJTLdkoAA0tRvqV
         yUJyxewFc09H0Lbm4idDuDBhYf9O3FXI/CIE5ppahH+0/qtNu9fVjx8N2GTfHo2HiBfL
         /WgIl9KKcCEkfXt1crM4hxh94+Tl/2wDEKJUDuexlSjVBEehd/pySNhlogu6Hw6q4An1
         jBxiOIic6veY8WvaZmsni5EHCXIohqzpAwHevVJ1tVvICwjRVIA6oj4A3xNqQvPAdt6q
         a3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722614341; x=1723219141;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=411U8k9mMC3IZL6s6SMQtlI1/hffpCMVW4TK9o1PCQs=;
        b=GiCN/rPhkqQqxC8pFhQFo2FFpIwlym5R0IMDOVCtC983wKdMcmyByyAQ5ST7EG4doS
         F/sizZbwsmsoH+uLNP1xfUz5xCYW8qtO9n4dFUFYqxDzdR7jMhMNssrIAoZl6Vc+dWz7
         jvGEEVqh/zQl4VFZBaTJ+1kFKh3J7E7VMdhpVWfQ97UvJDSlQmQ1XDmGCGgEzf4gl+Ze
         4H5FH0JYGlj7Pm8G20TF5p6lTBWB8us95WnsExiZKH72NYYrhjJ2DJ74/v5/MCHI67Ww
         TXF5Vnj0wfK1erskM+8P2d8gVkh7vl62WaanqPmnMvRc+iMM/jU0WddiPqBIOrJZJx50
         h/pA==
X-Forwarded-Encrypted: i=1; AJvYcCWp9q06E9/jro/LhWfugSOH9gKKUJ4z7bWNjCurLfIv3PEOolqLqBXc1JA69nMifecFb8cdAH5COYPTviOz7UCZ196q3gxGiZLwya+lvA==
X-Gm-Message-State: AOJu0Yz7sLx301UaAi3jDedVNsegE7tcfctBur7nua5LZg0pP/wRHg8L
	5V9Upj+R0bf1hqv4c4mONhRzVMlwPT4FVH382F1aAkkiNAEuPmAlKxazRDgN7hY=
X-Google-Smtp-Source: AGHT+IFGZiI6AUAkN7eJwQnP8DpPrdR8tAAe1cjOdO9L4E8zWgjvbtVtl9NTqmwHz+5c4nciO1RMng==
X-Received: by 2002:a81:c242:0:b0:65f:dfd9:b672 with SMTP id 00721157ae682-6895f9e5cdamr42031227b3.11.1722614340987;
        Fri, 02 Aug 2024 08:59:00 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a140613afsm2935237b3.136.2024.08.02.08.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:59:00 -0700 (PDT)
Date: Fri, 2 Aug 2024 11:58:59 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Wojciech =?utf-8?Q?G=C5=82adysz?= <wojciech.gladysz@infogain.com>,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	ebiederm@xmission.com, kees@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/fs: last check for exec credentials on NOEXEC
 mount
Message-ID: <20240802155859.GB6306@perftesting>
References: <20240801120745.13318-1-wojciech.gladysz@infogain.com>
 <20240801140739.GA4186762@perftesting>
 <mtnfw62q32omz5z4ptiivmzi472vd3zgt7bpwx6bmql5jaozgr@5whxmhm7lf3t>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mtnfw62q32omz5z4ptiivmzi472vd3zgt7bpwx6bmql5jaozgr@5whxmhm7lf3t>

On Thu, Aug 01, 2024 at 05:15:06PM +0200, Mateusz Guzik wrote:
> On Thu, Aug 01, 2024 at 10:07:39AM -0400, Josef Bacik wrote:
> > On Thu, Aug 01, 2024 at 02:07:45PM +0200, Wojciech Gładysz wrote:
> > > Test case: thread mounts NOEXEC fuse to a file being executed.
> > > WARN_ON_ONCE is triggered yielding panic for some config.
> > > Add a check to security_bprm_creds_for_exec(bprm).
> > > 
> > 
> > Need more detail here, a script or something to describe the series of events
> > that gets us here, I can't quite figure out how to do this.
> > 
> > > Stack trace:
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 2736 at fs/exec.c:933 do_open_execat+0x311/0x710 fs/exec.c:932
> > > Modules linked in:
> > > CPU: 0 PID: 2736 Comm: syz-executor384 Not tainted 5.10.0-syzkaller #0
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > > RIP: 0010:do_open_execat+0x311/0x710 fs/exec.c:932
> > > Code: 89 de e8 02 b1 a1 ff 31 ff 89 de e8 f9 b0 a1 ff 45 84 ff 75 2e 45 85 ed 0f 8f ed 03 00 00 e8 56 ae a1 ff eb bd e8 4f ae a1 ff <0f> 0b 48 c7 c3 f3 ff ff ff 4c 89 f7 e8 9e cb fe ff 49 89 de e9 2d
> > > RSP: 0018:ffffc90008e07c20 EFLAGS: 00010293
> > > RAX: ffffffff82131ac6 RBX: 0000000000000004 RCX: ffff88801a6611c0
> > > RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
> > > RBP: ffffc90008e07cf0 R08: ffffffff8213173f R09: ffffc90008e07aa0
> > > R10: 0000000000000000 R11: dffffc0000000001 R12: ffff8880115810e0
> > > R13: dffffc0000000000 R14: ffff88801122c040 R15: ffffc90008e07c60
> > > FS:  00007f9e283ce6c0(0000) GS:ffff888058a00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007f9e2848600a CR3: 00000000139de000 CR4: 0000000000352ef0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  bprm_execve+0x60b/0x1c40 fs/exec.c:1939
> > >  do_execveat_common+0x5a6/0x770 fs/exec.c:2077
> > >  do_execve fs/exec.c:2147 [inline]
> > >  __do_sys_execve fs/exec.c:2223 [inline]
> > >  __se_sys_execve fs/exec.c:2218 [inline]
> > >  __x64_sys_execve+0x92/0xb0 fs/exec.c:2218
> > >  do_syscall_64+0x6d/0xa0 arch/x86/entry/common.c:62
> > >  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> > > RIP: 0033:0x7f9e2842f299
> > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007f9e283ce218 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
> > > RAX: ffffffffffffffda RBX: 00007f9e284bd3f8 RCX: 00007f9e2842f299
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000400
> > > RBP: 00007f9e284bd3f0 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9e2848a134
> > > R13: 0030656c69662f2e R14: 00007ffc819a23d0 R15: 00007f9e28488130
> > > 
> > > Signed-off-by: Wojciech Gładysz <wojciech.gladysz@infogain.com>
> > > ---
> > >  fs/exec.c | 42 +++++++++++++++++++-----------------------
> > >  1 file changed, 19 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/fs/exec.c b/fs/exec.c
> > > index a126e3d1cacb..0cc6a7d033a1 100644
> > > --- a/fs/exec.c
> > > +++ b/fs/exec.c
> > > @@ -953,8 +953,6 @@ EXPORT_SYMBOL(transfer_args_to_stack);
> > >   */
> > >  static struct file *do_open_execat(int fd, struct filename *name, int flags)
> > >  {
> > > -	struct file *file;
> > > -	int err;
> > >  	struct open_flags open_exec_flags = {
> > >  		.open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
> > >  		.acc_mode = MAY_EXEC,
> > > @@ -969,26 +967,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
> > >  	if (flags & AT_EMPTY_PATH)
> > >  		open_exec_flags.lookup_flags |= LOOKUP_EMPTY;
> > >  
> > > -	file = do_filp_open(fd, name, &open_exec_flags);
> > > -	if (IS_ERR(file))
> > > -		goto out;
> > > -
> > > -	/*
> > > -	 * may_open() has already checked for this, so it should be
> > > -	 * impossible to trip now. But we need to be extra cautious
> > > -	 * and check again at the very end too.
> > > -	 */
> > > -	err = -EACCES;
> > > -	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
> > > -			 path_noexec(&file->f_path)))
> > > -		goto exit;
> > > -
> > 
> > This still needs to be left here to catch any bad actors in the future.  Thanks,
> > 
> 
> This check is fundamentally racy.
> 
> path_noexec expands to the following:
>         return (path->mnt->mnt_flags & MNT_NOEXEC) ||
>                (path->mnt->mnt_sb->s_iflags & SB_I_NOEXEC);
> 
> An exec racing against remount setting the noexec flag can correctly
> conclude the file can be execed and then trip over the check later if
> the flag showed up in the meantime.
> 
> This is not fuse-specific and I disagree with the posted patch as well.
> 
> The snippet here tries to validate that permissions were correctly checked
> at some point, but it fails that goal in 2 ways:
> - the inode + fs combo might just happen to be fine for exec, even if
>   may_open *was not issued*
> - there is the aforementioned race
> 
> If this thing here is supposed to stay, it instead needs to be
> reimplemented with may_open setting a marker "checking for exec was
> performed and execing is allowed" somewhere in struct file.

This sounds like a reasonable alternative solution.

> 
> I'm not confident this is particularly valuable, but if it is, it
> probably should hide behind some debug flags.

I'm still going to disagree here, putting it behind a debug flag means it'll
never get caught, and it obviously proved valuable because we're discussing this
particular case.

Is it racy? Yup sure.  I think that your solution is the right way to fix it,
and then we can have a 

WARN_ON(!(file->f_mode & FMODE_NO_EXEC_CHECKED));

or however we choose to flag the file, that way we are no longer racing with the
mount flags and only validating that a check that should have already occurred
has in fact occurred.  Thanks,

Josef

