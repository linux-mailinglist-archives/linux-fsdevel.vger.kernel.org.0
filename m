Return-Path: <linux-fsdevel+bounces-13587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 045B18719BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 10:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B26B20D95
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B0E52F85;
	Tue,  5 Mar 2024 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yr3p1hnY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5384CB2E
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631644; cv=none; b=ICZhbHpVX1ZkOUYBfLdSf+QDs0IDmI88+QmWSQTe5lMrHH1o1vFMMG8iM7jX9MN2UvR6hoiDOALoPiGljih3eJW2O/4+3nZHqi9xmX8BNxfgsBcfwdEWYPNBLSTNcGJdlTRP+uvp2mpJXSovXwP9meKC1WUAsIiWCRQnOUmybmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631644; c=relaxed/simple;
	bh=oJFbRLDXN0dx2+ypR4FUd/atuzb30yq+vz3qMyPtiog=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WpzFXblXMDvzTpK6Wo5hFcJgbwqBRZGEEn2yYDCYMRBmTVi84eEOdAoA3hzOxVzCWUPQTLwCbqxSW63h64D1xCWGEYUO3vENHwYKczNjYz/B27NNmu79A8wm37cBSlbjoB/yfEfH1JIRxhqO3wBjzK3TnTRhraLB14rcbTkyefc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yr3p1hnY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709631641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lsD3iFmjG4YWgMgCa0qF0PcFuMKNa1xhP5HC+b5AB/0=;
	b=Yr3p1hnYw6tzzCLbLGspLHzdQ677HTIZ7PA4ua7t9xRddnskUC5hczlahpeeDY5H/8oKNN
	COlQCVxFAyGBPvSO7YCqLZrYW9dozeOY5TxHWhddD9K/5Ggd1fgOXm0OWfmZyTH6eiGl1c
	KVJHwcCquGSTuPChPO7pX+KAzc4FJHI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-XHy8K1uCPhmNrVAbcLFjGw-1; Tue, 05 Mar 2024 04:40:38 -0500
X-MC-Unique: XHy8K1uCPhmNrVAbcLFjGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB2D0803F52;
	Tue,  5 Mar 2024 09:34:26 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BA34E200AEA0;
	Tue,  5 Mar 2024 09:34:26 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id A238C30C1B93; Tue,  5 Mar 2024 09:34:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 9D3053FB51;
	Tue,  5 Mar 2024 10:34:26 +0100 (CET)
Date: Tue, 5 Mar 2024 10:34:26 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: Hugh Dickins <hughd@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
    Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] tmpfs: don't interrupt fallocate with EINTR
In-Reply-To: <20240305-abgas-tierzucht-1c60219b7839@brauner>
Message-ID: <84acfa88-816f-50d7-50a2-92ea7a7db42@redhat.com>
References: <ef5c3b-fcd0-db5c-8d4-eeae79e62267@redhat.com> <20240305-abgas-tierzucht-1c60219b7839@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4



On Tue, 5 Mar 2024, Christian Brauner wrote:

> On Mon, Mar 04, 2024 at 07:43:39PM +0100, Mikulas Patocka wrote:
> > 
> > Index: linux-2.6/mm/shmem.c
> > ===================================================================
> > --- linux-2.6.orig/mm/shmem.c	2024-01-18 19:18:31.000000000 +0100
> > +++ linux-2.6/mm/shmem.c	2024-03-04 19:05:25.000000000 +0100
> > @@ -3143,7 +3143,7 @@ static long shmem_fallocate(struct file
> >  		 * Good, the fallocate(2) manpage permits EINTR: we may have
> >  		 * been interrupted because we are using up too much memory.
> >  		 */
> > -		if (signal_pending(current))
> > +		if (fatal_signal_pending(current))
> 
> I think that's likely wrong and probably would cause regressions as
> there may be users relying on this?

ext4 fallocate doesn't return -EINTR. So, userspace code can't rely on it.

Mikulas


