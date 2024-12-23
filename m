Return-Path: <linux-fsdevel+bounces-38081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BC69FB7BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 00:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4491884FFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 23:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33AE1C5F31;
	Mon, 23 Dec 2024 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vdrfRty5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD92837B;
	Mon, 23 Dec 2024 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734995544; cv=none; b=ZhZUb2/0aPYteCEs6/ZDXwAi5Rcgvoql06hqlK52kRYHomw15TW3F+ZZkT/Ac+pfTRDLwClmlW//AYPO5ZteVrzVLC/Cz72kcUDYdFEDgCFN9M9fzYiQ/5r1IktOg+2dsSMxeV3igH7P30ZuWS+WvYgyUd6xPs9ZoA/c0PVD3X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734995544; c=relaxed/simple;
	bh=3UL2A2JM0swfFNBM8Co/qT2ChdEpdogfAth6JA6jfR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKjTpqcNZNRxi5uO0JnECsm4YVs2GMROrmNuwxZ7AK2N4/g4e73zTlh8ZIoZHVfW19x6YHigglizzi/v3i66j3qjPQillso/8R8JgeLTQUjFDM0Sf7E/e+g+YrPT3fiJtHFXL0C/icLsczDCgBzcAPEH6CekN2xu2ec30FR2J6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vdrfRty5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s//1pRJvnqQb3M93+E4h0uQ95nRtao5MsDhiyZKiP+s=; b=vdrfRty5BDhMpxOvE21qoNg1SG
	1A+Bd0T8CWOsU7+knNp1m4WjlxoNN4gqrsrlKVun+2Xjdm+S2HW4uHoSh6Zwmliw5xWpF8cCLlnUk
	1JHj8qnyplCjZF++l022xmAt4iFu3eXVk2rGG9h6nl1g/wINnHDoKXl+kXI2utaoSZoRszFjSXQ7k
	QokERoycLX9j0kd4p/fVsk31Ytx8QUNM+peTxDqge+S+jwMQI2j9dVB2m2GOcU/+pqD+d6B2XSqZD
	WqeffRs1qpdhrNzDzsQZgwYspU4M8hCRp4/gsnmKoCPC27hXpQQNcS39wcT2ayrDS3dY+y0Knu1hb
	qiGrMgRw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tPrb0-0000000BSZa-12cr;
	Mon, 23 Dec 2024 23:12:18 +0000
Date: Mon, 23 Dec 2024 23:12:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 6/6] efivarfs: fix error on write to new variable leaving
 remnants
Message-ID: <20241223231218.GQ1977892@ZenIV>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
 <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>
 <20241211-krabben-tresor-9f9c504e5bd7@brauner>
 <049209daadc928ecbf3bdb17d80634fa55842263.camel@HansenPartnership.com>
 <f9690563fe9d7ae4db31dd37650777e02580b332.camel@HansenPartnership.com>
 <20241223200513.GO1977892@ZenIV>
 <72a3f304b895084a1da0a8a326690a57fce541b7.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72a3f304b895084a1da0a8a326690a57fce541b7.camel@HansenPartnership.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 23, 2024 at 05:56:04PM -0500, James Bottomley wrote:
> > Let me look into that area...
> 
> I thought about this some more.  I could see a twisted container use
> case where something like this might happen (expose some but not all
> efi variables to the container).
> 
> So, help me understand the subtleties here.  If it's the target of a
> bind mount, that's all OK, because you are allowed to delete the
> target.  If something is bind mounted on to an efivarfs object, the
> is_local_mountpoint() check in vfs_unlink would usually trip and
> prevent deletion (so the subtree doesn't become unreachable).  If I
> were to duplicate that, I think the best way would be simply to do a
> d_put() in the file->release function and implement drop_nlink() in
> d_prune (since last put will always call __dentry_kill)?

Refcounting is not an issue.  At all.

Inability to find and evict the mount, OTOH, very much is.  And after your
blind d_delete() that's precisely what will happen.

You are steadily moving towards more and more convoluted crap, in places
where it really does not belong.

If anything, simple_recursive_removal() should be used for that, instead
of trying to open-code bizarre subsets of its functionality...

