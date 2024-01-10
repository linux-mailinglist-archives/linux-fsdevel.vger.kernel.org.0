Return-Path: <linux-fsdevel+bounces-7695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9AC829716
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 11:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47449B24D7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3733FB2A;
	Wed, 10 Jan 2024 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QW9/ez6b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB8D3FB07
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704881677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N8fyAvLcym3lieO4wYcel0i1AGhFIX/f3clpYmcSXdA=;
	b=QW9/ez6bQXNcSy+gf/e8e+US/t6/PNd1zmtCi1p4RbTDmb3t775+dT8RK0YiOv6rZnaevy
	h7OP6XIsWb4UoPCvcDokA5Se4CwaXZ+IHmmxd+fbmWdswPKZv8HNlLiYvl8wkZsnX0qM6T
	7q3GF6gkpivM0HajI/RrTZjaxljWh+E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-OvzGbcwzPAGBkz83m5jLww-1; Wed, 10 Jan 2024 05:14:33 -0500
X-MC-Unique: OvzGbcwzPAGBkz83m5jLww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63AC78945A7;
	Wed, 10 Jan 2024 10:14:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3D79E2026D6F;
	Wed, 10 Jan 2024 10:14:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com>
References: <ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com> <CAHk-=wgJz36ZE66_8gXjP_TofkkugXBZEpTr_Dtc_JANsH1SEw@mail.gmail.com> <1843374.1703172614@warthog.procyon.org.uk> <20231223172858.GI201037@kernel.org> <2592945.1703376169@warthog.procyon.org.uk>
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: dhowells@redhat.com, eadavis@qq.com,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Simon Horman <horms@kernel.org>,
    Markus Suvanto <markus.suvanto@gmail.com>,
    Jeffrey E Altman <jaltman@auristor.com>,
    "Marc
 Dionne" <marc.dionne@auristor.com>,
    Wang Lei <wang840925@gmail.com>, "Jeff
 Layton" <jlayton@redhat.com>,
    Steve French <smfrench@gmail.com>,
    "Jarkko
 Sakkinen" <jarkko@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    "Eric
 Dumazet" <edumazet@google.com>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, keyrings@vger.kernel.org,
    linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    heng.su@intel.com
Subject: Re: [PATCH] keys, dns: Fix missing size check of V1 server-list header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1694630.1704881668.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jan 2024 10:14:28 +0000
Message-ID: <1694631.1704881668@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Pengfei Xu <pengfei.xu@intel.com> wrote:

>   Bisected info between v6.7-rc7(keyctl05 passed) and v6.7-rc8(keyctl05 =
failed)
> is in attached.
> =

> keyctl05 failed in add_key with type "dns_resolver" syscall step tracked
> by strace:
> "
> [pid 863107] add_key("dns_resolver", "desc", "\0\0\1\377\0", 5, KEY_SPEC=
_SESSION_KEYRING <unfinished ...>
> [pid 863106] <... alarm resumed>)       =3D 30
> [pid 863107] <... add_key resumed>)     =3D -1 EINVAL (Invalid argument)
> "

It should fail as the payload is actually invalid.  The payload specifies =
a
version 1 format - and that requires a 6-byte header.  The bug the patched
fixes is that whilst there is a length check for the basic 3-byte header,
there was no length check for the extended v1 header.

> After increased the dns_res_payload to 7 bytes(6 bytes was still failed)=
,

The following doesn't work for you?

	echo -n -e '\0\0\01\xff\0\0' | keyctl padd dns_resolver desc @p

David


