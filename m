Return-Path: <linux-fsdevel+bounces-36046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDBB9DB240
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 05:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C43282836
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 04:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2A813C3D5;
	Thu, 28 Nov 2024 04:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L4x4RVVh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A87322B;
	Thu, 28 Nov 2024 04:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732769003; cv=none; b=ISpsysLDnJ48sH1i+1bZf6h+nqQNAFVcEmT/rhELoigAQ+CGXAXFHMloUv9rnXM9DIGeKGQpA5DEShwcey1aTX2YktKtOF7r8BVB4gtl7mCBMy7ZXiEs3I7P9AGv5jjZSSXB1Sb9JaJq8RVl1jA/zKawa3M6be5zhLkqTJf7W8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732769003; c=relaxed/simple;
	bh=tPmeI6mINZrGON1HgoVqiNVpURgSxewz8UhLtmLvC1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIlvZrp88gHvgAWD9hJmrwKkp9XS8ai+tvkuZonAid1VabpO7FDnQ3tnqfG72S3m8yp1MxLBg18OXN+YVMN1H4Gzwy0ITLOZa1g+L6gCvUac5J0qW5ADevNJ05KNkE5vVYwX6SSAAdIX/c/M9tzDz5IwA8RkPCivDKjnPg6xx5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L4x4RVVh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bHgQ9J4ArMhQqhydg/zZeEQ2x7DBPsepvZ8L3kMwMfk=; b=L4x4RVVhvER+bf2wYzoTo4Ehm8
	NbVOpFl4ElwRABcTt3icKx6EAkGJTJyW27S7z9K1+TayDnMU7X4/4hSLXb+ueBh/Sy7SNgIWjlkbj
	qwTaGpwAw42HNSUWy0661HEEUVVuC4m7aTWXneS0j59sA2MAP2ZyHylgmK1pe3edSBwbti97GPCiY
	Z0qkP7YHUQm2aRg6d9R5RaLa6916hLnHKkdJkxggAjH/muAovImFnMa6gUmP2a5EcYqAHqAlLd51L
	RGbJRZQQN5B/oBDE3Y55IbdC0oQPFRJCq1+p45q05WmA4iVpbWT0qQw+YhLk6cPUZM9Zkr+Vz5rXq
	5l7hJroA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGWN4-00000002CNv-2gAk;
	Thu, 28 Nov 2024 04:43:18 +0000
Date: Thu, 28 Nov 2024 04:43:18 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Bharata B Rao <bharata@amd.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, nikunj@amd.com, vbabka@suse.cz,
	david@redhat.com, akpm@linux-foundation.org, yuzhao@google.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, joshdon@google.com, clm@meta.com
Subject: Re: [RFC PATCH 0/1] Large folios in block buffered IO path
Message-ID: <Z0f05sdTiL8kW9U8@casper.infradead.org>
References: <20241127054737.33351-1-bharata@amd.com>
 <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
 <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com>
 <3947869f-90d4-4912-a42f-197147fe64f0@amd.com>
 <CAGudoHEN-tOhBbdr5hymbLw3YK6OdaCSfsbOL6LjcQkNhR6_6A@mail.gmail.com>
 <5a517b3a-51b2-45d6-bea3-4a64b75dfd30@amd.com>
 <CAGudoHHBu663RSjQUwi14_d+Ln6mw_ESvYCc6dTec-O0Wi1-Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHHBu663RSjQUwi14_d+Ln6mw_ESvYCc6dTec-O0Wi1-Eg@mail.gmail.com>

On Thu, Nov 28, 2024 at 05:22:41AM +0100, Mateusz Guzik wrote:
> This means that the folio waiting stuff has poor scalability, but
> without digging into it I have no idea what can be done. The easy way

Actually the easy way is to change:

#define PAGE_WAIT_TABLE_BITS 8

to a larger number.

> out would be to speculatively spin before buggering off, but one would
> have to check what happens in real workloads -- presumably the lock
> owner can be off cpu for a long time (I presume there is no way to
> store the owner).

So ...

 - There's no space in struct folio to put a rwsem.
 - But we want to be able to sleep waiting for a folio to (eg) do I/O.

This is the solution we have.  For the read case, there are three
important bits in folio->flags to pay attention to:

 - PG_locked.  This is held during the read.
 - PG_uptodate.  This is set if the read succeeded.
 - PG_waiters.  This is set if anyone is waiting for PG_locked [*]

The first thread comes along, allocates a folio, locks it, inserts
it into the mapping.
The second thread comes along, finds the folio, sees it's !uptodate,
sets the waiter bit, adds itself to the waitqueue.
The third thread, ditto.
The read completes.  In interrupt or maybe softirq context, the
BIO completion sets the uptodate bit, clears the locked bit and tests
the waiter bit.  Since the waiter bit is set, it walks the waitqueue
looking for waiters which match the locked bit and folio (see
folio_wake_bit()).

So there's not _much_ of a thundering herd problem here.  Most likely
the waitqueue is just too damn long with a lot of threads waiting for
I/O.

[*] oversimplification; don't worry about it.

