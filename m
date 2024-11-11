Return-Path: <linux-fsdevel+bounces-34361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5E99C4A5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 01:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B331B33A50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 00:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8D01C3F1D;
	Tue, 12 Nov 2024 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OueZ1Yqn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECE91586CB;
	Mon, 11 Nov 2024 23:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731369600; cv=none; b=IAtTZfni0ii4xKmHuLBIFcu6RXD/gi3ZeLZHRGBuPFqH41niiqJgEnRu2bsZn3z5slfmxPZkBXeKW0fiCQRoOtkPVtL3uGBsTmcY9ogBO+qBDQzYJMD41wZ8/oIweXrN8JxXzfdVwfaIU9gQySaPvdUnpFr4iIPxcAhJT7WuLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731369600; c=relaxed/simple;
	bh=DBeXyiPoEk4jq3UvI4MGD72KO9awpusbXnD6ozAC/YM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Woq3L2L7M9EOESYNzhwZntMMs7MGvwEejupLle9iafZsrDlB2mKBOzgl6o7qlzVqQ73RBFraJ9iyX8peTemQ+B52yq7PlMZv0AvqRyuhI2LCiuuoBSQyNImdfWIMGmm0AzqYskb5MACFKZpZx/xTznTYbmTKe4lmCS39H0ZxIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OueZ1Yqn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cefc36c5d4so7020078a12.0;
        Mon, 11 Nov 2024 15:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731369597; x=1731974397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeb/sGQBQbggfnIh8ADSPE4+Kba4+lOc0hxRhJ4OMyo=;
        b=OueZ1Yqnv5jZcJE31dC2hAdSvQUxwi1Z2Cklyvl4RyDE5Nil/Ahj/rwIETLNYtP3v9
         2dEBjEph/oE6fa8xTWfiSIj77aY/+ONJaGintvdw4w1Nwson6BOoAYZjkSEx/VhsDn0M
         dZvNMbXSCTR2sqSAfV1i2pdi3yGvyfmZ5bjYMBmOyAGW5KxiFReJJuiTKo8kU7lvLdiz
         DG1UO38QXrp2PkppHJYEnL1R5IiUkR475DZ4Hip0X2zkHz9kWOq6n4zynE1K7+WBzrj8
         ngbMzTlhfqAJPa5KPGk7P306kBcF/vOjrZIsmkUkWbNGvV3XPJzKtK79s5ovFB0BHUcO
         OAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731369597; x=1731974397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeb/sGQBQbggfnIh8ADSPE4+Kba4+lOc0hxRhJ4OMyo=;
        b=oAFb4G6chtDJdhS8gDfoZxUYVAJNSySaNMFQQoott8gQ7dGJ0qIPd4fxcSwfo8YnLM
         fBNHLAmW5S9f78vAsiRCHfCfAEQC4kTBdKGbscoIcJP7HKA4AKfJNhsD4XJLRoaLQJpa
         bqLRbOPKbpUcIZ4LpGRCiicNFNUi+8PjRuJFNqwjeUFjTTLMDqQb59Ve/gEtdg7jG/uA
         7hDMTKcq3JzyRrUDLbKj38p5Xj2dXlhlIF51BZn1IBnT9YfqCGQNAatr4FAdhqIMPH+7
         S9GZJhUu19zE6lmA7x8qJuz1X8WTTewggweiC92/+Lv+TPkfi1WQ54+LAcd6W6zK6ieo
         05jg==
X-Forwarded-Encrypted: i=1; AJvYcCU05jm4uJlt7ZnWJgCNuyr6IpeWb5/YvvGZV9VPI1bzb0+hRe5g7OnSJL4Chtb2McWmuozXls0wCrbnFA==@vger.kernel.org, AJvYcCVDwosZte4aft4mJB3CJmnlws0Bp57BHvE3TZJFlW/HSakwlmHRdT/iEyEYkYBgfDsp3lpo1muz24ic@vger.kernel.org, AJvYcCVdJNchje5AxulmwxvogYjgZMPCAah3RlRkHveYiw7kOoLgGPpYtfnT9R7I14KPe1RRlm88Qz9Gt/dYmg==@vger.kernel.org, AJvYcCWOM4+R5QaN+dJKNGWTcRCZj/yS5FGrcM+PJ+UM9q4ZvLua2wXFmI1dlIRlKC55aNWm7IS/Wjyy8DWtxBopbw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo7MJWo7ucOWGdCpqzpUdscVce4orc5UrwZpsxtFqb6d4bY1dm
	R1KUADGjT1XjTSwcCsmZDUJCNkubQKIemHxnoyb9kpZg1RYYHZVvp6fHGC2nPg6Usetb5TL0F0h
	SqAfSu9lmDxnohUAdZwX5ewRSaPQ=
X-Google-Smtp-Source: AGHT+IHHwxY/TJOQ7Nuz4nknIlqtFJHiuYgNFoMDUB8JaLJfrMkEmhf3QjspysraBHI4CEeJBsEvdbsAjRJvE47Uc7Q=
X-Received: by 2002:a17:906:6a19:b0:a99:d6cf:a1df with SMTP id
 a640c23a62f3a-a9eeffee0e2mr1462283866b.46.1731369596890; Mon, 11 Nov 2024
 15:59:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731355931.git.josef@toxicpanda.com> <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
 <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
 <CAEzrpqdtSAoS+p4i0EzWFr0Nrpw1Q2hphatV7Sk4VM49=L3kGw@mail.gmail.com> <CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com>
In-Reply-To: <CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 Nov 2024 00:59:43 +0100
Message-ID: <CAOQ4uxgxtQhe_3mj5SwH9568xEFsxtNqexLfw9Wx_53LPmyD=Q@mail.gmail.com>
Subject: Re: [PATCH v6 06/17] fsnotify: generate pre-content permission event
 on open
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:22=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 11 Nov 2024 at 14:46, Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > Did you see the patch that added the
> > fsnotify_file_has_pre_content_watches() thing?
>
> No, because I had gotten to patch 6/11, and it added this open thing,
> and there was no such thing in any of the patches before it.
>
> It looks like you added FSNOTIFY_PRE_CONTENT_EVENTS in 11/17.
>
> However, at no point does it look like you actually test it at open
> time, so none of this seems to matter.
>
> As far as I can see, even at the end of the series, you will call the
> fsnotify hook at open time even if there are no content watches on the
> file.
>
> So apparently the fsnotify_file_has_pre_content_watches() is not
> called when it should be, and when it *is* called, it's also doing
> completely the wrong thing.
>
> Look, for basic operations THAT DON'T CARE, you now added a function
> call to fsnotify_file_has_pre_content_watches(), that function call
> looks at inode->i_sb->s_iflags (doing two D$ accesses that shouldn't
> be done!), and then after that looks at the i_fsnotify_mask.
>
> THIS IS EXACTLY THE KIND OF GARBAGE I'M TALKING ABOUT.
>
> This code has been written by somebody who NEVER EVER looked at
> profiles. You're following chains of pointers when you never should.
>
> Look, here's a very basic example of the kind of complete mis-design
> I'm talking about:
>
>  - we're doing a basic read() on a file that isn't being watched.
>
>  - we want to maybe do read-ahead
>
>  - the code does
>
>         if (fsnotify_file_has_pre_content_watches(file))
>                 return fpin;
>
>    to say that "don't do read-ahead".
>
> Fine, I understand the concept. But keep in mind that the common case
> is presumably that there are no content watches.
>
> And even ignoring the "common case" issue, that's the one you want to
> OPTIMIZE for. That's the case that matters for performance, because
> clearly if there are content watches, you're going to go into "Go
> Slow" mode anyway and not do pre-fetching. So even if content watches
> are common on some load, they are clearly not the case you should do
> performance optimization for.
>
> With me so far?
>
> So if THAT is the case that matters, then dammit, we shouldn't be
> calling a function at all.
>
> And when calling the function, we shouldn't start out with this
> completely broken logic:
>
>         struct inode *inode =3D file_inode(file);
>         __u32 mnt_mask =3D real_mount(file->f_path.mnt)->mnt_fsnotify_mas=
k;
>
>         if (!(inode->i_sb->s_iflags & SB_I_ALLOW_HSM))
>                 return false;
>
> that does random crap and looks up some "mount mask" and looks up the
> superblock flags.
>
> Why shouldn't we do this?
>
> BECAUSE NONE OF THIS MATTERS IF THE FILE HASN'T EVEN BEEN MARKED FOR
> CONTENT MATCHES!
>
> See why I'm shouting? You're doing insane things, and you're doing
> them for all the cases that DO NOT MATTER. You're doing all of this
> for the common case that doesn't want to see that kind of mindless
> overhead.
>
> You literally check for the "do I even care" *last*, when you finally
> do that fsnotify_object_watched() check that looks at the inode. But
> by then you have already wasted all that time and effort, and
> fsnotify_object_watched() is broken anyway, because it's stupidly
> designed to require that mnt_mask that isn't needed if you have
> properly marked each object individually.
>
> So what *should* you have?
>
> You should have had a per-file flag saying "Do I need to even call
> this crud at all", and have it in a location where you don't need to
> look at anything else.
>
> And fsnotify already basically has that flag, except it's mis-designed
> too. We have FMODE_NONOTIFY, which is the wrong way around (saying
> "don't notify", when that should just be the *default*), and the
> fsnotify layer uses it only to mark its own internal files so that it
> doesn't get called recursively. So that flag that *looks* sane and is
> in the right location is actually doing the wrong thing, because it's
> dealing with a rare special case, not the important cases that
> actually matter.
>
> So all of this readahead logic - and all of the read and write hooks -
> should be behind a simple "oh, this file doesn't have any notification
> stuff, so don't bother calling any fsnotify functions".
>
> So I think the pattern should be
>
>     static inline bool fsnotify_file_has_pre_content_watches(struct file =
*file)
>     {
>         if (unlikely(file->f_mode & FMODE_NOTIFY))
>                 return out_of_line_crud(file);
>         return false;
>     }
>

I think that's a good idea for pre-content events, because it's fine
to say that if the sb/mount was not watched by a pre-content event listener
at the time of file open, then we do not care.

The problem is that legacy inotify/fanotify watches can be added after
file is open,
so that is allegedly why this optimization was not done for fsnotify
hooks in the past.

Thanks,
Amir.

