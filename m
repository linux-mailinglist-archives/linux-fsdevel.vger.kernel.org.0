Return-Path: <linux-fsdevel+bounces-46254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59570A85F36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 15:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FFE1BC497E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 13:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213751F1317;
	Fri, 11 Apr 2025 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULnEshjX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82BB1F76C2
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378372; cv=none; b=M6N7nRefRANeIgge7ryMZPwlYtSR8jKrm20Til/v5Igc7cqnTrV4sn7oQtSnWZftyNWYzADKcl7eJDhZmQD6+qMDt2d1jfgGsal0NUdHWHMEfpYghX+/b1OB/TCQhd9aXudULhLxOVz8ZBlVMk8905iv/ukLWLNTFJ4YKlWaCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378372; c=relaxed/simple;
	bh=QbRv7MQscUqVyaYV3ngZqzPBCMXRpBOWY/0Mlt51EiA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=X/+KADbQFNfhAyfNP72Hauz+kg9VVutNMNayCingF+K+EXBtv3w2Rf5mQRCR13N1QUeBQKC4XfKSQpnokq3rIFhZW9D5wsclBxrbeZpX+uFRFCzCUKNmYJPNhgEkH0+t3OWXdBcF1TQqDpQTvK448BqHrQ6CouvNWa7PGAh0vfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULnEshjX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744378369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsaVlHAtrpLtXp2YSOsqrDFUnRxErtB8/tE5rfri0KQ=;
	b=ULnEshjXEFQTl0YnJC8YeUmy2gl86oRK+w+/mlaZUkXriHwSb5J1CDhRPTbrSWlXv0cZus
	y2mBN1cao5FG4wwZph3frqEvju0bE3RgRJXOaVGLmpSY+ow4s/qWZQWCM9tPu8uQigZsnP
	/sqdY8HpTqs2FaUAwiqV+EKpNMzpidg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-CWmmYwr6MFusAhR0XMIxUw-1; Fri,
 11 Apr 2025 09:32:46 -0400
X-MC-Unique: CWmmYwr6MFusAhR0XMIxUw-1
X-Mimecast-MFC-AGG-ID: CWmmYwr6MFusAhR0XMIxUw_1744378365
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D681E1800361;
	Fri, 11 Apr 2025 13:32:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.40])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F188C19560AD;
	Fri, 11 Apr 2025 13:32:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250409170015.2651829-1-song@kernel.org>
References: <20250409170015.2651829-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, pc@manguebit.com, kernel-team@fb.com
Subject: Re: [PATCH v2] netfs: Only create /proc/fs/netfs with CONFIG_PROC_FS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2370195.1744378361.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Apr 2025 14:32:41 +0100
Message-ID: <2370196.1744378361@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Song Liu <song@kernel.org> wrote:

> When testing a special config:
> =

> CONFIG_NETFS_SUPPORTS=3Dy
> CONFIG_PROC_FS=3Dn
> =

> The system crashes with something like:
> =

> [    3.766197] ------------[ cut here ]------------
> [    3.766484] kernel BUG at mm/mempool.c:560!
> [    3.766789] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> [    3.767123] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W
> [    3.767777] Tainted: [W]=3DWARN
> [    3.767968] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> [    3.768523] RIP: 0010:mempool_alloc_slab.cold+0x17/0x19
> [    3.768847] Code: 50 fe ff 58 5b 5d 41 5c 41 5d 41 5e 41 5f e9 93 95 =
13 00
> [    3.769977] RSP: 0018:ffffc90000013998 EFLAGS: 00010286
> [    3.770315] RAX: 000000000000002f RBX: ffff888100ba8640 RCX: 00000000=
00000000
> [    3.770749] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000=
ffffffff
> [    3.771217] RBP: 0000000000092880 R08: 0000000000000000 R09: ffffc900=
00013828
> [    3.771664] R10: 0000000000000001 R11: 00000000ffffffea R12: 00000000=
00092cc0
> [    3.772117] R13: 0000000000000400 R14: ffff8881004b1620 R15: ffffea00=
04ef7e40
> [    3.772554] FS:  0000000000000000(0000) GS:ffff8881b5f3c000(0000) knl=
GS:0000000000000000
> [    3.773061] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.773443] CR2: ffffffff830901b4 CR3: 0000000004296001 CR4: 00000000=
00770ef0
> [    3.773884] PKRU: 55555554
> [    3.774058] Call Trace:
> [    3.774232]  <TASK>
> [    3.774371]  mempool_alloc_noprof+0x6a/0x190
> [    3.774649]  ? _printk+0x57/0x80
> [    3.774862]  netfs_alloc_request+0x85/0x2ce
> [    3.775147]  netfs_readahead+0x28/0x170
> [    3.775395]  read_pages+0x6c/0x350
> [    3.775623]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    3.775928]  page_cache_ra_unbounded+0x1bd/0x2a0
> [    3.776247]  filemap_get_pages+0x139/0x970
> [    3.776510]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    3.776820]  filemap_read+0xf9/0x580
> [    3.777054]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    3.777368]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    3.777674]  ? find_held_lock+0x32/0x90
> [    3.777929]  ? netfs_start_io_read+0x19/0x70
> [    3.778221]  ? netfs_start_io_read+0x19/0x70
> [    3.778489]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    3.778800]  ? lock_acquired+0x1e6/0x450
> [    3.779054]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    3.779379]  netfs_buffered_read_iter+0x57/0x80
> [    3.779670]  __kernel_read+0x158/0x2c0
> [    3.779927]  bprm_execve+0x300/0x7a0
> [    3.780185]  kernel_execve+0x10c/0x140
> [    3.780423]  ? __pfx_kernel_init+0x10/0x10
> [    3.780690]  kernel_init+0xd5/0x150
> [    3.780910]  ret_from_fork+0x2d/0x50
> [    3.781156]  ? __pfx_kernel_init+0x10/0x10
> [    3.781414]  ret_from_fork_asm+0x1a/0x30
> [    3.781677]  </TASK>
> [    3.781823] Modules linked in:
> [    3.782065] ---[ end trace 0000000000000000 ]---
> =

> This is caused by the following error path in netfs_init():
> =

>         if (!proc_mkdir("fs/netfs", NULL))
>                 goto error_proc;
> =

> Fix this by adding ifdef in netfs_main(), so that /proc/fs/netfs is only
> created with CONFIG_PROC_FS.
> =

> Signed-off-by: Song Liu <song@kernel.org>

Acked-by: David Howells <dhowells@redhat.com>


