Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AB056374E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 18:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiGAQCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 12:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiGAQCi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:02:38 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B812217058
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=uC9dI/5zMaGeQeLrvz9kid964PMTDAQBXxj9nf81kIU=; b=IVNKxmEdl95C5QaJPjHFI+VruG
        cU6sk9uA4Uv1fzapqpw86UUmulcOsZSn1YrJlULDYA7qPNSjl3FvqCzFnXdxyrQAcex1GWp9AK2dZ
        sGI5Mlp1+R9ShH6QH0Nb/WY42gU8AudEOrzPG/deJVSjoXXxJMSQcOj+rdbgvUDVeguIWxUvJAzPV
        jGp8NqTRfvIwIUvE6tDGgFcukqFAiJ/IIPKyLOjrQThr7/QcpVjmMH3eyFDkfv4ev0Sszxq6oo/5K
        JPyC0+/XASQte4bcM06IR1wrDw0t53M4aYS23HJZDOelAW9BUj7YxOotwiAnKh5578Wb3dXsZIEB6
        K9tHbX4/d4Icqd/0vydWJ3wOwe4xcs3OheBBq+X0AVd7BpCE3I0anU93FaVp6mQ6IqkMugdgwIR3T
        7R0lCi52HOOrWzP+y+9BclNjFenVxNaQGLiStU/FAilhJGr5156EcK7aqI+lXd48k7fDaoychmTXn
        7PExVG3mhIEOvi9faSGaMclwlQLVd5gJF8PHhp7cfERpIL/Fr+WUm2yL4rYMwquxG3Grhiwk2InMN
        9puQqnTURMqHEan+rfoxj04wN7S7hlO2eQ/pYJCNH1M6ghX1EF6oRqOn8JiRAxm4XCk8GRcGVq2JT
        4Va2LU+csT665HNYzWAlMBYj5N2O+PHr4PcH0PQf0=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 01/44] 9p: handling Rerror without copy_from_iter_full()
Date:   Fri, 01 Jul 2022 18:02:31 +0200
Message-ID: <6628265.VPEUYjqhpI@silver>
In-Reply-To: <Yr6TbVQvu+noSzc8@codewreck.org>
References: <YrKWRCOOWXPHRCKg@ZenIV> <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <Yr6TbVQvu+noSzc8@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Freitag, 1. Juli 2022 08:25:49 CEST Dominique Martinet wrote:
> (sigh, I'm tired -- said I'd add Christian in Ccs and promply forgot to
> do it. Sorry for double send to everyone else.)
> 
> +Christian Schoenebeck in Ccs as that concerns qemu as well.
> 
> The patch I'm replying to is at
> https://lkml.kernel.org/r/20220622041552.737754-1-viro@zeniv.linux.org.uk
> 
> Al Viro wrote on Wed, Jun 22, 2022 at 05:15:09AM +0100:
> >         p9_client_zc_rpc()/p9_check_zc_errors() are playing fast
> > 
> > and loose with copy_from_iter_full().
> > 
> > 	Reading from file is done by sending Tread request.  Response
> > 
> > consists of fixed-sized header (including the amount of data actually
> > read) followed by the data itself.
> > 
> > 	For zero-copy case we arrange the things so that the first
> > 
> > 11 bytes of reply go into the fixed-sized buffer, with the rest going
> > straight into the pages we want to read into.
> > 
> > 	What makes the things inconvenient is that sglist describing
> > 
> > what should go where has to be set *before* the reply arrives.  As
> > the result, if reply is an error, the things get interesting.  On success
> > we get
> > 
> > 	size[4] Rread tag[2] count[4] data[count]
> > 
> > For error layout varies depending upon the protocol variant -
> > in original 9P and 9P2000 it's
> > 
> > 	size[4] Rerror tag[2] len[2] error[len]
> > 
> > in 9P2000.U
> > 
> > 	size[4] Rerror tag[2] len[2] error[len] errno[4]
> > 
> > in 9P2000.L
> > 
> > 	size[4] Rlerror tag[2] errno[4]
> > 	
> > 	The last case is nice and simple - we have an 11-byte response
> > 
> > that fits into the fixed-sized buffer we hoped to get an Rread into.
> > In other two, though, we get a variable-length string spill into the
> > pages we'd prepared for the data to be read.
> > 
> > 	Had that been in fixed-sized buffer (which is actually 4K),
> > 
> > we would've dealt with that the same way we handle non-zerocopy case.
> > However, for zerocopy it doesn't end up there, so we need to copy it
> > from those pages.
> > 
> > 	The trouble is, by the time we get around to that, the
> > 
> > references to pages in question are already dropped.  As the result,
> > p9_zc_check_errors() tries to get the data using copy_from_iter_full().
> > Unfortunately, the iov_iter it's trying to read from might *NOT* be
> > capable of that.  It is, after all, a data destination, not data source.
> > In particular, if it's an ITER_PIPE one, copy_from_iter_full() will
> > simply fail.
> > 
> > 	In ->zc_request() itself we do have those pages and dealing with
> > 
> > the problem in there would be a simple matter of memcpy_from_page()
> > into the fixed-sized buffer.  Moreover, it isn't hard to recognize
> > the (rare) case when such copying is needed.  That way we get rid of
> > p9_zc_check_errors() entirely - p9_check_errors() can be used instead
> > both for zero-copy and non-zero-copy cases.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> I ran basic tests with this, should be ok given the code path is never
> used on normal (9p2000.L) workloads.

I haven't read this patch in detail yet, but upfront: POSIX error strings are 
like what, max. 128 bytes, no? So my expectation therefore would be that this 
patch could be further simplified.

Apart from that, I would rename handle_rerror() to something that reflects 
better what it actually does, e.g. unsparse_error() or cp_rerror_to_sdata().

> I also tried 9p2000.u for principle and ... I have no idea if this works
> but it didn't seem to blow up there at least.
> The problem is that 9p2000.u just doesn't work well even without these
> patches, so I still stand by what I said about 9p2000.u and virtio (zc
> interface): we really can (and I think should) just say virtio doesn't
> support 9p2000.u.
> (and could then further simplify this)
>
> If you're curious, 9p2000.u hangs without your patch on at least two
> different code paths (trying to read a huge buffer aborts sending a
> reply because msize is too small instead of clamping it, that one has a
> qemu warning message; but there are others ops like copyrange that just
> fail silently and I didn't investigate)

Last time I tested 9p2000.u was with the "remove msize limit" (WIP) patches:
https://lore.kernel.org/all/cover.1640870037.git.linux_oss@crudebyte.com/
Where I did not observe any issue with 9p2000.u.

What msize are we talking about, or can you tell a way to reproduce?

> I'd rather not fool someone into believing we support it when nobody has
> time to maintain it and it fails almost immediately when user requests
> some unusual IO patterns... And I definitely don't have time to even try
> fixing it.
> I'll suggest the same thing to qemu lists if we go that way.

Yeah, the situation with 9p2000.u in QEMU is similar in the sense that 
9p2000.u is barely used, little contributions, code not in good shape (e.g 
slower in many aspects in comparison to 9p2000.L), and for that reason I 
discussed with Greg to deprecate 9p2000.u in QEMU (not done yet). We are not 
aware about any serious issue with 9p2000.u though.

Best regards,
Christian Schoenebeck


