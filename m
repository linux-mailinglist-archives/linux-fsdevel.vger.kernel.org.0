Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E6E359B61
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 12:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbhDIKKK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 06:10:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:56094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234514AbhDIKIZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:08:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B833AF5B;
        Fri,  9 Apr 2021 10:08:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 47FB51F2B59; Fri,  9 Apr 2021 12:08:11 +0200 (CEST)
Date:   Fri, 9 Apr 2021 12:08:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: fsnotify path hooks
Message-ID: <20210409100811.GA20833@quack2.suse.cz>
References: <20210331094604.xxbjl3krhqtwcaup@wittgenstein>
 <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz>
 <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz>
 <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
 <20210408125258.GB3271@quack2.suse.cz>
 <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 08-04-21 18:11:31, Amir Goldstein wrote:
> > > FYI, I tried your suggested approach above for fsnotify_xattr(),
> > > but I think I prefer to use an explicit flavor fsnotify_xattr_mnt()
> > > and a wrapper fsnotify_xattr().
> > > Pushed WIP to fsnotify_path_hooks branch. It also contains
> > > some unstashed "fix" patches to tidy up the previous hooks.
> >
> > What's in fsnotify_path_hooks branch looks good to me wrt xattr hooks.
> > I somewhat dislike about e.g. the fsnotify_create() approach you took is
> > that there are separate hooks fsnotify_create() and fsnotify_create_path()
> > which expose what is IMO an internal fsnotify detail of what are different
> > event types. I'd say it is more natural (from VFS POV) to have just a
> > single hook and fill in as much information as available... Also from
> 
> So to be clear, you do NOT want additional wrappers like this and
> you prefer to have the NULL mnt argument explicit in all callers?
> 
> static inline void fsnotify_xattr(struct dentry *dentry)
> {
>         fsnotify_xattr_mnt(NULL, dentry);
> }
> 
> For fsnotify_xattr() it does not matter so much, but fsnotify_create/mkdir()
> have quite a few callers in special filesystems.

Yes, I prefer explicit NULL mnt argument to make it obvious we are going to
miss something in this case. I agree it's going to be somewhat bigger churn
but it isn't that bad (10 + 6 callers).

> > outside view, it is unclear that e.g. vfs_create() will generate some types
> > of fsnotify events but not all while e.g. do_mknodat() will generate all
> > fsnotify events. That's why I'm not sure whether a helper like vfs_create()
> > in your tree is the right abstraction since generating one type of fsnotify
> > event while not generating another type should be a very conscious decision
> > of the implementor - basically if you have no other option.
> 
> I lost you here.

Sorry, I was probably too philosophical here ;)

> Are you ok with vfs_create() vs. vfs_create_nonotify()?

I'm OK with vfs_create_nonotify(). I have a problem with vfs_create()
because it generates inode + fs events but does not generate mount events
which is just strange (although I appreciate the technical reason behind
it :).

> How do you propose to change fsnotify hooks in vfs_create()?

So either pass 'mnt' to vfs_create() - as we discussed, this may be
actually acceptable these days due to idmapped mounts work - and generate
all events there, or make vfs_create() not generate any fsnotify events and
create new vfs_create_notify() which will take the 'mnt' and generate
events. Either is fine with me and more consistent than what you currently
propose. Thoughts?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
