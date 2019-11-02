Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E09ECFF2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2019 18:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfKBRYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Nov 2019 13:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfKBRYt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Nov 2019 13:24:49 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [65.158.186.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30223217D9;
        Sat,  2 Nov 2019 17:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572715488;
        bh=dFj8NAZBJwn8JB6ouldPBEYS8ERyP1np8D1tiIVWD3Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=yuTvp7WvRnzQ0qd5ylYyP6sw4h01DHOO4nwOU4fk0N1ttS6Jmy3gP7qgrsVSkrNno
         Zs3BSxWyQKRxdl5BFMvOyk41dPLnX/QBcdNRc46YU+RNBx07OYXwkuzpgMUsDiwOgZ
         iU5yoU7dWFZgeCqtHCpdM7XB7PZorpnclWT0Ujkw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0159A35204A2; Sat,  2 Nov 2019 10:24:47 -0700 (PDT)
Date:   Sat, 2 Nov 2019 10:24:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wugyuan@cn.ibm.com, jlayton@kernel.org, hsiangkao@aol.com,
        Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH RESEND 1/1] vfs: Really check for inode ptr in lookup_fast
Message-ID: <20191102172447.GU20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20190927044243.18856-1-riteshh@linux.ibm.com>
 <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com>
 <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk>
 <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
 <20191101234622.GM26530@ZenIV.linux.org.uk>
 <20191102061706.GA10268@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102061706.GA10268@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 02, 2019 at 06:17:06AM +0000, Al Viro wrote:
> On Fri, Nov 01, 2019 at 11:46:22PM +0000, Al Viro wrote:
> > on anything except alpha that would be pretty much automatic and
> > on alpha we get the things along the lines of
> > 
> > 	f = fdt[n]
> > 	mb
> > 	d = f->f_path.dentry
> > 	i = d->d_inode
> > 	assert(i != NULL)
> > vs.
> > 	see that d->d_inode is non-NULL
> > 	f->f_path.dentry = d
> > 	mb
> > 	fdt[n] = f
> > 
> > IOW, the barriers that make it safe to fetch the fields of struct file
> > (rcu_dereference_raw() in __fcheck_files() vs. smp_store_release()
> > in __fd_install() in the above) should *hopefully* take care of all
> > stores visible by the time of do_dentry_open().  Sure, alpha cache
> > coherency is insane, but AFAICS it's not _that_ insane.
> > 
> > Question to folks familiar with alpha memory model:
> > 
> > A = 0, B = NULL, C = NULL
> > CPU1:
> > 	A = 1
> > 
> > CPU2:
> > 	r1 = A
> > 	if (r1) {
> > 		B = &A
> > 		mb
> > 		C = &B
> > 	}
> > 
> > CPU3:
> > 	r2 = C;
> > 	mb
> > 	if (r2) {	// &B
> > 		r3 = *r2	// &A
> > 		r4 = *r3	// 1
> > 		assert(r4 == 1)
> > 	}
> > 
> > is the above safe on alpha?
> 
> Hmm...  After digging through alpha manuals, it should be -
> 
> U1: W A, 1
> 
> V1: R A, 1

Assuming a compare and branch here ...

> V2: W B, &A
> V3: MB
> V4: W C, &B
> 
> W1: R C, &B
> W2: MB

... and here ...

> W3: R B, &A
> W4: R A, 0
> 
> is rejected since
> 	U1 BEFORE V1 (storage and visibility)
> 	V1 BEFORE V3 BEFORE V4 (processor issue order constraints)
> 	V4 BEFORE W1 (storage and visibility)
> 	W1 BEFORE W2 BEFORE W4 (processor issue order constraints)
> and W4 BEFORE U1 (storage and visibility), which is impossible
> due to BEFORE being acyclic and transitive.
> 
> I might very well be missing something, though...  Paul, could you
> take a look and tell if the above makes sense?

...  then yes, agreed.  Alpha does respect control dependencies to
stores, and you supplied the required mb for the last task that has
a control dependency only to loads.

I have to ask...  Are you seeing failures on Alpha?

							Thanx, Paul
