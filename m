Return-Path: <linux-fsdevel+bounces-9257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC9283FA08
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 22:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779AF1F221BD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 21:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45AD3C46B;
	Sun, 28 Jan 2024 21:19:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150D3C068;
	Sun, 28 Jan 2024 21:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706476778; cv=none; b=Ts4QLZZROPfuP0rGx3DbDMX1HudeN9ALJIqf+n0qw7rmR6cXBBR+MSycUqVbRi4avn7BJ6NDCQNk6JIQzVpLDvoTV4yauTPQedX7hPqzA69VuCAkwCmepHRfr3uKIhaMrn6ZldHzlhou413mNmECi7bhDOhodAdq0O+4H5w9dBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706476778; c=relaxed/simple;
	bh=GUpw5izvhyZ2h4yrNEtqr/QWSWIXNewKupdAHYrEHOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unKfjX1I17+Seb0Y2yb+2oUiIXYFiDxhbWwW1Hb943faubJ5Jaf0EXM535gl+L1h32OKIHNYhZFPR4nUL/Yqt93I1GnxxovsDz14XxVGd5WrjlmQwvwu1Gh09rSbGyZq89wlN6xDDwzBU2/kBLMDvQo9ObTSxzIDL0CLuzA/zII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7446C433F1;
	Sun, 28 Jan 2024 21:19:36 +0000 (UTC)
Date: Sun, 28 Jan 2024 16:19:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner
 <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240128161935.417d36b3@rorschach.local.home>
In-Reply-To: <CAHk-=whKJ6dzQJX27gvL4Xug5bFRKW7_Cx4XpngMKmWxOtb+Qg@mail.gmail.com>
References: <20240126150209.367ff402@gandalf.local.home>
	<CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
	<20240126162626.31d90da9@gandalf.local.home>
	<CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
	<CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
	<CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
	<20240128151542.6efa2118@rorschach.local.home>
	<CAHk-=whKJ6dzQJX27gvL4Xug5bFRKW7_Cx4XpngMKmWxOtb+Qg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 12:53:31 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Honestly, you should just *always* do refcounting. No "free after RCU
> delay" as an alternative. Just refcount it.
> 
> Now, the RCU delay may be needed if the lookup of said structure
> happens under RCU, but no, saying "I use SRCU to make sure the
> lifetime is at least X" is just broken.
> 
> The refcount is what gives the lifetime. Any form of RCU-delaying
> should then be purely about non-refcounting RCU lookups that may
> happen as the thing is dying (and said lookup should *look* at the
> refcount and say "oh, this is dead, I'm not returning this".

The deleting of the ei is done outside the VFS logic. I use SRCU to
synchronize looking at the ei children in the lookup. On deletion, I
grab the eventfs_mutex, set ei->is_freed and then wait for SRCU to
finish before freeing.

The lookup checks ei->is_freed and doesn't do anything if set, but most
that logic is under the SRCU, which is what I want to make sure is
finished before the ei is deleted.

Hmm, I still need the logic for iput(), as dentry->d_fsdata can still
access the ei. That's where I need to have the ref counters. For a
lookup, I need to up the ref count when I create a new inode for the ei
or its children. Then in the iput() I decrement the ei ref count. I can
only free the ei if the ref count is zero.

The ref count is for knowing if an ei is referenced by a
dentry->d_fsdata, and the SRCU is to make sure there's no lookups
accessing an ei.

-- Steve

