Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446B0ECD93
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2019 07:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfKBGRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Nov 2019 02:17:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45304 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfKBGRJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Nov 2019 02:17:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQmig-0003Wx-Sb; Sat, 02 Nov 2019 06:17:07 +0000
Date:   Sat, 2 Nov 2019 06:17:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wugyuan@cn.ibm.com, jlayton@kernel.org, hsiangkao@aol.com,
        Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH RESEND 1/1] vfs: Really check for inode ptr in lookup_fast
Message-ID: <20191102061706.GA10268@ZenIV.linux.org.uk>
References: <20190927044243.18856-1-riteshh@linux.ibm.com>
 <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com>
 <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk>
 <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
 <20191101234622.GM26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101234622.GM26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 11:46:22PM +0000, Al Viro wrote:
> on anything except alpha that would be pretty much automatic and
> on alpha we get the things along the lines of
> 
> 	f = fdt[n]
> 	mb
> 	d = f->f_path.dentry
> 	i = d->d_inode
> 	assert(i != NULL)
> vs.
> 	see that d->d_inode is non-NULL
> 	f->f_path.dentry = d
> 	mb
> 	fdt[n] = f
> 
> IOW, the barriers that make it safe to fetch the fields of struct file
> (rcu_dereference_raw() in __fcheck_files() vs. smp_store_release()
> in __fd_install() in the above) should *hopefully* take care of all
> stores visible by the time of do_dentry_open().  Sure, alpha cache
> coherency is insane, but AFAICS it's not _that_ insane.
> 
> Question to folks familiar with alpha memory model:
> 
> A = 0, B = NULL, C = NULL
> CPU1:
> 	A = 1
> 
> CPU2:
> 	r1 = A
> 	if (r1) {
> 		B = &A
> 		mb
> 		C = &B
> 	}
> 
> CPU3:
> 	r2 = C;
> 	mb
> 	if (r2) {	// &B
> 		r3 = *r2	// &A
> 		r4 = *r3	// 1
> 		assert(r4 == 1)
> 	}
> 
> is the above safe on alpha?

Hmm...  After digging through alpha manuals, it should be -

U1: W A, 1

V1: R A, 1
V2: W B, &A
V3: MB
V4: W C, &B

W1: R C, &B
W2: MB
W3: R B, &A
W4: R A, 0

is rejected since
	U1 BEFORE V1 (storage and visibility)
	V1 BEFORE V3 BEFORE V4 (processor issue order constraints)
	V4 BEFORE W1 (storage and visibility)
	W1 BEFORE W2 BEFORE W4 (processor issue order constraints)
and W4 BEFORE U1 (storage and visibility), which is impossible
due to BEFORE being acyclic and transitive.

I might very well be missing something, though...  Paul, could you
take a look and tell if the above makes sense?
