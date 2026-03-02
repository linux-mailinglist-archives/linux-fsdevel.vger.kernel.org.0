Return-Path: <linux-fsdevel+bounces-78944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFXEKnHHpWnEFgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 18:22:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E52AF1DDBE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 18:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF8E33063D55
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 17:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF77421A0E;
	Mon,  2 Mar 2026 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ONWU5f4e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CBD296BBC
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471889; cv=none; b=SmIo+j8KZroXmxA0LTBk2do+CEHCRbyGTp3qyNgxXkq/6ork4Vo0BdTIxVQA0HlaSYd7d4rgwdG5D7vRku/9PNIJq7cAAc1hMQDBvXeG3Y7nnfO796BXpwhegBJcl5j4NFMMJb709Kgq600J7IPmazxRm/I9YwIkl7TIH/xi0Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471889; c=relaxed/simple;
	bh=bHDpiT/DMBChb2eg6esWRxtOQQQsukrENMa/lbFayFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLampw8BA4wgFuHWHURt9gD5hxFSIaOebU0v7jx95xCvym+iJIMLBRjE41U+yqb/WJPszqhB8fhxe6xsp4vlGwx8+Hbx/FUCuSMim8KKHY8ahbROEAQ27FxQ6YPK/tBQ9QlLnyoAnt6qilvj1OKmPuIRiAE2/K5VT02EvNT+pAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ONWU5f4e; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8f992167dcso487584466b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 09:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1772471886; x=1773076686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TbIkpYLS9gbJFch6OaF8nYKkHDJKdsVHvQjZGTHSn/8=;
        b=ONWU5f4e85G4QbtZLDlvfhCkDCvuqPD/iWB/QiK1Z+ADGvir8TkfblktI7LaSjuEey
         sxppX1LltLFdd4ttxu3EJKB1fnSw7oaxlIdyf+7XVJApFR0LGUFG3TsnOzKDOCeYWTOP
         40qMTJvde9QFA4BrjAcxx5aCBf0b/gBVlVzb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772471886; x=1773076686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbIkpYLS9gbJFch6OaF8nYKkHDJKdsVHvQjZGTHSn/8=;
        b=EB1D9ypJgPzyy8LI0JUGMtbv77C3tmIfZovVFcij1PgZNKK/Nk4OBVAP2SmMh4LP46
         Hw5RiUugmJGl8MlrvPRjOZDz0hRzwWFTTl8fMFCP8qk7giS0mWnsDb0Db8GXgwCnbMqG
         MZI/6NhWbV77I+4WgFt5xeMlwmuRXbu0QR2YEfsEhz/EPWefKgk2/idd2LRz3elEmid4
         R928eX/5CoOcrOgRDmNzayKGKurgqOn4o/m0X+Xi6p+HUNEcRSdy1dgKQ17Tk9zWxTFo
         y1xY+0lhjlLazs1gb4yu6dQHFaYHx8zCdSpDgKYFxA+2kjlO+yQ5bD+ijX9qDQue+C+0
         xCpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7gJzh++UtQ++SCbYjffLQRZcd6ISWFlGUsxudOthlqAolYvx+0eHXx9e7uyqKR4vq9WYUl/R9MytmDTzC@vger.kernel.org
X-Gm-Message-State: AOJu0YzJI3qufCI5vcsz3zGpEdgvSPlUjfWMGthfRishSmR11GFX4HI+
	u2EWKM/Tra+cn7MX2oQPwfadhWUpt0HsnFsFTfk5ZCKPX0ZF2bM0CF67WMq8x5S7ZqYQqqydE8r
	RDGkmgrTHww==
X-Gm-Gg: ATEYQzxlJYcZAn2v/W4LKeo6NgUNtJC5AU8wesOXulcnkBuyPvSUvmN4V9qjtFJAcBD
	eMOqg7omekSJqyyZuyzHBaPvDi+CLXbRtPJCb6a4MNePd/mNLxZCNywDE56cRcWvJQONa/lf400
	TunGzG0AvfP4Y3iSPQTZhcY3VTKpAD5OsbtK8NIUVLBmxlgc4rn8Oy5llSoZhzQZmma64H7CYBo
	WhXtZ4vc4jBcHUINjWOMWpVh3e9bQszgdJ/X1emPqUwh5TYORxa1Npf3bIj3Yw2QZ3CeQoUE406
	5bDxGibRSlIA4WVw5ntyC0+zU8YOSIAVTUVsOpQqjVGr5SFsb8UTTNAi90JscfFSR3JvU0pLOpC
	UXmQzow4gSPJIBRZwSWh+xctBGWjlhq9u0sYKEsTfxD01En8iw8EBIKjDZ895vUrOS0ZFmNtIFY
	DedzDhEmzYKBgJiS4gvxR4gEniisLc+KkCFNd9VyKd9xUaqRvjN9apu71kj/mHcJ8ErxTIUQEAD
	nVRT38NYtE=
X-Received: by 2002:a17:907:97c6:b0:b72:58b6:b263 with SMTP id a640c23a62f3a-b93765c7e06mr831030366b.60.1772471885811;
        Mon, 02 Mar 2026 09:18:05 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac73d2asm484242666b.26.2026.03.02.09.18.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 09:18:05 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65f73225f45so7502561a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 09:18:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkQlW8jjmRLTjaxRAVcS4SYJ2UJy09/RmsNxkxyc0fpLn523CDdEvoBKqGmlUzPKr8xT5RE1D7A8kF3RU1@vger.kernel.org
X-Received: by 2002:a17:907:25c2:b0:b8e:7dcb:7f1b with SMTP id
 a640c23a62f3a-b93763af8f8mr867609766b.21.1772471885098; Mon, 02 Mar 2026
 09:18:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302132755.1475451-1-david.laight.linux@gmail.com> <20260302132755.1475451-5-david.laight.linux@gmail.com>
In-Reply-To: <20260302132755.1475451-5-david.laight.linux@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Mar 2026 09:17:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=whaR_ujJvWGTe_fZxg_d2YSORZWnXwHLa5Gao+x136pYA@mail.gmail.com>
X-Gm-Features: AaiRm52ly83FU0bUfVtu2Rv39h3JOZJTzcdxMzg3AYFviKySZcFGK5yhPqg6aWc
Message-ID: <CAHk-=whaR_ujJvWGTe_fZxg_d2YSORZWnXwHLa5Gao+x136pYA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] uaccess: Disable -Wshadow in __scoped_user_access()
To: david.laight.linux@gmail.com
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andre Almeida <andrealmeid@igalia.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Heiko Carstens <hca@linux.ibm.com>, Jan Kara <jack@suse.cz>, 
	Julia Lawall <Julia.Lawall@inria.fr>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	Kees Cook <kees@kernel.org>, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E52AF1DDBE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78944-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,igalia.com,citrix.com,linux.ibm.com,kernel.org,csgroup.eu,infradead.org,stgolabs.net,suse.cz,inria.fr,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,efficios.com,ellerman.id.au,gmail.com,imag.fr,dabbelt.com,armlinux.org.uk,linutronix.de,linux-foundation.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 at 05:28, <david.laight.linux@gmail.com> wrote:
>
> From: David Laight <david.laight.linux@gmail.com>
>
> -Wshadow is enabled by W=2 builds and __scoped_user_access() quite
> deliberately creates a 'const' shadow of the 'user' address that
> references a 'guard page' when the application passes a kernel pointer.

This is too ugly to live.

There is no way that we should make an already unreadable macro even
worse just because somebody - incorrectly - thinks that W=2 matters.

No - what matters a whole lot more is keeping the kernel sources
readable (well, at least as readable as is possible).

Because W=2 is one of those "you get what you deserve" things.

             Linus

