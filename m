Return-Path: <linux-fsdevel+bounces-67660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EA3C45D2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 11:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A17704EB7B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35C6303A1B;
	Mon, 10 Nov 2025 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWxfpDiK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE59B30275B
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769043; cv=none; b=JBP5eeNlUQLEJY4OB5m+WrXni4nTt8AjZ7Ggr0Aygz+OtPzjssJZmIOG5PAlbYiQ8lwStKpm3LR8HMPEACYqJNISGdVDcAgbRkzl9Jqc5fduXOXHu0eQhvGel6EayIavW2YacVa9yrhOHKbitl/OCUKW6sHE6Pz8lYLZySZ/22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769043; c=relaxed/simple;
	bh=xMPm2roPNOiQD1q4be1XihMW21gDvf9YbXLroWX6Tnw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YOa4qgTKmUUj4xoYV3LtcJPdgra1kHs7mxNYllMwGZUqpVB15FrGPf3JiR+j9GYIXqdgwCBobkJJN3cYamsVu2GV0PUSvaujx+H0JgMG6SlX4xLjKMOWHeZrdDYw8LaloHREtrk5CeZFPGzAFHqjaf+gr1D4Isa8mbwnltRa6as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWxfpDiK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762769040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qycs3QBWuphW6IaV/2MMmVqLjCAStIYoGfDJBOz4Br0=;
	b=HWxfpDiKKEWBnJmmnuqSZ83+yCMovqgaUIxguYMLQmlmcns990gG7Ub3Wexzo0fl26XCdn
	VGdc7uVN0WcgHiVtdUxQVddA4rOSm/PL1lq6DKGsA5W8EuONzhKFFrQEprc5ni3lTXgLBl
	GCHVHgeyscx2RVsbbNC2ai0eG7MH6Fo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-aFxD10TfOmGWdUeGPQvyBQ-1; Mon,
 10 Nov 2025 05:03:56 -0500
X-MC-Unique: aFxD10TfOmGWdUeGPQvyBQ-1
X-Mimecast-MFC-AGG-ID: aFxD10TfOmGWdUeGPQvyBQ_1762769034
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6EADA195609F;
	Mon, 10 Nov 2025 10:03:54 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.47])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A5391800576;
	Mon, 10 Nov 2025 10:03:50 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>,  Matthew Wilcox
 <willy@infradead.org>,  Hans Holmberg <hans.holmberg@wdc.com>,
  linux-xfs@vger.kernel.org,  Carlos Maiolino <cem@kernel.org>,  "Darrick J
 . Wong" <djwong@kernel.org>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
In-Reply-To: <20251110093828.GC22674@lst.de> (Christoph Hellwig's message of
	"Mon, 10 Nov 2025 10:38:28 +0100")
References: <20251106133530.12927-1-hans.holmberg@wdc.com>
	<lhuikfngtlv.fsf@oldenburg.str.redhat.com>
	<20251106135212.GA10477@lst.de>
	<aQyz1j7nqXPKTYPT@casper.infradead.org>
	<lhu4ir7gm1r.fsf@oldenburg.str.redhat.com>
	<20251106170501.GA25601@lst.de> <878qgg4sh1.fsf@mid.deneb.enyo.de>
	<aRESlvWf9VquNzx3@dread.disaster.area>
	<lhuseem1mpe.fsf@oldenburg.str.redhat.com>
	<20251110093828.GC22674@lst.de>
Date: Mon, 10 Nov 2025 11:03:48 +0100
Message-ID: <lhu1pm6yzjv.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

* Christoph Hellwig:

> On Mon, Nov 10, 2025 at 06:27:41AM +0100, Florian Weimer wrote:
>> Sorry, I made the example confusing.
>> 
>> How would the application deal with failure due to lack of fallocate
>> support?  It would have to do a pwrite, like posix_fallocate does to
>> today, or maybe ftruncate.  This is way I think removing the fallback
>> from posix_fallocate completely is mostly pointless.
>
> In general it would ftruncate.  If it thinks it can't work without
> preallocation at all the application will fail, as again the lack
> of posix_fallocate means that space can't be preallocated.

Hmm.  It's not a 1:1 replacement: someone really needs to understand the
code and see what the appropriate way to deal with the situation is.  Of
course the posix_fallocate fallback path (or an application-level
equivalent) has the potential for data loss, too.  It's just a different
trade-off.

Thanks,
Florian


