Return-Path: <linux-fsdevel+bounces-38237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CE49FDECC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 12:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685C13A1850
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 11:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6066814D6ED;
	Sun, 29 Dec 2024 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJ3sY21f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461CD76C61
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735473315; cv=none; b=OKDs+u8bAQPzG8x7kCztFYgx4Lt+R9dji4DnkhGJCnnwNvy6pr5j4ER/BYtVI1WZ7EzUT4evzGG1Xuyw42XiMTGVwvb6tCRQS+KqIHlQ/nDSHS1onBPjB9gWzRvWyU2w5+zHZyX+ceXGYydBdI6RQskgQG1XMiZqXHW7oiE/iys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735473315; c=relaxed/simple;
	bh=K/qinsJoRcgdJnsylvhYhvno4oZCbWn49qRk5zLfe8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMyOYCSJ8id1ZL1XVySu0/Ip2BZrk8eV+g1pt37qI52UiSCqOP1NPGlR7zTZ1Gg+IfAH5Mlrde/uS5VYxnPFB/ds2s6arboOSwD29uf/xttFKEFEnd5G7nZM68SS7BovX6uw8w6uOx3Ti5x0eJpqU4IrumLuy5tA+ZuzzRFR+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJ3sY21f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735473311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KOBWRo/4XUDcNFktLWNpdZoqhBqySzxhLZs8dWsn3S8=;
	b=fJ3sY21f6u7Cp8FLIPGNkf//PK3LNx8Jt4ySSaqKGXl3ew/TY6P5ZPKnYyQR5VO59xtdvb
	ZsvJmEqHjQWOJgc4LRWzbu4hWiSa+ozLLQPDiinUqrxhdZ682h9FeUcmph7M8pofTMgANq
	piXTl2P3OZuwXfTPSfAAlEwGO7baOAo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-62bwi7YbMxS3m-7p4zA2nw-1; Sun,
 29 Dec 2024 06:55:10 -0500
X-MC-Unique: 62bwi7YbMxS3m-7p4zA2nw-1
X-Mimecast-MFC-AGG-ID: 62bwi7YbMxS3m-7p4zA2nw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3A7519560AA;
	Sun, 29 Dec 2024 11:55:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 336A31956086;
	Sun, 29 Dec 2024 11:55:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 29 Dec 2024 12:54:44 +0100 (CET)
Date: Sun, 29 Dec 2024 12:54:40 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	WangYuli <wangyuli@uniontech.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <20241229115439.GA27491@redhat.com>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
 <20241226201158.GB11118@redhat.com>
 <1df49d97-df0e-4471-9e40-a850b758d981@colorfullife.com>
 <20241228143248.GB5302@redhat.com>
 <20241228152229.GC5302@redhat.com>
 <20241228163231.GA19293@redhat.com>
 <8d56b9d7-bb92-4c6e-ba8b-da3ec238943b@colorfullife.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d56b9d7-bb92-4c6e-ba8b-da3ec238943b@colorfullife.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Manfred,

Sorry, I don't understand, perhaps you misunderstood me too.

On 12/28, Manfred Spraul wrote:
>
> >Even simpler,
> >
> >	void wait(void)
> >	{
> >		DEFINE_WAIT(entry);
> >
> >		__set_current_state(XXX);
> >		add_wait_queue(WQ, entry);
> >
> >		if (!CONDITION)
> >			schedule();
> >
> >		remove_wait_queue(WQ, entry);
> >		__set_current_state(TASK_RUNNING);
> >	}
> >
> >This code is ugly but currently correct unless I am totally confused.

What I tried to say: the code above is another (simpler) example of
the currently correct (afaics) code which will be broken by your patch.

Of course, wait() assumes that

	void wake(void)
	{
		CONDITION = 1;
		wake_up(WQ);
	}

calls __wake_up_common_lock() and takes WQ->lock unconditionally, and
thus wait() doesn't need the additional barries.

> And: Your proposal is in conflict with
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/kernel/fork.c?h=v2.6.0&id=e220fdf7a39b54a758f4102bdd9d0d5706aa32a7

I proposed nothing ;) But yes sure, this code doesn't match the comment
above waitqueue_active(), and that is why the wake() paths can't check
list_empty() to avoid __wake_up_common_lock().

> But I do not see the issue, the worst possible scenario should be something like:
>
> 	// add_wait_queue
> 		spin_lock(WQ->lock);
> 		LOAD(CONDITION);	// false!
> 		list_add(entry, head);
> 		STORE(current_state)
> 		spin_unlock(WQ->lock);

Again, wake() can happen between LOAD() and list_add()...

But sorry again, I guess I completely misunderstood you...

Oleg.


