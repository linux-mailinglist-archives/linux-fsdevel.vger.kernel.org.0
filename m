Return-Path: <linux-fsdevel+bounces-37163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3259EE70C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658812831CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41E72135DE;
	Thu, 12 Dec 2024 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MbCn8YE/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D92116EC
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007704; cv=none; b=Dxds/qlxqKWyXvsUuQS+X//Vh9fyGwK4PjVRdbx1OT47V07Xc5OIb2UR7+apJPLhkd90K5n1hR/16aTQUesjdRWWK5HcHvLlJY1IDJoWiFpjPVss61Wtbw/qLin/UqBqAMSpE7fLqRL3y5pZp3N6TWuheofSyCLPb5X0sx8Yp6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007704; c=relaxed/simple;
	bh=eXcDjK+WxXfhkb/H+2/rzALKf9gvXWlErbl0BRgDjUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFMwFyi7cjGkoDbpBjbr3dy5lKsVrPMFFGwwK0P1CEnvkB8vjJQY0/QPRt2IdQGMJScNxM4UI6N+zuZkNLX6XdD59H3sl1hHV0XuJAP8p7cqSKRDEs8LzFDPvalcytuPmg0WNc+GmKrfEbfbnnsiaLVk2oxwJmCXXofsWIhs5P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MbCn8YE/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BgTIw7hVKJxeUIMmCT0J2mjcu6nSoKwayiyH6BmoNFQ=; b=MbCn8YE/hSL9gvPkMiq6N2q6J1
	Rr5627OGJWO3SMJNad4kkV7VySdFSlWx36LhYJ/EiNLUhXFx3/NZt9nt6MIl3U04h6CVzYj6UmFsr
	8EC2ST47uTpba3bVQe20LdWe5Rhb8QtavKKOHfhwTiGCqM3+ZQeswuDyTOTadIGA+WjHzWMbFfmmh
	VjR02k25nXiCpDrX4CL0e84jGI3zVe1PkZQiZOIKSdq5tplXi6dv3sg07SkGigZZyU114FVT6PaVw
	UpsZZRbTpgtVmkZA9xu1wXQhu3dCanKMCb0D05soP7azTNoQ4sPqqVtZE9SySbu8L9ec/pvAU6Fwy
	uz2uRfCA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLic6-00000005hxg-3PLX;
	Thu, 12 Dec 2024 12:48:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 04C743003FF; Thu, 12 Dec 2024 13:48:18 +0100 (CET)
Date: Thu, 12 Dec 2024 13:48:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] fs: lockless mntns lookup for nsfs
Message-ID: <20241212124817.GZ21636@noisy.programming.kicks-ass.net>
References: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
 <20241212-work-mount-rbtree-lockless-v2-5-4fe6cef02534@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212-work-mount-rbtree-lockless-v2-5-4fe6cef02534@kernel.org>

On Thu, Dec 12, 2024 at 12:56:04PM +0100, Christian Brauner wrote:

> @@ -146,6 +147,7 @@ static void mnt_ns_tree_add(struct mnt_namespace *ns)
>  
>  	mnt_ns_tree_write_lock();
>  	node = rb_find_add_rcu(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_cmp);
> +	list_add_tail_rcu(&ns->mnt_ns_list, &mnt_ns_list);
>  	mnt_ns_tree_write_unlock();

This only works if the entries are inserted in order -- if not, you can
do something like:

  prev = rb_prev(&ns->mnt_ns_tree_node);
  if (!prev) {
    // no previous, add to head
    list_add(&ns->mnt_ns_list, &mnt_ns_list); 
  } else {
    // add after the previous tree node
    prev_ns = container_of(prev, struct mnt_namespace, mnt_ns_tree_node);
    list_add_tail(&ns->mnt_ns_list, &prev_ns->mnt_ns_list);
  }

