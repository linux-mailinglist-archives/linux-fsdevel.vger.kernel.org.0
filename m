Return-Path: <linux-fsdevel+bounces-71198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C625BCB9312
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 16:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08CE73066DC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 15:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A2129E0E7;
	Fri, 12 Dec 2025 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bc25+NHc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3C21C9F9;
	Fri, 12 Dec 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765554651; cv=none; b=AgHjKjcBQXl3xvzw2hh7pJ3FfRMgL7o76WJMNNiIrA87+1Hea/fEOEo4wqEWOVoZ7fsI5EyVWJQAAuOFARgFswZ1Q09ZKefs8NqrWM27SxVXP1t6tSTCKdnQxq7E8q7RmqWDY8wP4tLtivofOy0FZenG9Rg+OUTopp1+QidZiQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765554651; c=relaxed/simple;
	bh=Lb8RQP6gwwEbNWwfb81+8/RJHLCpjbsiLtVR9N626Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DV09LPhImQ3Tln1reJ/xV9xtn92p94R99LLCqoH5FKt+7PXWX912/A95JKFfHxWQmvL8cHrA/86jlZ2nzL8ZEpJxG8N81U6VwQt4aHUH5x3L3aA3aqEih/XY0iNId37UAEqwvPLR/Lh8KVe/3GBnqPh9mo7NIjYY6NDlDkVPReg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bc25+NHc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=wOhaMt+bLTj+No6UopNehq9gG2mVlFLA56jyTvdrXwE=; b=bc25+NHc2xQcg4/HjCvaE7ab0W
	CvMFLhR0F+6jqCANZQcjcNdrmIBeOCodo62BPiYeJLS5ZU+azlu75mgbGdgDyhaVGqlcnEYqi3XaC
	XwhaFbvYT5pPJJLUDgc9Xx9erYCfi5nt+WTGDV75RQLoBm75t0GiQqh3kKEjcTaFUAkuAjMUnr2fD
	8UBfgiECDr5vPzeLEJyn9w3GQRBpRbWiZKmpndDd7NNS/kzkJS58lZnDDqKhuictAaEfi13WO/34e
	atFY4D3/JSz2k+Uj2YM6mZhHO00fpFIcBGL/9nZJCt2R4JcNBZpx5GsfMP5KrqvnKGIZu3C7mmLga
	lbuKL2Kw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vU5QI-0000000Gtcf-1apM;
	Fri, 12 Dec 2025 15:51:14 +0000
Date: Fri, 12 Dec 2025 15:51:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "tianjia.zhang" <tianjia.zhang@linux.alibaba.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] file: Call security_file_alloc() after initializing the
 filp
Message-ID: <20251212155114.GG1712166@ZenIV>
References: <20251209075347.31161-1-tianjia.zhang@linux.alibaba.com>
 <dpuld3qyyl6kan2jsigftmuhrqee2htjfmlytvnr55x37wy3eb@jkutc2k4zkfm>
 <038af1cc-a0f1-46a6-8382-5bca44161aee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <038af1cc-a0f1-46a6-8382-5bca44161aee@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 12, 2025 at 06:01:53PM +0800, tianjia.zhang wrote:

> The scenario is as follows: I have hooked all LSM functions and
> abstracted struct file into an object using higher-level logic. In my
> handler functions, I need to print the file path of this object for
> debugging purposes. However, doing so will cause a crash unless I
> explicitly know that handler in the file_alloc_security context—which,
> in my case, I don't.
> 
> Of course, obtaining the path isn't strictly required; I understand that
> in certain situations—such as during initialization—there may be no
> valid path at all. Even so, it would be acceptable if I could reliably
> determine from filp->f_path that fetching the path is inappropriate. The
> problem is that, without knowing whether I'm in the file_alloc_security
> context, I have no reliable way to decide whether it's safe to attempt
> retrieving the path.

<sarcasm>

"I can't figure out which of the functions in my code is calling (directly)
this function in my code; there's a predicate that might allow me to do
that, but it doesn't really work without this change to function outside
of my code.  With this change I can make the things work; no, I won't
tell you which predicate it is, you'll just have to avoid any changes
in the area in the future, lest my code breaks".

</sarcasm>

In case it's not obvious from the above, your reasoning is unconvincing.

