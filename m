Return-Path: <linux-fsdevel+bounces-29909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B58983A2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 01:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89010B21A9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 22:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B13145B3E;
	Mon, 23 Sep 2024 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eePA8gnV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B149143C40
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130847; cv=none; b=Il/l+W7XIGv7nVEHuErC6B6NWRf7SyW6VWQjsd9axaKtoJ7ERvTEluAKf0ZmZgBD6yxnVYsgurlUvRtp3si2Dd2UJvPgeUnPm85POyWCg5oNgBaGWRCEPTiqZKIKx/6aERTxwJGzICCYWlEY54YaD0DP5L87sjxaCjCqreLouQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130847; c=relaxed/simple;
	bh=N7+o7khx1jf67s1hBqcR1Ne4Otvu61IbH27PLtV3oCw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=R46mq/YtoVGpwI5ybB8/jAZ8fOAbjMBJ+GjFNKwd2pJR/ZdgbsrzO7BOeg0C8XLifHtBxj0y028t3imQS1VHxZaYEyfTIe4Is9G0DMkrLS3MUb6+kvsAIOi2CyyzMebr7KID0dDNE1XeYMyjzRxgYeQlr6hwOXHbJw/IbGrUELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eePA8gnV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727130844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jTkM6enpKsq/HPP1aWcd0UHOFBRJuXPpDuW+0fAnEgU=;
	b=eePA8gnVy+KpeSID2jCvQ93ToonI1G/92XpJFo8sviMmcByFNBU8/QP4LByxwkc2JIWZc7
	9+pR157GGaaL/A575t2qQkg02BiYUKEpBoz3s38Si/QVXV/Oh/5A5aiuDaDE6SmvcguIdB
	gJAZgWLfnvhkj2c5Zgp6vam1jIozw2s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-vMyy1_3ZP0WVkfaK3Q6znA-1; Mon,
 23 Sep 2024 18:34:01 -0400
X-MC-Unique: vMyy1_3ZP0WVkfaK3Q6znA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BEF4190C4DA;
	Mon, 23 Sep 2024 22:33:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F15319560AA;
	Mon, 23 Sep 2024 22:33:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <0f6afef57196cb308aa90be5b06a64793aa24682.camel@gmail.com>
References: <0f6afef57196cb308aa90be5b06a64793aa24682.camel@gmail.com> <20240814203850.2240469-20-dhowells@redhat.com> <20240923183432.1876750-1-chantr4@gmail.com> <670794146059f85a30efd7cf9d6650375d987077.camel@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: dhowells@redhat.com, Manu Bretelle <chantr4@gmail.com>,
    asmadeus@codewreck.org, ceph-devel@vger.kernel.org,
    christian@brauner.io, ericvh@kernel.org, hsiangkao@linux.alibaba.com,
    idryomov@gmail.com, jlayton@kernel.org,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-mm@kvack.org,
    linux-nfs@vger.kernel.org, marc.dionne@auristor.com,
    netdev@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.com,
    smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com,
    v9fs@lists.linux.dev, willy@infradead.org
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <961633.1727130830.1@warthog.procyon.org.uk>
Date: Mon, 23 Sep 2024 23:33:50 +0100
Message-ID: <961634.1727130830@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Eduard Zingerman <eddyz87@gmail.com> wrote:

> - null-ptr-deref is triggered by access to page->pcp_list.next
>   when list_del() is called from page_alloc.c:__rmqueue_pcplist(),

Can you tell me what the upstream commit ID of your kernel is?  (before any
patches are stacked on it)

If you can modify your kernel, can you find the following in fs/netfs/:

buffered_read.c:127:			new = kmalloc(sizeof(*new), GFP_NOFS);
buffered_read.c:353:	folioq = kmalloc(sizeof(*folioq), GFP_KERNEL);
buffered_read.c:458:	folioq = kmalloc(sizeof(*folioq), GFP_KERNEL);
misc.c:25:		tail = kmalloc(sizeof(*tail), GFP_NOFS);

and change the kmalloc to kzalloc?

David


