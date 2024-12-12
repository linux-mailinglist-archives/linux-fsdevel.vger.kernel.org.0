Return-Path: <linux-fsdevel+bounces-37158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A8B9EE657
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491702827CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFD4211A27;
	Thu, 12 Dec 2024 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LzDt66uw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46690259495
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734005375; cv=none; b=jxDl9Suy7h8pRo8f2QYgExadjXNuWH602Y7IsEG8cCg0zgB4YEmSHWram01DfkyBAxkpF5ZskZj2OgTVlEdJZ/8QDPXruICeEZsf1WymdGi0L+LBYsAybX3t6Kx5sjTMe09HYolTt0o4EBS7dPra0jp/KUB941hwpcus5PnNlis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734005375; c=relaxed/simple;
	bh=LY7v22mtNEgZBKES/r3ZHvZRxIJ1hCQ4xGOSctFQXU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLlQJ9Tu9seUfgT+08YBeCH4LQ+k2SN7+dZz4WUbfGI7rdp1EslR7tYV+wGX65rfYzOap+GGGdxYkcTbIvqvxunKJKJ0bqrXU4Ru/9IKhWJ7URUawdtQwnwMb9VTrjqeIeT3j08sK/FLctpGxTp10tQ8Ko+NoELI8+1k3IOxwig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LzDt66uw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GA0WCj2/ALAdMcpcpRR0bkTNrrapKCp07a3QY3pmE8Q=; b=LzDt66uwL5XhS4ucOYhnYNNHQr
	NtWhEQv1FIiNJc36uUb+j2N61z+AYE5NKx4ilQMfsVK0iSWda6pv0a0a8/XcMO0Pn9/aO/I0VzQ7R
	vmtDGK5PZTMkPiyTZZ5/TPBI+GBICUGrjH+QaOLW2RQkwcdoQrWvJfxiZqgPpNlwPa4A6QrneL7Ne
	fgH+3nk+uSnlT64ine8Vd/ZkpVBmIRATNnMS22vzNN8WRybh6BjQK2qW5f7xL5VK7+yZjeUruiC+J
	T7M+r5iX7AIwhttjwq1mBO2DOByTjRzyaRdgGWooQ4DNXhdZkw3kXvYGshuF7KO67cE8U/RFIYTNt
	BRi4zLVQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLi0Y-000000043Tn-0u5i;
	Thu, 12 Dec 2024 12:09:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C05F93003FF; Thu, 12 Dec 2024 13:09:29 +0100 (CET)
Date: Thu, 12 Dec 2024 13:09:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] fs: lockless mntns rbtree lookup
Message-ID: <20241212120929.GY21636@noisy.programming.kicks-ass.net>
References: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
 <20241212-work-mount-rbtree-lockless-v2-3-4fe6cef02534@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212-work-mount-rbtree-lockless-v2-3-4fe6cef02534@kernel.org>

On Thu, Dec 12, 2024 at 12:56:02PM +0100, Christian Brauner wrote:


> @@ -16,7 +16,10 @@ struct mnt_namespace {
>  	u64 event;
>  	unsigned int		nr_mounts; /* # of mounts in the namespace */
>  	unsigned int		pending_mounts;
> -	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
> +	union {
> +		struct rb_node	mnt_ns_tree_node; /* node in the mnt_ns_tree */
> +		struct rcu_head mnt_ns_rcu;
> +	};
>  	refcount_t		passive; /* number references not pinning @mounts */
>  } __randomize_layout;

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

I'm not sure that union is sane; the above means you're overwriting the
tree node while a concurrent lookup might still see the node and want to
decent from it.

