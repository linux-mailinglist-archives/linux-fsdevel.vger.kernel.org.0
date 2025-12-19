Return-Path: <linux-fsdevel+bounces-71786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DB1CD2150
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 23:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43E113064E68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 22:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54942FFF9D;
	Fri, 19 Dec 2025 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nI1teiY/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74C0261B70;
	Fri, 19 Dec 2025 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766182194; cv=none; b=QmG8j8iGYqaFOAz1woG7DM8YDSadLFg2bdTYlGSlsF/DIVCYdmumAB8kAAlelq3K++xvO6V6kTozQNprIEqoXHD6JzyNlsZN/58Ch8b+4GEY8x4RggExIS75S5pvk22K2ovfQZZJ/DGyTGh1MCm64OagAw2LuXbAAPFgPQid38Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766182194; c=relaxed/simple;
	bh=vpNBspchGAJv5WjJQfgIuIlaMMfgprtaF20ghvYXEvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdvsIGYpbfjq8ePO7F3KFhkH01HXRXdILU1YYeYUhmHcjPYaHlJAVcAjt6fZxWclBIZZpnOy9r61YWBfPSUID/Z3pKJ9KeA2/rjG74cbvHrNvszxJOFRRrS/+euYpKTmP0LtZiJfuvmeslimi5LjTqZ5C4KqlgbAIN9aSxaBdWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nI1teiY/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i/f3ovgR9grm0uiWb1C9l7U/WjK8IiAgmOVrUtACKh8=; b=nI1teiY/8U+WhDRnVNjSoZu1tD
	prUEo4u/ol/6bIMh55GbDuPXCaYyeD87ZyTVKEwdedG5C2X7va/n/V/fes1zGrcmNxClqArB7b9Rb
	g0z7GxntLLSHsRvTgnWLdbqKnEVI9LY8yKhK0rjFmS/CihH5YGTRRNVKZpNLyT8fgi/f2b25Gr25c
	MRNC6JSGpA5ktZeQzRCIsuPiTqbS0TY6FzRhanFP0oCE87WA640fW0aa/yd/TnvPuGXYtq04xSBRs
	QvGr+nuMPdyEl6PSIemLyrjKvdKIW2ebUKtSIGRdZyKIZUE9lCtBoRJrIrr0rVcq1YUYcvyL37qca
	DCUIgoOQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vWigB-00000009Xb5-3SwD;
	Fri, 19 Dec 2025 22:10:31 +0000
Date: Fri, 19 Dec 2025 22:10:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, mszeredi@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH] fuse: add missing iput() in fuse_lookup() error path
Message-ID: <20251219221031.GZ1712166@ZenIV>
References: <20251219174310.41703-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219174310.41703-1-luis@igalia.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 19, 2025 at 05:43:09PM +0000, Luis Henriques wrote:
> The inode use count needs to be dropped in the fuse_lookup() error path,
> when there's an error returned by d_splice_alias().
> 
> (While there, remove extra white spaces before labels.)
> 
> Fixes: 5835f3390e35 ("fuse: use d_materialise_unique()")
> Signed-off-by: Luis Henriques <luis@igalia.com>

Have you actually looked at d_splice_alias()?

It does consume inode reference in all cases, success or error.  On success
it gets transferred to dentry; on failure it is dropped.  That's quite
deliberate, since it makes life much simplier for failure handling in the
callers.

If you can reproduce a leak there, I would like to see a reproducer.
If not, I would say that your patch introduces a double-iput.

NAK.

