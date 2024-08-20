Return-Path: <linux-fsdevel+bounces-26409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C1F959070
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 00:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9702B228CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 22:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9E81C7B7A;
	Tue, 20 Aug 2024 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bTFGbbd+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABEE18C35A
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724192721; cv=none; b=E/3bkpnRvQdVMeopFZEHGSTxfebq4EIEgljFniX08q7ZSaHxuf02rqGWM3pTOjtTqYOlxWOUb76F+HsMHh+mCXmlET22YRVOy4fr4trhcifI+kJm8/HuU2jWf1pYWqcLHZU5G66XDxTBXpCRllUP73lSxt/i79NzsUrcJy6xF7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724192721; c=relaxed/simple;
	bh=XA2Xl9LLz1exNbfscxHunBT38eheK6GidZ5koi0zXEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0DlsqnFMxsruoqHsoOFzQRSbdFzzlKJ60bBH1W4cPC4Gf3L8XgSSVtrwKwuIv3r+9aqXCR7lJ+lPQRWCEtKshLFZR+8IEKfR5Ppp8z4GUK0hd8xsZg/oAHbDuRlL3RDuhHoRBhRAxiK47Hclu+qJALZBSRrU1bg2aNeI65Ow7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bTFGbbd+; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f3e2f07f41so25077851fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 15:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724192718; x=1724797518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NsDflXvhlv7B/L933J7hmRo6Te0QXzkZ39ECbN08B6k=;
        b=bTFGbbd+uQEhNIB4wN7I7nn0Qz4pPr9ugZMWT9Hgi8ZJ8lRV1fba1n/mMo8igwsXs8
         JCbbKeb+LjQHtG5EUmZaQTvcJxpmk0fl5+osoVPHtKtAMpfvUPrvRysozyKp2lVcAoxp
         4kW4Xttbz3BNjTrYBagOEX3xl2B6jI/nfMrQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724192718; x=1724797518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsDflXvhlv7B/L933J7hmRo6Te0QXzkZ39ECbN08B6k=;
        b=c/+dTq5edUxHBhgfqCbdLoVR78ME2DXy9rY5YWeW6gZNzVmtGdv3CwoP4GhPbp6Hve
         dJa3MYqSEYWx6r1MoEA91Q8W+p8JHPQ48p2lErIMnN60O97tvvsJyl1nBJSU0CTSKzGu
         PW/avlBNN0dcWL97KKl0j532We4BWJrmomeLmta35hZ8NUbjas8TP6T17uWPNUPApsLX
         pSIlqrjZ+i0CN6Wi5/N6Yub+Q15irAdsLAPkcsfh47iszQSXanYRCjpbXVGwVRlzr+eb
         m48hcc+f/vTdOv7Hpd2OZbJBs3e8PqjOB1/o07QXQn5z+SJ4HRCGZSJbuw6/O9TL2wZo
         gFyg==
X-Forwarded-Encrypted: i=1; AJvYcCWwWBHODtgzre7LB2W/btxtj1FPbPBM4/Ni0cZ+CwhpU/TPuDNB0yvc1aQsiIGmXq6KWKes9teN5Esv+6xE@vger.kernel.org
X-Gm-Message-State: AOJu0YwInn+YP8DRjVKK8HVblBJUyWFXH15XMS2ZaFXHj36lM7ZPu7s0
	mBW/sAGXvLcaql0bUeOp6DzA3TKvkndM6+QZE1WA4NUx9S5ndONAMvHTM7NN2Z4Djifgn7IP1c+
	AjPzBPA==
X-Google-Smtp-Source: AGHT+IHhRkXj/fGXgSA9sopKxpKTBRHDsKEfUt3KI1OQmqFoy1ojPKG8aeyMd5RDV3kcB9FrOPBZbQ==
X-Received: by 2002:a2e:b04f:0:b0:2f3:bed2:2947 with SMTP id 38308e7fff4ca-2f3f8b61da5mr1921311fa.47.1724192717275;
        Tue, 20 Aug 2024 15:25:17 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f3b748e516sm18835801fa.39.2024.08.20.15.25.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 15:25:16 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f3e2f07f41so25077691fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 15:25:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXXnHPdlwY4s2vkbP+ar2B40QhTlGn1FtVnY2bWusht7Z04DUsZ0OAeLTWqPWsRMAvxNoCu5N6mE+buohuw@vger.kernel.org
X-Received: by 2002:a2e:4e1a:0:b0:2ef:1bbb:b6f8 with SMTP id
 38308e7fff4ca-2f3f8953891mr2311831fa.32.1724192716017; Tue, 20 Aug 2024
 15:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whxS9qM36w5jmf-F32LSC=+m3opufAdgfOBCoTDaS1_Ag@mail.gmail.com>
 <172419214486.6062.12815120063228775100@noble.neil.brown.name>
In-Reply-To: <172419214486.6062.12815120063228775100@noble.neil.brown.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Aug 2024 15:24:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtmQyq9OZLHPDVkkq-XVQNMF1ck-vSZjQYo=g4=Ue1Zg@mail.gmail.com>
Message-ID: <CAHk-=whtmQyq9OZLHPDVkkq-XVQNMF1ck-vSZjQYo=g4=Ue1Zg@mail.gmail.com>
Subject: Re: [PATCH 0/9 RFC] Make wake_up_{bit,var} less fragile
To: NeilBrown <neilb@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 15:16, NeilBrown <neilb@suse.de> wrote:
>
> The argument is more like "we have interfaces that are often used
> wrongly and the resulting bugs are hard to find through testing because
> they don't affect the more popular architectures".

Right, but let's make the fix be that we actually then make those
places use better interfaces that don't _have_ any memory ordering
issues.

THAT is my argument. In the "combined" interface, the problem simply
goes away entirely, rather than being hidden by adding possibly
totally pointless barriers.

                 Linus

