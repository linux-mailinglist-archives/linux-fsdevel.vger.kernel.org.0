Return-Path: <linux-fsdevel+bounces-12031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9334C85A761
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 16:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F79281990
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 15:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D578538F83;
	Mon, 19 Feb 2024 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNjgSegG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4DE3A1D0
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356621; cv=none; b=L899KjUsNFoe0LyOvTWO3rxnhKXfOrSp0MY84AuWWC/KlSP4/QusNWY5wRUQfhZ6312eBNNGZgqTxDDH9qgq9GcvQkvSPIhUxUgic7AKbFi+QtmyuJerFu/rurX55W/cHuVMA9tera58RbJoHfHC7d8hIfMWlpNMIMEIF7zj7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356621; c=relaxed/simple;
	bh=hvcSZggNYwd1CYJgsripQwgsNNAg6Cy3z4QCGLatV4w=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=B74GObtgOC/bPRs3kTGd8YgVC39pr7KxWDiKIRF5qvCFDYDpIatXdAZRd9UHLcnl0Ohb8YC/UiGikzexz3mg8UdGYmB+6xftjAhsguHso+Gf5mSc2NQRA998ze/QON94ZaRynz3uKocWWF3OuQ2cJgvDl6G8y8ioPPYZUkwYKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNjgSegG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708356619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QYaLkDingG/oVb75goCjWGn8ofJus/df9gihxIlJ4do=;
	b=HNjgSegGTW42rS1hsKIcfWBcQJPh7qKlLE5rDuXSQ1CZEoAf0eBSbx7wmsguaUyZglfIMU
	KfsHYpLMK9F4i8cID0r3ZzdZxYHZW1hx1qQOymGsaXKJ2/1wqHCLc46KT66j1NaUxTxrv5
	PThXL9eijyNn2nK4oGtLAxajNlZRV+s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-Te3Sd4D0PO62j8L3FVOFPQ-1; Mon, 19 Feb 2024 10:30:14 -0500
X-MC-Unique: Te3Sd4D0PO62j8L3FVOFPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A649A85A58C;
	Mon, 19 Feb 2024 15:30:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 25202C08496;
	Mon, 19 Feb 2024 15:30:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5mu0Dw7jVHFaz4cYCNjWj9RFa76pRTyQOEenDACHDgNfyg@mail.gmail.com>
References: <CAH2r5mu0Dw7jVHFaz4cYCNjWj9RFa76pRTyQOEenDACHDgNfyg@mail.gmail.com> <20240205225726.3104808-1-dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Christian Brauner <christian@brauner.io>, netfs@lists.linux.dev,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/12] netfs, cifs: Delegate high-level I/O to netfslib
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <187135.1708356611.1@warthog.procyon.org.uk>
Date: Mon, 19 Feb 2024 15:30:11 +0000
Message-ID: <187136.1708356611@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Steve French <smfrench@gmail.com> wrote:

> [  228.573783]  ? show_regs+0x6d/0x80
> [  228.573787]  ? die+0x37/0xa0
> [  228.573789]  ? do_trap+0xd4/0xf0
> [  228.573793]  ? do_error_trap+0x71/0xb0
> [  228.573795]  ? iov_iter_revert+0x114/0x120
> [  228.573798]  ? exc_invalid_op+0x52/0x80
> [  228.573801]  ? iov_iter_revert+0x114/0x120
> [  228.573803]  ? asm_exc_invalid_op+0x1b/0x20
> [  228.573808]  ? iov_iter_revert+0x114/0x120
> [  228.573813]  ? smb2_readv_callback+0x50f/0x5b0 [cifs]
> [  228.573874]  cifs_demultiplex_thread+0x46e/0xe40 [cifs]

I don't suppose you can tell me what line smb2_readv_callback+0x50f/0x5b0 is?

David


