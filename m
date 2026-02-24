Return-Path: <linux-fsdevel+bounces-78238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMzRMd16nWmAQAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:18:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D2F185362
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3662830913DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EF4376BE4;
	Tue, 24 Feb 2026 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEwojE27"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D30377541
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928282; cv=none; b=MFhdyY7yzWpNH2uvJxUlsBe4+5QbN6WwrTeW4cci7BsMnaHwQu29yUF+uDOwyeoWhmnjxark/z7sTL/yIIiYipmPTEKg8kyADstp55wki4mHsIUyr7C+ddHJNZaQRDPcTfc2p0ewUEjKyYyoviXuarBdhZGJX61Q8vWLxVrXoK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928282; c=relaxed/simple;
	bh=kwirtkezUKyttq19ZuH10pyRTvZLQj8wIqqJHevs7fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkNYMbvhtF6QVpWcqC0FkJm66RJ84T1EvFIeqm92v31okNYeHhMoMzmC+/j89lYXHBvpSEEYiuW6xDSbFpagS0Ob7kulO0s9n9lXpJ862WumBJLPCOKzYLSGbM2XYy4hqCJc8qg87lK3pwjMNv8fYwSJDiR8HaPq4j7yVKd6wlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UEwojE27; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771928280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M87QNnsSCJlVJUoKJxVdXvjbujJhFeSG308AaM5lV3o=;
	b=UEwojE278xjRVYI6QWzAc0A6oSkq3XWBbRzRfVJ8m6IjfCYd31x0TOPDhITTJ50m+Og7Tb
	IB1s4qwKAWg2L5tDcRNyyziaZDilRr8oXgFmktlPMGSJ43NVSSZz4FrCDNap9fSllVTp2w
	gMKNZuIhYBsvxc1q1piw6zIxnp/cZes=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-lgdNJAsjPlqNYJSgqZugwA-1; Tue,
 24 Feb 2026 05:17:51 -0500
X-MC-Unique: lgdNJAsjPlqNYJSgqZugwA-1
X-Mimecast-MFC-AGG-ID: lgdNJAsjPlqNYJSgqZugwA_1771928269
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 502CC18003F6;
	Tue, 24 Feb 2026 10:17:49 +0000 (UTC)
Received: from fedora (unknown [10.44.32.38])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A23351800465;
	Tue, 24 Feb 2026 10:17:45 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 24 Feb 2026 11:17:48 +0100 (CET)
Date: Tue, 24 Feb 2026 11:17:43 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: pidfd && O_RDWR
Message-ID: <aZ16x0OH098LMqen@redhat.com>
References: <20260223-work-pidfs-autoreap-v4-0-e393c08c09d1@kernel.org>
 <20260223-work-pidfs-autoreap-v4-2-e393c08c09d1@kernel.org>
 <aZx2dlV9tJaL5gDG@redhat.com>
 <aZx3ctUf-ZyF-Krc@redhat.com>
 <aZyI6Aht747CTLiC@redhat.com>
 <aZyonv349Qy92yNA@redhat.com>
 <20260223-ziemlich-gemalt-0900475140e5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-ziemlich-gemalt-0900475140e5@brauner>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78238-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 45D2F185362
X-Rspamd-Action: no action

On 02/23, Christian Brauner wrote:
>
> On Mon, Feb 23, 2026 at 08:21:02PM +0100, Oleg Nesterov wrote:
> > On 02/23, Oleg Nesterov wrote:
> > >
> > > pidfd_prepare() does pidfs_alloc_file(pid, flags | O_RDWR) and "| O_RDWR"
> > > makes no sense because pidfs_alloc_file() itself does
> > >
> > > 	flags |= O_RDWR;
> > >
> > > I was going to send the trivial cleanup, but why a pidfs file needs
> > > O_RDWR/FMODE_WRITE ?
> > >
> > > Actually the same question about some anon_inode_getfile_fmode(O_RDWR)
> > > users, for example signalfd.c.
> >
> > perhaps an accidental legacy from 628ff7c1d8d8 ("anonfd: Allow making anon
> > files read-only") ?
>
> It was always a possibility that we would support some form of
> write-like operation eventually. And we have support for setting trusted
> extended attributes on pidfds for some time now (trusted xattrs require
> global cap_sys_admin).

But why do we need O_RDWR right now? That was my question.

I can be easily wrong, but I think that pidfs_xattr_handlers logic doesn't
need it...

OK, I won't pretend I understand fs, I'll send the trivial cleanup which just
removes the unnecessary "flags | O_RDWR" in pidfd_prepare().

Oleg.


