Return-Path: <linux-fsdevel+bounces-41253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0181A2CD5B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 21:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6BC3ACDAA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 20:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F042719CC05;
	Fri,  7 Feb 2025 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SAwNACIC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C60187342;
	Fri,  7 Feb 2025 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958470; cv=none; b=GxckvEyj6sc2EZzPZgYvOE7C2mWog3B1nsDUaAzC1RdsKHBQP/P5babR3d/sDa4RixZ8Y4RjvcddjRGUYYNlBcQDcsj0QBtPhGdvbUYblk84xfBeZ+a7TzroVYlP/Byu1u8q/biMCQjR8BMvbS4LePeZ62zRJ3y1Od3n2LCF4IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958470; c=relaxed/simple;
	bh=NY1Xf/zeA4ho7skt3fwe0xeram+zbZh6Fgj4jHUkgDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbkY2OwG66VNkk5ZvAPX8sWRhsYa3j9QkTUQY1ugzaAkVNgz8JP/GEGjXL95cvRCTUONkqNkTM4swzIzlHFfEWKsntHpJMkehL83FfoU9RW3ylYobztVknph1XZjBZFeaAM5LwCR1zDgOAnSPERWK4D9VXT0DfqnT3pwgwe6lJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SAwNACIC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3vJgo+wgvqCPDY0tBycy0uGfRft56AlWwMgsaDPYvz8=; b=SAwNACIChSGAV+7n0ZpBbqdujG
	BsuEVBtoUn3immXnXedag0XNmwqdXlAiElP97mufuqjmPjfLPUuDuKVEkE0YbLx9yaQnhbU7QypPf
	DxnIaQztiCJ25zzGM6Dind5esb+xI5nuJAgYsH5b7wxaIibbh03TMhbBJl/66SiKplJKpFk9Vv76N
	VWJrGVo67gHIMMjPDkbH4cCeuqH0d2ZVRYJbA4zksIWGg51v+ZF5ZraUA3NjfogK07LJrtIjs4bN1
	+P1pROJKAcFpF9F6y38gnpjAvRELna3G/ullWa1ohfq2vpWxqpCY+hpu+fP4IdQ1dXbHNS48l/AGS
	o2vrP2Cw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgUXB-00000006WvL-2wRU;
	Fri, 07 Feb 2025 20:01:05 +0000
Date: Fri, 7 Feb 2025 20:01:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/19] VFS: use d_alloc_parallel() in
 lookup_one_qstr_excl() and rename it.
Message-ID: <20250207200105.GF1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-4-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-4-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 06, 2025 at 04:42:40PM +1100, NeilBrown wrote:
> -	dentry = d_alloc(base, name);
> -	if (unlikely(!dentry))
> +	dentry = d_alloc_parallel(base, name);
> +	if (unlikely(IS_ERR_OR_NULL(dentry)))
>  		return ERR_PTR(-ENOMEM);

Huh?  When does d_alloc_parallel() return NULL and why do you
play with explicit ERR_PTR(-ENOMEM) here?

> +	if ((flags & LOOKUP_INTENT_FLAGS) == 0)

Yecchh...  Thank you (from all reviewers, I suspect) for the exciting
opportunity to verify what values are possible in lookup_flags in various
callers and which are guaranteed to intersect with your LOOKUP_INTENT_FLAGS
mask.

> +#define LOOKUP_INTENT_FLAGS	(LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_EXCL |	\
> +				 LOOKUP_RENAME_TARGET)
> +

... as well as figuring out WTF do LOOKUP_OPEN and LOOKUP_EXCL fit into
that.

