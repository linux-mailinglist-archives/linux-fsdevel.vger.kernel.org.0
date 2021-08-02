Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D773DE198
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 23:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhHBVZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 17:25:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34646 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhHBVZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:25:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D996522046;
        Mon,  2 Aug 2021 21:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627939504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=flTtb6/7w0HwUmbRvIEcTdDi58G1gakn33lHELatPJc=;
        b=Y/csoegbCdDbzs4kYXj1/8GjSKxImjYIkGAnNH9jLI/OOm+Hz52ww88Cws8YKkDzB8xe4t
        ZCvkr3igTGZ9zXpeRlzh4CBIPgX5ZJ2ujDEz/QvngduiwFFzimLTZHEAs8W7ynBFSIlsaK
        AfpAD2mQyD63T3bFRsRfJjKt2Q9G4WA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627939504;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=flTtb6/7w0HwUmbRvIEcTdDi58G1gakn33lHELatPJc=;
        b=RFr0CLU/d1EG/iQETp3HG0+xER+pjE55JNAk/GC4T2Ank1QL0jecs4gRxAmCK1eDihmM21
        oZWzZNGlC9vpKtAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E4AD13CAE;
        Mon,  2 Aug 2021 21:25:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /OMCC61iCGEjBAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 02 Aug 2021 21:25:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "Linux NFS list" <linux-nfs@vger.kernel.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: A Third perspective on BTRFS nfsd subvol dev/inode number issues.
In-reply-to: <CAOQ4uxgnGWMUvtyJ0MMxMzHFwiyR68FHorDNmLSva0CdpVNNcQ@mail.gmail.com>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162742546548.32498.10889023150565429936.stgit@noble.brown>,
 <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk>,
 <162762290067.21659.4783063641244045179@noble.neil.brown.name>,
 <CAJfpegsR1qvWAKNmdjLfOewUeQy-b6YBK4pcHf7JBExAqqUvvg@mail.gmail.com>,
 <162762562934.21659.18227858730706293633@noble.neil.brown.name>,
 <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com>,
 <162763043341.21659.15645923585962859662@noble.neil.brown.name>,
 <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com>,
 <162787790940.32159.14588617595952736785@noble.neil.brown.name>,
 <YQeB3ASDyO0wSgL4@zeniv-ca.linux.org.uk>,
 <162788285645.32159.12666247391785546590@noble.neil.brown.name>,
 <CAOQ4uxgnGWMUvtyJ0MMxMzHFwiyR68FHorDNmLSva0CdpVNNcQ@mail.gmail.com>
Date:   Tue, 03 Aug 2021 07:24:58 +1000
Message-id: <162793949857.32159.8101709423759352396@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 02 Aug 2021, Amir Goldstein wrote:
> On Mon, Aug 2, 2021 at 8:41 AM NeilBrown <neilb@suse.de> wrote:
> >
> > On Mon, 02 Aug 2021, Al Viro wrote:
> > > On Mon, Aug 02, 2021 at 02:18:29PM +1000, NeilBrown wrote:
> > >
> > > > It think we need to bite-the-bullet and decide that 64bits is not
> > > > enough, and in fact no number of bits will ever be enough.  overlayfs
> > > > makes this clear.
> > >
> > > Sure - let's go for broke and use XML.  Oh, wait - it's 8 months too
> > > early...
> > >
> > > > So I think we need to strongly encourage user-space to start using
> > > > name_to_handle_at() whenever there is a need to test if two things are
> > > > the same.
> > >
> > > ... and forgetting the inconvenient facts, such as that two different
> > > fhandles may correspond to the same object.
> >
> > Can they?  They certainly can if the "connectable" flag is passed.
> > name_to_handle_at() cannot set that flag.
> > nfsd can, so using name_to_handle_at() on an NFS filesystem isn't quite
> > perfect.  However it is the best that can be done over NFS.
> >
> > Or is there some other situation where two different filehandles can be
> > reported for the same inode?
> >
> > Do you have a better suggestion?
> >
> 
> Neil,
> 
> I think the plan of "changing the world" is not very realistic.

I disagree.  It has happened before, it will happen again.  The only
difference about my proposal is that I'm suggesting the change be
proactive rather than reactive.

> Sure, *some* tools can be changed, but all of them?

We only need to change the tools that notice there is a problem.  So it
is important to minimize the effect on existing tools, even when we
cannot reduce it to zero.  We then fix things that are likely to see a
problem, or that actually do.  And we clearly document the behaviour and
how to deal with it, for code that we cannot directly affect.

Remember: there is ALREADY breakage that has been fixed.  btrfs does
*not* behave like a "normal" filesystem.  Nor does NFS.  Multiple tools
have been adjusted to work with them.  Let's not pretend that will never
happen again, but instead use the dynamic to drive evolution in the way
we choose.

> 
> I went back to read your initial cover letter to understand the
> problem and what I mostly found there was that the view of
> /proc/x/mountinfo was hiding information that is important for
> some tools to understand what is going on with btrfs subvols.

That was where I started, but not where I ended.  There are *lots* of
places that currently report inconsistent information for btrfs subvols.

> 
> Well I am not a UNIX history expert, but I suppose that
> /proc/PID/mountinfo was created because /proc/mounts and
> /proc/PID/mounts no longer provided tool with all the information
> about Linux mounts.
> 
> Maybe it's time for a new interface to query the more advanced
> sb/mount topology? fsinfo() maybe? With mount2 compatible API for
> traversing mounts that is not limited to reporting all entries inside
> a single page. I suppose we could go for some hierarchical view
> under /proc/PID/mounttree. I don't know - new API is hard.

Yes, exactly - but not just for mounts.  Yes, we need new APIs (Because
the old ones have been broken in various ways).  That is exactly what
I'm proposing.  But "fixing" mountinfo turns out to be little more than
rearranging deck-chairs on the Titanic.

> 
> In any case, instead of changing st_dev and st_ino or changing the
> world to work with file handles, why not add inode generation (and
> maybe subvol id) to statx().

The enormous benefit of filehandles is that they are supported by
kernels running today.  As others have commented, they also work over
NFS.
But I would be quite happy to see more information made available
through statx - providing the meaning of that information was clearly
specified - both what can be assumed about it and what cannot.

Thanks,
NeilBrown


> filesystem that care enough will provide this information and tools that
> care enough will use it.
> 
> Thanks,
> Amir.
> 
> 
