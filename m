Return-Path: <linux-fsdevel+bounces-36207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AE69DF5EE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 15:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C234281BB0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 14:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECD01D5CDD;
	Sun,  1 Dec 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOtUuIMd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7218E4D8A3;
	Sun,  1 Dec 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733062640; cv=none; b=OUezD1K9dHf4QwCpHATWRwnJIKOO2rTYwjmt6SiBa38ZX37ZKvkafiibem4rQVwC0/luRJz/mBr6cpgJAvlizC70k6VXAS4oDl/ODdGVuFa0CWgH4sZkdkukOgZksndXIMKmvMxGkWav0D6D8K+JaMC0PAe8jlbFcOxvyOmIxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733062640; c=relaxed/simple;
	bh=DrUsAqQ1VrrITAmnB41RxEst13PDZyHTTGTu987L3I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZVASd0gItAiM7GVlMAkrB7tOSwENo4+JuPksJHr+KRhWYxHvPVcnjBxNPa91uehpEkIk/lHVf7YEukHdKwv0ARh4BSH3Ev6iHcRpVd4xb/ZHc53OOUMPJ7DrY4vRaUVRNeuXXpQkc9ocKNdk4q7pniJteESaFUHYGRktPhKHMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOtUuIMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE64AC4CECF;
	Sun,  1 Dec 2024 14:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733062638;
	bh=DrUsAqQ1VrrITAmnB41RxEst13PDZyHTTGTu987L3I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOtUuIMdEEw18pth+jDSDXBhMnHYQV3c2/DFCEfBfNjvCipuNZVg+ugdDAp69fWZF
	 epvlPebS+SFeG9qNVTlgj89hCHlXQnRQeM095gK5AYX6epWSuwpWb6weIjk9FX4XG/
	 3Y+5plX7utoay2eD1LKNH6u8fxqWKWf7y6Zdh+b3Ftvhu51+rHhdfPfUMFSb0WV71E
	 0LWycyytBlD71Qm5nk1Q1F2tQo5aaBNlUCXT5W+a9n/z8MrVgRlE3e9pDKfEUJcNTL
	 KRiXrC7dtrl4rnY8YD8LnAyVnb8U8rygRCRnuq5rG4DJcmXfWxaxubf+FQXa4tdQxN
	 3sUH+M+K+h6yA==
Date: Sun, 1 Dec 2024 15:17:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Tycho Andersen <tandersen@netflix.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: fix up /proc/pid/comm in the
 execveat(AT_EMPTY_PATH) case
Message-ID: <20241201-konglomerat-genial-c1344842c88b@brauner>
References: <20241130045437.work.390-kees@kernel.org>
 <20241130-ohnegleichen-unweigerlich-ce3b8af0fa45@brauner>
 <CAHk-=wi=uOYxfCp+fDT0qoQnvTEb91T25thpZQYw1vkifNVvMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=uOYxfCp+fDT0qoQnvTEb91T25thpZQYw1vkifNVvMQ@mail.gmail.com>

On Sat, Nov 30, 2024 at 10:02:38AM -0800, Linus Torvalds wrote:
> On Sat, 30 Nov 2024 at 04:30, Christian Brauner <brauner@kernel.org> wrote:
> >
> > What does the smp_load_acquire() pair with?
> 
> I'm not sure we have them everywhere, but at least this one at dentry
> creation time.
> 
> __d_alloc():
>         /* Make sure we always see the terminating NUL character */
>         smp_store_release(&dentry->d_name.name, dname); /* ^^^ */
> 
> so even at rename time, when we swap the d_name.name pointers
> (*without* using a store-release at that time), both of the dentry
> names had memory orderings before.
> 
> That said, looking at swap_name() at the non-"swap just the pointers"
> case, there we do just "memcpy()" the name, and it would probably be
> good to update the target d_name.name with a smp_store_release.
> 
> In practice, none of this ever matters. Anybody who uses the dentry
> name without locking either doesn't care enough (like comm[]) or will
> use the sequence number thing to serialize at a much higher level. So
> the smp_load_acquire() could probably be a READ_ONCE(), and nobody
> would ever see the difference.

Right now it's confusing. So no matter if we do READ_ONCE() or
smp_load_acquire() there'd please be a comment explaing why so we don't
pointlessly leave everyone wondering about that barrier.

/*
 * Hold rcu lock to keep the name from being freed behind our back.
 * Use cquire semantics to make sure the terminating NUL from
 * __d_alloc() is seen.
 *
 * Note, we're deliberately sloppy here. We don't need to care about
 * detecting a concurrent rename and just want a sensible name.
 */
rcu_read_lock();
__set_task_comm(me, smp_load_acquire(&file_dentry(bprm->file)->d_name.name), true);
rcu_read_unlock();

or something better.

