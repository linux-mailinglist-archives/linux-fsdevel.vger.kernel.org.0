Return-Path: <linux-fsdevel+bounces-1710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8477DDDDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 09:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93C2281603
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 08:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007396ABB;
	Wed,  1 Nov 2023 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Q2Pbshap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5709346BD
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 08:45:44 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6CE10D
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 01:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Iv0tenCxJbIvTgVIjRmgo/bss/o5PnRrQQFVkdWXdO0=; b=Q2PbshapGTohrn0q3MVrwGVS9R
	LwQEDnu+XhYUIT1cfcBazl9cQv/d1B2MUiHzekUATG3ZuAfA9ZYin9FS5IVPzidGok4TudHpcRG6l
	kJ+k/eaPsPRz27ykJfEJrKaz4r1uwTPvKGKEqtnXRYwuPOI/J5Xt4/hfLL7CGb78wDJBIgKX76dnG
	nZNItMiBWVqX5Sey3OnLgsvpqmpAORZiSywUsxR44K8aLEzOS3zLxtR1v3pv82Qdj0YsVnYPZf+4Y
	xQlklodK6agyoJeHI3krhgAU/RL9fv9mR+xZ7seeIAFmgTg/7DEJBYxWdMQdhF7F5eVq9KFl+iV+c
	he0OMLUQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qy6r1-008soC-2N;
	Wed, 01 Nov 2023 08:45:35 +0000
Date: Wed, 1 Nov 2023 08:45:35 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/15] fold the call of retain_dentry() into fast_dput()
Message-ID: <20231101084535.GG1957730@ZenIV>
References: <20231031061226.GC1957730@ZenIV>
 <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
 <20231101062104.2104951-9-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101062104.2104951-9-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 01, 2023 at 06:20:58AM +0000, Al Viro wrote:
> Calls of retain_dentry() happen immediately after getting false
> from fast_dput() and getting true from retain_dentry() is
> treated the same way as non-zero refcount would be treated by
> fast_dput() - unlock dentry and bugger off.
> 
> Doing that in fast_dput() itself is simpler.

FWIW, I wonder if it would be better to reorganize it a bit -

// in some cases we can show that retain_dentry() would return true
// without having to take ->d_lock
< your comments regarding that part go here>
static inline bool lockless_retain_dentry(struct dentry *dentry)
{
        unsigned int d_flags;

        smp_rmb();
        d_flags = READ_ONCE(dentry->d_flags);
        d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_OP_DELETE |
                        DCACHE_DISCONNECTED | DCACHE_DONTCACHE;

        /* Nothing to do? Dropping the reference was all we needed? */
        if (d_flags == (DCACHE_REFERENCED | DCACHE_LRU_LIST) && !d_unhashed(dentry))
                return true;
	return false;
}

and fast_dput() becomes

{
        int ret;
	// try to do decrement locklessly
	ret = lockref_put_return(&dentry->d_lockref);
	if (likely(ret >= 0)) {
		// could we show that full check would succeed?
		if (ret || lockless_retain_dentry(dentry))
			return true;
		// too bad, have to lock it and do full variant
		spin_lock(&dentry->d_lock);
	} else {
		// failed, no chance to avoid grabbing lock
                spin_lock(&dentry->d_lock);
		// underflow?  whine and back off - we are done
                if (WARN_ON_ONCE(dentry->d_lockref.count <= 0)) {
                        spin_unlock(&dentry->d_lock);
                        return true;
                }
		// decrement it under lock, then...
                dentry->d_lockref.count--;
        }
	// full check it is...
        if (dentry->d_lockref.count || retain_dentry(dentry)) {
                spin_unlock(&dentry->d_lock);
                return true;
        }
        return false;
}

Might be easier to follow that way...  Another thing: would you mind

#if USE_CMPXCHG_LOCKREF
extern int lockref_put_return(struct lockref *);
#else
static inline int lockref_put_return(struct lockref *l)
{
	return -1;
}
#endif

in include/linux/lockref.h?  Would be useful on DEBUG_SPINLOCK configs...

