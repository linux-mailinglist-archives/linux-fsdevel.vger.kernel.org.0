Return-Path: <linux-fsdevel+bounces-8202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1EC830E52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 21:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E604C1F259C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 20:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D34D25566;
	Wed, 17 Jan 2024 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="beCoH6fw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96647250EF;
	Wed, 17 Jan 2024 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705525146; cv=none; b=YGxBxNjJbp762aH9d7tVIrbdu9jDh2aJ++jNB+O5jvhb6CVMDOLZgp74yVm95PYbXA4Z7dF6sxsILJx/dYEKjWCyEzBMVzaSdWXRnvsywcVe/hBWE1hOCD9dg9ksRzuj89E7pQoeFsQhNLpqtbTR4tlJt+D9Omh1ivicDJggCog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705525146; c=relaxed/simple;
	bh=DlM/RuYuH1b01vCd/RhvIaHU3REIrO4rQFDg2+XvZq8=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=R2gpxcNJdFDVb3encgVBIfLNVLCe9TAksxmMgrdSFFSFrR27KuD+kHuAGlaQ4V6XA8frTJDplmTl5DHrWfDRH//vpoksUoZ7m7Cfv4ltr3JxrLziSj5vIXMg27Mk4rbgTfQzbrGWOneWXOqx2erIHnnBnJHuP36c4wIHT/nf8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=beCoH6fw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pkNWLL2Ut4cYQL6nLJM8ERU7VpEkSUkQghkmIkDx9X4=; b=beCoH6fwCVVp5Cb9B40CGR4rt7
	1Os8tB3vYOYg1/5X1vAcDcrLvCjUVvVZFJSCVoV/ezCe3o4wt9RbNny/xjhihFQ40q9CRtCe6nuRY
	gVELu/wGM/Aqyg6jYoTiHGQT/7wQgGmqUuxgZNYFKKlt33mbXmLFTNovAmNv+L18ki7qvjF6Duc+v
	a8S287LV3IUwIkJjLzlxrHRSvjqKXA+mS7u58xSE3SU99x+VD70UZYjkrm1DF3+VWivjvB2uimjjM
	J6Rhd4o6/wmzZpBSgKKJOIbjaJgl5XvbQxYwhnaf6dcCrqOJreBWxouUMKg++gSXxRf/fQGSatWBa
	7CjDfUGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQCzz-00000000kRy-1kqe;
	Wed, 17 Jan 2024 20:58:59 +0000
Date: Wed, 17 Jan 2024 20:58:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Phillip Susi <phill@thesusis.net>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Message-ID: <Zag_k-csqVRuHpyK@casper.infradead.org>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <20240116114519.jcktectmk2thgagw@quack3>
 <20240117-tupfen-unqualifiziert-173af9bc68c8@brauner>
 <20240117143528.idmyeadhf4yzs5ck@quack3>
 <ZafpsO3XakIekWXx@casper.infradead.org>
 <87il3rvg2u.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il3rvg2u.fsf@vps.thesusis.net>

On Wed, Jan 17, 2024 at 03:51:37PM -0500, Phillip Susi wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > We have numerous ways to intercept file reads and make them either
> > block or fail.  The obvious one to me is security_file_permission()
> > called from rw_verify_area().  Can we do everything we need with an LSM?
> 
> I like the idea.  That runs when someone opens a file right?  What about

Every read() and write() call goes through there.  eg ksys_read ->
vfs_read -> rw_verify_area -> security_file_permission

It wouldn't cover mmap accesses.  So if you had the file mmaped
before suspend, you'd still be able to load from the mmap.  There's
no security_ hook for that right now, afaik.

> Is that in addition to, or instead of throwing out the key and
> suspending IO at the block layer?  If it is in addition, then that would
> mean that trying to open a file would fail cleanly, but accessing a page
> that is already mapped could hang the task.  In an unkillable state.
> For a long time.  Even the OOM killer can't kill a task blocked like
> that can it?  Or did that get fixed at some point?

TASK_KILLABLE was added in 2008, but it's up to each individual call
site whether to use killable or uninterruptible sleep.


