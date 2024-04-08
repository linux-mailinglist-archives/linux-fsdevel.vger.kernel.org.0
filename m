Return-Path: <linux-fsdevel+bounces-16370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC97C89C7BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 17:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBAB1F237C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 15:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941AC13F437;
	Mon,  8 Apr 2024 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kyrxkUyN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6813F428
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588547; cv=none; b=aAz+3404Raxyp3ApofgEAuFvFY6PllrkGu9rJBQ63fXIvqikFCFMLG3PrSgmm5re7PNAC0AJHamu/K2qYR7H64xFve2DHazPNjtLbFcEjK9Ln8zZy7Vx2CU0dfr15EIQQInehwO8cSjDAyKc6oBN/d4NF7G+gfdf4oGZMhB7EdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588547; c=relaxed/simple;
	bh=fG6U9xW9bmejD2wSZN1Slg2WozyDP7zJ7nn1Aj/489A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5K8Vjf35BLgeE0wSEReizlw9CCCKyjvzR4TfXqh3EI83g0AzHtpTAaIhTdlec6i5ZaeqxmeplMLaz+UKD89/AngEGdBRQJ5af9ueDsSYkSWXW8Mqiat4IMGqEjNQsAD4ewJyX9njv+J6g07JBKcZNT0/mD+jYa45ZH9QTFvNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kyrxkUyN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pLLB0dlv+unFokrZFiHOqNvATB7+6s7gdIaXCzVzZ6g=; b=kyrxkUyNtfxqVb8ycbsgdDMFl7
	HH5iLb/xw/j5G3sB35hxg4kel8hyo6ES+vx+6LHNtO7/zwvEQ3XnZGXQQw6RB1wQMm99DP7U22i1w
	EZQymceXjKt3to4exVn/How87/+6G3zPhEY40uM54nEnMqTJs+Ru+uuTOcyhESz39hS027AYyfO1F
	4gd0UhLnQ6X81HotZPGOhkcWESfp03MkrBn1Q9RTL/jlgIwlbhoxkBODdsYlLc3GJUhlMwT27Dcak
	afvNYU4nW/YO1o8PKxzkiu0ai28v2cz+dA5itvggm7CnlrKH3FU9JHy8H1U5W+XG//rUcaQJqlJan
	hZR9Xy4g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rtqVl-008XR7-1T;
	Mon, 08 Apr 2024 15:02:17 +0000
Date: Mon, 8 Apr 2024 16:02:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Add FOP_HUGE_PAGES
Message-ID: <20240408150217.GN538574@ZenIV>
References: <20240407201122.3783877-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407201122.3783877-1-willy@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Apr 07, 2024 at 09:11:20PM +0100, Matthew Wilcox (Oracle) wrote:
> -static inline bool is_file_hugepages(struct file *file)
> +static inline bool is_file_hugepages(const struct file *file)
>  {
> -	if (file->f_op == &hugetlbfs_file_operations)
> -		return true;
> -
> -	return is_file_shm_hugepages(file);
> +	return file->f_op->fop_flags & FOP_HUGE_PAGES;
>  }

Extra cacheline to pull can be costly on a sufficiently hot path...

