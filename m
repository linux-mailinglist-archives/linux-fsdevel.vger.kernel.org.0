Return-Path: <linux-fsdevel+bounces-40893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 347A6A281C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 03:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF213A56FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 02:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67285212D68;
	Wed,  5 Feb 2025 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfnsoiX2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5BE78F4C
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722492; cv=none; b=gIoSqf7LxBZyqx+JuzNl247EWbj6maJJ4oxE0+x7ZpAIO4s6+uacVGvYfjYputmnTDkbUiZHleMfeMIouMz0dXtYP1a8TDEQKOfFeNBFY0NDrP4Qn2LHuRrrJCuzcfZayYH2IutOfo/e+clzRPV2Z7f7RSNfPfkXosuTSrxaVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722492; c=relaxed/simple;
	bh=kxDSnmcLSkprIP6MFrOgYbru6QXt2wLziq50MQzCueo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqheN5KzMp5RvxLYfog/STlt0/DyBlCtFfe5DQj+zruBYmOqzHtB+SywupRAN8sF6FRQcPGVf1J5RrNZGtTCJwfhOtJgTWsWzVLMdLhs+BFDghjVJyKnGTHxZjYYIUE8+2UbTXAiPCYbLJYSZ5VQVxib9qpD4zm0PzM041s8z5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfnsoiX2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738722489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cKLoT1hLBEAEE6EdkFVMb1fVq76cMS7uiMXFZgfhdXM=;
	b=QfnsoiX2W1aOEJsRHxbBnlx3TbfppuPqkb6SORzmdM3F4ExFRDEGJ84ivtg4bzB1RlO0tD
	p+t+FlICQpWGLQESpHxA40RzIwzcYEiiX8DGG66lR50+0vxDjAWxGG6HPcXFhAiklH5BDk
	/Wh4+baOdt+gbaqDKluzI2q2JjcR6aM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-N4ujSK1BOQOzcGmwGU_BOg-1; Tue,
 04 Feb 2025 21:28:03 -0500
X-MC-Unique: N4ujSK1BOQOzcGmwGU_BOg-1
X-Mimecast-MFC-AGG-ID: N4ujSK1BOQOzcGmwGU_BOg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0F8C18009A8;
	Wed,  5 Feb 2025 02:28:01 +0000 (UTC)
Received: from fedora (unknown [10.72.116.78])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B99B18008D0;
	Wed,  5 Feb 2025 02:27:55 +0000 (UTC)
Date: Wed, 5 Feb 2025 10:27:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: David Wei <dw@davidwei.uk>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bschubert@ddn.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] FUSE io_uring zero copy
Message-ID: <Z6LMpdbqiHSY5W9v@fedora>
References: <dc3a5c7d-b254-48ea-9749-2c464bfd3931@davidwei.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc3a5c7d-b254-48ea-9749-2c464bfd3931@davidwei.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello David,

On Thu, Jan 30, 2025 at 01:28:55PM -0800, David Wei wrote:
> Hi folks, I want to propose a discussion on adding zero copy to FUSE
> io_uring in the kernel. The source is some userspace buffer or device
> memory e.g. GPU VRAM. The destination is FUSE server in userspace, which
> will then either forward it over the network or to an underlying
> FS/block device. The FUSE server may want to read the data.
> 
> My goal is to eliminate copies in this entire data path, including the
> initial hop between the userspace client and the kernel. I know Ming and
> Keith are working on adding ublk zero copy but it does not cover this
> initial hop and it does not allow the ublk/FUSE server to read the data.

Not sure get the point, it depends on if the kernel buffer is initialized,
and you can't read data from one uninitialized kernel buffer.

But if it is userspace or device buffer, the limit may be relaxed.

> 
> My idea is to use shared memory or dma-buf, i.e. the source data is
> encapsulated in an mmap()able fd. The client and FUSE server exchange
> this fd through a back channel with no kernel involvement. The FUSE
> server maps the fd into its address space and registers the fd with

This approach need client code modification, which isn't generic and
can't cover existed posix applications.

There could be too many client processes, does this way really scale?

> io_uring via the io_uring_register() infra. When the client does e.g. a
> DIO write, the pages are pinned and forwarded to FUSE kernel, which does

BTW, fuse supports write zero copy already, just read zero copy isn't
supported.

> a lookup and understands that the pages belong to the fd that was
> registered from the FUSE server. Then io_uring tells the FUSE server
> that the data is in the fd it registered, so there is no need to copy
> anything at all.
> 
> I would like to discuss this and get feedback from the community. My top
> question is why do this in the kernel at all? It is entirely possible to
> bypass the kernel entirely by having the client and FUSE server exchange
> the fd and then do the I/O purely through IPC.

IMO, client code modification may not be accepted for existed applications.


Thanks,
Ming


