Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E169179A121
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Sep 2023 04:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjIKCHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 22:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjIKCHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:07:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB08189
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 19:07:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c39bc0439bso7534945ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 19:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694398030; x=1695002830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iFdWQV0JfBW9JatAANQUGiCR3g8udJbX/WYt1WXyjDE=;
        b=0JUVZLzh4CONnZwyTK9mRLI9VHguD4BTyS4ZVqp/reI48yxwlgvQmli+vUP664gnOI
         2TDqx7YybGW2KGtVCGw1Eucs1XfjHiW2uc+xA+yYZviItwcGleW8f3B9Q8itNQwvkPaI
         CcqsBDhgpyZCLaErsBTNoHVLjvUtu2u7G/OOs5hPfqub3mtLvhn5RVF7figmL1+ye4Gs
         kdyw/IO+pyW8sCVfYfOazSeYDhVXq2kp4jvD+N0q/PCD6fz9tTpGKE2CcZtRgC6iyLPY
         YSSBNWJTkuHri2ZpfcmWbSicawSSHdwoP6H6BDTj7iz9knFOPxn1CBDFxPL1u0uEMSkN
         YLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694398030; x=1695002830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFdWQV0JfBW9JatAANQUGiCR3g8udJbX/WYt1WXyjDE=;
        b=gI3pE3723flBBxNVo2MOL0JJZkmPU24JOi/3Z9Xqml6VgW17BI7orbV0wldZ+dV/OS
         VGZLOwyOaXy67t9zc5Vy0xQRMdgjJzYySUMRe6AVggJB9n8I9mhTJVH2nNjLuJSd66Yv
         qMVQHWgwLBHZ8LUKssByvbczSPUvaI6cZB8HshjXoFnRGnytQSKwH/8ilfZNaJ2gKtA7
         +ESrs6HAuvuRvuq1FDDGSRq5t6MdXNe+ylqNGh73yl+bWOS9MmX+RrBa3YqJCDtqL1rn
         aJZ1DMpseFusnQS0FF8d1rbGlOpUNyxCZ8rC8+3dMPS2Sy1MY81nkLDXEuFaQiEarNCS
         b5rA==
X-Gm-Message-State: AOJu0YwPfsaeWsQzcLcM40yN7ChGApztfyQlEJnfJ6UpcTNdu35RMMuj
        l4vDOoGA/Q9Ell2YP9T66HDbxPowV3ClO2sditA=
X-Google-Smtp-Source: AGHT+IF1iWSDM7k1ay09wAZyHu4bNutY5poNI0pO3IQzH+yzO0oG1uBlmDWVAv3yfOmm0WaLKndtbA==
X-Received: by 2002:a17:902:dac1:b0:1bc:7e37:e832 with SMTP id q1-20020a170902dac100b001bc7e37e832mr16481004plx.19.1694398030444;
        Sun, 10 Sep 2023 19:07:10 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id ja10-20020a170902efca00b001b9da8b4eb7sm5188478plb.35.2023.09.10.19.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 19:07:09 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qfWKR-00DakW-13;
        Mon, 11 Sep 2023 12:07:07 +1000
Date:   Mon, 11 Sep 2023 12:07:07 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZP52S8jPsNt0IvQE@dread.disaster.area>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
 <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
 <20230909224230.3hm4rqln33qspmma@moria.home.lan>
 <ZP5nxdbazqirMKAA@dread.disaster.area>
 <20230911012914.xoeowcbruxxonw7u@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911012914.xoeowcbruxxonw7u@moria.home.lan>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 10, 2023 at 09:29:14PM -0400, Kent Overstreet wrote:
> On Mon, Sep 11, 2023 at 11:05:09AM +1000, Dave Chinner wrote:
> > On Sat, Sep 09, 2023 at 06:42:30PM -0400, Kent Overstreet wrote:
> > > On Sat, Sep 09, 2023 at 08:50:39AM -0400, James Bottomley wrote:
> > > > So why can't we figure out that easier way? What's wrong with trying to
> > > > figure out if we can do some sort of helper or library set that assists
> > > > supporting and porting older filesystems. If we can do that it will not
> > > > only make the job of an old fs maintainer a lot easier, but it might
> > > > just provide the stepping stones we need to encourage more people climb
> > > > up into the modern VFS world.
> > > 
> > > What if we could run our existing filesystem code in userspace?
> > 
> > You mean like lklfuse already enables?
> 
> I'm not seeing that it does?
> 
> I just had a look at the code, and I don't see anything there related to
> the VFS - AFAIK, a VFS -> fuse layer doesn't exist yet.

Just to repeat what I said on #xfs here...

It doesn't try to cut in half way through the VFS -> filesystem
path. It just redirects the fuse operations to "lkl syscalls" and so
runs the entire kernel VFS->filesystem path.

https://github.com/lkl/linux/blob/master/tools/lkl/lklfuse.c

> And that looks a lot heavier than what we'd ideally want, i.e. a _lot_
> more kernel code would be getting pulled in. The entire block layer,
> probably the scheduler as well.

Yes, but arguing that "performance sucks" misses the entire point of
this discussion: that for the untrusted user mounts of untrusted
filesystem images we already have a viable method for moving the
dangerous processing out into userspace that requires almost *zero
additional work* from anyone.

As long as the performance of the lklfuse implementation doesn't
totally suck, nobody will really care that much that isn't quite as
fast as a native implementation. PLuggable drives (e.g. via USB) are
already going to be much slower than a host installed drive, so I
don't think performance is even really a consideration for these
sorts of use cases....

> What I've got in bcachefs-tools is a much thinner mapping from e.g.
> kthreads -> pthreads, block layer -> aio, etc.

Right, and we've got that in userspace for XFS, too. If we really
cared that much about XFS-FUSE, I'd be converting userspace to use
ublk w/ io_uring on top of a port of the kernel XFS buffer cache as
the basis for a performant fuse implementation. However, there's a
massive amount of userspace work needed to get a native XFS FUSE
implementation up and running (even ignoring performance), so it's
just not a viable short-term - or even medium-term - solution to the
current problems.

Indeed, if you do a fuse->fs ops wrapper, I'd argue that lklfuse is
the place to do it so that there is a single code base that supports
all kernel filesystems without requiring anyone to support a
separate userspace code base. Requiring every filesystem to do their
own FUSE ports and then support them doesn't reduce the overall
maintenance overhead burden on filesystem developers....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
