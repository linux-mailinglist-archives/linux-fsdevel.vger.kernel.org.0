Return-Path: <linux-fsdevel+bounces-34460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A06D9C5B36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 16:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3C53B63350
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6598A1FBF5D;
	Tue, 12 Nov 2024 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aF4cCIGX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92CB1F6677
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419950; cv=none; b=AWIDFecxl3Ozq2/CHVKBUCjHtywtvipEFxn2bk003AK5RTqlG9E9S6juj8BoyZHoWJW5RbJPLFli0zeoBiVQtzBlaA4eK8DNjjqAeMy2pFusd5xZ0NYDDQsTu8p/7z2WdGeV0ZEqMz0uwJYiq9SN8Xs21uyvO2weeS+NCAavlhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419950; c=relaxed/simple;
	bh=n73oBx1UGZDNkycHp8Ut2yvubYvojk5RNGOm4WEaZ+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQEI2CAP625TptcfOvst5qCWDuxVIJoaHOXaVkkXGu3Tx1mcc9DWOzRQFOFQDRPqxDBMNCwWuJIQkFY1O8tskrzqDpQuqkRlnwYK3V0bMAaB67gvNiwYtIKOzNYXimsTxpJAa8fu7Yax7OBfYoxyhHZvyLnHzClBU9+NQNfXMKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aF4cCIGX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731419948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OYHEazC3kMdgaU4WAhtrRVWgw83NovZFNBSgOxQWLV4=;
	b=aF4cCIGX9QmJXasH8qJR8BUZASK/VREpmo9Tw5XMziurYpwuCL9cCRhu9Yrzzk42/e8XV9
	1yjxmLvW+oLEpZsSGHvDDe4O2Vlv2+TAG8ShGBxi3u/fMaAKnaWxJNLe5rkYuZEPCKdAFf
	8TAhcqnO8RY2MDtjGvjicgVw4EouXFY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-SXj649TXNxiNH8QXHvkBWw-1; Tue,
 12 Nov 2024 08:59:04 -0500
X-MC-Unique: SXj649TXNxiNH8QXHvkBWw-1
X-Mimecast-MFC-AGG-ID: SXj649TXNxiNH8QXHvkBWw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D94B71955D62;
	Tue, 12 Nov 2024 13:59:03 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 413DD19560A3;
	Tue, 12 Nov 2024 13:59:03 +0000 (UTC)
Date: Tue, 12 Nov 2024 09:00:35 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iomap: lift zeroed mapping handling into
 iomap_zero_range()
Message-ID: <ZzNfg2E7TyMyo86h@bfoster>
References: <20241108124246.198489-1-bfoster@redhat.com>
 <20241108124246.198489-3-bfoster@redhat.com>
 <ZzGeQGl9zvQLkRfZ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzGeQGl9zvQLkRfZ@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sun, Nov 10, 2024 at 10:03:44PM -0800, Christoph Hellwig wrote:
> On Fri, Nov 08, 2024 at 07:42:44AM -0500, Brian Foster wrote:
> > In preparation for special handling of subranges, lift the zeroed
> > mapping logic from the iterator into the caller.
> 
> What's that special code?  I don't really see anything added to this
> in the new code?  In general I would prefer if all code for the
> iteration would be kept in a single function in preparation for
> unrolling these loops.  If you want to keep this code separate
> from the write zeroes logic (which seems like a good idea) please
> just just move the actual real zeroing out of iomap_zero_iter into
> a separate helper similar to how we e.g. have multiple different
> implementations in the dio iterator.
> 

There is no special code... the special treatment is to check the dirty
state of a block unaligned start in isolation to decide whether to skip
or explicitly zero if dirty. The fallback logic is to check the dirty
state of the entire range and if needed, flush the mapping to push all
pending (dirty && unwritten) instances out to the fs so the iomap is up
to date and we can safely skip iomaps that are inherently zero on disk.

Hmm.. so I see the multiple iter modes for dio, but it looks like that
is inherent to the mapping type. That's not quite what I'm doing here,
so I'm not totally clear on what you're asking for. FWIW, I swizzled
this code around a few times and failed to ultimately find something I'd
consider elegant. For example, initial versions would have something
like another param to iomap_zero_iter() to skip the optimization logic
(i.e. don't skip zeroed extents for this call), which I think is more in
the spirit of what you're saying, but I ultimately found it cleaner to
open code that part. If you had something else in mind, could you share
some pseudocode or something to show the factoring..?

> > +	while ((ret = iomap_iter(&iter, ops)) > 0) {
> > +		const struct iomap *s = iomap_iter_srcmap(&iter);
> > +
> > +		if (s->type == IOMAP_HOLE || s->type == IOMAP_UNWRITTEN) {
> > +			loff_t p = iomap_length(&iter);
> 
> Also please stick to variable names that are readable and preferably
> the same as in the surrounding code, e.g. s -> srcmap p -> pos.
> 

Sure. I think I did this to avoid long lines, but I can change it.
Thanks.

Brian


