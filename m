Return-Path: <linux-fsdevel+bounces-24615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E66AC941595
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 17:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B6F285D9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 15:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970FC1A38F5;
	Tue, 30 Jul 2024 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QU9MxgQq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FB018A92F
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354087; cv=none; b=I9qg/R/vR/Gu59T//SM6snXUpQ29KnufPwoK68XMyypSYkFs1HaM5sDZqqVUQU86Bt27R9xE7D4Xah/Ryqt7APrYlaP7pMMtUlJguukVaLqt2u8pKmzyjWa9juOYjzMfJxYQG75H9CMvu2JjjtHinLBzEi8gVNBbkPes1DzY1Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354087; c=relaxed/simple;
	bh=ajVW/Twg9kyeIBsINLqc9i2LrtkZwqPRQKXCgiMS69U=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=YMN7ScW9/eenJcPgCzFoGvi8ljHaK//CT7d/J8qO5buvCQUH8LTLhVtiUXTeN44CTCSjavtnqFtkOzjAIxr/ROJP79j4S0fQmIqoXHOGALNIS/DuNwm6gMQzcMP6v3m3fjGBI/Gd6wRe+JN4uCAEGyxvSf0sPbYQJzgZ1nWsv8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QU9MxgQq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722354084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0mB5yq5YiVF6hgMMbOMHQ2v9K7FPCMyb/XiuYsldEd0=;
	b=QU9MxgQqWM3bdC0MFtF7Tv9Qqh2vdbdZlmuXo+Gb6EXIUwqBZMzTIdl/iOjB2fqY5otov5
	C9MKp8xlSylEsFgGaah8D5PT0w7AFFW6dfQ3oMhLCJf4nXr/jcW0ODumdtifCgRLcsx5PE
	IMYm+dXuT6od5JIFgxWgrrNsTAWAWRU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-PKs2OiCNM3OTGBYH9YTL8g-1; Tue,
 30 Jul 2024 11:41:17 -0400
X-MC-Unique: PKs2OiCNM3OTGBYH9YTL8g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 412451955D48;
	Tue, 30 Jul 2024 15:41:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E59D1955D42;
	Tue, 30 Jul 2024 15:41:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3516608.1722349609@warthog.procyon.org.uk>
References: <3516608.1722349609@warthog.procyon.org.uk> <20240729090639.852732-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, willy@infradead.org,
    linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
    ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
Subject: Re: [PATCH] fs/ceph/addr: pass using_pgpriv2=false to fscache_write_to_cache()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3554543.1722354072.1@warthog.procyon.org.uk>
Date: Tue, 30 Jul 2024 16:41:12 +0100
Message-ID: <3554544.1722354072@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

I think the right thing to do is probably to at least partially revert:

	ae678317b95e760607c7b20b97c9cd4ca9ed6e1a
	netfs: Remove deprecated use of PG_private_2 as a second writeback flag

for the moment.  That removed the bit that actually did the write to the
cache on behalf of ceph.

David


