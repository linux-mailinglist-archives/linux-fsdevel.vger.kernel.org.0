Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BB31CC63F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 05:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgEJDBb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 23:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726778AbgEJDBb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 23:01:31 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219D8C061A0C;
        Sat,  9 May 2020 20:01:31 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXcDW-004nLk-Ly; Sun, 10 May 2020 03:01:26 +0000
Date:   Sun, 10 May 2020 04:01:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 05/20] tomoyo_write_control(): get rid of pointless
 access_ok()
Message-ID: <20200510030126.GN23230@ZenIV.linux.org.uk>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
 <20200509234557.1124086-5-viro@ZenIV.linux.org.uk>
 <b67a5f6e-0192-f350-e797-455fe570ce93@i-love.sakura.ne.jp>
 <CAHk-=wgqyW2ow6yO+yz_0v4aKd162Lwtr24c5nKjZRG-2vW8PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgqyW2ow6yO+yz_0v4aKd162Lwtr24c5nKjZRG-2vW8PA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 09, 2020 at 05:57:56PM -0700, Linus Torvalds wrote:
> On Sat, May 9, 2020 at 5:51 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > I think that this access_ok() check helps reducing partial writes (either
> > "whole amount was processed" or "not processed at all" unless -ENOMEM).
> 
> No it doesn't.
> 
> "access_ok()" only checks the range being a valid user address range.
> 
> It doesn't actually help at all if the worry is "what if we take a
> page fault in the middle".  Because it simply doesn't check those
> kinds of things.
> 
> Now, if somebody passes actual invalid ranges (ie kernel addresses or
> other crazy stuff), they only have themselves to blame. The invalid
> range will be noticed when actually doing the user copy, and then
> you'll get EFAULT there. But there's no point in trying to figure that
> out early - it's only adding overhead, and it doesn't help any normal
> case.

It might be a good idea to add Documentation/what-access_ok-does_not ;-/
In addition to what you've mentioned,

* access_ok() does not fault anything in; never had.

* access_ok() does not verify that memory is readable/writable/there at all;
never had, except for genuine 80386 and (maybe) some of the shittier 486
clones.

* access_ok() does not protect you from the length being insanely large;
even on i386 it can pass with length being a bit under 3Gb.  If you
count upon it to prevent kmalloc() complaints about insanely large
allocation (yes, I've seen that excuse used), you are wrong.

* on a bunch of architectures access_ok() never rejects anything, and
no, that's _not_ MMU-less ones.  sparc64, for example.  Or s390, or
parisc, etc.
