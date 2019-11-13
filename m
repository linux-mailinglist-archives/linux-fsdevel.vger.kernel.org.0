Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F26BFB0D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 13:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfKMMwU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 07:52:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47772 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfKMMwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:52:20 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUs88-0001Mh-K2; Wed, 13 Nov 2019 12:52:17 +0000
Date:   Wed, 13 Nov 2019 12:52:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, wugyuan@cn.ibm.com,
        Jeff Layton <jlayton@kernel.org>,
        Gao Xiang <hsiangkao@aol.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ecryptfs@vger.kernel.org
Subject: Re: [PATCH][RFC] ecryptfs_lookup_interpose(): lower_dentry->d_inode
 is not stable
Message-ID: <20191113125216.GF26530@ZenIV.linux.org.uk>
References: <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk>
 <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
 <20191101234622.GM26530@ZenIV.linux.org.uk>
 <20191102172229.GT20975@paulmck-ThinkPad-P72>
 <20191102180842.GN26530@ZenIV.linux.org.uk>
 <20191103163524.GO26530@ZenIV.linux.org.uk>
 <20191103182058.GQ26530@ZenIV.linux.org.uk>
 <20191103185133.GR26530@ZenIV.linux.org.uk>
 <CAOQ4uxiHH=e=Y5Xb3bkv+USxE0AftHiP935GGQEKkv54E17oDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiHH=e=Y5Xb3bkv+USxE0AftHiP935GGQEKkv54E17oDA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 13, 2019 at 09:01:36AM +0200, Amir Goldstein wrote:
> > -       if (d_really_is_negative(lower_dentry)) {
> > +       /*
> > +        * negative dentry can go positive under us here - its parent is not
> > +        * locked.  That's OK and that could happen just as we return from
> > +        * ecryptfs_lookup() anyway.  Just need to be careful and fetch
> > +        * ->d_inode only once - it's not stable here.
> > +        */
> > +       lower_inode = READ_ONCE(lower_dentry->d_inode);
> > +
> > +       if (!lower_inode) {
> >                 /* We want to add because we couldn't find in lower */
> >                 d_add(dentry, NULL);
> >                 return NULL;
> 
> Sigh!
> 
> Open coding a human readable macro to solve a subtle lookup race.
> That doesn't sound like a scalable solution.
> I have a feeling this is not the last patch we will be seeing along
> those lines.
> 
> Seeing that developers already confused about when they should use
> d_really_is_negative() over d_is_negative() [1] and we probably
> don't want to add d_really_really_is_negative(), how about
> applying that READ_ONCE into d_really_is_negative() and
> re-purpose it as a macro to be used when races with lookup are
> a concern?

Would you care to explain what that "fix" would've achieved here,
considering the fact that barriers are no-ops on UP and this is
*NOT* an SMP race?

And it's very much present on UP - we have
	fetch ->d_inode into local variable
	do blocking allocation
	check if ->d_inode is NULL now
	if it is not, use the value in local variable and expect it to be non-NULL

That's not a case of missing barriers.  At all.  And no redefinition of
d_really_is_negative() is going to help - it can't retroactively affect
the value explicitly fetched into a local variable some time prior to
that.

There are other patches dealing with ->d_inode accesses, but they are
generally not along the same lines.  The problem is rarely the same...
