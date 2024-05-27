Return-Path: <linux-fsdevel+bounces-20233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29848D00E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 15:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE2F288809
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBDD15F419;
	Mon, 27 May 2024 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xyHfZBAP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EE115ECE4;
	Mon, 27 May 2024 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814733; cv=none; b=kPtJ7T27rEL3d0LrY3R4I/7Sj3np0TaMpGexzkCwySCAJqaB5VIINIJTWhUtj+AnOw13bYUMspHNYg7EVI01HAyAtEfKrE+oA9SZ3NnHNUzfQM2mKAmrRBac/9DluUeh9edFRtQzC68xHEdyAIhrJT238ifLKQHrhAxnQ4ooRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814733; c=relaxed/simple;
	bh=Y5EStVtK5WBwaVqJnTBpsLDGG9CDOGGAhpofJDguFsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AM9dU4cLOUMbVsGu2JLfRERJfqrcjMRpVGq205lCcPkKzJh72qeSjj2AJaUZUK0wfQwxnHj9Hc5k/Go3RfBWs78kReLwcvh0t4ILY/6ad5MUcSiqjxUgHRsFls3GRs3lPoLGW1zct9Q7ZFwCyoMY+k4gFCX15dNGhYG8YXdwsYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xyHfZBAP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LizxiP53j7D2NoPkmTsvm1+adARrQRUkvK742gCLD4s=; b=xyHfZBAP16UcddrMhJmpJz3Jd6
	5ksXFxX2gBhXrU2IeCQijkzwenNq+TDmDH9VGK7TboOMDwG6iZxIGJNrLoqEbpsomJR8y9g+jzRFg
	LImskVT7Q6JV9hTwFqhDDEvFt+gLbWJZ9KZ4c+Q5DSbZd3tX+TOoWMywiF6cmQKJyRlP9OlgF+jeA
	NGJfpZJflKTevGmnksZ4mPAPSI5L/hbzRO39rLbPts2lpLKLQjz+Bd5O8SkOWimf2xJ2yoAciiMIY
	O4QdhHFpiEX88VxN5edNdV+Kz88wcLesD3dKy2xO9CLfNB7pMt00b+vOgCjzEfI6VZ1xbgrdb9OUh
	KO6+F1kg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBZwA-0000000EysS-0LnS;
	Mon, 27 May 2024 12:58:50 +0000
Date: Mon, 27 May 2024 05:58:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Sukrit.Bhatnagar@sony.com" <Sukrit.Bhatnagar@sony.com>
Cc: Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@ucw.cz>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/2] Improve dmesg output for swapfile+hibernation
Message-ID: <ZlSDinoWgqLt21QD@infradead.org>
References: <20240522074658.2420468-1-Sukrit.Bhatnagar@sony.com>
 <Zk+c532nfSCcjx+u@duo.ucw.cz>
 <TYAPR01MB4048D805BA4F8DEC1A12374DF6F02@TYAPR01MB4048.jpnprd01.prod.outlook.com>
 <ZlRseMV1HgI4zXNJ@infradead.org>
 <TYAPR01MB40481A5A5DC3FA97917404E2F6F02@TYAPR01MB4048.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB40481A5A5DC3FA97917404E2F6F02@TYAPR01MB4048.jpnprd01.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, May 27, 2024 at 12:51:07PM +0000, Sukrit.Bhatnagar@sony.com wrote:
> In my understanding, the resume offset in hibernate is used as follows.
> 
> Suspend
> - Hibernate looks up the swap/swapfile using the details we pass in the
>   sysfs entries, in the function swsusp_swap_check():
>   * /sys/power/resume - path/uuid/major:minor of the swap partition (or
>                         non-swap partition for swapfile)
>   * /sys/power/resume_offset - physical offset of the swapfile in that
>                                partition
>   * If no resume device is specified, it just uses the first available swap!
> - It then proceeds to write the image to the specified swap.
>   (The allocation of swap pages is done by the swapfile code internally.)

Where "it" is userspace code?  If so, that already seems unsafe for
a swap device, but definitely is a no-go for a swapfile.

> - Hibernate gets the partition and offset values from kernel command-line
>   parameters "resume" and "resume_offset" (which must be set from
>   userspace, not ideal).

Or is it just for these parameters?  In which case we "only" need to
specify the swap file, which would then need code in the file system
driver to resolve the logical to physical mapping as swap files don't
need to be contiguous.


