Return-Path: <linux-fsdevel+bounces-60703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E556B502BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 18:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E5636344D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01449272E7B;
	Tue,  9 Sep 2025 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKHFXDBb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EF42DCF6B;
	Tue,  9 Sep 2025 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435539; cv=none; b=k66TRJiT2H1l+zfLUfOLwg4HccsnM/PyBgdUQv9WV1lRS9ZT+H28bhvlKbDMrQEQboAyiQRqELUqDSG+4ap8ouxB54i3Ms7uBmb9wtamWdVMnaUIpZ5+pm2U+qxMimwF2h4d6NezmtI5TjI+0VkfxMo6G+DjG6ZeCV5ChWPWhFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435539; c=relaxed/simple;
	bh=VA8kSZeCvm2+t7NQDLwz0tPDeeIVHmFGODhgUbAgT6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcYIuE2bA6SALD97taGf+H/4EH9Rleo5HMHtZ3DQR07mx227qa+8PD+8/toEjYUL2urewErB7zpjszuA1Ours/neqnV3YKvaePT+Jqx5STCxRpyT/3E8mYIWoiXFjTvbfX0MUXqQk3puJtJE91d6T1lkUqmQiNHBXV52k97C1ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKHFXDBb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45debcea3aeso12263225e9.3;
        Tue, 09 Sep 2025 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757435535; x=1758040335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wbYTk2JPptJ3W+J+MPkUAKMlaUcMoA7/y+wPZtESr2w=;
        b=UKHFXDBbn8j3EV+ubFANBO9gmV/b+r5bOwkZYmniSryP/DB4HVWghDhqEf3GmFIsBz
         za5A4dUBdHs+r4JBXd6wURkvEuIZlE7uhYPlLvpn/nAiXdJHBeud9ZGmoAORlEvXkVzx
         SuG4oVTP7VNSU2Tk/SvbcZvmTMRLGXh+g6/+hqNwBtUdGUIYa7/7H1STChv/Pp67mQPc
         Wxy2UCUKPBqOi92XrEtxt+G9tnp8TY1S3/hS0GKFFgp+bp1e69Z+ToB3Wna1Tm8KApkM
         0kIpad5bYkqS3Tm+qSBFYi2qwmsNhbD+y4xRgPL/+Kk8eaPI0VkM8idRQ5T6xq8T4CDZ
         lNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757435535; x=1758040335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbYTk2JPptJ3W+J+MPkUAKMlaUcMoA7/y+wPZtESr2w=;
        b=kwmbqc7Z+lZ8Ez8e3Bb3biNOiO1zqIcLct7ZXwft+HaMSF0PNCeYAstgCu6e7n2HeF
         fPYTkAIuiWuG1tzp3POZy/05oGUWcSRDHPERtVCOzhmiBLyrfZhm9scRh/+nWSliWOHl
         l+u/Obsd4LrNnoq8Lyk/TWsxi3V8IZHOAi0TsQY40f12Dpk0E7xVM+gsorR69wlsj1TW
         0sp1wv1DiYMxXR4qw56fyZyJtyp/TmBtgQX7XcpnXWBgBVMz+KJD5+NGk/jwIyvlYFEA
         TmkinE0vizZO5ICdMJr83BkVlgVOfLwzq5Nn2BdQ/+Ox4MmtGtaoUAxFIee8gGOhdgTb
         p2UA==
X-Forwarded-Encrypted: i=1; AJvYcCUDjhY2msHA+H3zOuiVlJWJh44DK2+QrwCCb7Kl4owQm17vW+Ta4oL5XODPQLxcgsl2OysewFWyn3ZP@vger.kernel.org, AJvYcCUhvs+lpj86gM+VrE9ceHXDQ2MV90y1ggA+1XJG4oaqRx1L2VQBBAJ4fv35Br8POXbe8SKfNf1pYuPOww==@vger.kernel.org, AJvYcCXP72pyvIkKs02KTRjTllx3zhL1MHNSKvxHmPKQo5XFw3XQDusDRwMYuj/fVlwkT3uPjZrYTz4Q/Zwbag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPhXgmMU+8een34n3fJlIi2xwwb1W68V6wGVqJ09lx/y1Z3l41
	nomDHBlgJ1Wfe8KKX2pVlFQfxUry8gEbgQz2MwfCIZR7JtTKIThM6ujY
X-Gm-Gg: ASbGncvsOy3ajQgJjOzLcG2MRlBPNtCGCd7vUl1cJ7W9NeezJeWXQWXervWku2YzazX
	3OTYqtwC0pAOJxnH24iD0aMrrv+e57nijgqRQ4o2XM76OGK8a7sxlKOUFxP+4GjzNuCfKkWrjef
	+hu7ns+sA2T7/4lSB+Qi/ep1mULtL+8xXVQ66vjZbyx+2tLty/gTy0MofB+ZeDv/QiGu7VM/IuZ
	NYBjL2TVPbbDVCd5/1nLz3MaXWcGAG8N8Rw2x0g84O6FW4+yOgy7+G/vXzHknsIyxjbxOvywOm6
	5qKiBepnJNj71oz4YWwhgd//uF2SsT+vA1LqzI9cqKhu3bM4iFyqmmV9XExkSu/4GGodVTmpEfX
	2P7l4JtahdTVXjCWAADlcmrrplPsQgee7e9wiY0AmfH+xzidv
X-Google-Smtp-Source: AGHT+IHTRb4pbzVPo5ZtOoR2qIEMJwme9q30LOB5pgTlTtjAorxcr6SJhpp1OJ/wwX0HWSyf5GnBVg==
X-Received: by 2002:a05:600c:3502:b0:45d:dc07:d8f7 with SMTP id 5b1f17b1804b1-45df6a61503mr4907625e9.4.1757435534633;
        Tue, 09 Sep 2025 09:32:14 -0700 (PDT)
Received: from f (cst-prg-84-152.cust.vodafone.cz. [46.135.84.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bfd08sm3203284f8f.4.2025.09.09.09.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:32:13 -0700 (PDT)
Date: Tue, 9 Sep 2025 18:32:06 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 00/54] fs: rework inode reference counting
Message-ID: <frffkyu6vac5v7qt5ee36xmg6hrwwdks7mnn2k7krdqecn56mc@3kwx24xtmane>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <eeu47pjcaxkfol2o2bltigfjvrz6eecdjwtilnmnprqh7dhdn7@rqi35ya5ilmv>
 <20250902211629.GA252154@fedora>
 <dpi5ey667awq63mgxrzu6qdfpeinrmeapgbllqidcdjayanz2p@kp3alvfskssp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dpi5ey667awq63mgxrzu6qdfpeinrmeapgbllqidcdjayanz2p@kp3alvfskssp>

On Tue, Sep 09, 2025 at 03:48:43PM +0200, Mateusz Guzik wrote:
> On Tue, Sep 02, 2025 at 05:16:29PM -0400, Josef Bacik wrote:
> 
> This conversation would be best had over a beer, but unfortunately it's
> not an option. ;)
> 
> I trimmed the mail prior to the summary. There was some stuff in your
> response where I don't think we have a mutual understanding who is
> arguing for what and it also shows a little in the content below. I'm
> going to try to address it.
> 
> I think there is a significant disconnect in one crucial detail which
> I'm going to note later.
>  
> > Alright I see what you're suggesting. What I want is to have the refcounts be
> > the ultimate arbiter of the state of the inode. We still need I_NEW and
> > I_CREATING. I want to separate the dirty flags off to the side so we can use
> > bitops for I_CREATING and I_NEW. From there we can do simple things about
> > waiting where we need to, and eliminate i_lock for those accesses. That way
> > inode lookup becomes xarray walk under RCU,
> > refcount_inc_not_zero(&inode->i_count), if (unlikely(test_bit(I_NEW))) etc.
> > 
> 
> I'm going to address this way below.
> 
> > This has all been long and I think I've got the gist of what you're suggesting.
> > I'm going to restate it here so I'm sure we're on the same page.
> > 
> > 1. Don't do the i_obj_count thing.
> > 2. Clean-up all the current weirdness by defining helpers that clearly define
> > the flow of the inode lifetime.
> > 3. Remove the flags that are no longer necessary.
> > 4. Continue on with my other work to remove i_hash and the i_lru.
> > 
> > I don't disagree with this approach. I would however like to argue that changing
> > the refcounting rules to be clear accomplishes a lot of the above goals, and
> > gives us access to refcount_t which allows us to capture all sorts of bad
> > behavior without needing to duplicate the effort.
> > 
> 
> The ordering may be a little off here, consider text searching for
> "primary disconnect" and reading that first if you don't like this
> paragraph. :)
> 
> This is part of what I'm saying, but it skips the justification, which
> imo puts a question mark on the i_obj_count idea.
> 
> One important bit is that the VFS layer should be able to have all its
> funcs assert whether they are legally called for a given inode and if
> the operation they are asked to do is also legal. What is legal depends
> on where the inode is in its lifecycle (literally just handed out from
> the allocator, fully constructed, or maybe in the process of being
> aborted or maybe destroyed or maybe some other state).
> 
> The binary state of merely "usable or not usable" provided by typical
> refcount schemes does not cut it and this remains true for your scheme
> with i_obj_count.
> 
> So in the name of providing an environment where the programmer can
> check wtf is happening and have the layer yell if at all possible, you
> would need to provide *something* in parallel to the new count anyway.
> 
> I outlined one way to do it with enums each denoting a dedicated state.
> 
> Another way to do it is with flags, except not in the current
> clusterfuck form.
> 
> I also argued with the *something* in place the i_obj_count becomes
> spurious.
> 
> However, if your primary objection is that "->i_count == 0" is ambiguous
> as to whether the inode happens to not have users or is being torned
> down, I have a simple solution.
> 
> Suppose the current flags are here to say for the time being, even then
> it is an invariant that ->i_count == 0 when I_FREEING is being set.
> Then you can also kill the refcount by setting it to some magic value
> indicating the obj is dead. As a result you still have your indicator in
> ->i_count.
> 
> > As an alternative approach, I could do the following.
> > 
> > 1. Pull the delayed iput work from btrfs into the core VFS.
> 
> I outlined in my previous e-mail how you can do the deferred
> ->evict_inode thing very easily with the help of the vfs layer and
> without any refcount shenanigans or putting the burden on filesystems
> which don't need/want it.
> 
> Search for "evict_deferred" to find it. It boils down to return an error
> from the routine and having evict() schedule deferred work.
> Alternatively it can be expected the filesystem already did that and
> then there is a magic entry point (e.g., evict_deferred_finish()) to
> call after the fs is finally done.
> 
> That proposal can be further twaked to pass an argument denoting who is
> calling. For example if you are already operating from task_work (due to
> deferred fput) OR fput_close_sync then maybe even btrfs can have its
> evict_inode() do the work in place?
> 
> I would really like to NOT see iput() defaulting to deferred work for
> everyone if it can be avoided, but maybe I misunderstood the problem you
> are facing there.
> 
> > 2. In all the places where we have dubious lifetime stuff (aka where I use
> > i_obj_count), replace it with more i_count usage, and rely on the delayed iput
> > infrastructure to save us here.
> > 3. Change the rules so we never have 0 refcount objects.
> > 4. Convert to refcount_t.
> 
> So I think these points showcase the primary disconnect between your
> position and mine.
> 
> AFAICS your general stance is that the current state of lifecycle is...
> lacking in quality/clarity (no argument here). At the same time
> refcounts are a well-known mechanism and the specific refcount API in
> the Linux kernel has extra stopgaps. With this in mind you want to lean
> into it, dropping as much hand-rolled code as possible, with the
> assumption this is going to reduce bugs and provide some bug-proofing
> for the future.
> 
> My stance includes few points, but the crux is I claim the proposed
> refcount approach is in fact harder to reason about and harder to
> implement in the current kernel (not to be confused with an
> implementation from scratch). All elaborated on below.
> 
> First and foremost, even if i_obj_count is to land, the pragmatic
> approach is to bring the current to state to basic sanity in small
> incremental bisectable steps (on top of providing way better assertion
> coverage). That would mean making things sensible with the flags first
> and only then switch to the new refcount scheme. Part of the problem is
> that in the VFS layer you are getting screwed over by bad filesystems
> (which the layer currently provides little self-defence against) and bad
> consumers at the same time, while the layer only provides ad-hoc asserts.
> 
> With the patchset as proposed you are making a significant jump in few
> steps leaving a big window for subtle bugs which can take forever to
> figure out. Personally I would not feel safe merging the patchset for
> this reason alone.
> 
> Next up, reported woes are not inherent to the currently taken approach
> (including ->i_count == 0 meaning it's still all fine and this not being
> an ambiguous condition or synchronisation vs writeback) and the general
> things the layer is doing at the moment can be expressed in a clean &
> debuggable & assertion-friendly manner without any extra refcounts.
> 
> As a small illustration and a step towards that goal I posted a patchset
> sorting out ->i_state handling and the I_WILL_FREE flag:
> https://lore.kernel.org/linux-fsdevel/20250909091344.1299099-1-mjguzik@gmail.com/T/#t
> 
> Something of that sort should land even if your patchset makes it way
> into mainline.
> 
> I also claim a clear-cut flow which denotes the inode as being
> in-teardown *and* providing a way for certain mechanisms to stop messing
> with it *while* it is still fully operational are important longterm.
> 
> The famed writeback is part of it.
> 
> I claim a clear-cut API which synchronizes grabbing the inode or
> buggering off vs waiting race-free is not hard to implement, it just was
> not done.
> 
> More importantly, I claim the current writeback code may be actively
> depending on various parts of the inode not being torned down while it
> is operating. With your proposal of only guarding the actual freeing of
> the backing struct, an extensive review would be needed to make sure
> this is not happening.
> 
> > 5. Remove the various flags.
> > 6. Continue with my existing plans.
> > 
> > Does this sound like a reasonable compromise?  Do my explanations make sense?
> > Did I misunderstand something fundamentally in your response?
> > 
> 
> So I looked some more at the patchset and there is something I did not
> mentally register earlier concerning avoidance of ->i_lock for ref
> acquire.
> 
> I don't know if it is motivated by a scalability problem on that lock or
> the idea that it will help conversion of the hash to xarray (it might, I
> have not analyzed the API).
> 
> There is a problem with the current patchset: with everything applied
> you get __iput() -> maybe_add_lru() -> ->drop_inode().
> 
> ... except the call happens with the spin lock held (like in the stock
> kenrel) but also ->i_count == 1, allowing lockless ref acquires.
> 
> While the layer can have API contract like that, this very much changes
> guarantees compared to the current state.
> 
> In the current kernel it is an invariant nobody is going to poke at the
> inode as long you hold ->i_lock -- the count is 0, thus you are the only
> remaining user and any potential new users are stalled waiting on the
> lock.
> 
> In the kernel as proposed this is no longer true -- anyone can bump the
> ref since it is not 0, afterwards they might end up modifying the inode
> in a way some of the ->drop_inode routines are not prepared for.
> 
> Or to put it differently, this automatically makes ->drop_inode
> callbacks harder to implement as there are races to worry about.
> 
> There is a bunch of dodgy filesystems with their custom drop routines,
> all possibly relying on the old semantics. All of which would have to be
> audited for correctness in face of the new scheme if this is to go in.
> 
> This is most likely not worth the effort. Also note in my proposals
> these semantics would remain unchanged.
> 
> I do know for a fact that the per-sb super block list lock, global hash
> lock and dentry + inode LRUs locks are a scalability problem.
> 
> I don't know anything about ->i_lock vs ref get/put also being one. I'm
> not saying this can't happen in some workloads, but from my quick poking
> around vast majoring of inodes reaching iput() have a ref of 1 or way
> higher than 1.
> 
> So even if ->i_lock does pose a scalability problem, it can be probably
> get largely alleviated on the stock kernel as follows: 1. provide some
> assertions nobody bumps 0->1 with I_FREEING et al set 2. allow for
> atomic igrab if refcount is at least 1. Note in this case ref of 1
> guarantees drop_inode is not in progress.
> 
> If the goal is to help xarray conversion, I have no basis to comment as
> I don't know that API. I did however note that for a fair comparison it
> would make sense to start with bitlocks for the hash. I can do that
> work, I did not because the LRU bottlenecks overtook the hash in my
> tests after my previous work in the area (some lock avoidance + not
> waiting on super block lock while holding the hash lock). fwiw I can do
> the bitlocks with the spin lock, as outlined in my previous e-mail.
> 
> Further, if going that way, it would probably make sense to sort out the
> sb thing and LRUs first anyway.
> 
> There is an old patchset which sorts out the hash thing + sb thing:
> https://lore.kernel.org/all/20231206060629.2827226-1-david@fromorbit.com/
> 
> Would need to some rebasing.
> 
> I disagree with how it handles the hash (I would do it with the inverted
> locking I described in my previous e-mail). The distributed linked list
> is also imo of too high granularity compared to what's really needed and
> not backed by core-local memory (I mean NUMA). However, if one is to
> evaluate a hash replacement, doing it on top of the patchset would be a
> good start (+ some LRU unfucking, even as simple as straight commenting
> it out just for testing purposes).
> 
> Maybe even get the dlist thing in as is regardless of hash vs whatever.
> I'm not going to argue much with anyone who does the work to bring that
> in, despite the remark above.
> 
> I had seen too many cases where one approach is implemented in a gimped
> manner, an inferior approach is implemented in a less gimped manner and
> is faster, leading people to conclude the latter is in fact the better
> choice. Now I have no idea how xarray is going to perform here, I am
> saying rolling with it vs a globally locked hash is unfair.
> 
> > I'm not married to my work, I want to find a solution we're all happy with. I'm
> > starting a new job this week so my ability to pay a lot of attention to this is
> > going to be slightly diminished, so I apologize if I missed something.  Thanks,
> > 
> 
> Well I'm not even working on Linux, so all my commentary is from the
> sidelines, which puts in me in a worse spot to participate.
> 
> The good news is that whatever happens is only my problem if I stick
> around. :-P

I don't know if I conveyed everything I wanted, so I'm going to state the
following:

The bigger the complaints about confusing code, the stronger the
argument for documenting understanding of what's going on with asserts
before any substantial changes are made. And serious rounds of testing
afterwards.

Even excluding the ->drop_inode business, I'm unable to tell if the
patchset provides the same semantics as the flag-based implementation
it replaces and it's hard to say what's up as the current assert
coverage is very limited. Given the other comments on this patchset I
don't think I'm the only one.

Realistically even the "premier" filesystems most likely violate the API
contract with VFS in some corner cases. The less used filesystems are
likely more egregious and would preferably be rm'd if at all possible
(I'm glancing at the qnx stuff).

Or to put it differently, this very well may expose latent bugs, except
it will not be known whether that's what happened or the bug is with the
patchset. A lot of potential for nasty debugging sessions which
hopefully can be avoided.

If it was my project, I would try to remedy it as follows:
1. add some state tracking maybe with one byte enums as I described in
my first e-mail (to recap say a state for just allocated, constructed,
being torned down and aborted). states would get updated as the inode
transitions from completely new through usable to deallocated.
2. add a mandatory func to call when the fs is claiming the inode
becomes fully operational or is getting aborted. the former case can
validate the inode fits the API contract (e.g., valid mode; i'm glaring
at ntfs here). it would also set the target state and validate it is
only called for inodes which are freshly allocated. I tried do to that
some time ago, d_instantiante is not it afair. this could also
pre-compute i_opflags instead of handling them at consumer callsite
(see do_inode_permission)
3. fix up rwsem asserts. currently they don't differentiate between
reader and writer locking
4. sprinkle asserts all over that the inode is in a valid state. for
example if the rwsem can only be legally taken if the inode is fully
constructed, assert it is fully constructed everytime it gets taken.
this can help catch botched inodes escaping the reservation (for example
suppose a filesystem has its own mechanism in place of the inode hash and that
mechanism has a bug allowing I_NEW inodes to escape -- it will get found
sooner and easier)
5. replace open-coded access to various fields with accessors (i posted
the ->i_state thing as an example). said accessors need variants
denoting what the caller provides vs what it expects, notably if the
field is readable without any locks held

and so on in the same vein, all gated by CONFIG_DEBUG_VFS, so no impact
on production kernels.

While doing so maybe tighten up some of the behavior (e.g., by whacking
I_WILL_FREE).

After it stops crashing with whatever can be thrown at it locally, maybe
ask people from other companies to give it a beating with their test
jigs.

At the end of it I would say I would have decent confidence that my
understanding of the semantics lines up with reality and that
filesystems adhere to it to a reasonable degree.

Only then I would consider replacing the current flags with a refcount
changes a viable approach (although I still don't think it buys anything
once the above work is done).

not my call though and I'm not volunteering for any of the above,
although I did a little bit (the ->i_state thing)

This is based on my adventures $elsewhere.

