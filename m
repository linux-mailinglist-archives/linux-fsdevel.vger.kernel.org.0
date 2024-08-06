Return-Path: <linux-fsdevel+bounces-25162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1509497F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 21:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99271F21E76
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272AA14EC44;
	Tue,  6 Aug 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hSyqRyQO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995DB149C53
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970943; cv=none; b=khEM4y+aXwaCIg3s5+A1H/wmLJZ4nh3iX/6lHy52n1sqFSMCaOl5ChfGy/ysPsyepf6c6kGIlyIZKG+acI3KgZzYDA/ioalvWI2kmEXWlEEwQKJivZ2JyMdhWZZ1Q1xiEKZNSzpxy7jk2deUcwr9/NTUBG+pGlCDXePYmTxEi0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970943; c=relaxed/simple;
	bh=PJTPlupeD76Ia/bH//Hxc92U19lHKicSKX8SQIwk0cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6DNe3mT9yleAbR2LE9LBmMEU27jtqmUjFJGAFfTngpxttxzwY/ReEIhdhLllx88ZojHN6h4I1MfxO3KQEoK592WQTKbWLXlDUxmSV8bg/xAZwxE/zk91i/T210b8fTkpCotxWv+a6JhbN3tdjvBblDU+dnN3KP5OqMTNaOxwi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hSyqRyQO; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7bcd0so1427585a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722970940; x=1723575740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K7OpQ24xTWKUtgMGYYeHm4cTkwdIfO8nPqlqE9Blx+8=;
        b=hSyqRyQObHqXHpWmW9u6MZLDMEpMzxlPemfmbhuU39nUV42cSxj/u/oTu7sgYY4xV9
         oNGQhgJDPg0CIamrgffRsHALbeUF60KWDJrj2HmjnJx3oy485gSKyTNAO9xM6RsqAKGs
         r2QTbcROu9e7/jowArtRnY6S8vqyC+wZKgWmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722970940; x=1723575740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7OpQ24xTWKUtgMGYYeHm4cTkwdIfO8nPqlqE9Blx+8=;
        b=vdF6F2SnKug4wOCAm1RLaA5BvvT0IqW9aQEJDHbGVrmKmAcfVbHaLeHaoB5AOgK4kU
         vl/38wPbs/9uHRtUKZ0hd0rz7MKsjnbtWnKc/NEjOhxUh5QUjMkq4VNg7tECmo4NdqFq
         YupxkFsgjdhbtDD64JzwrwgbcfkymXWWcAY6JiQXeWYhmACt2O3JWDkoyVFrX+2gUtIp
         e2Gk3tsfR3oFzElz+EyBe6rLy2hA8ALmerJx7uvuehtNIYKKIi92NHvMDk+I/PBhT9np
         bFqBI6xRWhg1QLREGUI6zGzPXFroxnQ5tAY1vnNafSXMwcT5VraSE+ODcLdeE/iJVFeB
         5FKg==
X-Forwarded-Encrypted: i=1; AJvYcCUbJ9smPWg7M6K57AEXT+v0hX6/sp9U/uKv5as1oJlOc1uSfPWIW5dPTYWKqW3jfFMs3eoRc6fAy89I+gTXrD8RQhvf64Xt1yv6dZJZTA==
X-Gm-Message-State: AOJu0YztNoDZqQ/a8xsJE5lV37V/oNcEtiKEa69JtgVbYX6IaVj6Lc7n
	kioiYnU640Toi8CTHOoUt0tOmPZeuU/IGgEZ4iFXXJkeLgd6ddnK20fwN3girdYdTf+P7ubZS7S
	sYVOMMw==
X-Google-Smtp-Source: AGHT+IEMDM/7w8xlWghetf8k6ngLNfSxK0mkGeFee5Ixx3/+q5lC1iyLhS6sIcFzp/5BKfez9egTGQ==
X-Received: by 2002:a17:907:3f8b:b0:a7a:a6e1:2c60 with SMTP id a640c23a62f3a-a7dc5148422mr1108619666b.61.1722970939523;
        Tue, 06 Aug 2024 12:02:19 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec6db8sm564154966b.194.2024.08.06.12.02.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 12:02:18 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa63so1400718a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 12:02:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1EeN/1vZq8oAGfvlalJ8PrIizYrOCeQn77LmvKQ6jrfr5kWIswMrQc/xqUU8TiTIpjN9cDftzSH2gvH7wpfkUhPT5143Tsy6i0KmCRA==
X-Received: by 2002:a05:6402:22af:b0:5b9:df62:15cd with SMTP id
 4fb4d7f45d1cf-5b9df62178emr7137033a12.32.1722970938444; Tue, 06 Aug 2024
 12:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6@eucas1p2.samsung.com>
 <20240716141656.pvlrrnxziok2jwxt@joelS2.panther.com> <20240806185736.GA29664@openwall.com>
In-Reply-To: <20240806185736.GA29664@openwall.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Aug 2024 12:02:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1w6+Xup=amYtYUCLO-SRYoy9R0z6BG-uGV=y2f6yFWA@mail.gmail.com>
Message-ID: <CAHk-=wg1w6+Xup=amYtYUCLO-SRYoy9R0z6BG-uGV=y2f6yFWA@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl changes for v6.11-rc1
To: Solar Designer <solar@openwall.com>
Cc: Joel Granados <j.granados@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, Kees Cook <keescook@chromium.org>, 
	"Thomas Wei??schuh" <linux@weissschuh.net>, Wen Yang <wen.yang@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 11:57, Solar Designer <solar@openwall.com> wrote:
>
> As (I assume it was) expected, these changes broke out-of-tree modules.

It was presumably not expected - but for the simple reason that no
kernel developer should spend one single second worrying about
out-of-tree modules.

It's simply not a concern - never has been, and never will be.

Now, if some out-of-tree module is on the cusp of being integrated,
and is out-of-tree just because it's not quite ready yet, that would
maybe be then a case of "hey, wait a second".

But no. We are not going to start any kind of feature test macros for
external modules in general.

                 Linus

