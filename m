Return-Path: <linux-fsdevel+bounces-34362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178E19C4B0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 01:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDF1281DF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 00:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA0C1F7545;
	Tue, 12 Nov 2024 00:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SXA4uyst"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FD21F7079
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731371874; cv=none; b=aCLTjHD78S6vsCDETVpeG9mvAPzAxHVpHwX85uFGvYODNDE7OVhFXFDGUYXmXtioKZ5ITxdsiNQnmgk7E8HXTVjvz4btNSFGsWmOeUi8Ptc/7/Aqxrzhdaclkb4+fYoCSzfBUtibR0xODkj0DoAY+rZYr/Z6wdAy9KErYYQg49M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731371874; c=relaxed/simple;
	bh=t6P42hBzZCFlDjsCYhooA9AZjGMzRt8DzGc4WyVzrqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2DbCskWgvHEdU+3UijIu4l5mDb7AlKuH3YOKtyNwH7g+peUHEtdFfT25dlmvofABCGZDm6Iukm6JsDyY1DMCpJ5mubvaWniTdNLACD6hjpFidqESxpGko7g8KqnTFQ1oVfW2bUktI4Mj+SG4WuSRHPoUqyjOmMNs83EwJk+/rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SXA4uyst; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso863592266b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 16:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731371870; x=1731976670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8s+Ye3Sb5A7DOLizr5823ibyYsiIFEnIKQUrUtOpKwk=;
        b=SXA4uystd9A/eWiyQMlrxa9yqO6rP1uD0hnbGfv3X7PKvOwiDVS07v11KZEHKP98Bt
         bg+aWAQ1bUSUJAkKp+djcehP71y3AIVXDE/cEGAANu0KwnVCgoDWiEDvMuW8gDjb53bU
         bzJWFH0Rd1rHVYxHmuOk5Qt/tSZ1EypBkFd+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731371870; x=1731976670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8s+Ye3Sb5A7DOLizr5823ibyYsiIFEnIKQUrUtOpKwk=;
        b=bHaO5pFROlzMMJNCvEOXKKx15Y9KnRLj6XjkGJZUMQA3reSrNra7q4ExPjsqlGlj3/
         w9Fl0UnTNe7GJye+u5cPkKe3qldWH4mxn+xR2vdqh7RMA0QeGTTMjbKIYG1WMra1KZyM
         ieNKhfLiZhD8i5j4OX9Uxb/sXecRAUbAXjf5mZQGR4CcrbvLNgDtN4N24RxQQ8L9MyNC
         vV4yMPcvd9L3v3lg6csAq22umHHxomIe6+kIp+p13BcagX38TXgqkJ02kTsX6vpNvb8P
         HFtA+p4L7trcOxYsDFZnK/OkYNxWRyqWbnmYiKRJgv5euj5D/zZ2rWF9Qgrfn9silEmB
         QAdw==
X-Forwarded-Encrypted: i=1; AJvYcCUq0zS2o9ZH0WbKO6A1KFLE2aJdPuzgneF4AICyfZLi+xqe/TnfjjwPEQU8/4ceeaq0FhHLSfqefrS7PtRA@vger.kernel.org
X-Gm-Message-State: AOJu0YwgWWThc+wQd90jviAIKZyeyr/Tt+pdsrOz6Y0qnmYsHgEN5+1w
	eH5WGe6Ahq0oRwqtyl5tGCMZTytbnieFKzs0A1azWOugqouJppOcACWgQ1MRmAM9dfyrffNbH/J
	YE9c=
X-Google-Smtp-Source: AGHT+IFnkTa/D3jCoEqoYwhuRDJqyU74hTeTyH0eKxtRd7fpKtVOaBY9eB31VS4hpUj2WdVe+fQkeg==
X-Received: by 2002:a17:907:9493:b0:a9e:c947:9855 with SMTP id a640c23a62f3a-a9eeffee7cfmr1487062566b.48.1731371870537;
        Mon, 11 Nov 2024 16:37:50 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0deeed0sm649953566b.139.2024.11.11.16.37.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 16:37:48 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so663326666b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 16:37:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhMlcrrw1OPLKtjw/Z73XOsmZH0KoXXWFz81yELz1olklYH56VdUgEta9Hr6pDhdFVy3IseWZG+k/wHU/N@vger.kernel.org
X-Received: by 2002:a17:906:dc8a:b0:a9e:b090:e65d with SMTP id
 a640c23a62f3a-a9eeff383eemr1195211366b.32.1731371866917; Mon, 11 Nov 2024
 16:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731355931.git.josef@toxicpanda.com> <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
 <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
 <CAEzrpqdtSAoS+p4i0EzWFr0Nrpw1Q2hphatV7Sk4VM49=L3kGw@mail.gmail.com>
 <CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com> <CAOQ4uxgxtQhe_3mj5SwH9568xEFsxtNqexLfw9Wx_53LPmyD=Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxgxtQhe_3mj5SwH9568xEFsxtNqexLfw9Wx_53LPmyD=Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Nov 2024 16:37:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgUV27XF8g23=aWNJecRbn8fCDDW2=10y9yJ122+d8JrA@mail.gmail.com>
Message-ID: <CAHk-=wgUV27XF8g23=aWNJecRbn8fCDDW2=10y9yJ122+d8JrA@mail.gmail.com>
Subject: Re: [PATCH v6 06/17] fsnotify: generate pre-content permission event
 on open
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 16:00, Amir Goldstein <amir73il@gmail.com> wrote:
>
> I think that's a good idea for pre-content events, because it's fine
> to say that if the sb/mount was not watched by a pre-content event listener
> at the time of file open, then we do not care.

Right.

> The problem is that legacy inotify/fanotify watches can be added after
> file is open, so that is allegedly why this optimization was not done for
> fsnotify hooks in the past.

So honestly, even if the legacy fsnotify hooks can't look at the file
flag, they could damn well look at an inode flag.

And I'm not even convinced that we couldn't fix them to just look at a
file flag, and say "tough luck, somebody opened that file before you
started watching, you don't get to see what they did".

So even if we don't look at a file->f_mode flag, the lergacy cases
should look at i_fsnotify_mask, and do that *first*.

IOW, not do it like fsnotify_object_watched() does now, which is just
broken. Again, it looks at inode->i_sb->s_fsnotify_mask completely
pointlessly, but it also does it much too late - it gets called after
we've already called into the fsnotify() code and have messed up the
I$ etc.

The "linode->i_sb->s_fsnotify_mask" is not only an extra indirection,
it should be very *literally* pointless. If some bit isn't set in
i_sb->s_fsnotify_mask, then there should be no way to set that bit in
inode->i_fsnotify_mask. So the only time we should access
i_sb->s_fsnotify_mask is when i_notify_mask gets *modified*, not when
it gets tested.

But even if that silly and pointless i_sb->s_fsnotify_mask thing is
removed, fsnotify_object_watched() is *still* wrong, because it
requires that mnt_mask as an argument, which means that the caller now
has to look it up - all this entirely pointless work that should never
be done if the bit wasn't set in inode->i_fsnotify_mask.

So I really think fsnotify is doing *everything* wrong.

And I most certainly don't want to add more runtime hooks to
*critical* code like open/read/write.

Right now, many of the fsnotify things are for "metadata", ie for
bigger file creation / removal / move etc. And yes, the "don't do this
if there are no fsnotify watchers AT ALL" does actually end up meaning
that most of the time I never see any of it in profiles, because the
fsnotify_sb_has_watchers() culls out that case.

And while the fsnotify_sb_has_watchers() thing is broken garbage and
does too many indirections and is not testing the right thing, at
least it's inlined and you don't get the function calls.

That doesn't make fsnotify "right", but at least it's not in my face.
I see the sb accesses, and I hate them, but it's usually at least
hidden. Admittedly not as well hidden as it *should* be, since it does
the access tests in the wrong order, but the old fsnotify_open()
doesn't strike me as "terminally broken".

It doesn't have a permission test after the open has already done
things, and it's inlined enough that it isn't actively offensive.

And most of the other fsnotify things have the same pattern - not
great, but not actively offensive.

These new patches make it in my face.

So I do require that the *new* cases at least get it right. The fact
that we have old code that is misdesigned and gets it wrong and should
also be improved isn't an excuse to add *more* badly coded stuff.

And yes, if somebody fixes the old fsnotify stuff to check just the
i_fsnotify_mask in the inline function, and moves all the other silly
checks out-of-line, that would be an improvement. I'd very much
applaud that. But it's a separate thing from adding new hooks.

                Linus

