Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24CC4E0D1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 22:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389246AbfJVULf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 16:11:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42716 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387645AbfJVULf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:11:35 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iN0V9-0007Ux-9U; Tue, 22 Oct 2019 20:11:31 +0000
Date:   Tue, 22 Oct 2019 21:11:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wugyuan@cn.ibm.com, jlayton@kernel.org, hsiangkao@aol.com,
        Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RESEND 1/1] vfs: Really check for inode ptr in lookup_fast
Message-ID: <20191022201131.GZ26530@ZenIV.linux.org.uk>
References: <20190927044243.18856-1-riteshh@linux.ibm.com>
 <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com>
 <20191022143736.GX26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022143736.GX26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 22, 2019 at 03:37:36PM +0100, Al Viro wrote:
> On Tue, Oct 22, 2019 at 07:08:54PM +0530, Ritesh Harjani wrote:
> > I think we have still not taken this patch. Al?

> You've picked the easiest one to hit, but on e.g. KVM setups you can have the
> host thread representing the CPU where __d_set_inode_and_type() runs get
> preempted (by the host kernel), leaving others with much wider window.
> 
> Sure, we can do that to all callers of d_is_negative/d_is_positive, but...
> the same goes for any places that assumes that d_is_dir() implies that
> the sucker is positive, etc.
> 
> What we have guaranteed is
> 	* ->d_lock serializes ->d_flags/->d_inode changes
> 	* ->d_seq is bumped before/after such changes
> 	* positive dentry never changes ->d_inode as long as you hold
> a reference (negative dentry *can* become positive right under you)
> 
> So there are 3 classes of valid users: those holding ->d_lock, those
> sampling and rechecking ->d_seq and those relying upon having observed
> the sucker they've pinned to be positive.
> 
> What you've been hitting is "we have it pinned, ->d_flags says it's
> positive but we still observe the value of ->d_inode from before the
> store to ->d_flags that has made it look positive".

Actually, your patch opens another problem there.  Suppose you make
it d_really_is_positive() and hit the same race sans reordering.
Dentry is found by __d_lookup() and is negative.  Right after we
return from __d_lookup() another thread makes it positive (a symlink)
- ->d_inode is set, d_really_is_positive() becomes true.  OK, on we
go, pick the inode and move on.  Right?  ->d_flags is still not set
by the thread that made it positive.  We return from lookup_fast()
and call step_into().  And get to
        if (likely(!d_is_symlink(path->dentry)) ||
Which checks ->d_flags and sees the value from before the sucker
became positive.  IOW, d_is_symlink() is false here.  If that
was the last path component and we'd been told to follow links,
we will end up with positive dentry of a symlink coming out of
pathname resolution.

Similar fun happens if you have mkdir racing with lookup - ENOENT
is what should've happened if lookup comes first, success - if
mkdir does.  This way we can hit ENOTDIR, due to false negative
from d_can_lookup().

IOW, d_really_is_negative() in lookup_fast() will paper over
one of oopsen, but it
	* won't cover similar oopsen on other codepaths and
	* will lead to bogus behaviour.

I'm not sure that blanket conversion of d_is_... to smp_load_acquire()
is the right solution; it might very well be that we need to do that
only on a small subset of call sites, lookup_fast() being one of
those.  But we do want at least to be certain that something we'd
got from lookup_fast() in non-RCU mode already has ->d_flags visible.

I'm going through the callers right now, will post a followup once
the things get cleaner...
