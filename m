Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA6377562A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 11:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjHIJLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 05:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjHIJLw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:11:52 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF981FCE;
        Wed,  9 Aug 2023 02:11:51 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56c711a88e8so4462981eaf.2;
        Wed, 09 Aug 2023 02:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691572311; x=1692177111;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=95b0g0kQ/kMh+tBO2T92o5rrBTjwtyERuJc6qJBCnQM=;
        b=ahA3fta79K1lED+E4D8vrc/b9MyPv4KQmnxXjKknfBtas1D1OXW48Tca+A8ieiXNDY
         usNfiF8+74jrvXXO6puw7VPlmAV4AuSi8EoYlJxQHTiKeZ18qQ7BqH9bfGggBs0yTTXo
         sFS05h9iPOHgYyvMCmTbEWzh3zMZ0SAiEEOZEAYBp+8vca/6hn7pgsulRvdMRUb50zUw
         0/Zp23g7vY2Cj9vzakF6/BnXEdiuyjdEFQ1T+PpXpyjiXaR1t3Zz5feZdQyh+uOikd/5
         ar7JaCmZFAJXrTfjOYi9U2jtVnruGJNi4X1gF16Pbp8aSCTEKxEUXvdQdRRUplkhLMeG
         EwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691572311; x=1692177111;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95b0g0kQ/kMh+tBO2T92o5rrBTjwtyERuJc6qJBCnQM=;
        b=ZepB7MfSBPMA9L8O0xbSvcxto+B5mKIiaqd/RcP+VhLXvXf3dhVey7LL/lunE0LkAl
         oWYNBloyGlSog1PPDE+4UYHf9brISiHzBlw9NLY9kZ/ua5W+Weh4yCRUVbn6DGQfddWy
         kNAtfFPiUW0996ItX5/XPLy9zOu5OWjjL8++L+NRhcT5P9y+w8VgCXlidEaprlt2/K2Z
         3z/BMlC0OyOq3fb1Kw8HdavH5gTv9bhMdo1J8wobDrQqXnzHz5Gh+ml3A8pEt2p3WErj
         pVIIGPkx1haDn8lp46BXNNKw0wpEV19f7GWrPGjAPRuk03OfzlGAwbJEI3hEdEuVUHz8
         SwBQ==
X-Gm-Message-State: AOJu0YxOIapSAMJRqTry1LX7to67OC4qtQucjJG+W9DbdkHcHnDyC0b4
        gy+fwltLcGjwVOhsOj+HifWMHuKht5PpkfneHc7KKbkSwx4=
X-Google-Smtp-Source: AGHT+IHaBM7G8aIFg9fxaN5s/odXkiFXeWtEKvsK8sSmSQBrTTLYQ2tVfdnmTGD6rvljhCm0D6LxG+UwuSOx72KG9Fs=
X-Received: by 2002:a4a:270e:0:b0:56c:c38a:c9cb with SMTP id
 l14-20020a4a270e000000b0056cc38ac9cbmr2225969oof.4.1691572310608; Wed, 09 Aug
 2023 02:11:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:129a:0:b0:4f0:1250:dd51 with HTTP; Wed, 9 Aug 2023
 02:11:50 -0700 (PDT)
In-Reply-To: <ZNL6MRbWWnleybR3@dread.disaster.area>
References: <CAGudoHF_Y0shcU+AMRRdN5RQgs9L_HHvBH8D4K=7_0X72kYy2g@mail.gmail.com>
 <ZNLMpgrCOQXFQnDk@dread.disaster.area> <CAGudoHG0Rp2Ku1mRRQnksDZFemUBzfhwyK3LJidEFgvmUfsfsQ@mail.gmail.com>
 <ZNL6MRbWWnleybR3@dread.disaster.area>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed, 9 Aug 2023 11:11:50 +0200
Message-ID: <CAGudoHHyZn6Gsd8MDwFkxBKdAyhSztmEJXz=9zse2EoM0CNPrQ@mail.gmail.com>
Subject: Re: new_inode_pseudo vs locked inode->i_state = 0
To:     Dave Chinner <david@fromorbit.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/9/23, Dave Chinner <david@fromorbit.com> wrote:
> On Wed, Aug 09, 2023 at 02:23:59AM +0200, Mateusz Guzik wrote:
>> On 8/9/23, Dave Chinner <david@fromorbit.com> wrote:
>> > On Tue, Aug 08, 2023 at 06:05:33PM +0200, Mateusz Guzik wrote:
>> >> Hello,
>> >>
>> >> new_inode_pseudo is:
>> >>         struct inode *inode = alloc_inode(sb);
>> >>
>> >> 	if (inode) {
>> >> 		spin_lock(&inode->i_lock);
>> >> 		inode->i_state = 0;
>> >> 		spin_unlock(&inode->i_lock);
>> >> 	}
>> >>
>> >> I'm trying to understand:
>> >> 1. why is it zeroing i_state (as opposed to have it happen in
>> >> inode_init_always)
>> >> 2. why is zeroing taking place with i_lock held
>> >>
>> >> The inode is freshly allocated, not yet added to the hash -- I would
>> >> expect that nobody else can see it.
>> >
>> > Maybe not at this point, but as soon as the function returns with
>> > the new inode, it could be published in some list that can be
>> > accessed concurrently and then the i_state visible on other CPUs
>> > better be correct.
>> >
>> > I'll come back to this, because the answer lies in this code:
>> >
>> >> Moreover, another consumer of alloc_inode zeroes without bothering to
>> >> lock -- see iget5_locked:
>> >> [snip]
>> >> 	struct inode *new = alloc_inode(sb);
>> >>
>> >> 		if (new) {
>> >> 			new->i_state = 0;
>> >> [/snip]
>> >
>> > Yes, that one is fine because the inode has not been published yet.
>> > The actual i_state serialisation needed to publish the inode happens
>> > in the function called in the very next line - inode_insert5().
>> >
>> > That does:
>> >
>> > 	spin_lock(&inode_hash_lock);
>> >
>> > 	.....
>> >         /*
>> >          * Return the locked inode with I_NEW set, the
>> >          * caller is responsible for filling in the contents
>> >          */
>> >         spin_lock(&inode->i_lock);
>> >         inode->i_state |= I_NEW;
>> >         hlist_add_head_rcu(&inode->i_hash, head);
>> >         spin_unlock(&inode->i_lock);
>> > 	.....
>> >
>> > 	spin_unlock(&inode_hash_lock);
>> >
>> > The i_lock is held across the inode state initialisation and hash
>> > list insert so that if anything finds the inode in the hash
>> > immediately after insert, they should set an initialised value.
>> >
>> > Don't be fooled by the inode_hash_lock here. We have
>> > find_inode_rcu() which walks hash lists without holding the hash
>> > lock, hence if anything needs to do a state check on the found
>> > inode, they are guaranteed to see I_NEW after grabbing the i_lock....
>> >
>> > Further, inode_insert5() adds the inode to the superblock inode
>> > list, which means concurrent sb inode list walkers can also see this
>> > inode whilst the inode_hash_lock is still held by inode_insert5().
>> > Those inode list walkers *must* see I_NEW at this point, and they
>> > are guaranteed to do so by taking i_lock before checking i_state....
>> >
>> > IOWs, the initialisation of inode->i_state for normal inodes must be
>> > done under i_lock so that lookups that occur after hash/sb list
>> > insert are guaranteed to see the correct value.
>> >
>> > If we now go back to new_inode_pseudo(), we see one of the callers
>> > is new_inode(), and it does this:
>> >
>> > struct inode *new_inode(struct super_block *sb)
>> > {
>> >         struct inode *inode;
>> >
>> >         spin_lock_prefetch(&sb->s_inode_list_lock);
>> >
>> >         inode = new_inode_pseudo(sb);
>> >         if (inode)
>> >                 inode_sb_list_add(inode);
>> >         return inode;
>> > }
>> >
>> > IOWs, the inode is immediately published on the superblock inode
>> > list, and so inode list walkers can see it immediately. As per
>> > inode_insert5(), this requires the inode state to be fully
>> > initialised and memory barriers in place such that any walker will
>> > see the correct value of i_state. The simplest, safest way to do
>> > this is to initialise i_state under the i_lock....
>> >
>>
>> Thanks for the detailed answer, I do think you have a valid point but
>> I don't think it works with the given example. ;)
>>
>> inode_sb_list_add is:
>>         spin_lock(&inode->i_sb->s_inode_list_lock);
>>         list_add(&inode->i_sb_list, &inode->i_sb->s_inodes);
>>         spin_unlock(&inode->i_sb->s_inode_list_lock);
>>
>> ... thus i_state is published by the time it unlocks.
>>
>> According to my grep all iterations over the list hold the
>> s_inode_list_lock, thus they are guaranteed to see the update, making
>> the release fence in new_inode_pseudo redundant for this case.
>
> I don't believe that is the case - the i_state modification is not
> within the critical region the s_inode_list_lock covers, nor is the
> cacheline i_state lies on referenced within the critical section.
> Hence there is no explicit ordering dependency created by
> inode_sb_list_add on the value of i_state.
>
> Your argument seems to be that we can rely on the side effect of
> some unrelated lock to provide ordered memory access - that's just
> really poor locking design and will result in unmaintainable code
> that gets broken without realising in the future.
>

In that spirit, *normally* when you add an object to some
list/whatever, there are probably other changes you made past i_state
= 0 (i.e. another fence is ultimately needed just before insertion).

Least error prone approach as far as I'm concerned would make sure the
inserting routine issues relevant fences -- that way consumers which
sneak in some updates prior to calling it are still covered just fine
and so happens the sb list iteration *is* covered in this manner. But
I guess that's not the expected way here.

I feel compelled to note that not issuing the fence in iget5_locked
and instead relying on hash insertion to sort it out is implementing
this approach, albeit internally it is explicitly done with i_lock.

> That's why the spin lock. It's *obviously correct*, and it doesn't
> require any of the other code that checks i_state to have to care
> about any lock or memory barrier mechanism other than taking
> i_lock...
>

It is obvious not *wrong* to do in sense of not breaking code, just
deeply confusing for the reader -- I don't know about you, if I see a
lock taken and released for what should be an object invisible to
other threads, immediately the question pops up if the inode *is* in
fact visible somewhere. Making sure i_state update is published by
starting with acquiring the lock on freshly allocated inode is not
something I thought of.

>> With this in mind I'm assuming the fence was there as a safety
>> measure, for consumers which would maybe need it.
>>
>> Then the code can:
>>         struct inode *inode = alloc_inode(sb);
>>
>>         if (inode) {
>>                 inode->i_state = 0;
>>                 /* make sure i_state update will be visible before we
>> insert
>>                  * the inode anywhere */
>>                 smp_wmb();
>>         }
>
> AFAIA, that doesn't work by itself without a matching smp_rmb()
> prior to the i_state reader - memory barriers need to be paired for
> ordering to be valid. Hence this also seems to assume that we can
> rely on some other unrelated lock pairing to actually order memory
> accesses to i_state....
>

It has to be either smp_rmb or a consume barrier.

Spelling it out instead of having it implicitly done through
spin_unlock points out that it is redundant for the new_inode vs sb
allocation case, people just don't have strong reaction to plain
lock/unlock trips, whereas they get very worried about any explicitly
mentioned barriers (most justified for the latter, but they also
should be this way for the former).

>> Upshots:
>> - replaces 2 atomics with a mere release fence, which is way cheaper
>> to do everywhere and virtually free on x86-64
>> - people reading the code don't wonder who on earth are we locking
>> against
>
> Downsides:
> - memory barriers are hard to get right,
> - nobody will be able to look at the code and say "this is obviously
>   correct".
> - random unpaired memory barriers in code end up making it
>   unmaintainable.
> - impossible to test for correctness
>
[snip]
>> I am however going to /strongly suggest/ that a comment explaining
>> what's going on is added there, if the current state is to remain.
>
> If you really think that improves the code, send a patch....
>
>> As far as I'm concerned *locking* when a mere smp_wmb would sufficne
>> is heavily misleading and should be whacked if only for that reason.
>
> If it ain't broke, don't fix it.
>
> The code we have now is widely used (there are over a hundred
> callers of new_inode()) and we know it works correctly. Nobody is
> complaining that it is too slow, and generally speaking the overhead
> of this lock traversal is lost in the noise of all the other
> operations needed to be performed to initialise a new inode.
>

Maybe you have been around this code too long to see an outsider
perspective or maybe I did not do a good job spelling it out.

I'm not complaining about speed, I'm complaining that a standalone
lock trip there is *confusing*, especially when another consumer in
the same file does not do it and filesystems have *custom* allocation
routines -- is the inode visible to other threads?

I also noted the reasoning you initially gave is trivially satisified
with smp_wmb, but I'm definitely not going to push for it.

However, after more poking around, what I think what you were trying
to say is that whatever inode lookups/traversal always take the inode
lock to inspect i_state, thus zeroing enclosed by it makes it easier
to reason about it (but if that's the case why is iget5_locked
standing out and you seem fine with it?). Now that I justification I
can understand at least.

All that said, how about this (modulo wording):
diff --git a/fs/inode.c b/fs/inode.c
index 8fefb69e1f84..977e72942706 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1018,6 +1018,13 @@ struct inode *new_inode_pseudo(struct super_block *sb)
        struct inode *inode = alloc_inode(sb);

        if (inode) {
+               /*
+                * Make sure i_state update is visible before this inode gets
+                * inserted anywhere.
+                *
+                * Safe way for consumers to inspect the field is with i_lock
+                * held, match this for simplicity.
+                */
                spin_lock(&inode->i_lock);
                inode->i_state = 0;
                spin_unlock(&inode->i_lock);
@@ -1285,6 +1292,11 @@ struct inode *iget5_locked(struct super_block
*sb, unsigned long hashval,
                struct inode *new = alloc_inode(sb);

                if (new) {
+                       /*
+                        * new_inode_pseudo takes a lock to zero i_state, here
+                        * we safely skip it because hash insertion will take
+                        * care of it
+                        */
                        new->i_state = 0;
                        inode = inode_insert5(new, hashval, test, set, data);
                        if (unlikely(inode != new))


or patch iget5_locked to use new_inode_pseudo, but then I don't want
to be on a lookout for someone's microbench changing

-- 
Mateusz Guzik <mjguzik gmail.com>
