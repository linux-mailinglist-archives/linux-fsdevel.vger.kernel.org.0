Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF3CC095D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2019 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfI0QQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Sep 2019 12:16:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:34830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727289AbfI0QQs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Sep 2019 12:16:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2DF93AD87;
        Fri, 27 Sep 2019 16:16:46 +0000 (UTC)
Date:   Fri, 27 Sep 2019 11:16:43 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Ian Kent <raven@themaw.net>
Cc:     viro@zeniv.linux.org.uk, autofs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] Don't propagate automount
Message-ID: <20190927161643.ehahioerrlgehhud@fiona>
References: <20190926195234.bipqpw5sbk5ojcna@fiona>
 <3468a81a09d13602c67007759593ddf450f8132c.camel@themaw.net>
 <e5fbf32668aea1b8143d15ff47bd1e4309d03b17.camel@themaw.net>
 <d163042ab8fffd975a6d460488f1539c5f619eaa.camel@themaw.net>
 <7f31f0c2bf214334a8f7e855044c88a50e006f05.camel@themaw.net>
 <b2443a28939d6fe79ec9aa9d983f516c8269448a.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2443a28939d6fe79ec9aa9d983f516c8269448a.camel@themaw.net>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18:51 27/09, Ian Kent wrote:
> On Fri, 2019-09-27 at 15:41 +0800, Ian Kent wrote:
> > 
> > > > I initially thought this was the result of a "fix" in the mount
> > > > propagation code but it occurred to me that propagation is meant
> > > > to occur between mount trees not within them so this might be a
> > > > bug.
> > > > 
> > > > I probably should have worked out exactly what upstream kernel
> > > > this started happening in and then done a bisect and tried to
> > > > work out if the change was doing what it was supposed to.
> > > > 
> > > > Anyway, I'll need to do that now for us to discuss this sensibly.
> > > > 
> > > > > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > > > > 
> > > > > > diff --git a/fs/pnode.c b/fs/pnode.c
> > > > > > index 49f6d7ff2139..b960805d7954 100644
> > > > > > --- a/fs/pnode.c
> > > > > > +++ b/fs/pnode.c
> > > > > > @@ -292,6 +292,9 @@ int propagate_mnt(struct mount *dest_mnt,
> > > > > > struct
> > > > > > mountpoint *dest_mp,
> > > > > >  	struct mount *m, *n;
> > > > > >  	int ret = 0;
> > > > > >  
> > > > > > +	if (source_mnt->mnt_mountpoint->d_flags &
> > > > > > DCACHE_NEED_AUTOMOUNT)
> > > > > > +		return 0;
> > > > > > +
> > > > > 
> > > > > Possible problem with this is it will probably prevent mount
> > > > > propagation in both directions which will break stuff.

No, I am specifically checking when the source has a automount flag set.
It will block only one way. I checked it with an example.

> > > > > 
> > > > > I had originally assumed the problem was mount propagation
> > > > > back to the parent mount but now I'm not sure that this is
> > > > > actually what is meant to happen.
> 
> Goldwyn,
> 
> TBH I'm already a bit over this particularly since it's a
> solved problem from my POV.
> 
> I've gone back as far as Fedora 20 and 3.11.10-301.fc20 also
> behaves like this.

The problem started with the root directory being mounted as
shared.

> 
> Unless someone says this behaviour is not the way kernel
> mount propagation should behave I'm not going to spend
> more time on it.
> 
> The ability to use either "slave" or "private" autofs pseudo
> mount options in master map mount entries that are susceptible
> to this mount propagation behaviour was included in autofs-5.1.5
> and the patches used are present on kernel.org if you need to
> back port them to an earlier release.

What about "shared" pseudo mount option? The point is the default
shared option with automount is broken, and should not be exposed
at all.

> 
> https://mirrors.edge.kernel.org/pub/linux/daemons/autofs/v5/patches-5.1.5/autofs-5.1.4-set-bind-mount-as-propagation-slave.patch
> 
> https://mirrors.edge.kernel.org/pub/linux/daemons/autofs/v5/patches-5.1.5/autofs-5.1.4-add-master-map-pseudo-options-for-mount-propagation.patch
> 
> It shouldn't be too difficult to back port them but they might
> have other patch dependencies. I will help with that if you
> need it.

My problem is not with the patch and the "private" or "slave" flag, but
with the absence of it. We have the patch you mention in our repos.

I am assuming that users are stupid and they will miss putting the flags
in the auto.master file and wonder why when they try to access the directories
the process hangs. In all, any user configuration should not hang the kernel.

My point is, if you don't have a automount map with the daemon, how can you
propagate it and still be in control?

I tried my experiments with 5.3.1 without "slave" or "private" flags and the
process accessing the bind mount hangs.


-- 
Goldwyn
