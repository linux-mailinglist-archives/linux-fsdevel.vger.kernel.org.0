Return-Path: <linux-fsdevel+bounces-30980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5934899034F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78AC31C20B2A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9F220FAA1;
	Fri,  4 Oct 2024 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3QJrdpS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECB8148FF6
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046262; cv=none; b=pdaaE7SaI9AodcooYw6NmMJyAPiNvcnHG40kvZO7oUexo+YzRrl8moRTuswHiFaDOBZAiVK9wrRduJkhUYgbzELbqyF+sSlqTfGs9vgGyN5DHGzCAOP/BW2dIiCWij/VwTZB0g7XVyKmMylROXkMG8De9Q6GIj4ikJ1H+GnEds8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046262; c=relaxed/simple;
	bh=fTD2ucq9J26AkeNSNPlAWDmTU4qktKPFMukHQfAOpKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+kzJERKlO/nNZP1syUut2gpQ8CZy5VZoesBnWFry+fW5Gm3NDw6rfywhSLYHjNtqCi1yncqRi5gPArki2N2UJ9AyWz8XuNguQLRFSylocQJ5a27pcNM1JaaxSPDRme0okQTCeRc38dj0c+F1t+nF6k8YV6pWSkQWZS9RF601MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z3QJrdpS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728046258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVF8DgPOYH31LJm3NWs4Ti1Tq8gTaEHw5QsDrHnfb/s=;
	b=Z3QJrdpS7iQuZ/ih39BYvwOwtkoy2KyLtqdERxDBSasUtMmj9TzkyH2xtDOuRs+ztb/sX1
	xSjo/YMuB0VgBhhX80/Ti2384uNAny/TsMRC6glPJVO38c9rdeH8iQ84eRY6SHALbv/Sr0
	72H4zBG3euJJ8qy92MbVe3StXqg1nzY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-knsxtWiMN0SJlbqa-zbA-w-1; Fri, 04 Oct 2024 08:50:57 -0400
X-MC-Unique: knsxtWiMN0SJlbqa-zbA-w-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3e3a993fbc7so1800386b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Oct 2024 05:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728046256; x=1728651056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVF8DgPOYH31LJm3NWs4Ti1Tq8gTaEHw5QsDrHnfb/s=;
        b=p4y1klH0liCpA+OgRFVH861lfVtBnRI7OsSh/B2Hu/owjZOkbJR0JfYEgGPODCpKOn
         vkpHs+DG+W2wBwYM/Db1hTY1IM1GcZ2w2ZzaqE9OJGLXraX9JFrUK0DFvhd+FtBR/CDc
         UQW75KE3XbHi8VJFuyKrPYx/wna9TP4VD4fQtAtZ0abUzlpUL251vyQMR+UGt/WvyqHN
         wwiniQSPhIb0tH4ySCdg4ls9Q8QCXEvSLF4Cg/yl5J+4V+WU3PMkK0F1Y/+6FG1R9acV
         BSKE+Z7E0ossx15/LCmOUpw0Czi0R42hnuutQMRtbYEq/bgBpJA6AdJHiKkAh/qhHJOI
         sHIg==
X-Forwarded-Encrypted: i=1; AJvYcCVNBce1eGzIUykJCWEc52UmLXKoazscrXIJK1TitdDVFyh6iVZb7SIn505nSPj1Ychz7wTf0Eh1qydWeJtI@vger.kernel.org
X-Gm-Message-State: AOJu0YzDSaDZ85H9T9BqRkq532VPXiPC8H5/xCFHpR9+aX6KtGomF4Ez
	nEVLmmqfaciQnTW2evYK/MXvOgob7it2+BweriIAPR42q2OuyiAoyZpIUPcFzH1giHkb6hAqt3x
	L3U3CWKrixNaGrh/Q7xgTvZVcKcr5W09V6fWp7kQbNTNWclHsQ5fNLbPBvt9AYXdzMwC7BUdTzK
	SXtiQAbiyNxGDTqnLX1E+S/nh1wiBPqg6heqCU1x9rw+e2tb1M
X-Received: by 2002:a05:6808:448c:b0:3e3:c411:5e86 with SMTP id 5614622812f47-3e3c411848dmr812687b6e.35.1728046256380;
        Fri, 04 Oct 2024 05:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpqfAKYzgpxhx1Y0BybucSFPMqmPot5eRKUtb/w2XIi6XfDKI/xhyBng1Hj827T1HCrAcFDKKTHQWLD2IflRU=
X-Received: by 2002:a05:6808:448c:b0:3e3:c411:5e86 with SMTP id
 5614622812f47-3e3c411848dmr812677b6e.35.1728046256097; Fri, 04 Oct 2024
 05:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805201241.27286-1-jack@suse.cz> <Zvp6L+oFnfASaoHl@t14s>
 <20240930113434.hhkro4bofhvapwm7@quack3> <CAOQ4uxjXE7Tyz39wLUcuSTijy37vgUjYxvGL21E32cxStAgQpQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjXE7Tyz39wLUcuSTijy37vgUjYxvGL21E32cxStAgQpQ@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 4 Oct 2024 14:50:40 +0200
Message-ID: <CAASaF6yASRgEKfhAVktFit31Yw5e9gwMD0jupchD0gWK9EppTw@mail.gmail.com>
Subject: Re: [LTP] [PATCH] ext4: don't set SB_RDONLY after filesystem errors
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Ted Tso <tytso@mit.edu>, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, ltp@lists.linux.it, 
	Gabriel Krisman Bertazi <gabriel@krisman.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:32=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Mon, Sep 30, 2024 at 1:34=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 30-09-24 12:15:11, Jan Stancek wrote:
> > > On Mon, Aug 05, 2024 at 10:12:41PM +0200, Jan Kara wrote:
> > > > When the filesystem is mounted with errors=3Dremount-ro, we were se=
tting
> > > > SB_RDONLY flag to stop all filesystem modifications. We knew this m=
isses
> > > > proper locking (sb->s_umount) and does not go through proper filesy=
stem
> > > > remount procedure but it has been the way this worked since early e=
xt2
> > > > days and it was good enough for catastrophic situation damage
> > > > mitigation. Recently, syzbot has found a way (see link) to trigger
> > > > warnings in filesystem freezing because the code got confused by
> > > > SB_RDONLY changing under its hands. Since these days we set
> > > > EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
> > > > filesystem modifications, modifying SB_RDONLY shouldn't be needed. =
So
> > > > stop doing that.
> > > >
> > > > Link: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@goog=
le.com
> > > > Reported-by: Christian Brauner <brauner@kernel.org>
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > ---
> > > > fs/ext4/super.c | 9 +++++----
> > > > 1 file changed, 5 insertions(+), 4 deletions(-)
> > > >
> > > > Note that this patch introduces fstests failure with generic/459 te=
st because
> > > > it assumes that either freezing succeeds or 'ro' is among mount opt=
ions. But
> > > > we fail the freeze with EFSCORRUPTED. This needs fixing in the test=
 but at this
> > > > point I'm not sure how exactly.
> > > >
> > > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > > index e72145c4ae5a..93c016b186c0 100644
> > > > --- a/fs/ext4/super.c
> > > > +++ b/fs/ext4/super.c
> > > > @@ -735,11 +735,12 @@ static void ext4_handle_error(struct super_bl=
ock *sb, bool force_ro, int error,
> > > >
> > > >     ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
> > > >     /*
> > > > -    * Make sure updated value of ->s_mount_flags will be visible b=
efore
> > > > -    * ->s_flags update
> > > > +    * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
> > > > +    * modifications. We don't set SB_RDONLY because that requires
> > > > +    * sb->s_umount semaphore and setting it without proper remount
> > > > +    * procedure is confusing code such as freeze_super() leading t=
o
> > > > +    * deadlocks and other problems.
> > > >      */
> > > > -   smp_wmb();
> > > > -   sb->s_flags |=3D SB_RDONLY;
> > >
> > > Hi,
> > >
> > > shouldn't the SB_RDONLY still be set (in __ext4_remount()) for the ca=
se
> > > when user triggers the abort with mount(.., "abort")? Because now we =
seem
> > > to always hit the condition that returns EROFS to user-space.
> >
> > Thanks for report! I agree returning EROFS from the mount although
> > 'aborting' succeeded is confusing and is mostly an unintended side effe=
ct
> > that after aborting the fs further changes to mount state are forbidden=
 but
> > the testcase additionally wants to remount the fs read-only.
>
> Regardless of what is right or wrong to do in ext4, I don't think that th=
e test
> really cares about remount read-only.
> I don't see anything in the test that requires it. Gabriel?
> If I remove MS_RDONLY from the test it works just fine.
>
> Any objection for LTP maintainers to apply this simple test fix?

Does that change work for you on older kernels? On 6.11 I get EROFS:

fanotify22.c:59: TINFO: Mounting /dev/loop0 to
/tmp/LTP_fangb5wuO/test_mnt fstyp=3Dext4 flags=3D20
fanotify22.c:59: TBROK: mount(/dev/loop0, test_mnt, ext4, 32,
0x4211ed) failed: EROFS (30)

>
> Thanks,
> Amir.
>
> --- a/testcases/kernel/syscalls/fanotify/fanotify22.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
> @@ -57,7 +57,7 @@ static struct fanotify_fid_t bad_link_fid;
>  static void trigger_fs_abort(void)
>  {
>         SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
> -                  MS_REMOUNT|MS_RDONLY, "abort");
> +                  MS_REMOUNT, "abort");
>  }
>


