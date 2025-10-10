Return-Path: <linux-fsdevel+bounces-63713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF253BCB665
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 04:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37E994E54D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 02:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C5237163;
	Fri, 10 Oct 2025 02:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="NTEEm1fF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEBA22ACE3
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 02:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760061894; cv=none; b=DaUwm3WsB/4rzvIAT37PTni4D1QkPU2pqPomRyYt2h10JFqw60yCqRN/5Oxsmh4B6gVHQuHzeuO0dIIjmzMA3ljdKcE3+sVNsjNf6UB3a8D1jGsib7eiC2uTms06GeWbPSAr2EC/OZL06anGcP85Hac1nBjEAG9aZ5FT2Vm6NCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760061894; c=relaxed/simple;
	bh=mSVicwHPNwBYbc5eIDs/6z7/izHRfWM3fLKw/ysKU6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LInTNNtaPSFvfgFEPTViPlA5PjIhyP0KuMgUr/zwR3+yEUQpXnIXu3cX3wZhA8ytnBeCbHg9F3PKowYAJuzc3HSQXNgyqH+ajQDUsgVjeUihoPi8fP/7KTIWiyfceLKQXxJ2pn6WCHst/XKtoJQCRmiQVUdIk0ZkUdK8aGU1gYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=NTEEm1fF; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-118-62.bstnma.fios.verizon.net [173.48.118.62])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59A24Ala032648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 22:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1760061858; bh=+i9CZvHErpX1gMxpBo/MZPquUnlVUXMm2JZ6XHVAh6U=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=NTEEm1fF4+b4oTPLfR+Olw6dJMTie0wWcphlTqcCpqkDbhw7EWTo1YRG0kJi3tNUa
	 rgibmZnB8b34ZCzBwgkEKRfWku1ekXeTnzobuHj/lBw27mXbc6KuLa4JWh7ZsIYTyt
	 aS6lXn486jRIcgGBRUQXoM7BsDUWo+lQHEq3y4b5drmRYQhtCxzPP1qTBOseSub+bg
	 wiNOHo8pYZvXUGOH5ODlBFjueImhSemtjSjw3YD12VpIvc66i1Dg/HKu1e8/Ph1Sfl
	 Scw0Q4j2zZCDGbXI1tHWV8Ar81pASC9f92Q/9ZfNyMc/wxgc+6oWH416IdouJSxhvv
	 vktZhk0HaeRqg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 66A832E00D9; Thu, 09 Oct 2025 22:04:10 -0400 (EDT)
Date: Thu, 9 Oct 2025 22:04:10 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Matt Fleming <matt@readmodwrite.com>
Cc: adilger.kernel@dilger.ca, jack@suse.cz, kernel-team@cloudflare.com,
        libaokun1@huawei.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <20251010020410.GE354523@mit.edu>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
 <20251008150705.4090434-1-matt@readmodwrite.com>
 <20251008162655.GB502448@mit.edu>
 <20251009102259.529708-1-matt@readmodwrite.com>
 <20251009175254.d6djmzn3vk726pao@matt-Precision-5490>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009175254.d6djmzn3vk726pao@matt-Precision-5490>

On Thu, Oct 09, 2025 at 06:52:54PM +0100, Matt Fleming wrote:
> On Thu, Oct 09, 2025 at 11:22:59AM +0100, Matt Fleming wrote:
> > 
> > Thanks Ted. I'm going to try disabling the stripe parameter now. I'll report
> > back shortly.
> 
> Initial results look very good. No blocked tasks so far and the mb
> allocator latency is much improved.

OK, so that definitely confirms the theory of what's going on.  There
have been some changes in the latest kernel that *might* address what
you're seeing.  The challenge is that we don't have a easy reproducer
that doesn't involve using a large file system running a production
workload.  If you can only run this on a production server, it's
probably not fair to ask you to try running 6.17.1 and see if it shows
up there.

I do think in the long term, we need to augment thy buddy bitmap in
fs/ext4/mballoc.c with some data structure which tracks free space in
units of stripe blocks, so we can do block allocation in a much more
efficient way for RAID systems.  The simplest way would be to add a
counter of the number of aligned free stripes in the group info
structure, plus a bit array which indicates which aligned stripes are
free.  This is not just to improve stripe allocation, but also when
doing sub-stripe allocation, we preferentially try allocating out of
stripes which are already partially in use.

Out of curiosity, are you using the stride parameter because you're
using a SSD-based RAID array, or a HDD-based RAID array?

      		       	      	   	     	  - Ted

