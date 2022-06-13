Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D0754A23F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 00:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiFMWrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 18:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiFMWrq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:47:46 -0400
X-Greylist: delayed 1140 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Jun 2022 15:47:45 PDT
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B3130572;
        Mon, 13 Jun 2022 15:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+COkvdNrG6nWHW8DeXVNn4pSIXXVecQkufUo12vTZqM=; b=F1GaohTqdVyGbYtsxIq1ypUFSB
        P1lDuj/SfIxIUbtNOkI8o8CmCXWpPq/1+OMrMMOxMWjRQoykrHF01Bq4OG0vxR0hKM5bbwC9uWOd9
        2/mdrfapr7kM/8zZ6/tsuHr3nPIYSd/WzF2XWntJS3FWWPOug6sDaEw/SFUeb0PMXbBSmi7lByhJm
        GA2PvhnaqVNF03pAh+K/YYGKB64ks4khKPFs48hRmwGveqm7TfpcG87sSbrydMzgtxbcH248jh/q/
        d6pEaGxSHgZi/+SunJ6dUdtnr+ZWQL5awJRvRUba+eqJscSETAyFR+DCrVKsFj874VH3hJcv8Nh/L
        0SgvT1OQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o0sXy-0005E5-FL;
        Mon, 13 Jun 2022 22:28:34 +0000
Date:   Mon, 13 Jun 2022 23:28:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        nvdimm@lists.linux.dev, David Howells <dhowells@redhat.com>
Subject: Re: [RFC][PATCH] fix short copy handling in copy_mc_pipe_to_iter()
Message-ID: <Yqe6EjGTpkvJUU28@ZenIV>
References: <YqaAcKsd6uGfIQzM@zeniv-ca.linux.org.uk>
 <CAHk-=wjmCzdNDCt6L8-N33WSRaYjnj0=yTc_JG8A_Pd7ZEtEJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjmCzdNDCt6L8-N33WSRaYjnj0=yTc_JG8A_Pd7ZEtEJw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:54:36AM -0700, Linus Torvalds wrote:
> On Sun, Jun 12, 2022 at 5:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Unlike other copying operations on ITER_PIPE, copy_mc_to_iter() can
> > result in a short copy.  In that case we need to trim the unused
> > buffers, as well as the length of partially filled one - it's not
> > enough to set ->head, ->iov_offset and ->count to reflect how
> > much had we copied.  Not hard to fix, fortunately...
> >
> > I'd put a helper (pipe_discard_from(pipe, head)) into pipe_fs_i.h,
> > rather than iov_iter.c -
> 
> Actually, since this "copy_mc_xyz()" stuff is going to be entirely
> impossible to debug and replicate for any normal situation, I would
> suggest we take the approach that we (long ago) used to take with
> copy_from_user(): zero out the destination buffer, so that developers
> that can't test the faulting behavior don't have to worry about it.
> 
> And then the existing code is fine: it will break out of the loop, but
> it won't do the odd revert games and the "randomnoise.len -= rem"
> thing that I can't wrap my head around.
> 
> Hmm?

Not really - we would need to zero the rest of those pages somehow.
They are already allocated and linked into pipe; leaving them
there (and subsequent ones hadn't seen any stores whatsoever - they
are fresh out of alloc_page(GFP_USER)) is a non-starter.

We could do allocation as we go, but that's a much more intrusive
change...

BTW, speaking of pipes:
static inline unsigned int pipe_space_for_user(unsigned int head, unsigned int tail,
                                               struct pipe_inode_info *pipe)
{
        unsigned int p_occupancy, p_space;

        p_occupancy = pipe_occupancy(head, tail);
        if (p_occupancy >= pipe->max_usage)
                return 0;
        p_space = pipe->ring_size - p_occupancy;
        if (p_space > pipe->max_usage)
                p_space = pipe->max_usage;
        return p_space;
}

OK, if head - tail >= max_usage, we get 0.  Fair enough, since
pipe_full() callers will get "it's full, sod off" in that situation.
But...  what the hell is the rest doing?  p_space is the amount of
slots not in use.  So we return the lesser of it and max_usage?

Suppose we have 128 slots in the ring, with max_usage being below
that (e.g. 64).  63 slots are in use; you can add at most one.
And p_space is 65, so this sucker will return 64.

Dave, could you explain what's going on there?  Note that pipe_write()
does *not* use that thing at all; it's only splice (i.e. ITER_PIPE
stuff) that is using it.

What's wrong with
        p_occupancy = pipe_occupancy(head, tail);
        if (p_occupancy >= pipe->max_usage)
                return 0;
	else
		return pipe->max_usage - p_occupancy;

which would match the way you are using ->max_usage in pipe_write()
et.al.  Including the use in copy_page_to_iter_pipe(), BTW...
