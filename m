Return-Path: <linux-fsdevel+bounces-41738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE41A3639D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 17:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC181725A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED25C267703;
	Fri, 14 Feb 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XubBJHf+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CD5245002
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551771; cv=none; b=UHVSBkxKstH4oY90Qfulp/TTIvJG2AZ/eXNNWBvNTga3y8R8NdsIVYbKR07ES8dye9NOwsPZBJzh6BErq5gejQwfZUSy/+FIjnH8J9V+nsiFmKzbEL40aS/UkiqvxLv8yB4vjLaqhimNFrOHbl7c2jz61uhtRJHgSc5Blqu0aF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551771; c=relaxed/simple;
	bh=pLOvI29Aapj4IwnfzZBqEbDiMXSI4ItjPkzJDZfHXao=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=fbDmEwYRRc8+4MvF6LPAT5CTz2oIp2kHkNjPmBX6phjwoIdXRytucurlE/B9I8lzO8n4iXSW43OW1N+yAmUgrSrVNLqPC17qtVV83qGMoMaszUWJfjk96QzOhSaK3H/7v8OS2w8xrS87n7jRGhohMCr8wtQruoEU0PXCdMqF1eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XubBJHf+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739551768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RFZJfEhydfL+zGFnhFKg82fdmsgRH1RPROwECxkAuWw=;
	b=XubBJHf+iPWVZyMCDyRUbnmjxw0ypQtKgTnFsaPX2T5pfXX0WanODdP0R6lZNpgGPM67jm
	kAG3oQ8aJL3i4IacNrNiQdNsAAXNf5cy1HLN9NEyB9qP4gPdI3Rmc8KNpK8YP7ZB1DDOoa
	8Dgpz5Bf8JXQHHOD9jvSjJvdTRZxwbk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-F9ck2ihFP4yWtSgUlgZjZQ-1; Fri,
 14 Feb 2025 11:49:27 -0500
X-MC-Unique: F9ck2ihFP4yWtSgUlgZjZQ-1
X-Mimecast-MFC-AGG-ID: F9ck2ihFP4yWtSgUlgZjZQ_1739551765
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7577E180087D;
	Fri, 14 Feb 2025 16:49:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C169519373C4;
	Fri, 14 Feb 2025 16:49:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <a8d8f11a-0fea-4b74-893b-905d6ef841e6@redhat.com>
References: <a8d8f11a-0fea-4b74-893b-905d6ef841e6@redhat.com> <b34d5d5f-f936-4781-82d3-6a69fdec9b61@redhat.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: dhowells@redhat.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
    Lukas Schauer <lukas@schauer.dev>
Subject: Re: [RFC PATCH 2/2] watch_queue: Fix pipe accounting
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4145091.1739551762.1@warthog.procyon.org.uk>
Date: Fri, 14 Feb 2025 16:49:22 +0000
Message-ID: <4145092.1739551762@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Eric Sandeen <sandeen@redhat.com> wrote:

> -	if (!pipe_has_watch_queue(pipe)) {
> -		pipe->max_usage = nr_slots;
> -		pipe->nr_accounted = nr_slots;
> -	}
> +	pipe->max_usage = nr_slots;
> +	pipe->nr_accounted = nr_slots;

Hmmm...   The pipe ring is supposed to have some spare capacity when used as a
watch queue so that you can bung at least a few messages into it.

David


