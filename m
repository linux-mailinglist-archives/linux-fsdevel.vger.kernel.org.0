Return-Path: <linux-fsdevel+bounces-4568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5690C800B11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 13:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11AEA281573
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE98E2555F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gj1R3fIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB0AD48
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 03:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701431782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcOERy4n8CRS+7evS6pVyIbNEma6ZLagFwPNpYFCddY=;
	b=Gj1R3fIKU788jbf+dhY5GaTIKKx+D+krqwpeS8hprO533XRQ1L759i/zqWE3ZZy9Rb1MUv
	xsMT8RoKeYf4wMujTwwwOXJSPivK5DZ6k/9crljNVwIGQ6tCD/Lvx1kuYs/hUlOQ7KNkdU
	Aa7qQ/lJwAA3Qriz+kQWNkrRdUbohkM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-2PdFzcwlPb66x7JLoJeOig-1; Fri, 01 Dec 2023 06:56:19 -0500
X-MC-Unique: 2PdFzcwlPb66x7JLoJeOig-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8AF9811E7B;
	Fri,  1 Dec 2023 11:56:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DDC23492BFC;
	Fri,  1 Dec 2023 11:56:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20231201-orchideen-modewelt-e009de4562c6@brauner>
References: <20231201-orchideen-modewelt-e009de4562c6@brauner>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Lukas Schauer <lukas@schauer.dev>,
    linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pipe: wakeup wr_wait after setting max_usage
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3429983.1701431777.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 Dec 2023 11:56:17 +0000
Message-ID: <3429984.1701431777@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Christian Brauner <brauner@kernel.org> wrote:

> From: Lukas Schauer <lukas@schauer.dev>
> =

> Commit c73be61cede5 ("pipe: Add general notification queue support") a
> regression was introduced that would lock up resized pipes under certain
> conditions. See the reproducer in [1].
> =

> The commit resizing the pipe ring size was moved to a different
> function, doing that moved the wakeup for pipe->wr_wait before actually
> raising pipe->max_usage. If a pipe was full before the resize occured it
> would result in the wakeup never actually triggering pipe_write.
> =

> Set @max_usage and @nr_accounted before waking writers if this isn't a
> watch queue.
> =

> Fixes: c73be61cede5 ("pipe: Add general notification queue support")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D212295 [1]
> Cc: <stable@vger.kernel.org>
> [Christian Brauner <brauner@kernel.org>: rewrite to account for watch qu=
eues]
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: David Howells <dhowells@redhat.com>


