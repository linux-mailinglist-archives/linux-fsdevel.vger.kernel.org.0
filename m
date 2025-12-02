Return-Path: <linux-fsdevel+bounces-70418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8E0C99C7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 02:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3601C3463AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 01:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACC82153D3;
	Tue,  2 Dec 2025 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X0gSWpo1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5AF156678
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639360; cv=none; b=XgBtBwMMQgYUb7+LTWI7EC5HgAvNNnWVmDpe26qtLIcTB6I+Xw+PX4yBxqt4L4d/iNqEUsDCdltJKeeXiyJfEb8fuKyxLkX0HKKRAw6ZF17dfYIpFU5qS2nzc0amrzJd6iB/r1esEqa26xmqRCJ1OF5ooPFZunScjdpIp6kDsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639360; c=relaxed/simple;
	bh=LKIM6mt+HcObnfTPlOCLeMkiy8bAb7PeXjPJ15Fuq6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V65yEDMxpGv2NX2jWjXNLixbqJB51+xsSe8wXJBNnqe8d3aSLHGuL86LtUYjADwpk0gJOUJtkTczo1xgOojzIkgPHVJpYt/vooNI9BaSr31yyIMT6qQFUBxhG0KMwG2EZm1xlHf0cHn9wrw6PykrFAJOmT30uJalrkon/CCJYRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X0gSWpo1; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so636603566b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 17:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764639357; x=1765244157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hZknnnxhPQCAq+p7l02p0cQf1GhnFL6uJixWR9Dzwec=;
        b=X0gSWpo1XFcl3yL5EXNoWsUx8H6ancwqzXFQuwZHG3IscFpIYmObcLiN2MHxrH1dj1
         SfJI0HizKh2KZunFnkx+F5ybU6Sdw1ROvUNs5wnLHHPAC+QEM8VskGhl/2dyFH+7/Re3
         EMyJDl7x/NI4B0uyfhCR84hzB1oOIrpA6KVOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764639357; x=1765244157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZknnnxhPQCAq+p7l02p0cQf1GhnFL6uJixWR9Dzwec=;
        b=ndvDXg+CW/UP80YVr8lqqdL+yI06ACWMekGU1QsDiNfJeh44daifrX/WUoqHTqlBAM
         xLoD7ZB7sH0ohMSDNpkdqoebWvFhXMMBIT7OypmyMKTnO9ZNFiXPiBv1/q8bau5Fr4FR
         +vzaUdfSekxYW2m+/Ah1ETGCpFQOJFhbbJ2sak1X/C2Vo/eDRYGxtP8uQ/8QL2fbm8yp
         VxDqY/EhM9GBzDQCvrtXMRrIF5Ad9ETYdMJBM3mTIBawU/CPQkq3awNCbsKHE64LDzYQ
         J20s0Xd0FiBG8yVMJQoqPYUctsjrWDsg+mbQZtv7n6s+/b3UZbZWh2cXI2R6IM2lgado
         7MYA==
X-Gm-Message-State: AOJu0Yy3azY8y3F/dO0HCJwEvS6sti88/PVOwT6PzY/km4x8G2FVHkUj
	tuRuP6rojkRGbWuycOmIE0SLuat5wSCPi5IYtbYEjSFMCdu5Aa06HRdDzTb/c2ZYoJpED8kvxUe
	1fS+bAEQ=
X-Gm-Gg: ASbGncvLAgYOtvbE4O1H3BJxjAHA5BhWLHFEv5ojlKUCvwnFRmkblDsYYF+8A+ESzrL
	FeGhTGQb+h3IkUVa/OYKWMa03jjFNOGRiCURTaHFOgpQ8PZ6YbYPXWqJOVmuQUxrPe6H7WBWMBB
	DWyjwHfrUYkOaf6twI7lniFThw/DMoEsNDxY2MfkIQHh2UhnJtmM/bMiC4VJHHW+mZQzG+IOaBo
	cJAau0ZkIVhRkqW/DsuGcQ/qAFSlBBtO5eTW9hhMdL2Sp7hqv9oKNgLPXvvNTbO2FWvxBaGD3yt
	GE+DVLe3nV0X+Ye9/dwWPWWBODPFSMHgG9a3a6PsRsyHgM0pKZkhPXiXHjPadxwt3ZCS398WETR
	Qn7KgwUZBYT2why4qS9j913tVF3Ny9nk69D69Lnsyga3X3k5UiZUm33nO3m+AtxINC8R35dMoev
	8zc6Icz0RPAi5Y162DZ3b8WEI11vuexrPSeq0PexWEk3ZWbcUdNeVRy9Bw8dKb
X-Google-Smtp-Source: AGHT+IGKNhVXTpxvrkL4rAir2J951dqYvmze+AQyNB2mxCGf10zHyNhX6EAJ5YbaEeYedqePwTvDXA==
X-Received: by 2002:a17:907:9450:b0:b73:9be1:33ec with SMTP id a640c23a62f3a-b767153ede4mr4072629666b.9.1764639356658;
        Mon, 01 Dec 2025 17:35:56 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a5f979sm1352223666b.69.2025.12.01.17.35.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 17:35:55 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso8713415a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 17:35:55 -0800 (PST)
X-Received: by 2002:a05:6402:518a:b0:643:d1b:41d9 with SMTP id
 4fb4d7f45d1cf-64554674b58mr39077615a12.17.1764639355248; Mon, 01 Dec 2025
 17:35:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-vfs-fd-prepare-minimal-v619-41df48e056e7@brauner>
In-Reply-To: <20251128-vfs-fd-prepare-minimal-v619-41df48e056e7@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 1 Dec 2025 17:35:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgir86nTfX8SG05QhTtV-Vghkk-q6RMeiBUb80hSF2+Lg@mail.gmail.com>
X-Gm-Features: AWmQ_bkEH4KtVv3rWZ0mojwSCg3TWfCyYJY1czph-G__-wZNNb5iaLtMlpTROOY
Message-ID: <CAHk-=wgir86nTfX8SG05QhTtV-Vghkk-q6RMeiBUb80hSF2+Lg@mail.gmail.com>
Subject: Re: [GIT PULL 17/17 for v6.19] vfs fd prepare minimal
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Nov 2025 at 08:51, Christian Brauner <brauner@kernel.org> wrote:
>
> This is an alternative pull request for the FD_{ADD,PREPARE}() work containing
> only parts of the conversion.

Ok, I'm nto super happy with how thsi all looks, partly because
there's been a lot of conflicts.  I don't t hink this was well done,
with multiple different areas getting cleaned up in the same release.

I considered leaving some stuff entirely for the next go-around, but
I've taken it all, although I only took this smaller version of the
FD_ADD().

Not because I think anything was particularly bad, but simply because
I feel it was too much churn for one release. This is all old code
that didn't need to be changed all at once.

Please don't do this again. We're not in that kind of a hurry, and
hurried cleanups aren't great.

Also, I don't love your mqueue merge resolution with the cast to
create the path argument to dentry_open(). So I did that differently.

That said, I don't love mine *either*. It all feels a bit hacky. I get
the feeling that maybe the mqueue case should just have used
FD_PREPARE() / fd_publish() after all.

Anyway, please check that I didn't miss anything. It is entirely possible I did.

             Linus

