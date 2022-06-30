Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1015625D7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 00:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiF3WLc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 18:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiF3WLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:11:32 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFC657218
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 15:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mtS/W6S4ZeH//iFrZhwYMBYVsLjLHYpJIvpSws+etro=; b=ZPLSfteaUs2J8RHePOitdyLHIB
        p0JZlqFyhUEvraXnAJ50/b6Nik7xKwwlQ+3vOSkenlc1FL02/2OH94SAhkc3AuNOaSZOja1x9PE46
        w4IRHtcT3DPKWaDzRuDxEui352EkNIBXkzvXJwXmzwf5X712AMSjcAwQm/dolxwBAtwaEiBz8WJMn
        2k6OnjEBoQmLo/rQw+EAvEBDGK/R5LX+dByGvO9HnB+4SjuXdDc65dhDT+6qAdShzSbGFtC5d1doZ
        gGLVA4uYTRxyGziwVKXn5Hb6G9W1Vp5sxNkS5jasVBDbhVuY84uxQgd4N7XT3IJ6PD0L4p0lohk8Y
        aoaJu+lQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o72Nj-006hza-3r;
        Thu, 30 Jun 2022 22:11:27 +0000
Date:   Thu, 30 Jun 2022 23:11:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: [block.git conflicts] Re: [PATCH 37/44] block: convert to advancing
 variants of iov_iter_get_pages{,_alloc}()
Message-ID: <Yr4fj0uGfjX5ZvDI@ZenIV>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-37-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622041552.737754-37-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:15:45AM +0100, Al Viro wrote:
> ... doing revert if we end up not using some pages
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

... and the first half of that thing conflicts with "block: relax direct
io memory alignment" in -next...

Joy.  It's not hard to redo on top of the commit in there; the
question is, how to deal with conflicts?

I can do a backmerge, provided that there's a sane tag or branch to
backmerge from.  Another fun (if trivial) issue in the same series
is around "iov: introduce iov_iter_aligned" (two commits prior).

Jens, Keith, do you have any suggestions?  AFAICS, variants include
	* tag or branch covering b1a000d3b8ec582da64bb644be633e5a0beffcbf
(I'd rather not grab the entire for-5.20/block for obvious reasons)
It sits in the beginning of for-5.20/block, so that should be fairly
straightforward, provided that you are not going to do rebases there.
If you are, could you put that stuff into an invariant branch, so
I'd just pull it?
	* feeding the entire iov_iter pile through block.git;
bad idea, IMO, seeing that it contains a lot of stuff far from
anything block-related. 
	* doing a manual conflict resolution on top of my branch
and pushing that out.  Would get rid of the problem from -next, but
Linus hates that kind of stuff, AFAIK, and with good reasons.

	I would prefer the first variant (and that's what I'm
going to do locally for now - just
git tag keith_stuff bf8d08532bc19a14cfb54ae61099dccadefca446
and backmerge from it), but if you would prefer to deal with that
differently - please tell.
