Return-Path: <linux-fsdevel+bounces-51161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF02AD3611
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 14:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC99C175804
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 12:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80AD290DAA;
	Tue, 10 Jun 2025 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erC1vSIi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB8822578E
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558199; cv=none; b=Xr68pCLk9LaQKOumUKvAqR16e6SnsuWM2bdI2TKwdhCntMawH1FUMOfZCEy4KJB6wbaUXOh6PRlPE+0i/laV4vbBja/Gbaf++sus+g1vne9sbiBNZ4XUl+LuCE8Nn9xQJMry4FiACRcNlLwE09Fuqzh2FeuvjQ4UN9zYIpufVJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558199; c=relaxed/simple;
	bh=Mx+m0Kvr3P5//+kfdE27LV2gIzvBClZH1GCPHM85MaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iscwZpc5b3I1H7vqB9ewPUT2ysOL7QAbM3Md5VV/HS+OGJpfig4aSVMOatqnSdZo8hc87k7oAO1U8czuYZqNeEnPqk0AkRXRjH+7ARMMWwiTrHqcjclt1GvrAoLLYf9Q6+vShStZYIRlYooWVe/xuDbhhU6wu1zQqscwMNLUj4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erC1vSIi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749558196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GiWXWdJikqoIX0QaIbtyGeuDqgzC7gx2eetCW8Ce0Fw=;
	b=erC1vSIi9TV6wzD27i3JlAzCD/piF0l3jnq6xmzGT+oqywdvtsOr3d4yTrp3nJY7TNAnsx
	OXL1bSu9hbnlgcdoscDqm2/UQ4thmSHMmN81HJEBVtVkeaOla+q4HDufUBeQl8l3jL5tiq
	LH/kCfUFbvfoXeY2w49krUrNFxadvGk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-ypkTm2-fP4-Suj9YEK5lUg-1; Tue,
 10 Jun 2025 08:23:12 -0400
X-MC-Unique: ypkTm2-fP4-Suj9YEK5lUg-1
X-Mimecast-MFC-AGG-ID: ypkTm2-fP4-Suj9YEK5lUg_1749558191
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2242D195608E;
	Tue, 10 Jun 2025 12:23:11 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.100])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59A1E19560A3;
	Tue, 10 Jun 2025 12:23:10 +0000 (UTC)
Date: Tue, 10 Jun 2025 08:26:45 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC 7/7] xfs: error tag to force zeroing on debug kernels
Message-ID: <aEgkhYne8EenhJfI@bfoster>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-8-bfoster@redhat.com>
 <aEe1oR3qRXz-QB67@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEe1oR3qRXz-QB67@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Jun 09, 2025 at 09:33:37PM -0700, Christoph Hellwig wrote:
> On Thu, Jun 05, 2025 at 01:33:57PM -0400, Brian Foster wrote:
> > iomap_zero_range() has to cover various corner cases that are
> > difficult to test on production kernels because it is used in fairly
> > limited use cases. For example, it is currently only used by XFS and
> > mostly only in partial block zeroing cases.
> > 
> > While it's possible to test most of these functional cases, we can
> > provide more robust test coverage by co-opting fallocate zero range
> > to invoke zeroing of the entire range instead of the more efficient
> > block punch/allocate sequence. Add an errortag to occasionally
> > invoke forced zeroing.
> 
> I like this, having an easy way to improve code coverage using the
> existing fallocate and errtag interfaces is always a good thing.
> 
> Can I assume you plan to add a testcase using the errtag to xfstests?
> 

Well that is kind of the question.. ;) My preference was to either add
something to fstests to enable select errortags by default on every
mount (or do the same in-kernel via XFS_DEBUG[_ERRTAGS] or some such)
over just creating a one-off test that runs fsx or whatever with this
error tag turned on. [1].

That said, I wouldn't be opposed to just doing both if folks prefer
that. It just bugs me to add yet another test that only runs a specific
fsx test when we get much more coverage by running the full suite of
tests. IOW, whenever somebody is testing a kernel that would actually
run a custom test (XFS_DEBUG plus specific errortag support), we could
in theory be running the whole suite with the same errortag turned on
(albeit perhaps at a lesser frequency than a custom test would use). So
from that perspective I'm not sure it makes a whole lot of sense to do
both.

So any thoughts from anyone on a custom test vs. enabling errortag
defaults (via fstests or kernel) vs. some combination of both?

Brian

[1] Eric also raised the idea of branching off "test tag" variants of
errortags that might help distinguish injection points that control
behavior vs. those that truly create errors. That could reduce confusion
for testers and whatnot.

I haven't dug into viability, but in theory that could also define a set
of events that don't spew event trigger noise into dmesg if certain
events were to be enabled by default (again, on debug kernels only).


