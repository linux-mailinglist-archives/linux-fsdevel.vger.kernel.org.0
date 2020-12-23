Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DB22E2138
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 21:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgLWUWY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 15:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgLWUWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 15:22:23 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A74C06179C
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Dec 2020 12:21:43 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id q1so234680ilt.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Dec 2020 12:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YIp/BzkdOvytsQ2dfltPyb5qXUBQynTBvMwCQ2WlfQc=;
        b=eaGf/NZR63/J9T+0MxEFv22j+c3hPJvY2DdmuKQZGoQYGkpZGzm4mrP6XHW+v/982h
         cCMxGbMo6/j9dbsjJF5trpKHNUlrHo8RsfpEznEwj/jebMWzWmIlkYMiEqUD9kWvg1Ml
         HNDEFICvL+8Y9O8JVhsPK+cTcawSA+EMvWxz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YIp/BzkdOvytsQ2dfltPyb5qXUBQynTBvMwCQ2WlfQc=;
        b=YJkEbiJYlbpeXSVva1sAbi2IuWeDDHpspCH2IvuyzpDhqZ/ABYewlwYW0FcsFE7y0p
         EVwkJTQBbrgEIhZUFYY+o7zcU5T0rFZOBSHOfUHYqH562BhrnhmlfgLgZXNsSqmFrZaO
         IRnOxrSsL3h2VzrgaWpKIAmmpnpKzN0ipt5nZ28bRtD9ARwxHUBJCPX1ZBeuSzgOdOD7
         emV6HlUmtOAjpgoeCBTJQeBhwCi/bwuz6NHBZrVXbxpi67/8u+PjuSe4HJAzaMtAf85w
         4ei/Mgd34NaO0fl571w5Z9Q3ffhF6H4MI43l/6LLLwHct+Sq+hYYHXTIg2xN8SRY9wfb
         S1/A==
X-Gm-Message-State: AOAM530E0EQmDmAdPfPCxhVlY5RprRYnxtH5AKLiqGKdHYFDtqZ338Ln
        EdAVMvho4iLF4dc5QESeQteGHw==
X-Google-Smtp-Source: ABdhPJwJbX9fw50loVbIqJtPIKvnqXU8eAPFRgZx2132KVN4ygd+pgSFEQ7+FyYDGtda7kOaRmztpw==
X-Received: by 2002:a92:b6c7:: with SMTP id m68mr26322693ill.95.1608754902781;
        Wed, 23 Dec 2020 12:21:42 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id l6sm19034195ili.78.2020.12.23.12.21.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Dec 2020 12:21:42 -0800 (PST)
Date:   Wed, 23 Dec 2020 20:21:41 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        jlayton@kernel.org, amir73il@gmail.com, miklos@szeredi.hu,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201221195055.35295-1-vgoyal@redhat.com>
 <20201221195055.35295-4-vgoyal@redhat.com>
 <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223185044.GQ874@casper.infradead.org>
 <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223200746.GR874@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223200746.GR874@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 23, 2020 at 08:07:46PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 23, 2020 at 07:29:41PM +0000, Sargun Dhillon wrote:
> > On Wed, Dec 23, 2020 at 06:50:44PM +0000, Matthew Wilcox wrote:
> > > On Wed, Dec 23, 2020 at 06:20:27PM +0000, Sargun Dhillon wrote:
> > > > I fail to see why this is neccessary if you incorporate error reporting into the 
> > > > sync_fs callback. Why is this separate from that callback? If you pickup Jeff's
> > > > patch that adds the 2nd flag to errseq for "observed", you should be able to
> > > > stash the first errseq seen in the ovl_fs struct, and do the check-and-return
> > > > in there instead instead of adding this new infrastructure.
> > > 
> > > You still haven't explained why you want to add the "observed" flag.
> > 
> > 
> > In the overlayfs model, many users may be using the same filesystem (super block)
> > for their upperdir. Let's say you have something like this:
> > 
> > /workdir [Mounted FS]
> > /workdir/upperdir1 [overlayfs upperdir]
> > /workdir/upperdir2 [overlayfs upperdir]
> > /workdir/userscratchspace
> > 
> > The user needs to be able to do something like:
> > sync -f ${overlayfs1}/file
> > 
> > which in turn will call sync on the the underlying filesystem (the one mounted 
> > on /workdir), and can check if the errseq has changed since the overlayfs was
> > mounted, and use that to return an error to the user.
> 
> OK, but I don't see why the current scheme doesn't work for this.  If
> (each instance of) overlayfs samples the errseq at mount time and then
> check_and_advances it at sync time, it will see any error that has occurred
> since the mount happened (and possibly also an error which occurred before
> the mount happened, but hadn't been reported to anybody before).
> 

If there is an outstanding error at mount time, and the SEEN flag is unset, 
subsequent errors will not increment the counter, until the user calls sync on
the upperdir's filesystem. If overlayfs calls check_and_advance on the upperdir's
super block at any point, it will then set the seen block, and if the user calls
syncfs on the upperdir, it will not return that there is an outstanding error,
since overlayfs just cleared it.


> > If we do not advance the errseq on the upperdir to "mark it as seen", that means 
> > future errors will not be reported if the user calls sync -f ${overlayfs1}/file,
> > because errseq will not increment the value if the seen bit is unset.
> > 
> > On the other hand, if we mark it as seen, then if the user calls sync on 
> > /workdir/userscratchspace/file, they wont see the error since we just set the 
> > SEEN flag.
> 
> While we set the SEEN flag, if the file were opened before the error
> occurred, we would still report the error because the sequence is higher
> than it was when we sampled the error.
> 

Right, this isn't a problem for people calling f(data)sync on a particular file, 
because it takes its own snapshot of errseq. This is only problematic for folks 
calling syncfs. In Jeff's other messages, it sounded like this behaviour is
pretty important, and the likes of postgresql depend on it.
