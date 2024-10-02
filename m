Return-Path: <linux-fsdevel+bounces-30778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A5798E3B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D67C284CA1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 19:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32597216A0E;
	Wed,  2 Oct 2024 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JyPbud29"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A743215F77
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898576; cv=none; b=ZwbgAcD1JB9B1kABOF+WMDYy/4+UPtsLbcJr10/uyoQnfyQ8zTlt0CvW7UcFOQR72ne+XzAl1XPAFJ3aO0pandzHilu+xMMB4cVNZVbcYsNAatRcxdw2VMb/5+1YYH4lrIblCR+dyVZRPjG+cJcpsx/ZBzWctE91EapNcJlJqlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898576; c=relaxed/simple;
	bh=RnO6uv8HRi8ObI+RtKyEOrQ+9Cm9ALlIkZ6dw4lENc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYHSLDA9TnP96fTC2Rue9H4snMguCutmYuUS2F3K2n5fYiWmYVWgeZSBOY4lbJIPonJLNS/Kh5ht/Xdhl1gQCSNIliz7N5KDKn774DXcZQ9Kg5fpelvP/+mhgJlKot49cmjzjbYit3NCMy59DDzUfuof2J3vA7/0MXbcn63LxVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JyPbud29; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c42f406fa5so65819a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 12:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727898573; x=1728503373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dzdt4GqtyHMMk9bZurHX/Y4rm7tRkS7KSsld1cCXB3k=;
        b=JyPbud29xThN9i9vxDWj7rgwL1J4LYdZTQ1agTQ0QKfRAQNgSO9lmiRxYE13KGhjbo
         Gj5m+TamdNVZSZbnzpZu5MOvDq75shP56ZgXFtqwrbLFF3K0rKDLfsvWZnzYXNDSzsf9
         0NAFgEEy3M7xi6p9UUppCXCtrrL9crit089Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727898573; x=1728503373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dzdt4GqtyHMMk9bZurHX/Y4rm7tRkS7KSsld1cCXB3k=;
        b=WHX68e6TYvOqfFdO89YiWp6t/MWBIESMexAk8C87TJzPDK2KF5hHefAubErcS22Xzy
         jeDIQ1KVPZfFrjHo6aesSpmSN9m6EKlQBHQY5zvlJRUWZ3MGsNu4pM8u53E7rK32FTJt
         2hjwYsnTv+r/q1iCA+gx8E6zV3Tr26pAVePmRBrxZYpAbtrw2HeLV7nEHj8Lq7ZinU4c
         e/uxj76eqz7ZylNUsvC7H00kbNgenQhXHtmcqsNSHynbVzSKwCli3xKML6FLDqLbQ9Xa
         il6n/pu0BIP7bnwcTUkUq8kAoHNMYN875OICksbmZ82CHFdYP4CMTgPS2TVvPFPKr0n6
         tupQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfTwDr4Ka9e2yP/h6Jihf0U/L0pcYxc97sJ4kQkrmiJ4rKMH8UwHq6VKZuoQ8g/fJjJyNbMBCe9llD3f8p@vger.kernel.org
X-Gm-Message-State: AOJu0YxmENT2uNHLVGtdgWPyuwPVUzfjU/nr1eXXxyWMj2HnSruJXgAx
	fh073MIwwIgbWE43GUYSKwknD0csZF8tPgF+sJvztyG2SiPuxe4hInxu8iv+E4ScOHAiZ24UFMY
	Asq0Shg==
X-Google-Smtp-Source: AGHT+IGZQbgoyiuWT4vuEQtIBaTGA50KeCgpSUPBRXREdItVw+jjVfq9SLPR32bJJtXlYupTIEV9lg==
X-Received: by 2002:a05:6402:3549:b0:5c4:2384:c485 with SMTP id 4fb4d7f45d1cf-5c8b1b65a4dmr4156631a12.27.1727898572585;
        Wed, 02 Oct 2024 12:49:32 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248b707sm8025136a12.76.2024.10.02.12.49.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 12:49:32 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37cd26c6dd1so181016f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 12:49:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmoN+dey5SmUk38uoWc0h9CByRP2CCjgmfsehUsq9AEy0614wAKVWN4DqoqIwJiFFOeZGVsqtd1wubyaqu@vger.kernel.org
X-Received: by 2002:adf:e712:0:b0:37c:d1c6:7e45 with SMTP id
 ffacd0b85a97d-37cfba0a614mr3298213f8f.40.1727898570159; Wed, 02 Oct 2024
 12:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002014017.3801899-1-david@fromorbit.com> <20241002-lethargisch-hypnose-fd06ae7a0977@brauner>
 <Zv098heGHOtGfw1R@dread.disaster.area>
In-Reply-To: <Zv098heGHOtGfw1R@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Oct 2024 12:49:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBqi+1YjH=-AiSDqx8p0uA6yGZ=HmMKtkGC3Ey=OhXhw@mail.gmail.com>
Message-ID: <CAHk-=wgBqi+1YjH=-AiSDqx8p0uA6yGZ=HmMKtkGC3Ey=OhXhw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	kent.overstreet@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 05:35, Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Oct 02, 2024 at 12:00:01PM +0200, Christian Brauner wrote:
>
> > I don't have big conceptual issues with the series otherwise. The only
> > thing that makes me a bit uneasy is that we are now providing an api
> > that may encourage filesystems to do their own inode caching even if
> > they don't really have a need for it just because it's there.  So really
> > a way that would've solved this issue generically would have been my
> > preference.
>
> Well, that's the problem, isn't it? :/
>
> There really isn't a good generic solution for global list access
> and management.  The dlist stuff kinda works, but it still has
> significant overhead and doesn't get rid of spinlock contention
> completely because of the lack of locality between list add and
> remove operations.

I much prefer the approach taken in your patch series, to let the
filesystem own the inode list and keeping the old model as the
"default list".

In many ways, that is how *most* of the VFS layer works - it exposes
helper functions that the filesystems can use (and most do), but
doesn't force them.

Yes, the VFS layer does force some things - you can't avoid using
dentries, for example, because that's literally how the VFS layer
deals with filenames (and things like mounting etc). And honestly, the
VFS layer does a better job of filename caching than any filesystem
really can do, and with the whole UNIX mount model, filenames
fundamentally cross filesystem boundaries anyway.

But clearly the VFS layer inode list handling isn't the best it can
be, and unless we can fix that in some fundamental way (and I don't
love the "let's use crazy lists instead of a simple one" models) I do
think that just letting filesystems do their own thing if they have
something better is a good model.

That's how we deal with all the basic IO, after all. The VFS layer has
lots of support routines, but filesystems don't *have* to use things
like generic_file_read_iter() and friends.

Yes, most filesystems do use generic_file_read_iter() in some form or
other (sometimes raw, sometimes wrapped with filesystem logic),
because it fits their model, it's convenient, and it handles all the
normal stuff well, but you don't *have* to use it if you have special
needs.

Taking that approach to the inode caching sounds sane to me, and I
generally like Dave's series. It looks like an improvement to me.

              Linus

