Return-Path: <linux-fsdevel+bounces-32186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A37B49A2081
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 13:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2351F27723
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187571DC04C;
	Thu, 17 Oct 2024 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evChSBdm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F971DB37C
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163044; cv=none; b=trjDzUF65ygJIyJYMQsPy8wYs3vR8UTmE9doB+GDkIBApJV9ekrfNUyMFEFu1aQVR5kyhpVuYguOrL0YDR1+B38tvxpmhaufsQaXInWxoz0ujci1pqTgo7sky1e1jHPu5TGT72Ic83dDWlVUJB1a9ylU/jXjmeRxjwtH6IssE/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163044; c=relaxed/simple;
	bh=Uozh1w9LZoXr6ha27kAfa1WuCkzQONJaDgQPc6sczFA=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=TSPwknikPnZJoGybyhtiV6md5lYzQVTZ8mW3Ixvh/vfBc4bIdt4D7PdwRqDha0uycpuP8RrFKqR14uepvv37JZ3CjgD1d3H3TdMizDPd3oFKLxXmlLwWRocifCkPqcKvg2dE6ybvPMX3C6kc649L8zD8xfs4gF1cGp612IKcuIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=evChSBdm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729163041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uozh1w9LZoXr6ha27kAfa1WuCkzQONJaDgQPc6sczFA=;
	b=evChSBdm6ObgZR8mByfxEeZ5SsYdsJKkJj+puzGSGTFDQ/IOTi+yhC1KKgRs2hj+bbIaR6
	Fz2lLWgQpXs+CGUhAE9SEt8ptmzkunIdSZuXH2JKvF+Ey3Xmni+BvXKowrUNgdR+q3x4jd
	m0RsfVTsvoJ1ssjgK4XbPI/g83FeKeM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-Pi1RK835NXed1iR06uqpVA-1; Thu,
 17 Oct 2024 07:04:00 -0400
X-MC-Unique: Pi1RK835NXed1iR06uqpVA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 755D01955F45;
	Thu, 17 Oct 2024 11:03:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.218])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AE1419560A3;
	Thu, 17 Oct 2024 11:03:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1292002.1729090128@warthog.procyon.org.uk>
References: <1292002.1729090128@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix kdoc of netfs_read_subreq_progress()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1395128.1729163036.1@warthog.procyon.org.uk>
Date: Thu, 17 Oct 2024 12:03:56 +0100
Message-ID: <1395129.1729163036@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Ignore this, the fix needs to be applied to patches I haven't upstreamed yet.

David


