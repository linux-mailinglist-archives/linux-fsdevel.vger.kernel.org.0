Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26A61DF5FE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 10:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387712AbgEWIPe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 04:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387471AbgEWIPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 04:15:33 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C875EC061A0E
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 01:15:32 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u16so6069041lfl.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 01:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pz5IpPnqQym07imPNP194ldsEOzZ722IuM/LHmahs88=;
        b=etpppD3sOhIuLu49I0DwFkGMuMOwg81haclPsGJC6TBxDPOzmARLArZ+94DZe7XjaI
         if+G+Tz9DDYBejUypSC6+YKWQCFdwX9qKuzxM4muG/u1YGN7Orh3vE6EP70pz9QTy5Hx
         hERr9XsH2jGplGfO1dojGu+oDZ/oegoC4XbS/4wmbP5WB7cAL3owdAE6GOTRuMHXdxW2
         b0Ah3Od4zX895f/c+exQZOR//IVsTTHorAsgPt0qW0wtqoT7Wl3dm6HVBfk7rODX3y5W
         XTue48Lb2ZgHsLy5Ry4Yl/LCn55q4i05u4Nm5ICrvMi0yH7G/zSLfAaW3n0PSkkD1N8E
         s8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pz5IpPnqQym07imPNP194ldsEOzZ722IuM/LHmahs88=;
        b=Ae56gqDcLVQN4hA36m2hAO4zmL4MFNrHQlQ6Vafw413IekGKSX+rhBBIDSLy5SAQbf
         AyRdf9LIugeuXZlc01wI9Aj+pJcPLijUtA9MB9BX0taLAuBBSJtcwAX/OQNAQcWwCZCH
         5LLWjpGhtL5QqnWrWq+bUHxLNL9w58+wHhVgGTep/J2aiKdaQKc4lAf9sXbXatNdsjop
         6gtuD9ijekt3Pfm+jyrEsV017REp1bEylpscj4FMXHZNNv7vif/BlB2UeB6gG9ZcEvmP
         wiHLSKgz8CfgW6kTfDVD/sJ6+qxFUPje8OOXqXMZUP3x+Pjj297kPoXk/vCeuBixkll8
         vshA==
X-Gm-Message-State: AOAM531A3rjbiDYHTwFOuvti1XdzepnGEYZs5NTb4Z40zN3pVV8p9Hgg
        Zsc/t3vrdMhceo4JOwYzeMJrtDt93/IqYp8QXsxcSw==
X-Google-Smtp-Source: ABdhPJzwUlJicPJUTEKreO42XNW0mvKvzEQny4lvYylKlEBBDRSJvHgMmTQ8SE7D7kREHF2lDZKMKkJ/2VMQz8z48u4=
X-Received: by 2002:ac2:5bc1:: with SMTP id u1mr1002223lfn.61.1590221731279;
 Sat, 23 May 2020 01:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAB0TPYGCOZmixbzrV80132X=V5TcyQwD6V7x-8PKg_BqCva8Og@mail.gmail.com>
 <20200522144100.GE14199@quack2.suse.cz> <CAB0TPYF+Nqd63Xf_JkuepSJV7CzndBw6_MUqcnjusy4ztX24hQ@mail.gmail.com>
 <20200522153615.GF14199@quack2.suse.cz>
In-Reply-To: <20200522153615.GF14199@quack2.suse.cz>
From:   Martijn Coenen <maco@android.com>
Date:   Sat, 23 May 2020 10:15:20 +0200
Message-ID: <CAB0TPYGJ6WkaKLoqQhsxa2FQ4s-jYKkDe1BDJ89CE_QUM_aBVw@mail.gmail.com>
Subject: Re: Writeback bug causing writeback stalls
To:     Jan Kara <jack@suse.cz>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        miklos@szeredi.hu, tj@kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jaegeuk wondered whether callers of write_inode_now() should hold
i_rwsem, and whether that would also prevent this problem. Some
existing callers of write_inode_now() do, eg ntfs and hfs:

hfs_file_fsync()
    inode_lock(inode);

    /* sync the inode to buffers */
    ret = write_inode_now(inode, 0);

but there are also some that don't (eg fat, fuse, orangefs).

Thanks,
Martijn


On Fri, May 22, 2020 at 5:36 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 22-05-20 17:23:30, Martijn Coenen wrote:
> > [ dropped android-storage-core@google.com from CC: since that list
> > can't receive emails from outside google.com - sorry about that ]
> >
> > Hi Jan,
> >
> > On Fri, May 22, 2020 at 4:41 PM Jan Kara <jack@suse.cz> wrote:
> > > > The easiest way to fix this, I think, is to call requeue_inode() at the end of
> > > > writeback_single_inode(), much like it is called from writeback_sb_inodes().
> > > > However, requeue_inode() has the following ominous warning:
> > > >
> > > > /*
> > > >  * Find proper writeback list for the inode depending on its current state and
> > > >  * possibly also change of its state while we were doing writeback.  Here we
> > > >  * handle things such as livelock prevention or fairness of writeback among
> > > >  * inodes. This function can be called only by flusher thread - noone else
> > > >  * processes all inodes in writeback lists and requeueing inodes behind flusher
> > > >  * thread's back can have unexpected consequences.
> > > >  */
> > > >
> > > > Obviously this is very critical code both from a correctness and a performance
> > > > point of view, so I wanted to run this by the maintainers and folks who have
> > > > contributed to this code first.
> > >
> > > Sadly, the fix won't be so easy. The main problem with calling
> > > requeue_inode() from writeback_single_inode() is that if there's parallel
> > > sync(2) call, inode->i_io_list is used to track all inodes that need writing
> > > before sync(2) can complete. So requeueing inodes in parallel while sync(2)
> > > runs can result in breaking data integrity guarantees of it.
> >
> > Ah, makes sense.
> >
> > > But I agree
> > > we need to find some mechanism to safely move inode to appropriate dirty
> > > list reasonably quickly.
> > >
> > > Probably I'd add an inode state flag telling that inode is queued for
> > > writeback by flush worker and we won't touch dirty lists in that case,
> > > otherwise we are safe to update current writeback list as needed. I'll work
> > > on fixing this as when I was reading the code I've noticed there are other
> > > quirks in the code as well. Thanks for the report!
> >
> > Thanks! While looking at the code I also saw some other paths that
> > appeared to be racy, though I haven't worked them out in detail to
> > confirm that - the locking around the inode and writeback lists is
> > tricky. What's the best way to follow up on those? Happy to post them
> > to this same thread after I spend a bit more time looking at the code.
>
> Sure, if you are aware some some other problems, just write them to this
> thread. FWIW stuff that I've found so far:
>
> 1) __I_DIRTY_TIME_EXPIRED setting in move_expired_inodes() can get lost as
> there are other places doing RMW modifications of inode->i_state.
>
> 2) sync(2) is prone to livelocks as when we queue inodes from b_dirty_time
> list, we don't take dirtied_when into account (and that's the only thing
> that makes sure aggressive dirtier cannot livelock sync).
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
