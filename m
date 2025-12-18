Return-Path: <linux-fsdevel+bounces-71676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDD0CCCDED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 17:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3138302717C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 16:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E081E346AD0;
	Thu, 18 Dec 2025 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9pU6HoV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13DF341050
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073727; cv=none; b=CNLYH0WuEXqNgnkaX3mpVdy3JU7M2FZ4D3WJ8BVRRr8D8hHY+ytd7mweQx07S+2VIs0vPoqSajiLB7+jw5J423gT1a73NZQOHLByTfz+Dy6MZ7Byssr1kJzp1VLPt0AlmOCCZ+NaQ5rJ62R1S1QQorjNbIAI20W4Lc9oXcNltyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073727; c=relaxed/simple;
	bh=BScBlqt9oUPsNau3zG+LX8szxfFdQg7PIgNCX4laoeI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=RPn+Jyc1WAoAjpQgWnWIixI3M8ydI9mJjkHxnOiowrkAFQ2Bh4CZyVIXkyZ+vBvsyvrvZCHYJAbhNsIDSXjzDFBSjEqAxzMLPFoJb0E+Ra9rumKVJI7ysU0ChDg2cXLWb/wHMHSCer4P2IPDv0+5LWxPFQlpUpC6odAQDFzWO54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9pU6HoV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766073724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ab/c4h5GVt8vnw4hGY058QQvtrKLjtG4Mq92Qr9Slk=;
	b=X9pU6HoVY2tMrgvXHby2j7KE5Fu+zSz0Nn1t87hfvuTqy7KBvhSMlNHCkpi3sPbKFC6Pc/
	9NMU4e3aJ/ru56h3AEn2d1AtUZjE0hNXHt0BN2K8oq3dAMtiNhhZM7XY2zwso5gRBkrXzF
	RqPrpNeo0gFDuBzw5j32Cf1EpuHmfmk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-1AA64_CYPTC-jcxPcZa4fg-1; Thu,
 18 Dec 2025 11:02:00 -0500
X-MC-Unique: 1AA64_CYPTC-jcxPcZa4fg-1
X-Mimecast-MFC-AGG-ID: 1AA64_CYPTC-jcxPcZa4fg_1766073719
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B72D7195FCED;
	Thu, 18 Dec 2025 16:01:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BCB671956056;
	Thu, 18 Dec 2025 16:01:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <b5ebd3be-c567-44bb-9411-add5e79234dc@linux.dev>
References: <b5ebd3be-c567-44bb-9411-add5e79234dc@linux.dev> <712257.1766069339@warthog.procyon.org.uk>
To: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
Cc: dhowells@redhat.com, Namjae Jeon <linkinjeon@kernel.org>,
    Steve French <sfrench@samba.org>,
    Sergey Senozhatsky <senozhatsky@chromium.org>,
    Tom Talpey <tom@talpey.com>, Paulo Alcantara <pc@manguebit.org>,
    Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ksmbd: Fix to handle removal of rfc1002 header from smb_hdr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <753139.1766073714.1@warthog.procyon.org.uk>
Date: Thu, 18 Dec 2025 16:01:54 +0000
Message-ID: <753140.1766073714@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev> wrote:

> `ksmbd_conn_handler_loop()` calls `get_rfc1002_len()`. Does this need to be
> updated as well?

I don't think so.  It reads the RFC1002 header into a 4-byte array (hdr_buf)
and calls get_rfc1002_len() on that, so that should be unaffected.

> Since the size of `struct smb_hdr` has changed, the value of
> `SMB1_MIN_SUPPORTED_HEADER_SIZE` should also be updated to `(sizeof(struct
> smb_hdr) + 4)`. `SMB1_MIN_SUPPORTED_HEADER_SIZE` is used in
> `ksmbd_conn_handler_loop()`.

Actually, should SMB2_MIN_SUPPORTED_HEADER_SIZE include the +4 at all?
pdu_size is the length stored in the RFC1002 header, which does not include
itself.

David


