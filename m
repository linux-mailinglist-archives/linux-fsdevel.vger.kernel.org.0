Return-Path: <linux-fsdevel+bounces-30976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20BF9902F4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3851F21B90
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E298115C120;
	Fri,  4 Oct 2024 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKsV7KT6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD47918E1F;
	Fri,  4 Oct 2024 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045142; cv=none; b=Um9u3IuUjQkO2Td77p89t0pADfSS4LiGv0CSDNEZY4t1xxJg64SPWNv4RHWQSLdInPKcr3cFp1A588HyxPgPBoM+7fsZwV4/oceZKUDsyv7leLIk9pCrMlRkNTT+utxLkBGIdnw2ufe07vjgY48hvTHCW9wafgkDEtWab+RC0bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045142; c=relaxed/simple;
	bh=5U8V8WOfJ3wtUdAdJe4BZi7CMbnDBGQF+fg1FNgkWpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+8PinTtsVFUwnPStj1dStR7lDxzNo/5rA4hAQZFzTt32+R8OFQNwjktUYTG/MLDouO5rYwM5l5i+F06GMMe/kO6Tp4PGxPtVEMrWUPU29FusNVZgud2IzLBm6RCeHmBFVfKpOcCqegJgksqrInSzgs8aBoz1yF+fbIuvbifs+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKsV7KT6; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-277dd761926so1340452fac.2;
        Fri, 04 Oct 2024 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728045139; x=1728649939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKC3ZzOfY1vnMThrPX5eHTYnINaF5X9h9PqNHEL1Mb4=;
        b=eKsV7KT6DY/uCDZdoejZnFAzKuBaLUxx1Ktua5+H87q1lopYsCx0LWJqFHCRNHlcdO
         StqPblnEQ0AN9wMeoD3gIazK7tH3RP922DUxeGO4HzT3JudyQMOXk58FbE6IB2y32neV
         b3J2akgH3qq/xLck9z7DI3J0mcBwnSf7RgL7My3ihISLMLEB5jjwQehFJDTRwTu3fUg+
         6rBBUgpJQpLOVe5QChDTcSENtcIe/X3S3851bu51uDRNBx33dpw6C0+7zAFVxgO+2oGu
         4GFdbVNivj5bC8zevth0l601U+kpGiLFhKaGfODEghpq8Bl+nQsuAnfTaLIHg6pMuRuA
         ZZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728045139; x=1728649939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKC3ZzOfY1vnMThrPX5eHTYnINaF5X9h9PqNHEL1Mb4=;
        b=CmtDEhrm2xXpI0QTgC/+0XYSYPBL9nBdb79IA9hC12RM8CQz7L+W4O8KCfUfExgT5m
         7rGDIvSLx0Lk0Ts5lBItDA+J2/m3n05Wdzx2DpV4jSE3ngS+PmS+fCOLr5eKb/p5RtiW
         l1ZOClc1fdLmhdgvWu1qbiZFmP7DNp68cXSLd64VHJgHzproTyEjNxhjcNpDJ2ulqQ2A
         HudKTV3ZHafJNWwaCbcudLhUZ0lXtpK2iz14L+u1k/XRS8QSSYMaq9s0bx+0PcrGXKDQ
         ElbO7lM68o23KWA3uTn0BqIy6rJmkrqcehEXWOL0fwsOSgLvMUXxatMvTGkWoGNfkEYk
         IC+w==
X-Forwarded-Encrypted: i=1; AJvYcCXZ8+ODlmdRNNoAFM+/711a2aUIcOGIxFc0Ida/gvjQJ+aYYIfW0Umq0UxdViD3YVm0MgTAmLc0ydwO@vger.kernel.org, AJvYcCXz0USADH6SpMJ1TFvztSSvZ2s3jxLk9Lk89LSJ/2Axgs4XAxagtSP2kCjd1B7Jy41DvEMFPYNA4nugccs6xg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8CQXu/Lf77vjEK/AIvviW4Oxee7KiCM9Hv1QYxWyyc2bA+uaJ
	vIEPeD7aMVjxqVtGRXRih/qSGpfyOS8h2VAQQD1HIHkD9EAQXXaUIsy05E/lcQzH+uewSToMtBH
	tao4JMMJWbzik1VokaioA6Pu0l0o=
X-Google-Smtp-Source: AGHT+IEni/Z/X/VHL065Ks4eUduiUbArksCcx/51P+E3Jkb5Q1CZodXv4yzVi9r8mymwk3BCnRIQlRXgZsjprXeDFg4=
X-Received: by 2002:a05:6870:f151:b0:254:bd24:de83 with SMTP id
 586e51a60fabf-287c1da64efmr1616401fac.12.1728045138732; Fri, 04 Oct 2024
 05:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805201241.27286-1-jack@suse.cz> <Zvp6L+oFnfASaoHl@t14s> <20240930113434.hhkro4bofhvapwm7@quack3>
In-Reply-To: <20240930113434.hhkro4bofhvapwm7@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 4 Oct 2024 14:32:07 +0200
Message-ID: <CAOQ4uxjXE7Tyz39wLUcuSTijy37vgUjYxvGL21E32cxStAgQpQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH] ext4: don't set SB_RDONLY after filesystem errors
To: Jan Kara <jack@suse.cz>
Cc: Jan Stancek <jstancek@redhat.com>, Christian Brauner <brauner@kernel.org>, Ted Tso <tytso@mit.edu>, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, ltp@lists.linux.it, 
	Gabriel Krisman Bertazi <gabriel@krisman.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 1:34=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 30-09-24 12:15:11, Jan Stancek wrote:
> > On Mon, Aug 05, 2024 at 10:12:41PM +0200, Jan Kara wrote:
> > > When the filesystem is mounted with errors=3Dremount-ro, we were sett=
ing
> > > SB_RDONLY flag to stop all filesystem modifications. We knew this mis=
ses
> > > proper locking (sb->s_umount) and does not go through proper filesyst=
em
> > > remount procedure but it has been the way this worked since early ext=
2
> > > days and it was good enough for catastrophic situation damage
> > > mitigation. Recently, syzbot has found a way (see link) to trigger
> > > warnings in filesystem freezing because the code got confused by
> > > SB_RDONLY changing under its hands. Since these days we set
> > > EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
> > > filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
> > > stop doing that.
> > >
> > > Link: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@google=
.com
> > > Reported-by: Christian Brauner <brauner@kernel.org>
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > > fs/ext4/super.c | 9 +++++----
> > > 1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > Note that this patch introduces fstests failure with generic/459 test=
 because
> > > it assumes that either freezing succeeds or 'ro' is among mount optio=
ns. But
> > > we fail the freeze with EFSCORRUPTED. This needs fixing in the test b=
ut at this
> > > point I'm not sure how exactly.
> > >
> > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > index e72145c4ae5a..93c016b186c0 100644
> > > --- a/fs/ext4/super.c
> > > +++ b/fs/ext4/super.c
> > > @@ -735,11 +735,12 @@ static void ext4_handle_error(struct super_bloc=
k *sb, bool force_ro, int error,
> > >
> > >     ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
> > >     /*
> > > -    * Make sure updated value of ->s_mount_flags will be visible bef=
ore
> > > -    * ->s_flags update
> > > +    * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
> > > +    * modifications. We don't set SB_RDONLY because that requires
> > > +    * sb->s_umount semaphore and setting it without proper remount
> > > +    * procedure is confusing code such as freeze_super() leading to
> > > +    * deadlocks and other problems.
> > >      */
> > > -   smp_wmb();
> > > -   sb->s_flags |=3D SB_RDONLY;
> >
> > Hi,
> >
> > shouldn't the SB_RDONLY still be set (in __ext4_remount()) for the case
> > when user triggers the abort with mount(.., "abort")? Because now we se=
em
> > to always hit the condition that returns EROFS to user-space.
>
> Thanks for report! I agree returning EROFS from the mount although
> 'aborting' succeeded is confusing and is mostly an unintended side effect
> that after aborting the fs further changes to mount state are forbidden b=
ut
> the testcase additionally wants to remount the fs read-only.

Regardless of what is right or wrong to do in ext4, I don't think that the =
test
really cares about remount read-only.
I don't see anything in the test that requires it. Gabriel?
If I remove MS_RDONLY from the test it works just fine.

Any objection for LTP maintainers to apply this simple test fix?

Thanks,
Amir.

--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -57,7 +57,7 @@ static struct fanotify_fid_t bad_link_fid;
 static void trigger_fs_abort(void)
 {
        SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
-                  MS_REMOUNT|MS_RDONLY, "abort");
+                  MS_REMOUNT, "abort");
 }

