Return-Path: <linux-fsdevel+bounces-78953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFgcFHjdpWkvHgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 19:56:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D871DE833
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 19:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2551309875C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 18:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9054368293;
	Mon,  2 Mar 2026 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvCWi9k+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC7533F36B
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772477717; cv=none; b=obepyBBF4rVATUbDX6y0s0ORdkIoP9W4GCT+K4JBQY4/O96hMvGq0EPW7F97MgvThNcRRFNJ4uO/PdKcngsljS9iYA10oviiBLTZqchPhMeUzlQCsQ+wcbZrU8i1KljFxI0fIQ08zAz40XUnT8e4p/qBPJuqZqSP9DD71uHd670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772477717; c=relaxed/simple;
	bh=6CWcjg4sVeYB4RPm3k+7MYd79lL+Kt3ozxhbCjBaI2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WP2jSF7Wa+x+uvUsGmtcafxRJqnprCNjqtyZhsPWw+EviFbJtclQsTlqHi0zbBrzszK88aN+M6zEqWSJZTqe2d9ASuBornCiFUauqnM/4b0rXCMz6BVKKvNZo/yvvrVR8KT779+dr4HTgm0e7IlSGLZT6F/A6XPkC7jwLuMEQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvCWi9k+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48371119eacso60236655e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 10:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772477714; x=1773082514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRlJolTcfRvzUSQHPs3dCXFlQx1DAFYYMFjz2DuLSf4=;
        b=UvCWi9k+QnpLrY5/dA3CMsPNlt7ii5K2NB+3bP7iE3Vh5skznbDG8WWxKzkZYtETx+
         D26PdOdXT9NI+Zp1pATJDM5V/01+tm9EC7Ts/Sh2kI6B2cFhIF3wHFLRYkpAEYC75ZXB
         QUgUai8zcJbN+c/sKzmGxemMRYCVECpUCYNnVmqon/MwGgzEUqOQU0CyfulfQdX1zauU
         YDoZ5EMcuax1AmJi7th9YsNGUSt9OFMj52/2uw17em8ZEzpz4a7w+dIiajfiZYVpgdHy
         i247OgWwQ2pQ/BPibQVZ7HkXWy2/Xvpob6a7c/kG40NAYIqbdkbnJdr5pWlgSx8TBFgH
         v2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772477714; x=1773082514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRlJolTcfRvzUSQHPs3dCXFlQx1DAFYYMFjz2DuLSf4=;
        b=p7P5iwfvBw9SWyTJMh/xQPIHIuIHOWvKCWAHNsprjaSgPi9GJP0JikJn2tc9Pb6uMA
         vlv6j407Jv7toiS/M6li740Sa4L4ZDG+afFEBksGaPVQf32355eoxlD0ndMq2MOrP3jS
         uxhuNFCZtnCW4BeeIha1peXHJm0kK3Oau6vGSJy9/RGLx2LJYhzd2SLG6pp1d3YY9geS
         QyrrVRBvTIukX32FuLbtctnoqqkHJ4z5bRmDZ6HLXt+lSGCNkKuule04DfFEqb3cAzNZ
         p++Y7FvsuwbBKJ06jufkoFv3Eao86MIPeReF7uSd4nUAPJJek/YZXrLL01a1HJGd+/5X
         sFIw==
X-Forwarded-Encrypted: i=1; AJvYcCXi8v+2DxNa60DTJE1/YhmGrMB8rZF0jTapZuzc1BIWlp8BhZ0eav+HvaCHADh31k/sOFfx6dGRVYqeQX4N@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ9j5RpLoJiClO1Sij3hsNN5kRD1/67jfnBdUBxknTlv2vxcww
	2KslXpCMdwo1/w56/t1YGltFWn6S4MNr3lMQfqJFp0/Ji+gWu9d1DE9V
X-Gm-Gg: ATEYQzyFyiC8zKRqsw0D5gS9oWxELfZcEy4Snwk5Ehctpwrjmhw760gWHyrM2tNW/HK
	UkzokQHaMZy8ZOiAjS25uJjDKlupQAV+68VWZ2WbxUSxj53UtlY8NK5l1BlJXa+KdEivpitIITv
	9pMWWAZNg82HOW8GJd9ImcQX1bk4Aua5ohe41lMcZCzuFwqMdqjHf+l/O1CAKAuE1jhNK/zd+uS
	oZU2hy9hlWlGfXg3LAOXmYaTK81LJ2bMnTjbVgFNoeIZYKQ52+JYBH+l0FNm7s57JazfHr1yxdj
	GABpSLzP5RGTrhcZoh7Boto0aAznWbsHvRophU9FsueLkLR9cuMlmiElNr9hb6s30UrVGTCjckj
	wZ1c2gLSwU387O+8Ww9/ucVMTaWTAnJZHbC2u0WIzVJyKQeH6rLceTM42dsxJi7nOhaS2jpKn2K
	i0g2fBsd5kTkhOLgIRrQ==
X-Received: by 2002:a05:600c:350d:b0:483:a8e9:201b with SMTP id 5b1f17b1804b1-483c9b81265mr267465545e9.0.1772477712531;
        Mon, 02 Mar 2026 10:55:12 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b89c99sm299471225e9.15.2026.03.02.10.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 10:55:12 -0800 (PST)
Date: Mon, 2 Mar 2026 18:55:10 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Andre Almeida <andrealmeid@igalia.com>, Andrew
 Cooper <andrew.cooper3@citrix.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Heiko Carstens
 <hca@linux.ibm.com>, Jan Kara <jack@suse.cz>, Julia Lawall
 <Julia.Lawall@inria.fr>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Nicolas Palix
 <nicolas.palix@imag.fr>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Russell King
 <linux@armlinux.org.uk>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, x86@kernel.org, Kees Cook <kees@kernel.org>,
 akpm@linux-foundation.org
Subject: Re: [PATCH v2 1/5] uaccess: Fix scoped_user_read_access() for
 'pointer to const'
Message-ID: <20260302185510.6b49a025@pumpkin>
In-Reply-To: <CAHk-=wjKWi=j_xcMBAi2Hkuut6aNeqXTwOFoMGkHfDA+3WXsgg@mail.gmail.com>
References: <20260302132755.1475451-1-david.laight.linux@gmail.com>
	<20260302132755.1475451-2-david.laight.linux@gmail.com>
	<e8a688b3-97e1-4523-9a82-8d9dd16e3d90@kernel.org>
	<CAHk-=wjKWi=j_xcMBAi2Hkuut6aNeqXTwOFoMGkHfDA+3WXsgg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D9D871DE833
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78953-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,igalia.com,citrix.com,linux.ibm.com,csgroup.eu,infradead.org,stgolabs.net,suse.cz,inria.fr,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,efficios.com,ellerman.id.au,gmail.com,imag.fr,dabbelt.com,armlinux.org.uk,linutronix.de,linux-foundation.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 09:26:31 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 2 Mar 2026 at 06:59, Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
> >
> > Can we get this fix merged in 7.0-rc3 so that we can start building 7.1
> > on top of it ?  
> 
> Applied this first patch. I'm not so convinced about the others in the
> series, although people can always try to argue for them..

Patches 2 and 3 seemed a reasonable idea to me.
Removes a lot of code that is only there to make the whole thing work.
The 'with' is a bit of a take on Pascal - but without the 'making the
code completely unreadable' side effect.

I don't do WARN=1 builds, never mind WARN=2 :-)
Although -Wshadow can find real bugs - so I would turn it on and
suffer the annoyances. 

Patch 5 was just what I was experimenting with.
Doing the equivalent change to the non-compat version (IIRC it
uses the (likely) much slower copy_to/from_user() because the
structures match) might even be more sensible.

	David


> 
>               Linus


