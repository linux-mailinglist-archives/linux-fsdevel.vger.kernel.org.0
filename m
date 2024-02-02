Return-Path: <linux-fsdevel+bounces-9958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A6C8466E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 05:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0799F1F23624
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 04:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709C0E57A;
	Fri,  2 Feb 2024 04:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lalX4tc9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D616F51D;
	Fri,  2 Feb 2024 04:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706847346; cv=none; b=Yu9n5Mx6HAhYujm7L8cf5I82ffxUCyEE5BejhlXvlfMPnzbYx2tTJlRzHyr1xV6BSz83iQz7AC4yXWfj8/swwTfXC2SPh/Pl4mAGHXlSqO+j0r1MdVTe3BtgK7tUizel01n0Nm1LhD8Yc0Jr9XtYk9rrMZqZBQoHhNjyd/z35xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706847346; c=relaxed/simple;
	bh=9MVNGYON3I3TYe4RK9+epNKhwSjMObmQ1NUsggK6G0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6mzs2St2tlq/LW9cJnFZ6ddn4IowC8R+M8mKYEtZdip8OOWZc/mHf2Ys2i2SquS23MtANosMFHCVbUbAKoubKEvLWv5zXZQ1gZ39AosvYznp2hNDRtoynzQNBu9W84wC32JNu+CRC7ZecFDD8xLo5dKS+znll8PUCG/lIsP35A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lalX4tc9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p3ixc7xOxGnAntqDXaoDdSsv0shKrOpuXUN8Nh+tsrM=; b=lalX4tc9Vfkolj7JczpTxRNVwo
	pHdD2uo9pRSZmmrBqYvCRuQ+OEV+AFi40Ssv8tjbePX/mCMI4DdTUWenA1YKVXUkFvZFITgSknIs2
	Xylq03WiiyzsFc5lc1GMDRSvx5PXh89KBRqDEeOdP12R0RzDmNAlc6LMgR2xcrxuzF+cveQ5Dd5F+
	fjthmkCRvEAdugiZsj0XdbkuiiNGGAGEAQ9HjxQ0O1TCxHuNSVtL1iEA6F5Vuy8hdItMq8ByTIGt+
	Xu2xxpqBuOfZ26W9jtzpI7eWDiHinmyRD5ct4azlN7cIHOPKigOuWjwUNDkj6CWmGufBEXw6XgizO
	E91ERloQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVkxn-000000004Er-3S5p;
	Fri, 02 Feb 2024 04:15:39 +0000
Date: Fri, 2 Feb 2024 04:15:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Don Dutile <ddutile@redhat.com>, Rafael Aquini <raquini@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH] mm/madvise: set ra_pages as device max request size
 during ADV_POPULATE_READ
Message-ID: <Zbxsawh-wlkQ5-8C@casper.infradead.org>
References: <20240202022029.1903629-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202022029.1903629-1-ming.lei@redhat.com>

On Fri, Feb 02, 2024 at 10:20:29AM +0800, Ming Lei wrote:
> +static struct file *madvise_override_ra_win(struct file *f,
> +		unsigned long start, unsigned long end,
> +		unsigned int *old_ra_pages)
> +{
> +	unsigned int io_pages;
> +
> +	if (!f || !f->f_mapping || !f->f_mapping->host)
> +		return NULL;

How can ->f_mapping be NULL?  How can f_mapping->host be NULL?


