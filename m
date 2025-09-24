Return-Path: <linux-fsdevel+bounces-62610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813C6B9ABF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD02178887
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 15:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E826B30DECF;
	Wed, 24 Sep 2025 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXHU1IWW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921072E03EE
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728381; cv=none; b=lwzHy9c3slPEkq/yY6gY99y5CrgsIXcW00OlBYO4Cc8/gKEvi3KGp+knGVGfN8fqzRsf6/1qOyvuKEA3glFr6pMW/puNQAWg7AXmeds46nkxfs1egYEPE5cRyuQKtKIJHa0hwgE+JMLQFPzWJtKrvokWSEk3dhVjz4AdPR7rK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728381; c=relaxed/simple;
	bh=v/Cr/IL70HpmLDXq0/COC0G/ZI+89mZIjWnRZv6XJNQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=GgrrJCdPZUI2UmWqdFkhnwPqlxyY+9OvHke2yd1QZOA0nMOrxIN4jRmk60eB010yirVVuQwRxbnqKilVejzzQCrc4VGiZi8NBHzFoJF10WNvklAEkzrT4rRTU/BkICfvSzjt3nc+tVQJVcW7fCXkoS9NA1IRNPtUaEYkWNzeywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UXHU1IWW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758728378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VW0CPi1vI6VVLJVg3ytdkJ52tq0kRHmrUbFeTNhR9kk=;
	b=UXHU1IWWyq2K4SkhQxVeyavQ0X6DL3l8p3o7gcEb2Zayw9EAoPpmFKiI8ft1Ss97hMikT7
	dQmKWDBc4KyTFduHkdeaYqCMXt+oFKKU/bf5woTVHx27P5JVB7a5BGZqnlu91aGuzY0Xhv
	39ps1Jc72eMJ1CgSFfGSvRQS9tXlqig=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-4lk1vFx3OCKtwoH6h-Rr2A-1; Wed,
 24 Sep 2025 11:39:35 -0400
X-MC-Unique: 4lk1vFx3OCKtwoH6h-Rr2A-1
X-Mimecast-MFC-AGG-ID: 4lk1vFx3OCKtwoH6h-Rr2A_1758728374
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 097E318002E0;
	Wed, 24 Sep 2025 15:39:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.155])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABDF41800451;
	Wed, 24 Sep 2025 15:39:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <745741.1758727499@warthog.procyon.org.uk>
References: <745741.1758727499@warthog.procyon.org.uk> <20250911222501.1417765-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-stable@vger.kernel.org
Subject: Re: [PATCH] fs/netfs: fix reference leak
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <755694.1758728365.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Sep 2025 16:39:26 +0100
Message-ID: <755695.1758728366@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

David Howells <dhowells@redhat.com> wrote:

> > ... and frees the allocation (without the "call_rcu" indirection).
> =

> Unfortunately, this isn't good.  The request has already been added to t=
he
> proc list and is removed in netfs_deinit_request() by netfs_proc_del_rre=
q() -
> but that means that someone reading /proc/fs/netfs/requests can be looki=
ng at
> it as you free it.
> =

> You still need the call_rcu() - or you have to call synchronize_rcu().
> =

> I can change netfs_put_failed_request() to do the call_rcu() rather than
> mempool_free()/netfs_stat_d().

How about:

/*
 * Free a request (synchronously) that was just allocated but has failed b=
efore
 * it could be submitted.
 */
void netfs_put_failed_request(struct netfs_io_request *rreq)
{
	int r;

	/* New requests have two references (see netfs_alloc_request(), and
	 * this function is only allowed on new request objects
	 */
	if (!__refcount_sub_and_test(2, &rreq->ref, &r))
		WARN_ON_ONCE(1);

	trace_netfs_rreq_ref(rreq->debug_id, r, netfs_rreq_trace_put_failed);
	netfs_free_request(&rreq->cleanup_work);
}

David


