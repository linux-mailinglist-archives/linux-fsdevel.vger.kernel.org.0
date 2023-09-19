Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C84E7A56DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 03:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjISBQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 21:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjISBQE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 21:16:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00858E
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 18:15:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c39f2b4f5aso37204715ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 18:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1695086158; x=1695690958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8BP6Q+AMCPZ9MOO2xNlzGG06UMqHA6HfF4RkMK4C86Q=;
        b=0sMzuxZ+qFdOHFVvGGcZItt7T+1X3toDwk8wn+Lm5ELPgz5BYn/zY9R62rLdGrlxPI
         sHsrfMdeoA8WM77/5w75m5uOR7DpDXfvCRs1jIzc6xB9p0OQPXRR/B0nglMfxHYUprLr
         Vmr/jdmO30LCi9vxEs0VkOs3JCg2Nse2j23T5xWs5RXt5gyQ0H0zrWgxFY3bpclyFI2T
         9C3GhKtGMPxE2iBrUBoiEXvUh4RRMSWCnN8sMl3qB5QPnEneZ6dmsK6Wus/meMBXjhS8
         iS4FIXZ10Q7hCUSV+56TLkdXDC4XObd4GdthRJqgsSlmITjCOj91Wqt64hNKlMljX91j
         c52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695086158; x=1695690958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BP6Q+AMCPZ9MOO2xNlzGG06UMqHA6HfF4RkMK4C86Q=;
        b=jSYZFGw+Vsm1aBH7P4II+V9iPHwWmSDSxcqQ8SXUY42y8JBZuoWbxHXei5ktXxrCnD
         xQQZQl97nmnPUzHbz3bmZknnewAx4BPolLGq5zo+x8KM/dtkgyEfwgpMxRLkIRByh6yF
         le0R4Gr7kwzPUXThJegkotyZRo3Vkc7/iLYJlBybUJanjiLPdw7iRWJm6+TsWfjVJJja
         P+m4vuSzh8MIXumI/OD5f40I9kn9gUDiYKKX454F2PP5bu3ZcMnF7sb43yoKBBc9+Adk
         TRsApoX9m8YRCAKV7D7mxO0wqhq9Yb4ZWtbyqyWUINyrWMMAunuS/wcFbyUnClXWk/wO
         6i3w==
X-Gm-Message-State: AOJu0Yx0oSZButq28IV4EI31ztwTUJ3Se4tE7Qxzje/aQjnORuaqHqZL
        Xo+i+LXKR86INaEFutVONCm8kg==
X-Google-Smtp-Source: AGHT+IGOgXqDv1bbpA30MGtF4mW4FWWx/FG+CA3auvFFmXfcnA2Uzim5eQdbBL3ID+8bVQ5OqrVrbA==
X-Received: by 2002:a17:903:1c8:b0:1c3:9544:cf63 with SMTP id e8-20020a17090301c800b001c39544cf63mr12300495plh.23.1695086158005;
        Mon, 18 Sep 2023 18:15:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001bdc6ca748esm8905210plb.185.2023.09.18.18.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 18:15:57 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qiPLG-002a5u-2O;
        Tue, 19 Sep 2023 11:15:54 +1000
Date:   Tue, 19 Sep 2023 11:15:54 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     NeilBrown <neilb@suse.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZQj2SgSKOzfKR0e3@dread.disaster.area>
References: <ZPkz86RRLaYOkmx+@dread.disaster.area>
 <20230906225139.6ffe953c@gandalf.local.home>
 <ZPlFwHQhJS+Td6Cz@dread.disaster.area>
 <20230907071801.1d37a3c5@gandalf.local.home>
 <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net>
 <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
 <ZQTfIu9OWwGnIT4b@dread.disaster.area>
 <db57da32517e5f33d1d44564097a7cc8468a96c3.camel@HansenPartnership.com>
 <169491481677.8274.17867378561711132366@noble.neil.brown.name>
 <CAHk-=wg_p7g=nonWOqgHGVXd+ZwZs8im-G=pNHP6hW60c8=UHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg_p7g=nonWOqgHGVXd+ZwZs8im-G=pNHP6hW60c8=UHw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 17, 2023 at 10:30:55AM -0700, Linus Torvalds wrote:
> On Sat, 16 Sept 2023 at 18:40, NeilBrown <neilb@suse.de> wrote:
> >
> > I'm not sure the technical argument was particularly coherent.  I think
> > there is a broad desire to deprecate and remove the buffer cache.

....

> In other words, the buffer cache is
> 
>  - simple
> 
>  - self-contained
> 
>  - supports 20+ legacy filesystems
> 
> so the whole "let's deprecate and remove it" is literally crazy
> ranting and whining and completely mis-placed.

But that isn't what this thread is about. This is a strawman that
you're spending a lot of time and effort to stand up and then knock down.

Let's start from a well known problem we currently face: the
per-inode page cache struggles to scale to the bandwidth
capabilities of modern storage. We've known about this for well over
a decade in high performance IO circles, but now we are hitting it
with cheap consumer level storage. These per-inode bandwidth
scalability problems is one of the driving reasons behind the
conversion to folios and the introduction of high order folios into
the page cache.

One of the problems being raised in the high-order folio context is
that *bufferheads* and high-order folios don't really go together
well.  The pointer chasing model per-block bufferhead iteration
requires to update state and retrieve mapping information just does
not scale to marshalling millions of objects a second through the
page cache.

The best solution is to not use bufferheads at all for file data.
That's the direction the page cache IO stack is moving; we are
already there with iomap and hence XFS. With the recent introduction
of high order folios into the buffered write path, single file write
throughput on a pcie4.0 ssd went from ~2.5GB/s consuming 5 CPUs in
mapping lock contention to saturating the device at over 7GB/s
whilst also providing a 70% reduction in total CPU usage. This
result is came about simply by reduce reducing mapping lock traffic
by a couple of orders of magnitude across the write syscall, IO
submission, IO completion and memory reclaim paths....

This was easy to do with iomap based filesystems because they don't
carry per-block filesystem structures for every folio cached in page
cache - we carry a single object per folio that holds the 2 bits of
per-filesystem block state we need for each block the folio maps.
Compare that to a bufferhead - it uses 56 bytes of memory per
fielsystem block that is cached.

Hence in modern systems with hundreds of GB to TB of RAM and IO
rates measured in the multiple GB/s, this is a substantial cost in
terms of page cache efficiency and resource usage when using
bufferheads in the data path.  The benefits to moving from
bufferheads for data IO to iomap for data IO are significant.

However, that's not an easy conversion. There's a lot of work to
validate the intergrity of the IO path whilst making such a change.
It's complex and requires a fair bit of expertise in how the IO path
works, filesystem locking models, internal fs block mapping and
allocation routines, etc. And some filesystems flush data through
the buffer cache or track data writes though their journals via
bufferheads, so actually removing bufferheads for them is not an
easy task.

So we have to consider that maybe it is less work to make high-order
folios work with bufferheads. And that's where we start to get into
the maintenance problems with old filesysetms using bufferheads -
how do we ensure that the changes for high-order folio support in
bufferheads does not break the way one of these old filesystems
that use bufferheads?

That comes down to a simple question: if we can't actually test all
these old filesystems, how do we even know that they work correctly
right now?  Given that we are supposed to be providing some level of
quality assurance to users of these filesystems, are they going to
bve happy with running untested code that nobody really knows if it
works properly or not?

The buffer cache and the fact legacy filesystems use it is the least
of our worries - the problems are with the complex APIs,
architecture and interactions at the intersection point of shared
page cache and filesystem state. The discussion is a reflection on
how difficult it is to change a large, complex code base where
significant portions of it are untestable.

Regardless of which way we end up deciding to move forwards there is
*lots* of work that needs to be done and significant burdens remain
on the people who need to API changes to do get where we need to be.
We want to try to minimise that burden so we can make progress as
fast as possible.

Getting rid of unmaintained, untestable code is low hanging fruit.
Nobody is talking about getting rid of the buffer cache; we can
ensure that the buffer cache continues to work fairly easily; it's
all the other complex code in the filesystems that is the problem.

What we are actually talking about how to manage code which is
unmaintained, possibly broken and which nobody can and/or will fix.
Nobody benefits from the kernel carrying code we can't easily
maintain, test or fix, so working out how to deal with this problem
efficiently is a key part of the decisions that need to be made.

Hence to reduce this whole complex situation to a statement "the
buffer cache is simple and people suggesting we deprecate and remove
it" is a pretty significant misrepresentation the situation we find
ourselves in.

> Was this enough technical information for people?
> 
> And can we now all just admit that anybody who says "remove the buffer
> cache" is so uninformed about what they are speaking of that we can
> just ignore said whining?

Wow. Just wow.

After being called out for abusive behaviour, you immediately call
everyone who disagrees with you "uninformed" and suggest we should
"just ignore said whining"?

Which bit of "this is unacceptable behaviour" didn't you understand,
Linus?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
