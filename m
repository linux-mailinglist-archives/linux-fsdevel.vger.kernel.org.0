Return-Path: <linux-fsdevel+bounces-18098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1F48B579C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 14:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD151C22940
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 12:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E47454907;
	Mon, 29 Apr 2024 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pRM1aQe6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3DC53E17;
	Mon, 29 Apr 2024 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392613; cv=none; b=WoGJfH02IBbl9K5JZaNgV3PU2MRbSjAT9X8pEJcTcBZrRGmW0MS2TOm+e3+74rbYFjnNJzDVGJ8OlulUSsdadAnLngue6CSHjKg9WjPkLVLyfPYrNm9zyAxe60YZnQiC6iXosY33G+7UV82iFR/fXzIQe/fcrOpdSvIlPVf5nr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392613; c=relaxed/simple;
	bh=q7cqQWzC/Fb/v74sma4ofRUya5vCxStSHQg1ToDATG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8mPEGcUedu+lrlRw8GsJLDrLjW28eAclcb+X2Ow5PnmPjkWAU5G03IZcjM102/GD+Zg8iOjyDKlpHKzA6005ig0DqAx0FOoqjn25Jov5EfZjMkDdhmWgx50RJv+RU+yU0DlL0ShQeBkS8/yQLtLyobXzaHhXXTIX7YdzZbp6dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pRM1aQe6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4A2uxi6TdEIYh6cHPIgW9quB6pUydTmOMED3wqRAD1o=; b=pRM1aQe6PTvGnQ2y8LSiRmLlIl
	TWaEMRHfDhElw6y7a2Bvq5OkmYqyzeO6mSg72m1I0hfkmd9yEyHphyN5auql1v12zePySuBmTqfOw
	eTDzKvRyjxc7hQ1EhWCSOg3fF491OEcPqNwpe2BlbI0H/ZQaqB8ZEW8PuajhZLhf2+kyAV5eFLOjb
	/YFNFoAjNsHlpMCPQBGK2A+Qj6gBzeg2RJVpQ/N+EwjuB26zsZV+dF3RXOPz+sHe/ipBDsA/ewI+o
	Z06xLfMWH6MaNRtwSa70ZqZ4zCbMTyyI28U8wCPrkXoJoxIyRYjsAF3j/NnHg2Zjl2mHuwwqHHexc
	s7zqTm1A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1PpZ-0000000COJZ-0LBk;
	Mon, 29 Apr 2024 12:10:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BCFC930040C; Mon, 29 Apr 2024 14:10:00 +0200 (CEST)
Date: Mon, 29 Apr 2024 14:10:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: akpm@linux-foundation.org, oleg@redhat.com, longman@redhat.com,
	dylanbhatch@google.com, rick.p.edgecombe@intel.com,
	ke.wang@unisoc.com, xuewen.yan94@gmail.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched/proc: Print user_cpus_ptr for task status
Message-ID: <20240429121000.GA40213@noisy.programming.kicks-ass.net>
References: <20240429084633.9800-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429084633.9800-1-xuewen.yan@unisoc.com>

On Mon, Apr 29, 2024 at 04:46:33PM +0800, Xuewen Yan wrote:
> The commit 851a723e45d1c("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
> would clear the user_cpus_ptr when call the do_set_cpus_allowed.
> 
> In order to determine whether the user_cpus_ptr is taking effect,
> it is better to print the task's user_cpus_ptr.

This is an ABI change and would mandate we forever more have this
distinction. I don't think your changes justifies things sufficiently
for this.

