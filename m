Return-Path: <linux-fsdevel+bounces-37276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 062269F06EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 09:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D0D16A442
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 08:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4646BFCA;
	Fri, 13 Dec 2024 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="btVCz7HA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FDB1AB6D8
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079830; cv=none; b=mO8A4Jipb04N1p02x88celZjUYZieWmcm97uK892MzmkntLZT1nADKDBs95HJNekSwJndzhEciW0wSt3z4wYlmwTnfQwAFPyNVqs+Gg6BEpEAAMMRctA29xSn2BJCZHxlO35BPrn+omQKpa07RFxthuUUpHRg0aephz/PZT6ZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079830; c=relaxed/simple;
	bh=0O6K5VZNDUBYmaUVHWHfuieSzVnjmyOPRbecaWkAncU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYBuXNsHIcJCtC43SWwwRhD0t6jzkbVboFIv2KqtixvOUwOfBCEEds/g/DvW6RPiU3cN25k5gjrpAlFN2Y9viWhIiBTV8nuEWW1kC3JkgtUWzA1W24kNbqR0TYDLPPJhebZIZVeDXiZEYRk58H1Z9Bt5slF51xjJ4RLZzrAZUz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=btVCz7HA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vY7EhCrE6vk/oQGc4+lntIIkbSKVPo66P0iC+YumPxE=; b=btVCz7HA5/ELOlCsMiZpKinKGk
	YV2uZ5JiROHroFvSk4/bTTOl8gA49JpBC7AHPWbt7j+/N/MnzjiP+mCLwncz/WN05PbbTEA2abFJV
	/W5M5dib4b9Lrpfg0LRIfaEWJNIObNwiu/6wV9FJJWChELwusGbL0F4U5Iw2r8w1xzxAUnD9hrCle
	gOsdvtIWLXerpZTr14mDvDVblf6+7gRV92ZUd9IpfJH4gbVf8qTpicf5Jk6t83IKbLw1F6gcqvgAp
	jC3FzSH1Rae7ERguUumniXv7RJXusE504W8rdDqUKM6OPivn7+SLeO9fKIl6rnlk1bS5Dw+/EDDkb
	+ui/UX9g==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tM1NR-0000000BfIz-0aln;
	Fri, 13 Dec 2024 08:50:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 23D0430049D; Fri, 13 Dec 2024 09:50:24 +0100 (CET)
Date: Fri, 13 Dec 2024 09:50:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] fs: lockless mntns rbtree lookup
Message-ID: <20241213085024.GA21636@noisy.programming.kicks-ass.net>
References: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
 <20241213-work-mount-rbtree-lockless-v3-3-6e3cdaf9b280@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-work-mount-rbtree-lockless-v3-3-6e3cdaf9b280@kernel.org>

On Fri, Dec 13, 2024 at 12:03:42AM +0100, Christian Brauner wrote:
> +static inline void mnt_ns_tree_write_lock(void)
> +{
> +	write_lock(&mnt_ns_tree_lock);
> +	write_seqcount_begin(&mnt_ns_tree_seqcount);
> +}
> +
> +static inline void mnt_ns_tree_write_unlock(void)
> +{
> +	write_seqcount_end(&mnt_ns_tree_seqcount);
> +	write_unlock(&mnt_ns_tree_lock);
>  }

>  static void mnt_ns_tree_add(struct mnt_namespace *ns)
>  {
> -	guard(write_lock)(&mnt_ns_tree_lock);
> -	rb_add(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_less);
> +	struct rb_node *node;
> +
> +	mnt_ns_tree_write_lock();
> +	node = rb_find_add_rcu(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_cmp);
> +	mnt_ns_tree_write_unlock();
> +
> +	WARN_ON_ONCE(node);
>  }

>  static void mnt_ns_tree_remove(struct mnt_namespace *ns)
>  {
>  	/* remove from global mount namespace list */
>  	if (!is_anon_ns(ns)) {
> -		guard(write_lock)(&mnt_ns_tree_lock);
> +		mnt_ns_tree_write_lock();
>  		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
> +		mnt_ns_tree_write_unlock();
>  	}
>  
> -	mnt_ns_release(ns);
> +	call_rcu(&ns->mnt_ns_rcu, mnt_ns_release_rcu);
>  }

Its probably not worth the effort, but I figured I'd mention it anyway,
if you do:

DEFINE_LOCK_GUARD_0(mnt_ns_tree_lock, mnt_ns_tree_lock(), mnt_ns_tree_unlock())

You can use: guard(mnt_ns_tree_lock)();

But like said, probably not worth it, given the above are the only two
sites and they're utterly trivial.


Anyway, rest of the patches look good now.

