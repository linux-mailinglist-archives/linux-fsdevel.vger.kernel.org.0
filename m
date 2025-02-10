Return-Path: <linux-fsdevel+bounces-41385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CFEA2EA45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 11:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142A83A07D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 10:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DBD1DED6B;
	Mon, 10 Feb 2025 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boPdFcxG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3711D47C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185087; cv=none; b=QL7LhnCGmo7hWO9QoaI+1RqxNyGmSa9X+2UKkrhjyk2hr9+uSDqme3T6rg6dWQBz4ydGhtBHyRcrejS8dMNuBIH6NEwHZyuvvs/NyV2zTVB78qlT8Oa8au5VmfGxjGgColaBGgkmzhxzkM5kGLE6ZW0byjaYDRwhwToxBXXFYJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185087; c=relaxed/simple;
	bh=vWv7UNywuHbbX95H499CJg9o/VWBHM3d/g4SWjJwcx0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=mcjZ6nkykmbA4uhQWCOibXZLXY1d9mQfndEIcVrk2bUQErzGduO9lxhYe+typz9XmoZ1idCMMMQ+wPKQtBa+c0/e3nqupCKba0ZHEnd0r5UtAkDjsfsSLQ7eQOnlLGVf/hjQMmS2ZMjinLDZp2FmwBgmUz4lGJO898GQxKBOnV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=boPdFcxG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739185084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyNTaqn/k/Z/XNNjhpEEGmhvU1IQLM++33YHYodhCTg=;
	b=boPdFcxGDFdOkYBon7p9CxXE4eNYFQpt0UwH9x+qJ1VthhxPeuPzI+A0xHmr8PAiexsOJV
	siTD7JLgyWZeZ76FCee/fiGPpt0udkbsx+yhnnNX6r8Kth/TSPX8f7FMcPQs7iENK4agpl
	dGBD0PI/LdAldk1yWv6Z+t99ZUF5Jno=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-CEEK-4T5M4mNX5PdTFK0ug-1; Mon,
 10 Feb 2025 05:58:00 -0500
X-MC-Unique: CEEK-4T5M4mNX5PdTFK0ug-1
X-Mimecast-MFC-AGG-ID: CEEK-4T5M4mNX5PdTFK0ug
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4747A195604F;
	Mon, 10 Feb 2025 10:57:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E900218004A7;
	Mon, 10 Feb 2025 10:57:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <335ad811ae2cf5ebdfc494c185b9f02e9ca40c3e@linux.dev>
References: <335ad811ae2cf5ebdfc494c185b9f02e9ca40c3e@linux.dev> <3173328.1738024385@warthog.procyon.org.uk> <3187377.1738056789@warthog.procyon.org.uk>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: dhowells@redhat.com, "Marc Dionne" <marc.dionne@auristor.com>,
    "Steve French" <stfrench@microsoft.com>,
    "Eric Van Hensbergen" <ericvh@kernel.org>,
    "Latchesar
 Ionkov" <lucho@ionkov.net>,
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
Content-ID: <2985986.1739185070.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Feb 2025 10:57:50 +0000
Message-ID: <2985987.1739185070@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Ihor Solodrai <ihor.solodrai@linux.dev> wrote:

> I recommend trying to reproduce with steps I shared in my initial report=
:
> https://lore.kernel.org/bpf/a7x33d4dnMdGTtRivptq6S1i8btK70SNBP2XyX_xwDAh=
LvgQoPox6FVBOkifq4eBinfFfbZlIkMZBe3QarlWTxoEtHZwJCZbNKtaqrR7PvI=3D@pm.me/
> =

> I know it may not be very convenient due to all the CI stuff,

That's an understatement. :-)

> but you should be able to use it to iterate on the kernel source locally=
 and
> narrow down the problem.

Can you share just the reproducer without all the docker stuff?  Is this o=
ne
of those tests that requires 9p over virtio?  I have a different environme=
nt
for that.

David


