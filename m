Return-Path: <linux-fsdevel+bounces-36370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C159E2851
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 17:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9F2289BA7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 16:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8154E1FA270;
	Tue,  3 Dec 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwSKULEr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1661F9F6B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244969; cv=none; b=F845eVq/GOnCBJcQnm881KdrpvGEaybYpboyp0s8Rm2RBWSj54TVaJ7oOjILeMDmFaJuOlRc7F2kRwvbnjcnqUdyw+sUH98zV93fo4MlVW/6A17y4cjMonZos+asCm1NvLXv1FjWJPdaoisqbKF/ZydIdeW2+fdsETAQV8P8OL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244969; c=relaxed/simple;
	bh=7Gx75QDlyoDonl8gsJEr0X4zw3xiB1g1IW3hMV6K+3U=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=T5Ss5haI0rCDe2bjQeT6hYdqTmkdmMlBRCIRI/tg2ShJgARGMsVF7QiZRyIsN03C7/J2usMivlsjqngXdcp/JzvUkFR6dkAy0us99TjRQ6FMmqko6zZc7F6iP3HbLBSMBvQ3182Bc9/DEhfX2LJ9DqF1XRgzOKt88YKt0E9ErBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DwSKULEr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733244965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DV9CirJEkNvuIp9vIxKxT+t7dtJcsduQ7RHNpTrXiWQ=;
	b=DwSKULEr+iRfMpURP4LWpuwomYutnYNbmjj6d7c7PGsbRnnEJ8ZYdIQznqiCrOYA7ORhzu
	V1V8np1r2ekRwxlnDu575dQwkid2xYBvx805qiVHH6FHT6WpkAtoKdnB1C3wt1nMkbxQmz
	pxFoZgEHPfeXGF4cJ2HkYyBxAs8JNDw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-BLyc-I2_PU6o9ocECVBXbg-1; Tue,
 03 Dec 2024 11:56:00 -0500
X-MC-Unique: BLyc-I2_PU6o9ocECVBXbg-1
X-Mimecast-MFC-AGG-ID: BLyc-I2_PU6o9ocECVBXbg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 377AF1955D96;
	Tue,  3 Dec 2024 16:55:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BAACA19560A3;
	Tue,  3 Dec 2024 16:55:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CA+G9fYuLXDh8GDmgdhmA1NAhsma3=FoH1n93gmkHAGGFKbNGeQ@mail.gmail.com>
References: <CA+G9fYuLXDh8GDmgdhmA1NAhsma3=FoH1n93gmkHAGGFKbNGeQ@mail.gmail.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org,
    open list <linux-kernel@vger.kernel.org>,
    lkft-triage@lists.linaro.org, Jeff Layton <jlayton@kernel.org>,
    Dan Carpenter <dan.carpenter@linaro.org>,
    Anders Roxell <anders.roxell@linaro.org>,
    Arnd Bergmann <arnd@arndb.de>
Subject: Re: fs/netfs/read_retry.c:235:20: error: variable 'subreq' is uninitialized when used here [-Werror,-Wuninitialized]
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <589334.1733244955.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Dec 2024 16:55:55 +0000
Message-ID: <589335.1733244955@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> Build error:
> ---------
> fs/netfs/read_retry.c:235:20: error: variable 'subreq' is
> uninitialized when used here [-Werror,-Wuninitialized]
>   235 |         if (list_is_last(&subreq->rreq_link, &stream->subrequest=
s))
>       |                           ^~~~~~
> fs/netfs/read_retry.c:28:36: note: initialize the variable 'subreq' to
> silence this warning
>    28 |         struct netfs_io_subrequest *subreq;
>       |                                           ^
>       |                                            =3D NULL
> 1 error generated.
> make[5]: *** [scripts/Makefile.build:194: fs/netfs/read_retry.o] Error 1
> =

> Build image:
> -----------
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202411=
26/testrun/26060810/suite/build/test/clang-19-lkftconfig/log
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202411=
26/testrun/26060810/suite/build/test/clang-19-lkftconfig/details/
> - https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjvChfT6aOW=
plZaZeQzbYCX/
> =

> Steps to reproduce:
> ------------
> - tuxmake --runtime podman --target-arch x86_64 --toolchain clang-19
> --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjv=
ChfT6aOWplZaZeQzbYCX/config
> LLVM=3D1 LLVM_IAS=3D1
> =

> The git log shows
> $ git log --oneline  next-20241122..next-20241125 -- fs/netfs/read_retry=
.c
> 1bd9011ee163e netfs: Change the read result collector to only use one wo=
rk item
> 5c962f9982cd9 netfs: Don't use bh spinlock
> 3c8a83f74e0ea netfs: Drop the was_async arg from netfs_read_subreq_termi=
nated()
> 2029a747a14d2 netfs: Abstract out a rolling folio buffer implementation
> =

> metadata:
> ----
>   git describe: next-20241125 and next-20241126
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-n=
ext.git
>   git sha: ed9a4ad6e5bd3a443e81446476718abebee47e82
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjvChfT6aOWpl=
ZaZeQzbYCX/config

That should be fixed on my branch now:

   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/l=
og/?h=3Dnetfs-writeback

I'm just moving the branch to v6.13-rc1 and fixing reported issues before
asking Christian to repull it.

David


