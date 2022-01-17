Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371A2490A93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 15:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbiAQOgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 09:36:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59201 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234662AbiAQOgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642430163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0GXsjvYqgApuYgej4CjFXthDC/WRS/ARzY7AF/+YP/U=;
        b=XhRv/AnighVqNZdqFYkSXOYz/45D712SuKpQOUHLDcO12XTsCuHpO/8+dzqtue/BnQLEwC
        34ukwZeve53+NzLmxatq2zC18vaRVMUYTv+r0onVojkGbRKMYx+2gI7Io9GX7rMFvMF5+d
        o1f+yqMhiumNB/GRLH8OQE5EBAWSoJc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-SVYeZIE5P7CZZYEc8pG9-A-1; Mon, 17 Jan 2022 09:36:02 -0500
X-MC-Unique: SVYeZIE5P7CZZYEc8pG9-A-1
Received: by mail-qk1-f197.google.com with SMTP id y4-20020ae9f404000000b0047a17f48187so7055067qkl.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jan 2022 06:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0GXsjvYqgApuYgej4CjFXthDC/WRS/ARzY7AF/+YP/U=;
        b=V2mqVijvHBLap4BtmQH61QsTYPnxO7z8re1zOMXrZ+tnyh9T5snzarCZtIkxPeHpif
         WUMqENIYlaLw+tY1qZgZiGQdC2CA4AP3s61GmvfYqICEQuzBetrbUfQELYmlfWTqQ0cF
         BbJowiUh5I5HaTiRtsiznHJ5p/N1bukBp3UAGZnUPFSPLcF9gFyl7J6dJcduXYuOX/4a
         lL1BXzMRq1njmaqezjMYfrVIdXPov/R+fFVLz7t3l6Ti4/FGFzaI3ZRYS6t895JoOerV
         +jplWKcRf6wXqIMT6mXJILq53zE9HYp4UsbitlAZsSDq4XP4gTMZRm6qpGmSqX6mLgzp
         8Gew==
X-Gm-Message-State: AOAM531h+YlAJ8ZVKDG8HXV5LONCZ36e7J9MQ1Mmgpzqip4vYhiUMclD
        3m9+fe7ajQptyDQGo7K7gTTUmxacq5Swk15CcwmUu3twfeJH7SuiEcj9xVf55TRpKWUVmS2N6kt
        P1OASeVitm5jIalzq1OwK3OLiow==
X-Received: by 2002:ac8:7f12:: with SMTP id f18mr6216818qtk.643.1642430161599;
        Mon, 17 Jan 2022 06:36:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8KukT/ZNmG+VATMnw8vtIzAkw+sVuNtD7kejW9XkeoQXxY5HdrfRHqFeFmzHPUSRco0+oKw==
X-Received: by 2002:ac8:7f12:: with SMTP id f18mr6216795qtk.643.1642430161298;
        Mon, 17 Jan 2022 06:36:01 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id b6sm9056207qtk.91.2022.01.17.06.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 06:36:01 -0800 (PST)
Date:   Mon, 17 Jan 2022 09:35:58 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <YeV+zseKGNqnSuKR@bfoster>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
 <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
 <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 10:55:32AM +0800, Ian Kent wrote:
> On Sat, 2022-01-15 at 06:38 +0000, Al Viro wrote:
> > On Mon, Jan 10, 2022 at 05:11:31PM +0800, Ian Kent wrote:
> > > When following a trailing symlink in rcu-walk mode it's possible
> > > for
> > > the dentry to become invalid between the last dentry seq lock check
> > > and getting the link (eg. an unlink) leading to a backtrace similar
> > > to this:
> > > 
> > > crash> bt
> > > PID: 10964  TASK: ffff951c8aa92f80  CPU: 3   COMMAND: "TaniumCX"
> > > …
> > >  #7 [ffffae44d0a6fbe0] page_fault at ffffffff8d6010fe
> > >     [exception RIP: unknown or invalid address]
> > >     RIP: 0000000000000000  RSP: ffffae44d0a6fc90  RFLAGS: 00010246
> > >     RAX: ffffffff8da3cc80  RBX: ffffae44d0a6fd30  RCX:
> > > 0000000000000000
> > >     RDX: ffffae44d0a6fd98  RSI: ffff951aa9af3008  RDI:
> > > 0000000000000000
> > >     RBP: 0000000000000000   R8: ffffae44d0a6fb94   R9:
> > > 0000000000000000
> > >     R10: ffff951c95d8c318  R11: 0000000000080000  R12:
> > > ffffae44d0a6fd98
> > >     R13: ffff951aa9af3008  R14: ffff951c8c9eb840  R15:
> > > 0000000000000000
> > >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> > >  #8 [ffffae44d0a6fc90] trailing_symlink at ffffffff8cf24e61
> > >  #9 [ffffae44d0a6fcc8] path_lookupat at ffffffff8cf261d1
> > > #10 [ffffae44d0a6fd28] filename_lookup at ffffffff8cf2a700
> > > #11 [ffffae44d0a6fe40] vfs_statx at ffffffff8cf1dbc4
> > > #12 [ffffae44d0a6fe98] __do_sys_newstat at ffffffff8cf1e1f9
> > > #13 [ffffae44d0a6ff38] do_syscall_64 at ffffffff8cc0420b
> > > 
> > > Most of the time this is not a problem because the inode is
> > > unchanged
> > > while the rcu read lock is held.
> > > 
> > > But xfs can re-use inodes which can result in the inode -
> > > >get_link()
> > > method becoming invalid (or NULL).
> > 
> > Without an RCU delay?  Then we have much worse problems...
> 
> Sorry for the delay.
> 
> That was a problem that was discussed at length with the original post
> of this patch that included a patch for this too (misguided though it
> was).
> 

To Al's question, at the end of the day there is no rcu delay involved
with inode reuse in XFS. We do use call_rcu() for eventual freeing of
inodes (see __xfs_inode_free()), but inode reuse occurs for inodes that
have been put into a "reclaim" state before getting to the point of
freeing the struct inode memory. This lead to the long discussion [1]
Ian references around ways to potentially deal with that. I think the
TLDR of that thread is there are various potential options for
improvement, such as to rcu wait on inode creation/reuse (either
explicitly or via more open coded grace period cookie tracking), to rcu
wait somewhere in the destroy sequence before inodes become reuse
candidates, etc., but none of them seemingly agreeable for varying
reasons (IIRC mostly stemming from either performance or compexity) [2].

The change that has been made so far in XFS is to turn rcuwalk for
symlinks off once again, which looks like landed in Linus' tree as
commit 7b7820b83f23 ("xfs: don't expose internal symlink metadata
buffers to the vfs"). The hope is that between that patch and this
prospective vfs tweak, we can have a couple incremental fixes that at
least address the practical problem users have been running into (which
is a crash due to a NULL ->get_link() callback pointer due to inode
reuse). The inode reuse vs. rcu thing might still be a broader problem,
but AFAIA that mechanism has been in place in XFS on Linux pretty much
forever.

Brian

[1] https://lore.kernel.org/linux-fsdevel/163660197073.22525.11235124150551283676.stgit@mickey.themaw.net/

[2] Yet another idea could be a mix of two of the previously discussed
approaches: stamp the current rcu gp marker in the xfs_inode somewhere
on destroy and check it on reuse to conditionally rcu wait when
necessary. Perhaps that might provide enough batching to mitigate
performance impact when compared to an unconditional create side wait.

> That discussion resulted in Darrick merging the problem xfs inline
> symlink handling with the xfs normal symlink handling.
> 
> Another problem with these inline syslinks was they would hand a
> pointer to internal xfs storage to the VFS. Darrick's change
> allocates and copies the link then hands it to the VFS to free
> after use. And since there's an allocation in the symlink handler
> the rcu-walk case returns -ECHILD (on passed NULL dentry) so the
> VFS will call unlazy before that next call which I think is itself
> enough to resolve this problem.
> 
> The only thing I think might be questionable is the VFS copy of the
> inode pointer but I think the inode is rcu freed so it will be
> around and the seq count will have changed so I think it should be
> ok.
> 
> If I'm missing something please say so, ;)
> 
> Darrick's patch is (was last I looked) in his xfs-next tree.
> 
> Ian
> 
> 

