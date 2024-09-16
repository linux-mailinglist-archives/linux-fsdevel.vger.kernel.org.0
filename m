Return-Path: <linux-fsdevel+bounces-29510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 441BA97A566
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 17:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E45AFB23ED3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 15:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B14E158853;
	Mon, 16 Sep 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXmMqIsG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B34D1BC41
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500821; cv=none; b=bmSoS9QTnVJHakyd/2xPgUbfpLjDBV/h+nQtNDnPO89+ZnSytXZQCHJArJVjPvlK2uqlMUqefjhBZ+AOBAUgHkwEsUGFIUUQXyG0GSUHpEZ3sXU58t8s2PEWoovM/9UptQB7bMg6VCcsTEvy8Zx1UzwRtYV68qw7TH+97e6ApSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500821; c=relaxed/simple;
	bh=wp6YBN26xDilAAxfhdKpbgwokQEihlbQRJcmqMUthcc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Od2SymaMBzDjXPJCo55m4fzX2loek4UDFgaC1+XXzDIP8F7xxdcbVvVvKD3PqYd9I3SBqJsSkC4kjWymmCfgHbQU7v9yBkohXcEuPRqzEMJiQQKVdQccOWoptJdTqDNf9g8Cj2bKFLsdxjqKruxrOe+slklkwHF41zW8W8nnV1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XXmMqIsG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726500818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yz2fu+PylpvYN8AobfZy+iSas4bVuJNB5TCNqmOKTeE=;
	b=XXmMqIsGSPA5Vyy2xpTuFGg72HZFLoTGRJtFbUEn/ppdVK9zuVfJ+XtBVmSvnUvpMqBeuK
	P7YN1KR8fY70gK5Ej9B9/waRPaosCalxWXECgmwO6i+UY8P2HYjAEuq4vaRBd/jR9S1tZv
	B10c28+qlYXNtmK0Ghy/P6x0wPtoNxQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-46DGQVv8O5mTVp9nAyHmjg-1; Mon,
 16 Sep 2024 11:33:35 -0400
X-MC-Unique: 46DGQVv8O5mTVp9nAyHmjg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11A5019560BF;
	Mon, 16 Sep 2024 15:33:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 56B7E19560A3;
	Mon, 16 Sep 2024 15:33:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wiVC5Cgyz6QKXFu6fTaA6h4CjexDR-OV9kL6Vo5x9v8=A@mail.gmail.com>
References: <CAHk-=wiVC5Cgyz6QKXFu6fTaA6h4CjexDR-OV9kL6Vo5x9v8=A@mail.gmail.com> <20240913-vfs-netfs-39ef6f974061@brauner> <CAHk-=wjr8fxk20-wx=63mZruW1LTvBvAKya1GQ1EhyzXb-okMA@mail.gmail.com> <1947793.1726494616@warthog.procyon.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH] cifs: Fix cifs readv callback merge resolution issue
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2003345.1726500810.1@warthog.procyon.org.uk>
Date: Mon, 16 Sep 2024 16:33:30 +0100
Message-ID: <2003346.1726500810@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> Could we please just remove that whole 'was_async' case entirely, and
> just make the cres->ops->read() path just do a workqueue (which seems
> to be what the true case does anyway)?
> 
> So then the netfs_read_subreq_terminated() wouldn't need to take that
> pointless argument, with the only case of async use just fixing
> itself? Wouldn't that be cleaner?

It's probably a good idea, but there's also erofs, which also goes through
cachefiles_read() with it's own async callback which complicates things a
little.

David


