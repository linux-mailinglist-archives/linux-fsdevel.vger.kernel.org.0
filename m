Return-Path: <linux-fsdevel+bounces-41329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 364D0A2E003
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 19:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4571884385
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 18:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642E71E2310;
	Sun,  9 Feb 2025 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c45SxwBR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C21DFD86
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739126784; cv=none; b=I+fSs5hxxxfqH236qdN8eroAm3/iQ1k+h7RbLtr6Pl3cXayVBErGv51DAKVhn82QT1idB0LyzuUwweii72ahaNHZI3swD6PuNiJ0IOvmf0iuFwQdpjwZ5kOI/+qn3yMrNRLzluf6M42oIQIWp+0tgfon8UoNbuivmgo/lzwN1Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739126784; c=relaxed/simple;
	bh=Z0exPwYpyB309Go0LJdY5JTDAMje5GwGG3TVn8LyKTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drlzQxJPzdjtW/+ZoFLGwP5xV+V4j5ETTurcTC33xVtkx+IvnUEEw2PsdeGDxixFvHmewz5Tp9FyKU6DwIaqMUSEZ5rY2WrBhcIOGABkPs6JbeY2pZHdb7Ctbr0/Rz6QknnmuN0Ljaf7f0fObEvM/tx0p4CwWfZSY1CjGI/UrjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c45SxwBR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5de6ff9643fso1147950a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 10:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739126781; x=1739731581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=299OX1xBTdJBPWgTGDe6mblBfhAuT0bmyryb6qbXkF0=;
        b=c45SxwBRlxbUxEzSqWlcn0vcqS9BB2XZtcgBA8G9XJqfkOu1ZMqz34LQuzFlvpBJGJ
         SpdbcS+AwaoizCSGiD1w6QQpQS01o5LGs+UUwUWX1AMl/rRbtiAXuj5lpycvG+n6gdnU
         xoq1jzwGy081zLVGqj8yHxIInW+yNBBkz339Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739126781; x=1739731581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=299OX1xBTdJBPWgTGDe6mblBfhAuT0bmyryb6qbXkF0=;
        b=ookpsxvFTOiXGvQKKqu3NvBUlv4vH//WVV0qCTJ/Jp9lP4+rAWf9x6t09+Ha22daY4
         YRgqwIaJDtqM6H5ZCjlaByoIvSxzfHY6sYr717xo2mIdGWMUnVq5QKCmM4fchdZ4p3bu
         UqVRRivrCzGLRR+Qr+OqUpigjqrENjbEhXz4YU/ZrX2itHed6luGzY9pBPd2u3CUeEH3
         mEGsPt96JVxZcFaL9TnAS93GvMeWcKKuwZh8zjkTRf62VDGoWoolLhS0qRnvb6cQsCLe
         /9QXfcWTcSQx/UQAbrb1/nU6BfADDESUrUYRWpk/odBD+NpqbBWNL8ZuZFFPGnKE8KSQ
         tBKQ==
X-Gm-Message-State: AOJu0Yy1CZ97T+6fSDvVTtB94NYM/oZvi6aeZTuFq74Uou6mqeCrVOP1
	4EKXs2eqIQt23os5zqya7cO5g+6/n+9pC6O6nkOtjPobWgbJDb2NBoAq+mOgstim8gdDilSDX9t
	IO1w=
X-Gm-Gg: ASbGnctJjnQmP9/Xbt+2oEuEa0VYb5XMfoOfE/qv6t02Kx/UWO+iSc4CdVjsyDQaPzc
	aFKJi8V+QZD/ySL/9WXcLc4QMobYu5broRjoD5jG/csnVsZglMr4m8pCsK9iI0KeEwdTOZqnhqk
	1I7DSUTkrD47UjPeIiS37+7TaV7LqMP5dDnLnzZTrJ1W8QMeqaSmWPve9Xd6lbvyL0H9EDzDmP9
	i1G4JO9L15UTxFRtAUo9sfbujHQzp8m88EZXANJ+OA7/D1lWPtkNXQ4pt5DX3x3MTw4bQuoXMJ8
	dSU1wAxauGw5RTo9lBxybyyfan5fCZGrOndxBTgaT+d0NAoZ/+PQLscIxrdYKFQBeQ==
X-Google-Smtp-Source: AGHT+IHVkPx+yos4srEr3W8+6ttBOTOtaG6rzVeLHtOBeJLx7RfAR5MIuGTqdrO2toqpbTDJ0FijkQ==
X-Received: by 2002:a05:6402:5413:b0:5dc:cd96:49fe with SMTP id 4fb4d7f45d1cf-5de450b0e93mr9483205a12.21.1739126781056;
        Sun, 09 Feb 2025 10:46:21 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de6e5880b6sm1835282a12.37.2025.02.09.10.46.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 10:46:20 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaec111762bso897311066b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 10:46:19 -0800 (PST)
X-Received: by 2002:a17:907:9726:b0:ab7:5b58:f467 with SMTP id
 a640c23a62f3a-ab789c629ffmr1156201866b.40.1739126779662; Sun, 09 Feb 2025
 10:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209105600.3388-1-david.laight.linux@gmail.com>
 <20250209105600.3388-2-david.laight.linux@gmail.com> <CAHk-=wgu0B+9ZSmXaL6EyYQyDsWRGZv48jRGKJMphpO4bNiu_A@mail.gmail.com>
 <20250209183437.340dcee6@pumpkin> <CAHk-=wgkEDmf7V+F5jP6On3=pEewRYGbZyvs1E3K-3n3HYr4=Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgkEDmf7V+F5jP6On3=pEewRYGbZyvs1E3K-3n3HYr4=Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Feb 2025 10:46:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjv5x4ee-nKLfwoYwgJ9OqBkd+wqGn-dgWpHdpA2oZqqw@mail.gmail.com>
X-Gm-Features: AWEUYZmY_webv9q8a6uZQUIkEL63ugKdCcPkMcgteGn1w1zExAU2n4DAjnsukHg
Message-ID: <CAHk-=wjv5x4ee-nKLfwoYwgJ9OqBkd+wqGn-dgWpHdpA2oZqqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] uaccess: Simplify code pattern for masked user copies
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Feb 2025 at 10:40, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's *really* easy to miss the "oh, that changes X" when the only
> little tiny sign of it is that "&" character inside the argument list,
> and then the *normal* mental model is that arguments are arguments
> *to* the function, not returns *from* the function.

While I'm ranting, this is just another case of "C++ really got this
very very wrong".

C++ made pass-by-reference really easy, and removed the need for even
that tiny marker in the caller.

So then you really can't even visually see that "oh, that call changes
its argument", and have to just know.

              Linus

