Return-Path: <linux-fsdevel+bounces-68532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B23C8C5E85D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 18:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22744383213
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 16:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39B420CCDC;
	Fri, 14 Nov 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kaducntk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945D33439B
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763138396; cv=none; b=knt4YvfgbKyHjyzPg0XaRiUacBOHHADLttfjmqwvY8M/gwMQ8ICt3FzlGtv5y/a8Gqq33UNe6zu1nrv2xBLaHheSSmO6XgIzGrE6h27fGsHHNwI0bsC842eTypeH0uYbxc9vJHpVFr2Kgc7eu0m89ODqIMbWF+cEz0GWw7gIx8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763138396; c=relaxed/simple;
	bh=ujc/M8mdn7m1KIB2P3z9gtu62MbvlwvHfMUB8puDjV4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ZnYJD38dIY7FZjcMDiGCADqCkDrNtANkSxSfgkYxEcJ1mpi6QC4jMeDTFbuELiuyVUz3/XlTG93Hh94kS4/uT7Tstob8uhU8/YwpYtrgg8UiuJTtgOI9rs7IsleKzJfOQrO9OarHofNAFA1UiAJg7lpuYj1CQlBTKcnAEYvPReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kaducntk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763138393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/VyC3lN4MVn3wvAdyGA1bAEekvrnmWtCoIUz9azsLoY=;
	b=KaducntkYt/mgqzk/OhpxFO8kvMKV6Cc/vDOeGd64hj6wiP43hf4BkoFNqb4nfwAfruXVS
	XGQwvdFMPf6qqWqVxfVgiVCpvT/cooJPn59+PlC9CAdrQ5beSsnCwQaLta6LNTMr86Q5Cj
	BRGgelXBd0i4vrApmatESn3G9KORYLE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-VcS8kyyIN8qfV949n0aTXA-1; Fri,
 14 Nov 2025 11:39:50 -0500
X-MC-Unique: VcS8kyyIN8qfV949n0aTXA-1
X-Mimecast-MFC-AGG-ID: VcS8kyyIN8qfV949n0aTXA_1763138388
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B77D018AB428;
	Fri, 14 Nov 2025 16:39:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.87])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B162300018D;
	Fri, 14 Nov 2025 16:39:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CANT5p=p2jb2dmgQJw2jen_JcvUw8BJYV1Lq4pfUzuMVDpx=v2A@mail.gmail.com>
References: <CANT5p=p2jb2dmgQJw2jen_JcvUw8BJYV1Lq4pfUzuMVDpx=v2A@mail.gmail.com> <CAH2r5mtnf1eBTXnDQBiQYKrwEwUzxcxC5Nfv1NbiCdudQMaUZA@mail.gmail.com>
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: dhowells@redhat.com, Steve French <smfrench@gmail.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Paulo Alcantara <pc@manguebit.org>,
    CIFS <linux-cifs@vger.kernel.org>,
    linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: New netfs crash in last month or so
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1860502.1763138385.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Nov 2025 16:39:45 +0000
Message-ID: <1860503.1763138385@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Shyam Prasad N <nspmangalore@gmail.com> wrote:

> It looks like a missing initialization in the netfs write retry code.
> This initialization of sreq_max_segs seems different from all the
> other places to me:
> https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/netfs/write_retry.c=
#L162
> David / Paulo: Is it expected to set a non-zero value to this? If the
> value of this was 0, we wouldn't have called netfs_limit_iter in this
> codepath.

That shouldn't matter.  netfs_limit_iter() should still work, even if max_=
segs
is INT_MAX.

> [Fri Nov 7 10:03:15 2025] netfs_limit_iter+0x50f/0x770 [netfs]

Can you find a line for this, Steve?

David


