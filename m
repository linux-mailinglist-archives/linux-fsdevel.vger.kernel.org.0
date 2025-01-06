Return-Path: <linux-fsdevel+bounces-38472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4551FA02FD5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 19:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F517A1757
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 18:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9B31DF96C;
	Mon,  6 Jan 2025 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rp97KaHl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB66D1DF960
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 18:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736188645; cv=none; b=HsOr9GYPtZU0lqLj9nDhUW8lTPJHh6kmb8wh7Ak5WxhisTbJeyy123sK+s/jQk1FdyrnEdML7MuIYWP8orKqsrhJZkjN7JlWQF6j6l85EesGWat5KaUqHjd7+YR9PhRH2zB6wFVd1Bqc0Vcz78iTvgDJYyjKaXhUFbIMf20d56o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736188645; c=relaxed/simple;
	bh=DMyNrPw9s2h7q2z1rXh5aiad8faofsuC7wxYluJNqVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RC2F99YPN1UHpVQFKS33MHsF7VVUR+OzcV46rckVG7YnJosYQdD/VndZYDFdvAIFxqF9JmkU94mO1X4W/DBX+mkHQCJpf4zYjdz8FPsR+NoP4xXSeQLhW98dZOpW4ueQk3TGWRYoXY6YjM4UpJfNslW3O0kuAChF9NMQcmY54dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rp97KaHl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736188642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DMyNrPw9s2h7q2z1rXh5aiad8faofsuC7wxYluJNqVY=;
	b=Rp97KaHlIWzCWH0rXLi5k9z1YJQt/FLX4WsSP+ZyDjKs3sG7WGHE5jUh/f0SSjC1TCaiRJ
	vW2kI5brPZGrw1MquSxRjdSz6YJD6DEhvEwagUYaUIUwbqEbYFJrEsCAqiNVmkSpFFudHE
	Wpv+tE2VYsTBxb/EFMrJ7V4/tNEqshI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-wiDTMSU3OgO1Q8VdFSmfHg-1; Mon,
 06 Jan 2025 13:37:19 -0500
X-MC-Unique: wiDTMSU3OgO1Q8VdFSmfHg-1
X-Mimecast-MFC-AGG-ID: wiDTMSU3OgO1Q8VdFSmfHg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0E21195609E;
	Mon,  6 Jan 2025 18:37:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.102])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B9626195606B;
	Mon,  6 Jan 2025 18:37:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  6 Jan 2025 19:36:51 +0100 (CET)
Date: Mon, 6 Jan 2025 19:36:47 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Manfred Spraul <manfred@colorfullife.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: wakeup_pipe_readers/writers() && pipe_poll()
Message-ID: <20250106183646.GG7233@redhat.com>
References: <20241229135737.GA3293@redhat.com>
 <20250102163320.GA17691@redhat.com>
 <CAHk-=wj9Hr4PBobc13ZEv3HvFfpiZYrWX2-t5F62TXmMJoL5ZA@mail.gmail.com>
 <20250106163038.GE7233@redhat.com>
 <CAHk-=whZwWJ4dA-r54eyEZaiVpEK+-9joKid3EyPsHVRGAgEgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whZwWJ4dA-r54eyEZaiVpEK+-9joKid3EyPsHVRGAgEgA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/06, Linus Torvalds wrote:
>
> On Mon, 6 Jan 2025 at 08:31, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > To be honest, I don't understand the wait_address check in poll_wait(),
> > it seems that wait_address is never NULL.
>
> Oh, it seems to be historical.

Yeah, please see my previous email.

I think it must die, but needs another one-liner.

> > That is what I tried to propose. Will you agree with this change?
> > We can even use smp_store_mb(), say
>
> I think it's clearer to just use smp_mb().

OK, agreed, I'll send the trivial patch once I write the changelog.

Oleg.


