Return-Path: <linux-fsdevel+bounces-36859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EBC9E9F35
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 20:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CAF28606D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 19:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05834153814;
	Mon,  9 Dec 2024 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fNBeAwWQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354991531EF
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733771230; cv=none; b=fquMb6gu2kxsqmH9vSyPnRbNQkeBpq27VMzsupy4ipSOp1ygjcs9mqhUf6uIUBh2UVe8BbiGe0+8ToUCXNVtbcTWqc5XqxV/aVboDdpk7r4R8s1CRnxMt/JsEFpfwJhU2joErsNqjzN8hacapO+j9Y0sgl0zqM8UbErx0Uo1RTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733771230; c=relaxed/simple;
	bh=N6sYFmfhKv56VX6TJ7+s3GcfsWAkQdAYYrinc3gLWYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1a+iavHHK2AhjYzCEvYFaoDjMrdE6+A0n2LtmBSqymv3y3BSFcfRfSwRxyYqOv+OhjlWYMeqYAsfkaeh9wwDBWO343qQT05u6vKZ5FIhCQWgbtZ4fTaNwer3kUOPoOD1ZIGiKkyuEBrmA3nZAZJLOiJrXL4PmkrUqVO+ULVCfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fNBeAwWQ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa64f3c5a05so455811266b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 11:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733771226; x=1734376026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0C6SoEKcPTFkjVpCjODqDPIQirURxhRumTuqazuXSvc=;
        b=fNBeAwWQzce6wWmNWLbPc5+/X9xmgNO2f/bywkrzpgdGx6VdG93gO1gPaUwbfwtSE4
         j8Jpoaip2CBtuBZHzjzOrdlast6poPpfhEs9nrOblr8e/bSKbJ4y9QSlNyNZLqSMRClt
         B4KscuuioXtl73DrkUGrp2lurZhLmc3Dj9AAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733771226; x=1734376026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0C6SoEKcPTFkjVpCjODqDPIQirURxhRumTuqazuXSvc=;
        b=uxFzG1uIvvPrEpQKBLtthmk3Mt9735EQDckLoV3f22ihhoSPhMen/TwtyBrjCTprIK
         8TCKNALt1bB6GMouGer0RKlKCBc3SIRbcWdVtCA2yzKBzMzB4j7sMVqCykiywRz8ha0N
         XpgcmCJa/N1xYACA4wuDkDft0uijuO87TPX4kv7hbZVj1Gy1amXhbUqB9+flH+aAWhhy
         /t7SlmfRkRoAkhigh1DGAfHs6hHWchJ4/AP18JtrbeosW1jyffDJoHTf+3KPSnV4GNlf
         PpjhDwriYXg4o9veuxhUshDpB6vwCiWe0/Kns4ITczHIHh9ITL+s5TBGY7sCjxqLyCyy
         TclA==
X-Gm-Message-State: AOJu0YzQE4abHdZ03DXsQYvohHEk2Iu8WMdNC9yxADPmnKofXwGdpYRa
	9PcZoLkvZq8OPtFdmaBGKK0BFK+ZBN6dLB0qRNoyo3iGQhBLvII22NmYCvIQuQWcUed/mlqvOsR
	yDX0=
X-Gm-Gg: ASbGncvmG7+pH6MZ2hK2o6EZoXBGRXubm4oLUMFdtnmQ+9tlLFfs5WWiLMN7myr34HR
	cc/4lH0yw3WLMpNxu5eumqttp5i2on8/HQhUy30fCiXWPU1gsCXRORt9rJE5ZrpLbKW5OeVpcUz
	3/eH9kIXvUxlZhq5/oZw6ewZ2cczP9+TbqXB0pGn0vicCcfSLXRjrQ4eM+P1K0Y9cbYqtaO0SC/
	pvuUGecmfiL4Rdml3T/AmlcQc0KwMVwZObQ5wADg6t6Xan9LiHRQcx29WKoKAUJidva2HHO1M4N
	Wvc6Be10LdrHtrujsTRfN58X
X-Google-Smtp-Source: AGHT+IGFH4mICY4fc81tnvFM8qtnms9sGfAIGRkOeWFbXicxnfZyC/RYJluRsOEswnb8+lSsaQ8nkA==
X-Received: by 2002:a17:906:31ce:b0:aa6:9eac:4b86 with SMTP id a640c23a62f3a-aa69eac4cd4mr120830366b.16.1733771226136;
        Mon, 09 Dec 2024 11:07:06 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa66f19af6asm339834666b.196.2024.12.09.11.07.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 11:07:05 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa64f3c5a05so455806566b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 11:07:05 -0800 (PST)
X-Received: by 2002:a17:907:c9a0:b0:aa6:83cc:7996 with SMTP id
 a640c23a62f3a-aa69ce67643mr163542366b.42.1733771225169; Mon, 09 Dec 2024
 11:07:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209035251.GV3387508@ZenIV>
In-Reply-To: <20241209035251.GV3387508@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Dec 2024 11:06:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=whnCrFZ+id8E3Y0uXVDyT4Kbu6pLdPgL42LYTNPdYDVpQ@mail.gmail.com>
Message-ID: <CAHk-=whnCrFZ+id8E3Y0uXVDyT4Kbu6pLdPgL42LYTNPdYDVpQ@mail.gmail.com>
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Dec 2024 at 19:52, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> +               struct external_name *p;
> +               p = container_of(name->name.name, struct external_name, name[0]);
> +               // get a valid reference
> +               if (unlikely(!atomic_inc_not_zero(&p->u.count)))
> +                       goto retry;

Oh - this is very much *not* safe.

The other comment I had was really about "that's bad for performance".
But this is actually actively buggy.

If the external name ref has gone down to zero, we can *not* do that

    atomic_inc_not_zero(..)

thing any more, because the recount is in a union with the rcu_head
for delaying the free.

In other words: the *name* will exist for the duration of the
rcu_read_lock() we hold, but that "p->u.count" will not. When the
refcount has gone to zero, the refcount is no longer usable.

IOW, you may be happily incrementing what is now a RCU list head
rather than a count.

So NAK. This cannot work.

It's probably easily fixable by just not using a union in struct
external_name, and just having separate fields for the refcount and
the rcu_head, but in the current state your patch is fundamentally and
dangerously buggy.

(Dangerously, because you will never *ever* actually hit that tiny
race - you need to race with a concurrent rename *and* a drop of the
other dentry that got the external ref, so in practice this is likely
entirely impossible to ever hit, but that only makes it more subtle
and dangerous).

            Linus

