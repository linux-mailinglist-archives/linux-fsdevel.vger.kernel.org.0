Return-Path: <linux-fsdevel+bounces-36698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3109E82B9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 00:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3758818845F2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 23:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750E815746B;
	Sat,  7 Dec 2024 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SPFYToYx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD480BFF
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Dec 2024 23:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733614774; cv=none; b=Q9upFnIkPnTszr6qxdmXmQXeu5eI49JqpYNkzo2fgMG+W9A/M0urtWiIX/i/HJ/ltLzRe0PFiC8DSW68pJFFhpXxXmbfKNSXBj0vXiuW0a9IunM8vbl+nley0704g2vyCKyLw4BLo6b+WYCqRszHVGGqVal65Rcct31pb7dvmu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733614774; c=relaxed/simple;
	bh=pL+Zu62NJLF3gdb/19qeMns0MdgAjMEanQttYLILo5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrxJGfH3wLMKQmwlabXY6Rlh0dAmULZ+glcZLD4gcPlmaMGzkdvdzmZM5WokZIXZb4DZVvwfnNFtSP1fWqVx2hCWOk/NmHMUIJe1mXMlaiFaqBQ0SKjvlo+dYpjbqdWldOcpOGppHxJVanHrdnPS3bnZsAouH6STjvQLJ1vrkJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SPFYToYx; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 7 Dec 2024 18:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733614768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pL+Zu62NJLF3gdb/19qeMns0MdgAjMEanQttYLILo5E=;
	b=SPFYToYx5WVhzjFqSpPbqo05pUE1pRhiQ5+nws5/XsqS9qo9xt8nAOG3WjEdgyt93RbCLQ
	q8YBIxQZuBH7TssuzEhzeT2107B+1EZO7SpKqx6oZ7Hyt2xNmbR29WHM7gaGu1xOLKP0PC
	/7TjqCCXvJGKkm9iNejys6Yu7pClF5M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Malte =?utf-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>
Cc: Miklos Szeredi <mszeredi@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: silent data corruption in fuse in rc1
Message-ID: <5zj4d3e7vscemwkod2kdz47tisumniv5jkmzlbaftjbb7vphn6@ncpmjph7tv77>
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
X-Migadu-Flow: FLOW_OUT

On Sun, Dec 08, 2024 at 12:01:11AM +0100, Malte Schröder wrote:
> On 07/12/2024 22:58, Kent Overstreet wrote:
> > Hey Miklos, I've got a user who noticed silent data corruption when
> > building flatpaks on rc1; it appeared when using both bcachefs and btrfs
> > as the host filesystem, it's now looking like fuse changes might be the
> > culprit - we just got confirmation that reverting
> > fb527fc1f36e252cd1f62a26be4906949e7708ff fixes it.
> >
> > Can you guys take it from here? Also, I think a data corruption in rc1
> > merits a post mortem and hopefully some test improvements, this caused a
> > bit of a freak out.
> Hi
> all,                                                                        
>                                                                              
>  
> I did report this. What I encountered is flatpak installs failing on
> bcachefs  
> because of mismatching hashes. I did not notice any other issues, just
> this    
> thing with flatpak. Flatpak seems to put downloaded files into
> directories     
> mounted with "revokefs-fuse" on /var/tmp. So far I could only reproduce
> this on
> bcachefs, it does not happen when I make /var/tmp a tmpfs or when I
> bind-mount
> a directory from a btrfs onto
> /var/tmp.                                        
>                                                                              
>  
> To me there seems to be some bad interaction between fuse and
> bcachefs.        
>                                                                              
>  
> Reverting fb527fc1f36e252cd1f62a26be4906949e7708ff fixes the issue for
> me.     

You said it happened with btrfs as well?

