Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3E854A2B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 01:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbiFMXZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 19:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbiFMXZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:25:16 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B1632065;
        Mon, 13 Jun 2022 16:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aJziV53ZNLcQpCnTSJ1xxm7rGO6TWzWG0v4urvX8NyU=; b=OT0sULAjLdDaLe/ufoRgRaz7h6
        lrNif+4H2x52/rVv8ukb76PFqzdihC65C1EMUDEvF+Al/I3OixmZVOhwnHVxnbiuj7E2UrBJAcK3i
        jq5BxKMcUf79LcpEbksN/HeGbGhMS59DgwAcyqzfBHXGBAr4eL+w8z1Xhz9hgreXdCcLdwZtYOSwB
        ZYuHacQ5p0oL3Ji5PO+Cu6tPRFt3jXOxRhifbYIa0FpTmQz+qczlVENomVFoigy/tiAnImRolar+O
        VX6TvKMmZD5xYum3sDP3LaVe4eMJSNR1tv14TqHfsPe1Hd8QoCCwuRCuyn+faTB7sA1Dm1z4QhW25
        kX5Ovdfg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o0tQd-0005hJ-Th;
        Mon, 13 Jun 2022 23:25:04 +0000
Date:   Tue, 14 Jun 2022 00:25:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        nvdimm@lists.linux.dev, David Howells <dhowells@redhat.com>
Subject: Re: [RFC][PATCH] fix short copy handling in copy_mc_pipe_to_iter()
Message-ID: <YqfHT7Ha/N/wAdcG@ZenIV>
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

> Dave, could you explain what's going on there?  Note that pipe_write()
> does *not* use that thing at all; it's only splice (i.e. ITER_PIPE
> stuff) that is using it.
> 
> What's wrong with
>         p_occupancy = pipe_occupancy(head, tail);
>         if (p_occupancy >= pipe->max_usage)
>                 return 0;
> 	else
> 		return pipe->max_usage - p_occupancy;
> 
> which would match the way you are using ->max_usage in pipe_write()
> et.al.  Including the use in copy_page_to_iter_pipe(), BTW...

The more I'm looking at that thing, the more it smells like a bug;
it had the same 3 callers since the time it had been introduced.

1) pipe_get_pages().  We are about to try and allocate up to that
many pipe buffers.  Allocation (done in push_pipe()) is done only
if we have !pipe_full(pipe->head, pipe->tail, pipe->max_usage).

It simply won't give you more than max_usage - occupancy.
Your function returns min(ring_size - occupancy, max_usage), which
is always greater than or equal to that (ring_size >= max_usage).

2) pipe_get_pages_alloc().  Same story, same push_pipe() being
called, same "we'll never get that much - it'll hit the limit
first".

3) iov_iter_npages() in case of ITER_PIPE.  Again, the value
is bogus - it should not be greater than the amount of pages
we would be able to write there.

AFAICS, 6718b6f855a0 "pipe: Allow pipes to have kernel-reserved slots"
broke it for cases when ring_size != max_usage...
