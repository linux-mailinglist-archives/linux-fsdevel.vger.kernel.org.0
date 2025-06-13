Return-Path: <linux-fsdevel+bounces-51641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240A4AD9847
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 00:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCD73BB19D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 22:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01B628DF20;
	Fri, 13 Jun 2025 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DLB9Eccs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2C328D8C0;
	Fri, 13 Jun 2025 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749854192; cv=none; b=bWaE21YqFGqbLMxqesydaNmrek7iocMBbuKQ6t8iVP2evqwWHadHw/Cz7I438Ui2IGpGJ7QLk5n3GCMwesAE6nx4FtSfZFJXHMQD5LUovU7PJMWw+BpFZf51RttjVjyfxXlnzA+BNnO6SdgwIaedTQNOMg5qdiA4eVwF/lu2w9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749854192; c=relaxed/simple;
	bh=7RYWF2bnGVw62I0X+ZtqcE8VaubKUXf019kZeP72seE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWkDJbcPQJAg00SOlV50Wf8L99hPLGg/m0uys9XOhdWVA4qQSC5gHG6tdWjBEUowKr7/HnEG2wPWKSBzGSSO+1kMnpO8XTc+hEBqdJMCdkqnNNnRUQSHLslvsAijstQANusmCHPyK3EOuY0UyHxsEZ0YTC1d5ykz7eh7bgcyyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DLB9Eccs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RehG7PGPztUq7+nfLhbm0NJARXK9a/ujCIVsQ/Sto/8=; b=DLB9Eccs1SU42K683ck6j503gv
	ZRkXx2hJTzR0nR483LQS29/NswhHAuHsYnwe1n2ZyfetqKyXn0pr1piYyf5AKWJx3zsMZLQ/PVRqR
	jFYMLBFc8etrXuEAnUeAjMF9c5tcqHZOwcR8+7fkHYArJbV/jgOa/Lhokfrq/Vux/lXDhoRE4CwUf
	wJdEOPAWxRB0E1AtXPg/4n2dZvgiIUu1sw8clbisRRBi9YjHCs43MH4uAb7jkyQ83UvAYC7R2mOZJ
	Cso7B+KLGR9aBUsXy/XDyWczn/I8RQdbCtZP9zFqSbF7QZWF1kXAcE6v6rkLHlndbtapWLITqdB31
	/7Ba3E4g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQD0b-0000000FchZ-2xx1;
	Fri, 13 Jun 2025 22:36:25 +0000
Date: Fri, 13 Jun 2025 23:36:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, chuck.lever@oracle.com,
	linux-nfs@vger.kernel.org, neil@brown.name,
	torvalds@linux-foundation.org, trondmy@kernel.org
Subject: Re: [PATCH 02/17] new helper: simple_start_creating()
Message-ID: <20250613223625.GA1880847@ZenIV>
References: <20250613073149.GI1647736@ZenIV>
 <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
 <20250613073432.1871345-2-viro@zeniv.linux.org.uk>
 <84376c8a7753a8242e9f5730128f0eaea7863b61.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84376c8a7753a8242e9f5730128f0eaea7863b61.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 13, 2025 at 02:31:56PM -0400, Jeff Layton wrote:
> > -	if (unlikely(IS_DEADDIR(d_inode(parent))))
> > -		dentry = ERR_PTR(-ENOENT);
> > -	else
> > -		dentry = lookup_noperm(&QSTR(name), parent);
> > -	if (!IS_ERR(dentry) && d_really_is_positive(dentry)) {
> > -		if (d_is_dir(dentry))
> > -			pr_err("Directory '%s' with parent '%s' already present!\n",
> > -			       name, parent->d_name.name);
> > -		else
> > -			pr_err("File '%s' in directory '%s' already present!\n",
> > -			       name, parent->d_name.name);
> 
> Any chance we could keep a pr_err() for this case? I was doing some
> debugfs work recently, and found it helpful.

Umm...  Not in simple_start_creating(), obviously, but...
Would something like
	dentry = simple_start_creating(parent, name);
        if (IS_ERR(dentry)) {
		if (dentry == ERR_PTR(-EEXIST))
			pr_err("'%s' already exists in '%pd'\n", name, parent);
		simple_release_fs(&debugfs_mount, &debugfs_mount_count);
	}
work for you?

