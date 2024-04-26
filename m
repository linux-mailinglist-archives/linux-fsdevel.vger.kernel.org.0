Return-Path: <linux-fsdevel+bounces-17878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C64E8B336F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 10:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58741F21B01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 08:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D546613CFA9;
	Fri, 26 Apr 2024 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUo6s2AZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8D013C8E0
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714121826; cv=none; b=OIUvkTX82JFxYKMq9MwuOWV2zgNOqz2DGJeuUU8XqO1VdvebwaDP37ggMQsBkfkla1TTh11l8HsEBZ/q2VQFcVmnkvxa9x4/ZC6zaIz/Dr9fqeLOywpFac/jx/RdoP0gGvIjxLY7BDKel4Oisel/emiupGgz/iZv1NBIWurhkug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714121826; c=relaxed/simple;
	bh=1XTN5T6PRQMZa8FXz2scQeKYQ8+8piXFIKhjXNy4qqk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=apEQSMpNFwDUKP3Qbuf58EHvQNszxKINUEoULJfhzkqg+ZCwHd3SVBicIB662E2ij8MhiLVuxZwXuyCa9JcpK6BuqbPXv+6YFhMU95n36fyQhuHJnCZt/lQXmpQG5jAbv/pxbYvtGFVscm7xO3YGCSgaLnDvzk3v0pWUKKuYors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RUo6s2AZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714121823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2pEeDTYgZgn4hwUL7ZGzmZnqIMR6LoTfbNN89+uR1s=;
	b=RUo6s2AZe8NQ5NpJpLKfHcyvqqouScb5cATRaWiRYCAvUZCQEQHwtlkx4JGtuYFUI0+Jev
	UBi4/0UmQl/FedbAHWhwPXDVKT81lH8ghgMpAt2pcfcmGOt7/TALgeBUwq+/MD3mLHhDr7
	dwLGYJYPdMaUOxycnhqmagUfuGHPuvM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-qRaC9TC_OIC8O5N87ajHKw-1; Fri, 26 Apr 2024 04:57:00 -0400
X-MC-Unique: qRaC9TC_OIC8O5N87ajHKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B03E8032FA;
	Fri, 26 Apr 2024 08:56:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 146B72166B31;
	Fri, 26 Apr 2024 08:56:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2145850.1714121572@warthog.procyon.org.uk>
References: <2145850.1714121572@warthog.procyon.org.uk> <Zin4G2VYUiaYxsKQ@xsang-OptiPlex-9020> <202404161031.468b84f-oliver.sang@intel.com> <164954.1713356321@warthog.procyon.org.uk>
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
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2145948.1714121817.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Apr 2024 09:56:57 +0100
Message-ID: <2145949.1714121817@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

David Howells <dhowells@redhat.com> wrote:

> =3D=3D> Retrieving sources...
>   -> Source is https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git
>   -> Cloning linux git repo...
> Cloning into bare repository '/root/lkp-tests/programs/turbostat/pkg/lin=
ux'...

Actually, it cloned the linux git repo twice by http, once into:

	programs/turbostat/pkg/linux/

which is a bare repo, and once into:

	tmp-pkg/turbostat/src/linux/

which has all the files checked out.

If it must clone linux, can it at least clone one from the other?

David


