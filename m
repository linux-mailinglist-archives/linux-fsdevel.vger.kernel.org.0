Return-Path: <linux-fsdevel+bounces-45927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCC0A7F665
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 09:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6AF188F512
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 07:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FC6263C7D;
	Tue,  8 Apr 2025 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVcvqbBc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5765263F52
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 07:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097521; cv=none; b=JoAYs2AMWCOWxE4Yhr80yisJo5HBjpqncJ34KC05v15F9acPpxQLWBgtalqoyIyPJfLs62r+j8Ztdj1EKHp6M56L9DTaEFJSX5kRPPSh02aIbOlMxF6IyrG1yHk8+hlQxbowReeTOocdLFmiKGC3xXPPuZmx1bQ5CRG8tZk2QPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097521; c=relaxed/simple;
	bh=U9itVnCxggxgVsfVdyPjJCPJaNCMXNeHPOM7KFsN0Qs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=pae2xtprdF7IM+8K7Qyp78lNpkSrBA31gm9OyoQOftQMZBrPBgymeXcKBWg9UCjBl7owP224NxZEdtSHStzBgVu0M4wHiZRzYoasvzvow3daWHGcTPhSDWdFKZ+qDGx9M7bJguHlKwzGe+evH92VqOb0+h/A37QkgbY/TOgoyls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVcvqbBc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744097518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yoMCVwSsU8fP4TmDR3lw4btuAmHMxt6XZM6tKZauCOQ=;
	b=gVcvqbBcEba9qnT2f2PRUpnVrZYL6ue9ZB/+wCTRiMsJ1lqXcgsJ+vx0hRizj01rjXwN4U
	8Q/Pv5J029iqca+liztM+hLBHGrCgX2AGO4bnLDdIQ2FTAdlhCyjzb1fqREInRURITcebc
	Q6S+NCrsdFScBBg1TJHA8ijj1gQ0x6k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-o0mHNaJ_NSmGM3gznGbmHw-1; Tue,
 08 Apr 2025 03:31:55 -0400
X-MC-Unique: o0mHNaJ_NSmGM3gznGbmHw-1
X-Mimecast-MFC-AGG-ID: o0mHNaJ_NSmGM3gznGbmHw_1744097514
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4F0B19560B6;
	Tue,  8 Apr 2025 07:31:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.40])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF22C3001D0E;
	Tue,  8 Apr 2025 07:31:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <b395436343d8df2efdebb737580fe976@manguebit.com>
References: <b395436343d8df2efdebb737580fe976@manguebit.com> <20250407184730.3568147-1-song@kernel.org>
To: Paulo Alcantara <pc@manguebit.com>
Cc: dhowells@redhat.com, Song Liu <song@kernel.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    kernel-team@fb.com
Subject: Re: [PATCH] netfs: Let netfs depends on PROC_FS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1478621.1744097510.1@warthog.procyon.org.uk>
Date: Tue, 08 Apr 2025 08:31:50 +0100
Message-ID: <1478622.1744097510@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Paulo Alcantara <pc@manguebit.com> wrote:

> It wouldn't make sense to make it depend on PROC_FS.

Correct.

> I see two problems here:
> 
> (1) We shouldn't be creating /proc/fs/netfs if CONFIG_PROC_FS=n

Yes, the proc_*() calls will all fail if CONFIG_PROC_FS=n and so need to be
#ifdef'd around.

> (2) There's a wrong assumption in the API that @netfs_request_pool and
> @netfs_subrequest_pool will always be initialized.  For example, we
> should return an error from netfs_alloc_[sub]rquest() functions in case
> @mempool == NULL.

No.  The assumption is correct.  The problem is that if the module is built in
(ie. CONFIG_NETFS_SUPPORT=y), then there is no consequence of netfs_init()
failing - and fail it does if CONFIG_PROC_FS=n - and 9p, afs and cifs will
call into it anyway, despite the fact it deinitialised itself.

It should marked be module_init(), not fs_initcall().

David


