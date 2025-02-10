Return-Path: <linux-fsdevel+bounces-41434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A31FEA2F745
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 19:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5218A167E60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5582566CA;
	Mon, 10 Feb 2025 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fjee4mD5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E19192B86
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212631; cv=none; b=gb+rkDJtPSoLiMLkNAiJFstQpS6+NQYmDLCVBRozYGFfJ6hbUdm71/+BAFzyzaFLszFwE9D1DjkxU8lyK2WSv/fouXr+ujHO5xmwPqlDmDFMVOQjaV6z9ThGh0DpyGQo7cLqRoP93VladNmQS7sgA1n3jeb4EbOEovUjAuZOlmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212631; c=relaxed/simple;
	bh=plrszGEhhOJeVjyC7n+aazHGZNIi5qc55aIExBaQAL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubNGWfxl63Ku7AN+cbxNW0UUmTVPKr2fIoQAU7SdyaJIdK7XNAuYePIfJngjdx11QNykRQZhBBztdJ+JLc24lQ9S3UeooNVsDnTwWHCUpJ9773hm5uC6jP00w6LX4nbA5VI8DDHZvmcnVnk+94sfLfiA3yPv4X1s7DLSBsdqGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fjee4mD5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739212628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PXcd8TMhIQd0dY517RowXz7dN5q0sny2C8JBNAV9EvA=;
	b=Fjee4mD5vUg5Smg7jDCFVG4IAfYqCFo7YOy+7xzPKg4wwU0xz6alvtUP0umpMzG/lSGqpV
	83bcVqEusY+SzxgfBNBTVhux0Oe1KGnOCxTztGPXzVj2rsMe7lb/UvXWQNCSuGutGssyWz
	qPaMP5ikxQQa4zb7RBT0iL3R3Z5OMz8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-7KP284FwOC2iUJDr_7ciuA-1; Mon,
 10 Feb 2025 13:37:04 -0500
X-MC-Unique: 7KP284FwOC2iUJDr_7ciuA-1
X-Mimecast-MFC-AGG-ID: 7KP284FwOC2iUJDr_7ciuA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC37E19560B1;
	Mon, 10 Feb 2025 18:37:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.113])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BFC961956094;
	Mon, 10 Feb 2025 18:36:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Feb 2025 19:36:36 +0100 (CET)
Date: Mon, 10 Feb 2025 19:36:29 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	David Howells <dhowells@redhat.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Oliver Sang <oliver.sang@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pipe: change pipe_write() to never add a zero-sized
 buffer
Message-ID: <20250210183629.GJ32480@redhat.com>
References: <20250209150749.GA16999@redhat.com>
 <CAHk-=wgYC-iAp4dw_wN3DBWUB=NzkjT42Dpr46efpKBuF4Nxkg@mail.gmail.com>
 <20250209180214.GA23386@redhat.com>
 <CAHk-=whirZek1fZQ_gYGHZU71+UKDMa_MYWB5RzhP_owcjAopw@mail.gmail.com>
 <20250209184427.GA27435@redhat.com>
 <CAHk-=wihBAcJLiC9dxj1M8AKHpdvrRneNk3=s-Rt-Hv5ikqo4g@mail.gmail.com>
 <20250209191510.GB27435@redhat.com>
 <b050f92e-4117-4e93-8ec6-ec595fd8570a@amd.com>
 <20250210172200.GA16955@redhat.com>
 <CAHk-=wj8V1v6QmJ_8X6zznautRq29tXMYzxorOniFx4NtxRE1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj8V1v6QmJ_8X6zznautRq29tXMYzxorOniFx4NtxRE1A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 02/10, Linus Torvalds wrote:
>
> On Mon, 10 Feb 2025 at 09:22, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > +               int avail = PAGE_SIZE - offset;
> >
> > -               if ((buf->flags & PIPE_BUF_FLAG_CAN_MERGE) &&
> > -                   offset + chars <= PAGE_SIZE) {
> > +               if (avail && (buf->flags & PIPE_BUF_FLAG_CAN_MERGE)) {
> >                         ret = pipe_buf_confirm(pipe, buf);
> >                         if (ret)
> >                                 goto out;
> >
> > +                       chars = min_t(ssize_t, chars, avail);
>
> If I read this correctly, this patch is horribly broken.
>
> You can't do partial writes. Pipes have one very core atomicity
> guarantee: from the man-pages:
>
>    PIPE_BUF
>        POSIX.1 says that writes of less than PIPE_BUF bytes must be
>        atomic:

Ah, I didn't know!

Thanks for your explanation and the quick NACK!

> Maybe we should add a comment somewhere about this.

Agreed. It would certainly help the ignorant readers like me ;)

So I guess that the "goto again" logic in sender/receiver in
tools/perf/bench/sched-messaging.c is currently pointless,
DATASIZE == 100 < PIPE_BUF.

Thanks.

Oleg.


