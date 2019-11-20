Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35C3A104408
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 20:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfKTTNr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 14:13:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbfKTTNq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:13:46 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70FAA208CE;
        Wed, 20 Nov 2019 19:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574277225;
        bh=La1HKQgpHIGqu+A9vJ9gXjbNnhWYrCWS1/SPTX2d5vQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6JjhgXzt0nJTTAkHYDRYBhe7xkv5MVuJTm+/X8D/w3p8ETLzbJjo4jkirb5ALekb
         n1VP7YaJITSXQufLr1jumoC7xb2tOz9q8y1rsjgwEMuj8TXVJ/wNL7kkXNNBXzNkK3
         izlDra5gLQYAl+phdEeUxZ2Not7WZJk2uSyKxGoc=
Date:   Wed, 20 Nov 2019 19:13:40 +0000
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        linuxfs <linux-fsdevel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] selinux: Don't call avc_compute_av() from RCU
 path walk
Message-ID: <20191120191340.GA4799@willie-the-truck>
References: <20191119184057.14961-1-will@kernel.org>
 <20191119184057.14961-2-will@kernel.org>
 <5e51f9a5-ba76-a42d-fc2b-9255f8544859@tycho.nsa.gov>
 <20191120131229.GA21500@willie-the-truck>
 <d8dbd290-0ffa-271f-0268-5e9148e7ee9b@tycho.nsa.gov>
 <20191120190743.GT2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120190743.GT2889@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 20, 2019 at 11:07:43AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 20, 2019 at 10:28:31AM -0500, Stephen Smalley wrote:
> > On 11/20/19 8:12 AM, Will Deacon wrote:
> > > Hi Stephen,
> > > 
> > > Thanks for the quick reply.
> > > 
> > > On Tue, Nov 19, 2019 at 01:59:40PM -0500, Stephen Smalley wrote:
> > > > On 11/19/19 1:40 PM, Will Deacon wrote:
> > > > > 'avc_compute_av()' can block, so we carefully exit the RCU read-side
> > > > > critical section before calling it in 'avc_has_perm_noaudit()'.
> > > > > Unfortunately, if we're calling from the VFS layer on the RCU path walk
> > > > > via 'selinux_inode_permission()' then we're still actually in an RCU
> > > > > read-side critical section and must not block.
> > > > 
> > > > avc_compute_av() should never block AFAIK. The blocking concern was with
> > > > slow_avc_audit(), and even that appears dubious to me. That seems to be more
> > > > about misuse of d_find_alias in dump_common_audit_data() than anything.
> > > 
> > > Apologies, I lost track of GFP_ATOMIC when I reading the code and didn't
> > > think it was propagated down to all of the potential allocations and
> > > string functions. Having looked at it again, I can't see where it blocks.
> > > 
> > > Might be worth a comment in avc_compute_av(), because the temporary
> > > dropping of rcu_read_lock() looks really dodgy when we could be running
> > > on the RCU path walk path anyway.
> > 
> > I don't think that's a problem but I'll defer to the fsdevel and rcu folks.
> > The use of RCU within the SELinux AVC long predates the introduction of RCU
> > path walk, and the rcu_read_lock()/unlock() pairs inside the AVC are not
> > related in any way to RCU path walk.  Hopefully they don't break it.  The
> > SELinux security server (i.e. security_compute_av() and the rest of
> > security/selinux/ss/*) internally has its own locking for its data
> > structures, primarily the policy rwlock.  There was also a patch long ago to
> > convert use of that policy rwlock to RCU but it didn't seem justified at the
> > time.  We are interested in revisiting that however.  That would introduce
> > its own set of rcu_read_lock/unlock pairs inside of security_compute_av() as
> > well.
> 
> RCU readers nest, so it should be fine.  (Famous last words...)

Agreed. It was blocking that worried me, and it turns out that doesn't
happen for this code.

Will
