Return-Path: <linux-fsdevel+bounces-17126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AA08A8302
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 14:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9D81F22448
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 12:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C0E13CF87;
	Wed, 17 Apr 2024 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nh3e1gxT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E9B13D28C
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356335; cv=none; b=RluWu4GGQysg0Pq3M5t/ZtypF3LK/wZ+Ze54J4muXYE9EfnVxseXCokiXSVGWY40ITvxp5ozMQhdR5YxZwRW5bY1QUpn8rZBkR6wOCF5xhJn0RJ3R/HJUMUd/twFx0hf1DF29IGEi7877nPrZWK1XFHKxAy0mC4gXdnt/chqqPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356335; c=relaxed/simple;
	bh=e5g+9Z9HtsHEKxe2LaOAecd54UvAXCkGQ96msWQj9N4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=FpQt75jokUd7MEMW3YySNCwq5Qx/tJzzVVVzWNWxD5kY+kz/USpfZF8ICZvGuLMmxNSoE0rQRh35xEUj6CVeBTe5JkAz72aGFeFycAR9C6+5EEJ8gPLJc4RzkD8MDMQ1rjijB0f6JUhDh326xbNUfhOm1Fv7BVlaGupHZi77V6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nh3e1gxT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713356332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5g+9Z9HtsHEKxe2LaOAecd54UvAXCkGQ96msWQj9N4=;
	b=Nh3e1gxTGEjWYbibhmTlrm8IO+AGZzLdGzcgkjJxEMXeFzGl1digl4i/rSMEmNSdKmn0Ed
	ybPB1thskLwBc4Gd/lAt5x9OfDd5e0wFp+jqnbsS9GUbTRiwMsNhhivoj01MM+nfzGkk8n
	jCoo4xSo6CripZvzl9uKX0thwJTGhMM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-HZb4tYkCOiuraGxVwvC9Yw-1; Wed,
 17 Apr 2024 08:18:48 -0400
X-MC-Unique: HZb4tYkCOiuraGxVwvC9Yw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D17DE3C0253F;
	Wed, 17 Apr 2024 12:18:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 762A6112132A;
	Wed, 17 Apr 2024 12:18:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <202404161031.468b84f-oliver.sang@intel.com>
References: <202404161031.468b84f-oliver.sang@intel.com>
To: kernel test robot <oliver.sang@intel.com>
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
Content-ID: <164953.1713356321.1@warthog.procyon.org.uk>
Date: Wed, 17 Apr 2024 13:18:41 +0100
Message-ID: <164954.1713356321@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

When I try and do "sudo bin/lkp install job.yaml", I get an error because
Fedora 39 doesn't have a libarchive-tools package.

Also, I can't find a "filemicro_seqwriterandvargam.f" script, presumably
because it would get patched into existence by the failing install step above.

David


