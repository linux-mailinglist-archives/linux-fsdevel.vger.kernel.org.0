Return-Path: <linux-fsdevel+bounces-57645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A87B241CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 08:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100FC3BFFF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 06:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C4D2D3734;
	Wed, 13 Aug 2025 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vt6VckGn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89DF2D2397;
	Wed, 13 Aug 2025 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067487; cv=none; b=RzY8CcZHBdqH5x3KwZTb8S3DtNRPn6zJFsRr6xnQQpjMQ4X2maxuzhT8H9eAzIO1giOFFJz+y5OcrfBDFjgN8JrjTu1r+sQ3GxtYmUYk72PrR54y5A42GwI1tmZOiEmVePZdQSaxemKizJrI8R7b5AayzUZtp/MqzE09zeEFmGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067487; c=relaxed/simple;
	bh=bquKFG0kbBHJUv82BQCZOUnkm2velApg2/ANEduHk8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsBYi47RM2dIaJiEGr4coIsATYTSPfCVkQTIKylt3iFNdzgt8+AHJnJ3AKYd64SDqv3qWC43EHT5EK74zI8pzPyT+JvPs3qkQYJfm1AlGfQtkRLsGaWJm6qA30BDa076BoxpSMw6G+/qutpOlX1t3CG+MK2gQ+ECuM9VEjuzQBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vt6VckGn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0SNIdZiTJR/nPW1SdNBX7/DJYyYBUtTTIadH/4Y1HCg=; b=vt6VckGnfO/bRRiyFxmXG9ogQn
	sU3C5xi4iIp5tuRc34S9kxl5tNaRl9AtTgEm+7SWGAGEbW4/p/dK1U9ns6ca+6XQpjKnsL6WwqfPv
	IiWYMQMqYj6y3NQs1sn1zJub+2HYiOP4yyFS8U9o0DSMHmZUwO0/Xd42zILkkvfEL7P/0vayh8GHw
	tQcul4hTNmy+uZj/vdV/WA6o58XjgJCGKYJTITnQenOcJRPIwOFEIqfpTy/8WEpgr1Hp+0+EilJ92
	68d+GTcpetaDTVjn8KbX7NpVPzyNwIFk0u7npkiQcDSDEbOy7Xsl3S+yIvv1gjeukl5q9naab7Bqn
	xPYjpGFw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um5Dr-00000006iOl-1FbN;
	Wed, 13 Aug 2025 06:44:31 +0000
Date: Wed, 13 Aug 2025 07:44:31 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] VFS: use global wait-queue table for
 d_alloc_parallel()
Message-ID: <20250813064431.GF222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-10-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-10-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 12, 2025 at 12:25:12PM +1000, NeilBrown wrote:

> +** mandatory**
> +
> +d_alloc_parallel() no longer requires a waitqueue_head.  It uses one
> +from an internal table when needed.

Misleading, IMO - that sounds like "giving it a wq is optional, it will
pick one if needed" when reality is "calling conventions have changed,
no more passing it a waitqueue at all".

> +#define	PAR_LOOKUP_WQ_BITS	8
> +#define PAR_LOOKUP_WQS (1 << PAR_LOOKUP_WQ_BITS)
> +static wait_queue_head_t par_wait_table[PAR_LOOKUP_WQS] __cacheline_aligned;

I wonder how hot these cachelines will be...

> +static int __init par_wait_init(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < PAR_LOOKUP_WQS; i++)
> +		init_waitqueue_head(&par_wait_table[i]);
> +	return 0;
> +}
> +fs_initcall(par_wait_init);

Let's not open _that_ can of worms; just call it from dcache_init().

> +static inline void d_wake_waiters(struct wait_queue_head *d_wait,
> +				  struct dentry *dentry)
> +{
> +	/* ->d_wait is only set if some thread is actually waiting.
> +	 * If we find it is NULL - the common case - then there was no
> +	 * contention and there are no waiters to be woken.
> +	 */
> +	if (d_wait)
> +		__wake_up(d_wait, TASK_NORMAL, 0, dentry);

Might be worth a note re "this is wake_up_all(), except that key is dentry
rather than NULL" - or a helper in wait.h to that effect, for that matter.
I see several other places where we have the same thing (do_notify_pidfd(),
nfs4_callback_notify_lock(), etc.), so...


> +		struct wait_queue_head *wq;
> +		if (!dentry->d_wait)
> +			dentry->d_wait = &par_wait_table[hash_ptr(dentry,
> +								  PAR_LOOKUP_WQ_BITS)];
> +		wq = dentry->d_wait;

Yecchhh...  Cosmetic change: take
	&par_wait_table[hash_ptr(dentry, PAR_LOOKUP_WQ_BITS)];
into an inlined helper, please.

BTW, while we are at it - one change I have for that function is
(in the current form)
static bool d_wait_lookup(struct dentry *dentry,
			  struct dentry *parent,
			  const struct qstr *name)
{
	bool valid = true;
	spin_lock(&dentry->d_lock);
        if (d_in_lookup(dentry)) {
		DECLARE_WAITQUEUE(wait, current);
		add_wait_queue(dentry->d_wait, &wait);
		do {   
			set_current_state(TASK_UNINTERRUPTIBLE);
			spin_unlock(&dentry->d_lock);
			schedule();
			spin_lock(&dentry->d_lock);
		} while (d_in_lookup(dentry));
	}
	/*
	 * it's not in-lookup anymore; in principle the caller should repeat
	 * everything from dcache lookup, but it's likely to be what
	 * d_lookup() would've found anyway.  If so, they can use it as-is.
	 */
	if (unlikely(dentry->d_name.hash != name->hash ||
		     dentry->d_parent != parent ||
		     d_unhashed(dentry) ||
		     !d_same_name(dentry, parent, name)))
		valid = false;
	spin_unlock(&dentry->d_lock);
	return valid;
}

with
	if (unlikely(d_wait_lookup(dentry, parent, name))) {
                dput(dentry);
		goto retry;
	}
	dput(new);
	return dentry;
in the caller (d_alloc_parallel()).  Caller easier to follow and fewer functions
that are not neutral wrt ->d_lock...  I'm not suggesting to fold that with
yours - just a heads-up on needing to coordinate.

Anyway, modulo fs_initcall() thing it's all cosmetical; I certainly like
the simplified callers, if nothing else.

That's another patch I'd like to see pulled in front of the queue.

