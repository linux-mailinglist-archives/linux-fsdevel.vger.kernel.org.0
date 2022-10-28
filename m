Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E429611910
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiJ1RQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiJ1RQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:16:08 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0D71C1155;
        Fri, 28 Oct 2022 10:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VF9k33pcdLTeIysuh3TIPFQyMmapNyL28cb+mCFej7M=; b=nmp1KrD+1RWDQWEGdIqlR51rBX
        Co4HTXHi5hdL7Or9H1D7lpRvNrl/dAuuwvAE6q9kU48BXcpLgXluKjNvJ+P1tA1YmgokVrwE9OnH/
        AcziZ+6gbDvJSaNlD0+weqyHcrHbSu7zl/Kbr3RvXdrDw165/xZy9f8iKmn6DoOJHudD6qT+vDs34
        LKpMZK318phJiptxpreVIn2neWvwUjImyjShts7sCtdpAUKBGWGhe9/smOz/8QzCbHxWBl9aEJ6Jd
        IK+VDpPS62qG95W0D/FpB00S75DV2grnMKSBpKWBdapKD3okncI1K/E0D1OJ65iyd/8BRJDjmYZPH
        ezIgcMqw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ooSxU-00F00G-04;
        Fri, 28 Oct 2022 17:15:52 +0000
Date:   Fri, 28 Oct 2022 18:15:51 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] use less confusing names for iov_iter direction
 initializers
Message-ID: <Y1wOR7YmqK8iBYa8@ZenIV>
References: <Y1btOP0tyPtcYajo@ZenIV>
 <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
 <20221028023352.3532080-12-viro@zeniv.linux.org.uk>
 <CAHk-=wibPKfv7mpReMj5PjKBQi4OsAQ8uwW_7=6VCVnaM-p_Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wibPKfv7mpReMj5PjKBQi4OsAQ8uwW_7=6VCVnaM-p_Dw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 28, 2022 at 09:41:35AM -0700, Linus Torvalds wrote:

> >         rq_for_each_segment(bvec, rq, iter) {
> > -               iov_iter_bvec(&i, READ, &bvec, 1, bvec.bv_len);
> >                 len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
> >                 if (len < 0)
> >                         return len;
> 
> where WRITE is used in the 'write()' function, and READ is used in the
> read() function.
> 
> So that naming is not great, but it has a fairly obvious pattern in a
> lot of code.
> 
> Not all code, no, as clearly shown by the other eleven patches in this
> series, but still..
> 
> The new naming doesn't strike me as being obviously less confusing.
> It's not horrible, but I'm also not seeing it as being any less likely
> in the long run to then cause the same issues we had with READ/WRITE.
> It's not like
> 
>                 iov_iter_bvec(&i, ITER_DEST, &bvec, 1, bvec.bv_len);
> 
> is somehow obviously really clear.
> 
> I can see the logic: "the destination is the iter, so the source is
> the bvec".

???

Wait a sec; bvec is destination - we are going to store data into the page
hanging off that bvec.

We have a request to read from /dev/loop into given page; page is where
the data goes into; the source of that data is the backing file of /dev/loop.

Or am I completely misparsing your sentence above?

> I think the real fix for this is your 11/12, which at least makes the
> iter movement helpers warn about mis-use. That said, I hate 11/12 too,
> but for a minor technicality: please make the WARN_ON() be a
> WARN_ON_ONCE(), and please don't make it abort.

Umm...  How are you going to e.g. copy from ITER_DISCARD?  I've no problem
with WARN_ON_ONCE(), but when the operation really can't be done, what
can we do except returning an error?

> Because otherwise somebody who has a random - but important enough -
> driver that does this wrong will just have an unbootable machine.
> 
> So your 11/12 is conceptually the right thing, but practically
> horribly wrong. While this 12/12 mainly makes me go "If we have a
> patch this big, I think we should be able to do better than change
> from one ambiguous name to another possibly slightly less ambiguous".
> 
> Honestly, I think the *real* fix would be a type-based one. Don't do
> 
>         iov_iter_kvec(&iter, ITER_DEST, ...
> 
> at all, but instead have two different kinds of 'struct iov_iter': one
> as a destination (iov_iter_dst), and one as a source (iov_iter_src),
> and then just force all the use-cases to use the right version. The
> actual *underlying" struct could still be the same
> (iov_iter_implementation), but you'd force people to always use the
> right version - kind of the same way a 'const void *' is always a
> source, and a 'void *' is always a destination for things like memcpy.
> 
> That would catch mis-uses much earlier.
> 
> That would also make the patch much bigger, but I do think 99.9% of
> all users are very distinct. When you pass a iter source around, that
> 'iov_iter_src' is basically *always* a source of the data through the
> whole call-chain. No?

No.  If nothing else, you'll get to split struct msghdr (msg->msg_iter
different for sendmsg and recvmsg that way) *and* you get to split
every helper in net/* that doesn't give a damn about the distinction
(as in "doesn't even look at ->msg_iter", for example).

> Maybe I'm 100% wrong and that type-based one has some fundamental
> problem in it, but it really feels to me like your dynamic WARN_ON()
> calls in 11/12 could have been type-based. Because they are entirely
> static based on 'data_source'.

See above; ->direct_IO() is just one example, there are much more
painful ones.   Sure, we can make those use a union of pointers or
pointer to union or play with casts, but that'll end up with
much more places that can go wrong.

I thought of that approach, but I hadn't been able to find any way to
do it without a very ugly and painful mess as the result.

We can do separate iov_iter_bvec_dest()/iov_iter_bvec_source(), etc.,
but it won't buy you any kind of type safety - not without splitting
the type and that ends up being too painful ;-/
