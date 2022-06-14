Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300D954A34F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 02:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbiFNAx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 20:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiFNAx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 20:53:56 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBFC2FFF5;
        Mon, 13 Jun 2022 17:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gb5E1ldq5OJFZfWUbl/fw8bH7nSwLZwzG19ZDpeNBtQ=; b=KvBo6xh0HK0GydjEAQjoC1HVyL
        AV1IOkIMCtraKad7QJkyct7tjm3FtoFtF2qsWzNdFshheB1Dk7YxDdq1JR4bHoJP8J5ZliaDkZ3GM
        ZY3NtJq9VqYTIY2fgfAyniULF7Id+UNImGHTGgZKl1dcX0j3keZqdlOqs4RZad+O1PQwYjgJ9v62X
        UTMn1R72uDrIhvpdOSP7Oiuaz6mfSpYlRQyelvj64pvv0LK3Rn1ZQDmUCvejv4CAGbOwpk4Z6rJN+
        tVE3g7LWbJFVwGmfy8H1X5iJUYWi7SiUzaVLrof+c1oHLKlVOKZbTG7iABZjNXqQNab5x4UxluGCX
        GCizf9Fw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o0uoY-0006Pc-QR;
        Tue, 14 Jun 2022 00:53:50 +0000
Date:   Tue, 14 Jun 2022 01:53:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        nvdimm@lists.linux.dev, David Howells <dhowells@redhat.com>
Subject: Re: [RFC][PATCH] fix short copy handling in copy_mc_pipe_to_iter()
Message-ID: <YqfcHiBldIqgbu7e@ZenIV>
References: <YqaAcKsd6uGfIQzM@zeniv-ca.linux.org.uk>
 <CAHk-=wjmCzdNDCt6L8-N33WSRaYjnj0=yTc_JG8A_Pd7ZEtEJw@mail.gmail.com>
 <Yqe6EjGTpkvJUU28@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqe6EjGTpkvJUU28@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 13, 2022 at 11:28:34PM +0100, Al Viro wrote:
> On Mon, Jun 13, 2022 at 10:54:36AM -0700, Linus Torvalds wrote:
> > On Sun, Jun 12, 2022 at 5:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > Unlike other copying operations on ITER_PIPE, copy_mc_to_iter() can
> > > result in a short copy.  In that case we need to trim the unused
> > > buffers, as well as the length of partially filled one - it's not
> > > enough to set ->head, ->iov_offset and ->count to reflect how
> > > much had we copied.  Not hard to fix, fortunately...
> > >
> > > I'd put a helper (pipe_discard_from(pipe, head)) into pipe_fs_i.h,
> > > rather than iov_iter.c -
> > 
> > Actually, since this "copy_mc_xyz()" stuff is going to be entirely
> > impossible to debug and replicate for any normal situation, I would
> > suggest we take the approach that we (long ago) used to take with
> > copy_from_user(): zero out the destination buffer, so that developers
> > that can't test the faulting behavior don't have to worry about it.
> > 
> > And then the existing code is fine: it will break out of the loop, but
> > it won't do the odd revert games and the "randomnoise.len -= rem"
> > thing that I can't wrap my head around.
> > 
> > Hmm?
> 
> Not really - we would need to zero the rest of those pages somehow.
> They are already allocated and linked into pipe; leaving them
> there (and subsequent ones hadn't seen any stores whatsoever - they
> are fresh out of alloc_page(GFP_USER)) is a non-starter.
> 
> We could do allocation as we go, but that's a much more intrusive
> change...

FWIW, I've got quite a bit of cleanups in the local tree; reordering and
cleaning that queue up at the moment, will post tonight or tomorrow.

I've looked into doing allocations page-by-page (instead of single
push_pipe(), followed by copying into those).  Doable, but it ends
up being much messier.

IMO this "truncate on failure" approach is saner.
