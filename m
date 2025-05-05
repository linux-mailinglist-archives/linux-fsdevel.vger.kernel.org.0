Return-Path: <linux-fsdevel+bounces-48083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9305DAA94D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9563A3BB1C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D65258CE8;
	Mon,  5 May 2025 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTQlqip/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D1C2C859;
	Mon,  5 May 2025 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746453052; cv=none; b=JrB4a0ZxKVqz3/Yt9scEezyb48Fu/+JPy6PO1DAD5g1YCd3KrUNHe9OrzV6ryBN1YBGZoo0NQMSzAZU/nivv4g+iO8uhKQ0qoxEFwZh7wNhJSHZSr/AhDju6E5C6mbQSNvap4TDSplPkAOw1pqMiIFtKhqtgrS5/rZhnvwt5+O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746453052; c=relaxed/simple;
	bh=Vqk0ZpZc2qCwVlVPa1gNgdMWQzO0ZUreacqfzsriyUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxxq4seAFvOCGpgpY/WZikIAE68zEbzB+6wQ9MkltnhvYzd7Yt9/3w8GgWvFWdkgqcGAewltpUdQiyHOgPLqPtr7UiF1pFEEIHqyzQTAkNHIGNQnSDI8PochzFyvDiVNh5FrjxR505B2CV0quP83Jvy4POEGRMWnbt/bgFhUQEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTQlqip/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FD5C4CEE4;
	Mon,  5 May 2025 13:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746453051;
	bh=Vqk0ZpZc2qCwVlVPa1gNgdMWQzO0ZUreacqfzsriyUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTQlqip/9RtDq3faJnMsVwE+9Nde3Mnr3H4IzjZ81T1juQF7EOoMHDLstfmKej10J
	 H5gITaG4z0iFzIuIUu5YI7joHG0oT4jg+r6UknQ66QsthJD0whwF68MulFkkvvx6et
	 WST+LOzBuWuy5KdJQ27kmB+EfVrnyofS9Igy5t4TJA6uKGA0YIxV3KfJwtKhE0pqQt
	 4t7Fv+aAPqZhR3s55I2uhb1r5gusiltCLG2pwI7myW53nhgqHhnin9Pc/ah2May61z
	 7/WfFkRLcv9dcAN0AftB7MhohCeBd6cdZO5VhJRPo7G8KY1PzQPG8f2UkLMhs1fkaW
	 5roincr1ws3Uw==
Date: Mon, 5 May 2025 15:50:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 7/8] mm/maps: read proc/pid/maps under RCU
Message-ID: <20250505-wachen-konform-3fe08f1b3214@brauner>
References: <20250418174959.1431962-1-surenb@google.com>
 <20250418174959.1431962-8-surenb@google.com>
 <CAG48ez3YLWh9hXQQdGVQ7hCsd=k_i2Z2NO6qzT6NaOYiRjy=nw@mail.gmail.com>
 <CAJuCfpGGiwTbMeGAeYNtQ5SsFenUw8up6ToLy=VstULM_TSoXA@mail.gmail.com>
 <CAG48ez15g5n9AoMJk1yPHsDCq2PGxCHc2WhCAzH8B2o6PgDwzQ@mail.gmail.com>
 <CAJuCfpG+YjyVE-6TaAQEjwc0iixqN8Epf25jo2awtL=gqY=afA@mail.gmail.com>
 <CAG48ez0ntTH_sOaPiqML715jyTCujwyh3Og1wBq9RNLbu55C5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0ntTH_sOaPiqML715jyTCujwyh3Og1wBq9RNLbu55C5Q@mail.gmail.com>

On Tue, Apr 29, 2025 at 08:54:58PM +0200, Jann Horn wrote:
> On Tue, Apr 29, 2025 at 8:04 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > On Tue, Apr 29, 2025 at 10:21 AM Jann Horn <jannh@google.com> wrote:
> > >
> > > Hi!
> > >
> > > (I just noticed that I incorrectly assumed that VMAs use kfree_rcu
> > > (not SLAB_TYPESAFE_BY_RCU) when I wrote my review of this, somehow I
> > > forgot all about that...)
> >
> > Does this fact affect your previous comments? Just want to make sure
> > I'm not missing something...
> 
> When I suggested using "WRITE_ONCE(vma->vm_file, NULL)" when tearing
> down a VMA, and using get_file_rcu() for the lockless lookup, I did
> not realize that you could actually also race with all the other
> places that set ->vm_file, like __mmap_new_file_vma() and so on; and I
> did not think about whether any of those code paths might leave a VMA
> with a dangling ->vm_file pointer.
> 
> I guess maybe that means you really do need to do the lookup from the
> copied data, as you did in your patch; and that might require calling
> get_file_active() on the copied ->vm_file pointer (instead of
> get_file_rcu()), even though I think that is not really how
> get_file_active() is supposed to be used (it's supposed to be used
> when you know the original file hasn't been freed yet). Really what

I think it's fine for get_file_active() to be used in this way. That
->vm_file pointer usage should get a fat comment above it explaining how
what you're doing is safe.

> you'd want for that is basically a raw __get_file_rcu(), but that is
> static and I think Christian wouldn't want to expose more of these
> internals outside VFS...

Yeah, no. I don't want that to be usable outside of that file.

> (In that case, all the stuff below about get_file_rcu() would be moot.)
> 
> Or you could pepper WRITE_ONCE() over all the places that write
> ->vm_file, and ensure that ->vm_file is always NULLed before its
> reference is dropped... but that seems a bit more ugly to me.
> 
> > > On Tue, Apr 29, 2025 at 7:09 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > On Tue, Apr 29, 2025 at 8:40 AM Jann Horn <jannh@google.com> wrote:
> > > > > On Fri, Apr 18, 2025 at 7:50 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > > > With maple_tree supporting vma tree traversal under RCU and vma and
> > > > > > its important members being RCU-safe, /proc/pid/maps can be read under
> > > > > > RCU and without the need to read-lock mmap_lock. However vma content
> > > > > > can change from under us, therefore we make a copy of the vma and we
> > > > > > pin pointer fields used when generating the output (currently only
> > > > > > vm_file and anon_name). Afterwards we check for concurrent address
> > > > > > space modifications, wait for them to end and retry. While we take
> > > > > > the mmap_lock for reading during such contention, we do that momentarily
> > > > > > only to record new mm_wr_seq counter. This change is designed to reduce
> > > > > > mmap_lock contention and prevent a process reading /proc/pid/maps files
> > > > > > (often a low priority task, such as monitoring/data collection services)
> > > > > > from blocking address space updates.
> > > > > [...]
> > > > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > > > index b9e4fbbdf6e6..f9d50a61167c 100644
> > > > > > --- a/fs/proc/task_mmu.c
> > > > > > +++ b/fs/proc/task_mmu.c
> > > > > [...]
> > > > > > +/*
> > > > > > + * Take VMA snapshot and pin vm_file and anon_name as they are used by
> > > > > > + * show_map_vma.
> > > > > > + */
> > > > > > +static int get_vma_snapshot(struct proc_maps_private *priv, struct vm_area_struct *vma)
> > > > > > +{
> > > > > > +       struct vm_area_struct *copy = &priv->vma_copy;
> > > > > > +       int ret = -EAGAIN;
> > > > > > +
> > > > > > +       memcpy(copy, vma, sizeof(*vma));
> > > > > > +       if (copy->vm_file && !get_file_rcu(&copy->vm_file))
> > > > > > +               goto out;
> > > > >
> > > > > I think this uses get_file_rcu() in a different way than intended.
> > > > >
> > > > > As I understand it, get_file_rcu() is supposed to be called on a
> > > > > pointer which always points to a file with a non-zero refcount (except
> > > > > when it is NULL). That's why it takes a file** instead of a file* - if
> > > > > it observes a zero refcount, it assumes that the pointer must have
> > > > > been updated in the meantime, and retries. Calling get_file_rcu() on a
> > > > > pointer that points to a file with zero refcount, which I think can
> > > > > happen with this patch, will cause an endless loop.
> > > > > (Just as background: For other usecases, get_file_rcu() is supposed to
> > > > > still behave nicely and not spuriously return NULL when the file* is
> > > > > concurrently updated to point to another file*; that's what that loop
> > > > > is for.)
> > > >
> > > > Ah, I see. I wasn't aware of this subtlety. I think this is fixable by
> > > > checking the return value of get_file_rcu() and retrying speculation
> > > > if it changed.
> > >
> > > I think you could probably still end up looping endlessly in get_file_rcu().
> 
> (Just to be clear: What I meant here is that get_file_rcu() loops
> *internally*; get_file_rcu() is not guaranteed to ever return if the
> pointed-to file has a zero refcount.)
> 
> > By "retrying speculation" I meant it in the sense of
> > get_vma_snapshot() retry when it takes the mmap_read_lock and then
> > does mmap_lock_speculate_try_begin to restart speculation. I'm also
> > thinking about Liam's concern of guaranteeing forward progress for the
> > reader. Thinking maybe I should not drop mmap_read_lock immediately on
> > contention but generate some output (one vma or one page worth of
> > vmas) before dropping mmap_read_lock and proceeding with speculation.
> 
> Hm, yeah, I guess you need that for forward progress...
> 
> > > > > (If my understanding is correct, maybe we should document that more
> > > > > explicitly...)
> > > >
> > > > Good point. I'll add comments for get_file_rcu() as a separate patch.
> > > >
> > > > >
> > > > > Also, I think you are introducing an implicit assumption that
> > > > > remove_vma() does not NULL out the ->vm_file pointer (because that
> > > > > could cause tearing and could theoretically lead to a torn pointer
> > > > > being accessed here).
> > > > >
> > > > > One alternative might be to change the paths that drop references to
> > > > > vma->vm_file (search for vma_close to find them) such that they first
> > > > > NULL out ->vm_file with a WRITE_ONCE() and do the fput() after that,
> > > > > maybe with a new helper like this:
> > > > >
> > > > > static void vma_fput(struct vm_area_struct *vma)
> > > > > {
> > > > >   struct file *file = vma->vm_file;
> > > > >
> > > > >   if (file) {
> > > > >     WRITE_ONCE(vma->vm_file, NULL);
> > > > >     fput(file);
> > > > >   }
> > > > > }
> > > > >
> > > > > Then on the lockless lookup path you could use get_file_rcu() on the
> > > > > ->vm_file pointer _of the original VMA_, and store the returned file*
> > > > > into copy->vm_file.
> > > >
> > > > Ack. Except for storing the return value of get_file_rcu(). I think
> > > > once we detect that  get_file_rcu() returns a different file we should
> > > > bail out and retry. The change in file is an indication that the vma
> > > > got changed from under us, so whatever we have is stale.
> > >
> > > What does "different file" mean here - what file* would you compare
> > > the returned one against?
> >
> > Inside get_vma_snapshot() I would pass the original vma->vm_file to
> > get_file_rcu() and check if it returns the same value. If the value
> > got changed we jump to  /* Address space got modified, vma might be
> > stale. Re-lock and retry. */ section. That should work, right?
> 
> Where do you get an "original vma->vm_file" from?
> 
> To be clear, get_file_rcu(p) returns one of the values that *p had
> while get_file_rcu(p) is running.

