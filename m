Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDB2793241
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 01:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjIEXGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 19:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjIEXGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 19:06:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA933199
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 16:06:26 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-573d52030fbso1059263a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Sep 2023 16:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1693955186; x=1694559986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dO/dIcLU4UrEWRYNP8worgvjS2fDG6114grtK8ATUpc=;
        b=USOBNKSoc8zgyXxqKw2N79ITmJY8Fl935WLOeELNGip6U6T8Dh75jKZsmZQslnY8W9
         va06L6tmLQGCUmv1/qx2pQmiTJgDe9Zg6kyAS5jDdWzQShnDDTeEY2M7JF0inb8rJIEU
         sSeVl3sslBtNmk2fP3zh9V23VpUa3gWhWpY8x4vPgRs3RoOUt9A8GH9fzyqsL/sy0K+7
         laBASpa8P5DCVGyHORHh+4O3H1GW2COFGJj2l1fNQXyOT4wB/nN9u0joQegj1OlHzl0c
         4c3fdd2oQ0koo5P9/dTNBpZDdkstpwsCpys5Xcrqs64bXVAa80AJHdBdT2agJfS2Ir6t
         IWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693955186; x=1694559986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dO/dIcLU4UrEWRYNP8worgvjS2fDG6114grtK8ATUpc=;
        b=Q7xBAlvUIHHXqXF1r8EUcxKM/jQ2QyY4DL2uCCM8cV4wmQw/y+p2+Z0eErDFZAfeRl
         sJxxd6s8Qr2PnWwj2KB/KKJ9aBh9213KqWRp7oGrd/iufmzfVxE5K+HBEsc2QZK+8nG7
         lMrphoKrW2zdLDiO8XJtGH36CuHJte3Yet4VDn+iGOZhddM9ByqIVA+xT/c8LdMpl3F4
         L9qu3rEBruRUHokxaU+StbgYb6PKggiMNAZWFYZ0kpQ3UP9Z+GRk/8H5jbj0JNou3HKZ
         mYiOsIx2HIef+Dwe2qaSSF+/dZpST161FwUopkUOTQV6sdf8UsKB5PwcFNBVOB4T4sFz
         vRYA==
X-Gm-Message-State: AOJu0YxcBQDgElUe0O9GhhnGd7tyqT+CmhE1nfC+AcE6r4K1jxNnMZFy
        PXRE0yR1vIpLZ0DpQiLstHw/9e3motUqprZlNNo=
X-Google-Smtp-Source: AGHT+IGi4exKmtuxmoPipzJLXqM/ad3tO/t+gcfoH7IB0Pe/nikdOzrtE04yJHW1SDWAq/fGD0xdyg==
X-Received: by 2002:a17:90a:43e4:b0:26b:6a2f:7d90 with SMTP id r91-20020a17090a43e400b0026b6a2f7d90mr11194046pjg.23.1693955186057;
        Tue, 05 Sep 2023 16:06:26 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a035d00b00264040322desm10487241pjf.40.2023.09.05.16.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 16:06:25 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qdf7l-00BLP2-3B;
        Wed, 06 Sep 2023 09:06:22 +1000
Date:   Wed, 6 Sep 2023 09:06:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     ksummit@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZPe0bSW10Gj7rvAW@dread.disaster.area>
References: <ZO9NK0FchtYjOuIH@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO9NK0FchtYjOuIH@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 30, 2023 at 04:07:39PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> we have a lot of on-disk file system drivers in Linux, which I consider
> a good thing as it allows a lot of interoperability.  At the same time
> maintaining them is a burden, and there is a lot expectation on how
> they are maintained.
> 
> Part 1: untrusted file systems
> 
> There has been a lot of syzbot fuzzing using generated file system
> images, which I again consider a very good thing as syzbot is good
> a finding bugs.  Unfortunately it also finds a lot of bugs that no
> one is interested in fixing.   The reason for that is that file system
> maintainers only consider a tiny subset of the file system drivers,
> and for some of them a subset of the format options to be trusted vs
> untrusted input.  It thus is not just a waste of time for syzbot itself,
> but even more so for the maintainers to report fuzzing bugs in other
> implementations.
> 
> What can we do to only mark certain file systems (and format options)
> as trusted on untrusted input and remove a lot of the current tension
> and make everyone work more efficiently?  Note that this isn't even
> getting into really trusted on-disk formats, which is a security
> discussion on it's own, but just into formats where the maintainers
> are interested in dealing with fuzzed images.

I think this completely misses the point of contention of the larger
syzbot vs filesystem discussion: the assertion that "testing via
syzbot means the subsystem is secure" where "secure" means "can be
used safely for operations that involve trust model violations".

Fundamentally, syzbot does nothing to actually validate the
filesystem is "secure". Fuzzing can only find existing bugs by
simulating an attacker, but it does nothing to address the
underlying issues that allow that attack channel to exist.

All "syzbot doesn't find bugs" means is that -random bit
manipulation- of the filesystem's metadata *hasn't found issues*.

Even though the XFS V5 format is pretty robust against random bit
manipulation, it's certainly not invulnerable and cannot detect
coordinated, multiple object corruptions (cross linked blocks,
cycles in trees, etc) without a full filesystem scan. These sorts of
corruptions are almost never going to be exercised by random bit
manipulation fuzzers like syzbot, but they are exactly the sort of
thing a malicious attacker with some knowledge of how the filesystem
works would look at....

Let's also address the elephant in the room: malicious attackers
don't need to to exploit flaws in the filesystem metadata structure
to trojan an unsuspecting user.

i.e. We cannot detect changes to metadata that are within valid
bounds and may be security sensitive - things like UIDs and GIDs,
inode permissions, inode flags, link counts, symbolic links, etc. We
also can't determine if the file data is unchanged, so it's easy to
trojan the contents of an executable file on a filesystem image.

IOWs, all the attacker needs to do is trojan an installer script on
an application or device driver disk/image, and the user will run it
as root themselves....

There are whole classes of malicious modifications that syzbot
doesn't exercise and we cannot detect nor defend against at the
filesystem level without changing the trust model the filesystem
operates under. And if we change the trust model, we are now talking
about on-disk format changes and using robust crypto for all the
data and metadata in the filesystem. At which point, we may as well
require a full disk encryption layer via dm-crypt....

If we say "filesystem is secure against untrusted input" then that
is what users will expect us to provide. It will also means that
every bug that syzbot might find will result in a high priority CVE,
because any issue arising from untrusted input is a now a major
system security issue.

As such, I just don't see how "tested with syzbot" equates with
"safe for untrusted use cases" whilst also reducing the impact of
the problems that syzbot finds and reports...

> Part 2: unmaintained file systems
> 
> A lot of our file system drivers are either de facto or formally
> unmaintained.  If we want to move the kernel forward by finishing
> API transitions (new mount API, buffer_head removal for the I/O path,
> ->writepage removal, etc) these file systems need to change as well
> and need some kind of testing.  The easiest way forward would be
> to remove everything that is not fully maintained, but that would
> remove a lot of useful features.

Linus has explicitly NACKed that approach.

https://lore.kernel.org/linux-fsdevel/CAHk-=wg7DSNsHY6tWc=WLeqDBYtXges_12fFk1c+-No+fZ0xYQ@mail.gmail.com/

Which is a problem, because historically we've taken code into
the kernel without requiring a maintainer, or the people who
maintained the code have moved on, yet we don't have a policy for
removing code that is slowly bit-rotting to uselessness.

> E.g. the hfsplus driver is unmaintained despite collecting odd fixes.
> It collects odd fixes because it is really useful for interoperating
> with MacOS and it would be a pity to remove it.  At the same time
> it is impossible to test changes to hfsplus sanely as there is no
> mkfs.hfsplus or fsck.hfsplus available for Linux.  We used to have
> one that was ported from the open source Darwin code drops, and
> I managed to get xfstests to run on hfsplus with them, but this
> old version doesn't compile on any modern Linux distribution and
> new versions of the code aren't trivially portable to Linux.
> 
> Do we have volunteers with old enough distros that we can list as
> testers for this code?  Do we have any other way to proceed?
>
> If we don't, are we just going to untested API changes to these
> code bases, or keep the old APIs around forever?

We do slowly remove device drivers and platforms as the hardware,
developers and users disappear. We do also just change driver APIs
in device drivers for hardware that no-one is actually able to test.
The assumption is that if it gets broken during API changes,
someone who needs it to work will fix it and send patches.

That seems to be the historical model for removing unused/obsolete
code from the kernel, so why should we treat unmaintained/obsolete
filesystems any differently?  i.e. Just change the API, mark it
CONFIG_BROKEN until someone comes along and starts fixing it...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
