Return-Path: <linux-fsdevel+bounces-12005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB4A85A407
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 14:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A95B24EAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 13:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B459536124;
	Mon, 19 Feb 2024 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHTKpei2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004B35F0C
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347656; cv=none; b=IsdA+fTl6d9+Ab8N1QvjwFBnQHg5VZY8uY9xIZvdMIWNt78IJuSAs+N9MS+J7ZmWv/8hVneKIvGNm77aIoI5o8UTrCKOBqwUksVrbSE0vn2BthKgvoBrlKBidwWRcGpeYF88o4nlToKbqdTLqt6o+mfM8pnHKv4XtE7SSI9ON7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347656; c=relaxed/simple;
	bh=dHWiwi/4MsahdbBRvdAXd0W5GApiDgwNTSRWlu2vpSE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=VUKNqpc6+zlKoUuNlcEJiFo25oc22md5pA7vqiUH6uhkfNKkod8qQ3Us5wSYJzo6c2lx935nw17nvWi8KGv0RKeUXc62CU3kHYUNRkoCdJfgZzleqqkLBCRMn4wnG7pfKTGP2UZSc2m3TlLwbDjNfPXjItcUJfP4Z2+i+MjDc4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WHTKpei2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708347653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TwNcCYcnKDEqL3qwv8hEJSNKkkqFQa2yy0ZaFvuYG/I=;
	b=WHTKpei2dDzPv87YFnrLdAD4IuLXDSN31x9SSJE5z9ETXQfJBbfzycTFWDI5FDYRlv5aL3
	vwH+qw6ercpeWaT2LCEXJhs1fF26ggREOtNJnVnyV7a+Mh8sP7AnGyNvvKDB5jSQ0N2dGs
	ZR+Dey+LO0/v9AAYN+JyQ4/5Okd38Jk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-EKdDHX6EOFScijXKBRs-bg-1; Mon,
 19 Feb 2024 08:00:48 -0500
X-MC-Unique: EKdDHX6EOFScijXKBRs-bg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 937BD1C05AA6;
	Mon, 19 Feb 2024 13:00:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 14603AC0C;
	Mon, 19 Feb 2024 13:00:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240217081431.796809-1-libaokun1@huawei.com>
References: <20240217081431.796809-1-libaokun1@huawei.com>
To: Christian Brauner <christian@brauner.io>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    Baokun Li <libaokun1@huawei.com>, linux-cachefs@redhat.com,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] cachefiles: fix memory leak in cachefiles_add_cache()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <131232.1708347645.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Feb 2024 13:00:45 +0000
Message-ID: <131233.1708347645@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Hi Christian,

Could you take this through your VFS tree please?

> The following memory leak was reported after unbinding /dev/cachefiles:
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> unreferenced object 0xffff9b674176e3c0 (size 192):
>   comm "cachefilesd2", pid 680, jiffies 4294881224
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc ea38a44b):
>     [<ffffffff8eb8a1a5>] kmem_cache_alloc+0x2d5/0x370
>     [<ffffffff8e917f86>] prepare_creds+0x26/0x2e0
>     [<ffffffffc002eeef>] cachefiles_determine_cache_security+0x1f/0x120
>     [<ffffffffc00243ec>] cachefiles_add_cache+0x13c/0x3a0
>     [<ffffffffc0025216>] cachefiles_daemon_write+0x146/0x1c0
>     [<ffffffff8ebc4a3b>] vfs_write+0xcb/0x520
>     [<ffffffff8ebc5069>] ksys_write+0x69/0xf0
>     [<ffffffff8f6d4662>] do_syscall_64+0x72/0x140
>     [<ffffffff8f8000aa>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Put the reference count of cache_cred in cachefiles_daemon_unbind() to
> fix the problem. And also put cache_cred in cachefiles_add_cache() error
> branch to avoid memory leaks.
> =

> Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted file=
system")
> CC: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

and add:

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: David Howells <dhowells@redhat.com>


