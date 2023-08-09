Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C75E7750E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 04:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjHICaQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 22:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjHICaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:30:15 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F331BD4
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 19:30:14 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686e29b058cso4546584b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 19:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1691548213; x=1692153013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gyfp6/2lE4hfVWKzgHrPf1nFIaC64TP1oDST4S2dfl0=;
        b=ulu95Y2+kgQdpeV+25AK9IH5fI08CD9OWmtSI1iM0Vmmmi1Ej1NzFcK6CWGv7vpOfj
         wn4WC2vIY26y0HvqrRvdU09jilWgdMYuYEUGNs3fUT/GEbyQtILHEyBY79U/PLrrX9TP
         SNSbPDs8T/OGQyTjBDzP3BXlufrepaN2Dfe6nKEWKnIRuz9Kf5FDlVEI47FTNW5QBLqO
         EzdtV38eCuzNjw4zUHMNdI9qwo12Lze3hvCGAoxeRSMz8RBhW81I3OfQrAGuHS/tNKMl
         ZlQxl1T/JiqAxZGHJj2g0g2PygPwLsMbs+33UrOwRjvsWkplQp/TSzDkAy+ks1W2DGPW
         EqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691548213; x=1692153013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyfp6/2lE4hfVWKzgHrPf1nFIaC64TP1oDST4S2dfl0=;
        b=I710bLU9hHDKldmd50VpTutegSlnoPUy0nbS3gWdUhZnyNqJBBVOwOcH+xgNC5pWdh
         NwWLLDthKEzyfY5ThGQJO811K+tLt7quMnfK3J58ksUHvdSFlf964CPSSXtzCPzo2Z9u
         cwtaNrQu69wyt0jzZOlcIOYNnDphFYaX6iGc6xceOY1mJLp0gBA/1NUhhOguA9c6/W9p
         Y/YHy1gJGlkAFwlecvDVm3yVAup5RGsd7/gMxHlLSF4PIO9yHgz/vUrCRiApCaNm3gT0
         OiALKw/SZxMC1H7HSLnP+a0jEnoDgVwO0KgRtf4+lY8kU86l2ygvJMPbLHGXBf7x3PCn
         KR1Q==
X-Gm-Message-State: AOJu0YyQGzJaUhynPQ1k2jZohC29Zx5OFUOm+uDtyYchGaTWYi9wPIOq
        QN65T73nc2L2X0YwuBuu1WNK5hJK3E+27SC2yqg=
X-Google-Smtp-Source: AGHT+IF3qoTVzAV4hz1Zju6dhOcSE4C1HkfgjegEFW/dolPYh7fLcdkK5H0OrCk9kkL8SLj/utT21A==
X-Received: by 2002:a05:6a20:ce9f:b0:140:48d4:8199 with SMTP id if31-20020a056a20ce9f00b0014048d48199mr1189133pzb.24.1691548213400;
        Tue, 08 Aug 2023 19:30:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-166-213.pa.nsw.optusnet.com.au. [49.180.166.213])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902b60400b001a95f632340sm9721034pls.46.2023.08.08.19.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 19:30:12 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qTYxd-002xzB-38;
        Wed, 09 Aug 2023 12:30:09 +1000
Date:   Wed, 9 Aug 2023 12:30:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: new_inode_pseudo vs locked inode->i_state = 0
Message-ID: <ZNL6MRbWWnleybR3@dread.disaster.area>
References: <CAGudoHF_Y0shcU+AMRRdN5RQgs9L_HHvBH8D4K=7_0X72kYy2g@mail.gmail.com>
 <ZNLMpgrCOQXFQnDk@dread.disaster.area>
 <CAGudoHG0Rp2Ku1mRRQnksDZFemUBzfhwyK3LJidEFgvmUfsfsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHG0Rp2Ku1mRRQnksDZFemUBzfhwyK3LJidEFgvmUfsfsQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 09, 2023 at 02:23:59AM +0200, Mateusz Guzik wrote:
> On 8/9/23, Dave Chinner <david@fromorbit.com> wrote:
> > On Tue, Aug 08, 2023 at 06:05:33PM +0200, Mateusz Guzik wrote:
> >> Hello,
> >>
> >> new_inode_pseudo is:
> >>         struct inode *inode = alloc_inode(sb);
> >>
> >> 	if (inode) {
> >> 		spin_lock(&inode->i_lock);
> >> 		inode->i_state = 0;
> >> 		spin_unlock(&inode->i_lock);
> >> 	}
> >>
> >> I'm trying to understand:
> >> 1. why is it zeroing i_state (as opposed to have it happen in
> >> inode_init_always)
> >> 2. why is zeroing taking place with i_lock held
> >>
> >> The inode is freshly allocated, not yet added to the hash -- I would
> >> expect that nobody else can see it.
> >
> > Maybe not at this point, but as soon as the function returns with
> > the new inode, it could be published in some list that can be
> > accessed concurrently and then the i_state visible on other CPUs
> > better be correct.
> >
> > I'll come back to this, because the answer lies in this code:
> >
> >> Moreover, another consumer of alloc_inode zeroes without bothering to
> >> lock -- see iget5_locked:
> >> [snip]
> >> 	struct inode *new = alloc_inode(sb);
> >>
> >> 		if (new) {
> >> 			new->i_state = 0;
> >> [/snip]
> >
> > Yes, that one is fine because the inode has not been published yet.
> > The actual i_state serialisation needed to publish the inode happens
> > in the function called in the very next line - inode_insert5().
> >
> > That does:
> >
> > 	spin_lock(&inode_hash_lock);
> >
> > 	.....
> >         /*
> >          * Return the locked inode with I_NEW set, the
> >          * caller is responsible for filling in the contents
> >          */
> >         spin_lock(&inode->i_lock);
> >         inode->i_state |= I_NEW;
> >         hlist_add_head_rcu(&inode->i_hash, head);
> >         spin_unlock(&inode->i_lock);
> > 	.....
> >
> > 	spin_unlock(&inode_hash_lock);
> >
> > The i_lock is held across the inode state initialisation and hash
> > list insert so that if anything finds the inode in the hash
> > immediately after insert, they should set an initialised value.
> >
> > Don't be fooled by the inode_hash_lock here. We have
> > find_inode_rcu() which walks hash lists without holding the hash
> > lock, hence if anything needs to do a state check on the found
> > inode, they are guaranteed to see I_NEW after grabbing the i_lock....
> >
> > Further, inode_insert5() adds the inode to the superblock inode
> > list, which means concurrent sb inode list walkers can also see this
> > inode whilst the inode_hash_lock is still held by inode_insert5().
> > Those inode list walkers *must* see I_NEW at this point, and they
> > are guaranteed to do so by taking i_lock before checking i_state....
> >
> > IOWs, the initialisation of inode->i_state for normal inodes must be
> > done under i_lock so that lookups that occur after hash/sb list
> > insert are guaranteed to see the correct value.
> >
> > If we now go back to new_inode_pseudo(), we see one of the callers
> > is new_inode(), and it does this:
> >
> > struct inode *new_inode(struct super_block *sb)
> > {
> >         struct inode *inode;
> >
> >         spin_lock_prefetch(&sb->s_inode_list_lock);
> >
> >         inode = new_inode_pseudo(sb);
> >         if (inode)
> >                 inode_sb_list_add(inode);
> >         return inode;
> > }
> >
> > IOWs, the inode is immediately published on the superblock inode
> > list, and so inode list walkers can see it immediately. As per
> > inode_insert5(), this requires the inode state to be fully
> > initialised and memory barriers in place such that any walker will
> > see the correct value of i_state. The simplest, safest way to do
> > this is to initialise i_state under the i_lock....
> >
> 
> Thanks for the detailed answer, I do think you have a valid point but
> I don't think it works with the given example. ;)
> 
> inode_sb_list_add is:
>         spin_lock(&inode->i_sb->s_inode_list_lock);
>         list_add(&inode->i_sb_list, &inode->i_sb->s_inodes);
>         spin_unlock(&inode->i_sb->s_inode_list_lock);
> 
> ... thus i_state is published by the time it unlocks.
> 
> According to my grep all iterations over the list hold the
> s_inode_list_lock, thus they are guaranteed to see the update, making
> the release fence in new_inode_pseudo redundant for this case.

I don't believe that is the case - the i_state modification is not
within the critical region the s_inode_list_lock covers, nor is the
cacheline i_state lies on referenced within the critical section.
Hence there is no explicit ordering dependency created by
inode_sb_list_add on the value of i_state.

Your argument seems to be that we can rely on the side effect of
some unrelated lock to provide ordered memory access - that's just
really poor locking design and will result in unmaintainable code
that gets broken without realising in the future.

That's why the spin lock. It's *obviously correct*, and it doesn't
require any of the other code that checks i_state to have to care
about any lock or memory barrier mechanism other than taking
i_lock...

> With this in mind I'm assuming the fence was there as a safety
> measure, for consumers which would maybe need it.
> 
> Then the code can:
>         struct inode *inode = alloc_inode(sb);
> 
>         if (inode) {
>                 inode->i_state = 0;
>                 /* make sure i_state update will be visible before we insert
>                  * the inode anywhere */
>                 smp_wmb();
>         }

AFAIA, that doesn't work by itself without a matching smp_rmb()
prior to the i_state reader - memory barriers need to be paired for
ordering to be valid. Hence this also seems to assume that we can
rely on some other unrelated lock pairing to actually order memory
accesses to i_state....

> Upshots:
> - replaces 2 atomics with a mere release fence, which is way cheaper
> to do everywhere and virtually free on x86-64
> - people reading the code don't wonder who on earth are we locking against

Downsides:
- memory barriers are hard to get right,
- nobody will be able to look at the code and say "this is obviously
  correct".
- random unpaired memory barriers in code end up making it
  unmaintainable.
- impossible to test for correctness

> All that said, if the (possibly redundant) fence is literally the only
> reason for the lock trip, I would once more propose zeroing in
> inode_init_always:
> diff --git a/fs/inode.c b/fs/inode.c
> index 8fefb69e1f84..ce9664c4efe9 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -232,6 +232,13 @@ int inode_init_always(struct super_block *sb,
> struct inode *inode)
>                 return -ENOMEM;
>         this_cpu_inc(nr_inodes);
> 
> +       inode->i_state = 0;
> +       /*
> +        * Make sure i_state update is visible before this inode gets inserted
> +        * anywhere.
> +        */
> +       smp_wmb();

We've had code calling inode_init_always() for a long time that
requires i_state to remain untouched until the caller is ready to
change it. This would break that code....

> Now, I'm not going to flame with anyone over doing smp_wmb instead of
> the lock trip (looks like a no-brainer to me, but I got flamed for
> another one earlier today ;>).

Yes, I read that thread, and nobody was flaming anyone. People just
asked hard questions about why we need to change code that has been
working largely untouched for a decade.

> I am however going to /strongly suggest/ that a comment explaining
> what's going on is added there, if the current state is to remain.

If you really think that improves the code, send a patch....

> As far as I'm concerned *locking* when a mere smp_wmb would sufficne
> is heavily misleading and should be whacked if only for that reason.

If it ain't broke, don't fix it.

The code we have now is widely used (there are over a hundred
callers of new_inode()) and we know it works correctly. Nobody is
complaining that it is too slow, and generally speaking the overhead
of this lock traversal is lost in the noise of all the other
operations needed to be performed to initialise a new inode.

If there's a compelling reason to change the code (e.g. benchmark
improvements), then spend the time to do the audit to determine the
change is safe and test all the filesystems the change affects to
validate there are no regressions...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
