Return-Path: <linux-fsdevel+bounces-36679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67039E7A77
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 22:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358731888765
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 21:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585F6213E81;
	Fri,  6 Dec 2024 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPoC01pq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFBC213E6A
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519619; cv=none; b=l77xRlrffxUiNUTMArh0avt+Y8hlJkBQWs2INYHJdBpz/tPcPjAtjTWrNLx4fvHrEZsEg9Qz4/2RGFcF4sotOFJvcc5Ja/KRZrgCgQ9Q8M+INaF9+fC+RKLTyxGp7MEufqnvEOZj7l7suovaC4M6d7YC0WiHzFVYW6HjQtkgOy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519619; c=relaxed/simple;
	bh=UmyiWS3FvApH/OGcGuiDKK7Yco/2XZG4nu/5S0zwsIw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=lo0P7SlynhuTxRIvYfHhYD2IFjL6XCuY23NCcvARilCs05ZcWEsLZ1oxvYNU24AWy6d2fiwvp3ZrXhGih8ID+DKugiCnnVShKA0UEwMYgxOJCPWdseh3dudSdy/TSWTyCxzTA4KfeksEN+2ASBnjlTT7Bq7jnjNV2t3IrcJZVJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPoC01pq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733519617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cSUJegE2rtjeYKwXEyaKur6j8cDYr8o25vQqsWAVYBA=;
	b=RPoC01pqlDypxNHJ0qToD8fWrWapd9wSfUuH13+CB51yr4SgyPfl/sWejH2jy7zsa5S7gR
	rwJ6KcPAblgmimZt+SC5FVEaM3rE0ORQUXVxC4EwnQNbTMZRPhuhw7yp215PSHAwdkGEar
	DvUujtmJZ7WlFqiju9zPlTTJhbyuQ3M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-KSFQMdm-PCuJQiNgdilzKg-1; Fri,
 06 Dec 2024 16:13:34 -0500
X-MC-Unique: KSFQMdm-PCuJQiNgdilzKg-1
X-Mimecast-MFC-AGG-ID: KSFQMdm-PCuJQiNgdilzKg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 152541956089;
	Fri,  6 Dec 2024 21:13:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 301F63000238;
	Fri,  6 Dec 2024 21:13:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKPOu+_OamJ-0wsJB3GOYu5v76ZwFr+N2L92dYH6NLBzzhDfOQ@mail.gmail.com>
References: <CAKPOu+_OamJ-0wsJB3GOYu5v76ZwFr+N2L92dYH6NLBzzhDfOQ@mail.gmail.com> <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com> <3990750.1732884087@warthog.procyon.org.uk> <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com> <CAKPOu+9xvH4JfGqE=TSOpRry7zCRHx+51GtOHKbHTn9gHAU+VA@mail.gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    netfs@lists.linux.dev, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
    linux-kernel@vger.kernel.org
Subject: Re: 6.12 WARNING in netfs_consume_read_data()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1995559.1733519609.1@warthog.procyon.org.uk>
Date: Fri, 06 Dec 2024 21:13:29 +0000
Message-ID: <1995560.1733519609@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Max Kellermann <max.kellermann@ionos.com> wrote:

> 
> I tried with 6.12.3 + dhowells/netfs-writeback; David's branch solved
> many problems and it took much longer to trigger the hang, but it
> eventually occurred:

Can you get some tracing for me?

echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_failure/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_rreq/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_sreq/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_folio/enable
echo 1 >/sys/kernel/debug/tracing/events/cachefiles/cachefiles_read/enable
echo 1 >/sys/kernel/debug/tracing/events/cachefiles/cachefiles_write/enable

(And compress the result before posting)

Thanks,
David


