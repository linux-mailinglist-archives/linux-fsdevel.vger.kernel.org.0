Return-Path: <linux-fsdevel+bounces-17130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E248A8388
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 14:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CDD282586
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AC613D265;
	Wed, 17 Apr 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcz/NJxt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7A03D72
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358624; cv=none; b=OSA+pc+PDwTjwAWqc9g9mEh1YQBfftGlPrYni8qo/ryZ67COO4pvbicBWvp9QwzhAKYy2LqEZIZ7w9h7lPXh6pdM+MtUrZCHQ5vGkj0jJ45zOtwst+7HLe/BEhUmBeaJ6DcHxj+8HQFzcMgiKTlf1AA6BXLlNFbbFoAUp549CTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358624; c=relaxed/simple;
	bh=0KqwVkUJ+i/UOU9NhJubI/pH0Y+Yaqu0/Os+YXVbOEw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=olHe0hIPPJlIn+ZWre7vdvdgOjKk5n/AGt6qutSEicx5kNuuXwi07XPlU7FbemraxpDCEo6awv25DSpmeKB58RkT13SsSSiCxddtiXa69DCzQ+dOjXKpuyUq5rduZHYMb3UWI07rztGgkRZO1grdWi8Jtc1kHXAGUJD8feT8yGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hcz/NJxt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713358621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5e3vCaPqQdY5LIxc1pB4ISWhqI1L7muAHirVH+nUkhc=;
	b=hcz/NJxtkNhPI7OCZTTruuiVGN9OnXX9EOLg+7UmaIbPj2Wk6au0s40WDrZ7ltuOcF3QXC
	cF/hMGP6kzc9NDQ9VX8hAm9yxhC+ypVAM7Q4t/3BrVPvbpXTnIVOsCMMt8f6ltQigd6ZFn
	dSSFhGAsOCxDvNFyZo8I481puO1iT6Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-GSyWKDcPOKGpq32iWKZHHA-1; Wed, 17 Apr 2024 08:57:00 -0400
X-MC-Unique: GSyWKDcPOKGpq32iWKZHHA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4107A104B501;
	Wed, 17 Apr 2024 12:57:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 74EA151EF;
	Wed, 17 Apr 2024 12:56:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Zh7g5ws68IkJ1vo3@casper.infradead.org>
References: <Zh7g5ws68IkJ1vo3@casper.infradead.org> <20240416180414.GA2100066@perftesting>
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Josef Bacik <josef@toxicpanda.com>,
    linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
    kernel-team@fb.com
Subject: Re: [LSF/MM/BPF TOPIC] Changing how we do file system maintenance
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <186153.1713358614.1@warthog.procyon.org.uk>
Date: Wed, 17 Apr 2024 13:56:54 +0100
Message-ID: <186154.1713358614@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Apr 16, 2024 at 02:04:14PM -0400, Josef Bacik wrote:
> > I would like to propose we organize ourselves more akin to the other
> > large subsystems.  We are one of the few where everybody sends their
> > own PR to Linus, so oftentimes the first time we're testing eachothers
> > code is when we all rebase our respective trees onto -rc1.  I think
> > we could benefit from getting more organized amongst ourselves, having
> > a single tree we all flow into, and then have that tree flow into Linus.
> 
> This sounds like a great idea to me.  As someone who does a lot of
> changes that touch a lot of filesystems, I'd benefit from this model.
> It's very frustrating to be told "Oh, submit patches against tree X
> which isn't included in linux-next".
> 
> A potential downside is that it increases the risk of an ntfs3 style
> disaster where the code is essentially dumped on all other fs maintainers.
> But I like the idea of a maintainer group which allows people to slide
> in and out of the "patch pumpkin" role.  Particularly if it lets more
> junior developers take a turn at wrangling patches.

Would it make sense to have an MM + FS tree, given that a lot of MM changes
affect filesystems too?  Or, at least, a common branch between the MM and FS
trees for things that affect both?

David


