Return-Path: <linux-fsdevel+bounces-54354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 088ABAFE991
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 15:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FAA71C81FB1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 13:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39512DFA28;
	Wed,  9 Jul 2025 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJCkevPO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6252DAFAF
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066119; cv=none; b=VNgmj5qhHCFXONrnOAliOwYiYgQAMmsw0j5AfILIjhcQXGOZXzi7OLoRr//tPzy2OcU9JhDtHb3LEOFOJULWrbR9567Xs8P5L3WvyIK6HVtbi7N/i8bwIEuzGOx8uCbmCNv8vg5w0J/ZVqwgMurP5IZf3GL+M+T631BXkQcK95g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066119; c=relaxed/simple;
	bh=/H1wwcYQS3C200j65rusHRaNOcAUWMWreLwsmQzUutA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=cDPwv7MGxgiutx/FN5HXP0S36oBIbQ7JdCODg06vpuS8PVSn6g/crIphAqIy55vUTrF9uxeN0k5HOhH9oHvxNUhif5SorOfXYOywYtrKb0dw7vP0PPLOs70+0XpVOpREfT40w0hxOtn+4P1q5QEq0IkKJkM8h/5iDg+zGaj9PZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJCkevPO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752066116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fPAEJueQlgI9BgBvvY5GihbFk6Uvv9VDWN1JiHtaB3M=;
	b=cJCkevPOFsdwwQYiSs/jSJI0iogF0ec0f0KLivCl3amYqd1FWOo3+4FLevpmDmIK9QvEst
	mjgbam4P30rLbMHVJFKDCeJtdPwNfDucIyWD6GPFg/nileU3QcdDJWklJJN4S6qeG7rVK9
	yPnYNq/vc9r8CdI1IdhtOeJPu8oZCJE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-H1jXk4VzN_GhrVr5QRFMeA-1; Wed,
 09 Jul 2025 09:01:53 -0400
X-MC-Unique: H1jXk4VzN_GhrVr5QRFMeA-1
X-Mimecast-MFC-AGG-ID: H1jXk4VzN_GhrVr5QRFMeA_1752066111
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1661C1801217;
	Wed,  9 Jul 2025 13:01:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1908195608F;
	Wed,  9 Jul 2025 13:01:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com>
References: <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com> <20250701163852.2171681-1-dhowells@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
    netfs@lists.linux.dev, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2724317.1752066097.1@warthog.procyon.org.uk>
Date: Wed, 09 Jul 2025 14:01:37 +0100
Message-ID: <2724318.1752066097@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Max Kellermann <max.kellermann@ionos.com> wrote:

> your commit 2b1424cd131c ("netfs: Fix wait/wake to be consistent about
> the waitqueue used") has given me serious headaches; it has caused
> outages in our web hosting clusters (yet again - all Linux versions
> since 6.9 had serious netfs regressions). Your patch was backported to
> 6.15 as commit 329ba1cb402a in 6.15.3 (why oh why??), and therefore
> the bugs it has caused will be "available" to all Linux stable users.
> 
> The problem we had is that writing to certain files never finishes. It
> looks like it has to do with the cachefiles subrequest never reporting
> completion. (We use Ceph with cachefiles)
> 
> I have tried applying the fixes in this pull request, which sounded
> promising, but the problem is still there. The only thing that helps
> is reverting 2b1424cd131c completely - everything is fine with 6.15.5
> plus the revert.
> 
> What do you need from me in order to analyze the bug?

As a start, can you turn on:

echo 65536 >/sys/kernel/debug/tracing/buffer_size_kb
echo 1 > /sys/kernel/debug/tracing/events/netfs/netfs_read/enable
echo 1 > /sys/kernel/debug/tracing/events/netfs/netfs_rreq/enable
echo 1 > /sys/kernel/debug/tracing/events/netfs/netfs_sreq/enable
echo 1 > /sys/kernel/debug/tracing/events/netfs/netfs_failure/enable

If you keep an eye on /proc/fs/netfs/requests you should be able to see any
tasks in there that get stuck.  If one gets stuck, then:

echo 0 > /sys/kernel/debug/tracing/events/enable

to stop further tracing.

Looking in /proc/fs/netfs/requests, you should be able to see the debug ID of
the stuck request.  If you can try grepping the trace log for that:

grep "R=<8-digit-hex-id>" /sys/kernel/debug/tracing/trace

that should hopefully let me see how things progressed on that call.

David


