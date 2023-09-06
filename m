Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B9A7946AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 00:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbjIFWyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 18:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjIFWys (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:54:48 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A75619A9
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 15:54:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c34c9cc9b9so2684625ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 15:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694040884; x=1694645684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+N2Dpt8hCyK/GCOhgZdHPa9hp5pWTWAPcK1f0tlZvUU=;
        b=Y+VB9HmG/F3mxeiviPAy9GIc7OnxGb90twzRgjmvNzDI8eeK/cmQS69B6ti5yWM8pP
         FV30ILvUmINGtIXbpovMDs9mFbe4/1+8MySaJcFEjFZBnR+WU+dzeeD2becdgHFNUVR7
         nWXl9K7k/vtRCnfhciDgXFH94V+9odOm6pI4qG6NTC9/Asskhe3X4g4my4onLWj6mTsb
         06kV+vOl9pmbE1BwVHTq9RLrkQY41bNzGpoqNOwiiH0nFWnKGflyiyOP0QEBFQtEjgVb
         wNllK0NmrKCd/nXpeLuVz7XJkukE+R8C9IUw6xlbNBc5HD6TwMKPuZ6FYEr6H5g6m+Uc
         j3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694040884; x=1694645684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+N2Dpt8hCyK/GCOhgZdHPa9hp5pWTWAPcK1f0tlZvUU=;
        b=iNFzb+Ukr2CSIAwljB6Wy4yWG9Xfbzn9qmY5PfM3IYD6pP1eKVhbZQEdvXWDNRqgUg
         v0ZJDNd2xnNKkm9EuuJg5oEpKmKi8PHqDoEE0KQr5KesE5JkInIrx2iTxe3RdQjC23aj
         qThxuKLkT5ryZFNUHoVFa1Lm2Ko8HTPIq5fr0buR7Pq8OS0RADqDJhJqXIFXYlwD2tFp
         iZD+8B/3NjatT2LnURoq8aCql3nmJv4JqJLnpStz5vkhCYNp5qfOv3JVmoJ1YSZoFWo5
         23qicuEAq6lGWngC7jBWrfJf6wVP9G7etT0hBBfbgQhp0pY9BuH36+tV+Jl4TdQkxROF
         QIUA==
X-Gm-Message-State: AOJu0Yx++khDCFA73URtQi5HXYW9HDd4LlJZiN2G3f6PHM8c0dKVm7BH
        H+4NMragQYqHLx6NA7rCB9eilgAzomimi8f4VAc=
X-Google-Smtp-Source: AGHT+IE1Q3+f6DmiLoBBl0Ogm5XFOczxHZDTXx++n9QuBTo2Z6Wb6M/2STLDRv7HeUT8IOv1pOib7w==
X-Received: by 2002:a17:902:ce83:b0:1b8:a389:4410 with SMTP id f3-20020a170902ce8300b001b8a3894410mr18887840plg.0.1694040883579;
        Wed, 06 Sep 2023 15:54:43 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902bd4b00b001ab39cd875csm11512937plx.133.2023.09.06.15.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 15:54:42 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qe1Py-00BmHE-3C;
        Thu, 07 Sep 2023 08:54:39 +1000
Date:   Thu, 7 Sep 2023 08:54:38 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZPkDLp0jyteubQhh@dread.disaster.area>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 03:32:28PM -0700, Guenter Roeck wrote:
> On 8/30/23 07:07, Christoph Hellwig wrote:
> > Hi all,
> > 
> > we have a lot of on-disk file system drivers in Linux, which I consider
> > a good thing as it allows a lot of interoperability.  At the same time
> > maintaining them is a burden, and there is a lot expectation on how
> > they are maintained.
> > 
> > Part 1: untrusted file systems
> > 
> > There has been a lot of syzbot fuzzing using generated file system
> > images, which I again consider a very good thing as syzbot is good
> > a finding bugs.  Unfortunately it also finds a lot of bugs that no
> > one is interested in fixing.   The reason for that is that file system
> > maintainers only consider a tiny subset of the file system drivers,
> > and for some of them a subset of the format options to be trusted vs
> > untrusted input.  It thus is not just a waste of time for syzbot itself,
> > but even more so for the maintainers to report fuzzing bugs in other
> > implementations.
> > 
> > What can we do to only mark certain file systems (and format options)
> > as trusted on untrusted input and remove a lot of the current tension
> > and make everyone work more efficiently?  Note that this isn't even
> > getting into really trusted on-disk formats, which is a security
> > discussion on it's own, but just into formats where the maintainers
> > are interested in dealing with fuzzed images.
> > 
> > Part 2: unmaintained file systems
> > 
> > A lot of our file system drivers are either de facto or formally
> > unmaintained.  If we want to move the kernel forward by finishing
> > API transitions (new mount API, buffer_head removal for the I/O path,
> > ->writepage removal, etc) these file systems need to change as well
> > and need some kind of testing.  The easiest way forward would be
> > to remove everything that is not fully maintained, but that would
> > remove a lot of useful features.
> > 
> > E.g. the hfsplus driver is unmaintained despite collecting odd fixes.
> > It collects odd fixes because it is really useful for interoperating
> > with MacOS and it would be a pity to remove it.  At the same time
> > it is impossible to test changes to hfsplus sanely as there is no
> > mkfs.hfsplus or fsck.hfsplus available for Linux.  We used to have
> > one that was ported from the open source Darwin code drops, and
> > I managed to get xfstests to run on hfsplus with them, but this
> > old version doesn't compile on any modern Linux distribution and
> > new versions of the code aren't trivially portable to Linux.
> > 
> > Do we have volunteers with old enough distros that we can list as
> > testers for this code?  Do we have any other way to proceed?
> > 
> > If we don't, are we just going to untested API changes to these
> > code bases, or keep the old APIs around forever?
> > 
> 
> In this context, it might be worthwhile trying to determine if and when
> to call a file system broken.
> 
> Case in point: After this e-mail, I tried playing with a few file systems.
> The most interesting exercise was with ntfsv3.
> Create it, mount it, copy a few files onto it, remove some of them, repeat.
> A script doing that only takes a few seconds to corrupt the file system.
> Trying to unmount it with the current upstream typically results in
> a backtrace and/or crash.
> 
> Does that warrant marking it as BROKEN ? If not, what does ?

There's a bigger policy question around that.

I think that if we are going to have filesystems be "community
maintained" because they have no explicit maintainer, we need some
kind of standard policy to be applied.

I'd argue that the filesystem needs, at minimum, a working mkfs and
fsck implementation, and that it is supported by fstests so anyone
changing core infrastructure can simply run fstests against the
filesystem to smoke test the infrastructure changes they are making.

I'd suggest that syzbot coverage of such filesystems is not desired,
because nobody is going to be fixing problems related to on-disk
format verification. All we really care about is that a user can
read and write to the filesystem without trashing anything.

I'd also suggest that we mark filesystem support state via fstype
flags rather than config options. That way we aren't reliant on
distros setting config options correctly to include/indicate the
state of the filesystem implementation. We could also use similar
flags for indicating deprecation and obsolete state (i.e. pending
removal) and have code in the high level mount path issue the
relevant warnings.

This method of marking would also allow us to document and implement
a formal policy for removal of unmaintained and/or obsolete
filesystems without having to be dependent on distros juggling
config variables to allow users to continue using deprecated, broken
and/or obsolete filesystem implementations right up to the point
where they are removed from the kernel.

And let's not forget: removing a filesystem from the kernel is not
removing end user support for extracting data from old filesystems.
We have VMs for that - we can run pretty much any kernel ever built
inside a VM, so users that need to extract data from a really old
filesystem we no longer support in a modern kernel can simply boot
up an old distro that did support it and extract the data that way.

We need to get away from the idea that we have to support old
filesystems forever because someone, somewhere might have an old
disk on the shelf with that filesystem on it and they might plug it
in one day. If that day ever happens, they can go to the effort of
booting an era-relevant distro in a VM to extract that data. It
makes no sense to put an ongoing burden on current development to
support this sort of rare, niche use case....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
