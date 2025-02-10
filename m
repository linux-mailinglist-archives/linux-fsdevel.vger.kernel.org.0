Return-Path: <linux-fsdevel+bounces-41489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61772A2FE47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 00:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E431886AEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 23:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0170126136F;
	Mon, 10 Feb 2025 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjOe4yai"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547D31BBBD7
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739229553; cv=none; b=rM6hggW5L7NXtkkr4cHMC/wTgITQKiUYFm2gM+OYpKpZwXakKYt7m2oAf8VyD+Gt28xPWpMiKtG4ShATbagFtImMTV2MC3cO5xH5J3zPWKpdBWc8d7z9ujVAM+50nmt5wZxKBfBwL3sMlINd8Z9m4EfXRqQH+XPql6t2f/BEoOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739229553; c=relaxed/simple;
	bh=WtfLk+YtNZL/W7iw8DNGwzsp9tN0JOYfou8cMl9XKtI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=rc5++IJbEuFGy/a2s3ZT9GO5SPCPLVtKj474k0DP20xOpWByiqJ2W20SufAFf7gR5EEccbw/mn1Cd8z/EDgJ1OO8tyYiu5mmop0YNnrDDKcfbyzhmfek7gu88seJOg38OCYT40r25NFkeRKx30f2ZOoF0xxCaMlKYav3aX7vVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjOe4yai; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739229549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BCFGrlEtzNntYujJOFVmJbBSaFSsuqUeDjxzqx00PbU=;
	b=TjOe4yaicRGLBwjfyGwUoo11vs1415or2xgsmjMAlMacQbACFU17XhCp7wjhYjRVf5bT5X
	as7NOg7aNLOX9a6IViyhFwDyEzPGPVYSZOkaKpyFAebTs6JXijgJF4tP18BFTZ5WcLdQPt
	F69asSA+M+LNmfXsuxI8y118++hsKrM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-qujH-pw7NCGUxgAQih54Bg-1; Mon,
 10 Feb 2025 18:19:06 -0500
X-MC-Unique: qujH-pw7NCGUxgAQih54Bg-1
X-Mimecast-MFC-AGG-ID: qujH-pw7NCGUxgAQih54Bg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A565B1800374;
	Mon, 10 Feb 2025 23:19:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C27CE3001D12;
	Mon, 10 Feb 2025 23:18:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <8d8a5d5b00688ea553b106db690e8a01f15b1410@linux.dev>
References: <8d8a5d5b00688ea553b106db690e8a01f15b1410@linux.dev> <335ad811ae2cf5ebdfc494c185b9f02e9ca40c3e@linux.dev> <3173328.1738024385@warthog.procyon.org.uk> <3187377.1738056789@warthog.procyon.org.uk> <2986469.1739185956@warthog.procyon.org.uk>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: dhowells@redhat.com, "Marc Dionne" <marc.dionne@auristor.com>,
    "Steve
 French" <stfrench@microsoft.com>,
    "Eric Van Hensbergen" <ericvh@kernel.org>,
    "Latchesar  Ionkov" <lucho@ionkov.net>,
    "Dominique Martinet" <asmadeus@codewreck.org>,
    "Christian Schoenebeck" <linux_oss@crudebyte.com>,
    "Paulo Alcantara" <pc@manguebit.com>,
    "Jeff Layton" <jlayton@kernel.org>,
    "Christian Brauner" <brauner@kernel.org>, v9fs@lists.linux.dev,
    linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    ast@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] netfs: Add retry stat counters
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3210863.1739229537.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Feb 2025 23:18:57 +0000
Message-ID: <3210864.1739229537@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Ihor Solodrai <ihor.solodrai@linux.dev> wrote:

> Done. I pushed the logs to the previously mentioned github branch:
> https://github.com/kernel-patches/bpf/commit/699a3bb95e2291d877737438fb6=
41628702fd18f

Perfect, thanks.

Looking at the last record of /proc/fs/netfs/requests, I see:

	REQUEST  OR REF FL ERR  OPS COVERAGE
	=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D =3D=3D=3D =3D=3D =3D=3D=3D=3D =3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D
	00000a98 RA   1 2001    0   0 @0000 2000/2000

So the request of interest is R=3D00000a98 in the trace.  Grepping for tha=
t, I
see (with a few columns cut out):

 test_progs-no_a-97: netfs_rreq_ref: R=3D00000a98 NEW         r=3D1
 test_progs-no_a-97: netfs_read: R=3D00000a98 READAHEAD c=3D00000000 ni=3D=
2ec02f16 s=3D0 l=3D2000 sz=3D17a8
 test_progs-no_a-97: netfs_rreq_ref: R=3D00000a98 GET SUBREQ  r=3D2
 test_progs-no_a-97: netfs_sreq: R=3D00000a98[1] DOWN TERM  f=3D192 s=3D0 =
17a8/17a8 s=3D1 e=3D0
 test_progs-no_a-97: netfs_rreq_ref: R=3D00000a98 GET WORK    r=3D3
 test_progs-no_a-97: netfs_sreq_ref: R=3D00000a98[1] PUT TERM    r=3D1
 test_progs-no_a-97: netfs_rreq_ref: R=3D00000a98 GET SUBREQ  r=3D4
 test_progs-no_a-97: netfs_sreq: R=3D00000a98[2] ZERO SUBMT f=3D00 s=3D17a=
8 0/858 s=3D0 e=3D0
    kworker/u8:2-36: netfs_rreq_ref: R=3D00000a98 SEE WORK    r=3D4
    kworker/u8:2-36: netfs_rreq: R=3D00000a98 RA COLLECT f=3D2021
    kworker/u8:2-36: netfs_sreq: R=3D00000a98[1] DOWN DSCRD f=3D92 s=3D0 1=
7a8/17a8 s=3D1 e=3D0
    kworker/u8:2-36: netfs_sreq_ref: R=3D00000a98[1] PUT DONE    r=3D0
    kworker/u8:2-36: netfs_sreq: R=3D00000a98[1] DOWN FREE  f=3D92 s=3D0 1=
7a8/17a8 s=3D1 e=3D0
    kworker/u8:2-36: netfs_rreq_ref: R=3D00000a98 PUT SUBREQ  r=3D3
    kworker/u8:2-36: netfs_rreq: R=3D00000a98 RA COMPLET f=3D2021
    kworker/u8:2-36: netfs_rreq: R=3D00000a98 RA WAKE-IP f=3D2021
    kworker/u8:2-36: netfs_rreq: R=3D00000a98 RA DONE    f=3D2001
    kworker/u8:2-36: netfs_rreq_ref: R=3D00000a98 PUT WORK    r=3D2
 test_progs-no_a-97: netfs_sreq: R=3D00000a98[2] ZERO TERM  f=3D102 s=3D17=
a8 858/858 s=3D1 e=3D0
 test_progs-no_a-97: netfs_rreq_ref: R=3D00000a98 GET WORK    r=3D3
 test_progs-no_a-97: netfs_sreq_ref: R=3D00000a98[2] PUT TERM    r=3D1
 test_progs-no_a-97: netfs_rreq_ref: R=3D00000a98 PUT RETURN  r=3D2
    kworker/u8:2-36: netfs_rreq_ref: R=3D00000a98 SEE WORK    r=3D2
    kworker/u8:2-36: netfs_rreq_ref: R=3D00000a98 PUT WORK    r=3D1

You can see subrequest 1 completes fine, the subrequest is freed and the r=
ef
it had on the request is put:

	netfs_sreq: R=3D00000a98[1] DOWN FREE  f=3D92 s=3D0 17a8/17a8 s=3D1 e=3D0
	netfs_rreq_ref: R=3D00000a98 PUT SUBREQ  r=3D3

Subrequest 2, however isn't collected:

	netfs_sreq: R=3D00000a98[2] ZERO SUBMT f=3D00 s=3D17a8 0/858 s=3D0 e=3D0
	netfs_sreq: R=3D00000a98[2] ZERO TERM  f=3D102 s=3D17a8 858/858 s=3D1 e=3D=
0
	netfs_sreq_ref: R=3D00000a98[2] PUT TERM    r=3D1

and the work happens again in kworker/u8:2-36 right at the end:

	netfs_rreq_ref: R=3D00000a98 SEE WORK    r=3D2
	netfs_rreq_ref: R=3D00000a98 PUT WORK    r=3D1

but this doesn't do anything.

The excess buffer clearance happened in the app thread (test_progs-no_a-97=
):

	netfs_sreq: R=3D00000a98[2] ZERO TERM  f=3D102 s=3D17a8 858/858 s=3D1 e=3D=
0

> Let me know if I can help with anything else.

Can you add some more tracepoints?

echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_collect/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_collect_sreq/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_collect_state/enable

However, I think I may have spotted the issue: I'm mixing
clear_and_wake_up_bit() for NETFS_RREQ_IN_PROGRESS (which will use a commo=
n
system waitqueue) with waiting on an rreq-specific waitqueue in such as
netfs_wait_for_read().

I'll work up a fix patch for that tomorrow.

Thanks,
David


