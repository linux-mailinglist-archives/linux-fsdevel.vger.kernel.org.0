Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F5B6D1407
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 02:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCaA3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 20:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCaA24 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:28:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CB0E1BA
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 17:28:48 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i5so83637034eda.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 17:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680222527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L/321qEfsdd6Li2EcEMfqC9Li7rtjZommEiuh2gRTto=;
        b=DZEf1xUJfTUEdgD3msGdVte+/jLWfThGevpfh0CnxibxN/P8QtCGkAJuFHfsgc0KrS
         /Axpy8WzWsImUTvrJb+u6GUWyv9JD94nUAwQ6xrZBGbpC2J87RDYe1WX/HDL/8uOKDfh
         ilMDEcNdDl9oxrv6U1AsvqEA2khFX179gVDgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680222527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/321qEfsdd6Li2EcEMfqC9Li7rtjZommEiuh2gRTto=;
        b=kiBTEq5v61VzyZIf+hjgQnVWTMbcWGiVuPKlFvsFe4EDKDo5vVjR9nExlUPqfmpzgW
         9+y23NX1DJcb9syxH4pxQujzfqsyHxDh2GWhhc+rgvbmD2j9BXdea1W5/i7Jr73KYVit
         mf1eQscgd2Q+g1Jn2BZQDPbEC9fm5rgoQ3p0bfSdrWH0a0aqJTA4ttVnWMweofzsfe0j
         QNrEBf2ctPYqtMwNJsWoFtcUdGAagPTeH75b7ifkclq1/Kp8URjBt71rmeE5VhYASd/c
         00AcY3LognybwLqEufTCUuR6A5QbIiZY2oTDJs7Wr8GzaD5ae64N4cjNKnjjZQvMkFAt
         ulDw==
X-Gm-Message-State: AAQBX9cCvvS32tQewYKhmyIX9Pw0R68BSGoSxLquqwJnAQ+U7LF5D55C
        dWWwSTP/HOMS0AI98karRXBlDF6pbUWZB/nwfwnlwA==
X-Google-Smtp-Source: AKy350YiyWxtdKYS11gbPuOdxgKie3I79uhb6oCaV13YfwgHdVzTkX0BBGKglxLUIUEpEZMbv4YpUX4X2kCh3ahutsM=
X-Received: by 2002:a17:907:3e8b:b0:931:ce20:db6e with SMTP id
 hs11-20020a1709073e8b00b00931ce20db6emr14070290ejc.2.1680222526978; Thu, 30
 Mar 2023 17:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
 <20221229081252.452240-4-sarthakkukreti@chromium.org> <Y7Wr2uadI+82BB6a@magnolia>
 <CAG9=OMNbeU=Xg5bWvHUSfzRf8vsk6csvcw5BGZeMD5Lo7dfKFQ@mail.gmail.com> <Y7bxjKusa2L/TNRE@mit.edu>
In-Reply-To: <Y7bxjKusa2L/TNRE@mit.edu>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 30 Mar 2023 17:28:35 -0700
Message-ID: <CAG9=OMM_0D+ck6=0dfjBi0B_zqTbp3i28tFDr8c3e1TQip1sQA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] fs: Introduce FALLOC_FL_PROVISION
To:     "Theodore Ts'o" <tytso@mit.edu>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 5, 2023 at 7:49 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Jan 04, 2023 at 01:22:06PM -0800, Sarthak Kukreti wrote:
> > > How expensive is this expected to be?  Is this why you wanted a separate
> > > mode flag?
> >
> > Yes, the exact latency will depend on the stacked block devices and
> > the fragmentation at the allocation layers.
> >
> > I did a quick test for benchmarking fallocate() with an:
> > A) ext4 filesystem mounted with 'noprovision'
> > B) ext4 filesystem mounted with 'provision' on a dm-thin device.
> > C) ext4 filesystem mounted with 'provision' on a loop device with a
> > sparse backing file on the filesystem in (B).
> >
> > I tested file sizes from 512M to 8G, time taken for fallocate() in (A)
> > remains expectedly flat at ~0.01-0.02s, but for (B), it scales from
> > 0.03-0.4s and for (C) it scales from 0.04s-0.52s (I captured the exact
> > time distribution in the cover letter
> > https://marc.info/?l=linux-ext4&m=167230113520636&w=2)
> >
> > +0.5s for a 8G fallocate doesn't sound a lot but I think fragmentation
> > and how the block device is layered can make this worse...
>
> If userspace uses fallocate(2) there are generally two reasons.
> Either they **really** don't want to get the NOSPC, in which case
> noprovision will not give them what they want unless we modify their
> source code to add this new FALLOC_FL_PROVISION flag --- which may not
> be possible if it is provided in a binary-only format (for example,
> proprietary databases shipped by companies beginning with the letters
> 'I' or 'O').
>
> Or, they really care about avoiding fragmentation by giving a hint to
> the file system that layout is important, and so **please** allocate
> the space right away so that it is more likely that the space will be
> laid out in a contiguous fashion.  Of course, the moment you use
> thin-provisioning this goes out the window, since even if the space is
> contiguous on the dm-thin layer, on the underlying storage layer it is
> likely that things will be fragmented to a fare-thee-well, and either
> (a) you have a vast amount of flash to try to mitigate the performance
> hit of using thin-provisioning (example, hardware thin-provisioning
> such as EMC storage arrays), or (b) you really don't care about
> performance since space savings is what you're going for.
>
> So.... because of the issue of changing the semantics of what
> fallocate(2) will guarantee, unless programs are forced to change
> their code to use this new FALLOC flag, I really am not very fond of
> it.
>
> I suspect that using a mount option (which should default to
> "provision"; if you want to break user API expectations, it should
> require a mount option for the system administrator to explicitly OK
> such a change), is OK.
>
Understood. I dropped the FALLOC flag from the series in v3, instead
we now rely on the filesystem's mount/policy.

> As far as the per-file mode --- I'm not convinced it's really
> necessary.  In general if you are using thin-provisioning file systems
> tend to be used explicitly for one purpose, so adding the complexity
> of doing it on a per-file basis is probably not really needed.  That
> being said, your existing prototype requires searching for the
> extended attribute on every single file allocation, which is not a
> great idea.  On a system with SELinux enabled, every file will have an
> xattr block, and requiring that it be searched on every file
> allocation would be unfortunate.  It would be better to check for the
> xattr when the file is opened, and then setting a flag in the struct
> file.  However, it might be better to see if it there is a real demand
> for such a feature before adding it.
>
Thanks for the feedback! On ChromeOS, we still have filesystems shared
between applications, partly due to inertia of adoption. So, we have a
few cases of needing to share the filesystem but with differing
provisioning policy.

One more idea that I've been exploring in this space and uses the
above file-based mechanism is to use a 'provisioning disabled'
fallocated file to make the apparent free space in the thinly
provisioned filesystem match the space available in the thinpool. In
theory, this prevents userspace applications from writing much more
than what's available on the thinpool. In practice, it depends on the
responsiveness of the service that monitors and resizes this 'storage
balloon'.

Best
Sarthak

>                                                 - Ted
