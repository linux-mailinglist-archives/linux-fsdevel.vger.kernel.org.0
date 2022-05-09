Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE79251FE8A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 15:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbiEINoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 09:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbiEINoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 09:44:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E122E266C88
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 06:40:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0E83F1FA1C;
        Mon,  9 May 2022 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652103621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ycU4Gx9k8RBszc2cczBkRGB6I9M6+Zi60z99N5HRB8k=;
        b=Re7fUmtofo2OGU9wisHkRDndrflBhYt9lc2yE1Ymkx7eXY+uBpJcZcFCZM1O0+BUEwjHRn
        MaqJGcI4YnSlASR4XzKsDvp+9r6mV/zvlfelVq9cLBCtgXo8TLidFdLMz2uJ1ehciXC24R
        51FoVN13ZoCGFi+nXPRnOcVLk4GSRoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652103621;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ycU4Gx9k8RBszc2cczBkRGB6I9M6+Zi60z99N5HRB8k=;
        b=XlTvVJvysC5b1NQ9HJQ3yBkCv9HfXFMDA3VNq1pun4YWsgzVXgL6BkCjXNXOQ1nw/U8zH5
        Lwoifq+3SOqdlYBA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D78142C141;
        Mon,  9 May 2022 13:40:20 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6E175A062A; Mon,  9 May 2022 15:40:20 +0200 (CEST)
Date:   Mon, 9 May 2022 15:40:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jchao sun <sunjunchao2870@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3] writeback: Fix inode->i_io_list not be protected by
 inode->i_lock error
Message-ID: <20220509134020.gb3ay5yi2o5kzacp@quack3.lan>
References: <20220504143924.ix2m3azbxdmx67u6@quack3.lan>
 <20220504182514.25347-1-sunjunchao2870@gmail.com>
 <20220504193847.lx4eqcnqzqqffbtm@quack3.lan>
 <CAHB1Naif38Cib5xMLa1nK7-5H4FeLgPMLbBCi-Ze=YNna8ymYA@mail.gmail.com>
 <20220505090059.bgbn7lv2jsvo3vu3@quack3.lan>
 <CAHB1NahS0+mxTPXNRDmQV6gzPrOQdnCf=G3CMJnrw2XrO42aSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHB1NahS0+mxTPXNRDmQV6gzPrOQdnCf=G3CMJnrw2XrO42aSg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 07-05-22 00:04:45, Jchao sun wrote:
> > On Thu, May 5, 2022 at 5:01 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 05-05-22 12:45:56, Jchao sun wrote:
> > > > On Thu, May 5, 2022 at 3:38 AM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Wed 04-05-22 11:25:14, Jchao Sun wrote:
> > > > > > Commit b35250c0816c ("writeback: Protect inode->i_io_list with
> > > > > > inode->i_lock") made inode->i_io_list not only protected by
> > > > > > wb->list_lock but also inode->i_lock, but inode_io_list_move_locked()
> > > > > > was missed. Add lock there and also update comment describing things
> > > > > > protected by inode->i_lock.
> > > > > >
> > > > > > Fixes: b35250c0816c ("writeback: Protect inode->i_io_list with
> > > > inode->i_lock")
> > > > > > Signed-off-by: Jchao Sun <sunjunchao2870@gmail.com>
> > > > >
> > > > > Almost there :). A few comments below:
> > > > >
> > > > > > @@ -2402,6 +2404,9 @@ void __mark_inode_dirty(struct inode *inode, int
> > > > flags)
> > > > > >                       inode->i_state &= ~I_DIRTY_TIME;
> > > > > >               inode->i_state |= flags;
> > > > > >
> > > > > > +             wb = locked_inode_to_wb_and_lock_list(inode);
> > > > > > +             spin_lock(&inode->i_lock);
> > > > > > +
> > > > >
> > > >
> > > > > > We don't want to lock wb->list_lock if the inode was already dirty (which
> > > > > > is a common path). So you want something like:
> > > > > >
> > > > > >                 if (was_dirty)
> > > > > >                         wb = locked_inode_to_wb_and_lock_list(inode);
> > > >
> > > > I'm a little confused about here. The logic of the current source tree is
> > > > like this:
> > > >                        if (!was_dirty) {
> > > >                                struct bdi_writeback *wb;
> > > >                                wb =
> > > > locked_inode_to_wb_and_lock_list(inode);
> > > >                                ...
> > > >                                dirty_list = &wb-> b_dirty_time;
> > > >                                assert_spin_locked(&wb->list_lock);
> > > >                        }
> > > > The logic is the opposite of the logic in the comments, and it seems like
> > > > that wb will
> > > > absolutely not be NULL.
> > > > Why is this? What is the difference between them?
> > >
> > > Sorry, that was a typo in my suggestion. It should have been
> > >
> > >                  if (!was_dirty)
> > >                          wb = locked_inode_to_wb_and_lock_list(inode);
> 
> 1. I have noticed that move_expired_inodes() has the logic as follows:
> 
>                       list_move(&inode->i_io_list, &tmp);
>                       spin_lock(&inode->i_lock);
>                       inode->i_state |= I_SYNC_QUEUED;
>                       spin_unlock(&inode->i_lock);
>                       ...
>                       list_move(&inode->i_io_list, dispatch_queue);
> 
>    Neither of the two operations on i_io_list are protected with
> inode->i_lock. It looks like that
>    do this on purpose, I'm a little confused about this.
>    I wonder that is this a mistake. or did this on purpose and there
> is something I have missed?
>    If the later, why is that?

Yes, that looks like a bug but a harmless one. Actually looking into the
code I'm not sure we still need the protection of inode->i_lock for
inode->i_io_list handling but that would be a separate cleanup anyway.

> 2. I also have some doubts about the results of testing for xfs with
> xfstests.I'll describe my test
>     steps later. The kernel version used for testing is
> 5.18.0-rc5-00016-g107c948d1d3e-dirty,
>     and the latest commit is 107c948d1d3e ("Merge tag 'seccomp-v5.18-rc6' of
>      git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux")
> 
>    <a> First tested without this patch, there are always a few fixed cases
>           where it will fail, maybe I got something wrong.  Here is
> the testing result.
>           Failures: xfs/078 xfs/191-input-validation xfs/252 xfs/289
> xfs/293 xfs/514
>                                    xfs/515 xfs/544
>           Failed 8 of 304 tests

This is OK. Usually failures like these are due to older version of
xfsprogs, unexpected configuration of the kernel, some missing tool or
something like that. Anyway you should be mostly interested in
not introducing new test failures :).

>    <b> Then tested with the patch which applied your suggestions. The
> result is unstable.
>            There is a high probability that there will be more
> failures(which will report as follows),
>            and a small probability that the test result is the same as
> the above test which without
>            this patch.
> 
>            xfs/206 ... umount: /mnt/test: target is busy.
>            _check_xfs_filesystem: filesystem on /dev/loop0 has dirty log
>            (see /root/xfstests-dev/results/xfs/206.full for details)
>             _check_xfs_filesystem: filesystem on /dev/loop0 is inconsistent(r)
>             (see /root/xfstests-dev/results/xfs/206.full for details)
>             ...
>            Failures: xfs/078 xfs/149 xfs/164 xfs/165
> xfs/191-input-validation xfs/206 xfs/222
>                           xfs/242 xfs/250 xfs/252 xfs/259 xfs/260
> xfs/289 xfs/290 xfs/292 xfs/293
>                           xfs/514 xfs/515 xfs/544
>            Failed 19 of 304 tests.

So this is definitely suspicious. Likely the patch introduced a problem.
You need to have a look why e.g. test xfs/149 fails (you can run individual
test like "./check xfs/149"). You can inspect output the test generates,
also kernel logs if there's anything suspicious etc.

>            I saw that there is a "fatal error: couldn't initialize XFS
> library" which means xfs_repair
>            have failed.

Yeah, you can maybe strace xfs_repair why this fails...

>    <c>  Lastly tested with the patch which applied your suggestions
> and some modifications
>            which made operations on i_io_list in move_expired_inodes()
> will be protected by
>            inode->i_lock. There is a high probability that  the result
> is the same as the test in <a>,
>            and a small probability the same as <b>
> 
>    I think I must be missing something I don't understand yet, do I?

Well, it may be that there is just some race somewhere so the problem does
not always manifest.

> 3.   Here are my test steps.
>             xfs_io -f -c "falloc 0 10g" test.img
>             mkfs.xfs test.img
>             losetup /dev/loop0 ./test.img
>             mount /dev/loop0 /mnt/test
>             export TEST_DEV=/dev/loop0
>             export TEST_DIR=/mnt/test
>             ./check -g xfs/quick
>             reboot after the tests(If don't reboot, following test
> results will become more unstable
>             and have more failures)
> 
>             Repeat the above steps.

This looks OK.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
