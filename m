Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A351D630CE2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 08:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiKSHMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Nov 2022 02:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiKSHMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Nov 2022 02:12:44 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98748A466B;
        Fri, 18 Nov 2022 23:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VCqCe3q478QSHNNJYRBLBecZWRB23gFIKJ0dIMZ/ya0=; b=s6I1VNpdKkJ9FwVLUB5c7DCHgX
        Hmsb/+7KJk9knppLLKAChhxc2n+wJe2kRwUcCjVsEdRB30ig3wFeuPSXxWVMEXNnYETEweYygFODX
        b/FdaT4z0a4zzHBY37WnK2vVqADuWGpYMkENg2qXmJC6FCqE0Jopiff5BGBxT41quSOk2/ln+b5ca
        HzNVCiBc9QCm6B+Mu8Y1zPpg2IsMAO4Taf0nC1aNysAxeVDtG3AbkAZOwHPrqfI4hHaE0c+6h6okq
        y2/GDLtgkvuIBxUUaQIvjnFFJwlpucgZppsHFgQGvPgedzPo9eia8BaRKYpizyHBqGBLgHh8uNxRq
        7WMr8otg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1owI1n-0050Vc-0D;
        Sat, 19 Nov 2022 07:12:39 +0000
Date:   Sat, 19 Nov 2022 07:12:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Denis Arefev <arefev@swemel.ru>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2] namespace: Added pointer check in copy_mnt_ns()
Message-ID: <Y3iB59LAgL8ORT5N@ZenIV>
References: <20221118114137.128088-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118114137.128088-1-arefev@swemel.ru>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 18, 2022 at 02:41:37PM +0300, Denis Arefev wrote:
> Return value of a function 'next_mnt' is dereferenced at
> namespace.c:3377 without checking for null,
> but it is usually checked for this function
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

NAK.

I see a bug in there, but it's not going to trigger a NULL pointer
dereference and your patch doesn't fix it at all.

That loop ought to be
		// skipped mntns binding?
                while (p->mnt.mnt_root != q->mnt.mnt_root)
			p = next_mnt(skip_mnt_tree(p), old);

and I suspect that it'll confuse your tool even worse.

What happens here is that new tree is congruent to the old one,
with some subtrees skipped.  Each node N in the new tree is a
clone of some node (Origin(N)) in the old one.  Copying preserves
node order.  We want to have p == Origin(q) on each iteration.

What we really have (due to the real bug) is

	p is no later than Origin(q) in node ordering

Initially it's trivially true (p points to root of the old tree,
and the only way it would *not* be copied would be to somehow get
mntns binding as root; in that case copy_tree() would've failed
and we wouldn't get to that loop at all).

Suppose it is true on some iteration.  What happens on the next
one?  q hadn't been the last node in the new tree, or we would've
found next_mnt(q, new) to be NULL and exited the loop.  But
that means that
	p "<=" Origin(q) "<" Origin(next_mnt(q, new))
("<" and "<=" in the node ordering, that is).  So p couldn't
have been the last node in the old tree and
	next_mnt(p, old) "<=" Origin(next_mnt(q, new))
After the
                p = next_mnt(p, old);
		q = next_mnt(q, new);
		if (!q)
			break;
we have
	p != NULL && p "<=" Origin(q)

Cloning preserves ->mnt_root, so the subsequent loop
                while (p->mnt.mnt_root != q->mnt.mnt_root)
			p = next_mnt(p, old);
could be rewritten as
		while (p->mnt.mnt_root != Origin(q)->mnt.mnt_root)
			p = next_mnt(p, old);
and in that form it's really obvious that p will not advance past
Origin(q), nevermind running out of nodes.

So on the next iteration the property still holds.  There's no way
for your added checks to trigger.

There *IS* a bug in that logics, though - mntns binding can have
a file bound on top of it.  In such case it is possible to have
p behind the Origin(q) for a (short) while.  It's not going to
cause serious problems, but that's certainly a non-obvious
behaviour and a comment needed to explain why it's not problem
is certainly longer than the one-liner change eliminating the
oddity.  Note that running into mnt_root mismatch means that p
is currently pointing to mntns binding we'd skipped when copying.
So let's skip the subtree in the same way copy_tree() did...

The bottom line:
	* your NULL pointer checks could never trigger; if you *do* have
a reproducer, please post it.
	* there's a (pretty harmless) bug in that code, but it is not
fixed by your patch.
	* see if your tool is any happier with the patch below; I would
be rather surprised if it did, but...

diff --git a/fs/namespace.c b/fs/namespace.c
index df137ba19d37..c80f422084eb 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3515,8 +3515,9 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 		q = next_mnt(q, new);
 		if (!q)
 			break;
+		// an mntns binding we'd skipped?
 		while (p->mnt.mnt_root != q->mnt.mnt_root)
-			p = next_mnt(p, old);
+			p = next_mnt(skip_mnt_tree(p), old);
 	}
 	namespace_unlock();
 
