Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583012E20E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 20:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgLWTa3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 14:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgLWTa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 14:30:29 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB9CC061794
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Dec 2020 11:29:43 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id x15so140757ilq.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Dec 2020 11:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GO51UVUTNvBhCJQD69obTiRmEahl2WX/DtgMyfCh1aI=;
        b=umJvLbgabVKE8NNhribeB3Mj6CL5aAY9F2WgopT7biHDRcoOldyYTms3ycziT26qQg
         P/kXz1hRLNT/c/2MSX9QidYbgghCvG1gzH9BMOUcaNgrU+AUO2svFTveIGmWm/KhLYeG
         s7Y0jLEyONdRTDgzkLpKdIWWRoJOBg1zkOagU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GO51UVUTNvBhCJQD69obTiRmEahl2WX/DtgMyfCh1aI=;
        b=nMPk6mlBKWFuXMbpiy2k6QN+rcKPhqMrFVun75s/bISG8SinbTWVFlSvfHcKE8V9UP
         hVZ+09uxu4kz6UucNOy/vwdqAhyjCK1QWT1ziEXN4mFSnYCgGSek3bm1KN3oLYRctY3X
         +ymQXtE5btMESQ1RTOkFzedXVLKLQMQ1BGjJZ9aMazi64OypZTKxb9BeZMsJHyG/AvJJ
         bVFPRy19GV4oWE5cjwciy4FqQwDMRStKXXX5//Q+mpgTssC7Dnw5Bf7lJRqLisPKfhq0
         DPxN1uWF8UR8/EhpqMfVvSq3sgUmMpdkM170FNu7AeO7G+u323DVI018WQ8E1Mra89aQ
         Omfw==
X-Gm-Message-State: AOAM533XmKTWP93p+lx1B1vd8V9Is9htkXpLRqwTUMdQp/ByYYCg+gTA
        RB52AzWENIg+8Ayy2+ZzyS64Bg==
X-Google-Smtp-Source: ABdhPJxgVI0N51a4lmloOWZTPdlTyDr3h7eUWimFnjN0UoZ0lBJsf8GBs9hacFiqk8YOuJmal1g4eA==
X-Received: by 2002:a92:bd04:: with SMTP id c4mr27471004ile.158.1608751782751;
        Wed, 23 Dec 2020 11:29:42 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id n77sm26473525iod.48.2020.12.23.11.29.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Dec 2020 11:29:42 -0800 (PST)
Date:   Wed, 23 Dec 2020 19:29:41 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        jlayton@kernel.org, amir73il@gmail.com, miklos@szeredi.hu,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201221195055.35295-1-vgoyal@redhat.com>
 <20201221195055.35295-4-vgoyal@redhat.com>
 <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223185044.GQ874@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223185044.GQ874@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 23, 2020 at 06:50:44PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 23, 2020 at 06:20:27PM +0000, Sargun Dhillon wrote:
> > I fail to see why this is neccessary if you incorporate error reporting into the 
> > sync_fs callback. Why is this separate from that callback? If you pickup Jeff's
> > patch that adds the 2nd flag to errseq for "observed", you should be able to
> > stash the first errseq seen in the ovl_fs struct, and do the check-and-return
> > in there instead instead of adding this new infrastructure.
> 
> You still haven't explained why you want to add the "observed" flag.


In the overlayfs model, many users may be using the same filesystem (super block)
for their upperdir. Let's say you have something like this:

/workdir [Mounted FS]
/workdir/upperdir1 [overlayfs upperdir]
/workdir/upperdir2 [overlayfs upperdir]
/workdir/userscratchspace

The user needs to be able to do something like:
sync -f ${overlayfs1}/file

which in turn will call sync on the the underlying filesystem (the one mounted 
on /workdir), and can check if the errseq has changed since the overlayfs was
mounted, and use that to return an error to the user.

If we do not advance the errseq on the upperdir to "mark it as seen", that means 
future errors will not be reported if the user calls sync -f ${overlayfs1}/file,
because errseq will not increment the value if the seen bit is unset.

On the other hand, if we mark it as seen, then if the user calls sync on 
/workdir/userscratchspace/file, they wont see the error since we just set the 
SEEN flag.

You need a new flag (observed) to differentiate between "Seen and reported to 
user" versus "seen by a second-order system, so should now increment".

One alternative is to always increment the errseq error counter, but I've
gotta imagine there's a reason that wasn't done in the first place.
