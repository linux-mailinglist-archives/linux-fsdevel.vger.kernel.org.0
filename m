Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DE47AD82D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 14:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjIYMj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 08:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYMj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:39:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66ADC0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 05:39:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1342BC433C8;
        Mon, 25 Sep 2023 12:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695645592;
        bh=5aN+37/37gh3gx5jsw17r7C+kMfBRl0h8pMLO3kka40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gO201HxAgH3MHkf/tCnnUItOCqaQIkMbyjs99ieSgTaCw2pe7/5fQOGCy0xCiq+je
         C802H/DRSGF9/a9WDaweb/h0n8xF7T+Ma47mJaB7ecpOvLqsIRfVnMkWjFbvV0VWWS
         2b2zQd3OwTkHFuiSM3qteCzxegmsvkkTxC14093EB0lUB/i7t6VvbpVevjGr10/wo3
         bea+yzumrZrDOXnfjnPUthF/r6tOh1FqAm20+XORQRK6rdc5p/NPVL8zl84AcZ1Uex
         uAAwufY/dZWZJCMsf0W+CWhHevkMHZMtDKAnFZHLtbj0k2XjF/hd8OMEjpu2AfDFUs
         W744U7SRMnw9g==
Date:   Mon, 25 Sep 2023 14:39:42 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Reuben Hawkins <reubenhwk@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Cyril Hrubis <chrubis@suse.cz>, mszeredi@redhat.com,
        lkp@intel.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev,
        ltp@lists.linux.it, Jan Kara <jack@suse.cz>
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
Message-ID: <20230925-festbesuch-komplett-d8c4ae2e1066@brauner>
References: <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
 <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
 <ZRBHSACF5NdZoQwx@casper.infradead.org>
 <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
 <ZRCwjGSF//WUPohL@casper.infradead.org>
 <CAD_8n+SBo4EaU4-u+DaEFq3Bgii+vX0JobsqJV-4m+JjY9wq8w@mail.gmail.com>
 <ZREr3M32aIPfdem7@casper.infradead.org>
 <CAOQ4uxgUC2KxO2fD-rSgVo3RyrrWbP-UHH+crG57uwXVn_sf2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgUC2KxO2fD-rSgVo3RyrrWbP-UHH+crG57uwXVn_sf2Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 25, 2023 at 12:43:42PM +0300, Amir Goldstein wrote:
> On Mon, Sep 25, 2023 at 9:42 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, Sep 24, 2023 at 11:35:48PM -0500, Reuben Hawkins wrote:
> > > The v2 patch does NOT return ESPIPE on a socket.  It succeeds.
> > >
> > > readahead01.c:54: TINFO: test_invalid_fd pipe
> > > readahead01.c:56: TFAIL: readahead(fd[0], 0, getpagesize()) expected
> > > EINVAL: ESPIPE (29)
> > > readahead01.c:60: TINFO: test_invalid_fd socket
> > > readahead01.c:62: TFAIL: readahead(fd[0], 0, getpagesize()) succeeded
> > > <-------here
> >
> > Thanks!  I am of the view that this is wrong (although probably
> > harmless).  I suspect what happens is that we take the
> > 'bdi == &noop_backing_dev_info' condition in generic_fadvise()
> > (since I don't see anywhere in net/ setting f_op->fadvise) and so
> > return 0 without doing any work.
> >
> > The correct solution is probably your v2, combined with:
> >
> >         inode = file_inode(file);
> > -       if (S_ISFIFO(inode->i_mode))
> > +       if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
> >                 return -ESPIPE;
> >
> > in generic_fadvise(), but that then changes the return value from
> > posix_fadvise(), as I outlined in my previous email.  And I'm OK with
> > that, because I think it's what POSIX intended.  Amir may well disagree
> > ;-)
> 
> I really have no problem with that change to posix_fadvise().
> I only meant to say that we are not going to ask Reuben to talk to
> the standard committee, but that's obvious ;-)
> A patch to man-pages, that I would recommend as a follow up.
> 
> FWIW, I checked and there is currently no test for
> posix_fadvise() on socket in LTP AFAIK.
> Maybe Cyril will follow your suggestion and this will add test
> coverage for socket in posix_fadvise().
> 
> Reuben,
> 
> The actionable item, if all agree with Matthew's proposal, is
> not to change the v2 patch to readahead(), but to send a new
> patch for generic_fadvise().
> 
> When you send the patch to Christian, you should specify
> the dependency - it needs to be applied before the readahead
> patch.
> 
> If the readahead patch was not already in the vfs tree, you
> would have needed to send a patch series with a cover letter,
> where you would leave the Reviewed-by on the unchanged
> [2/2] readahead patch.
> 
> Sending a patch series is a good thing to practice, but it is
> not strictly needed in this case, so I'll leave it up to you to decide.

My level of confusion is rather high at the moment.
I'll leave the readahead fix in vfs.misc (In fact, I just rebased it on
top everytime I picked up a patch so as to not invalidate the whole tree
when it changes.) and then please send the preparatory fix. Don't resend
the readahead fix if nothing has changed.
