Return-Path: <linux-fsdevel+bounces-62598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458DCB9AA4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CFD16560C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DFA313298;
	Wed, 24 Sep 2025 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZsrfI92"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D373128DD
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727511; cv=none; b=mcke1pnbAJTGkZ8VqELHb8mr+q/kuaChx3b2cRDBdQY+9Bt2lC3XkixhbfCwmI4VhclF0MJ7m5d2u6Nq9yx8D2UYUJTCrP1neac9tm4lv2U3djekyH7cMMVICfsUrLbeU1P2LeoBExMqhbDmmFNQZ7ept6kfMDHo3sbGNYl1Bgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727511; c=relaxed/simple;
	bh=U0SdXOUahWvhCvNN2IiXkoLSJW4W+TO1RjB82fo7u/E=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=K62211xQKkz6EA1yaEW7p2cczDesab/KSmz9Tdy65v2Aop8isB0DZl8Llkq7LErHbvjRL8UvtEUCgJQ7qesNGAkb8Jaj7InmN3EZuie/0icA2xobrA3dcvXwLqrbqpPRt8pBRSwo4tm+HHCQa0hH2I06/Leq1gB2pGM5qO48tTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZsrfI92; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758727508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g839bYXXnXzsEzs4lSTasjKmFEmWp6qANvpUvXmul2w=;
	b=VZsrfI927yVzvj70jqZiOMwT7HkVTiPJOWlSPuHbS9MBIlKJUQKUrXYsQzaQhVck/wyGbs
	uA2BTfhEEBQtaZTb8UmPt1zvvYCh1h8ucYOuTqBZTSw3nqbix3i8e94Fug89ugG5lHd6MM
	K3nKzdF8SjkWjyUklrRYpJ6eM4c4pNM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-U7tKr2YSOna7enw23176AA-1; Wed,
 24 Sep 2025 11:25:04 -0400
X-MC-Unique: U7tKr2YSOna7enw23176AA-1
X-Mimecast-MFC-AGG-ID: U7tKr2YSOna7enw23176AA_1758727503
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF799180034C;
	Wed, 24 Sep 2025 15:25:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.155])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A5ED1955F19;
	Wed, 24 Sep 2025 15:25:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250911222501.1417765-1-max.kellermann@ionos.com>
References: <20250911222501.1417765-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-stable@vger.kernel.org
Subject: Re: [PATCH] fs/netfs: fix reference leak
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <745740.1758727499.1@warthog.procyon.org.uk>
Date: Wed, 24 Sep 2025 16:24:59 +0100
Message-ID: <745741.1758727499@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Max Kellermann <max.kellermann@ionos.com> wrote:

> For my taste, the whole netfs code needs an overhaul to make reference
> counting easier to understand and less fragile & obscure.  But to fix
> this bug here and now and produce a patch that is adequate for a
> stable backport, I tried a minimal approach that quickly frees the
> request object upon early failure.

I'm not entirely satisfied with the refcounting either, as it's tricky with
the asynchronicity requirements.

> I decided against adding a second netfs_put_request() each time because that
> would cause code duplication which obscures the code further.  Instead, I
> added the function netfs_put_failed_request() which frees such a failed
> request synchronously under the assumption that the reference count is
> exactly 2 (as initially set by netfs_alloc_request() and never touched),
> verified by a WARN_ON_ONCE().

I like this.

> ... and frees the allocation (without the "call_rcu" indirection).

Unfortunately, this isn't good.  The request has already been added to the
proc list and is removed in netfs_deinit_request() by netfs_proc_del_rreq() -
but that means that someone reading /proc/fs/netfs/requests can be looking at
it as you free it.

You still need the call_rcu() - or you have to call synchronize_rcu().

I can change netfs_put_failed_request() to do the call_rcu() rather than
mempool_free()/netfs_stat_d().

Another possibility could be to defer the addition to the proc list to right
before we start adding subrequests.  Deleting from the proc list would be a
no-op if the thing isn't queued.

Thanks,
David


