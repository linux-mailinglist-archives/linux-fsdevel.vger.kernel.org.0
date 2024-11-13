Return-Path: <linux-fsdevel+bounces-34704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FECD9C7E50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 23:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFA4FB2701D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 22:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1150E18C90F;
	Wed, 13 Nov 2024 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSE8H3D+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C815444E;
	Wed, 13 Nov 2024 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731537331; cv=none; b=MsOeJ7LL0+6T3fwTfE9m1LnFnbcZd1+AFsRxONvaKEQVIwValJugaAT4+tAh/2LC4gCX5OMB6MYUpn5DM12FIjtKFYZNsxD9SxFNsDvyMBPoHS5mmxsliICSgkhvgp/8bc6SD1He65z9Sn1xQt6XxZQkNGMB2UHIIAAkVs6Kzcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731537331; c=relaxed/simple;
	bh=rjn0KiGgiLv1xsIPwjcqSSHf6SlULfYkhLvvSZTBIqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrDqpCqt8/sqHRNwnQW0fLrv3ZYIWtJrXHLy/wU7DQF4iyZDe/Y3l2swNlRt70K7s0Wr/AFwNuky79Iw6LFQPWeTzDY68dIS6wHEGhrKHoFHZV1ghJJsT5glXssKDn8DFlpUlXsFRTAgWuDZJOCNNX+vG2T/DyuSp8jhNsVP1pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSE8H3D+; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7180d9d0dcbso3394845a34.3;
        Wed, 13 Nov 2024 14:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731537329; x=1732142129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KDLg9To/YkPL+lMewcxLGFQQ9zp/mgylVTsqbiOTEQ=;
        b=mSE8H3D+HoORVw3G11NNbbXushkwbWfc0uBPO/YZ9YzRFgvZoXVAsK3n55sJ1BrThG
         V87wYhkQq8mZd7SHfMzumVEhsy3VqMY28lf3cvMjbjcVaS+ebHlH9veqp9xcImYHuMU/
         9m0dT7lpVOAzLWthY9XicU2UC2zHJB6LVPBzGDRoweL6FgZ19ozz120YR+svV8jzB12e
         EhaXUhoQPJaf0A4Il/wpjaTb9r3nmwlGXAbrrRvJSYlm87J1Xq3rX6vfKSLP1fDMmv+i
         IoLsXjvOzNlrVc9jZhzDN5q/1I8A7inPjoaR16NYXGLDPSFsYr9n9qww1eVuWiCBoavW
         uqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731537329; x=1732142129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KDLg9To/YkPL+lMewcxLGFQQ9zp/mgylVTsqbiOTEQ=;
        b=b5KlzXiSQWvVlIiWSznbZshSS5e26Q/UAAWO5dkD8AYa8PwyJM4eHS2iMa/Xciyygr
         Htm48Nj1Ml3qnQjRbArmec7qAClojT18/cQ6lj/AJOiAAZfNk+i5PrJNGeWw95Hs0Pwq
         5F4NBNDW1FQQmgCMgissS4tTGiE4azXEYSRLvggaPTxF3NSqO3S0bQXtRttEQt2ZTp5c
         Aq+R4e4JvvDUV2tzPYQDmiKO0qRS219IRf+hgHZn1OyejUtfprc64MxlZjvqIOUn0EaL
         2TWiwUmoZ25GawDm4coxPUTwZK2kzEqEcRHOuGhiwl7JMBFbTbBguu4lZPLYyj2L6cVN
         +HXg==
X-Forwarded-Encrypted: i=1; AJvYcCVEzAiQgquc4PQcRwW8ijKYku1xNjTlbeRVwxa0m8aGQb8T4CAhUCjz/eYZDvxJbgfwCIWxleTWzxBuWg==@vger.kernel.org, AJvYcCWzHWaCRPWcMLZ1oPgYcIFjil04r/KrN05eWTvy4zyT70o1YKkq+0tHBixokUly5ivHGvOFWEKwjfOzTo2Qxw==@vger.kernel.org, AJvYcCX8J53wR6IFqqHFgWA2cvB5N5iyHg9R3Ha3YQ1IUoz7OiC15KKHmnIE8KjYzymjj96pYUCG+I1R0ewL@vger.kernel.org, AJvYcCXHIsDlzl+5babYj8Hkwdtel5CdxLCVqjK8/Wi82OcHNdaXhTg63GtWIKLaOaCvo0i2Lze2FnKeYctbCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9mNzmIzwV1dzmEbthioWoJ+XhahSsYhAqCoG0kBgv/Kxb3udb
	a/W+KfRZ8S9s/6owCNaPRaPf+RR66TA8IJjdCTjy44l9iKqXlqK83N7/kvhYgZJ+vQgxhi8ecNK
	Z1/GJpIjkvYnXsjue3Q30/Wh52lw=
X-Google-Smtp-Source: AGHT+IEdZlQxt48o8J8iDRR0Lg99n+z9ualxe1wY20DVHLuL74dL16q0iW+CsMahVNFRcOyIZXBweMNj0cx54B5GAec=
X-Received: by 2002:a05:6830:2117:b0:718:18d6:a447 with SMTP id
 46e09a7af769-71a6020c4c3mr4694846a34.24.1731537328656; Wed, 13 Nov 2024
 14:35:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxjQHh=fUnBw=KwuchjRt_4JbaZAqrkDd93E2_mrqv_Pkw@mail.gmail.com> <CAHk-=wirrmNUD9mD5OByfJ3XFb7rgept4kARNQuA+xCHTSDhyw@mail.gmail.com>
In-Reply-To: <CAHk-=wirrmNUD9mD5OByfJ3XFb7rgept4kARNQuA+xCHTSDhyw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Nov 2024 23:35:16 +0100
Message-ID: <CAOQ4uxgFJX+AJbswKwQP3oFE273JDOO3UAvtxHz4r8+tVkHJnQ@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 10:22=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 13 Nov 2024 at 11:11, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > >
> > > This whole "add another crazy inline function using another crazy
> > > helper needs to STOP. Later on in the patch series you do
> > >
> >
> > The patch that I sent did add another convenience helper
> > fsnotify_path(), but as long as it is not hiding crazy tests,
> > and does not expand to huge inlined code, I don't see the problem.
>
> So I don't mind adding a new inline function for convenience.
>
> But I do mind the whole "multiple levels of inline functions" model,
> and the thing I _particularly_ hate is the "mask is usually constant
> so that the effect of the inline function is practically two different
> things" as exemplified by "fsnotify_file()" and friends.
>
> At that point, the inline function isn't a helper any more, it's a
> hindrance to understanding what the heck is going on.
>
> Basically, as an example: fsnotify_file() is actually two very
> different things depending on the "mask" argument, an that argument is
> *typically* a constant.
>
> In fact, in fsnotify_file_area_perm() is very much is a constant, but
> to make it extra non-obvious, it's a *hidden* constant, using
>
>         __u32 fsnotify_mask =3D FS_ACCESS_PERM;
>
> to hide the fact that it's actually calling fsnotify_file() with that
> constant argument.

Yeh, that specific "obfuscation" is a leftover from history.
It is already gone in the patches that we sent.

>
> And in fsnotify_open() it's not exactly a constant, but it's kind of
> one: when you actually look at fsnotify_file(), it has that "I do a
> different filtering event based on mask", and the two different
> constants fsnotify_open() uses are actually the same for that mask.
>
> In other words, that whole "mask" test part of fsnotify_file()
>
>         /* Permission events require group prio >=3D FSNOTIFY_PRIO_CONTEN=
T */
>         if (mask & ALL_FSNOTIFY_PERM_EVENTS &&
>             !fsnotify_sb_has_priority_watchers(path->dentry->d_sb,
>                                                FSNOTIFY_PRIO_CONTENT))
>                 return 0;
>
> mess is actually STATICALLY TRUE OR FALSE, but it's made out to be
> somehow an "arghumenty" to the function, and it's really obfuscated.
>

Yeh. I see that problem absolutely.
This is already gone in the patch that I send you today:
- All the old hooks call fsnotify_file() that only checks FMODE_NONOTIFY
  and calls fsnotify_path()
- The permission hooks now check FMODE_NONOTIFY_PERM
  and call fsnotify_path()

> That is the kind of "helper inline" that I don't want to see in the
> new paths. Making that conditional more complicated was part of what I
> objected to in one of the patches.
>
> > Those convenience helpers help me to maintain readability and code
> > reuse.
>
> ABSOLUTELY NOT.
>
> That "convenience helkper" does exactly the opposite. It explicitly
> and actively obfuscates when the actual
> fsnotify_sb_has_priority_watchers() filtering is done.
>
> That helper is evil.
>
> Just go and look at the actual uses, let's take
> fsnotify_file_area_perm() as an example. As mentioned, as an extra
> level of obfuscation, that horrid "helper" function tries to hide how
> "mask" is constant by doing
>
>         __u32 fsnotify_mask =3D FS_ACCESS_PERM;
>
> and then never modifying it, and then doing
>
>         return fsnotify_file(file, fsnotify_mask);
>
> but if you walk through the logic, you now see that ok, that means
> that the "mask" conditional fsnotify_file() is actually just
>
>     FS_ACCESS_PERM & ALL_FSNOTIFY_PERM_EVENTS
>
> which is always true, so it means that fsnotify_file_area_perm()
> unconditionally does that
>
>     fsnotify_sb_has_priority_watchers(..)
>
> filitering.
>
> And dammit, you shouldn't have to walk through that pointless "helper"
> variable, and that pointless "helper" inline function to see that. It
> shouldn't be the case that fsnotify_file() does two completely
> different things based on a constant argument.
>

ok. that's going to be history soon.
I will send this cleanup patch regardless of the pre-content series.

> It would have literally been much clearer to just have two explicitly
> different versions of that function, *WITHOUT* some kind of
> pseudo-conditional that isn't actually a conditional, and just have
> fsnotify_file_area_perm() be very explicit about the fact that it uses
> the fsnotify_sb_has_priority_watchers() logic.
>
> IOW, that conditional only makes it harder to see what the actual
> rules are. For no good reason.
>
> Look, magically for some reason fsnotify_name() could do the same
> thing without this kind of silly obfuscation. It just unconditonally
> calls fsnotify_sb_has_watchers() to filter the events. No silly games
> with doing two entirely different things based on a random constant
> argument.
>
> So this is why I say that any new fsnotify events will be NAK'ed and
> not merged by me unless it's all obvious, and unless it all obviously
> DOES NOT USE these inline garbage "helper" functions.
>
> The new logic had better be very obviously *only* using the
> file->f_mode bits, and just calling out-of-line to do the work. If I
> have to walk through several layers of inline functions, and look at
> what magic arguments those inline functions get just to see what the
> hell they actually do, I'm not going to merge it.

Sure for new hooks with new check-on-open semantics that is
going to be easy to do. The historic reason for the heavy inlining
is trying to optimize out indirect calls when we do not have the
luxury of using the check-on-open semantics.

>
> Because I'm really tired of actively obfuscated VFS hooks that use
> inline functions to hide what the hell they are doing and whether they
> are expensive or not.
>
> Your fsnotify_file_range() uses fsnotify_parent(), which is another of
> those "it does two different things" functions that either call
> fsnotify() on the dentry, or call __fsnotify_parent() on it if it's an
> inode, which means that it's another case of "what does this actually
> do" which is pointlessly hard to follow, since clearly for a truncate
> event it can't be a directory.
>
> And to make matters worse, fsnotify_truncate_perm() actually checks
> truncate events for directories and regular files, when truncates
> can't actually happen for anything but regular files in the first
> place. So  your helper function does a nonsensical cray-cray test that
> shouldn't exist.

Ha, right, that's a stupid copy&paste braino.
Easy to fix.

The simplest thing to do for the new hooks I think is to make
fsnotify_file_range() extern and then you won't need to look beyond it,
because it already comes after the unlikley FMODE_NONOTIFY_ bits check.

Will work on the rest of the series following those guidelines.
Let me know if the patch I sent you has taken a wrong direction.

Thanks,
Amir.

