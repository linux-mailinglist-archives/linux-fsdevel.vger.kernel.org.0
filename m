Return-Path: <linux-fsdevel+bounces-41330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B72A2E006
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 19:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC77D1884791
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 18:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472581E0DB0;
	Sun,  9 Feb 2025 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JEE/RZlj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1381D47C7
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739127166; cv=none; b=Dk60/tFGtUN1B1WMuHPgoZyOIpQa3Y0DCTOh3BvQXNWsdUp/f8XkRhXPzxmo/KbE9zSA8iTbLRI4NJCJOzfVXeTYxYIPd1TQYBiO/VKyjfzaJmQNoNVXV7ToeTPpKP+HOIBtaY6YACi84lplHQpV4RgAHq0x+Bu4aXlJX5lRhbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739127166; c=relaxed/simple;
	bh=IVNyMtoCy/IQWUCzExioy8R2z48SeBgRzIjIWimhBM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMgcF0bDSE8S4iigih8Z3zedzJj4NYi+mucijKGRfBH2EXbE2plsLAON8JChU88malOSKhotyelP8zj7Ba7ukvNIkvGcMEZb1E+pHpfyL2kKYT41Swx3qWK0yKEmL0nS7oGvOpnEWOFOUkbXzx+EPg8RfPMvraaMBRYqtUv70EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JEE/RZlj; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa68b513abcso700764166b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 10:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739127163; x=1739731963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LXXwY5h/VlGF5trnXWAZvvy5OPxaCpIv2SR4OnIR3x0=;
        b=JEE/RZljNO7T8jZStHcPGpoY0PZF4yqnK72vcjqqK/dWNhL57RYtZGM75lp9kuZj6e
         o0C/4dcekskiERMT1WeSaAKl6/F5M+cwhd9hkwvBsJoCUYY7PNHGzuS2uY994BbVRI8G
         eHf2ghw6SCmZK8WGVJEzrYPgBbinAW3Q/BeS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739127163; x=1739731963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXXwY5h/VlGF5trnXWAZvvy5OPxaCpIv2SR4OnIR3x0=;
        b=AIYfib0zxgdHOto9n9tgtg2OkNTxmCFKbE0iUYbuJJfNJ4W4ZqUhHaxc8vf/pQdTc7
         Nnr75DSu1eTaGHxgn9mQwLzOmaLG/7q8Bu8zXeRrMbm2H4+HAqUjIGxTBRqEln0BHNpV
         Wfap05S7P75jk154lWyMCDTZI/3ZzfutHdf/ZFi5h2JVBNEbEbb2ovWhWRksyFluD106
         OXkdbNVfodRim5fKeon2/Odsm9oF9piMmiRaZTnU0Ek1Ml2Uu+dy/2OONutYi5SFVozI
         /qrn3kHvlwN8HGL9t/JDtYUDLvJidH+llUppPqyt0y26PU/lejtkIxgBqxpO0Ixwe23+
         5VNA==
X-Forwarded-Encrypted: i=1; AJvYcCUNhI/+uPYTTK8TPMUk/XWdHMdctC2QQIzexN5wS+Y0D6w4stp08u+dk1438cY6C88l8QasR1RDtHIfEri9@vger.kernel.org
X-Gm-Message-State: AOJu0YxKWHuBTSvZRN+CGHiblHvOLAdyQVkby+dmi8PlDJ1aQrqGDZhd
	MIBGm06CXM2kY7btNFLvLsd7c3Egqww1rOI7I6LjGSaIx+O8pMRMuj5cKSq67Mou4N6/H3s7dtu
	khoo=
X-Gm-Gg: ASbGncvxJNBiInHGV7GvJEh3QnJF5w/9Ybv2AOuPTXMWRkDO1LkmXxlmUuNJHwNTPXC
	2WSE9XElIpNdWhvq46zpMQSjig0j17oKWN4xWFykBZdJ3l13JuZTgOuktkbOOKJjZFyNrvBcEwY
	QdprYQzm7ZDNI6ruEtj9D3B7alnHGY9WTk6nwpdooaNiQZdNWelZ7s/kTQp7mP+mpB9WHPIYWi4
	SHwWxDYGPxUq96zo62m0a4uOsYZkU0i5dAk0zx6FmXzY4NssBB9+rFGHriOFXmuGcUHroYsN//m
	ORQfX0PP2HYsJgolYKPzO6uIf4bgvI8n8RZyA0FX+Gelzdh/8fMjkU8KWhkNHqYLXA==
X-Google-Smtp-Source: AGHT+IGpLtva8y9gHWv1eMPP6j5oGPcuKqADPwlb63VBIA9iBbwwWBOhSWJtB5mF3PU2RNxItSMWHA==
X-Received: by 2002:a17:907:d08d:b0:ab7:992:7f42 with SMTP id a640c23a62f3a-ab789ba47famr1331456266b.34.1739127162600;
        Sun, 09 Feb 2025 10:52:42 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a5a78369sm356647866b.136.2025.02.09.10.52.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 10:52:41 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so584544966b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 10:52:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVehxQotLnGTSed0pa3aUTw4fuNSPCzQ7w0hIfP1WslH383gkGWUCvCkv6R3kIFf0rZyk8TsUnDSFLnUUIP@vger.kernel.org
X-Received: by 2002:a17:906:ef0b:b0:ab7:6c4b:796a with SMTP id
 a640c23a62f3a-ab789c629f3mr1325242666b.39.1739127161451; Sun, 09 Feb 2025
 10:52:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209150718.GA17013@redhat.com> <20250209150749.GA16999@redhat.com>
 <CAHk-=wgYC-iAp4dw_wN3DBWUB=NzkjT42Dpr46efpKBuF4Nxkg@mail.gmail.com>
 <20250209180214.GA23386@redhat.com> <CAHk-=whirZek1fZQ_gYGHZU71+UKDMa_MYWB5RzhP_owcjAopw@mail.gmail.com>
 <20250209184427.GA27435@redhat.com>
In-Reply-To: <20250209184427.GA27435@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Feb 2025 10:52:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wihBAcJLiC9dxj1M8AKHpdvrRneNk3=s-Rt-Hv5ikqo4g@mail.gmail.com>
X-Gm-Features: AWEUYZmWFnx6e3qeVjXXofi55drVemlr8M8BEprchRHM8w3Wt6AqBL3UZAxLIpI
Message-ID: <CAHk-=wihBAcJLiC9dxj1M8AKHpdvrRneNk3=s-Rt-Hv5ikqo4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] pipe: change pipe_write() to never add a zero-sized buffer
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	David Howells <dhowells@redhat.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, Oliver Sang <oliver.sang@intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Feb 2025 at 10:45, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Again, lets look eat_empty_buffer().
>
> The comment says "maybe it's empty" but how/why can this happen ?

WHY DO YOU CARE?

Even if it's just defensive programming, it's just plain good code,
when the rule is "the caller is waiting for data".

And if it means that you don't need to add random WARN_ON_ONCE() statements.

So here's the deal: either you

 (a) convince yourself that the length really can never be true, and
you write a comment about why that is the case.

or

 (b) you DON'T convince yourself that that is true, and you leave
eat_empty_buffer() alone.

and both of those situations are fine.

But adding a random sprinkling of WARN_ON_ONCE() statements is worse
than *either* of those two cases.

See what my argument is? Adding a WARN_ON is just making the code
worse. Don't do it. It's the worst of both worlds: it adds code to
generate, and it adds confusion to readers ("why are we warning?" or
"when can this happen").

In contrast, the "eat_empty_buffer()" case just saying "if it's an
empty buffer, it doesn't satisfy my needs, so I'll just release the
empty buffer and go on".

That's simple and straightforward. Easy to maintain, and more
efficient than your WARN_ONs.

And if you can convince yourself it's not needed, you remove it.
EXACTLY LIKE THE WARN_ON.

So there's simply never any upside to the WARN_ON.

               Linus

