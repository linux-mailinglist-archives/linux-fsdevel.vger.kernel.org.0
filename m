Return-Path: <linux-fsdevel+bounces-49530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6D2ABDF08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 17:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674A31BC13B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 15:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1DE26139C;
	Tue, 20 May 2025 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vGOWHule"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8F825FA2B
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754868; cv=none; b=ny/1y21AJ3lqNZ5aE33dAsuSqRSDYI6GL49DablwiAZ1oAbvMK5CpIijLGjU2gxOUzgOQNoZk0CFr7akGKdeLmvdmgpFjwey2ohkeQc0v2KhVs82NL4qJWK5oouqnGe+Am2z55O/13cBEWKMK+XFIAap8K3TbYc1sLMbB36zmvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754868; c=relaxed/simple;
	bh=YPvpf521/EYheHO0ufoqqbiDSC2EmK40SvmEWExWcjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcqoJn4yNuzS3YM6FZ0WfngIf/80cPHoUlywP4OCcl8tHY8GIdSbuyzXIU5Ecm5tCU5+RO6/xtAal6Uaeu6IVoyXDv1ZLFkJ08/xo47PRIKdl7yydpEbIbHKL+GieyItQj19D+Hzp9iYfzQU4zquCZgEfTD9qmMYkfiZbt8yguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vGOWHule; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 May 2025 11:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747754864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GqXiYRh8a/zAdC1TBIQg75g4Mx4yjlNTwYoHSTeNtrc=;
	b=vGOWHulef+JoLK64HfOGVPxJBhGKu+zU/GGjGsa8VJCOnf1rZeFRTcOln2IbXwosaTFg4z
	Tn+q+FwhUUxuxCWQy2zbaaomSd+bnddGoHCYwrHKOZhfsFj76ww5oB0rFWMFE1KP+bEhCv
	R7mMXAA+l1Boo+GIyTohQ7LZmMoOZCo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 4/6] fs: dcache locking for exlusion between overlayfs,
 casefolding
Message-ID: <mhjalo2m6rco2czfafjwy5bdw7lguqa6pfwhsesor5czofo3iu@o3tnjzcawjjf>
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
 <20250520051600.1903319-5-kent.overstreet@linux.dev>
 <20250520152536.GD2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520152536.GD2023217@ZenIV>
X-Migadu-Flow: FLOW_OUT

On Tue, May 20, 2025 at 04:25:36PM +0100, Al Viro wrote:
> On Tue, May 20, 2025 at 01:15:56AM -0400, Kent Overstreet wrote:
> 
> > +int d_casefold_enable(struct dentry *dentry, struct d_casefold_enable *e)
> > +{
> > +	struct dentry *root = dentry->d_sb->s_root;
> > +	int ret = 0;
> > +
> > +	guard(mutex)(&no_casefold_dentries_lock);
> > +
> > +	for (struct dentry *i = dentry;
> > +	     i && i->d_inode->i_flags & S_NO_CASEFOLD;
> > +	     i = i != root ? i->d_parent : NULL) {
> > +		ret = darray_push(&e->refs, i);
> > +		if (ret)
> > +			goto err;
> > +
> > +		ret = no_casefold_dentry_get(i, ref_casefold_enable);
> 
> 	Beyond being fucking ugly, this is outright broken.  Lose
> the timeslice (e.g. on allocation in that thing), and there's
> nothing to prevent your 'i' from pointing to freed memory.

I was under the impression that dentries couldn't be freed while a child
is pinned, and we have a dget() on the start of the chain.

But no, rename would break that, of course.

