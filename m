Return-Path: <linux-fsdevel+bounces-61405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D20B57DCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB57188778D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B5831B80B;
	Mon, 15 Sep 2025 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLZfvLJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4587A313286;
	Mon, 15 Sep 2025 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943910; cv=none; b=j9aO9BMV23MRxZjH2LDt3zjRM80yqwVc1WSfI7eu71bQDreAQ7gLSUhXA2PiWuvM8Xg8CWaWuDN2glzUHlY6Fx8mdSSr8qbpeFyUaOkmLQAhPlBFOOalPOLuUGRN+zp66Idum1OUQEIBoBjNh3ikWUIHj5qx+D5jt6rIaf81Myo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943910; c=relaxed/simple;
	bh=QsaenlLe+MpwjJA3/3iLUSdHMSKRqd8RhiCv3IDh7Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrxbumNjgXOBpLFwgkxFVOP/TpeCFnI2PDBAR9Lhv81rgJYMqOppPVdvcfIFhR8FmoP0hICYYUsu6zD1ZDXRBDzu3n1Xyb9e3yxLM18f4XI9ZCpK7I933eCGRxEaFZCuXbXQuU4frXRlagoBhF3vdlSsnuYy1vii/XPS6L21ihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLZfvLJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C17BC4CEF1;
	Mon, 15 Sep 2025 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757943909;
	bh=QsaenlLe+MpwjJA3/3iLUSdHMSKRqd8RhiCv3IDh7Xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kLZfvLJHFwUpC8HG54W3zYAdHQKzxO7fX/VXxZnpyRmwEkUm1WFhjQfdpQZyCo1YG
	 60KQWsaHTDiBWRoD+43/0rTtJIShZTkAl5ZPq9z+r3ut/Aiydo345vdFzB5j2HOQxm
	 470c2kA3uvhpHYUOjyd9Bma367Qg6TxDhaA6MFV+IBL+44bjN6ah9Hy4Yl0SqdnuQx
	 OvgCOAqJBvHekZzlTqZOMgT8mL6yjPTjnyDBWNEGNUDLoWw55dkgDZmB6427DAhKVx
	 1Q0iIEjlsXGC7S8FSDlLGxZIQ4FhMIv4fF/zb4PybKvKNMcLuHS1KPRoFDh9IZCppR
	 YkbGTNEC7nCOQ==
Date: Mon, 15 Sep 2025 15:45:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 18/33] mnt: support ns lookup
Message-ID: <20250915-gepachtet-paprika-a7b4274372c1@brauner>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-18-1a247645cef5@kernel.org>
 <4hey7blvy6dfk22kargj46oevtrnk6nccbgjrbk3xvctvbfhdt@jimfucryj25d>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4hey7blvy6dfk22kargj46oevtrnk6nccbgjrbk3xvctvbfhdt@jimfucryj25d>

On Mon, Sep 15, 2025 at 01:48:51PM +0200, Jan Kara wrote:
> On Fri 12-09-25 13:52:41, Christian Brauner wrote:
> > Move the mount namespace to the generic ns lookup infrastructure.
> > This allows us to drop a bunch of members from struct mnt_namespace.
> >                                                                       t
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Just one nit below. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> > @@ -4185,11 +4107,11 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
> >  		return ERR_PTR(ret);
> >  	}
> >  	if (!anon)
> > -		new_ns->seq = atomic64_inc_return(&mnt_ns_seq);
> > +		ns_tree_gen_id(&new_ns->ns);
> > +	RB_CLEAR_NODE(&new_ns->ns.ns_tree_node);
> > +	INIT_LIST_HEAD(&new_ns->ns.ns_list_node);
> 
> Why do you initialize ns_tree_node and ns_list_node here when
> ns_init_common() already initialized them?

I forgot to remove that. I should note I did all this while severly sick. :D

