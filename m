Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53828799262
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Sep 2023 00:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344155AbjIHWrx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 18:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344147AbjIHWrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:47:53 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3D21FEA
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 15:47:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a56401c12so2212000b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Sep 2023 15:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694213268; x=1694818068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AB7ij+67VcdmSJWxuO/XtcPVtWNgt8XlNOhFpysDH2c=;
        b=0M7lf5i96NmvQ3At8WhaOZ+S50hoSeynyDl+5PEVPc5vya1UFC3JPYb6vaUSaLI2QO
         HIoSnCaI4WRk0JsW1CAYdR30ItNMOhlwLMDDgEUEAgzaa4fLPQm14UpLOuAn/hK80Z7Z
         KwdTTIOBzAijV41qho2M3diY8uWyz5TyKDBUlRvOy97ouYB9XtmTLwoTBCjwQEpUnLWF
         hbKv+viHgaOOdKAtqFnfd/UnRAMec6Tv9gMWhFyBCOCvj1QJqgl0uj6wPIRJaDkLtvAz
         5pb6qMqEa9JSfiaoypXu7dxKMT5R10Pt7Aq0eHc3lYlgDazV3fF/e259oqHlg/H+GoNi
         lMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694213268; x=1694818068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AB7ij+67VcdmSJWxuO/XtcPVtWNgt8XlNOhFpysDH2c=;
        b=ZCV7wlAqHt6VjEvI/K0+SB4skVNjASqrFGWa7Zm1UUzcK2kXV5TpnTIwzv4h0yqvDb
         oBpp9MMVYR3MESoX8zjwuK2gDlq5WPs8psKfMCLGo0lXv1g+A9npUsj0rSLZC0ltDiBA
         IAVIqsnYF3PAfjQ1cShsO47MK2c8EF/AHDT31XqcOg0jym32JinhgNOV3XPwTtplTVDH
         9L+raSq6SC8emPfu6YPxMPgUAy+2Q5jDmp/y+wiBZwcKJHcrW5rQJd/Om+MxRUbXso4E
         J1zYA+Qm2drUT6FQH7dv0hCTWJfhj5PMU6YszOHB9+b92V5BnQKB2DtMq5UwMkuCcFGX
         iExQ==
X-Gm-Message-State: AOJu0YxVk7jbKjdhHX1AyYUsFUBQMcgSrEcHe83bGpXG8sSdxmhy47UK
        CHQZHMzu1jGUn/JhRYGF8rDry3Mkq+GYv+s5nJ8=
X-Google-Smtp-Source: AGHT+IFH+8aI7kMwEC2asNhBMTwVDs74jBs+Y0T7w0TTMnV/jS0JGPx6MOeQn/QX3BdOmLX3nlF6Aw==
X-Received: by 2002:a05:6a21:271e:b0:153:8754:8a7f with SMTP id rm30-20020a056a21271e00b0015387548a7fmr3485802pzb.4.1694213268373;
        Fri, 08 Sep 2023 15:47:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id g15-20020a62e30f000000b0064fde7ae1ffsm1746584pfh.38.2023.09.08.15.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 15:47:47 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qekGO-00CejT-1G;
        Sat, 09 Sep 2023 08:47:44 +1000
Date:   Sat, 9 Sep 2023 08:47:44 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     ksummit@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZPukkAuMPi+zT2OL@dread.disaster.area>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPrhb9ncxrylmVyP@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPrhb9ncxrylmVyP@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 08, 2023 at 01:55:11AM -0700, Christoph Hellwig wrote:
> On Wed, Sep 06, 2023 at 09:06:21AM +1000, Dave Chinner wrote:
> > I think this completely misses the point of contention of the larger
> > syzbot vs filesystem discussion: the assertion that "testing via
> > syzbot means the subsystem is secure" where "secure" means "can be
> > used safely for operations that involve trust model violations".
> > 
> > Fundamentally, syzbot does nothing to actually validate the
> > filesystem is "secure". Fuzzing can only find existing bugs by
> > simulating an attacker, but it does nothing to address the
> > underlying issues that allow that attack channel to exist.
> 
> I don't think anyone makes that assertation.  Instead the assumptions
> is something that is handling untrusted input should be available to
> surive fuzzing by syzbot, and that's an assumption I agree with.  That
> doesn't imply anything surving syzbot is secure, but it if doesn't
> survive syzbot it surely can't deal with untrusted input.

Sure, but as an experienced filesystem developer who, 15 years ago,
architected and implemented a metadata verification mechanism that
effectively defeats *random bit mutation metadata fuzzing*, I am
making sure that everyone is aware that "syzbot doesn't find
problems" is not the same thing as "filesystem is safe to handle
untrusted input".

Sure, syzbot being unable to find problems is a good start, but I
know *many* ways to screw over the XFS kernel implementation by
mutating the metadata in nasty ways that we *can't actually protect
against* at runtime, and that syzbot is *never* going to stumble
across by a random walk through all the possible bit mutations that
can occur in a filesystem's metadata.

I stress this again: syzbot not finding problems does not, in any
way, imply that a filesytem implementation is safe to parse
untrusted filesystem images in a ring 0 context. Anyone who says
that "syzbot doesn't find problems, so it's good to go with
untrusted input" is completely ignoring the long standing and well
known practical limitations of the fuzzing techniques being used by
tools like syzbot...

> > > unmaintained.  If we want to move the kernel forward by finishing
> > > API transitions (new mount API, buffer_head removal for the I/O path,
> > > ->writepage removal, etc) these file systems need to change as well
> > > and need some kind of testing.  The easiest way forward would be
> > > to remove everything that is not fully maintained, but that would
> > > remove a lot of useful features.
> > 
> > Linus has explicitly NACKed that approach.
> > 
> > https://lore.kernel.org/linux-fsdevel/CAHk-=wg7DSNsHY6tWc=WLeqDBYtXges_12fFk1c+-No+fZ0xYQ@mail.gmail.com/
> 
> .. and that is why I'm bring this up in a place where we can have
> a proper procedural discussion instead of snarky remarks.  This is
> a fundamental problem we;ll need to sort out.

I agree, which is why I'm trying to make sure that everyone has the
same understanding of the situation. Allowing filesystems to parse
untrusted data in ring 0 context comes down how which filesystem
developers actually trust their code and on-disk format verification
enough to allow it to be exposed willingly to untrusted input.

Make no mistake about it: I'm not willing to take that risk with
XFS. I'm not willing to take responsibility for deciding that we
should expose XFS to untrusted code - I *know* that it isn't safe,
and it would be gross negligence for me to present the code that I
help maintain and develop any other way.

> > Which is a problem, because historically we've taken code into
> > the kernel without requiring a maintainer, or the people who
> > maintained the code have moved on, yet we don't have a policy for
> > removing code that is slowly bit-rotting to uselessness.
> 
> ... and we keep merging crap that goes against all established normal
> requirements when people things it's new and shiny and cool :(

Well, yes, but that's a separate (though somewhat related)
discussion.

The observation I'd make from your comment is that the Linux
project, as a whole, has no clearly defined feature life-cycle
process. For the purpose of this discussion, we're concerned about
the end-of-life process for removing ancient, obsolete and/or broken
code in a sane, timely manner that we are completely lacking.

A project that has been going for 30 years, and is likely to be
going for another 30 years, needs to have a well defined EOL
process. Not just for filesystems, but for everything: syscalls,
drivers, platforms, sysfs interfaces, etc.

The current process of "send an email, and if anyone shouts don't
remove it" means that as long as there's a single user left, we
can't get rid of the junk that is causing us problems right now.

That's a terrible policy. As long as a single person has something
on their shelf they want to have keep working, we're supposed to
keep it working. In the cases where the developer time to keep the
feature working outweighs the number of users, the cost/benefit
ratio is so so far on the "cost" side it is not funny.  And when it
comes to filesystems, the risk/benefit analysis is pegged as hard as
it can be against the "risk" side.

IOWs, there's a wider scope here than just "how do we manage all
these obsolete, buggy, legacy filesystems?". I points to the fact
that the Linux project itself doesn't really know how to remove old
code and features that have become a burden to ongoing
development....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
