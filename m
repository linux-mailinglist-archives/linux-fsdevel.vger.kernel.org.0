Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABDD611AE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 21:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJ1TbK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 15:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ1TbI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:31:08 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2669E229E44;
        Fri, 28 Oct 2022 12:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rXRqCxzSwwJwUn6NUaDL+hX0MQGv2CPlx00T8de0cos=; b=k+le+6ssU0pzX5iaW/kTWOgm4b
        nhkSL3zT5nVqJVhVuRJK4TvRwmnHDnLaqUuWa+33dQ66uqwPEKjR4j4j9L4t1RboUwOc1Nk8nOWmt
        mz/UZSzC7pCS3TcjH1bbsoa537jLJ9WDiRH/HpVfMZj9CdcugRvy1mxB6bk4TGkhcCT5Ttoj96BuL
        bCfc5MewRDixyOuq+62XGtHBEts3nkQVf6Ij0WOUTS4g69Xtow1xtw/IxlhClbHYkhOkLGi5S4NAc
        2Sd8qZ5nSnH+oEKtDPOYRfzj09tLz4dzrw4xJctoRVfgt6ij1Sy7ZerlgDLXj0BG/z3WRgj8TfwLG
        AThxBdyQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ooV4A-00F1pm-0v;
        Fri, 28 Oct 2022 19:30:54 +0000
Date:   Fri, 28 Oct 2022 20:30:54 +0100
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
Message-ID: <Y1wt7uzL7vkBQ6Vm@ZenIV>
References: <Y1btOP0tyPtcYajo@ZenIV>
 <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
 <20221028023352.3532080-12-viro@zeniv.linux.org.uk>
 <CAHk-=wibPKfv7mpReMj5PjKBQi4OsAQ8uwW_7=6VCVnaM-p_Dw@mail.gmail.com>
 <Y1wOR7YmqK8iBYa8@ZenIV>
 <CAHk-=wi_iDAugqFZxTiscsRCNbtARMFiugWtBKO=NqgM-vCVAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi_iDAugqFZxTiscsRCNbtARMFiugWtBKO=NqgM-vCVAQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 28, 2022 at 11:35:06AM -0700, Linus Torvalds wrote:

> > Umm...  How are you going to e.g. copy from ITER_DISCARD?  I've no problem
> > with WARN_ON_ONCE(), but when the operation really can't be done, what
> > can we do except returning an error?
> 
> Fair enough. But it's the "people got the direction wrong, but the
> code worked" case that I would want tyo make sure still works - just
> with a warning.
> 
> Clearly the ITER_DISCARD didn't work before either, but all the cases
> in patches 1-10 were things that _worked_, just with entirely the
> wrong ->data_source (aka iov_iter_rw()) value.
> 
> So things like copy_to_iter() should warn if it's not a READ (or
> ITER_DEST), but it should still copy into the destination described by
> the iter, in order to keep broken code working.
> 
> That's simply because I worry that your patches 1-10 didn't actually
> catch every single case. I'm not actually sure how you found them all
> - did you have some automation, or was it with "boot and find warnings
> from the first version of patch 11/12"?

Went through the callers, replaced each with the right ITER_... (there's
not that many of them and they are fairly easy to review), then went
through mismatches and split their fixups into the beginning of the
series (READ -> ITER_SOURCE becoming READ -> WRITE -> ITER_SOURCE, that
is).

FWIW, there used to be one case where we really tried to copy the wrong
way - fixed a couple of cycles ago (f615625a44c4 "9p: handling Rerror
without copy_from_iter_full()").  No such catches this time...
