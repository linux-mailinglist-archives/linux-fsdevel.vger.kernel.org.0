Return-Path: <linux-fsdevel+bounces-23340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B40AA92ADCF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 03:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E214282CB5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 01:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B7F381BE;
	Tue,  9 Jul 2024 01:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEyVtyV9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF958286A6;
	Tue,  9 Jul 2024 01:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720488459; cv=none; b=A7BPrRIR/3BB7SAbDz8OlTIHRarHVeTuuSjfDKvK2RbtPaAYAUOAYi+hWy9aVUteu0wWRdrS7923VtgSb6PbRYuj2LxMGMixnqWvU4YYd+84uowFMLrA9rzAz7shAfwhRXPFD7+RWFS9GzUzbesT/6m35mzME6tkJ6u1pgNIuzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720488459; c=relaxed/simple;
	bh=sBC45OeBevAAqo8c0ci60elnCiFOJXOkvLC3yW3gny4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQX9jthjbmJp/y8QzCWOskiMdLT7DkhdGpEVRP3ik5WdXhrWJ3S/I+I+Ds46WUPrUAfFOIYW3pHkAJF5dPAl5CIdxFRjRD2yxYT8r2uTJzCaSB0JjObeaLG4ZWVXlkLeU+KqvbXGRp9V2RJJ1eoB7hOzj19XjGpSueQLjgdAqaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEyVtyV9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720488458; x=1752024458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sBC45OeBevAAqo8c0ci60elnCiFOJXOkvLC3yW3gny4=;
  b=TEyVtyV9GEhzcSxQykDtquXzihSHXZdNHV6eHK7ZMPGNzyv9OCQIfo3g
   8vmoUG7o+zOA/BP5zrZsjL05ah+bJ7809yawE5BXuB2Dk7HkkukBfpXFE
   tai5qLyFHm7lSIT52ecv5hyhdKExXLDVBGW66TJMVdonreLjqB0/VfUL2
   AgxHoEFseKVj0QiLUCCF1V7hw3cdZn6YjY2K2DWxnoxh+SqJQnz1nU6eQ
   RGNh121ZbhtYdUrQ2zn6XfI6uVfIoYQ3jr9sz1BgBnmvY3AZf/dCKYwS6
   NSFme9WkDdwCsV6hTXG1Xn/e3sAP76vVyOHYzfh7vBGmkXzYbWgOA21A8
   Q==;
X-CSE-ConnectionGUID: 98fnpccQQH6EVwud1ghgOA==
X-CSE-MsgGUID: hHZjf7RkSDijUKMw5KfIlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="28322540"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="28322540"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 18:27:37 -0700
X-CSE-ConnectionGUID: 1X9aegR3R5+2EY1KaceQ8Q==
X-CSE-MsgGUID: qI8oXd3vSriZkgwJTBl06A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="48104989"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 18:27:37 -0700
Date: Mon, 8 Jul 2024 18:27:36 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org,
	liam.howlett@oracle.com, surenb@google.com, rppt@kernel.org,
	adobriyan@gmail.com
Subject: Re: [PATCH v6 3/6] fs/procfs: add build ID fetching to PROCMAP_QUERY
 API
Message-ID: <ZoySCNydQ-bW6Yg_@tassilo>
References: <20240627170900.1672542-1-andrii@kernel.org>
 <20240627170900.1672542-4-andrii@kernel.org>
 <878qyqyorq.fsf@linux.intel.com>
 <CAEf4BzZHOhruFGinsRoPLtOsCzbEJyf2hSW=-F67hEHhvAsNZQ@mail.gmail.com>
 <Zn86IUVaFh7rqS2I@tassilo>
 <CAEf4Bzb3CnCKZi-kZ21F=qM0BHvJnexgajP0mHanRfEOzzES6A@mail.gmail.com>
 <ZoQTlSLDwaX3u37r@tassilo>
 <CAEf4BzYikHHoPGGX=hZ5283F1DEoinEt0kfRX3kpq2YFhzqyDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYikHHoPGGX=hZ5283F1DEoinEt0kfRX3kpq2YFhzqyDw@mail.gmail.com>

> So what exactly did you have in mind when you were proposing that
> check? Did you mean to do a pass over all VMAs within the process to
> check if there is at least one executable VMA belonging to
> address_space? If yes, then that would certainly be way too expensive
> to be usable.

I was thinking to only report the build ID when the VMA queried
is executable. If software wanted to look up a data symbol
and needs that buildid it would need to check a x vma too.

Normally tools iterate over all the mappings anyways so this
shouldn't be a big burden for them.

Did I miss something?

I guess an alternative would be a new VMA flag, but iirc we're low on
bits there already.

-Andi

