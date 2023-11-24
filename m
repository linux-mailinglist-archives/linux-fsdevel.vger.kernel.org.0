Return-Path: <linux-fsdevel+bounces-3684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F507F7858
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7ECB213F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 15:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA8431759;
	Fri, 24 Nov 2023 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMwF5Kzh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1371B5
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 07:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700841233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p6KID36QJgaLKX8qd4kBeMGTdnpd7Zl3i2+K28yL5TI=;
	b=WMwF5KzhpLkfJL7eKT7swOGLnYMjWRdBBMmUOh6ygRWwtNRbjEI8G+36M/AlT6XNu0U59Q
	pKH9tMpRxDmvrKZ4N89MR1MulWS2xozUU8S3+aZcebJ1X6LGPVbb02RNd3p9rsF2iByoDp
	a5XAj6TcqXlz593IFLKHNpROqVPH6ew=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-16V90mzhNPKi9sxTe4Uqvw-1; Fri, 24 Nov 2023 10:53:50 -0500
X-MC-Unique: 16V90mzhNPKi9sxTe4Uqvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4E6A821938;
	Fri, 24 Nov 2023 15:53:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 85D5340C6EBB;
	Fri, 24 Nov 2023 15:53:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20231124150822.2121798-1-jannh@google.com>
References: <20231124150822.2121798-1-jannh@google.com>
To: Jann Horn <jannh@google.com>
Cc: dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs/pipe: Fix lockdep false-positive in watchqueue pipe_write()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1210482.1700841227.1@warthog.procyon.org.uk>
Date: Fri, 24 Nov 2023 15:53:47 +0000
Message-ID: <1210483.1700841227@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Jann Horn <jannh@google.com> wrote:

> +	/*
> +	 * Reject writing to watch queue pipes before the point where we lock
> +	 * the pipe.
> +	 * Otherwise, lockdep would be unhappy if the caller already has another
> +	 * pipe locked.
> +	 * If we had to support locking a normal pipe and a notification pipe at
> +	 * the same time, we could set up lockdep annotations for that, but
> +	 * since we don't actually need that, it's simpler to just bail here.
> +	 */
> +	if (pipe_has_watch_queue(pipe))
> +		return -EXDEV;
> +

Linus wanted it to be possible for the user to write to a notificaiton pipe.

David


