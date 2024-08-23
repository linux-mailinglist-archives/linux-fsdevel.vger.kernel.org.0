Return-Path: <linux-fsdevel+bounces-26884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3861F95C811
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 10:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5ED281544
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 08:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30372143C6C;
	Fri, 23 Aug 2024 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpmZqLcN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9117813C827
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401794; cv=none; b=uSyt13wgLez+b+4F/SGH7tiiDRNLa7zePgLQnVwXWzArMdeDY0C3QY3KOm4W19rRUjfrvq1s5JsVrvqp1++UxFJm2lXFI4k5th5jbdnVF5LHDNp//sjLyroKJszF+5aWUYZyE99GLAGkWlfuUYyQJVYp8i/6fq4YXBMpamXjkQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401794; c=relaxed/simple;
	bh=omWEQWTCto5tcmumOjZ8DtRFS3w8ypJy8rx/adt3Cpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9LzDHQ8P2lVnuvt2GPVu32vP+xwTl5E/1mm7rTsD7TXOVmh7f/4+FOwAmEjqDf5QgN6QUSC4Ile8H3vlk7krVm+lY5sc1nYUR/19cnaoKg45pBfZFDfAJR0UIX7hdC515fJKwn+8PAPfOx8K7TAcybUgJD/vMAKhCDZndvbJ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpmZqLcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D519C32786;
	Fri, 23 Aug 2024 08:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724401794;
	bh=omWEQWTCto5tcmumOjZ8DtRFS3w8ypJy8rx/adt3Cpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PpmZqLcNLKrNXkniE3vpXB6oXqiHuZ2MQxWqU3qMz+2f/AODxfDPpwCQ28oe7PdOk
	 2pAr4JCBAHohrx1s3AlqFG/w0zn7ynqJW6ltbUlDiRBZk6Iwjs8BqLeteuUi0Iyj3A
	 i8nMVi330pGV3/h2VdT3sESxdPaMCakir/0uj/TmhH4HdNHvvxsbMhNzB/hLZTo/JA
	 lijNsm981QyQHP0lr4ma6j9p+FvxvZL+WyvlFZUJWmIzAEN2+JetIGOldaJ3LfOmLX
	 XecFLjGVT676mpEUxt8ZCcyHfKV1AhhoyN+R8NGDN7lIUbfgqVd2m843tj92pxwUFA
	 5deHa1utVNB2w==
Date: Fri, 23 Aug 2024 10:29:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 5/6] inode: port __I_LRU_ISOLATING to var event
Message-ID: <20240823-festnageln-enden-c123e903798f@brauner>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
 <20240821-work-i_state-v2-5-67244769f102@kernel.org>
 <172437341576.6062.4865045633122673711@noble.neil.brown.name>
 <CAHk-=wgocMvG7Lcrju7PgnWfUfsr3fEVOk=gwmGOhtTOdYdNjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgocMvG7Lcrju7PgnWfUfsr3fEVOk=gwmGOhtTOdYdNjA@mail.gmail.com>

On Fri, Aug 23, 2024 at 10:24:57AM GMT, Linus Torvalds wrote:
> On Fri, 23 Aug 2024 at 08:37, NeilBrown <neilb@suse.de> wrote:
> >
> > I would really like to add
> >
> >   wait_var_event_locked(variable, condition, spinlock)
> >
> > so that above would be one or two lines.
> 
> We don't even have that for the regular wait_event, but we do have
> 
>   wait_event_interruptible_locked
>   wait_event_interruptible_locked_irq
> 
> but they actually only work on the wait-queue lock, not on some
> generic "use this lock".
> 
> Honestly, I like your version much better, but having two *very*
> different models for what "locked" means looks wrong.
> 
> The wait-queue lock (our current "locked" event version) is a rather
> important special case, though, and takes advantage of holding the
> waitqueue lock by then using __add_wait_queue_entry_tail() without
> locking.
> 
> "You are in a maze of twisty little functions, all alike".

"You could've used a little more cowbell^wunderscores."

__fput()
____fput()

__wait_var_event()
___wait_var_event()

https://www.youtube.com/watch?v=cVsQLlk-T0s

