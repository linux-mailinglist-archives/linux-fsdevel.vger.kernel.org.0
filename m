Return-Path: <linux-fsdevel+bounces-38241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AB39FDEE8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 14:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF276161265
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 13:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44E1158D8B;
	Sun, 29 Dec 2024 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bB78sjHD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F2C45C18
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735478053; cv=none; b=coH0uqmlmVWD1bOrXE2vaJCnmoK2c4mEjDBO6JcBpspRjMK1dbh+rugPdRoz+6cVu/YH4YQgsdS+akxs5BhiAh1n1bb0qIUuI2GJopN0Bf0Djs7SZspyOcjPHs88rFjJfu1igDelaPAVlrEOMbU9eRIv4xq78nSQen5DPaKVNsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735478053; c=relaxed/simple;
	bh=aPyufRnwNBHqezWtme7xCZ714gWP3VpT/ks8zqr4Td0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uM45NExwIuAVdy4EUgBTm1OmvLNNqBv3Tmko54MqRmxKYoiX6vsuokwXmRn1w+ixroQQk7dNP04XBz8p0D3u5U/YDDdKC5OWpkJQX6jfK9TSKLziuaBx15Fuib7Nc1fOvfm368gXGWg/Dv21JTmL4aJoiPJufFPlyYiFXKzZSM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bB78sjHD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735478050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aPyufRnwNBHqezWtme7xCZ714gWP3VpT/ks8zqr4Td0=;
	b=bB78sjHDJPBByI2nPZhVXveL8QefCds4NGLI279SRgWOSIvMiu/1nOf3TAPZwuOSH1W0MY
	BYp9fhB4L9yTVZpIzgtHvQDcri5uXKDv2eQF91zn1oXe0mNXqtPQ3NKiw8pkOHj5/IG6HX
	w5cNXbWKHAPTDX1dfgjcAoOvyj92Pkc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-TBCig1XZOqWSL0oeoNRntA-1; Sun,
 29 Dec 2024 08:14:08 -0500
X-MC-Unique: TBCig1XZOqWSL0oeoNRntA-1
X-Mimecast-MFC-AGG-ID: TBCig1XZOqWSL0oeoNRntA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1090919560A2;
	Sun, 29 Dec 2024 13:14:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.22])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5C22519560AA;
	Sun, 29 Dec 2024 13:14:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 29 Dec 2024 14:13:42 +0100 (CET)
Date: Sun, 29 Dec 2024 14:13:38 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	WangYuli <wangyuli@uniontech.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <20241229131338.GD27491@redhat.com>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
 <20241226201158.GB11118@redhat.com>
 <1df49d97-df0e-4471-9e40-a850b758d981@colorfullife.com>
 <20241228143248.GB5302@redhat.com>
 <20241228152229.GC5302@redhat.com>
 <addb53ac-2f46-45db-83ce-c6b28e40d831@colorfullife.com>
 <20241229115741.GB27491@redhat.com>
 <ee120531-5857-4bfc-908c-8a6f1f3e7385@colorfullife.com>
 <20241229130543.GC27491@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241229130543.GC27491@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Sorry for the noise...

and currently this is fine. But if we want to add the wq_has_sleeper()
checks into fs/pipe.c then pipe_poll() needs smp_mb() after it calls
poll_wait().

Agreed?

On 12/29, Oleg Nesterov wrote:
>
> On 12/29, Manfred Spraul wrote:
> >
> > >I think that your patch (and the original patch from WangYuli) has the same
> > >proble with pipe_poll()->poll_wait()->__pollwait().
> >
> > What is the memory barrier for pipe_poll()?
> >
> > There is poll_wait()->__pollwait()->add_wait_queue()->spin_unlock(). thus
> > only store_release.
> >
> > And then READ_ONCE(), i.e. no memory barrier.
> >
> > Thus the CPU would be free to load pipe->head and pipe->tail before adding
> > the entry to the poll table.
> >
> > Correct?
>
> Yes, this was my thinking.
>
> See also my initial reply to WangYuli
> https://lore.kernel.org/all/20241226160007.GA11118@redhat.com/
>
> Do you agree?
>
> Oleg.


