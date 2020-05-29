Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BCB1E891F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 22:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgE2Uqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 16:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgE2Uqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 16:46:32 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC850C03E969;
        Fri, 29 May 2020 13:46:31 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeltc-0007t1-Jn; Fri, 29 May 2020 20:46:29 +0000
Date:   Fri, 29 May 2020 21:46:28 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dlmfs: convert dlmfs_file_read() to copy_to_user()
Message-ID: <20200529204628.GI23230@ZenIV.linux.org.uk>
References: <20200529000345.GV23230@ZenIV.linux.org.uk>
 <20200529000419.4106697-1-viro@ZenIV.linux.org.uk>
 <20200529000419.4106697-2-viro@ZenIV.linux.org.uk>
 <CAHk-=wgnxFLm3ZTwx3XYnJL7_zPNSWf1RbMje22joUj9QADnMQ@mail.gmail.com>
 <20200529014753.GZ23230@ZenIV.linux.org.uk>
 <CAHk-=wiBqa6dZ0Sw0DvHjnCp727+0RAwnNCyA=ur_gAE4C05fg@mail.gmail.com>
 <20200529031036.GB23230@ZenIV.linux.org.uk>
 <CAHk-=wgM0KbsiYd+USqbiDgW8WyvAFMfLXMgebc7Z+-Q6WjZqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgM0KbsiYd+USqbiDgW8WyvAFMfLXMgebc7Z+-Q6WjZqQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 08:42:25PM -0700, Linus Torvalds wrote:

> >         struct sigset_argpack argpack = { NULL, 0 };
> >
> >         if (get_sigset_argpack(sig, &argpack))
> >                 return -EFAULT;
> 
> and now you can use "argpack.sigset" and "argpack.sigset_size".
> 
> No?
> 
> Same exact deal for the compat case, where you'd just need that compat
> struct (using "compat_uptr_t" and "compat_size_t"), and then
> 
> >         struct compat_sigset_argpack argpack = { 0, 0 };
> >
> > +       if (get_compat_sigset_argpack(sig, &argpack))
> > +               return -EFAULT;
> 
> and then you use the result with "compat_ptr(argpack.sigset)" and
> "argpack.sigset_size".
> 
> Or did I mis-read anything and get confused by that code in your patch?

Umm...  I'd been concerned about code generation, but it actually gets
split into a pair of scalars just fine...

Al, trying to resist the temptation to call those struct bad_idea and
struct bad_idea_32...

All jokes aside, when had we (or anybody else, really) _not_ gotten
into trouble when passing structs across the kernel boundary?  Sure,
sometimes you have to (stat, for example), but just look at the amount
of PITA stat() has spawned...
