Return-Path: <linux-fsdevel+bounces-12080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8239285B0E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 03:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12C54B22CF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 02:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1771F44C7C;
	Tue, 20 Feb 2024 02:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ltWv/YZq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7132D1E88A;
	Tue, 20 Feb 2024 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708396090; cv=none; b=igjkzqW/GHKnNFfRkXwumAvNcDqaKAxdf0dxbmh4BlnNrikuqBfD7uB/Na6W98E8uH3FX3nWV9mi59IlzIM208PFw9YlqiyDV5K5FBkKQSNSxz0ETYf+DoMd+nmNgA/KUwDSyGNZdSWoHS5bMCVnkjCzZ8iW/i7KOKvYlgvlMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708396090; c=relaxed/simple;
	bh=g19aHEmjFQ5tSUUNdPZtI2asKF0wN+dEKgAolGDccIo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jfsZ3t3U7XDQd5pVUENC2vGMFSbc3SjolkKCWIp7rDn9ln7gAFArB137TbQlD9LNq+/V/PmQDtT68cbsIxZDTiI5sjR3NA1QVTrdN10k+tJbYOAFO7W9Vog85JJ14prIDVpO5bsgVhiT6rJX8N1X3UcPOTz40mpYSXMX7DF1ing=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ltWv/YZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB511C433F1;
	Tue, 20 Feb 2024 02:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708396090;
	bh=g19aHEmjFQ5tSUUNdPZtI2asKF0wN+dEKgAolGDccIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ltWv/YZqIm7Ia0akbwKFqWLV83KaIHAYNaIacwP1NBARaD8lrJCVtwtg0c68+w24W
	 jOKItH+DtztnP7owYaHqcDtXAK17W5jcR83LJ7h6pTn7cDNLqu4ofWGkLZ8zvlo8oS
	 5j4V0FS5Q/0Ui5x/QbbdkrdBv6g9SHDMbxV1l7FQ=
Date: Mon, 19 Feb 2024 18:28:08 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: willy@infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, gost.dev@samsung.com, p.raghav@samsung.com,
 da.gomez@samsung.com, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] test_xarray: fix soft lockup for advanced-api tests
Message-Id: <20240219182808.726500bf3546b49ac05d98d4@linux-foundation.org>
In-Reply-To: <20240216194329.840555-1-mcgrof@kernel.org>
References: <20240216194329.840555-1-mcgrof@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 11:43:29 -0800 Luis Chamberlain <mcgrof@kernel.org> wrote:

> The new adanced API tests

So this is a fix against the mm-unstable series "test_xarray: advanced
API multi-index tests", v2.

> want to vet the xarray API is doing what it
> promises by manually iterating over a set of possible indexes on its
> own, and using a query operation which holds the RCU lock and then
> releases it. So it is not using the helper loop options which xarray
> provides on purpose. Any loop which iterates over 1 million entries
> (which is possible with order 20, so emulating say a 4 GiB block size)
> to just to rcu lock and unlock will eventually end up triggering a soft
> lockup on systems which don't preempt, and have lock provin and RCU
> prooving enabled.
> 
> xarray users already use XA_CHECK_SCHED for loops which may take a long
> time, in our case we don't want to RCU unlock and lock as the caller
> does that already, but rather just force a schedule every XA_CHECK_SCHED
> iterations since the test is trying to not trust and rather test that
> xarray is doing the right thing.
> 
> [0] https://lkml.kernel.org/r/202402071613.70f28243-lkp@intel.com
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>

As the above links shows, this should be

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202402071613.70f28243-lkp@intel.com

> --- a/lib/test_xarray.c
> +++ b/lib/test_xarray.c
> @@ -781,6 +781,7 @@ static noinline void *test_get_entry(struct xarray *xa, unsigned long index)
>  {
>  	XA_STATE(xas, xa, index);
>  	void *p;
> +	static unsigned int i = 0;

I don't think this needs static storage.

PetPeeve: it is unexpected that `i' has unsigned type.  Can a more
communicative identifier be used?


I shall queue your patch as a fixup patch against
test_xarray-add-tests-for-advanced-multi-index-use and shall add the
below on top.  Pleae check.

--- a/lib/test_xarray.c~test_xarray-fix-soft-lockup-for-advanced-api-tests-fix
+++ a/lib/test_xarray.c
@@ -728,7 +728,7 @@ static noinline void *test_get_entry(str
 {
 	XA_STATE(xas, xa, index);
 	void *p;
-	static unsigned int i = 0;
+	unsigned int loops = 0;
 
 	rcu_read_lock();
 repeat:
@@ -746,7 +746,7 @@ repeat:
 	 * APIs won't be stupid, proper page cache APIs loop over the proper
 	 * order so when using a larger order we skip shared entries.
 	 */
-	if (++i % XA_CHECK_SCHED == 0)
+	if (++loops % XA_CHECK_SCHED == 0)
 		schedule();
 
 	return p;
_


