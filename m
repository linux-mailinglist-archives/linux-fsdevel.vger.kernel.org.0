Return-Path: <linux-fsdevel+bounces-17873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB65E8B3310
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 10:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A481F216EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 08:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2490613DDC1;
	Fri, 26 Apr 2024 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wb9WHzoN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2313313D632
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120454; cv=none; b=BYoit97oHi+EZON0krwkKItYy86adbYQsnffLRt7MZ+dHZ24yfIq8p9N02Y9NqfEKAm4/+eBP7IE4gvY7AYxI8+8rk7hgRPG4vONlZnuwyklz4HU+xmvIc7Yr5qgtbwsSYdmdAWo27C6ct2axaNRLHjnqTHnu8+hKe6X1LMJUXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120454; c=relaxed/simple;
	bh=kt1qirSnBIx/luYlP/mepOvqv1Q7ipxYPxOcDHHjLLU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=STFcUmvCD3+pF8HQU7nlwQDqSF6iON/ZayURSHLwMnuk184ls2ErNy81Q5H6I/zZampjxsdAW80aH1UneT0Owvxyl7IzdkSBW/BzUHb7583TqaUhAc6PEOTxCkxduCM4EopN5o3o4cqsCNp8/gz5+kdudHxbYqYDO/MYevxPXvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wb9WHzoN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714120452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JX0C/eE8/IhmRZdY4t48yInlwmvvYIOtx58avujDOfw=;
	b=Wb9WHzoNxlOkWimWkzTPJg57jX9NdYRDaFgx4zyW4c32Esovw73TiuHfYqoBkyVA5o18cY
	4S7aj7s1LcDGfQAuK0swpE6zm3GOlN9hJgvwe+B+QTBA34pRtL6ZuKHi/imgbzfKdr+/oH
	pr5dKSCLlBbgf4jXpNg/MabZSz6FwNw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-5-xSqQlbNLWhSxB61eaJVg-1; Fri,
 26 Apr 2024 04:34:05 -0400
X-MC-Unique: 5-xSqQlbNLWhSxB61eaJVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F0C228C97CB;
	Fri, 26 Apr 2024 08:34:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A70B32024511;
	Fri, 26 Apr 2024 08:34:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Zin4G2VYUiaYxsKQ@xsang-OptiPlex-9020>
References: <Zin4G2VYUiaYxsKQ@xsang-OptiPlex-9020> <202404161031.468b84f-oliver.sang@intel.com> <164954.1713356321@warthog.procyon.org.uk>
To: Oliver Sang <oliver.sang@intel.com>
Cc: dhowells@redhat.com, oe-lkp@lists.linux.dev, lkp@intel.com,
    Steve French <sfrench@samba.org>,
    Shyam Prasad N <nspmangalore@gmail.com>,
    "Rohith
 Surabattula" <rohiths.msft@gmail.com>,
    Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
    samba-technical@lists.samba.org
Subject: Re: [dhowells-fs:cifs-netfs] [cifs] b4834f12a4: WARNING:at_fs/netfs/write_collect.c:#netfs_writeback_lookup_folio
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Apr 2024 09:34:02 +0100
Message-ID: <2145544.1714120442@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Oliver Sang <oliver.sang@intel.com> wrote:

> I can pass "sudo bin/lkp install job.yaml" on my local machine with fedor=
a 39
> now.

Note that this causes:

systemd-sysv-generator[23561]: SysV service '/etc/rc.d/init.d/network' lack=
s a native systemd unit file. =E2=99=BB=EF=B8=8F Automatically generating a=
 unit file for compatibility. Please update package to include a native sys=
temd unit file, in order to make it safe, robust and future-proof. =E2=9A=
=A0=EF=B8=8F This compatibility logic is deprecated, expect removal soon. =
=E2=9A=A0=EF=B8=8F

to appear.  What's it doing to the networking settings?  It shouldn't be
touching those.

Also, does it have to install its own cifs server?  Can it not be directed =
to
my test server that's already set up on another machine?  And does it have =
to
build a kernel?  Can it not use the one that's already running on the machi=
ne?

David


