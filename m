Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79247355AF5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 20:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbhDFSDq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 14:03:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:45500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236637AbhDFSDp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 14:03:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12718B316;
        Tue,  6 Apr 2021 18:03:36 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 2ce8a309;
        Tue, 6 Apr 2021 18:04:59 +0000 (UTC)
Date:   Tue, 6 Apr 2021 19:04:59 +0100
From:   Luis Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v5 19/19] ceph: add fscrypt ioctls
Message-ID: <YGyiy1B+BaOQihrM@suse.de>
References: <20210326173227.96363-1-jlayton@kernel.org>
 <20210326173227.96363-20-jlayton@kernel.org>
 <YGyAjn5PcG9J/07/@suse.de>
 <ee49d17b2087d0f52c38931f13e648ee7a762b4f.camel@kernel.org>
 <YGyLJcqhpU5gGjsW@suse.de>
 <dc50279dba2d46921a200fbea8bd59702504adfc.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc50279dba2d46921a200fbea8bd59702504adfc.camel@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 01:27:21PM -0400, Jeff Layton wrote:
<snip>
> > > > I've spent a few hours already looking at the bug I reported before, and I
> > > > can't really understand this code.  What does it mean to increment
> > > > ->i_shared_gen at this point?
> > > > 
> > > > The reason I'm asking is because it looks like the problem I'm seeing goes
> > > > away if I remove this code.  Here's what I'm doing/seeing:
> > > > 
> > > > # mount ...
> > > > # fscrypt unlock d
> > > > 
> > > >   -> 'd' dentry is eventually pruned at this point *if* ->i_shared_gen was
> > > >      incremented by the line above.
> > > > 
> > > > # cat d/f
> > > > 
> > > >   -> when ceph_fill_inode() is executed, 'd' isn't *not* set as encrypted
> > > >      because both ci->i_xattrs.version and info->xattr_version are both
> > > >      set to 0.
> > > > 
> > > 
> > > Interesting. That sounds like it might be the bug right there. "d"
> > > should clearly have a fscrypt context in its xattrs at that point. If
> > > the MDS isn't passing that back, then that could be a problem.
> > > 
> > > I had a concern about that when I was developing this, and I *thought*
> > > Zheng had assured us that the MDS will always pass along the xattr blob
> > > in a trace. Maybe that's not correct?
> > 
> > Hmm, that's what I thought too.  I was hoping not having to go look at the
> > MDS, but seems like I'll have to :-)
> > 
> 
> That'd be good, if possible.
> 
> > > > cat: d/f: No such file or directory
> > > > 
> > > > I'm not sure anymore if the issue is on the client or on the MDS side.
> > > > Before digging deeper, I wonder if this ring any bell. ;-)
> > > > 
> > > > 
> > > 
> > > No, this is not something I've seen before.
> > > 
> > > Dentries that live in a directory have a copy of the i_shared_gen of the
> > > directory when they are instantiated. Bumping that value on a directory
> > > should basically ensure that its child dentries end up invalidated,
> > > which is what we want once we add the key to the directory. Once we add
> > > a key, any old dentries in that directory are no longer valid.
> > > 
> > > That said, I could certainly have missed some subtlety here.
> > 
> > Great, thanks for clarifying.  This should help me investigate a little
> > bit more.
> > 
> > [ And I'm also surprised you don't see this behaviour as it's very easy to
> >   reproduce. ]
> > 
> > 
> 
> It is odd... fwiw, I ran this for 5 mins or so and never saw a problem:
> 
>     $ while [ $? -eq 0 ]; do sudo umount /mnt/crypt; sudo mount /mnt/crypt; fscrypt unlock --key=/home/jlayton/fscrypt-keyfile /mnt/crypt/d; cat /mnt/crypt/d/f; done
>

TBH I only do this operation once and it almost always fails.  The only
difference I see is that I don't really use a keyfile, but a passphrase
instead.  Not sure if it makes any difference.  Also, it may be worth
adding a delay before the 'cat' to make sure the dentry is pruned.

> ...do I need some other operations in between? Also, the cluster in this
> case is Pacific. It's possible this is a result of changes since then if
> you're on a vstart cluster or something.
> 
> $ sudo ./cephadm version
> Using recent ceph image docker.io/ceph/ceph@sha256:9b04c0f15704c49591640a37c7adfd40ffad0a4b42fecb950c3407687cb4f29a
> ceph version 16.2.0 (0c2054e95bcd9b30fdd908a79ac1d8bbc3394442) pacific (stable)

I've re-compiled the cluster after hard-resetting it to commit
6a19e303187c which you mentioned in a previous email in this thread.  But
the result was the same.

Anyway, using a vstart cluster is also a huge difference I guess.  I'll
keep debugging.  Thanks!

Cheers,
--
Luís
