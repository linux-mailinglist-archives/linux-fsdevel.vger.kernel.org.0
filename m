Return-Path: <linux-fsdevel+bounces-40235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2535A20B98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 14:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E38B3A5E04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 13:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A851A8F6D;
	Tue, 28 Jan 2025 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAZoMyJg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5955199FAB
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738072523; cv=none; b=UP22lbeHYV0gU6pbskhdrB5OIXuMd1/9o77/Rp9EP5cA0bhnMpvopf4Hk9RNg8PTc0BUe3EqF408eEqM8WQquwcKjAlfQz6qSgBf3H6aKcOxloWYJTTGSiMalKPbmzLgJ2uA0dYtEb00uH2kj66ovW/QC/45EFNGCl4ipg3ADas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738072523; c=relaxed/simple;
	bh=VPEvCUdcTDDyxm6RZ+WwoWbgaYSmkW0AOcLkcfzB6qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iL2A+CYxhWegUqc7W57VqGsfBg7vOoSYSELW4kLdkwCrQEWENV/9CxM+1RzkM1m4IUYvPyhNTiQp+PkFjiAXNg/FDf4GzXBgSs8xRSBW2qJFl32Jz+D8eCw4+C/v/1cf+esISW/VbfOPszEKCXoXUh0RL3e/nmcq6DFrZDyc7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aAZoMyJg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738072520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y0awQQoqamDdf6hmE2qj5vIkQWsOvHfrmYqN0w07Tgw=;
	b=aAZoMyJgv5Cghmp10k3ZyX5BXy0AnVMzDV7SJy1YMpyDR+7N+MIsAvLNSJwFZhN52sjpcA
	RD2v/sgaZpwAXAj1z9mQtk/sDk2AYtv+fCN0ZmSNoNvIoIRxDQWRqxrIJOaC9uhEBzG0S3
	17gF3CBxB1Ei0ZL6vk53F792PIrs9JA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-LqKFgQNoM_yGe5loRFz60g-1; Tue,
 28 Jan 2025 08:55:17 -0500
X-MC-Unique: LqKFgQNoM_yGe5loRFz60g-1
X-Mimecast-MFC-AGG-ID: LqKFgQNoM_yGe5loRFz60g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A36D19560A3;
	Tue, 28 Jan 2025 13:55:16 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.118])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4ED2130001BE;
	Tue, 28 Jan 2025 13:55:15 +0000 (UTC)
Date: Tue, 28 Jan 2025 08:57:27 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 6/7] iomap: advance the iter directly on unshare range
Message-ID: <Z5jiR8vjG7MT3Psv@bfoster>
References: <20250122133434.535192-1-bfoster@redhat.com>
 <20250122133434.535192-7-bfoster@redhat.com>
 <Z5htdTPrS58_QKsc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5htdTPrS58_QKsc@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jan 27, 2025 at 09:39:01PM -0800, Christoph Hellwig wrote:
> On Wed, Jan 22, 2025 at 08:34:33AM -0500, Brian Foster wrote:
> > +	size_t bytes = iomap_length(iter);
> 
> > +		bytes = min_t(u64, SIZE_MAX, bytes);
> 
> bytes needs to be a u64 for the min logic to work on 32-bit systems.
> 

Ah, thanks. FYI, I also have the following change from followon work to
fold into this to completely remove advances via iter.processed:

-       if (!iomap_want_unshare_iter(iter))
-               return bytes;
+       if (!iomap_want_unshare_iter(iter)) {
+               iomap_iter_advance(iter, bytes);
+               return 0;
+       }

And the analogous change in the next patch for zero range (unwritten &&
!range_dirty) as well.

Finally, I'm still working through converting the rest of the ops to use
iomap_iter_advance(), but I was thinking about renaming iter.processed
to iter.status as a final step. Thoughts on a rename in general or on
the actual name?

Brian


