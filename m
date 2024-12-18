Return-Path: <linux-fsdevel+bounces-37756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBB79F6E68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 20:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C6B1894856
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 19:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADFB1FC102;
	Wed, 18 Dec 2024 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/qLMlfG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46221991BB
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734550999; cv=none; b=cy59E0KHMkTZpBqOeAiHn4uJpglW8SS5aNZnMa4Wil6hpW8swKlYBN/D2iUrYyrxGImg3d1QY3jYnQrtiESVTDGk1vI/HvQkHS+GmR9boJO5oi4O21JnOFnjCXpu72+M4DRIZPGg4+xNaAzNI5J07ndhzgKAevPZXeOg5uyb12A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734550999; c=relaxed/simple;
	bh=EumCg71PKp66EbU67mGD4ms9wWWB9uYEHczDZbj/MBo=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=TwADpKb91BPiYx0jwV3rEmqNhM9az1qFYeDuruXb+4WLdcLU1K/z0pOOnnK2n6ROiIUdD4ZCHdKV3Zdc3DNa59FF9L2kv6W7MsIFs/spX/IIUoTRoW1bWF6Q/rj6gerFZ73s3DV6HLA7/MflgmULF7cPfNUlRWXCXHnXHJblYTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/qLMlfG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734550996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SmDgTt04L2dfJvmBPkH5BYsGeg5OOD2ZgdtZVVBBxc=;
	b=e/qLMlfG6CSXOhk8uTUV16Uy7qs5fBpu7esrNmQyezdPXJwHIhPrwdCh/ym2RLg9PG8t5B
	wFq40wZkE3g6YM/aEe+JJWABj8HV7qaUmxoVQFOafKWGmpBmENWrnl9MMrgliAVRA2EaLF
	QjeakxQxFZnhEMGl1kJvqkfgPINLFpA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-6HZuLdxdNFe9bzlX9UvGRw-1; Wed,
 18 Dec 2024 14:43:09 -0500
X-MC-Unique: 6HZuLdxdNFe9bzlX9UvGRw-1
X-Mimecast-MFC-AGG-ID: 6HZuLdxdNFe9bzlX9UvGRw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4ACD419560AF;
	Wed, 18 Dec 2024 19:43:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1BFEF300F9B5;
	Wed, 18 Dec 2024 19:43:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3989572.1734546794@warthog.procyon.org.uk>
References: <3989572.1734546794@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
    Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
    Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: Ceph and Netfslib
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3991937.1734550983.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Dec 2024 19:43:03 +0000
Message-ID: <3991938.1734550983@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

David Howells <dhowells@redhat.com> wrote:

> =

> I don't know whether you know, but I'm working on netfslib-ising ceph wi=
th an
> eye to moving all the VFS/VM normal I/O interfaces to netfslib (->read_i=
ter,
> ->write_iter, ->readahead, ->read_folio, ->page_mkwrite, ->writepages), =
though
> with wrapping/methods by which each network filesystem can add its own
> distinctive flavour.
> =

> Also, that would include doing things like content encryption, since tha=
t is
> generally useful in filesystems and I have plans to support it in both A=
FS and
> CIFS as well.

I should also mention that netfslib brings multipage folio support with it
too.  All the filesystem has to do is to flip the bit:

	mapping_set_large_folios(inode->i_mapping);

On reading, netfs will tile subrequests drawn from both the server and the
local cache across a sequence of multipage folios.  On writing, it will wr=
ite
the data in parallel to both the server and the local cache, tiling
subrequests for both separately across the folios to be written.

Subrequests don't have to match folios in size or alignment and nor, when
writing, do subrequests going to the server have to match subrequests goin=
g to
the local cache.

Whilst on writing it only permits two parallel streams - one to the server=
 and
one to the cache - this is just an array with a hard-coded size at the mom=
ent
and could made expandable later to allow simultaneous writing to multiple
servers with different I/O characteristics.

David


