Return-Path: <linux-fsdevel+bounces-26346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B99957EE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 09:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC75B1F22FA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 07:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5622450285;
	Tue, 20 Aug 2024 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqZZjrpM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4879218E34A
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137342; cv=none; b=PNiu4ZKgSzPDvfJOoryaCIIlPj23hihBa/nIrxo6VkYH1tIMMw3gYwZC10yiDRaZyLDN6hDEUv7UlJFDlNQNxdH3M1LNi2Y/26zOTIl/zt4KKf7rURt8ChyDeBYmhwdP1a3RXcLFSVSX0Q5lTi5GbD/pA74WT637iGM0sJ4XT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137342; c=relaxed/simple;
	bh=4RvDm81YuYGUGtZK63aOvTreC1FK+b+j3aGtsr4Xuj4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ESEhvmgw24TXe1SjYrEzS/sy8+3SQFVGf+8XNVal9UklvuismMrjZc8niD2NFSUmWTZVc+W+etchzaz1rZVyDX8Zu9jfRRdYNkUhVX3YGTQYb0SdX2P2tz2HXKT+RxcJnBxB5JQHcTzDMKbEEf+BSDby7CJUd8rdglm5ubq5N+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqZZjrpM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724137340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l6tg+78ssHLoUiJiuLkOUbKvdvvwfkuyAkYgEhna4vY=;
	b=NqZZjrpMQ2GukqOhzhb4Ce+82mW8kcmZTV5LQd/nW5TYlM/J6Xwe9I2rq50AJWFpGljT/3
	B2L+ilGEkBeEGP1QkVn84TziRtSpQ8DdKUyiaTn0UNbXtek+cK4xbhNLzzAz2C1kl1IYIU
	m+AoijeJdWJFd/elOM48Q0I6oSeufXQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-5HP8PYE4P6aH5o6ka1-ocw-1; Tue,
 20 Aug 2024 03:02:16 -0400
X-MC-Unique: 5HP8PYE4P6aH5o6ka1-ocw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 190251954220;
	Tue, 20 Aug 2024 07:02:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75AC219560AA;
	Tue, 20 Aug 2024 07:02:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240817084619.2075189-1-yangerkun@huaweicloud.com>
References: <20240817084619.2075189-1-yangerkun@huaweicloud.com>
To: yangerkun <yangerkun@huaweicloud.com>
Cc: dhowells@redhat.com, brauner@kernel.org, jack@suse.cz,
    jlayton@kernel.org, hsiangkao@linux.alibaba.com,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] netfs: fix the mismatch used for CONFIG_FSCACHE_DEBUG
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3536138.1724137331.1@warthog.procyon.org.uk>
Date: Tue, 20 Aug 2024 08:02:11 +0100
Message-ID: <3536139.1724137331@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Thanks, but this is obsolete as of commit
fcad93360df4d04b172dba85b976c9f38ee0d5e0.

    netfs: Rename CONFIG_FSCACHE_DEBUG to CONFIG_NETFS_DEBUG

David


