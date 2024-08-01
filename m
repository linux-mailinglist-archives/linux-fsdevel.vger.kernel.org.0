Return-Path: <linux-fsdevel+bounces-24798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 654B1944EE5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 17:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C85D6B2708C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8BF19FA9D;
	Thu,  1 Aug 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/mDbm0w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062A313C3CD;
	Thu,  1 Aug 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525320; cv=none; b=MwPlxRNnMc7K8hVrpJwj9yUG1sOHlv/XVeizICekH6iHW+57bror4suyDeH9JpzPn7sn5GoVXH4tB2nK1BOPSv7sugER6fM4jTF+1KSROAXVr5yYUGwlK/bk69356NGfpZpX+p3ZGc8NMMWqX+aCBcOjeC0pu3QJTXW9c7AJAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525320; c=relaxed/simple;
	bh=IT1lteD7ekHREr8wSGlw6BLY61YLvWEiWnAN6g+tCqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJjCgSt+Ke2qwp8v7TTERez0q4GmS62Olu5bcVuOZH2aLVYrjkSSCL1JDd3c0aGR5BJJjBuks8lsVC/laAQW83SzbMS+yP5SsCdK1JQ7kc/41aNGO8UKoCG7/OtGTSM+O9W1SqQZw3jYFflDuPcLRFOvUZpnP/8U87d9Oh5K/YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/mDbm0w; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a81bd549eso677564866b.3;
        Thu, 01 Aug 2024 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722525317; x=1723130117; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kz66FuU/ARttOjZqWZbd30k8H0yCvS1lmutapB6qkKo=;
        b=e/mDbm0w+a9p3aFa8fcbftlS3eiSj+0rNZI3HlATxJecHUnVT55C5XE3Fuj4ejDrRp
         27O5/RB2Di7gjNgc5tLEsD5j3s3VrGVjQQSBZbhZUb81X5ZO42JQ1PAK7GqTidQqws6i
         MJ17EycpieCItKj5fpdxp6YespJLAlZXUV1fU+VMU+DXjwM1reHxFhb9cCP4lF9WNQ55
         kUgZXNoJxddLSfq1jp1kYHA/Y34HF3Px/wb7AlXDWfy9CocJZwOGJtk1yO/JW6RfU5en
         boOz4hrw62Lql7Mqzs01uVYJ0nOFmfpc4cZUS0xjk//dIwQnqbxuGpWLgvzgP/lYVAEy
         5Jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525317; x=1723130117;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kz66FuU/ARttOjZqWZbd30k8H0yCvS1lmutapB6qkKo=;
        b=e0BYv4rjieY0XduwOGebo6VoPBSeODlvDE79YUAwARHet+8yRW0OD64ifNhX2XdJkP
         pS1BUIH4mMX2GRQ5e+Y/39QNySaX4kQCH0wXP1ugZjNSLA09uYLU3pRGIeWiUSVvMyu8
         8lcuV53uNU9ExtgFcnGU0zKfh7BA9zMWdXuX0Ru20AeHqURsJclejBw7cXK6Fj3mjfeX
         qmNtprJdWq7j+qnR0oNlVGYmnML2HD0NqkqsnbYe5XYXZHDZ6bOMIojb2WrI4RswZiH2
         tOHgZRO7HKBVQclm56C8zonMimyjlQKBNw+bgtLuImoRvYG+i1zn46aaPXDIVjUuNU68
         VQ1w==
X-Forwarded-Encrypted: i=1; AJvYcCWz1uSBKyXMmMXH5BgifkyKHVNBu9enq0oV+ut3oYUrobCfthZuzrtsoATiVBPFVCE7ZP1gM21bO4f6+fgm8H8itYRYLDGzNEj95hzCDeh49Rhgzn35LWsjqnKmpCMAtUdeiuSrGYRdJZhb6Q==
X-Gm-Message-State: AOJu0Yzsf+D4o57RN2KuW18IRKet9H+ai7p59R86CE51//9kE6t+Ripl
	YNA62yVBL0hzTk0Xk49yTSU/Mon1tASLSNurGGwb1SzF1cHVbP3l
X-Google-Smtp-Source: AGHT+IEppeybcKSETEZ5zmIwCIBD+KqgNyxaSp2b7YPCA2K65+OU77JOwmEz1c02mFRC9iOAzsvAiw==
X-Received: by 2002:a17:907:724b:b0:a77:eb34:3b4b with SMTP id a640c23a62f3a-a7dc4dc02a3mr47413266b.11.1722525316792;
        Thu, 01 Aug 2024 08:15:16 -0700 (PDT)
Received: from f (cst-prg-90-207.cust.vodafone.cz. [46.135.90.207])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad4146dsm907559566b.114.2024.08.01.08.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:15:16 -0700 (PDT)
Date: Thu, 1 Aug 2024 17:15:06 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Wojciech =?utf-8?Q?G=C5=82adysz?= <wojciech.gladysz@infogain.com>, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, ebiederm@xmission.com, 
	kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/fs: last check for exec credentials on NOEXEC
 mount
Message-ID: <mtnfw62q32omz5z4ptiivmzi472vd3zgt7bpwx6bmql5jaozgr@5whxmhm7lf3t>
References: <20240801120745.13318-1-wojciech.gladysz@infogain.com>
 <20240801140739.GA4186762@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240801140739.GA4186762@perftesting>

On Thu, Aug 01, 2024 at 10:07:39AM -0400, Josef Bacik wrote:
> On Thu, Aug 01, 2024 at 02:07:45PM +0200, Wojciech Gładysz wrote:
> > Test case: thread mounts NOEXEC fuse to a file being executed.
> > WARN_ON_ONCE is triggered yielding panic for some config.
> > Add a check to security_bprm_creds_for_exec(bprm).
> > 
> 
> Need more detail here, a script or something to describe the series of events
> that gets us here, I can't quite figure out how to do this.
> 
> > Stack trace:
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 2736 at fs/exec.c:933 do_open_execat+0x311/0x710 fs/exec.c:932
> > Modules linked in:
> > CPU: 0 PID: 2736 Comm: syz-executor384 Not tainted 5.10.0-syzkaller #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > RIP: 0010:do_open_execat+0x311/0x710 fs/exec.c:932
> > Code: 89 de e8 02 b1 a1 ff 31 ff 89 de e8 f9 b0 a1 ff 45 84 ff 75 2e 45 85 ed 0f 8f ed 03 00 00 e8 56 ae a1 ff eb bd e8 4f ae a1 ff <0f> 0b 48 c7 c3 f3 ff ff ff 4c 89 f7 e8 9e cb fe ff 49 89 de e9 2d
> > RSP: 0018:ffffc90008e07c20 EFLAGS: 00010293
> > RAX: ffffffff82131ac6 RBX: 0000000000000004 RCX: ffff88801a6611c0
> > RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
> > RBP: ffffc90008e07cf0 R08: ffffffff8213173f R09: ffffc90008e07aa0
> > R10: 0000000000000000 R11: dffffc0000000001 R12: ffff8880115810e0
> > R13: dffffc0000000000 R14: ffff88801122c040 R15: ffffc90008e07c60
> > FS:  00007f9e283ce6c0(0000) GS:ffff888058a00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f9e2848600a CR3: 00000000139de000 CR4: 0000000000352ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  bprm_execve+0x60b/0x1c40 fs/exec.c:1939
> >  do_execveat_common+0x5a6/0x770 fs/exec.c:2077
> >  do_execve fs/exec.c:2147 [inline]
> >  __do_sys_execve fs/exec.c:2223 [inline]
> >  __se_sys_execve fs/exec.c:2218 [inline]
> >  __x64_sys_execve+0x92/0xb0 fs/exec.c:2218
> >  do_syscall_64+0x6d/0xa0 arch/x86/entry/common.c:62
> >  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> > RIP: 0033:0x7f9e2842f299
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f9e283ce218 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
> > RAX: ffffffffffffffda RBX: 00007f9e284bd3f8 RCX: 00007f9e2842f299
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000400
> > RBP: 00007f9e284bd3f0 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9e2848a134
> > R13: 0030656c69662f2e R14: 00007ffc819a23d0 R15: 00007f9e28488130
> > 
> > Signed-off-by: Wojciech Gładysz <wojciech.gladysz@infogain.com>
> > ---
> >  fs/exec.c | 42 +++++++++++++++++++-----------------------
> >  1 file changed, 19 insertions(+), 23 deletions(-)
> > 
> > diff --git a/fs/exec.c b/fs/exec.c
> > index a126e3d1cacb..0cc6a7d033a1 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -953,8 +953,6 @@ EXPORT_SYMBOL(transfer_args_to_stack);
> >   */
> >  static struct file *do_open_execat(int fd, struct filename *name, int flags)
> >  {
> > -	struct file *file;
> > -	int err;
> >  	struct open_flags open_exec_flags = {
> >  		.open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
> >  		.acc_mode = MAY_EXEC,
> > @@ -969,26 +967,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
> >  	if (flags & AT_EMPTY_PATH)
> >  		open_exec_flags.lookup_flags |= LOOKUP_EMPTY;
> >  
> > -	file = do_filp_open(fd, name, &open_exec_flags);
> > -	if (IS_ERR(file))
> > -		goto out;
> > -
> > -	/*
> > -	 * may_open() has already checked for this, so it should be
> > -	 * impossible to trip now. But we need to be extra cautious
> > -	 * and check again at the very end too.
> > -	 */
> > -	err = -EACCES;
> > -	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
> > -			 path_noexec(&file->f_path)))
> > -		goto exit;
> > -
> 
> This still needs to be left here to catch any bad actors in the future.  Thanks,
> 

This check is fundamentally racy.

path_noexec expands to the following:
        return (path->mnt->mnt_flags & MNT_NOEXEC) ||
               (path->mnt->mnt_sb->s_iflags & SB_I_NOEXEC);

An exec racing against remount setting the noexec flag can correctly
conclude the file can be execed and then trip over the check later if
the flag showed up in the meantime.

This is not fuse-specific and I disagree with the posted patch as well.

The snippet here tries to validate that permissions were correctly checked
at some point, but it fails that goal in 2 ways:
- the inode + fs combo might just happen to be fine for exec, even if
  may_open *was not issued*
- there is the aforementioned race

If this thing here is supposed to stay, it instead needs to be
reimplemented with may_open setting a marker "checking for exec was
performed and execing is allowed" somewhere in struct file.

I'm not confident this is particularly valuable, but if it is, it
probably should hide behind some debug flags.

