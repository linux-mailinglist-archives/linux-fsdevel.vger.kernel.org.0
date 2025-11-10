Return-Path: <linux-fsdevel+bounces-67641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A534DC45672
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A95A3A9A68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 08:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07672FD1BB;
	Mon, 10 Nov 2025 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIqCEH/u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B371B4F0A;
	Mon, 10 Nov 2025 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764122; cv=none; b=hfkElAtwl+frVs/hbp44ucifvtqGB1IvB329OYgiKfJtQdcLl7Y92SXLJYHI99YKZLROHp1HcY0olDT3tBdZNT2nsn8K/q3Rjc3vY1Zjka6wDrEFLcKehSMLzMOrOl6N//8ei7qy7xNhQPa5gmAW78VDQxxr39AFPEMdWN+brq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764122; c=relaxed/simple;
	bh=Hl8qSW/ynv3e2GvL2ympO60rSHhPRV7/xX+BMQkuvPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pmo6Y0hEQQ4ou0wNe18j+B+AivGuqfk75gRsth6O4N/VGvqvemuCJFLCrJmsNTVQWSF7LN0byHgnRXDzvN5n1QKwqw8PzLuLDDIlqyx8jB+yO7ET9Ig62wVy5A2bdWB2LzUdrQuyip4sEZ7/zh0L6pLJyi+qxWQodON1FbNanko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIqCEH/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C60C116D0;
	Mon, 10 Nov 2025 08:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762764121;
	bh=Hl8qSW/ynv3e2GvL2ympO60rSHhPRV7/xX+BMQkuvPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GIqCEH/uaB0FOh5958ftF+Qbb+FOyNoILmyF2X6xZBMNamcWuFZVDgdu8O43RIBbF
	 9J4LJ0bLJRP9J/5Wt9wPjoGg/d8Xca293Y6/Q5qteH7nvrEDIpgwOhZPTj2QWuMS1K
	 PSk+G5Zy/ewCqTMTjg7FQRB7jHGnkSJ7+WbpNMKBjqJ7+RoSHNBI5Z5rr9Xx8ZFZCP
	 6Xl8m65MRA8x4+Xj5abWiqmXsUc7nrew/6ztTQ0CKE+mkDcnrqebOBGpDORWAUW+6z
	 wwKrkyG9hIPGZ3TLhMTIl2suaxUx/U2OGKLsG9snaG1mQNtI1MTuEecNzesjFaqJAe
	 kAjx0X7NfxVhw==
Date: Mon, 10 Nov 2025 09:41:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/8] ns: fixes for namespace iteration and active
 reference counting
Message-ID: <20251110-elastisch-endeffekt-747abc5a614a@brauner>
References: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
 <20251109225528.9063-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251109225528.9063-1-hdanton@sina.com>

On Mon, Nov 10, 2025 at 06:55:26AM +0800, Hillf Danton wrote:
> On Sun, 09 Nov 2025 22:11:21 +0100 Christian Brauner wrote:
> > * Make sure to initialize the active reference count for the initial
> >   network namespace and prevent __ns_common_init() from returning too
> >   early.
> > 
> > * Make sure that passive reference counts are dropped outside of rcu
> >   read locks as some namespaces such as the mount namespace do in fact
> >   sleep when putting the last reference.
> > 
> > * The setns() system call supports:
> > 
> >   (1) namespace file descriptors (nsfd)
> >   (2) process file descriptors (pidfd)
> > 
> >   When using nsfds the namespaces will remain active because they are
> >   pinned by the vfs. However, when pidfds are used things are more
> >   complicated.
> > 
> >   When the target task exits and passes through exit_nsproxy_namespaces()
> >   or is reaped and thus also passes through exit_cred_namespaces() after
> >   the setns()'ing task has called prepare_nsset() but before the active
> >   reference count of the set of namespaces it wants to setns() to might
> >   have been dropped already:
> > 
> >     P1                                                              P2
> > 
> >     pid_p1 = clone(CLONE_NEWUSER | CLONE_NEWNET | CLONE_NEWNS)
> >                                                                     pidfd = pidfd_open(pid_p1)
> >                                                                     setns(pidfd, CLONE_NEWUSER | CLONE_NEWNET | CLONE_NEWNS)
> >                                                                     prepare_nsset()
> > 
> >     exit(0)
> >     // ns->__ns_active_ref        == 1
> >     // parent_ns->__ns_active_ref == 1
> >     -> exit_nsproxy_namespaces()
> >     -> exit_cred_namespaces()
> > 
> >     // ns_active_ref_put() will also put
> >     // the reference on the owner of the
> >     // namespace. If the only reason the
> >     // owning namespace was alive was
> >     // because it was a parent of @ns
> >     // it's active reference count now goes
> >     // to zero... --------------------------------
> >     //                                           |
> >     // ns->__ns_active_ref        == 0           |
> >     // parent_ns->__ns_active_ref == 0           |
> >                                                  |                  commit_nsset()
> >                                                  -----------------> // If setns()
> >                                                                     // now manages to install the namespaces
> >                                                                     // it will call ns_active_ref_get()
> >                                                                     // on them thus bumping the active reference
> >                                                                     // count from zero again but without also
> >                                                                     // taking the required reference on the owner.
> >                                                                     // Thus we get:
> >                                                                     //
> >                                                                     // ns->__ns_active_ref        == 1
> >                                                                     // parent_ns->__ns_active_ref == 0
> > 
> >     When later someone does ns_active_ref_put() on @ns it will underflow
> >     parent_ns->__ns_active_ref leading to a splat from our asserts
> >     thinking there are still active references when in fact the counter
> >     just underflowed.
> > 
> >   So resurrect the ownership chain if necessary as well. If the caller
> >   succeeded to grab passive references to the set of namespaces the
> >   setns() should simply succeed even if the target task exists or gets
> >   reaped in the meantime.
> > 
> >   The race is rare and can only be triggered when using pidfs to setns()
> >   to namespaces. Also note that active reference on initial namespaces are
> >   nops.
> > 
> >   Since we now always handle parent references directly we can drop
> >   ns_ref_active_get_owner() when adding a namespace to a namespace tree.
> >   This is now all handled uniformly in the places where the new namespaces
> >   actually become active.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >
> FYI namespace-6.19.fixes failed to survive the syzbot test [1].
> 
> [1] Subject: Re: [syzbot] [lsm?] WARNING in put_cred_rcu
> https://lore.kernel.org/lkml/690eedba.a70a0220.22f260.0075.GAE@google.com/

This used a stale branch that existed for testing:

Tested on:

commit:         00f5a3b5 DO NOT MERGE - This is purely for testing a b..

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

git tree:       https://github.com/brauner/linux.git namespace-6.19.fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=17a46a58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e31f5f45f87b6763
dashboard link: https://syzkaller.appspot.com/bug?extid=553c4078ab14e3cf3358
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

