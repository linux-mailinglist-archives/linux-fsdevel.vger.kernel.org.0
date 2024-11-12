Return-Path: <linux-fsdevel+bounces-34398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 285599C5059
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5338B24F02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 08:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F91E20B7F5;
	Tue, 12 Nov 2024 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y27Bvjzs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380D51A08CB;
	Tue, 12 Nov 2024 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399106; cv=none; b=H//9OzVNi2W7+k41ms0HR6GNg8UhPDA4HafW3IpL6YydjeHF0LYd0SlRgm/ap2q+be9QZZLpVjX6tDt/DAdfJEfP1JFbSjNqgpmiak2x9H1jB8SqlbdqN2LhOgPrtptFTHfTv8pd1YMzb/CbzbheLm2bQUqJFLSnW8agjjeE0qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399106; c=relaxed/simple;
	bh=wsc9Hm/t1SE8zIi/XJ/r/oh3u3s7boRYiBpGBy9/BKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIsIPonk29JbkNyQO0RjlgThn9LisSqEtpkN+96H705xg4/avFai37yhFcrZpDWECV4NxwDdi0rOFcRXHxoy4Wsq/E5vjlGeDaBlECXQRUnRatNGFulfSHb9+cBWtDag03lmO6tmbJM848U1HxQSlyGo56Slvz7IOvc75MWMCAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y27Bvjzs; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b13fe8f4d0so337632785a.0;
        Tue, 12 Nov 2024 00:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731399104; x=1732003904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYjdu3MIu3Eu/Ypiw444kSD1a+HXjbP7A8QKym9LvII=;
        b=Y27BvjzsjSocOBRlFcYQmCS0kGbmsxCqrVl1F9wZp1oCyZI47XRHolZQM8x2RJEaxi
         O9Cb/WPWSuwj7+XK6+rw93hTxSLh4LVOYq2u7c2G6kGsmdHLeTBhuWr4ZyPwOUE1eJ9M
         SMhFia/bWBoK+P4b9P2ImT2WfDk+Dip8M2U81fVMMm5Xc72DWW5PMUvyEejSBksJtypL
         Ba0+Wu6DCNqlICMGY5Myeh9nt4/eBf2O0Lscokhl/YeShrb8t+qTWPgcAst/YZHb2Qo4
         Q5lFL35GG7RY9DNWFQPa7LuxN6pXLaqMXOUqXKLUyAOrotEN8tcGSmqBuRd9UAsrQBMJ
         j/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731399104; x=1732003904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYjdu3MIu3Eu/Ypiw444kSD1a+HXjbP7A8QKym9LvII=;
        b=aA6nj5zX1JGGRuJlBelwwKT0XRR75nTQLL/z2EbBvERxXrhE/vWHzPHQ0UzSiAk+mm
         WvcrNghp8ZZ3bCT6iBhYBkEkwFlt6WBUbaKRkJEow2ZcVYGShyiPaRfhm7DVif9h24PO
         79OhbyKDqzcwgOryPoPxSj3FOZNzclgZdhekAZlKYN8VFOXey7TsWFIhkivAAGYExIH6
         J41w27yym3QOwCOtqiEno+bXlDOs0AV5MsClceybKBtWtdjyhLl3VhnQhY/6jH50mJFX
         88kRS/4zHs/iMWX21f1Uvfk6pwW0v1yogLVR+7ePA0fmacBlxyjGLHyyV/3R8lL+aeVk
         CGIw==
X-Forwarded-Encrypted: i=1; AJvYcCU6sFlTF3dy2GdVUjLet9LWhCSIMeaKAFL1fkcVEfhB1NqzE0ZAwvJAYskxwS4yusNa27IGCv3Q4I790g==@vger.kernel.org, AJvYcCVwLBIC/szQJiGstk7JsD7i7rh/MaTEgfBW6sdMV50Nh7w/Xf27QnOD8qLh2xGVDIeqtsx08kUrTeDyYdBDYg==@vger.kernel.org, AJvYcCWptSHzzVQmZE5b21eEqfcmN9vmqpo3hDDhl3yfRFvt00aCu6dEgex5p1LVUEaeFuaXY8XYl88aSKjZ@vger.kernel.org, AJvYcCX0MWqUr5Rd3bO/l3Cxmhrh03nlFbFraphHlHk9vi/xOZtf5wvIK79SerMtGMvKhtplkdSyk3DTJ56+DA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+3pmLDdNsvOv75HNitgRpDjtgw6SaU6SfMMb1rmX4FF1Ld7cC
	EeAZ/fI7IuPz4Qi/lWeqh+/EaXtBoaw/hu9judLbk6yynj2NdKKvkWPQsm9uWQhBAPmOQhCPxz+
	to+/oI7yHGPzE2y9NYXAzrIzwcC4=
X-Google-Smtp-Source: AGHT+IF8PhChDkQIPeKy040j30c4YpBejToxm9PopIZQRH7oO6q4EPvXD1ptT5PmED5D1+9XHwBRPyTqMw7gXqxqlng=
X-Received: by 2002:a05:6214:2b92:b0:6ce:2f4e:40f1 with SMTP id
 6a1803df08f44-6d39e1507famr237610156d6.26.1731399103800; Tue, 12 Nov 2024
 00:11:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731355931.git.josef@toxicpanda.com> <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
 <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
 <CAEzrpqdtSAoS+p4i0EzWFr0Nrpw1Q2hphatV7Sk4VM49=L3kGw@mail.gmail.com>
 <CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com>
 <CAOQ4uxgxtQhe_3mj5SwH9568xEFsxtNqexLfw9Wx_53LPmyD=Q@mail.gmail.com> <CAHk-=wgUV27XF8g23=aWNJecRbn8fCDDW2=10y9yJ122+d8JrA@mail.gmail.com>
In-Reply-To: <CAHk-=wgUV27XF8g23=aWNJecRbn8fCDDW2=10y9yJ122+d8JrA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 Nov 2024 09:11:32 +0100
Message-ID: <CAOQ4uxh7aT+EvWYMa9v=SyRjfdh4Je_FmS0+TNqonHE5Z+_TPw@mail.gmail.com>
Subject: Re: [PATCH v6 06/17] fsnotify: generate pre-content permission event
 on open
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 1:37=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 11 Nov 2024 at 16:00, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > I think that's a good idea for pre-content events, because it's fine
> > to say that if the sb/mount was not watched by a pre-content event list=
ener
> > at the time of file open, then we do not care.
>
> Right.
>
> > The problem is that legacy inotify/fanotify watches can be added after
> > file is open, so that is allegedly why this optimization was not done f=
or
> > fsnotify hooks in the past.
>
> So honestly, even if the legacy fsnotify hooks can't look at the file
> flag, they could damn well look at an inode flag.
>

Legacy fanotify has a mount watch (FAN_MARK_MOUNT),
which is the common way for Anti-malware to set watches on
filesystems, so I am not sure what you are saying.

> And I'm not even convinced that we couldn't fix them to just look at a
> file flag, and say "tough luck, somebody opened that file before you
> started watching, you don't get to see what they did".

That would specifically break tail -f (for inotify) and probably many other
tools, but as long as we also look at the inode flags (i_fsnotify_mask)
and the dentry flags (DCACHE_FSNOTIFY_PARENT_WATCHED),
then I think we may be able to get away with changing the semantics
for open files on a fanotify mount watch.

Specifically, I would really like to eliminate completely the cost of
FAN_ACCESS_PERM event, which could be gated on file flag, because
this is only for security/Anti-malware and I don't think this event is
practically
useful and it sure does not need to guarantee permission events to mount
watchers on already open files.

>
> So even if we don't look at a file->f_mode flag, the lergacy cases
> should look at i_fsnotify_mask, and do that *first*.
>
> IOW, not do it like fsnotify_object_watched() does now, which is just
> broken. Again, it looks at inode->i_sb->s_fsnotify_mask completely
> pointlessly, but it also does it much too late - it gets called after
> we've already called into the fsnotify() code and have messed up the
> I$ etc.
>
> The "linode->i_sb->s_fsnotify_mask" is not only an extra indirection,
> it should be very *literally* pointless. If some bit isn't set in
> i_sb->s_fsnotify_mask, then there should be no way to set that bit in
> inode->i_fsnotify_mask. So the only time we should access
> i_sb->s_fsnotify_mask is when i_notify_mask gets *modified*, not when
> it gets tested.
>

i_fsnotify_mask is the cumulative mask of all inode watchers
s_fsnotify_mask is *not* the cumulative of all i_fsnotify_mask
s_fsnotify_mask is the cumulative mask of all sb watchers
mnt_fsnotify_marks is the cumulative mask of all mount watchers

> But even if that silly and pointless i_sb->s_fsnotify_mask thing is
> removed, fsnotify_object_watched() is *still* wrong, because it
> requires that mnt_mask as an argument, which means that the caller now
> has to look it up - all this entirely pointless work that should never
> be done if the bit wasn't set in inode->i_fsnotify_mask.
>
> So I really think fsnotify is doing *everything* wrong.

Note the difference between fsnotify_sb_has_watchers()
and fsnotify_object_watched().

The former is an early optimization gate that checks if there are
any inode/mount/sb watchers (per class) on the filesystem, regardless
of specific events and specific target inode/file.

We could possibly further optimize fsnotify_sb_has_watchers() to avoid
access to ->s_fsnotify_info by setting sb flag (for each priority class).

The latter checks if any inode/mount/sb are interested in a specific
event on the said object.

In upstream code, fsnotify_object_watched() is always gated behind
fsnotify_sb_has_watchers(), which tries to prevent the indirect call.

The new fsnotify_file_has_pre_content_watches() helper could
have checked fsnotify_sb_has_priority_watchers(sb,
                                               FSNOTIFY_PRIO_CONTENT);
but it is better to gate by file flag as you suggested.


>
> And I most certainly don't want to add more runtime hooks to
> *critical* code like open/read/write.
>
> Right now, many of the fsnotify things are for "metadata", ie for
> bigger file creation / removal / move etc. And yes, the "don't do this
> if there are no fsnotify watchers AT ALL" does actually end up meaning
> that most of the time I never see any of it in profiles, because the
> fsnotify_sb_has_watchers() culls out that case.
>
> And while the fsnotify_sb_has_watchers() thing is broken garbage and
> does too many indirections and is not testing the right thing, at
> least it's inlined and you don't get the function calls.
>
> That doesn't make fsnotify "right", but at least it's not in my face.
> I see the sb accesses, and I hate them, but it's usually at least
> hidden. Admittedly not as well hidden as it *should* be, since it does
> the access tests in the wrong order, but the old fsnotify_open()
> doesn't strike me as "terminally broken".
>
> It doesn't have a permission test after the open has already done
> things, and it's inlined enough that it isn't actively offensive.
>
> And most of the other fsnotify things have the same pattern - not
> great, but not actively offensive.
>
> These new patches make it in my face.
>
> So I do require that the *new* cases at least get it right. The fact
> that we have old code that is misdesigned and gets it wrong and should
> also be improved isn't an excuse to add *more* badly coded stuff.
>
> And yes, if somebody fixes the old fsnotify stuff to check just the
> i_fsnotify_mask in the inline function, and moves all the other silly
> checks out-of-line, that would be an improvement. I'd very much
> applaud that. But it's a separate thing from adding new hooks.

We will do both.

Thanks,
Amir.

