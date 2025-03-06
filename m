Return-Path: <linux-fsdevel+bounces-43351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5611A54AFD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 13:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2BD16DC70
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 12:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827B220CCCC;
	Thu,  6 Mar 2025 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDrLu4I9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEA820C479
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264931; cv=none; b=uCQNb7okQT8Lb6ccV2Mm3QHxggHFVS65W5loSQgoc0MKXDjN45DGBf8EZL3NuYMwxd4NBhJtPRIC38/yaXa+eKP4Xd/gsjAtNPZd6EvB0ZZw3O46+4g1Mhg/qaDuZnDa0C8WNynxAHFiH8IOiwOW3XJzGxCYsd44kR7e3Fbk3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264931; c=relaxed/simple;
	bh=eP1g9nlyYI9CoKkIY1xPDI2Sac0aG/68toWY/f4XmOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4Fdv/BxIqx3MOev4OIJHFWkU5IQOywOpR6T55lr3ldA5Lb9dXrTWckW860gDoJy0YqGTsf3TK4g20TkRsGrpQA5NoisFFXWDfTcjLR/9PvtdC6/BiAm4opYooHFUfetb9/rMwe6sTgCr2mFQAmf8kv+OO/c2qVaC9Bbv6oF/WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDrLu4I9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741264928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OPM/bCOOX2GDDU6yA/rUlU5U2LhtBTM4alZ9ThMJ7Vs=;
	b=eDrLu4I9o9WpbbOCMfaSQpw8v1ZoGAWD17rAm6eBs4Mbpr4ctDx/n5vbvLm/J2WtTI20MJ
	zTWSb0RGWryfInXssYi+oLFMIdZJlhe91p+moSSYGa0nQvmY4R3XDHFaL7fEilob8hw9iD
	h1G+56SF5l/8FcM7/LTk6OiFD+0SoT0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-oZUYr1CKPBuiVKGau2zVhQ-1; Thu,
 06 Mar 2025 07:42:03 -0500
X-MC-Unique: oZUYr1CKPBuiVKGau2zVhQ-1
X-Mimecast-MFC-AGG-ID: oZUYr1CKPBuiVKGau2zVhQ_1741264921
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53C0C19560B0;
	Thu,  6 Mar 2025 12:42:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.240])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E5570300019E;
	Thu,  6 Mar 2025 12:41:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  6 Mar 2025 13:41:29 +0100 (CET)
Date: Thu, 6 Mar 2025 13:41:21 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Rasmus Villemoes <ravi@prevas.dk>, Neeraj.Upadhyay@amd.com,
	Ananth.narayan@amd.com, Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: Re: [RFC PATCH 3/3] treewide: pipe: Convert all references to
 pipe->{head,tail,max_usage,ring_size} to unsigned short
Message-ID: <20250306124120.GF19868@redhat.com>
References: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
 <20250306113924.20004-1-kprateek.nayak@amd.com>
 <20250306113924.20004-4-kprateek.nayak@amd.com>
 <20250306123245.GE19868@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306123245.GE19868@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 03/06, Oleg Nesterov wrote:
>
> On 03/06, K Prateek Nayak wrote:
> >
> > @@ -272,9 +272,9 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
> >  	 */
> >  	for (;;) {
> >  		/* Read ->head with a barrier vs post_one_notification() */
> > -		unsigned int head = smp_load_acquire(&pipe->head);
> > -		unsigned int tail = pipe->tail;
> > -		unsigned int mask = pipe->ring_size - 1;
> > +		unsigned short head = smp_load_acquire(&pipe->head);
> > +		unsigned short tail = pipe->tail;
> > +		unsigned short mask = pipe->ring_size - 1;
>
> I dunno... but if we do this, perhaps we should
> s/unsigned int/pipe_index_t instead?
>
> At least this would be more grep friendly.

in any case, I think another cleanup before this change makes sense...
pipe->ring_size is overused. pipe_read(), pipe_write() and much more
users do not need "unsigned int mask", they can use pipe_buf(buf, slot)
instead.

Oleg.


