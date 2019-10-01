Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAC25C40B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 21:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfJATJW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 15:09:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:54880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726626AbfJATJW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 15:09:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56ADDAEA1;
        Tue,  1 Oct 2019 19:09:19 +0000 (UTC)
Date:   Tue, 1 Oct 2019 14:09:16 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Ian Kent <raven@themaw.net>
Cc:     viro@zeniv.linux.org.uk, autofs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] Don't propagate automount
Message-ID: <20191001190916.fxko7vjcjsgzy6a2@fiona>
References: <20190926195234.bipqpw5sbk5ojcna@fiona>
 <3468a81a09d13602c67007759593ddf450f8132c.camel@themaw.net>
 <e5fbf32668aea1b8143d15ff47bd1e4309d03b17.camel@themaw.net>
 <d163042ab8fffd975a6d460488f1539c5f619eaa.camel@themaw.net>
 <7f31f0c2bf214334a8f7e855044c88a50e006f05.camel@themaw.net>
 <b2443a28939d6fe79ec9aa9d983f516c8269448a.camel@themaw.net>
 <20190927161643.ehahioerrlgehhud@fiona>
 <f0849206eff7179c825061f4b96d56c106c4eb66.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0849206eff7179c825061f4b96d56c106c4eb66.camel@themaw.net>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ian,

Sorry for the late reply, I had to setup and environment for your
specific case and it took time.

On  9:47 28/09, Ian Kent wrote:
> On Fri, 2019-09-27 at 11:16 -0500, Goldwyn Rodrigues wrote:
> > On 18:51 27/09, Ian Kent wrote:
> > > On Fri, 2019-09-27 at 15:41 +0800, Ian Kent wrote:
> > > > > > I initially thought this was the result of a "fix" in the
> > > > > > mount
> > > > > > propagation code but it occurred to me that propagation is
> > > > > > meant
> > > > > > to occur between mount trees not within them so this might be
> > > > > > a
> > > > > > bug.
> > > > > > 
> > > > > > I probably should have worked out exactly what upstream
> > > > > > kernel
> > > > > > this started happening in and then done a bisect and tried to
> > > > > > work out if the change was doing what it was supposed to.
> > > > > > 
> > > > > > Anyway, I'll need to do that now for us to discuss this
> > > > > > sensibly.
> > > > > > 
> > > > > > > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > > > > > > 
> > > > > > > > diff --git a/fs/pnode.c b/fs/pnode.c
> > > > > > > > index 49f6d7ff2139..b960805d7954 100644
> > > > > > > > --- a/fs/pnode.c
> > > > > > > > +++ b/fs/pnode.c
> > > > > > > > @@ -292,6 +292,9 @@ int propagate_mnt(struct mount
> > > > > > > > *dest_mnt,
> > > > > > > > struct
> > > > > > > > mountpoint *dest_mp,
> > > > > > > >  	struct mount *m, *n;
> > > > > > > >  	int ret = 0;
> > > > > > > >  
> > > > > > > > +	if (source_mnt->mnt_mountpoint->d_flags &
> > > > > > > > DCACHE_NEED_AUTOMOUNT)
> > > > > > > > +		return 0;
> > > > > > > > +
> > > > > > > 
> > > > > > > Possible problem with this is it will probably prevent
> > > > > > > mount
> > > > > > > propagation in both directions which will break stuff.
> > 
> > No, I am specifically checking when the source has a automount flag
> > set.
> > It will block only one way. I checked it with an example.
> 
> I don't understand how this check can selectively block propagation?
> 
> If you have say:
> test    /       :/exports \
>         /tmp    :/exports/tmp \
>         /lib    :/exports/lib
> 
> and
> /bind	/etc/auto.exports
> 
> in /etc/auto.master
> 
> and you use say:
> 
> docker run -it --rm -v /bind:/bind:slave fedora-autofs:v1 bash
> 
> your saying the above will not propagate those offset trigger mounts
> to the parent above the /bind/test mount but will propagate them to
> the container?

Yes, It works for me. I could not find the fedora-autofs, but used
fedora image. Check both cases. The first one (vanilla) is my modified
kernel with the patch I mentioned.

[root@fedora30 ~]# cat /etc/auto.master
/bind   /etc/auto.exports 

Note, there is no options. I added -bind in the config you provided.

[root@fedora30 ~]# cat /etc/auto.exports 
test -bind   /       :/exports \
        /tmp    :/exports/tmp \
        /lib    :/exports/lib

[root@fedora30 ~]# uname -a
Linux fedora30 5.3.1vanilla+ #9 SMP Tue Oct 1 11:11:11 CDT 2019 x86_64 x86_64 x86_64 GNU/Linux
[root@fedora30 ~]# docker run -it --rm -v /bind:/bind:slave fedora bash
[root@cf881c09f90a /]# ls /bind
[root@cf881c09f90a /]# ls /bind/test
lib  tmp
[root@cf881c09f90a /]# ls /bind/test/lib
lib-file

However, on existing fedora 30 kernel..

[root@fedora30 ~]# uname -a
Linux fedora30 5.2.17-200.fc30.x86_64 #1 SMP Mon Sep 23 13:42:32 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
[root@fedora30 ~]# docker run -it --rm -v /bind:/bind:slave fedora bash
[root@0a1d4f3dc475 /]# ls /bind
[root@0a1d4f3dc475 /]# ls /bind/test
lib  tmp
[root@0a1d4f3dc475 /]# ls /bind/test/lib
<hangs>


> 
> It looks like that check is all or nothing to me?
> Can you explain a bit more.
> 
> > 
> > > > > > > I had originally assumed the problem was mount propagation
> > > > > > > back to the parent mount but now I'm not sure that this is
> > > > > > > actually what is meant to happen.
> > > 
> > > Goldwyn,
> > > 
> > > TBH I'm already a bit over this particularly since it's a
> > > solved problem from my POV.
> > > 
> > > I've gone back as far as Fedora 20 and 3.11.10-301.fc20 also
> > > behaves like this.
> > 
> > The problem started with the root directory being mounted as
> > shared.
> 
> The change where systemd set the root file system propagation
> shared was certainly an autofs pain point (for more than just
> this case too) but I was so sure that wasn't when this started
> happening.
> 
> But ok, I could be mistaken, and you seem to be sure about.

Well, it might as well be with the propagation code. I am not sure
what introduced this.

> 
> > 
> > > Unless someone says this behaviour is not the way kernel
> > > mount propagation should behave I'm not going to spend
> > > more time on it.
> > > 
> > > The ability to use either "slave" or "private" autofs pseudo
> > > mount options in master map mount entries that are susceptible
> > > to this mount propagation behaviour was included in autofs-5.1.5
> > > and the patches used are present on kernel.org if you need to
> > > back port them to an earlier release.
> > 
> > What about "shared" pseudo mount option? The point is the default
> > shared option with automount is broken, and should not be exposed
> > at all.
> 
> What about shared mounts?
> 
> I don't know of a case where propagation shared is actually needed.
> If you know of one please describe it.

No, I don't have a use case for shared mounts. I am merely trying to
emphasize the default option (which behaves as shared) is broken.

> 
> The most common case is "slave" and the "private" option was only
> included because it might be needed if people are using isolated
> environments but TBH I'm not at all sure it could actually be used
> for that case.
> 
> IIUC the change to the propagation of the root file system was
> done to help with containers but turned out not to do what was
> needed and was never reverted. So the propagation shared change
> probably should have been propagation slave or not changed at
> all.

I agree. I am also worried of the swelling /proc/mounts because
of this.

> 
> > 
> > > https://mirrors.edge.kernel.org/pub/linux/daemons/autofs/v5/patches-5.1.5/autofs-5.1.4-set-bind-mount-as-propagation-slave.patch
> > > 
> > > https://mirrors.edge.kernel.org/pub/linux/daemons/autofs/v5/patches-5.1.5/autofs-5.1.4-add-master-map-pseudo-options-for-mount-propagation.patch
> > > 
> > > It shouldn't be too difficult to back port them but they might
> > > have other patch dependencies. I will help with that if you
> > > need it.
> > 
> > My problem is not with the patch and the "private" or "slave" flag,
> > but
> > with the absence of it. We have the patch you mention in our repos.
> 
> Ha, play on words, "absence of it" and "we have it in our repos"

I meant, Absence of "private" or "slave" flags.

> 
> Don't you mean the problem is that mount propagation isn't
> set correctly automatically by automount.
> 
> > 
> > I am assuming that users are stupid and they will miss putting the
> > flags
> > in the auto.master file and wonder why when they try to access the
> > directories
> > the process hangs. In all, any user configuration should not hang the
> > kernel.
> 
> I thought about that when I was working on those patches but,
> at the time, I didn't think the propagation problem had started
> when the root file system was set propagation shared at boot.
> 
> I still think changing the kernel propagation isn't the right
> way to resolve it.
> 
> But I would be willing to add a configuration option to autofs
> that when set would use propagation slave for all bind mounts
> without the need to modify the master map. Given how long the
> problem has been around I'm also tempted to make it default
> to enabled.
> 
> I'm not sure yet what that would mean for the existing mount
> options "shared" and "private" other than them possibly being
> needed if the option is disabled, even with this I'm still not
> sure a "shared" option is useful.
> 
> Isn't this automation your main concern?
> 

My main concerns is a user space configuration should not hang
the process.

This is a problem for people upgrading their kernel/systemd
and finding their processes hanging.

I am fine with making the change in user space automount daemon keeping
slave mounts as default, but then you would leave out a small security
window where users can hang the accessing process by modifying/replacing
automount.

-- 
Goldwyn
