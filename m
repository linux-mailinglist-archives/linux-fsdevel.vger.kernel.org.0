Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0DE13124
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 17:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfECP1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 11:27:03 -0400
Received: from fieldses.org ([173.255.197.46]:54374 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfECP1D (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 11:27:03 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 8AC291CC9; Fri,  3 May 2019 11:27:02 -0400 (EDT)
Date:   Fri, 3 May 2019 11:27:02 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "Goetz, Patrick G" <pgoetz@math.utexas.edu>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        NeilBrown <neilb@suse.com>, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
Message-ID: <20190503152702.GI12608@fieldses.org>
References: <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org>
 <87bm0l4nra.fsf@notabene.neil.brown.name>
 <CAOQ4uxjYEjqbLcVYoUaPzp-jqY_3tpPBhO7cE7kbq63XrPRQLQ@mail.gmail.com>
 <875zqt4igg.fsf@notabene.neil.brown.name>
 <8f3ba729-ed44-7bed-5ff8-b962547e5582@math.utexas.edu>
 <CAHc6FU4czPQ8xxv5efvhkizU3obpV_05VEWYKydXDDDYcp8j=w@mail.gmail.com>
 <31520294-b2cc-c1cb-d9c5-d3811e00939a@math.utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31520294-b2cc-c1cb-d9c5-d3811e00939a@math.utexas.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 02, 2019 at 05:51:12PM +0000, Goetz, Patrick G wrote:
> 
> 
> On 5/2/19 12:44 PM, Andreas Gruenbacher wrote:
> > On Thu, 2 May 2019 at 19:27, Goetz, Patrick G <pgoetz@math.utexas.edu> wrote:
> >> On 5/1/19 10:57 PM, NeilBrown wrote:
> >>> Support some day support for nfs4 acls were added to ext4 (not a totally
> >>> ridiculous suggestion).  We would then want NFS to allow it's ACLs to be
> >>> copied up.
> >>
> >> Is there some reason why there hasn't been a greater effort to add NFSv4
> >> ACL support to the mainstream linux filesystems?  I have to support a
> >> hybrid linux/windows environment and not having these ACLs on ext4 is a
> >> daily headache for me.
> > 
> > The patches for implementing that have been rejected over and over
> > again, and nobody is working on them anymore.
> > 
> > Andreas
> 
> That's the part I don't understand -- why are the RichACL patches being 
> rejected?

Looking back through old mail....:

	http://lkml.kernel.org/r/20160311140134.GA14808@infradead.org

	For one I still see no reason to merge this broken ACL model at
	all.  It provides our actualy Linux users no benefit at all,
	while breaking a lot of assumptions, especially by adding allow
	and deny ACE at the same sime.

	It also doesn't help with the issue that the main thing it's
	trying to be compatible with (Windows) actually uses a
	fundamentally different identifier to apply the ACLs to - as
	long as you're still limited to users and groups and not guids
	we'll still have that mapping problem anyway.

Christoph also had some objections to the implementation which I think
were addressed, but I could be wrong.

--b.
