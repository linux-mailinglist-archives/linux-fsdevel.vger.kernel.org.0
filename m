Return-Path: <linux-fsdevel+bounces-28369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A94969ED7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0191F23E44
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B481A7258;
	Tue,  3 Sep 2024 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1yvX8C7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C46A1CA690;
	Tue,  3 Sep 2024 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369399; cv=none; b=j1nMQ2OBhleKq+RfEvaqoNrqtd2sGXMa4zz1uQL/e4kVuRu308nw22CXTmduJL3u9wXed3ebO2uiylF21O/AiJnhKWI198LvNJQN7ZucT4z5Bgqf7+ry+sllalpAtQcsKwTHKN+zpceQyhMNO2UveiP3ua6aRrQXUp8FS+D8td8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369399; c=relaxed/simple;
	bh=psMiyvsynfGq6Oa1EbpLT4L9TZqEPting41YVwRcD3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THvF5rgrRLrHFE6pI5IKvBjLK8bcYcei4kYgdzAEYATOizzStz33BUWi/PRFMYgOfmzUNLR0ZmRk9c0QTz2U2GMCaisPhsv+t/7s4/hxIkzejaAETuvbQieeJgn8STu7eCX+fpUu+qYdqdp5NAM/weZYGpdldIRoEPipEpzYJC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1yvX8C7; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c34c02ff1cso21486196d6.2;
        Tue, 03 Sep 2024 06:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725369397; x=1725974197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGIgWA+Z6lZNw0/44TLTAh5+lMfGacrdZzpuKxzMwJk=;
        b=a1yvX8C7xYbBxDEeF3pe0jW927BzJ+fVQSDsFmWBfINd+QrUxuupw+XWXpmNSPgWNr
         +uqpf6I8NgKVGC9w0AD02cNMMI+z8N4tKZCJNYVNv8PKEYCtZZiuP83NrOLCnOOqGu03
         l7qXc9F58e+Lm/t76HCsWu/Eb5qXhpcBNfSo432Sac4tkimkIZtDXnmtAA+O1TQ6mIYu
         lZ3I411+vnpnkBZ350f0DbAHeMOj56hkvXOv+KeVgidolxV5YgjVwZoy1IO0eHAh45LA
         0bO9JTsczDFOO44VV9tXEj4H9CuGt/XdoZyuvyc6iXughA+f1Z2Frp2a+/pTXk3RjRm6
         Dg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725369397; x=1725974197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGIgWA+Z6lZNw0/44TLTAh5+lMfGacrdZzpuKxzMwJk=;
        b=UL3I44GwGL1zZekYNW/ZRb/QDgGcmWjytu+yYLlaVWOxD2UbWz9Ge/o8qJ1WhQprgK
         mbgMIQYadN02fhBtBB6T8EeU+q/7ZUgcYKSZy2J1jJHhoMIAAdoBVXos9CKoACQGo/dE
         5R/BsnfCatjcZHdv6Xie1lzBm1DfcIrEgYDC3opMKw/XniuO1OrmEhAn8vZRptAf57Er
         vBxclX0+D7d8/eW5tE11VWzUOEVQfBIG3llg40fGKiGxh1Hw0jirRHKKJbDKo7gddQnL
         WOfyQClznwCn1M1w/cpSdxJzyEEq8zJ8i3PFFfalUea3X2cOghmhp9TcycZMeGtzrr1K
         GVDw==
X-Forwarded-Encrypted: i=1; AJvYcCUREh8uXrOOkZImOz13dIZaHWlPDDH9t+XpFR0rEytcOEdfCReMVsQnUw7l61xL/fqHca8KYnzRfkZGuBP9@vger.kernel.org, AJvYcCUgc4FMYRnFc0ndyz6VWD+/mw4KGSsX0HUcN9C2I8VdnPbwCrCU93Mjo59Btwb6o5IZHd3cuFAih0xtYe39@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9kxuD6u7nUJAxB5Wqe8RD/1JC3z2kr+leSN5pUsOF3rIGPEo3
	8CoxEPnyqiT/0waAi/fqk+LJLN1WwMO6ti+ggkYYAtHROAVpy7HItLqGQbJv7L32O94nX/yBJoU
	O4SqfDZQ0V9PRE93L3U3pzepQAyg=
X-Google-Smtp-Source: AGHT+IH6xv/ihNNRfXoP5NW1PSMYDKkOs322EqcazacXLKGTZDpA+iegLV9xf3ZOwqnW2xoHN9i400zDIGtzUo49i9Q=
X-Received: by 2002:a05:6214:3109:b0:6c3:657b:4111 with SMTP id
 6a1803df08f44-6c3657b43e7mr73942296d6.52.1725369396843; Tue, 03 Sep 2024
 06:16:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZtBWxWunhXTh0bhS@tiehlicka> <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
 <ZtCFP5w6yv/aykui@dread.disaster.area> <CALOAHbCssCSb7zF6VoKugFjAQcMACmOTtSCzd7n8oGfXdsxNsg@mail.gmail.com>
 <ZtPhAdqZgq6s4zmk@dread.disaster.area> <CALOAHbBEF=i7e+Zet-L3vEyQRcwmOn7b6vmut0-ae8_DQipOAw@mail.gmail.com>
 <ZtVzP2wfQoJrBXjF@tiehlicka> <CALOAHbAbzJL31jeGfXnbXmbXMpPv-Ak3o3t0tusjs-N-NHisiQ@mail.gmail.com>
 <ZtWArlHgX8JnZjFm@tiehlicka> <CALOAHbD=mzSBoNqCVf5TTOge4oTZq7Foxdv4H2U1zfBwjNoVKA@mail.gmail.com>
 <20240903124416.GE424729@mit.edu>
In-Reply-To: <20240903124416.GE424729@mit.edu>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 3 Sep 2024 21:15:59 +0800
Message-ID: <CALOAHbCAN8KwgxoSw4Rg2Uuwp0=LcGY8WRMqLbpEP5MkW4H_XQ@mail.gmail.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc allocations
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 8:44=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Sep 03, 2024 at 02:34:05PM +0800, Yafang Shao wrote:
> >
> > When setting GFP_NOFAIL, it's important to not only enable direct
> > reclaim but also the OOM killer. In scenarios where swap is off and
> > there is minimal page cache, setting GFP_NOFAIL without __GFP_FS can
> > result in an infinite loop. In other words, GFP_NOFAIL should not be
> > used with GFP_NOFS. Unfortunately, many call sites do combine them.
> > For example:
> >
> > XFS:
> >
> > fs/xfs/libxfs/xfs_exchmaps.c: GFP_NOFS | __GFP_NOFAIL
> > fs/xfs/xfs_attr_item.c: GFP_NOFS | __GFP_NOFAIL
> >
> > EXT4:
> >
> > fs/ext4/mballoc.c: GFP_NOFS | __GFP_NOFAIL
> > fs/ext4/extents.c: GFP_NOFS | __GFP_NOFAIL
> >
> > This seems problematic, but I'm not an FS expert. Perhaps Dave or Ted
> > could provide further insight.
>
> GFP_NOFS is needed because we need to signal to the mm layer to avoid
> recursing into file system layer --- for example, to clean a page by
> writing it back to the FS.  Since we may have taken various file
> system locks, recursing could lead to deadlock, which would make the
> system (and the user) sad.
>
> If the mm layer wants to OOM kill a process, that should be fine as
> far as the file system is concerned --- this could reclaim anonymous
> pages that don't need to be written back, for example.  And we don't
> need to write back dirty pages before the process killed.  So I'm a
> bit puzzled why (as you imply; I haven't dug into the mm code in
> question) GFP_NOFS implies disabling the OOM killer?

Refer to the out_of_memory() function [0]:

    if (!(oc->gfp_mask & __GFP_FS) && !is_memcg_oom(oc))
        return true;

[0]. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/mm/oom_kill.c#n1137

Is it possible that this check can be removed?

>
> Regards,
>
>                                         - Ted
>
> P.S.  Note that this is a fairly simplistic, very conservative set of
> constraints.  If you have several dozen file sysetems mounted, and
> we're deep in the guts of file system A, it might be *fine* to clean
> pages associated with file system B or file system C.  Unless of
> course, file system A is a loop-back mount onto a file located in file
> system B, in which case writing into file system A might require
> taking locks related to file system B.  But that aside, in theory we
> could allow certain types of page reclaim if we were willing to track
> which file systems are busy.
>
> On the other hand, if the system is allowed to get that busy,
> performance is going to be *terrible*, and so perhaps the better thing
> to do is to teach the container manager not to schedule so many jobs
> on the server in the first place, or having the mobile OS kill off
> applications that aren't in the foreground, or giving the OOM killer
> license to kill off jobs much earlier, etc.  By the time we get to the
> point where we are trying to use these last dozen or so pages, the
> system is going to be thrashing super-badly, and the user is going to
> be *quite* unhappy.  So arguably these problems should be solved much
> higher up the software stack, by not letting the system get into such
> a condition in the first place.

I completely agree with your point. However, in the real world, things
don't always work as expected, which is why it's crucial to ensure the
OOM killer is effective during system thrashing. Unfortunately, the
kernel's OOM killer doesn't always perform as expected, particularly
under heavy thrashing. This is one reason why user-space OOM killers
like oomd exist.


--
Regards
Yafang

