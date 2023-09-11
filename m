Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6E879C356
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 04:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbjILCxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 22:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbjILCw5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:52:57 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1959A510D
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 16:07:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so6398915ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 16:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694473552; x=1695078352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XuOvAuitgVpwNW68IEhm3g9qIi8Riz123zMf3hveQBs=;
        b=Ld8oRuE6tcUY4lp3b7qTfSjiPCNxHb2sxyj1e+McTzDIrf4NP4jhDPUACtIrW3Bfla
         l3f+qH7EpMu6Zi1clsZMbCGUbxiyHk+x+BAfUK7hA+eg7lBpfN5ymHdcI7Lwk4jmrxGb
         tisg7IaqXRYKiX7y3O5zVnC3oBuDn+ohuGbJ+ZL+2SA4ccFApcfm0eVAidn1UfDrI/9C
         M8xXuvGg4VrGdOLlQapK6feqYsdLYe4uo8ISOJZhmLnqg+1BPOCy7Uco+SR4IUOlkeRz
         Ju2uk2XVAMKy8zAoFML96G/LUnbTh+woZyL2arcYPfhegV6MuZho2XQh9od/3cfcsA8C
         TwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694473552; x=1695078352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuOvAuitgVpwNW68IEhm3g9qIi8Riz123zMf3hveQBs=;
        b=GKyhB6aEuV8Qm44rdgWgpqmLwwK7iNeS3hRLupgdGuhlE5k7nCxVPOw/ajp49MRAm2
         NllHh6FXxkMya5EbXIVIrQi39Qojb5ihgQj/GkxF89ajLCfQZZAz5IJRgwMXzkOPcJi2
         RI2Xoft5zHaDh83ce9KBltCtstpBLGGng7lHF13rBQG1NE6b+GhGf/szkPV5bX4UKXlH
         BbuXvUBCrO/UZ4cNLDLuENTmD0oHwTNp2QIfVXua0zg5gihPv6LQi6QZHuNC+MEvJ1wt
         mXDuBHsyiRTWtqQVz+hstS7WSP1+LkdNGv4JXL2Mc/bB9BP1Ln4bVa/EluriVMXKlukS
         7k0g==
X-Gm-Message-State: AOJu0Yx+2aXtOc8Ijj3tx8d02ONsoDXdLlOD8GP4Ie3nP2n9h8LQdFXr
        5AolY7SevFGbo2f+qNSjsyzoAO1pH6X9JfveDek=
X-Google-Smtp-Source: AGHT+IHBqWEpAfZoVXfFa5/vR2XzTrXg9hy5GECmWfGXDiZ4BuZu7eo2+Nh2xoOFUY2UwQvCoBZtIw==
X-Received: by 2002:a17:902:e84e:b0:1b8:6cae:3570 with SMTP id t14-20020a170902e84e00b001b86cae3570mr13674878plg.11.1694473552602;
        Mon, 11 Sep 2023 16:05:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b001b392bf9192sm6987910plx.145.2023.09.11.16.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:05:52 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qfpyX-00Dyh3-1h;
        Tue, 12 Sep 2023 09:05:49 +1000
Date:   Tue, 12 Sep 2023 09:05:49 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>,
        Octavian Purdila <tavi.purdila@gmail.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZP+dTfwJP44wZwSV@dread.disaster.area>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
 <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
 <20230909224230.3hm4rqln33qspmma@moria.home.lan>
 <ZP5nxdbazqirMKAA@dread.disaster.area>
 <20230911012914.xoeowcbruxxonw7u@moria.home.lan>
 <ZP52S8jPsNt0IvQE@dread.disaster.area>
 <20230911153515.2a256856@echidna.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911153515.2a256856@echidna.fritz.box>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 11, 2023 at 03:35:15PM +0200, David Disseldorp wrote:
> On Mon, 11 Sep 2023 12:07:07 +1000, Dave Chinner wrote:
> > On Sun, Sep 10, 2023 at 09:29:14PM -0400, Kent Overstreet wrote:
> > > What I've got in bcachefs-tools is a much thinner mapping from e.g.
> > > kthreads -> pthreads, block layer -> aio, etc.  
> > 
> > Right, and we've got that in userspace for XFS, too. If we really
> > cared that much about XFS-FUSE, I'd be converting userspace to use
> > ublk w/ io_uring on top of a port of the kernel XFS buffer cache as
> > the basis for a performant fuse implementation. However, there's a
> > massive amount of userspace work needed to get a native XFS FUSE
> > implementation up and running (even ignoring performance), so it's
> > just not a viable short-term - or even medium-term - solution to the
> > current problems.
> > 
> > Indeed, if you do a fuse->fs ops wrapper, I'd argue that lklfuse is
> > the place to do it so that there is a single code base that supports
> > all kernel filesystems without requiring anyone to support a
> > separate userspace code base. Requiring every filesystem to do their
> > own FUSE ports and then support them doesn't reduce the overall
> > maintenance overhead burden on filesystem developers....
> 
> LKL is still implemented as a non-mmu architecture. The only fs specific
> downstream change that lklfuse depends on is non-mmu xfs_buf support:
> https://lore.kernel.org/linux-xfs/1447800381-20167-1-git-send-email-octavian.purdila@intel.com/

That was proposed in 2015.

> Does your lklfuse enthusiasm here imply that you'd be willing to
> reconsider Octavian's earlier proposal for XFS non-mmu support?

8 years a long time, circumstances change and we should always be
open to changing our minds when presented with new circumstances
and/or evidence.

Context: back in 2015 I was in the middle of a significant revamp of
the kernel and userspace code - that was when the shared libxfs
codebase was new and being actively developed, along with a
significant rework of all the userspace shims.  One of the things
that I was looking at the time was pulling everything into userspace
via libxfs that was needed for a native XFS-FUSE implementation.
That project never got that far - maintainer burnout happened before
that ever became a reality.

In that context, lklfuse didn't really make a whole lot of sense for
providing userspace XFS support via fuse because a native FUSE
solution would be much better in most regards (especially
performance). Things have changed a whole lot since then. We have
less fs developers, we have a antagonistic, uncooperative testing
"community", we have more code and releases to support, etc.

If we go back to what I said earlier about the minimum requirements
for a "community supported filesystem", it was about needing three
things:

- mkfs and fsck coverage
- fstests support
- syzbot doesn't get run on it

Now reconsider lklfuse from this perspective. We have #1 for most
filesystems, #2 is pretty trivial, and #3 is basically "syzbot +
lklfuse > /dev/null"...

IOWs, we can largely validate that lklfuse doesn't eat your data
with relatively little extra effort. We can provide userspace with a
viable, supported mechanism for unprivileged mounts of untrusted
filesystem images that can't lead to kernel compromise. And,
largely, we retain control of the quality of the lklfuse
implementation because it's running the kernel code that we already
maintain and support.

Times change, circumstances change, and if we aren't willing to
change our minds because we need to solve the new challenges
presented to us then we should not be in decision making
positions....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
