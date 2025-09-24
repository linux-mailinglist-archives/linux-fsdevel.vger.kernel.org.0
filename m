Return-Path: <linux-fsdevel+bounces-62665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CCDB9B9F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 21:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB641B26912
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 19:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F297625F99F;
	Wed, 24 Sep 2025 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQ8Ff9wj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264D260585
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741146; cv=none; b=JuvmdoRYlX0eUzK3h0k17RZWPEWUGSzW8SPgxbygkVlDIbFYhLH1UgBJ2n2loD5pWUH3x9QGenVaVR5KX54guNJek2dYppeXeYpNh4Y7pJVR4kHb0HPD7oDQoFUB8wtN8J+/bwrQzVtyTp7whp+mQaATuq0NrOydPHvFESYsVzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741146; c=relaxed/simple;
	bh=bfdr1izZepy2d7hS8qSaPF7cdm5I0VSenaOU1miTlig=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=oDyrkI5QYFDmgRsmUla4fuZEDTj9TBUYUuwpngKl6NSR2qUHW+5djSLYxBRUVO9G0pD03AxhwzMcL8SW4X76twIBWaLU4w6cUIR/v9KTA/Pgertimm6A3cULJnsXSdPcp4kxyJOVcppmiAfKXJSvLd7xpMnCO3WHTSkWT7jgNlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQ8Ff9wj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758741143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxh2bN/wrBh4C6P/52usGNA7maYhZCqL+ZR8wk6yXAM=;
	b=UQ8Ff9wjx114+nrUkg4HP4tEhzSZjjlxWM1yl93IsWJyuCKdNOxDQJZfC3pbB/YCEM2C2e
	r8ZjhTwMmCghGXFiR8hVIyGDP/BbFYypilHgof+aa1uMA1DD/DSnpip7wRHYIujftTx+Pf
	Ite/VO2g29Z0LIsePwCFOFfMAAe4ftI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-TrbHQcITPIqXwuhjR3G3iA-1; Wed,
 24 Sep 2025 15:12:20 -0400
X-MC-Unique: TrbHQcITPIqXwuhjR3G3iA-1
X-Mimecast-MFC-AGG-ID: TrbHQcITPIqXwuhjR3G3iA_1758741139
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E485D19560B8;
	Wed, 24 Sep 2025 19:12:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.155])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D77EE1800578;
	Wed, 24 Sep 2025 19:12:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250924185558.3395930-1-max.kellermann@ionos.com>
References: <20250924185558.3395930-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
Subject: Re: [PATCH v2] fs/netfs: fix reference leak
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <845749.1758741135.1@warthog.procyon.org.uk>
Date: Wed, 24 Sep 2025 20:12:15 +0100
Message-ID: <845750.1758741135@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Max Kellermann <max.kellermann@ionos.com> wrote:

> +void netfs_put_failed_request(struct netfs_io_request *rreq)
> +{
> +	/* new requests have two references (see
> +	 * netfs_alloc_request(), and this function is only allowed on
> +	 * new request objects
> +	 */
> +	WARN_ON_ONCE(refcount_read(&rreq->ref) != 2);
> +
> +	trace_netfs_rreq_ref(rreq->debug_id, 0, netfs_rreq_trace_put_failed);
> +	netfs_free_request(&rreq->cleanup_work);
> +}

Can you change the 0 in trace_netfs_rreq_ref() to refcount_read(&rreq->ref)?
(Or I can do that)

David


