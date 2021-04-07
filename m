Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBF0356C81
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 14:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbhDGMsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 08:48:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233022AbhDGMsJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:48:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE2676135D;
        Wed,  7 Apr 2021 12:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617799680;
        bh=IHe3CdrXn9kgyESxdbEaXF0ihv/AkXarmdpQrlmiMHE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NoRKhJbHcysHMJtNpsm3lEpfikVCmgoXYX/M9GWiGH737ykBudax6Pfnnqw3f+tvJ
         M+7BjrkYwsIRgVLnwa48RA+d1jPUEiVlzVQT/1NacAABphIG/UQK1xJbPHO3ojjO/1
         komlBniKiAjRI0BiV4zaRg0L7aF5sPwjH/KyLRJ8lkK9tnkhjHUrhvnWI2hSrEFOkr
         Jj7I+rj5lANq71U51i43ogHKTvzoWNwyjLLEYx9otvXKlziLX3Zpi0w+snwIji3NaF
         4JO35YjPySFUE+wi/aryd6yceEA7hNNq2JDMzhp84bByZKISMStWYHVXBHypFu9TrR
         2u0ixVFUHcRGA==
Message-ID: <37ab61e4647c44a52947550db75191dc6cc94a30.camel@kernel.org>
Subject: Re: [RFC PATCH v5 19/19] ceph: add fscrypt ioctls
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 07 Apr 2021 08:47:58 -0400
In-Reply-To: <YGyiy1B+BaOQihrM@suse.de>
References: <20210326173227.96363-1-jlayton@kernel.org>
         <20210326173227.96363-20-jlayton@kernel.org> <YGyAjn5PcG9J/07/@suse.de>
         <ee49d17b2087d0f52c38931f13e648ee7a762b4f.camel@kernel.org>
         <YGyLJcqhpU5gGjsW@suse.de>
         <dc50279dba2d46921a200fbea8bd59702504adfc.camel@kernel.org>
         <YGyiy1B+BaOQihrM@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-04-06 at 19:04 +0100, Luis Henriques wrote:
> On Tue, Apr 06, 2021 at 01:27:21PM -0400, Jeff Layton wrote:
> <snip>
> > > > > I've spent a few hours already looking at the bug I reported before, and I
> > > > > can't really understand this code.  What does it mean to increment
> > > > > ->i_shared_gen at this point?
> > > > > 
> > > > > The reason I'm asking is because it looks like the problem I'm seeing goes
> > > > > away if I remove this code.  Here's what I'm doing/seeing:
> > > > > 
> > > > > # mount ...
> > > > > # fscrypt unlock d
> > > > > 
> > > > >   -> 'd' dentry is eventually pruned at this point *if* ->i_shared_gen was
> > > > >      incremented by the line above.
> > > > > 
> > > > > # cat d/f
> > > > > 
> > > > >   -> when ceph_fill_inode() is executed, 'd' isn't *not* set as encrypted
> > > > >      because both ci->i_xattrs.version and info->xattr_version are both
> > > > >      set to 0.
> > > > > 
> > > > 
> > > > Interesting. That sounds like it might be the bug right there. "d"
> > > > should clearly have a fscrypt context in its xattrs at that point. If
> > > > the MDS isn't passing that back, then that could be a problem.
> > > > 
> > > > I had a concern about that when I was developing this, and I *thought*
> > > > Zheng had assured us that the MDS will always pass along the xattr blob
> > > > in a trace. Maybe that's not correct?
> > > 
> > > Hmm, that's what I thought too.  I was hoping not having to go look at the
> > > MDS, but seems like I'll have to :-)
> > > 
> > 
> > That'd be good, if possible.
> > 
> > > > > cat: d/f: No such file or directory
> > > > > 
> > > > > I'm not sure anymore if the issue is on the client or on the MDS side.
> > > > > Before digging deeper, I wonder if this ring any bell. ;-)
> > > > > 
> > > > > 
> > > > 
> > > > No, this is not something I've seen before.
> > > > 
> > > > Dentries that live in a directory have a copy of the i_shared_gen of the
> > > > directory when they are instantiated. Bumping that value on a directory
> > > > should basically ensure that its child dentries end up invalidated,
> > > > which is what we want once we add the key to the directory. Once we add
> > > > a key, any old dentries in that directory are no longer valid.
> > > > 
> > > > That said, I could certainly have missed some subtlety here.
> > > 
> > > Great, thanks for clarifying.  This should help me investigate a little
> > > bit more.
> > > 
> > > [ And I'm also surprised you don't see this behaviour as it's very easy to
> > >   reproduce. ]
> > > 
> > > 
> > 
> > It is odd... fwiw, I ran this for 5 mins or so and never saw a problem:
> > 
> >     $ while [ $? -eq 0 ]; do sudo umount /mnt/crypt; sudo mount /mnt/crypt; fscrypt unlock --key=/home/jlayton/fscrypt-keyfile /mnt/crypt/d; cat /mnt/crypt/d/f; done
> > 
> 
> TBH I only do this operation once and it almost always fails.  The only
> difference I see is that I don't really use a keyfile, but a passphrase
> instead.  Not sure if it makes any difference.  Also, it may be worth
> adding a delay before the 'cat' to make sure the dentry is pruned.
> 

No joy. I tried different delays between 1-5s and it didn't change
anything.

> > ...do I need some other operations in between? Also, the cluster in this
> > case is Pacific. It's possible this is a result of changes since then if
> > you're on a vstart cluster or something.
> > 
> > $ sudo ./cephadm version
> > Using recent ceph image docker.io/ceph/ceph@sha256:9b04c0f15704c49591640a37c7adfd40ffad0a4b42fecb950c3407687cb4f29a
> > ceph version 16.2.0 (0c2054e95bcd9b30fdd908a79ac1d8bbc3394442) pacific (stable)
> 
> I've re-compiled the cluster after hard-resetting it to commit
> 6a19e303187c which you mentioned in a previous email in this thread.  But
> the result was the same.
> 
> Anyway, using a vstart cluster is also a huge difference I guess.  I'll
> keep debugging.  Thanks!
> 

I may try to set one up today to see if I can reproduce it. Thanks for
the testing help so far!

-- 
Jeff Layton <jlayton@kernel.org>

