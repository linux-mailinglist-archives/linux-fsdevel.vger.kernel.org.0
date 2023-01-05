Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D09E65F085
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 16:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjAEPvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 10:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbjAEPuY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:50:24 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AB55F481
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jan 2023 07:50:23 -0800 (PST)
Received: from letrec.thunk.org (host-67-21-23-146.mtnsat.com [67.21.23.146] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 305FnZPB011422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Jan 2023 10:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1672933788; bh=SwRwXE7W0BAf789h44Lpm0WiZ8Jk4yCRVsQWnf58tQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=TWjo6ehQJMOdGDOS3GyzzMTHfBLKSbdtpKKlth14VGSLkrbqBtSQ2kroPogEvf4OX
         lzrX97+nCQ51R0BJvoeTTIuhvLi60KUruuT8esOIiVi3Fvem7+pYZZDULwFcu03ZIl
         h/C+KC8+HtlMhFZWqB77VShWfrvLnC5qa77df6rr1LtZvd1o+7y39ywk+S4FEk+nA3
         F39uFVUQchu/C8AUqdg8wlrjQIqYYZbdu70FwNwia7Sh+4K7APP6cPeUUgrzy/lu/r
         Jk9FEZn1y5U15N1HLLWLjtQ+fyh4GY29zG9tNgffaajL9CAJ5PdGy66Y+pZDtYIx4G
         EkUGvnba+IlTg==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 02E768C0850; Thu,  5 Jan 2023 10:49:32 -0500 (EST)
Date:   Thu, 5 Jan 2023 10:49:32 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, sarthakkukreti@google.com,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>
Subject: Re: [PATCH v2 3/7] fs: Introduce FALLOC_FL_PROVISION
Message-ID: <Y7bxjKusa2L/TNRE@mit.edu>
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
 <20221229081252.452240-4-sarthakkukreti@chromium.org>
 <Y7Wr2uadI+82BB6a@magnolia>
 <CAG9=OMNbeU=Xg5bWvHUSfzRf8vsk6csvcw5BGZeMD5Lo7dfKFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG9=OMNbeU=Xg5bWvHUSfzRf8vsk6csvcw5BGZeMD5Lo7dfKFQ@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 04, 2023 at 01:22:06PM -0800, Sarthak Kukreti wrote:
> > How expensive is this expected to be?  Is this why you wanted a separate
> > mode flag?
>
> Yes, the exact latency will depend on the stacked block devices and
> the fragmentation at the allocation layers.
> 
> I did a quick test for benchmarking fallocate() with an:
> A) ext4 filesystem mounted with 'noprovision'
> B) ext4 filesystem mounted with 'provision' on a dm-thin device.
> C) ext4 filesystem mounted with 'provision' on a loop device with a
> sparse backing file on the filesystem in (B).
> 
> I tested file sizes from 512M to 8G, time taken for fallocate() in (A)
> remains expectedly flat at ~0.01-0.02s, but for (B), it scales from
> 0.03-0.4s and for (C) it scales from 0.04s-0.52s (I captured the exact
> time distribution in the cover letter
> https://marc.info/?l=linux-ext4&m=167230113520636&w=2)
> 
> +0.5s for a 8G fallocate doesn't sound a lot but I think fragmentation
> and how the block device is layered can make this worse...

If userspace uses fallocate(2) there are generally two reasons.
Either they **really** don't want to get the NOSPC, in which case
noprovision will not give them what they want unless we modify their
source code to add this new FALLOC_FL_PROVISION flag --- which may not
be possible if it is provided in a binary-only format (for example,
proprietary databases shipped by companies beginning with the letters
'I' or 'O').

Or, they really care about avoiding fragmentation by giving a hint to
the file system that layout is important, and so **please** allocate
the space right away so that it is more likely that the space will be
laid out in a contiguous fashion.  Of course, the moment you use
thin-provisioning this goes out the window, since even if the space is
contiguous on the dm-thin layer, on the underlying storage layer it is
likely that things will be fragmented to a fare-thee-well, and either
(a) you have a vast amount of flash to try to mitigate the performance
hit of using thin-provisioning (example, hardware thin-provisioning
such as EMC storage arrays), or (b) you really don't care about
performance since space savings is what you're going for.

So.... because of the issue of changing the semantics of what
fallocate(2) will guarantee, unless programs are forced to change
their code to use this new FALLOC flag, I really am not very fond of
it.

I suspect that using a mount option (which should default to
"provision"; if you want to break user API expectations, it should
require a mount option for the system administrator to explicitly OK
such a change), is OK.

As far as the per-file mode --- I'm not convinced it's really
necessary.  In general if you are using thin-provisioning file systems
tend to be used explicitly for one purpose, so adding the complexity
of doing it on a per-file basis is probably not really needed.  That
being said, your existing prototype requires searching for the
extended attribute on every single file allocation, which is not a
great idea.  On a system with SELinux enabled, every file will have an
xattr block, and requiring that it be searched on every file
allocation would be unfortunate.  It would be better to check for the
xattr when the file is opened, and then setting a flag in the struct
file.  However, it might be better to see if it there is a real demand
for such a feature before adding it.

						- Ted
