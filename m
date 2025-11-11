Return-Path: <linux-fsdevel+bounces-67790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C799CC4B548
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 04:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39DD9188ECB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 03:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC887314B8E;
	Tue, 11 Nov 2025 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Nh4YGfdw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57390261B77;
	Tue, 11 Nov 2025 03:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831951; cv=none; b=MORdvAkbtFWWf4i4GArzkeUEiyxzNFomYpSULsnamJqrsUFmew664aUCh7nFHi6EbbFkwMGUZ5iR8dxmn8nMwD67qu7bSHCc0KpoYebbFJ291pBjz+A29zV1EHv+ADvuy0QQ6xZZ16SAx3fKsCXHF1z5xeA6Q1B/3L3kAdO3ncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831951; c=relaxed/simple;
	bh=Ii9lwsCxnfrd/+7EaatUAp97bEI8ieJbJWe1A+9LbX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1hI8KJdxmYlfeeZd/eD0A1/6pu0h6XW2f8Jq1yaOxzruD57nb/KluyoRsk390QfQPApgwcWhCx/LdZJIn0TbElXUk6ubaVqbiQ0EEU+QV5IdJ8JN2aapYatLLbiffJDm461tWtkLb1YaFiEaDNuWZr8g7eSVCeZXjKjeDwk6ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Nh4YGfdw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CjxKuBFzN0YjZ8SdSQdFar3Ri3ljDm9Qyv9V+RN0upI=; b=Nh4YGfdwqSyZ1hmbT1Z10HiwjM
	HQbd8etsCAuI48+0Pm4SRhgjjhYZtLDVwNPMUZ2Lu9VCiACk2MC+fOYtPN8hY5YFzsg7ljDI/xm4k
	eIM8+MXfm4h22SWnOeWXxeqLcdMhu0nhoRAWQ9rwH1vEaas3OZk4vbGCDBTdW76kl/eAUTzcCe4Z4
	GrNoRCqxZdYar0H5tlg4OYYZsqkznjTEMD5q4R+lcuAK1pGlJY6DPXUMlSe14LC2gCFESYm/f65Xb
	FMhCqWPieONg+FBgunTEf9U7Nj4sM20Iu0rrwlcrbLf7jjLS+M6FisuQTXmG/2P+OXoQHHm7KBZC0
	nxQe1v4A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIf7K-00000007y6M-1Xaq;
	Tue, 11 Nov 2025 03:32:26 +0000
Date: Tue, 11 Nov 2025 03:32:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] fs: add predicts based on nd->depth
Message-ID: <20251111033226.GP2441659@ZenIV>
References: <20251110165901.1491476-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110165901.1491476-1-mjguzik@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 10, 2025 at 05:59:01PM +0100, Mateusz Guzik wrote:

> Given these results:
> 1. terminate_walk() is called towards the end of the lookup. I failed
>    run into a case where it has any depth to clean up. For now predict
>    it does not.

Easy - just have an error while resolving a nested symlink in the middle
of pathname.  On success it will have zero nd->depth, of course.

> 2. legitimize_links() is also called towards the end of lookup and most
>    of the time there s 0 depth. Patch consumers to avoid calling into it
>    in that case.

On transition from lazy to non-lazy mode on cache miss, ->d_revalidate()
saying "dunno, try in non-lazy mode", etc.

That can happen inside a nested symlink as well as on the top level, but
the latter is more common on most of the loads.

> 3. walk_component() is typically called with WALK_MORE and zero depth,
>    checked in that order. Check depth first and predict it is 0.

Does it give a measurable effect?

> 4. link_path_walk() predicts not dealing with a symlink, but the other
>    part of symlink handling fails to make the same predict. Add it.

Unconvincing, that - one is "we have a component; what are the odds of that
component being a symlink?", another - "we have reached the end of pathname
or the end of nested symlink; what are the odds of the latter being the case?"

I can believe that answers to both questions are fairly low, but they are
not the same.  I'd expect the latter to be considerably higher than the
former.

> -	if (unlikely(!legitimize_links(nd)))
> +	if (unlikely(nd->depth && !legitimize_links(nd)))

I suspect that 
	if (unlikely(nd->depth) && !legitimize_links(nd))
might be better...

> -	if (unlikely(!legitimize_links(nd)))
> +	if (unlikely(nd->depth && !legitimize_links(nd)))
>  		goto out2;

Ditto.

