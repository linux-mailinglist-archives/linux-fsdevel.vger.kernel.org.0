Return-Path: <linux-fsdevel+bounces-12067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7A185AFC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 00:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB9F1F22516
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 23:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD34956755;
	Mon, 19 Feb 2024 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WAPyepDh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7154C7B
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708385074; cv=none; b=rAX4/2PzDBPO/SCiBynntVz3S4PbFZS93xXE8y57xeGfq42Ko3tgTYSUeJeMWgkC26pRlEH7DHZexxsull/2PhcHnXt2qhsfUcZlfHMCn93a81TgiI7lIUh6PozOGMg20faVzzl45ffCYJ2FylLf593yoJr+bU3J/jIMEnadVuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708385074; c=relaxed/simple;
	bh=33lfy3hXBnTqG12zvQs+lgelHG3xwXFXfHSDyO6Ro0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpyBfKP0WLqattw1qOTTvSamNDkXJBY2SmcHUhymWndmQhGWh6LVs4zjdhh4cW5mMQdN1rV5T9A8rJU8ijN9GZabhevl5G8YbKp0Nq7qcFZVX6ZqCgB3X9TjM0nUVOUar/ylmabzED3U7TRXrkSK+mN9TfiKj1UsX1KQbX67Q7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WAPyepDh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3e3a09cd79so201206766b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 15:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708385070; x=1708989870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0plIMHxe8yOXLQ7gWCRY/DMfYOp9oEwN4Q0ab4xUw6I=;
        b=WAPyepDh03mSiER4404e3HPUwqK3KjoZQLMnll0WPNHezp1Rxo0e89FW5+G7DVTPsm
         sirR4p2+02CwiBVwNwUIfW20Ktk1GC6Y0Y4QHQdZ26u/OjSA4ODpHRVka3TMH0S5beIL
         Vm4KYfhjYTuS0MSAhzFB4oLHzEUH/5DV7JjBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708385070; x=1708989870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0plIMHxe8yOXLQ7gWCRY/DMfYOp9oEwN4Q0ab4xUw6I=;
        b=eo3VpC9HGWQax7YzvJMC/b15elLQXLfHFn8bsM2DuKQ9+R+VSayQGg59iaq6PsD3/7
         woRWz/5FfCvM2h92IxmtYO+KwMj2/ggfXjBwJlx1xpRTg3TeUmNVKeLvIRNyhq+KtcLf
         LBGSmBN32/Jg9BzOk6dX49OvKuFImamiWrdF6QM8VUDct0KMcTmVa4SefrAwbG5VCGUK
         6LI3FNQoAmpivel1oXUotlrQ9BarqH56qwlKs5biK5ACj3VhEuEppQW3ZEwVdIKGSlYF
         xNa77z0gPl2KrO+0Luxk3JeLEXh7BeDGZRV+Z8r7LDmd8KGjpavtMFQEEP5tt62r31CS
         Jk4g==
X-Forwarded-Encrypted: i=1; AJvYcCXLrUBN7GJD/+pM7enuGsMjAfHBazU2/nj6cTbQXqRLlnCB8QsojsCiWovQV7Ci/k1CaftBGLqa3Mrv6rFQUtkUvDokVIuhsPCi8lK5AQ==
X-Gm-Message-State: AOJu0Yxm8e2/YvO6EXergHfagNEmJbk5wa/ojiQCrSW/b01RD1GOuW1h
	RZMUlJxOJ89CFg1whlbLtBQfNrKQDCOJSr9YXRdFd7vnWssyrk3sKeOU+rLZ3bzTiHNGoFLtL4b
	MMZw=
X-Google-Smtp-Source: AGHT+IFxTHAFpORjj3Y3pRMLM911l1mEd1RyhGwfNrqpjHD4g/zuGd8zpOKg9zhHCWnUqHLfW6Kx+Q==
X-Received: by 2002:a17:906:a3ce:b0:a3e:dcd2:2746 with SMTP id ca14-20020a170906a3ce00b00a3edcd22746mr1512908ejb.3.1708385070603;
        Mon, 19 Feb 2024 15:24:30 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906c19000b00a3cee88ddc7sm3430454ejz.147.2024.02.19.15.24.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 15:24:30 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5649f396269so1612431a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 15:24:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVeSa3OaSbiyTRdZ+z9RT1DJLqVEk0ysR/qnFyebSxJn9xqCT0SKLhiFpmkiqnkwNmakrQztc0zTQL3cEVllYC9vMdEsOrw1fuSjnEMdg==
X-Received: by 2002:aa7:d6c8:0:b0:564:c80a:632f with SMTP id
 x8-20020aa7d6c8000000b00564c80a632fmr41369edr.5.1708385069739; Mon, 19 Feb
 2024 15:24:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216-gewirbelt-traten-44ff9408b5c5@brauner>
 <20240217135916.GA21813@redhat.com> <CAHk-=whFXk2awwYoE7-7BO=ugFXDUJTh05gWgJk0Db1KP1VvDg@mail.gmail.com>
 <20240218-gremien-kitzeln-761dc0cdc80c@brauner> <20240218-anomalie-hissen-295c5228d16b@brauner>
 <20240218-neufahrzeuge-brauhaus-fb0eb6459771@brauner> <CAHk-=wgSjKuYHXd56nJNmcW3ECQR4=a5_14jQiUswuZje+XF_Q@mail.gmail.com>
 <CAHk-=wgtLF5Z5=15-LKAczWm=-tUjHO+Bpf7WjBG+UU3s=fEQw@mail.gmail.com>
 <20240219-parolen-windrad-6208ffc1b40b@brauner> <CAHk-=wj81r7z9wVVV+=M57z9tcVY4M8dcy8fLj5rWHrf916vcQ@mail.gmail.com>
 <20240219-deckung-zierpflanzen-054fa070b251@brauner>
In-Reply-To: <20240219-deckung-zierpflanzen-054fa070b251@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Feb 2024 15:24:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg8cHY=i3m6RnXQ2Y2W8psicKWQEZq1=94ivUiviM-0OA@mail.gmail.com>
Message-ID: <CAHk-=wg8cHY=i3m6RnXQ2Y2W8psicKWQEZq1=94ivUiviM-0OA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 13:18, Christian Brauner <brauner@kernel.org> wrote:
>
> I've moved the shared cmpxchg() bit in {ns,pidfs}_prune_dentry() to a
> tiny helper so the cmpxchg() isn't coded in the open and is documented
> in a single location.

Ack, thumbs up. LGTM,

              Linus

