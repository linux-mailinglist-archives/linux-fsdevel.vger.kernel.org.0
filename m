Return-Path: <linux-fsdevel+bounces-60668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C167B4FE3C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 15:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82940441DA8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 13:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C516834AB1F;
	Tue,  9 Sep 2025 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ0RVN5e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA452EB849;
	Tue,  9 Sep 2025 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425738; cv=none; b=XxDEp0yioYDLxbm3+ShQuPM9tk4GqSH6GJWD2XSbVCnGsLHYhMw+jd3zZ1tDlG3hawr9tryyLvenWRiPNsOtAq5cNOqv2ah1VA4qkSxCe/qxqcm/0qvmgcGK8R0iV19lynNGEzott5ouLeRLB6SX2m706XLYnM70XyXg5CSxxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425738; c=relaxed/simple;
	bh=LrwSQcHJ5zwyEDqOVBfPY5eWTJW8r8/t6z0j7e32T/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzYAWPJt9VYITLoR4tvyESfkSfdeu8gxPHLwYnimrLSViZ1eEVDrZkQEURFV76PiUuOdvTaA+JREUd9+Mg186lfdf3U8zRluMJjTOr75JU9f5ce+QYV68hxVnGycw3B2aFtFv5A3eOSoV2aXK1QlEbO9AYUBbEpZRTxv5pOz9WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ0RVN5e; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b9853e630so52354385e9.0;
        Tue, 09 Sep 2025 06:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757425734; x=1758030534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bhofjgq2pg/hk0vNn8yOm0N6bQgvcHXKUZY20lKVr9I=;
        b=bZ0RVN5eKq0TFgD168+NRbrLYlItIWSh6tu2LkwY6nQBE1h49OhO59lk82AoxzMJY0
         uJmuj+EIYw5ywjoNDIzQCB/lWIGjpputnjki/S24dNWI7cnVwzIy0Oo+4CWm6CqY+XLy
         FGBzcg9bDNbROx9PywflO9T2JHC2kAUDgUEY5SRBAP/SWgDz4aCf7755pWdert4uTlgB
         I8tjviWNwC/npng8qf3UyF4rHSEQz+6dyliMrordjMxxrjm9Q6DLpaUHeTdn48oOX4gO
         RK9EEaWimhrO2MEQxJe9NJ13lfckTzhGr49iGIRUJR/j3BEqyMA7cmowGadDrIFYtn2j
         I8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757425734; x=1758030534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bhofjgq2pg/hk0vNn8yOm0N6bQgvcHXKUZY20lKVr9I=;
        b=BzJmX/CbRssa5BayfHOxOk2CfY44enuTn5wTHUPNbrB1TJWwTkbBYFYNYmJfF6DLQs
         kvgM513q51KVx/FhxrMypXqFBuN59I2rGAlffrtc2ghkTzoCZtrhvLhZsNYJAM6hP7on
         5HwMHuUl9zZeQYAzhTfYc1rD5N6ilIMMA5dEUp1cg7xt121lwb4otCnShgrG7kv0PjNE
         CFbBv1YU7QFH0up35fWlVtcfIxQjQ7m0hssD9O+XyCUZqjf03LPdhN8ePyWQRSDFPw7G
         pvtgdk//gAHP6k6UBo1w3jhg5z3/IIVuJBtNE9ubC1lWwTlwmDOWZ+QyXQMbPbeXLyzJ
         2PWg==
X-Forwarded-Encrypted: i=1; AJvYcCUYIp9OZJVajoTCJmzIC2VvU7XM3tc6g6PDWgc1vUWsgXvfXqUA0I0xWEqfwX/bmHX9KBH2xRLt5DCsSA==@vger.kernel.org, AJvYcCW4tvd5oMmTznU60bJTa0gVcn0AYlKRBeRvTkwK2tywjW31ieZNo3iqO0Nn042KeiTeu1kwSTl0v56HEg==@vger.kernel.org, AJvYcCXpWvuG/M6l+Hz5IHXpJbjrGIkbqk1WaD08tES9Ddrj+buaxswWsNKRTkuUn6KsVGGf3KU+zAwX1RHI@vger.kernel.org
X-Gm-Message-State: AOJu0YyFcPrq/nyBT8shOMcC4sPxgePr1WTEVYau7WVtrRPf6D8q9ffH
	GxWBorRda3q+L/smIHPL1I+aVAR+DEsBFuhsHmz3Wz5RsxaTbOh9EkB4
X-Gm-Gg: ASbGncteigYVmghvCNtzUX0ApAY2tLJ1rPTluAxGtlVzhKAcPIHnDLLDt6rRfXYrJbc
	R2XMAflOvsRIFP6Sb/bZ6UNseOhlHE+pZlb3dfAkUGzlqFfZZpbxXV673ZFfwFctDUHUzI2/UsD
	9Fa8mkwaMhe+xSgjLB1ufT3kl0+jcwV4dwNrVCRNKnJYGQP/f1o4VdmyU1adQ70nGECFh0NfioO
	NxUdVY0N22IxXGGkhZUAs+J2jJMSbGbyNoU7amLHCqUQ3AAZRIm7uQ6Td70tOMPKXrMwK9M8Nld
	RlhE8kx6SW1gy6WiJfjUSc0yxjGqv1XFalgClqempzZiIDNOhWFIrjCiblYVMq1bdNlXSaFH809
	BfyVYpqy4XBtavQ96o7xbxJt2+sx9j4d0A33acg==
X-Google-Smtp-Source: AGHT+IF7mRfbickFsYTwMADQx4XAvz8ZPfeUqtzo+M3JPyVTyGXqKLtnhB+rcZg1p+yluEJGGSeq8w==
X-Received: by 2002:a05:600c:4e93:b0:45d:e0d8:a0aa with SMTP id 5b1f17b1804b1-45de0d8a342mr126859825e9.17.1757425733874;
        Tue, 09 Sep 2025 06:48:53 -0700 (PDT)
Received: from f (cst-prg-84-152.cust.vodafone.cz. [46.135.84.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e50e30asm492870045e9.24.2025.09.09.06.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:48:53 -0700 (PDT)
Date: Tue, 9 Sep 2025 15:48:43 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 00/54] fs: rework inode reference counting
Message-ID: <dpi5ey667awq63mgxrzu6qdfpeinrmeapgbllqidcdjayanz2p@kp3alvfskssp>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <eeu47pjcaxkfol2o2bltigfjvrz6eecdjwtilnmnprqh7dhdn7@rqi35ya5ilmv>
 <20250902211629.GA252154@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902211629.GA252154@fedora>

On Tue, Sep 02, 2025 at 05:16:29PM -0400, Josef Bacik wrote:

This conversation would be best had over a beer, but unfortunately it's
not an option. ;)

I trimmed the mail prior to the summary. There was some stuff in your
response where I don't think we have a mutual understanding who is
arguing for what and it also shows a little in the content below. I'm
going to try to address it.

I think there is a significant disconnect in one crucial detail which
I'm going to note later.
 
> Alright I see what you're suggesting. What I want is to have the refcounts be
> the ultimate arbiter of the state of the inode. We still need I_NEW and
> I_CREATING. I want to separate the dirty flags off to the side so we can use
> bitops for I_CREATING and I_NEW. From there we can do simple things about
> waiting where we need to, and eliminate i_lock for those accesses. That way
> inode lookup becomes xarray walk under RCU,
> refcount_inc_not_zero(&inode->i_count), if (unlikely(test_bit(I_NEW))) etc.
> 

I'm going to address this way below.

> This has all been long and I think I've got the gist of what you're suggesting.
> I'm going to restate it here so I'm sure we're on the same page.
> 
> 1. Don't do the i_obj_count thing.
> 2. Clean-up all the current weirdness by defining helpers that clearly define
> the flow of the inode lifetime.
> 3. Remove the flags that are no longer necessary.
> 4. Continue on with my other work to remove i_hash and the i_lru.
> 
> I don't disagree with this approach. I would however like to argue that changing
> the refcounting rules to be clear accomplishes a lot of the above goals, and
> gives us access to refcount_t which allows us to capture all sorts of bad
> behavior without needing to duplicate the effort.
> 

The ordering may be a little off here, consider text searching for
"primary disconnect" and reading that first if you don't like this
paragraph. :)

This is part of what I'm saying, but it skips the justification, which
imo puts a question mark on the i_obj_count idea.

One important bit is that the VFS layer should be able to have all its
funcs assert whether they are legally called for a given inode and if
the operation they are asked to do is also legal. What is legal depends
on where the inode is in its lifecycle (literally just handed out from
the allocator, fully constructed, or maybe in the process of being
aborted or maybe destroyed or maybe some other state).

The binary state of merely "usable or not usable" provided by typical
refcount schemes does not cut it and this remains true for your scheme
with i_obj_count.

So in the name of providing an environment where the programmer can
check wtf is happening and have the layer yell if at all possible, you
would need to provide *something* in parallel to the new count anyway.

I outlined one way to do it with enums each denoting a dedicated state.

Another way to do it is with flags, except not in the current
clusterfuck form.

I also argued with the *something* in place the i_obj_count becomes
spurious.

However, if your primary objection is that "->i_count == 0" is ambiguous
as to whether the inode happens to not have users or is being torned
down, I have a simple solution.

Suppose the current flags are here to say for the time being, even then
it is an invariant that ->i_count == 0 when I_FREEING is being set.
Then you can also kill the refcount by setting it to some magic value
indicating the obj is dead. As a result you still have your indicator in
->i_count.

> As an alternative approach, I could do the following.
> 
> 1. Pull the delayed iput work from btrfs into the core VFS.

I outlined in my previous e-mail how you can do the deferred
->evict_inode thing very easily with the help of the vfs layer and
without any refcount shenanigans or putting the burden on filesystems
which don't need/want it.

Search for "evict_deferred" to find it. It boils down to return an error
from the routine and having evict() schedule deferred work.
Alternatively it can be expected the filesystem already did that and
then there is a magic entry point (e.g., evict_deferred_finish()) to
call after the fs is finally done.

That proposal can be further twaked to pass an argument denoting who is
calling. For example if you are already operating from task_work (due to
deferred fput) OR fput_close_sync then maybe even btrfs can have its
evict_inode() do the work in place?

I would really like to NOT see iput() defaulting to deferred work for
everyone if it can be avoided, but maybe I misunderstood the problem you
are facing there.

> 2. In all the places where we have dubious lifetime stuff (aka where I use
> i_obj_count), replace it with more i_count usage, and rely on the delayed iput
> infrastructure to save us here.
> 3. Change the rules so we never have 0 refcount objects.
> 4. Convert to refcount_t.

So I think these points showcase the primary disconnect between your
position and mine.

AFAICS your general stance is that the current state of lifecycle is...
lacking in quality/clarity (no argument here). At the same time
refcounts are a well-known mechanism and the specific refcount API in
the Linux kernel has extra stopgaps. With this in mind you want to lean
into it, dropping as much hand-rolled code as possible, with the
assumption this is going to reduce bugs and provide some bug-proofing
for the future.

My stance includes few points, but the crux is I claim the proposed
refcount approach is in fact harder to reason about and harder to
implement in the current kernel (not to be confused with an
implementation from scratch). All elaborated on below.

First and foremost, even if i_obj_count is to land, the pragmatic
approach is to bring the current to state to basic sanity in small
incremental bisectable steps (on top of providing way better assertion
coverage). That would mean making things sensible with the flags first
and only then switch to the new refcount scheme. Part of the problem is
that in the VFS layer you are getting screwed over by bad filesystems
(which the layer currently provides little self-defence against) and bad
consumers at the same time, while the layer only provides ad-hoc asserts.

With the patchset as proposed you are making a significant jump in few
steps leaving a big window for subtle bugs which can take forever to
figure out. Personally I would not feel safe merging the patchset for
this reason alone.

Next up, reported woes are not inherent to the currently taken approach
(including ->i_count == 0 meaning it's still all fine and this not being
an ambiguous condition or synchronisation vs writeback) and the general
things the layer is doing at the moment can be expressed in a clean &
debuggable & assertion-friendly manner without any extra refcounts.

As a small illustration and a step towards that goal I posted a patchset
sorting out ->i_state handling and the I_WILL_FREE flag:
https://lore.kernel.org/linux-fsdevel/20250909091344.1299099-1-mjguzik@gmail.com/T/#t

Something of that sort should land even if your patchset makes it way
into mainline.

I also claim a clear-cut flow which denotes the inode as being
in-teardown *and* providing a way for certain mechanisms to stop messing
with it *while* it is still fully operational are important longterm.

The famed writeback is part of it.

I claim a clear-cut API which synchronizes grabbing the inode or
buggering off vs waiting race-free is not hard to implement, it just was
not done.

More importantly, I claim the current writeback code may be actively
depending on various parts of the inode not being torned down while it
is operating. With your proposal of only guarding the actual freeing of
the backing struct, an extensive review would be needed to make sure
this is not happening.

> 5. Remove the various flags.
> 6. Continue with my existing plans.
> 
> Does this sound like a reasonable compromise?  Do my explanations make sense?
> Did I misunderstand something fundamentally in your response?
> 

So I looked some more at the patchset and there is something I did not
mentally register earlier concerning avoidance of ->i_lock for ref
acquire.

I don't know if it is motivated by a scalability problem on that lock or
the idea that it will help conversion of the hash to xarray (it might, I
have not analyzed the API).

There is a problem with the current patchset: with everything applied
you get __iput() -> maybe_add_lru() -> ->drop_inode().

... except the call happens with the spin lock held (like in the stock
kenrel) but also ->i_count == 1, allowing lockless ref acquires.

While the layer can have API contract like that, this very much changes
guarantees compared to the current state.

In the current kernel it is an invariant nobody is going to poke at the
inode as long you hold ->i_lock -- the count is 0, thus you are the only
remaining user and any potential new users are stalled waiting on the
lock.

In the kernel as proposed this is no longer true -- anyone can bump the
ref since it is not 0, afterwards they might end up modifying the inode
in a way some of the ->drop_inode routines are not prepared for.

Or to put it differently, this automatically makes ->drop_inode
callbacks harder to implement as there are races to worry about.

There is a bunch of dodgy filesystems with their custom drop routines,
all possibly relying on the old semantics. All of which would have to be
audited for correctness in face of the new scheme if this is to go in.

This is most likely not worth the effort. Also note in my proposals
these semantics would remain unchanged.

I do know for a fact that the per-sb super block list lock, global hash
lock and dentry + inode LRUs locks are a scalability problem.

I don't know anything about ->i_lock vs ref get/put also being one. I'm
not saying this can't happen in some workloads, but from my quick poking
around vast majoring of inodes reaching iput() have a ref of 1 or way
higher than 1.

So even if ->i_lock does pose a scalability problem, it can be probably
get largely alleviated on the stock kernel as follows: 1. provide some
assertions nobody bumps 0->1 with I_FREEING et al set 2. allow for
atomic igrab if refcount is at least 1. Note in this case ref of 1
guarantees drop_inode is not in progress.

If the goal is to help xarray conversion, I have no basis to comment as
I don't know that API. I did however note that for a fair comparison it
would make sense to start with bitlocks for the hash. I can do that
work, I did not because the LRU bottlenecks overtook the hash in my
tests after my previous work in the area (some lock avoidance + not
waiting on super block lock while holding the hash lock). fwiw I can do
the bitlocks with the spin lock, as outlined in my previous e-mail.

Further, if going that way, it would probably make sense to sort out the
sb thing and LRUs first anyway.

There is an old patchset which sorts out the hash thing + sb thing:
https://lore.kernel.org/all/20231206060629.2827226-1-david@fromorbit.com/

Would need to some rebasing.

I disagree with how it handles the hash (I would do it with the inverted
locking I described in my previous e-mail). The distributed linked list
is also imo of too high granularity compared to what's really needed and
not backed by core-local memory (I mean NUMA). However, if one is to
evaluate a hash replacement, doing it on top of the patchset would be a
good start (+ some LRU unfucking, even as simple as straight commenting
it out just for testing purposes).

Maybe even get the dlist thing in as is regardless of hash vs whatever.
I'm not going to argue much with anyone who does the work to bring that
in, despite the remark above.

I had seen too many cases where one approach is implemented in a gimped
manner, an inferior approach is implemented in a less gimped manner and
is faster, leading people to conclude the latter is in fact the better
choice. Now I have no idea how xarray is going to perform here, I am
saying rolling with it vs a globally locked hash is unfair.

> I'm not married to my work, I want to find a solution we're all happy with. I'm
> starting a new job this week so my ability to pay a lot of attention to this is
> going to be slightly diminished, so I apologize if I missed something.  Thanks,
> 

Well I'm not even working on Linux, so all my commentary is from the
sidelines, which puts in me in a worse spot to participate.

The good news is that whatever happens is only my problem if I stick
around. :-P

