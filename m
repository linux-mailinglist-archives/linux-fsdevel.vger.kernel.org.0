Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4891A3B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 22:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfEJUJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 16:09:42 -0400
Received: from fieldses.org ([173.255.197.46]:55510 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbfEJUJm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 16:09:42 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 19F5C63E; Fri, 10 May 2019 16:09:41 -0400 (EDT)
Date:   Fri, 10 May 2019 16:09:41 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
Message-ID: <20190510200941.GB5349@fieldses.org>
References: <CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com>
 <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de>
 <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com>
 <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org>
 <87bm0l4nra.fsf@notabene.neil.brown.name>
 <20190503153531.GJ12608@fieldses.org>
 <87woj3157p.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87woj3157p.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 07, 2019 at 10:24:58AM +1000, NeilBrown wrote:
> Interesting perspective .... though doesn't NFSv4 explicitly allow
> client-side ACL enforcement in the case of delegations?

Not really.  What you're probably thinking of is the single ACE that the
server can return on granting a delegation, that tells the client it can
skip the ACCESS check for users matching that ACE.  It's unclear how
useful that is.  It's currently unused by the Linux client and server.

> Not sure how relevant that is....
> 
> It seems to me we have two options:
>  1/ declare the NFSv4 doesn't work as a lower layer for overlayfs and
>     recommend people use NFSv3, or
>  2/ Modify overlayfs to work with NFSv4 by ignoring nfsv4 ACLs either
>  2a/ always - and ignore all other acls and probably all system. xattrs,
>  or
>  2b/ based on a mount option that might be
>       2bi/ general "noacl" or might be
>       2bii/ explicit "noxattr=system.nfs4acl"
>  
> I think that continuing to discuss the miniature of the options isn't
> going to help.  No solution is perfect - we just need to clearly
> document the implications of whatever we come up with.
> 
> I lean towards 2a, but I be happy with with any '2' and '1' won't kill
> me.

I guess I'd also lean towards 2a.

I don't think it applies to posix acls, as overlayfs is capable of
copying those up and evaluating them on its own.

--b.

> 
> Do we have a vote?  Or does someone make an executive decision??
> 
> NeilBrown


