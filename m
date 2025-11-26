Return-Path: <linux-fsdevel+bounces-69849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB09C878CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 01:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C4C03532C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 00:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4741611E;
	Wed, 26 Nov 2025 00:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QjUsYgev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6971FB1
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 00:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764115542; cv=none; b=Ko7+ILpmPKtOS55Zim1juMTP6iGM28FnLJgisqnneELWkHhBdSbBk3cpMyrePzOAwxZC+cHElheae/cN6ieHS19N7MHpMFL8kCptqAsfaNtY/nAJYzZvq6aoaCbDVpZPS3XxStdf1cmqLotv7cQAmzthWro/KbyoAnuuCtg8Onw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764115542; c=relaxed/simple;
	bh=IWtKHfX36Cte44sr5orebBMWVyajN1IGqiZKhGdcEyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osFiPJNewjsMpMdXgME/kozKK5LQdsUGdJDFkL8fT4Xy+m8wkLjEKgsKBtlMgB/CYDzLlffCyQ7LUvri32fAHEyeHRAfQrVLHJm+tIvLYMJZyLKdikOfW9N/qnmUZI1V8Yxcwk5Fp7rhnxg86wwdYobPbvn+6+i7WxbHkD6g904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QjUsYgev; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b728a43e410so1071214566b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 16:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764115538; x=1764720338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b5/Zp9XMM2UPva6EZS2G85cTitA/7ROGh4awJTXNrK8=;
        b=QjUsYgevM5G7Hkr127C/TjfhpKkscaUfrbr8yTl/9daGFY8Nzcct69Urd5efa1a0RY
         TIFqNwX2nd3UK9wWZC3/Fkjqdr+H58c05ALBp8dhDDTHZveQdkwepzYBi0+XkxR6EWIt
         S8LoWX0b9FhvI2LoaptNbgcrSdL2SJp4Qwen4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764115538; x=1764720338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5/Zp9XMM2UPva6EZS2G85cTitA/7ROGh4awJTXNrK8=;
        b=BRfPFjDyYofr77fswZUYrXUlj4i8jXXRrF+aqAZQD01um8azPg3Mc+UO0RVknyqebE
         HxhKxGeyxqyut+DL3TVFNvPQ2zy6xB7/CYvUeAM91um4WidpDY53KRO5cD5K5dQsm3+V
         v8gFrSPXuqqlBoCjAQV7PlX4II6AqviUz3IUnJTfKez7b2lgW1fn4kCN37544gL3vZA+
         iY6FT/wpmuWMdKArbpj9V0DYGbo+QcZQLHHA1QMdPdHA5c4yBRdEUIifCS2bAtgnFN8X
         YnXt6oPRdYQ0MjZR2WoEsYkGhwJgoFsI4HmyE6XNmLBhj9yoNp8o2bMzf4fF4REO/k+C
         csdA==
X-Forwarded-Encrypted: i=1; AJvYcCWsqyaYjD/xkuKn7EPo+GV4aeclMDepZL7SPookndQ4qqHpcT+LnE0f6HHXjts5B6u3/DGEJfe1A2BkO/G4@vger.kernel.org
X-Gm-Message-State: AOJu0YwWQd7qiFGTcS11XwRQT1Wh93dVTdiHHkptpor9st7d1VffAlHs
	oupx37VgjcJPfhriQFqfovigP8HFw33k4RJtBNZH8jbmSr8SB4U8f5tzut9t00oS3G4YK4hQ9td
	NdYCTao7MTA==
X-Gm-Gg: ASbGnctGmMoQKaD/32ih24J0hvjJfcl0mwwINeYC6Ot5mJi8yAxUzT9ruDAcoc6XBay
	xjmPZo8Ie1S3G9yMLnJUqzgREnvRzZsH7UBD13rgPJLJBumYcMkA35AaFoJ/ei9P0HLAUED6Kg5
	8L//C2UWX1Bpr8IP+EDFK2yrx0boyrioD3YbebCuyXNBqQ2DaRw8JTVo1KBfUCcXgyoIwj3gbgX
	QL1NxiWTSVqLgm8uNsmxDez+EqnjaM4YXmR0WLm7QtcjGTjnLlWqWu9hsIGr4VamHn9ENJDBT1N
	FoWQsACCoijWspQyGJKBSHMuHGd4DnGhuqLkkdaXCtP/ovusqBO9QzfOIGeChRJIBNoqIIL5C+i
	h/IpojACO0kHkzHa0HJdY5QPhML7Km6iHfqojuX0/BECGq/LKsP7BeTvEvYmp5+rP+OPlLKLHSB
	60ZbAMVPFrp+QB8/i0RWA0FPBmrwfsEOlA5MvOnHtoDmcA3k8b04lpbuBKcjpp
X-Google-Smtp-Source: AGHT+IG9qfa5MiP26lM03PE3MEkEi5UaewEYz1CPx7RJFMmIvBXdMVteh4UJ2R4Z+RmTfvmYcHmh3A==
X-Received: by 2002:a17:907:1b28:b0:b73:6f8c:612b with SMTP id a640c23a62f3a-b76715653d5mr1847846266b.16.1764115538217;
        Tue, 25 Nov 2025 16:05:38 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4275sm1664481566b.37.2025.11.25.16.05.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 16:05:36 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so10230364a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 16:05:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVg7M474gGKTUjFouwKD84iHDzEpff8GSAigQiEC62JmluHgLPpSH4Ih5sQts0Ty6l37OYVzAkKuwQncI+3@vger.kernel.org
X-Received: by 2002:a05:6402:4313:b0:645:d3fe:8c57 with SMTP id
 4fb4d7f45d1cf-645d3fe8d77mr7881165a12.18.1764115536011; Tue, 25 Nov 2025
 16:05:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-22-b6efa1706cfd@kernel.org> <c41de645-8234-465f-a3be-f0385e3a163c@sirena.org.uk>
In-Reply-To: <c41de645-8234-465f-a3be-f0385e3a163c@sirena.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Nov 2025 16:05:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg+So1GE7=t94ejj4kBrportn2FGzOrqETO5PHVLAzh0A@mail.gmail.com>
X-Gm-Features: AWmQ_bkIeRFT-qxrQmWZBaCh_Rip3xXHEmn8IBKWozki_MwmDXTWaJPJ_L9Bai8
Message-ID: <CAHk-=wg+So1GE7=t94ejj4kBrportn2FGzOrqETO5PHVLAzh0A@mail.gmail.com>
Subject: Re: [PATCH v4 22/47] ipc: convert do_mq_open() to FD_PREPARE()
To: Mark Brown <broonie@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Nov 2025 at 14:30, Mark Brown <broonie@kernel.org> wrote:
>
>
> It's not clear to me if this is an overly
> sensitive test or an actual issue.

I think these two cases are both "error handling done in a different
order", where the test expected to get EMFILE (or something like
that), but now the file open is done before, so it actually gets
EACCES.

I'm not sure it really matters, but the old code did seem to do the
file prepare first, and the

        path.dentry = lookup_noperm(&QSTR(name->name), root);

afterwards.

And while I don't think the order *really* matters, I do think the old
order was better.

And I think it can be done that way.

So Christian, I think the proper solution is to not do that
"dentry_open()" in the FD_ADD() after doing all the other prep-work:

        ret = FD_ADD(O_CLOEXEC, dentry_open(&path, oflag, current_cred()));

but instead make a new proper "handle_mq_open()" helper that does the whole

        path.dentry = lookup_noperm(&QSTR(name->name), root);
...
        ret = prepare_open(path.dentry, oflag, ro, mode, name, attr);
...
        return dentry_open(&path, oflag, current_cred());

dance, and then do

        ret = FD_ADD(O_CLOEXEC, handle_mq_open());

so that this all is done in the same order as it used to be done.

Hmm?

I think the same thing is true for the other failed test-case.

             Linus

