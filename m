Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3BC774F32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 01:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjHHXQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 19:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjHHXQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:16:35 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2510C1BC1
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 16:16:24 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc1c1c68e2so40087675ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 16:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1691536554; x=1692141354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WOuOSlruUZcGR8zFMJNehfc4BcoLJdH6P9wW18YDQ0g=;
        b=ubMftYeNe5in/UHpQBFw8Qhxv6cS1+gdKFl1v3U6IM5NiY+6njAUDmxSzBWSvrgKL5
         j7u7tGz3YiAxPJ4VgCbKWhDMs+g7vrukoy01kw751e+cbn5cCD5mzZJN9QA6n5t5zQol
         mWmaGLr2yLt+3YKRipdH4RokDXrG7nIkikXWLd2c6bcBNnEExkk2EKC9cJRX0aXVqyCD
         X/qCa80cGiPHro7DopY0qkQjcL5J2sNLcbzsXjAFVj9Dld81/nlUi3eAWeRsPDPrPqJp
         4C4dd7SCkmSw1I1dlJUwglsZ9vX6pq7hwFiVH+8QgIzofHI2KHdxhlwdqX9sjqDmb1MZ
         +pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691536554; x=1692141354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOuOSlruUZcGR8zFMJNehfc4BcoLJdH6P9wW18YDQ0g=;
        b=IG5F9AWi2N5QUH7sfWatdIQSVjB3S/13jL2Z50qr+wfGKoSv2ER48NOGcO2WOYvTy5
         11Qxw8f9bNiAzAdptwWqMcaoWPbvIYAQpEvUpihqrvbRvLhHR8uvwJ68ogcDy5glif4J
         STSz/s5222FPR2Mnkq6oxi2jJYF/FZqTtQrw21oAAPUBi63Ku/D/kshaPswrYiktxGgk
         UkPPk3ucHzIUAT+prGNL9wlCQz8xH7BzjFMskEOp3sJqxmyEhP4w2UYJGWDsQiDiDVwb
         O3ui0eOMuMUSAP2liU7rwrj3PYthrrhf5YUu1MwSEufJNQTe3cu9LHNky+qyeA2BvTMZ
         kGVg==
X-Gm-Message-State: AOJu0YydOukIdNEll0GTTmzP1MIj9OO9HbQWkVakv29HlYFFBl7+t1VT
        qYLwjW2dcHDiEflk9lgw/CtAXw==
X-Google-Smtp-Source: AGHT+IHlCU0XJSLNj4wzvYDj/xmkWLj/tctgRQYV2ZXWs5Bs5ZjCChkp6v9ThAHcyfTeuNtd1DLt8w==
X-Received: by 2002:a17:902:d486:b0:1b9:c68f:91a5 with SMTP id c6-20020a170902d48600b001b9c68f91a5mr1164296plg.6.1691536554027;
        Tue, 08 Aug 2023 16:15:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-166-213.pa.nsw.optusnet.com.au. [49.180.166.213])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b001b8062c1db3sm9555273plf.82.2023.08.08.16.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 16:15:53 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qTVva-002uHX-27;
        Wed, 09 Aug 2023 09:15:50 +1000
Date:   Wed, 9 Aug 2023 09:15:50 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: new_inode_pseudo vs locked inode->i_state = 0
Message-ID: <ZNLMpgrCOQXFQnDk@dread.disaster.area>
References: <CAGudoHF_Y0shcU+AMRRdN5RQgs9L_HHvBH8D4K=7_0X72kYy2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHF_Y0shcU+AMRRdN5RQgs9L_HHvBH8D4K=7_0X72kYy2g@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 06:05:33PM +0200, Mateusz Guzik wrote:
> Hello,
> 
> new_inode_pseudo is:
>         struct inode *inode = alloc_inode(sb);
> 
> 	if (inode) {
> 		spin_lock(&inode->i_lock);
> 		inode->i_state = 0;
> 		spin_unlock(&inode->i_lock);
> 	}
> 
> I'm trying to understand:
> 1. why is it zeroing i_state (as opposed to have it happen in inode_init_always)
> 2. why is zeroing taking place with i_lock held
> 
> The inode is freshly allocated, not yet added to the hash -- I would
> expect that nobody else can see it.

Maybe not at this point, but as soon as the function returns with
the new inode, it could be published in some list that can be
accessed concurrently and then the i_state visible on other CPUs
better be correct.

I'll come back to this, because the answer lies in this code:

> Moreover, another consumer of alloc_inode zeroes without bothering to
> lock -- see iget5_locked:
> [snip]
> 	struct inode *new = alloc_inode(sb);
> 
> 		if (new) {
> 			new->i_state = 0;
> [/snip]

Yes, that one is fine because the inode has not been published yet.
The actual i_state serialisation needed to publish the inode happens
in the function called in the very next line - inode_insert5().

That does:

	spin_lock(&inode_hash_lock);

	.....
        /*
         * Return the locked inode with I_NEW set, the
         * caller is responsible for filling in the contents
         */
        spin_lock(&inode->i_lock);
        inode->i_state |= I_NEW;
        hlist_add_head_rcu(&inode->i_hash, head);
        spin_unlock(&inode->i_lock);
	.....

	spin_unlock(&inode_hash_lock);

The i_lock is held across the inode state initialisation and hash
list insert so that if anything finds the inode in the hash
immediately after insert, they should set an initialised value.

Don't be fooled by the inode_hash_lock here. We have
find_inode_rcu() which walks hash lists without holding the hash
lock, hence if anything needs to do a state check on the found
inode, they are guaranteed to see I_NEW after grabbing the i_lock....

Further, inode_insert5() adds the inode to the superblock inode
list, which means concurrent sb inode list walkers can also see this
inode whilst the inode_hash_lock is still held by inode_insert5().
Those inode list walkers *must* see I_NEW at this point, and they
are guaranteed to do so by taking i_lock before checking i_state....

IOWs, the initialisation of inode->i_state for normal inodes must be
done under i_lock so that lookups that occur after hash/sb list
insert are guaranteed to see the correct value.

If we now go back to new_inode_pseudo(), we see one of the callers
is new_inode(), and it does this:

struct inode *new_inode(struct super_block *sb)
{
        struct inode *inode;

        spin_lock_prefetch(&sb->s_inode_list_lock);

        inode = new_inode_pseudo(sb);
        if (inode)
                inode_sb_list_add(inode);
        return inode;
}

IOWs, the inode is immediately published on the superblock inode
list, and so inode list walkers can see it immediately. As per
inode_insert5(), this requires the inode state to be fully
initialised and memory barriers in place such that any walker will
see the correct value of i_state. The simplest, safest way to do
this is to initialise i_state under the i_lock....

> I don't know the original justification nor whether it made sense at
> the time, this is definitely problematic today in the rather heavy
> multicore era -- there is tons of work happening between the prefetch
> and actually take the s_inode_list_lock lock, meaning if there is
> contention, the cacheline is going to be marked invalid by the time
> spin_lock on it is called. But then this only adds to cacheline
> bouncing.

Well know problem - sb->s_inode_list_lock has been the heaviest
contended lock in the VFS for various XFS workloads for the best
part of a decade, yet XFS does not use new_inode(). See this branch
for how we fix the s_inode_list_lock contention issues:

https://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs.git/log/?h=vfs-scale

This commit removes the spin_lock_prefetch() you talk about:

https://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs.git/commit/?h=vfs-scale&id=fb17545b70d8c228295105044dd6b52085197d75

If only I had the time and resources available right now to push
this to completion.....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
