Return-Path: <linux-fsdevel+bounces-36869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F119EA22E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 23:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685711667FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 22:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29B419E971;
	Mon,  9 Dec 2024 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KTcv7Nqd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17C719D090
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733784967; cv=none; b=NIiRUGaty6L/EGf3YN2zmJSbiu+6oWQJcO9432kw+ra45nFaNYqUiGlGLJHHhCE30iEpPIXAbzKJ3+bjN5v+JE1HgIWpXtpvUz8w+xDWvdwgVNMw4Ak77ZmmUll5/q6mgo5xYf+SWZO3Wxj3YPaxpqAqRSzi5h4xul4zHgEv5+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733784967; c=relaxed/simple;
	bh=y6NaN3Zo232Pk2Ag5GJwiZUrdVDUsVzoFvVaXbq1lrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mU6/PTLiU5gWCZq9JmTqVotNZBmJ/pUzqcrRnDo/jpRcuSwJ+KWwvMCk7D3r4E5bMzim9QoVAqDSSIpuUWqXS3fbr+qKBZzD1xsXEf6IBK5T+SBzQdyrlFkniQWeaWjzffrM4tvfs3uoHi4og+NV/caPi/hFisPCwxHUFC1kmR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KTcv7Nqd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d34030ebb2so6482438a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 14:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733784963; x=1734389763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o9h9KlGUU8rXJLUI+EIgtD/4EyYFDGlbm4mYKbNrpdE=;
        b=KTcv7NqdpgBLeDCm/CvGx8puXuXcNIJjmnKuQyosGpw1KgflgMSm9Qw21taJn3tQ9X
         IkyI4I91k9FSR4+8fFBsxNUEuV1fSCsa3mcXqDOC8Qp7RmAVde4nNTGjpLw1Z6aFBTKK
         8nCLPtFBj7ocPEQ7DTqPzzKCw5kke04tDWnzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733784963; x=1734389763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9h9KlGUU8rXJLUI+EIgtD/4EyYFDGlbm4mYKbNrpdE=;
        b=XoT2/90pOSXg9THG8JVkXCGgoFRylK9b97JUbT7SJEKkhFwDuhc+T1zyfywJIxCTko
         R/fNQK1V9SJkdcHsJYj1aBUg2Uv6iklQSl5+ZJWDXcRQp6XkVU3BNatTcOoXhtAEoV9S
         b4XMsSbIHBrbhQqd10pF/jpMhpPJ88a7goCIvQKD1uC5vMrrvrCI/sNmRrnQMTKFJz9G
         AzKCE09LnWdjCioGPRPtNOAd+KHApDMjdvwLYccFuihG/6195vH8Wt/6iZStH8iFg01L
         KS1b3yzi1OLkYAVuMvJQccRQs3w+Puo+25KPOJQhDKBGJauCtJ3qxo2aOijtPZC9WAkm
         fJzw==
X-Gm-Message-State: AOJu0YxR5L77kCh9hWIeiKb0ezhFkQGMz69DU+v196i0O+1RUusK4oSu
	nR0qtTgAMXxZN9/k/d8SzKBy6tAAr7MP9GAO9K7m38/dD8JoFmsWkOh4/sQ+XLlz9B0UxEIJev3
	AFMo=
X-Gm-Gg: ASbGnctRY5IzfJGWoGeIvPn4U8fY2nb/j7gGAyxCcTOE7rRchD58f+HjrqH7OfrOtlr
	WsEe0KZyVLY66xLyf9G1XlVt7GM46SwvFzYMrlBBf7JS+yuDnDrn+/8jSVk6eokIqVdCADAeRfa
	mXB87xMtMLG+m/YIcrUAS6x1cubI/M0ICkK4CbbhJeLw5OmJv5HIOmwDU/aJPleOw3IUukWA84L
	errEdO22OxblPtPb72fqbyMAUrPigFI3C3xfrpD7boH6cdcObOIazYzEvvYhn5BIAgoDKLlje7j
	Vf0AMjMg2WGYOaehcCbhKsZJa8L/
X-Google-Smtp-Source: AGHT+IGHifKh5Bp9HXZRTTjp/ISmV/dXQLMFKPdCVvZ0asDRnQvoIavyfUlHR6O27AgtgBpEre1Cbw==
X-Received: by 2002:a17:906:18a9:b0:aa6:7881:1e84 with SMTP id a640c23a62f3a-aa69cd375ebmr241022366b.15.1733784963009;
        Mon, 09 Dec 2024 14:56:03 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa692e4e9d5sm154752766b.129.2024.12.09.14.56.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 14:56:02 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa689a37dd4so288944466b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 14:56:01 -0800 (PST)
X-Received: by 2002:a17:907:9145:b0:aa6:7c8e:8087 with SMTP id
 a640c23a62f3a-aa69cd0fcd4mr210991666b.12.1733784961326; Mon, 09 Dec 2024
 14:56:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209035251.GV3387508@ZenIV> <CAHk-=wh4=95ainkHyi5n3nFCToNWhLcfQtziSp3jSFSQGzQUAw@mail.gmail.com>
 <20241209211708.GA3387508@ZenIV> <20241209222854.GB3387508@ZenIV> <CAHk-=wjrtchauo9CO1ebkiES0X1VaZinjnHmcXQGBcZNHzyyBA@mail.gmail.com>
In-Reply-To: <CAHk-=wjrtchauo9CO1ebkiES0X1VaZinjnHmcXQGBcZNHzyyBA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Dec 2024 14:55:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj_rCVrTiRMyD8UKkRdUpeGiheyrZcf28H6OADRkLPFkw@mail.gmail.com>
Message-ID: <CAHk-=wj_rCVrTiRMyD8UKkRdUpeGiheyrZcf28H6OADRkLPFkw@mail.gmail.com>
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Dec 2024 at 14:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> IOW, I'd *start* with something like the attached, and then build on that..

Key word being "something like". I just checked, and that suggested
patch will cause build issues in lib/test_printf.c, because it does
things like

    .d_iname = "foo"

and it turns out that doesn't work when it's a flex-array.

It doesn't have to be a flex array, of course - it could easily just
continue to use DNAME_INLINE_LEN (now just defined in terms of "words
* sizeof*(unsigned long)").

I did that flex array thing mainly to see if somebody ends up
depending on the array as such. Clearly that test_printf.c code does
exactly that, but looks like nothing else is.

           Linus

