Return-Path: <linux-fsdevel+bounces-34471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF019C5BC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 16:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF011F232FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 15:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE4D200B84;
	Tue, 12 Nov 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="MBfUNQXK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDD22003CA
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425060; cv=none; b=ic2lqSskMeD/S2DhKW1T5n4dRUqamWa+jz59mJnzgZ6DPEUX+LVScngdjkZ0NVOZrpzGulBiXuuRb+Rm9Dv99vKqP6UcM3csk5UckIp/toJHw7Tt7TjZCHq+k45/diHS4pAzvRS34fKkZqtTSai6IZ9svSLOZbBLEQ6JAETbT3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425060; c=relaxed/simple;
	bh=Pw76qoxuEBmSQZkc5D1i8WJCwIAQTQoR8D52Af7iCGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4LFcZfNppCPVvRGsgw9NMifq/HHeLH11F0R3CGKHtRodt79aBP4oPeSd6szILxooosguR9eIUCFzw0ixLTQda4VjoKXqb1GdnWAUYyQgVSMq8RNOaixqHQwme7kKYybDiCnBraigcPeRaUdC/qvKYOu2McBzZl7OWYz2+zKBEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=MBfUNQXK; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbe68f787dso37429836d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 07:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731425057; x=1732029857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IYKvte0z2sS6p7AKJqybZy0XMGJi5wQZwdmuSoY937M=;
        b=MBfUNQXKEQRIWECUw2OHC45gWLyya3jbvyC3cShyvxU7yKBbS/SgE+cY7zb3E084is
         GrnfHfnzMwN0s/cG5W7EH/OBAxYdJoKgHm2cNBJ+LYZLImEnPIHx5Tjt2JX6ykoo8Ulu
         VORo1CPD3vdxt8gQpy7htO0QuG7n85acUDItfYGwO+A2p3GjLNZjCUYXXik4VXNL1SQm
         Y8j3voSb9yGP/wE1YJ5C5cIxLfu9c4rfJyGvBDMETh+CSTH82DGoCHWcHwE5bo1pvOpX
         3NkMDCptn6m8ny5jQrdJjTTDnO3vlYRj+arc23v2ieKIjO2NWZqwEtM/pGUDZPQVsqAX
         Kurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731425057; x=1732029857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYKvte0z2sS6p7AKJqybZy0XMGJi5wQZwdmuSoY937M=;
        b=uXzbkGPVKNXPO6nj2k7bzGT/S0QrbbDGD48P8EiCtXb16OyG0NCcqtek7+n4r9O7hf
         mfW5kPIyn1aarOcLy+3LVZiT0VqQbG61/+MPzr/oAKbHe8osmy7ojIzZQW2P1itLptJ3
         U0IIik5aQG70Sg6NGzrU6PGdF6qpR/yTvWHJseE8c53mrrUcAbpuqY4gDyJqg2aOxue0
         glAH0j2jFdMm/yfxXf72XxooGpxZeVaZLLh2XTCt2WIGI9UzdRHeLYikDJqOuJNOlv+G
         H3vwHtTuhweW+jOsDmB5ZH7pHlmrIXkCW/Cbf0zK2xlI1eRYo6ZFJI4PDXRWGmftQ7V9
         z9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaDBx0UxOzR4GvQQpMaGFIY0uYndTAeE8edBfiyXCFyae0cwy52eVYNc7ip8Z8cyHOJU/z77wCxXlPU4kY@vger.kernel.org
X-Gm-Message-State: AOJu0YzhbcSlisjTzqNScuHAKgFS41kZl+v06rQbQjX4mOyeV3x4xUjW
	LIRxzhKPFpyeTlmSwj6W4UcQeiA4g7gCYXszQppqkxirzMj6CoPTftQK9SoNQA4=
X-Google-Smtp-Source: AGHT+IEREsT1IN/Jyb5jxnIeqB6aJ6hHi/Typq40PSivxK57muONB5alYpUuJkLlVhIRLIUqlqBUcw==
X-Received: by 2002:a05:6214:53ca:b0:6cb:ef22:6274 with SMTP id 6a1803df08f44-6d39e10772emr228170466d6.3.1731425057185;
        Tue, 12 Nov 2024 07:24:17 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d39643b36asm71965466d6.75.2024.11.12.07.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 07:24:16 -0800 (PST)
Date: Tue, 12 Nov 2024 10:24:15 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 06/17] fsnotify: generate pre-content permission event
 on open
Message-ID: <20241112152415.GA826972@perftesting>
References: <cover.1731355931.git.josef@toxicpanda.com>
 <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
 <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
 <CAEzrpqdtSAoS+p4i0EzWFr0Nrpw1Q2hphatV7Sk4VM49=L3kGw@mail.gmail.com>
 <CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com>

On Mon, Nov 11, 2024 at 03:22:06PM -0800, Linus Torvalds wrote:
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
>         struct inode *inode = file_inode(file);
>         __u32 mnt_mask = real_mount(file->f_path.mnt)->mnt_fsnotify_mask;
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
>     static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
>     {
>         if (unlikely(file->f_mode & FMODE_NOTIFY))
>                 return out_of_line_crud(file);
>         return false;
>     }
> 
> so that the *only* thing that gets inlined is "does this file have any
> fsnotify stuff at all", and in the common case where that isn't true,
> we don't call any fsnotify functions, and we don't start looking at
> inodes or superblocks or anything pointless like that.
> 
> THAT is the kind of code sequence we should have for unlikely cases.
> Not the "call fsnotify code to check for something unlikely". Not
> "look at file_inode(file)->i_sb->s_iflags" until it's *required*.
> 
> Similarly, the actual open-time code SHOULD NEVER BE CALLED, because
> it should have the same kind of simple logic based on some simple flag
> either in the dentry or maybe in the inode. So that all those *normal*
> dentries and inodes that don't have watches don't get the overhead of
> calling into fsnotify code.
> 
> Because yes, I do see all those function calls, and all those
> unnecessary indirect pointer accesses when I do profiles. And if I see
> fsnotify in my profiles when I don't have any notifications enabled,
> that really really *annoys* me.
> 

There are good suggestions here, and decent analysis, Amir has followed up with
a patch that will improve things, and that's good.

But this was an entirely inappropriate way to communicate your point, even with
people who have been here a while and are used to being yelled at.

Throughout this email you have suggested that myself, Amir, and Jan have never
looked at profiles.  You go so far as to suggest that we have no idea what we're
doing and don't understand common case optimizations.  These are the sort of
comments that are unhelpful and put most people on the defensive, and make them
unwilling to listen to your suggestions and feedback.  These are the sort of
comments that make people work very hard to exit this community.

Are you wrong?  No.  We all get tunnel vision, I know I was deeply focused on
making the page fault case have as little impact as possible, but I definitely
didn't consider the indirect access case.  I don't run with mitigations on, and
frankly I am a file system person, I know if you're here we're going to do IO
and that's going to be the bad part.  That's why we do code review, because
we're all human and we all miss things.

But being dressed down like this for missing a better way, because lets be
honest what I did wasn't earth shatteringly bad, is not helpful.  It is actively
harmful, and it makes me not want to work on this stuff anymore.

We constantly have discussions about how do we bring in new people and how do we
train up new maintainers, without looking at how do we keep maintainers and how
do we keep developers.  If you're losing people like me, gaining new people is
going to be an even taller order.  Thanks,

Josef

