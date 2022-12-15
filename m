Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF7764E29D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 21:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiLOU5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 15:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLOU5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:57:43 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1D6528AE
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 12:57:41 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c13so435700pfp.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 12:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGlgG65UXPdq7YvcqlgjjW36/ERNfTZqDYuDWENGbu8=;
        b=v4T1uygL5ZIuGoU1nKeJ2S6HM0bKfVT8vOSMQRBFHs7ZdQOKZm2ZLafTTVXRMN8n2r
         0ZUf2QIvTfXYMpoD2jwtabM9kr9JGGrRrkIEN9NqLlvXlGArXNJiumj3A1k4tESITmdl
         WFb466dCE568BXZh+aYXBerMt29s5RS9bqmeHNLzLmzmwKtqE5trAqqK7JgBKwkVdHu6
         w9zX9He9+eY5aI2OVhjUUaIJOFMe1/7ZfQbxAAH/ZdRT9onbGCy5fH54dPZBeS+kdNKx
         2KSBE5vriWptao3hYIm+d/+RsGLbIWHanDkJJqFByjs/TgNHNI767QKuZmM+mF6a5p+6
         26ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGlgG65UXPdq7YvcqlgjjW36/ERNfTZqDYuDWENGbu8=;
        b=nXanMzBJn+Iq+AH0pI4efq3XVzmxPFOQxVE0NPaHbVph+uGV60y4Ds/E52lVvdzG7r
         baDjbaHLFNvRpytBDb5TAgbQgaNM+4xTjG99zMHdrtR5U5eMVxZJBrArpNeSMs6VzeFn
         CNcZt02w0Ayzy1TCh8QAO+81Txp/v9EThVMzXZah83wFkdoBiy4F0WaNk7t6ZyRpVRIK
         zmIQFj+HvJ0Q80lGzxlZlPwcfNh8L+pceL8wjVZUdhxPssXNSsbV7FONqmH4K3nzcAFL
         DenyH/wQZrF6IxeZBBk2spUzPaGhmnPlco6LO1YGh9UGBzBVp65/j3VjP1viME5Rxwan
         ZSYw==
X-Gm-Message-State: ANoB5pklowr51QLiyp5+sSWN2vo+gyjDcqAiCDY4cXmk+d/WG0L2fBDX
        JPH83YRE5YxPVMNDc86y1yV/+g==
X-Google-Smtp-Source: AA0mqf7+C0W4VsYl4Q0pz20esq6X7Hc9K9Y5ZTA8oeFHjubSafBeKjFUoLBintjBMQS1JAPSm9kBJg==
X-Received: by 2002:a62:53c5:0:b0:563:cc80:fb66 with SMTP id h188-20020a6253c5000000b00563cc80fb66mr27930943pfb.0.1671137861454;
        Thu, 15 Dec 2022 12:57:41 -0800 (PST)
Received: from dread.disaster.area (pa49-181-138-158.pa.nsw.optusnet.com.au. [49.181.138.158])
        by smtp.gmail.com with ESMTPSA id k18-20020aa79992000000b0056d7cc80ea4sm36829pfh.110.2022.12.15.12.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 12:57:40 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p5vIP-008sJh-34; Fri, 16 Dec 2022 07:57:37 +1100
Date:   Fri, 16 Dec 2022 07:57:37 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] fs-verity support for XFS
Message-ID: <20221215205737.GD1971568@dread.disaster.area>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <Y5jllLwXlfB7BzTz@sol.localdomain>
 <20221213221139.GZ3600936@dread.disaster.area>
 <Y5ltzp6yeMo1oDSk@sol.localdomain>
 <20221214230632.GA1971568@dread.disaster.area>
 <Y5rDCcYGgH72Wn/e@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5rDCcYGgH72Wn/e@sol.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 14, 2022 at 10:47:37PM -0800, Eric Biggers wrote:
> On Thu, Dec 15, 2022 at 10:06:32AM +1100, Dave Chinner wrote:
> > > Well, my proposal at
> > > https://lore.kernel.org/r/20221028224539.171818-2-ebiggers@kernel.org is to keep
> > > tracking the "verified" status at the individual Merkle tree block level, by
> > > adding a bitmap fsverity_info::hash_block_verified.  That is part of the
> > > fs/verity/ infrastructure, and all filesystems would be able to use it.
> > 
> > Yeah, i had a look at that rewrite of the verification code last
> > night - I get the gist of what it is doing, but a single patch of
> > that complexity is largely impossible to sanely review...
> 
> Thanks for taking a look at it.  It doesn't really lend itself to being split
> up, unfortunately, but I'll see what I can do.
> 
> > Correct me if I'm wrong, but won't using a bitmap with 1 bit per
> > verified block cause problems with contiguous memory allocation
> > pretty quickly? i.e. a 64kB bitmap only tracks 512k blocks, which is
> > only 2GB of merkle tree data. Hence at file sizes of 100+GB, the
> > bitmap would have to be kvmalloc()d to guarantee allocation will
> > succeed.
> > 
> > I'm not really worried about the bitmap memory usage, just that it
> > handles large contiguous allocations sanely. I suspect we may
> > eventually need a sparse bitmap (e.g. the old btrfs bit-radix
> > implementation) to track verification in really large files
> > efficiently.
> 
> Well, that's why my patch uses kvmalloc() to allocate the bitmap.
> 
> I did originally think it was going to have to be a sparse bitmap that ties into
> the shrinker so that pages of it can be evicted.  But if you do the math, the
> required bitmap size is only 1 / 2^22 the size of the file, assuming the Merkle
> tree uses SHA-256 and 4K blocks.  So a 100MB file only needs a 24-byte bitmap,
> and the bitmap for any file under 17GB fits in a 4K page.
> 
> My patch puts an arbitrary limit at a 1 MiB bitmap, which would be a 4.4TB file.
> 
> It's not ideal to say "4 TB Ought To Be Enough For Anybody".  But it does feel
> that it's not currently worth the extra complexity and runtime overhead of
> implementing a full-blown sparse bitmap with cache eviction support, when no one
> currently has a use case for fsverity on files anywhere near that large.

I think we can live with that for the moment, but I suspect that 4TB
filesize limit will become an issue sooner rather than later. What
will happen if someone tries to measure a file larger than this
limit? What's the failure mode?

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
