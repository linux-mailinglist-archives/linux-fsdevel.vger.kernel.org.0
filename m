Return-Path: <linux-fsdevel+bounces-3203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E6D7F153A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 15:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A499D1F24C4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9141BDEB;
	Mon, 20 Nov 2023 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ny5Mo9sJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DE9114
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 06:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700489064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXOjz0ifmGOciYLPWvEqDuqbvUzPaElYmDcPCwYGBB8=;
	b=Ny5Mo9sJiV8xEcK82+uipRZCHKlsyknCkl9nRWNd3T4VF2jeasppQf/MgRdzFqgwcZPB2Z
	9HTMeYmdzneT1T83pBwizhmKXqFoxx8wKKmPoU79zW7QUJbjkIfVBNmnPWovJWktta0P43
	L25vRfJ5mI0LHfsX5QOWtQk01DTmN+Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-u4zxrFwiNz2hIKUxejFxSw-1; Mon,
 20 Nov 2023 09:04:19 -0500
X-MC-Unique: u4zxrFwiNz2hIKUxejFxSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFF793C100A6;
	Mon, 20 Nov 2023 14:04:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BEF75C1596F;
	Mon, 20 Nov 2023 14:04:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <c1616e06b5248013cbbb1881bb4fef85a7a69ccb.1700257019.git.osandov@fb.com>
References: <c1616e06b5248013cbbb1881bb4fef85a7a69ccb.1700257019.git.osandov@fb.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    Al Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>, kernel-team@fb.com,
    linux-mm@kvack.org
Subject: Re: [PATCH] iov_iter: fix copy_page_to_iter_nofault()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2285535.1700489047.1@warthog.procyon.org.uk>
Date: Mon, 20 Nov 2023 14:04:07 +0000
Message-ID: <2285536.1700489047@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Omar Sandoval <osandov@osandov.com> wrote:

> From: Omar Sandoval <osandov@fb.com>
> 
> The recent conversion to inline functions made two mistakes:
> 
> 1. It tries to copy the full amount requested (bytes), not just what's
>    available in the kmap'd page (n).
> 2. It's not applying the offset in the first page.
> 
> Note that copy_page_to_iter_nofault() is only used by /proc/kcore. This
> was detected by drgn's test suite.
> 
> Fixes: f1982740f5e7 ("iov_iter: Convert iterate*() to inline funcs")
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Acked-by: David Howells <dhowells@redhat.com>


