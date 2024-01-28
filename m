Return-Path: <linux-fsdevel+bounces-9261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF8E83FA3C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 23:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B74282CF3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 22:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676FC3C484;
	Sun, 28 Jan 2024 22:01:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BEF3C461;
	Sun, 28 Jan 2024 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706479290; cv=none; b=D+Hu7hKEsSvEyBmtS01VN5C2kksNyhUsU2IzEGxAhr/NSHCgdtA2cLXo/onFkmtDmt1tCkKm84F6+xR4KBlxuVAH5opD5HUNhyMSIis2o5jtrG+SQuiMx79W93qn2MIH5ISiXMOpGe2h1cHsWWS5f8EuyaGEW5nDIrmAFlICAFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706479290; c=relaxed/simple;
	bh=ssQbheLqlmCPZsjWzxOefn+0xp44vjzjY+8m+zuL42w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYAgmmthmfzIuiEzbTyQvtoBnCp+RcwpjvWZzSgsiXv9D9/XcOoonKKkTI2dpXyl36+QOkl3jcJ04Mjq61+Adjb4nVy2/ySf7ZGBR3tsio8gi521zSR9hV2pC5FLjSDwRom611l6dtMHvTJ8KAtaMzajEsK+Uwr5fhwFgyvDn54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E89C433F1;
	Sun, 28 Jan 2024 22:01:27 +0000 (UTC)
Date: Sun, 28 Jan 2024 17:01:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner
 <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240128170125.7d51aa8f@rorschach.local.home>
In-Reply-To: <CAHk-=wiWo9Ern_MKkWJ-6MEh6fUtBtwU3avQRm=N51VsHevzQg@mail.gmail.com>
References: <20240126150209.367ff402@gandalf.local.home>
	<CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
	<20240126162626.31d90da9@gandalf.local.home>
	<CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
	<CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
	<CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
	<20240128151542.6efa2118@rorschach.local.home>
	<CAHk-=whKJ6dzQJX27gvL4Xug5bFRKW7_Cx4XpngMKmWxOtb+Qg@mail.gmail.com>
	<CAHk-=wiWo9Ern_MKkWJ-6MEh6fUtBtwU3avQRm=N51VsHevzQg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 13:08:55 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 28 Jan 2024 at 12:53, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Now, the RCU delay may be needed if the lookup of said structure
> > happens under RCU, but no, saying "I use SRCU to make sure the
> > lifetime is at least X" is just broken.  
> 
> Put another way, the only reason for any RCU should be that you don't
> use locking at lookup, and the normal lookup routine should follow a
> pattern something like this:
> 
>     rcu_read_lock();
>     entry = find_entry(...);
>     if (entry && !atomic_inc_not_zero(&entry->refcount))
>         entry = NULL;
>     rcu_read_unlock();
> 
> and the freeing should basically follow a pattern like
> 
>     if (atomic_dec_and_test(&entry->refcount))
>         rcu_free(entry);

Basically you are saying that when the ei is created, it should have a
ref count of 1. If the lookup happens and does the
atomic_inc_not_zero() it will only increment if the ref count is not 0
(which is basically equivalent to is_freed).

And then we can have deletion of the object happen in both where the
caller (kprobes) deletes the directory and in the final iput()
reference (can I use iput and not the d_release()?), that it does the
same as well.

Where whatever sees the refcount of zero calls rcu_free?

-- Steve

