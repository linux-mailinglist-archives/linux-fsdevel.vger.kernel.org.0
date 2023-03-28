Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916F86CB8D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 09:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjC1H5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 03:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC1H5p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:57:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7D8DB;
        Tue, 28 Mar 2023 00:57:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A820BCE1BB1;
        Tue, 28 Mar 2023 07:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40664C4339B;
        Tue, 28 Mar 2023 07:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679990260;
        bh=nDClLR3HbEHHb15bcJCKN0Qibc9ecvk0KMx69ATl9yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUFtPl3gRw4IuULWX75KXvwq4zQmIZ+QG6coQnyZG0j2eh5Ov6xUPOhcxcTckXJ8x
         /ky/T4vRrjcFr324TPeAakzpx2/79Z7ytIC384N7kcAxd8uA/N5Sa+dYCXXLmPMXgd
         a8m0IjpJR63MEQlW83F/0ATBvQ4pOTLABFFZJVTrkeoTY/pJ7SoKJE3aPfKk2OQSdp
         3COBgS4xDWBtZv+YL+syXFZW1BLX4jwmz71uyr7Y3i99r+MPmoCx6uxan2fm6yOxoC
         1GNuwsygEZPZMwk+MkzpRsVstGUoQmb79Jomw9ypsr2fIz2HOukhZmCnbpqGvU1Zqn
         rJrgyXg9gdAww==
Date:   Tue, 28 Mar 2023 09:57:35 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
Message-ID: <20230328075735.d3rs27jjvarmn6dw@wittgenstein>
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
 <20230320115153.7n5cq4wl2hmcbndf@wittgenstein>
 <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
 <ZCJN0aaVPFouMkxp@localhost>
 <CAHk-=wgLimhZ8px+BxTvkonBGHr9oFcjrk4tmE2-_mmd3vBGdg@mail.gmail.com>
 <1CBD903C-C417-42F4-9515-551041BF6CEF@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1CBD903C-C417-42F4-9515-551041BF6CEF@joshtriplett.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 01:00:30PM +0900, Josh Triplett wrote:
> On March 28, 2023 12:32:59 PM GMT+09:00, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >Ok, just to play along - maybe you can make it slightly less
> >nonsensical by throwing O_PATH into the mix, and now an empty
> >directory file descriptor at least has *some* use.
> 
> That's the case I was thinking of: create a directory, then use exclusively *at system calls, never anything path-based. (I was using "atomic" loosely; not concerned about races here, just convenience.)
> 
> >Now your code would not only be specific to Linux, it would be
> >specific to some very new version of Linux, and do something
> >completely different on older versions.
> 
> I'm extremely not concerned with depending on current Linux. But that said...
> 
> >Because those older versions will do random things, ranging from
> >"always return an error" to "create a regular file - not a directory -
> >and then return an error anyway" and finally "create a regular file -
> >not a directory - and return that resulting fd".
> 
> ... Right, open has the un-extendable semantics, hence O_TMPFILE. Fair enough. Nevermind then.

That's not even the issue per se as most applications would probably
just be able to test whether O_DIRECTORY|O_CREAT creates and opens a
directory. It's not that we haven't had to contend with similar issues
in userspace for other syscalls before.

The bigger problem for me is that we'd be advancing from fixing the
semantics to not do completely weird/unexpected things to making it do
something that users would expect or want it to do in one big step.

Right now we're making a clean break by telling userspace EINVAL. But if
that turns out to be problematic we can easily just roll back to a
version of the old weird behavior with probably little fanfare. But if
we already introduced support for new semantics that express user's
intuition about what it's supposed to do we'll have a much harder time
and created a flame war for ourselves.

If however, EINVAL works just fine for a couple of kernel releases then
it would be - separate from the sensibility of this specific request -
another matter to make it do something else. Because at that point it's
no different from reusing deprecated bits like we did for e.g.,
CLONE_DETACHED -> CLONE_PIDFD which has exactly the same ignore unknown
or removed flags semantics as open/openat/openat2. Moving slow even in
the face of excitement about new possibilities isn't always the wrong
thing. This is one case were it isn't.
