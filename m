Return-Path: <linux-fsdevel+bounces-35325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9FE9D3D87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 15:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C49B1F22A8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 14:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7411AA787;
	Wed, 20 Nov 2024 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdIykk8t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BED174EDB
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112872; cv=none; b=i8SpDgu2hocemn47FiyO4m0hDt9FtD2+v2YIPRHvZpxYPJsvzzzwYfRDZCn4QpT7iA7lzlUDyGUlORcG2V6E3KJJPdYkc1RVMddE0zbTFlDxm5LtiBaUad2wDgwLa96pZn/em/YUGr+cn8vDZTYA9L3YvDszuvaV8Lsig8C36f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112872; c=relaxed/simple;
	bh=p0Zc7C89GezcT9IePEKwx7rCiN6nfzujIaD58wvI68o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeuczbJfRneIVQ3NHqBa1aK1X+uvRzHAsuAHjfUZb/QuCkPai3ur4/TBhtNRmsalhSf9aBS/eiCr9j1mUrvbex51g80WEezp6QRnDQWrrlf21GyrkgtobkGAYwI9NKRBzJIvylh2j/LeZBGCHtaOhlI8MJk5hKC4t4yt8o5gpas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JdIykk8t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732112869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MaINUrxGE8VlxutjVrBStumfgzjXV+9aNIWp1juyD/w=;
	b=JdIykk8traI2qd5Jm92BQiZlmzRPxKir9vlrDN4Gk0skfeFftsDG746ABDGUQJbJIMkXXY
	JxeLyXiIlF4lb0MxIP3oA/c8NQ/3TctMRxnI9F5FRCM91YOV3PELkbt1S2LKP7ag1N4QqE
	p9QtiPL6Or9DOHvlsl/l3KNM91oSD2o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-PNHLcIl7NdCqMNJtVTbpOQ-1; Wed,
 20 Nov 2024 09:27:46 -0500
X-MC-Unique: PNHLcIl7NdCqMNJtVTbpOQ-1
X-Mimecast-MFC-AGG-ID: PNHLcIl7NdCqMNJtVTbpOQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C02A1954128;
	Wed, 20 Nov 2024 14:27:45 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8831F30000DF;
	Wed, 20 Nov 2024 14:27:44 +0000 (UTC)
Date: Wed, 20 Nov 2024 09:29:17 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] iomap: zero range folio batch processing
 prototype
Message-ID: <Zz3yPdRxSguEU2qc@bfoster>
References: <20241119154656.774395-1-bfoster@redhat.com>
 <Zz2f1c4mjR9blfTg@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz2f1c4mjR9blfTg@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Nov 20, 2024 at 12:37:41AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 19, 2024 at 10:46:52AM -0500, Brian Foster wrote:
> > I thought about using ->private along with a custom ->get_folio(), but I
> > don't think that really fits the idea of a built-in mechanism. It might
> > be more appropriate to attach to the iter, but that currently isn't
> > accessible to ->iomap_begin(). I suppose we could define an
> > iomap_to_iter() or some such helper that the fill helper could use to
> > populate the batch, but maybe there are other thoughts/ideas?
> 
> The iter is the right place, and you can get at it using
> container_of as already done by btrfs (and osme of my upcoming code):
> 
> 	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
> 
> 

Ok, yeah.. that's pretty much what I meant by having an iomap_to_iter()
helper, I just wasn't aware that some things were already doing that to
poke at the iter. Thanks.

I'm assuming we'd want this to be a dynamic allocation as well, since
folio_batch is fairly large in comparison (256b compared to 208b
iomap_iter).

Brian


