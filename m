Return-Path: <linux-fsdevel+bounces-43102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46859A4DF32
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 14:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C18F177A7A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 13:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510DA2046AD;
	Tue,  4 Mar 2025 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ie+iAhx0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC7320485B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094759; cv=none; b=FJL6axuo+aq8SYiSDkAkYC+iRd66lo1P2EGqAm/rK3nzPbz/Nkvo4eRdcxfNRVUha8rBZnPi2X4ivjSMUcAdmejBOlD7bU+NC7yBElm+ZLBZKGUaAWEqrtRGmYqkwWZ6NykRcu+Ps0oAo7KapGSyLytT0wMGZoptzBjGISkuWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094759; c=relaxed/simple;
	bh=r3Nisdi5Q9Wip7NkNXSMDJXBD6dGblQGzS7tgN7/kaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTny2/kNRdaNOBxVlahNDid6GssX+z9UUnWJJK8Ut1RolCF+ztsLuOwzhZ60fsGJr8L5AgsB4AcQzaXcyc1+naXMdZ2999KC94gsoCVK63QIbsAeHt2jL4jvspqIW9d+R9mp4J7BN+XuCZE9u6WYPXuW658qt8ZfvD7LQkFbZGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ie+iAhx0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741094756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=njrHr5Zj32Q7fbjo3E1wVGJh0ApjW14vpP+FavY+KBw=;
	b=Ie+iAhx0kH3UrqbIdDkK9GoNdarX5uTdoSOXX6iKHtopsRn596etw/Q3ghYYbHw6V1KWZL
	JLL3vQlyA2mt7DUNLcO34elEg+1glnmN9s12aL2PQVHEa/i+eBBn3KVL7UmzPVmyR9ZlLM
	tEBAmu8UDBbVdgvGSPfv0zHV8jWlxhY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-UdeULCsUP--sVgQ4XEPdgw-1; Tue,
 04 Mar 2025 08:25:46 -0500
X-MC-Unique: UdeULCsUP--sVgQ4XEPdgw-1
X-Mimecast-MFC-AGG-ID: UdeULCsUP--sVgQ4XEPdgw_1741094744
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 777421800374;
	Tue,  4 Mar 2025 13:25:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.246])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A9EAD180094C;
	Tue,  4 Mar 2025 13:25:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  4 Mar 2025 14:25:14 +0100 (CET)
Date: Tue, 4 Mar 2025 14:25:08 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250304132507.GC26141@redhat.com>
References: <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com>
 <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
 <20250303202735.GD9870@redhat.com>
 <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
 <20250304125416.GA26141@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304125416.GA26141@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/04, Oleg Nesterov wrote:
>
> On 03/03, Linus Torvalds wrote:
> >
> > +/*
> > + * Really only alpha needs 32-bit fields, but
> > + * might as well do it for 64-bit architectures
> > + * since that's what we've historically done,
> > + * and it makes 'head_tail' always be a simple
> > + * 'unsigned long'.
> > + */
> > +#ifdef CONFIG_64BIT
> > +  typedef unsigned int pipe_index_t;
> > +#else
> > +  typedef unsigned short pipe_index_t;
> > +#endif
>
> I am just curious, why we can't use "unsigned short" unconditionally
> and avoid #ifdef ?
>
> Is "unsigned int" more efficient on 64-bit?

Ah, I guess I misread the comment...

So, the problem is that 64-bit alpha can't write u16 "atomically" ?

Oleg.


