Return-Path: <linux-fsdevel+bounces-30992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF38990457
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 15:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FE61F21461
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 13:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D2521731D;
	Fri,  4 Oct 2024 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIkkx/Dv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2DB216A31;
	Fri,  4 Oct 2024 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048507; cv=none; b=F4Lfv4iCehxkc9j8ugASP3YXyxNXfQkoQWCsLLEIUaylfokn7OCIQ/ocUN3ngBWrDNKtcwlVyaJqhObx3PCqiDFO89eXOw8/jp1buhptM4hY4Y4Ad0lv1bqrD1fUcUNg1OnJ3+Zt2+JeSjfP27yAB215fPmPP07+Q1jIjm9Ug60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048507; c=relaxed/simple;
	bh=FWAanwgui+hTE2w/uN5Fsi1R1HgpTytUTuTEhs3O+nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejaY8zOs9cticGAa/tM+zszYT4A7shrAloixt+25eVD5zTMleDArDtDgZx7sf02ukSGdrvrc3x9D+4JKRt01c0LMECVx99eFHpZnaD/muxwOx7i0pl9J+pUMOlaNAH9wHnqDVJqywRZ9JshYEd6scIOcgonYAFKnkqpeE7sDx2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIkkx/Dv; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7ae3e3db294so122141585a.2;
        Fri, 04 Oct 2024 06:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728048504; x=1728653304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3D86/Xz7GWMcJfyoKry0xY7L2mFTRLNs/Qabyq5u3U=;
        b=jIkkx/DvzFpSO9+oKOz1pTNkgddqXtO25L67pJTn3akMhngIRssZXOVswwWOqPFY1p
         n1/dthYZWQ/+dZBJfg63xrreYOLWgiZpBoZyAu5XOAP9JRespDFg6QiMpu42Y8tCg6oh
         J9bf2qgvi+zCwVJVXTYxuLs6zgTYPT3SO+I56RNc0MkMGTC3XLThUIzwZcRCE1qQwn+A
         uKoGDR60HfD1+8HpXElt99mW7ikKLDvhAOFK2fnOdBvwFCBRLqDwcQ9m5WDvQ0DRLcRC
         npXPO/lSylMy/tLDDfFo/BeHneggqsgAoVH22ucSJc6cUoFYxu/SlFOlE9idblCi5rIn
         8xYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728048504; x=1728653304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3D86/Xz7GWMcJfyoKry0xY7L2mFTRLNs/Qabyq5u3U=;
        b=f/Gq4wQ8PPIDBwvhgTYqaUhZ4CtHwMxJ7qjBZJYG7XIq3aX3CkYy9MHmXKmWzlJh9M
         kz7rNnnkl8cb3mZFUv9bwbqfqv6OgiTOlFHDx1uIiaBHEpb/ny+5oImHX5phIG4PzEAQ
         snkvE0cR2JMBfw79LANhzeV+Nk+9uKD/LuJRFQdE5nmKBw+R6qx4W3slrjJ9lYZegui0
         Y86ls7POMHWBqjWux4ojLk4SJqs9a6Gj6Ty3UpYe1I6Bz7ygkjz79FYQXHYVExibhpcf
         3Nq/6aJaiqR2F+z7+xUi1SYes8uT9Rffrxf7JOHyJGH8to0cJSCn3A6Dma3E7/6Np64e
         +p8w==
X-Forwarded-Encrypted: i=1; AJvYcCUQ7bRt0dlezrULSNG3W4EnOp405QHFHZ5Vmut7SjVnaY75DvjrNhQFjh7LAQKrcQk3IVfzG/XWLVeO@vger.kernel.org, AJvYcCXgTBIvLyx18TtYUBJcYwWV8ShBq89br4ZMQkI6Lm8Jx/tPSGysD3pZa1ECpc92io6zzrQiJtx6jlkqdnOLCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1FpoCJow3eLEXxdOljMO4U+/udf8cgujSAF5Vkd8PEbhToB8m
	TXmtV9d1uYB1mq4WN64QLPPQDksIzNi7+pIqMiKM5fzCgsnXBhmyoh0/G1kThnrANym4lI5T3XK
	br8lYKMjt4SxQ34NBeMkEO6UkINI=
X-Google-Smtp-Source: AGHT+IFTuYdmM6+aufByiyaM0OZDHVhqwE7RcJfZ9RjNuzeqCS2P26MM8134E5yUf+F53VrT1DSjXIxIL2/tOnA+lxA=
X-Received: by 2002:a05:620a:31a5:b0:7a9:c129:297a with SMTP id
 af79cd13be357-7ae6f44cb1fmr465662585a.32.1728048504122; Fri, 04 Oct 2024
 06:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805201241.27286-1-jack@suse.cz> <Zvp6L+oFnfASaoHl@t14s>
 <20240930113434.hhkro4bofhvapwm7@quack3> <CAOQ4uxjXE7Tyz39wLUcuSTijy37vgUjYxvGL21E32cxStAgQpQ@mail.gmail.com>
 <CAASaF6yASRgEKfhAVktFit31Yw5e9gwMD0jupchD0gWK9EppTw@mail.gmail.com>
In-Reply-To: <CAASaF6yASRgEKfhAVktFit31Yw5e9gwMD0jupchD0gWK9EppTw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 4 Oct 2024 15:28:12 +0200
Message-ID: <CAOQ4uxjmtv88xoH0-s6D9WzRXv_stMsWB5+x2FMbdjCHyy1rmA@mail.gmail.com>
Subject: Re: [LTP] [PATCH] ext4: don't set SB_RDONLY after filesystem errors
To: Jan Stancek <jstancek@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Ted Tso <tytso@mit.edu>, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, ltp@lists.linux.it, 
	Gabriel Krisman Bertazi <gabriel@krisman.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:50=E2=80=AFPM Jan Stancek <jstancek@redhat.com> wr=
ote:
>
> On Fri, Oct 4, 2024 at 2:32=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
> >
> > On Mon, Sep 30, 2024 at 1:34=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Mon 30-09-24 12:15:11, Jan Stancek wrote:
> > > > On Mon, Aug 05, 2024 at 10:12:41PM +0200, Jan Kara wrote:
> > > > > When the filesystem is mounted with errors=3Dremount-ro, we were =
setting
> > > > > SB_RDONLY flag to stop all filesystem modifications. We knew this=
 misses
> > > > > proper locking (sb->s_umount) and does not go through proper file=
system
> > > > > remount procedure but it has been the way this worked since early=
 ext2
> > > > > days and it was good enough for catastrophic situation damage
> > > > > mitigation. Recently, syzbot has found a way (see link) to trigge=
r
> > > > > warnings in filesystem freezing because the code got confused by
> > > > > SB_RDONLY changing under its hands. Since these days we set
> > > > > EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
> > > > > filesystem modifications, modifying SB_RDONLY shouldn't be needed=
. So
> > > > > stop doing that.
> > > > >
> > > > > Link: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@go=
ogle.com
> > > > > Reported-by: Christian Brauner <brauner@kernel.org>
> > > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > > ---
> > > > > fs/ext4/super.c | 9 +++++----
> > > > > 1 file changed, 5 insertions(+), 4 deletions(-)
> > > > >
> > > > > Note that this patch introduces fstests failure with generic/459 =
test because
> > > > > it assumes that either freezing succeeds or 'ro' is among mount o=
ptions. But
> > > > > we fail the freeze with EFSCORRUPTED. This needs fixing in the te=
st but at this
> > > > > point I'm not sure how exactly.
> > > > >
> > > > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > > > index e72145c4ae5a..93c016b186c0 100644
> > > > > --- a/fs/ext4/super.c
> > > > > +++ b/fs/ext4/super.c
> > > > > @@ -735,11 +735,12 @@ static void ext4_handle_error(struct super_=
block *sb, bool force_ro, int error,
> > > > >
> > > > >     ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
> > > > >     /*
> > > > > -    * Make sure updated value of ->s_mount_flags will be visible=
 before
> > > > > -    * ->s_flags update
> > > > > +    * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
> > > > > +    * modifications. We don't set SB_RDONLY because that require=
s
> > > > > +    * sb->s_umount semaphore and setting it without proper remou=
nt
> > > > > +    * procedure is confusing code such as freeze_super() leading=
 to
> > > > > +    * deadlocks and other problems.
> > > > >      */
> > > > > -   smp_wmb();
> > > > > -   sb->s_flags |=3D SB_RDONLY;
> > > >
> > > > Hi,
> > > >
> > > > shouldn't the SB_RDONLY still be set (in __ext4_remount()) for the =
case
> > > > when user triggers the abort with mount(.., "abort")? Because now w=
e seem
> > > > to always hit the condition that returns EROFS to user-space.
> > >
> > > Thanks for report! I agree returning EROFS from the mount although
> > > 'aborting' succeeded is confusing and is mostly an unintended side ef=
fect
> > > that after aborting the fs further changes to mount state are forbidd=
en but
> > > the testcase additionally wants to remount the fs read-only.
> >
> > Regardless of what is right or wrong to do in ext4, I don't think that =
the test
> > really cares about remount read-only.
> > I don't see anything in the test that requires it. Gabriel?
> > If I remove MS_RDONLY from the test it works just fine.
> >
> > Any objection for LTP maintainers to apply this simple test fix?
>
> Does that change work for you on older kernels? On 6.11 I get EROFS:
>
> fanotify22.c:59: TINFO: Mounting /dev/loop0 to
> /tmp/LTP_fangb5wuO/test_mnt fstyp=3Dext4 flags=3D20
> fanotify22.c:59: TBROK: mount(/dev/loop0, test_mnt, ext4, 32,
> 0x4211ed) failed: EROFS (30)
>

Yeh me too, but if you change s/SAFE_MOUNT/mount
the test works just fine on 6.11 and 6.12-rc1 with or without MS_RDONLY.
The point of trigger_fs_abort() is to trigger the FS_ERROR event and it
does not matter whether remount succeeds or not for that matter at all.

So you can either ignore the return value of mount() or assert that it
can either succeed or get EROFS for catching unexpected errors.

Thanks,
Amir.

