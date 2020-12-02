Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D272CB2D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 03:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgLBCaN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 21:30:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:15224 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgLBCaN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 21:30:13 -0500
IronPort-SDR: nNGMQln6PDP1wT6Cd06CN9f9B6u6As7FmYMzMfgVwk/hUMp1F+40m3+XKD4sqKzaiJMP5v9uqf
 srX0BWBB9XeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="172158178"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="172158178"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 18:29:28 -0800
IronPort-SDR: tCo34gc8ONvympmjsivSknXt9rfuyemtxoJ1Hc4I2vCYiAYx7LYr4TwplrxLtN5gDjILu/TAEh
 TPD+jF8tJggg==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="549838785"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 18:29:26 -0800
Date:   Tue, 1 Dec 2020 18:29:26 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH 2/2] statx: move STATX_ATTR_DAX attribute handling to
 filesystems
Message-ID: <20201202022926.GA1455515@iweiny-DESK2.sc.intel.com>
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com>
 <20201201173905.GI143045@magnolia>
 <20201201205243.GK2842436@dread.disaster.area>
 <9ab51770-1917-fc05-ff57-7677f17b6e44@sandeen.net>
 <CAHk-=wjymrd42E6XfiXwR3NF5Fs4EhTzhUukCojEWpz0Vagvtw@mail.gmail.com>
 <15fd1754-371d-88ff-c60b-6635a2da0b13@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15fd1754-371d-88ff-c60b-6635a2da0b13@sandeen.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 04:26:43PM -0600, Eric Sandeen wrote:
> On 12/1/20 4:12 PM, Linus Torvalds wrote:
> > On Tue, Dec 1, 2020 at 2:03 PM Eric Sandeen <sandeen@sandeen.net> wrote:
> >>
> >> That's why I was keen to just add DAX unconditionally at this point, and if we want
> >> to invent/refine meanings for the mask, we can still try to do that?
> > 
> > Oh Gods.  Let's *not* make this some "random filesystem choice" where
> > now semantics depends on what some filesystem decided to do, and
> > different filesystems have very subtly different semantics.
> 
> Well, I had hoped that refinement might start with the interface
> documentation, I'm certainly not suggesting every filesystem should go
> its own way.
> > This all screams "please keep this in the VFS layer" so that we at
> > least have _one_ place where these kinds of decisions are made.
> 
> Making the "right decision" depends on what the mask actually means,
> I guess.
> 
> Today we set a DAX attribute in statx which is not set in the mask.
> That seems clearly broken.

Yes...  and no.  You can't set the statx DAX flag directly.  It is only an
indicator of the current file state.  That state is affected by the
inode mode and the DAX mount option.

But I agree that having a bit set when the corresponding mask is 0 is odd.

> 
> We can either leave that as it is, set DAX in the mask for everyone in
> the VFS, or delegate that mask-setting task to the individual filesystems
> so that it reflects <something>, probably "can this inode ever be in dax
> mode?"
> 
> I honestly don't care if we keep setting the attribute itself in the VFS;
> if that's the right thing to do, that's fine.  (If so, it seems like
> IS_IMMUTABLE -> STATX_ATTR_IMMUTABLE etc could be moved there, too.)

The reason I put it in the VFS layer was that the statx was intended to be a
VFS indication of the state of the inode.  This differs from the FS_XFLAG_DAX
which is a state of the on-disk inode.  The VFS IS_DAX can be altered by the
mount option forcing DAX or no-DAX.

So there was a reason for having it at that level.

But it is true that only FS's which support DAX will ever set IS_DAX() and
having the attribute set near the mask probably makes the code a bit more
clear.

So I'm not opposed to the patch either.  But users can't ever set the flag
directly so I'm not sure if it being in the mask is going to confuse anyone.

Ira

> 
> -Eric
