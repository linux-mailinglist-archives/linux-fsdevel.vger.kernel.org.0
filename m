Return-Path: <linux-fsdevel+bounces-70332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B29C9718A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 12:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 30E3B3425D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 11:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830692E8E13;
	Mon,  1 Dec 2025 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d+87uf4E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B228468D;
	Mon,  1 Dec 2025 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764589581; cv=none; b=cwtB84dwWpTHBsZBbQ0vm/9tOHii5jXOGnoP5ma8nEWyHYzsNg81ndrk9gYRNI0tRlFIgFL9KK0aLB2H/HWli5pOIp6xrBEsedlbJGL2lTwvf5Py59bOf2WbUNdgpBTt44ihHn4YPpr4x0S6dcdQZtFCzuWKsEh3fZ+sIZ+OHtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764589581; c=relaxed/simple;
	bh=C8jWhonQSiI3/Db8s6En0b/Em3GcnYqGTPHMdeRIaE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYFbEGmxMnr6odNJTVWx22NRPV5u+cGwB9X+/rzgACjpbHkRcEA49TFJySYzQA1JA/JVGS9EEiV5JtMa1JIjH137Z4LgrFtLOaAk1H8f5U+dIhICbQNZwrbnQGPYKxUWLAozQrb0E/ebbWKOLJx0rJ/PWVEQGPinJv887xXT52I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d+87uf4E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cwEuKGYRqZA39uVEfcGrbmePQmeqGzVrdA0MEw7phmk=; b=d+87uf4E9gM5Z+P90ZKEYKaaNT
	EBLQf4tbe+t6IIkyLM8iPK+ZXmU1WAetdZfnk/e1AGsBxd4TpDdmzYE2pPpxssoA6Rup3DgxgjLDa
	g+dL20jx9EoH/KXmnfyghUgNjayz235zYjjICba/EjsWxnYy+swpvyEZtKlgwvIyAGT4vPwYZsQj+
	JhyJKfMirZVqnQgqBzzFuTdMJxEqtFbPOJsv88UEJOYAWvvyycMaYOWd9BDLoRUCjklH1IOoeZOk1
	+bphbxpjcU92HKsyQaMWBqtosC/sg0+G/Mnl/N+X8wo2l8kjoYqoyx7CNCKkWjCCakLlj1NEfb5Lg
	cstbiPMw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ2M4-0000000H9dK-1XkJ;
	Mon, 01 Dec 2025 11:46:08 +0000
Date: Mon, 1 Dec 2025 11:46:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@lst.de, tytso@mit.edu, jack@suse.cz,
	djwong@kernel.org, josef@toxicpanda.com, sandeen@sandeen.net,
	rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com,
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Subject: Re: [PATCH v2 01/11] ntfsplus: in-memory, on-disk structures and
 headers
Message-ID: <aS2AAKmGcNYgJzx6@casper.infradead.org>
References: <20251127045944.26009-1-linkinjeon@kernel.org>
 <20251127045944.26009-2-linkinjeon@kernel.org>
 <aS1AUP_KpsJsJJ1q@infradead.org>
 <aS1WGgLDIdkI4cfj@casper.infradead.org>
 <CAKYAXd-UO=E-AXv4QiwY6svgjdO59LsW_4T6YcmJuW9nXZJEzg@mail.gmail.com>
 <aS16g_mwGHqbCK5g@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS16g_mwGHqbCK5g@infradead.org>

On Mon, Dec 01, 2025 at 03:22:43AM -0800, Christoph Hellwig wrote:
> On Mon, Dec 01, 2025 at 07:13:49PM +0900, Namjae Jeon wrote:
> > CPU intensive spinning only occurs if signals are delivered extremely
> > frequently...
> > Are there any ways to improve this EINTR handling?
> > Thanks!
> 
> Have an option to not abort when fatal signals are pending?

I'd rather not add a sixth argument to do_read_cache_folio().

And I'm not sure the right question is being asked here.  Storage can
disappear at any moment -- somebody unplugs the USB device, the NBD
device that's hosting the filesystem experiences a network outage, etc.

So every filesystem _should_ handle fatal signals gracefully.  The task
must die, even if it's in the middle of reading metadata.  I know that's
not always the easiest thing to do, but it is the right thing to do.

