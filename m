Return-Path: <linux-fsdevel+bounces-22275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5869159FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 00:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42AB8B20E24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 22:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252721A2573;
	Mon, 24 Jun 2024 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="es3/LXg2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157591A2559
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719268854; cv=none; b=jRtcfJVFana9WbuU3gED2s2dQss+fOpx8zGAxaBxMYnLWMJl+uDJuqrryanc98G+zAqZ8k34kTf76bfhtJcMxUDddL1Ccg3WXtV2JJHKfRLAa8unU2+zpjIFpGh+jz7q2yPujJJnqdlFbNEnGQyh6T1h0Pg/ardbTOw6FhZkbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719268854; c=relaxed/simple;
	bh=gZ5KsvuOtYJvO4Wv7/pCCF+MwuC23XNnjC2DTewuZJk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ghRdn7T1DPwZ3ZeDG+NkYlWEdM8aStmbX6NQNGVF9QM8nOfygG5fp547TvS78DUfmJqhJedSFvBqUOeYmhFODRTgf3xmLhIpZKuiR+vJwpkwPg3qxIKQVOg0vMMAzWTWEOr3AMvihQNKtppeG2pCOHkpHLJy0Y4q3o313h9OYRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=es3/LXg2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719268851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uxl1z2W74gbsX4wZ/0gxAsnxfLwDVydXk+S+lJvdUno=;
	b=es3/LXg280ryqVRj3I8N6MkRkOy/fhv7ZCIFNA4FYKOIqzJZxP3jrWqmbi3Jadyu5TRs9r
	S1KRygqiEA6RDaz4LPe97J1aP9R0r+absYUJBdaaAjKrFb4qkvzNayy4WOAyyI0XwYXqpq
	kpwhNiV1MYeRWGNzebJWDjXBZP+Pa1A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-TVIlF1LsNRqMsUGuKySzHg-1; Mon,
 24 Jun 2024 18:40:45 -0400
X-MC-Unique: TVIlF1LsNRqMsUGuKySzHg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07B2119560AF;
	Mon, 24 Jun 2024 22:40:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.111])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 776231955D8D;
	Mon, 24 Jun 2024 22:40:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZnmRGyuSZKtmJVhG@casper.infradead.org>
References: <ZnmRGyuSZKtmJVhG@casper.infradead.org> <614257.1719228181@warthog.procyon.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-mm@kvack.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix netfs_page_mkwrite() to check folio->mapping is valid
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <720578.1719268838.1@warthog.procyon.org.uk>
Date: Mon, 24 Jun 2024 23:40:38 +0100
Message-ID: <720579.1719268838@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Matthew Wilcox <willy@infradead.org> wrote:

> >  	if (folio_lock_killable(folio) < 0)
> >  		goto out;
> > +	if (folio->mapping != mapping) {
> > +		ret = VM_FAULT_NOPAGE | VM_FAULT_LOCKED;
> > +		goto out;
> > +	}
> 
> Have you tested this?

I've tried to.  generic/247 can trigger it, but the race happens rarely.

> I'd expect it to throw some VM assertions.

I didn't see any.

I guess VM_FAULT_LOCKED is not universally handled by the caller and that I
should unlock the folio myself instead.

David


