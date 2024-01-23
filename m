Return-Path: <linux-fsdevel+bounces-8626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73725839C96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 23:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42871C232BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 22:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD9B53E14;
	Tue, 23 Jan 2024 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcedpcst"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EB16AAB
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 22:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706050699; cv=none; b=XtfuU9jODWM0yTA1ExK2xojxtPLjRkVGADwZaFjqp7MrR8uM+u0C7DgXbGi+tKSztj3FTUwqIagf5g0lz1xBCl91nq+dtpipPbWs/NCHK5asOlh5+amlMCyozYuRW1K8VsvBupJBaW/mWen/+ao/D1qnP1t2Mi9OR/2qiKIcRCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706050699; c=relaxed/simple;
	bh=aeu0CBrnI66FBjVIijl0UIIQ/FNbTLbEiEDD43Xo/DI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=coePnrhnA01kRreeBOv7qUbfZw/fZYz8BDQnhFSA9za+pUkrdbyzPeuuYOpkSSh9bHr82cf+54arxbVMqczDaYSk0WdwNmQMgZNNcWkRsAh9WnTkOR6RlkS4xE0DGepvkqTWeEYiiQ/H5kzAg93EHkVJKUxTfyfpS2rzePg/KUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcedpcst; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706050696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jd2j+Hh/adVXKWtD56ozVK03qkc7HXVuVZfnpcpzJ70=;
	b=gcedpcstjARP3F5NLnKbroSO5xUXvWpYXy9nLj/HOJkMz3czQHvlnvIQ82SsuYLsjm1HsW
	Wj4r+cZo47humMcLQ9kClic2WDNKHl1cZGzrnjZ74/bi+ofgOoZLNMSjbUnjxhxUXWr71L
	hcVECI+i/0hFZ6RJO5VoaWklgwQTu1Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-QTtnJHMXO_WT4W_8REmvaA-1; Tue,
 23 Jan 2024 17:58:12 -0500
X-MC-Unique: QTtnJHMXO_WT4W_8REmvaA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFDB03C0FC83;
	Tue, 23 Jan 2024 22:58:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BEB1D492BC6;
	Tue, 23 Jan 2024 22:58:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZbAO8REoMbxWjozR@casper.infradead.org>
References: <ZbAO8REoMbxWjozR@casper.infradead.org> <wjtuw2m3ojn7m6gx2ozyqtvlsetzwxv5hdhg2hocal3gyou3ue@34e37oox4d5m>
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Kent Overstreet <kent.overstreet@linux.dev>,
    lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
    rust-for-linux@vger.kernel.org,
    Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
    Alice Ryhl <aliceryhl@google.com>,
    Wedson Almeida Filho <wedsonaf@gmail.com>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Kees Cook <keescook@chromium.org>, Gary Guo <gary@garyguo.net>,
    Dave Chinner <dchinner@redhat.com>,
    Ariel Miculas <amiculas@cisco.com>,
    Paul McKenney <paulmck@kernel.org>
Subject: Re: [LSF/MM TOPIC] Rust
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <201189.1706050689.1@warthog.procyon.org.uk>
Date: Tue, 23 Jan 2024 22:58:09 +0000
Message-ID: <201190.1706050689@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Matthew Wilcox <willy@infradead.org> wrote:

> I really want this to happen.  It's taken 50 years, but we finally have
> a programming language that can replace C for writing kernels.

I really don't want this to happen.  Whilst I have sympathy with the idea that
C can be replaced with something better - Rust isn't it.  The syntax is awful.
It's like they looked at perl and thought they could beat it at inventing
weird and obfuscated bits of operator syntax.  Can't they replace the syntax
with something a lot more C-like[*]?

But quite apart from that, mass-converting the kernel to Rust is pretty much
inevitably going introduce a whole bunch of new bugs.

David

[*] That said, we do rather torture the C-preprocessor more than we should
have to if the C language was more flexible.  Some of that could be alleviated
by moving to C++ and using some of the extra features available there.  That
would be an easier path than rusting the kernel.


