Return-Path: <linux-fsdevel+bounces-38240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E329FDEE4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 14:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861A73A186F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 13:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5C8157E88;
	Sun, 29 Dec 2024 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ej/tCH5q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508B1E50B
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735477580; cv=none; b=uAWcgiCtikZPZXkwOPwNtndFPnVvMfm3kbkrn350Uf52fyYG+5NJfIZeTK7FMG0nmJxRKQNIPID/HKeQm3vjV9RMeaVl2eUFPBYBOTTf7rbXhfJ2eyBQBYiX10EZU1XXX5C+qOzTLljEby4h2+MZQbORWvEbKyr2DuqAw/IvSQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735477580; c=relaxed/simple;
	bh=nndwLLlEzkDbJN6Z1dsl++j2uv7DwO7MKRo+94+3crc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vh+4C2RXMmDZmy6PWOgqjKMoZHSFbsX/R97rcjlMPlwaW0CavyVi2v7yhJOoQOuYbYxLoPZTgKSp8vKLFWrdSaFbAAo/Jbo/dONh2qMbwhE5wcGoKOrpwDgGmSq1b6A9/EqUDbbKvq6eJ/5m4r7fYteJImSv2H8YfVySRDUAfW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ej/tCH5q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735477577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nndwLLlEzkDbJN6Z1dsl++j2uv7DwO7MKRo+94+3crc=;
	b=Ej/tCH5qs22vG28/hcznVV0sOUxkpZeqaAi9QYbHEJG6as9rW3FyM2wV8Sjg3cPatGKnZ2
	GdqnW/t0tq5vcLDSwKviqSRrhOdrr/D2gh/jki+VM8yHmJjZAVN/BF8bWyU4Z4pvAIKaZD
	Q15aKb99lXCIXuqfCTGQIax6YGJwKPQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-ZrqYA2dJOi2b6ypdbDHSQw-1; Sun,
 29 Dec 2024 08:06:14 -0500
X-MC-Unique: ZrqYA2dJOi2b6ypdbDHSQw-1
X-Mimecast-MFC-AGG-ID: ZrqYA2dJOi2b6ypdbDHSQw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5225E195608C;
	Sun, 29 Dec 2024 13:06:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.22])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B76CD19560AA;
	Sun, 29 Dec 2024 13:06:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 29 Dec 2024 14:05:47 +0100 (CET)
Date: Sun, 29 Dec 2024 14:05:43 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	WangYuli <wangyuli@uniontech.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <20241229130543.GC27491@redhat.com>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
 <20241226201158.GB11118@redhat.com>
 <1df49d97-df0e-4471-9e40-a850b758d981@colorfullife.com>
 <20241228143248.GB5302@redhat.com>
 <20241228152229.GC5302@redhat.com>
 <addb53ac-2f46-45db-83ce-c6b28e40d831@colorfullife.com>
 <20241229115741.GB27491@redhat.com>
 <ee120531-5857-4bfc-908c-8a6f1f3e7385@colorfullife.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee120531-5857-4bfc-908c-8a6f1f3e7385@colorfullife.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 12/29, Manfred Spraul wrote:
>
> >I think that your patch (and the original patch from WangYuli) has the same
> >proble with pipe_poll()->poll_wait()->__pollwait().
>
> What is the memory barrier for pipe_poll()?
>
> There is poll_wait()->__pollwait()->add_wait_queue()->spin_unlock(). thus
> only store_release.
>
> And then READ_ONCE(), i.e. no memory barrier.
>
> Thus the CPU would be free to load pipe->head and pipe->tail before adding
> the entry to the poll table.
>
> Correct?

Yes, this was my thinking.

See also my initial reply to WangYuli
https://lore.kernel.org/all/20241226160007.GA11118@redhat.com/

Do you agree?

Oleg.


