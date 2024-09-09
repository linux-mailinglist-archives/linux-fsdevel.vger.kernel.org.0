Return-Path: <linux-fsdevel+bounces-28930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF127971304
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 11:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873A11F228E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 09:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91D61B2ED0;
	Mon,  9 Sep 2024 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzM0EE7J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66FF1B1502
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873075; cv=none; b=eZOYJ41VqfeBPoIlmLzAAa48AeW0MPSvDq7/aoGPYtuS404ar8tddbjFqEu95CUkRfnlXvXRu72H+H+2XO2b/mmApoNECYKKMZsexKYiljGj0zRGHgJy/QduoUDfFKQo96SISWS4Ohck6rcfFFMyLevpBR7nRRMisf+NoFtQHlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873075; c=relaxed/simple;
	bh=4ekekTypLn8Rlo2M08m1D2eZciu+3wadsyUNEaZJjU8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=E2/k6jDaZJPhx4UM++28MLSS8o3G8WlqS2uyhWohhHoZtKpA9Dn5Hs05PimQJdjC3+eoNncMHP2D+Ed4hWBKzphS+VUof2nZCWjZ7Na9uYWc53yJpdyTz7hNqBeT2w3XfNn7DT7pqbYYMLzT8pqu18uhvNftfSXcNNrO6TcIpkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzM0EE7J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725873072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9vtXlktka6Nj48pSJj/CVXF17j7ZU/bFy8NQQXgUyM0=;
	b=CzM0EE7J8xzhG+x2ll8nlfauK70PBFrK5we0GLzYEfQ8fry9Ox2yTXP3xf92SMqbN6AAtv
	Mi8oW9jMaqAkqUfFw6cnobtkGJqYphIi0oTKLAELtcGHsSu2DpqzU0bTFt6p0eIAZfbh9Q
	nSGXx98FRGsymwn3wx7410giv3urilc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-v2LRQ9qVNu6lhaIXjwxLsw-1; Mon,
 09 Sep 2024 05:11:11 -0400
X-MC-Unique: v2LRQ9qVNu6lhaIXjwxLsw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A2EC193F078;
	Mon,  9 Sep 2024 09:11:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07A651955F45;
	Mon,  9 Sep 2024 09:11:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240908192307.20733-3-dennis.lamerice@gmail.com>
References: <20240908192307.20733-3-dennis.lamerice@gmail.com>
To: Dennis Lam <dennis.lamerice@gmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, corbet@lwn.net,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs:filesystems: fix spelling and grammar mistakes on netfs library page
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <346198.1725873065.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Sep 2024 10:11:05 +0100
Message-ID: <346199.1725873065@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Dennis Lam <dennis.lamerice@gmail.com> wrote:

> - * Allow the netfs to partially fulfil a read, which will then be resub=
mitted.
> + * Allow the netfs to partially fulfill a read, which will then be resu=
bmitted.

"fulfil" is also correct:

	https://en.wiktionary.org/wiki/fulfil

> - * Handle clearing of bufferage that aren't on the server.
> + * Handle clearing of bufferages that aren't on the server.

"bufferage" wouldn't be countable and can't be pluralised, so the fix shou=
ld
be "aren't" -> "isn't" instead.

David


