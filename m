Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC21179998
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 21:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgCDULT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 15:11:19 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45577 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgCDULT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 15:11:19 -0500
Received: by mail-io1-f66.google.com with SMTP id w9so3809387iob.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2020 12:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=feWcOkSGkIcFQbSn/kTFYPNCri0Z0cK0YI1EBscIYk0=;
        b=hJu0KLg+QD+skHNEEjlZbawHkXSferTilONELxarAD6sB430ivo3bo/zTD62T0PwdK
         7ojrYRiaYnRWsn2nu25pkYHQrTWqW5KtDp6omvMpZfEs6hiRb7YitA0RsnrTLCGISqHq
         I29owY2MQMD7J/atnCBap1JuL3+zTp4yBdomXcstB4DIHpR9YjrE6JgKfCbLn5BzQ1+E
         7hrnPEaSqLmQN3YKTpLQrHCqxoT2EFICe66AS4oMossFeDegRggCVWNN0GHc1pdW6+E9
         5bMsx1JQd/pRFkB83JooEi3YTN56eu58LuKyo0lDM3oHHTRGR7+Gkkta8wnrc3t6giV6
         xsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=feWcOkSGkIcFQbSn/kTFYPNCri0Z0cK0YI1EBscIYk0=;
        b=anKY4D3SgylavXYx1HBy1eVh4byA2/XiqjO8Yv73vC8+10aGOlIwpfkgOHNgraS+qj
         smQJAcYRwrrA3c/mKX0Tn4Y8TAw8i2GSg6QZ+iD6tQYD8TJll8m5L5JSbT7L0yNOou4T
         /C3m9Isy4j395NKGQUaB3JW+99imZQfRTFb+p+8hrw2sWkAh4Fz5hjKpRgmNRAsR7DWV
         +UCnijLeh5ErvyNMRSoyDHfq1M57vgv3hHpY+HZT4CxtMLnkLRteWWvSziFOguQHinXa
         ABFDe/Hf+x/X6sj7CwOu0l9NvlH788hkIGUW23Ru09DrLe6v9L5+6QvUqxHGL0B+d4UX
         PQaA==
X-Gm-Message-State: ANhLgQ2GN1syKYub12O3OWs7qFoWhflF3zfOocdN2E/7FdHZQpWYxu99
        xtOoGoH7bWI44u0XjRBbjDMz+zDke74=
X-Google-Smtp-Source: ADFU+vvFLjldAN1VcQcrc2bDCf3aFCG7tm5Vts1V7Y4lJujvfJ1WV5b3TGhIVbnJ6+Hjt5fvqp8eKg==
X-Received: by 2002:a6b:fc0b:: with SMTP id r11mr3430409ioh.298.1583352677039;
        Wed, 04 Mar 2020 12:11:17 -0800 (PST)
Received: from google.com ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id i16sm4238015ioo.78.2020.03.04.12.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 12:11:16 -0800 (PST)
Date:   Wed, 4 Mar 2020 13:11:13 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ross Zwisler <zwisler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mattias Nissler <mnissler@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Raul Rangel <rrangel@google.com>,
        linux-fsdevel@vger.kernel.org,
        Benjamin Gordon <bmgordon@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v6] Add a "nosymfollow" mount option.
Message-ID: <20200304201113.GA98782@google.com>
References: <20200304173446.122990-1-zwisler@google.com>
 <20200304183829.GR23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304183829.GR23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 06:38:29PM +0000, Al Viro wrote:
> On Wed, Mar 04, 2020 at 10:34:46AM -0700, Ross Zwisler wrote:
> > From: Mattias Nissler <mnissler@chromium.org>
> > 
> > For mounts that have the new "nosymfollow" option, don't follow symlinks
> > when resolving paths. The new option is similar in spirit to the
> > existing "nodev", "noexec", and "nosuid" options, as well as to the
> > LOOKUP_NO_SYMLINKS resolve flag in the openat2(2) syscall. Various BSD
> > variants have been supporting the "nosymfollow" mount option for a long
> > time with equivalent implementations.
> > 
> > Note that symlinks may still be created on file systems mounted with
> > the "nosymfollow" option present. readlink() remains functional, so
> > user space code that is aware of symlinks can still choose to follow
> > them explicitly.
> > 
> > Setting the "nosymfollow" mount option helps prevent privileged
> > writers from modifying files unintentionally in case there is an
> > unexpected link along the accessed path. The "nosymfollow" option is
> > thus useful as a defensive measure for systems that need to deal with
> > untrusted file systems in privileged contexts.
> > 
> > More information on the history and motivation for this patch can be
> > found here:
> > 
> > https://sites.google.com/a/chromium.org/dev/chromium-os/chromiumos-design-docs/hardening-against-malicious-stateful-data#TOC-Restricting-symlink-traversal
> > 
> > Signed-off-by: Mattias Nissler <mnissler@chromium.org>
> > Signed-off-by: Ross Zwisler <zwisler@google.com>
> > ---
> > Resending v6 which was previously posted here [0].
> > 
> > Aleksa, if I've addressed all of your feedback, would you mind adding
> > your Reviewed-by?
> > 
> > Andrew, would you please consider merging this?
> 
> NAK.  It's not that I hated the patch, but I call hard moratorium on
> fs/namei.c features this cycle.
> 
> Reason: very massive rewrite of the entire area about to hit -next.
> Moreover, that rewrite is still in the "might be reordered/rebased/whatnot"
> stage.  The patches had been posted on fsdevel, along with the warning
> that it's going into -next shortly.
> 
> Folks, we are close enough to losing control of complexity in that
> code.  It needs to be sanitized, or we'll get into a state where the
> average amount of new bugs introduced by fixing an old one exceeds 1.
> 
> There had been several complexity injections into that thing over
> years (r/o bind-mounts, original RCU pathwalk merge, atomic_open,
> mount traps, openat2 to name some) and while some of that got eventually
> cleaned up, there's a lot of subtle stuff accumulated in the area.
> It can be sanitized and I am doing just that (62 commits in the local
> branch at the moment).  If that gets in the way of someone's patches -
> too fucking bad.  The stuff already in needs to be integrated properly;
> that gets priority over additional security hardening any day, especially
> since this cycle has already seen
> 	* user-triggerable oops in several years old hardening stuff
> (use-after-free, unlikely to be escalatable beyond null pointer
> dereference).  And I'm not blaming the patch authors - liveness analysis
> in do_last() as it is in mainline is a nightmare.
> 	* my own brown paperbag braino in attempt to fix that.
> Fortunately that one was easily caught by fuzzers and it was trivial to fix
> once found.  Again, liveness analysis (and data invariants) from hell...
> 	* gaps in LOOKUP_NO_XDEV (openat2 series, just merged).  Missed
> on review.  Reason: several places implementing mount crossing, with
> varying amount of divergence between them.  One got missed...
> 	* rather interesting corner cases of aushit vs. open vs. NFS.
> Fairly old ones, at that.  Still sorting that one out...
> 
> Anyway, the bottom line is: leave fs/namei.c (especially around the
> pathwalk-related code) alone for now.  Or work on top of the posted
> series, but expect it to change quite a bit under you.  Trying to
> dump that fun job on akpm is unlikely to work.  And if all of that
> comes as a surprise since you are not following fsdevel, consider
> doing so in the future, please.
> 
> PS:
> al@dizzy:~/linux/trees/vfs$ git diff --stat v5.6-rc1..HEAD fs/namei.c
>  fs/namei.c | 1408 +++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------
>  1 file changed, 597 insertions(+), 811 deletions(-)
> al@dizzy:~/linux/trees/vfs$ wc -l fs/namei.c
> 4723 fs/namei.c
> 
> The affected area is almost exclusively in core pathname resolution
> code.

Makes sense, thank you for the response.
