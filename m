Return-Path: <linux-fsdevel+bounces-31546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3C49984FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 349B0B22817
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DD31BFDEE;
	Thu, 10 Oct 2024 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSfYdopp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5426183CD9
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559914; cv=none; b=itu8UE0Bb9qFtdsjrE5EPwvO9wZWsXNNLB0wQGqIGs43mnCeXt4bq70iwZO5V1yszZzoxRPaP9w6gq/rkKkthzdZQ4zbVrxZ3/EGNbbCFAlmlKrHsVSOwq8G8hFPqDYM661/2Jyp342iAmDq30rSFeDitdIvOIChCtlA7F6YAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559914; c=relaxed/simple;
	bh=pfGEpMF39VFoy+My07KmkNgcSpKJiJuaOIL+fXlG1Cs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ef+nLe0PqFzop+UKjrOaXOFVXelNfYHyTFY+JhNNw9BvCGqj49qZ0pcUCg4YeouM+tCxrJzNo0pSy5MN6rjR6zs+fFWQfJxg+KTnLno+7XFl4QSlKw4UznnSzrv2ADN64Prj26hAtATPn8v6tKx/aUcbdAqO0agR0KePTVL7TV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KSfYdopp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P0mSN84ctC9kB+Ps3c0dqY7xkZFlxz3esb1cmK+QLag=;
	b=KSfYdoppvkd0G6jIkaJewSRZgK6KfncBjUQtgBZ0m+V+zONDcRnH33qT0300aW6efpw+0A
	xO4AAqWjwnQ0I9krhtrucKm1TmcATRYm4Y+zY19hyswnTwr70L9QQyWBsX+oc4Yp00TzGi
	hxAvCdfw4lGHV5s6ynExB6m1e3RwXQs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-harA49VCM6mKEob86Vqu_Q-1; Thu,
 10 Oct 2024 07:31:48 -0400
X-MC-Unique: harA49VCM6mKEob86Vqu_Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C96A1955F44;
	Thu, 10 Oct 2024 11:31:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E65E819560AA;
	Thu, 10 Oct 2024 11:31:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-7-wozizhi@huawei.com>
References: <20240821024301.1058918-7-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
    zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
    yukuai3@huawei.com
Subject: Re: [PATCH 6/8] cachefiles: Modify inappropriate error return value in cachefiles_daemon_secctx()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <304107.1728559896.1@warthog.procyon.org.uk>
Date: Thu, 10 Oct 2024 12:31:36 +0100
Message-ID: <304108.1728559896@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Zizhi Wo <wozizhi@huawei.com> wrote:

> In cachefiles_daemon_secctx(), if it is detected that secctx has been
> written to the cache, the error code returned is -EINVAL, which is
> inappropriate and does not distinguish the situation well.

I disagree: it is an invalid parameter, not an already extant file, and a
message is logged for clarification.  I'd prefer to avoid filesystem errors as
we are also doing filesystem operations.

David


