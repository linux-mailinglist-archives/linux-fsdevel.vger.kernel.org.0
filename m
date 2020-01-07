Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D68CB13217B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 09:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgAGIg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 03:36:29 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41153 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbgAGIg3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:36:29 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so75409312otc.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 00:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=cOdZAX6bsGnTIchAQhLsNAwpxMUPLA3EpB3d63E+2FU=;
        b=J72Dzp2Pc1ix1KqKPjR7hkXUdNeNaqrgOczC9Unr+irRcVYW4TWdsdjfQeCeMlrwcm
         PFZ65kpnrQ6YmDjk80VwvM/SxBsNM+52Opzo7pS85kYfTYur7XsTQnHZCQbUWugsTYxR
         nxE/j6duj6rUgXeLOroyn5EBodSV9iqwcQbnGN/0v0U0fZeJjW3b/eqdZX9kizzMprD8
         Zjf8Qa5IJZ9tY73atR8Lts5nO+9GpDqq7iMrx1GJzXCPu+978yo0ntFDGhWQM3vO6zbw
         HnbubKn/hofrLDiKrmsY+rwk7Nai4NIyG/JTzGqfEbqW03PkC5x4CKQX+iS9o5O+yPNU
         AhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=cOdZAX6bsGnTIchAQhLsNAwpxMUPLA3EpB3d63E+2FU=;
        b=PfcZNcK5cMo9Ek/px/DPUTVXyuihiT36+9QD//r2ESGULugODyKPuVVjrhjGJajhj+
         5Nb4i8qil3guJGPSjt0obYyFDSQ3926TtcYp5sxuHv3VwJwMUcdvRzA8mGyvI8nqvsRR
         dl+Qq0+Wu3+QS04/t1zW2ZoTj0hxcg/PDvYlixRey0Pt3xag7wPj8HB00pEibmFRhtKO
         Zw+TuYwVuTV1V2MpHnTMaPjuHuQ/OfXNLgSQS4yPDNbDNaP/eu1ZQQknd8syu31EjpxW
         L/U1pwmMbIIKiB8z+3EEG1CXrtQQFrlxUFuUqJibfk3HAmussNdOJ8LRACual11DEaOp
         W8qw==
X-Gm-Message-State: APjAAAX//pBs8FxsRZ1KxuPSvbKtuHmaivZgrDiYrCsdsNAHOZeo8tHf
        oZWi1UN1HuF6CleKBIftoWjgQw==
X-Google-Smtp-Source: APXvYqwa8V1H3tkf/N4sgLp2gomogunghg56W/YOXDTme0MXFqTUxTyE59L0HVF+go3Zl1Y4vQ719A==
X-Received: by 2002:a9d:7c90:: with SMTP id q16mr104640629otn.191.1578386188486;
        Tue, 07 Jan 2020 00:36:28 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w12sm24922791otk.75.2020.01.07.00.36.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jan 2020 00:36:27 -0800 (PST)
Date:   Tue, 7 Jan 2020 00:36:25 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Amir Goldstein <amir73il@gmail.com>
cc:     Dave Chinner <david@fromorbit.com>,
        Chris Down <chris@chrisdown.name>,
        Linux MM <linux-mm@kvack.org>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
In-Reply-To: <CAOQ4uxjvH=UagqjHP_71_p9_dW9wKqiaWujzY1xKe7yZVFPoTA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2001070002040.1496@eggly.anvils>
References: <cover.1578225806.git.chris@chrisdown.name> <ae9306ab10ce3d794c13b1836f5473e89562b98c.1578225806.git.chris@chrisdown.name> <20200107001039.GM23195@dread.disaster.area> <20200107001643.GA485121@chrisdown.name> <20200107003944.GN23195@dread.disaster.area>
 <CAOQ4uxjvH=UagqjHP_71_p9_dW9wKqiaWujzY1xKe7yZVFPoTA@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 7 Jan 2020, Amir Goldstein wrote:
> On Tue, Jan 7, 2020 at 2:40 AM Dave Chinner <david@fromorbit.com> wrote:
> > On Tue, Jan 07, 2020 at 12:16:43AM +0000, Chris Down wrote:
> > > Dave Chinner writes:
> > > > It took 15 years for us to be able to essentially deprecate
> > > > inode32 (inode64 is the default behaviour), and we were very happy
> > > > to get that albatross off our necks.  In reality, almost everything
> > > > out there in the world handles 64 bit inodes correctly
> > > > including 32 bit machines and 32bit binaries on 64 bit machines.
> > > > And, IMNSHO, there no excuse these days for 32 bit binaries that
> > > > don't using the *64() syscall variants directly and hence support
> > > > 64 bit inodes correctlyi out of the box on all platforms.

Interesting take on it.  I'd all along imagined we would have to resort
to a mount option for safety, but Dave is right that I was too focused on
avoiding tmpfs regressions, without properly realizing that people were
very unlikely to have written such tools for tmpfs in particular, but
written them for all filesystems, and already encountered and fixed
such EOVERFLOWs for other filesystems.

Hmm, though how readily does XFS actually reach the high inos on
ordinary users' systems?

> > > >
> > > > I don't think we should be repeating past mistakes by trying to
> > > > cater for broken 32 bit applications on 64 bit machines in this day
> > > > and age.
> > >
> > > I'm very glad to hear that. I strongly support moving to 64-bit inums in all
> > > cases if there is precedent that it's not a compatibility issue, but from
> > > the comments on my original[0] patch (especially that they strayed from the
> > > original patches' change to use ino_t directly into slab reuse), I'd been
> > > given the impression that it was known to be one.
> > >
> > > From my perspective I have no evidence that inode32 is needed other than the
> > > comment from Jeff above get_next_ino. If that turns out not to be a problem,
> > > I am more than happy to just wholesale migrate 64-bit inodes per-sb in
> > > tmpfs.
> >
> > Well, that's my comment above about 32 bit apps using non-LFS
> > compliant interfaces in this day and age. It's essentially a legacy
> > interface these days, and anyone trying to access a modern linux
> > filesystem (btrfs, XFS, ext4, etc) ion 64 bit systems need to handle
> > 64 bit inodes because they all can create >32bit inode numbers
> > in their default configurations.

I thought ext4 still deals in 32-bit inos, so ext4-world would not
necessarily have caught up?  Though, arguing the other way, IIUC 64-bit
ino support comes bundled with file sizes over 2GB (on all architectures?),
and it's hard to imagine who gets by with a 2GB file size limit nowadays.

> >
> 
> Chris,
> 
> Following Dave's comment, let's keep the config option, but make it
> default to Y and remove the mount option for now.
> If somebody shouts, mount option could be re-added later.
> This way at least we leave an option for workaround for an unlikely
> breakage.

Though I don't share Dave's strength of aversion to the inode32 and
inode64 mount options, I do agree that it's preferable not to offer
them if they're so very unlikely to be necessary.

Do we even need the config option?  We certainly do need to hold the
patch with config option and mount options "in our back pocket", so
that if a regression does get reported, then upstream and stable can
respond to fix it quickly; but do we need more than that?

My main concern is that a new EOVERFLOW might not be reported as such,
and waste a lot of someone's time to track down.

Hugh
