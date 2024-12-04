Return-Path: <linux-fsdevel+bounces-36460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1289F9E3C08
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB415285E7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8CC1F756F;
	Wed,  4 Dec 2024 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqat/6my"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3CA1F7063
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321020; cv=none; b=rCb1cG2/iEzul++KIg78TrlBXWJx86ddNVZ2M63AsPN91l+3u2YS+iVluyBtwgpRoSkc0cCpPUxInMbUDFrjAVzCcW5Rz9ydVdScKjcV3pIsKQTHSGlWA3Rkodw/U3CDEWrK0OC4XiekZk+yY/mHPdmyGb9bf+B4QkLzCNV7Kws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321020; c=relaxed/simple;
	bh=CEyhXB58ikymmdM/y6z0AsNHZOEwEN+DujGpcFYpGX0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=PIxvVlmgjDf7UR2k+TU3g/lQIYq4hy0TsSgdlDLQZkcFfOqlh2A1uZYMbkBeLT1Hbo/nJwPLbk/VPUu/KLBX9cHgbkoVfC+2ml5lFo6VnXo0LMlKCpMOhyQ7mK9lZfBFq2AMMlUNkdk+Ola0xE3Fsd3UVrXlZHDmdbzGSHNPktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqat/6my; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733321017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6pZC2krQjMelPf8ePl2xBPfxGOXxCw41Ox8U+g4AGa4=;
	b=bqat/6myNuEXztSFrpnF4j3qhG5ayW/o2TNa+TUSCjIXoS9wZWDrZJf4iyEMuOzewxAiBk
	RuKTsCOn5gSLBihivvyGe5SGhqN3xoo+IFY/uGQ24azEED/xWxzs5LL2fc+4voKjaAp7QG
	SkNhNcGQGKLg78WA9uo8boQsV8nzUec=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-KMoRKdqcPmKWSDBYb9kDUQ-1; Wed,
 04 Dec 2024 09:03:34 -0500
X-MC-Unique: KMoRKdqcPmKWSDBYb9kDUQ-1
X-Mimecast-MFC-AGG-ID: KMoRKdqcPmKWSDBYb9kDUQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C4281955BF9;
	Wed,  4 Dec 2024 14:03:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C69983000197;
	Wed,  4 Dec 2024 14:03:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241202093943.227786-1-dmantipov@yandex.ru>
References: <20241202093943.227786-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, lvc-project@linuxtesting.org,
    syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] netfs: fix kernel BUG in iov_iter_revert()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1128189.1733320983.1@warthog.procyon.org.uk>
Date: Wed, 04 Dec 2024 14:03:03 +0000
Message-ID: <1128190.1733320983@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Dmitry,

> So wrap 'netfs_prepare_read_iterator()' to handle all possible
> -ENOMEM cases and mark the corresponding subrequest as cancelled.

I think there's a slightly better way to do it.  There are three users of
netfs_prepare_read_iterator() but there's also the call to ->prepare_read()
which I think can all be combined.

(And I've just realised that the patch I asked syzbot to test has a bug in it)

David


