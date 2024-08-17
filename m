Return-Path: <linux-fsdevel+bounces-26177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833ED955628
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 09:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BACF281A67
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 07:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628A313EFEE;
	Sat, 17 Aug 2024 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XW/7kotd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255E813D880
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723879524; cv=none; b=luB66ykF3aVBRyWDGErQv0MOc0FoVfMJwlkvYMZDgrTbtZSQXOLzh7Qx1UvkMdD5PLJDlcb0GC9/4hdzLF7AVkzijqMrhADL1idIADBf+yJL8z2Ka770kndBVV/Id15+BgAYlB9iB30ryjp38qbKiVYGFLdmcwe/dsrl/0ifBFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723879524; c=relaxed/simple;
	bh=J58qyY1dIf3fsyEM5X/O0hHB0Dj14Rs70YnJiL2SxR4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=NwUjuJes/4h+dgDNOKsGMdpZ3pgpJeByzahNIPaB+oiVBGWR0qHfSeAOuISwo4qJh6YzPQsY+6IvY8WkMT7kjXfOwsWU4ftR/DRrvM7FYXUyD6I8+Kgzj3CrKSvyl23dyAXtK2ldUDLb15EimEwVJaw6S2HSMgn+IkvXrt+g29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XW/7kotd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723879521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OMOwGg5dl5W2520NqtMpFscL8MlK/BxGGQG5guJsQxI=;
	b=XW/7kotdjT+dB79ssAM2PYccUzMbOyVomAMX1PtwlBD5u5E3GpAo2cqLGYo6GPVn6R99xL
	HU+JG5/AltqRT0GkltmNfrfjvO04/ubUCaTd62Ao57kTcPIIzPHBIjdxwY0mTqIwB4qK9b
	cNvK0DQZYJejsce28jlUtetvjRszwB8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-75_9QSSmOZiEZ0_zsJit3g-1; Sat,
 17 Aug 2024 03:24:53 -0400
X-MC-Unique: 75_9QSSmOZiEZ0_zsJit3g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B559419560B4;
	Sat, 17 Aug 2024 07:24:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4A6A19540F0;
	Sat, 17 Aug 2024 07:24:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <rkjfi4wcv3rzthhc3ytswry3vposdxpm7bzfjz4tozdyaazdle@rg7x23beryre>
References: <rkjfi4wcv3rzthhc3ytswry3vposdxpm7bzfjz4tozdyaazdle@rg7x23beryre> <20240816-vfs-misc-dio-v1-1-80fe21a2c710@kernel.org> <2834955.1723825625@warthog.procyon.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
    Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] inode: remove __I_DIO_WAKEUP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3095916.1723879488.1@warthog.procyon.org.uk>
Date: Sat, 17 Aug 2024 08:24:48 +0100
Message-ID: <3095917.1723879488@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Mateusz Guzik <mjguzik@gmail.com> wrote:

> ... atomic_read and atomic_set -- these merely expand to regular movs, ...

Ah, no, that's not necessarily true.  See arch/parisc/include/asm/atomic.h.

David


