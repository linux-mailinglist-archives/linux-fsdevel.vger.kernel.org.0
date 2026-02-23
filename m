Return-Path: <linux-fsdevel+bounces-77985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CWVBGvCJnGl8JQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 18:10:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C53D417A66A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 18:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCCDD30E32C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C782329365;
	Mon, 23 Feb 2026 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUsdABLZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD38C30C368
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866356; cv=none; b=DGTO5f87BXr9D/RfYOeNS37X+RtNuy4MRwF/T5/v4yVlOX/tNm1fsROOCblQsfdTHoGGI3TMQXEGnaJ6zd2ajAVyqbq9wLFXqeKcxJYGE/q6EIOTqR8PIO40MeEfhlhIdv8t6u7tu/SQMXrxvGG0tnaLd+tQ2IrefhNJ0oU0Uhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866356; c=relaxed/simple;
	bh=SFmhNdnf3rACdXJjupmrzAWA8eXyokF2iD8l0cARuIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUEW4jnY17Uo8UW+ERv5fGcYSIWMGarzXT8hat9toxwqUcEweAuFrpIULW8rm5jK1mklhThEuWGvcVOmgxtjuzwvhhOKXjxgC4MMYPJKHAHAKUCtvTETyh4FNdi/k+/1oRZOQYKVZOkDXzDKWjCH4zVvz432CCi7qALSN6NINhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUsdABLZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771866354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h+nYqL8YQNY5qw0Z4TJIuXoqkgZMoxLSKm/GfAztHKU=;
	b=CUsdABLZaAWebiI6f8hgrZJRSj5+MRgVDkAzWjN2wzQVO9oZu1DT5omHpgTQVjdOQJEvGT
	PbTa1XhCbIB1H7g6tqCM2WC3oAvNIZkW4sSPRUCsHLAaJ3VU07BcXFubo81srmRFq8Qw1G
	w39XwIxbhJi5AR43O4k2jcRLOxdLzqE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-VJH6wrlwMx-GzMaurugLxw-1; Mon,
 23 Feb 2026 12:05:51 -0500
X-MC-Unique: VJH6wrlwMx-GzMaurugLxw-1
X-Mimecast-MFC-AGG-ID: VJH6wrlwMx-GzMaurugLxw_1771866350
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25E541956058;
	Mon, 23 Feb 2026 17:05:50 +0000 (UTC)
Received: from fedora (unknown [10.44.32.38])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 874D819560B2;
	Mon, 23 Feb 2026 17:05:46 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 23 Feb 2026 18:05:49 +0100 (CET)
Date: Mon, 23 Feb 2026 18:05:44 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: pidfd && O_RDWR
Message-ID: <aZyI6Aht747CTLiC@redhat.com>
References: <20260223-work-pidfs-autoreap-v4-0-e393c08c09d1@kernel.org>
 <20260223-work-pidfs-autoreap-v4-2-e393c08c09d1@kernel.org>
 <aZx2dlV9tJaL5gDG@redhat.com>
 <aZx3ctUf-ZyF-Krc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZx3ctUf-ZyF-Krc@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77985-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C53D417A66A
X-Rspamd-Action: no action

On 02/23, Oleg Nesterov wrote:
>
> Sorry for noise!

Yes, but let me add more (off-topic) noise to this thread...

pidfd_prepare() does pidfs_alloc_file(pid, flags | O_RDWR) and "| O_RDWR"
makes no sense because pidfs_alloc_file() itself does

	flags |= O_RDWR;

I was going to send the trivial cleanup, but why a pidfs file needs
O_RDWR/FMODE_WRITE ?

Actually the same question about some anon_inode_getfile_fmode(O_RDWR)
users, for example signalfd.c.

Can you explain just for my education?

Oleg.


