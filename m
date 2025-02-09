Return-Path: <linux-fsdevel+bounces-41327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3E3A2DFF8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 19:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2EC1886627
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 18:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA991E2007;
	Sun,  9 Feb 2025 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AwJ+fhYg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DD91D90C5
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739126457; cv=none; b=W/GdAHuS48zrfcdzLA/8Y84vMh5BvqSHWu27FhH41Voat6r2wClHmTK9HN0HCce0bTrl8whro4UlvNp8tWEBml2zPFjbj3i9SGLM7lthd+3IqUXsTD6cY0OullwU3+z7BZInYWCc1EZk3HTrxVDylJbY1ZpmER7pgtEOoMbSKuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739126457; c=relaxed/simple;
	bh=YI94TlVoN4L7wbMAtw/gPyxSKy6RHG6wuVteNjpRsTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5iPXu8s0xyl9f3E83jMjB1U3OjAWt+ZUcF44j4Bkj2P0J8i1kanW0ZlCTefJR/uBXsMmmgQ/l/TzA1gGqB4IvQ1qEhl86MZTQNaEWX6lUdRk2nopUa44cL6jade/ud3SEh6p2IdCUYgFVbUSKMqVcBDMaiMQWN/0Mj5aghoAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AwJ+fhYg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5de3c29ebaeso4019137a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 10:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739126453; x=1739731253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HqEVrPNyJZT2ieX+sAlKjBiYk9DF70TEQ29V5zg8sVc=;
        b=AwJ+fhYg9bhef9lOA7dEuJlNKQGImAGgg3ssViN63+QEoCvrVfdMKDOGZfPL4YjI6h
         lBTfE6VyBdzKRGGzZKVuUaMdyMgwj3z33nbkhYnX14pRhVjK07l8SXzHy+a0aPHvwVNv
         9Nx1EVbbm6wyJ9Uo445wZlMJfe/t0d/s5QFyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739126453; x=1739731253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqEVrPNyJZT2ieX+sAlKjBiYk9DF70TEQ29V5zg8sVc=;
        b=O6MR9b5qbg3nCzROH7hO2bve4eNHsTd5VIR5B1aU2VCein2L2IZDcrgT/YkhrgB8mp
         wpaw3sLjQG09xfFa41WMtaPMSBxNuaHGUQ4yRKmA4x92BdjT5CwEQroq8rfwdQFHeHQB
         J/EKFVjI8M+AdAa/tiJi6lbu/Rv3omx286JqFAXez5aNajLlZMyQJzQkIzzIuV8YnAuQ
         v29fMjHa4tRyPXcMcZSvNWVZZ++jrmCw53LOfgqgQ0jRVKFNkmfwOzVKlVb42zLsRiw2
         5r6gNAC1Gp/EYprv61JipyUADx77N7R0Vqbc/7Av8SBzZk38Y8UXv54OtFmPi13mL3d8
         Hodw==
X-Gm-Message-State: AOJu0YxDjWmXofLq/zkPh1Y/jmmUaFHGSufi1IqyLzBSD7wtuxoXUO+b
	IWtzjOiAk/nHpR674QMwRmSUNm2KYXtx22jwvsGZ4dcwfu3EcHI6Za5P9r8iOnqQ6Fa0hSKf1u1
	+8ho=
X-Gm-Gg: ASbGncuF4MgxBrPrpFxqI+iA2kNGrPm5CvX4yAPswzrue1gMeRDZMJSIwyDRhyOeidt
	dkUBJ0uXdDwK/P79oSpeZ+EkAxsS6totaw2Evk34HUy2hpxQiMAf6Lm5mi9WPIoJ+of+Ui1Kf3p
	IEvROnSAmVVFIqIN1DWmijjQy7y2ZC3swxTDz/UFc+H8Lx8ttUzvOruVwD6vEqYvaRCBxBQEPZz
	fXXYflUuov8fXG9KDVe7vGmq8yi6vYD6mJ9IIT+g70gjUMTSlv0Ps8AaCo6oB5+wF071vbcTSrc
	HndUyf+NQ3p5OTmWqtypBCTZbPJ1O8IrB8P0Wv1s0bx7C8OrhhMr/f4RVxZ+rbIekg==
X-Google-Smtp-Source: AGHT+IEnB+42Qvq2hDWwZhtjNy4DXIt/myMKqagfGPm8+i5EATW7zux2cIDaUKIjqeCtMAHR0p1W9Q==
X-Received: by 2002:a05:6402:1ccd:b0:5dc:1395:1d12 with SMTP id 4fb4d7f45d1cf-5de450882abmr13028711a12.31.1739126453558;
        Sun, 09 Feb 2025 10:40:53 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de5d484c76sm3483390a12.35.2025.02.09.10.40.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 10:40:52 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5de4c7720bcso3505456a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 10:40:52 -0800 (PST)
X-Received: by 2002:a05:6402:4608:b0:5dc:7538:3b6 with SMTP id
 4fb4d7f45d1cf-5de44feb687mr10488960a12.1.1739126451772; Sun, 09 Feb 2025
 10:40:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209105600.3388-1-david.laight.linux@gmail.com>
 <20250209105600.3388-2-david.laight.linux@gmail.com> <CAHk-=wgu0B+9ZSmXaL6EyYQyDsWRGZv48jRGKJMphpO4bNiu_A@mail.gmail.com>
 <20250209183437.340dcee6@pumpkin>
In-Reply-To: <20250209183437.340dcee6@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Feb 2025 10:40:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgkEDmf7V+F5jP6On3=pEewRYGbZyvs1E3K-3n3HYr4=Q@mail.gmail.com>
X-Gm-Features: AWEUYZn28FvwTKBQ3BrTy9qd-ZBM8Lp8EcjEquYp7tN5JTG7g2lPx7zYWLh20TA
Message-ID: <CAHk-=wgkEDmf7V+F5jP6On3=pEewRYGbZyvs1E3K-3n3HYr4=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] uaccess: Simplify code pattern for masked user copies
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Feb 2025 at 10:34, David Laight <david.laight.linux@gmail.com> wrote:
>
> For real functions they do generate horrid code.

It';s not about the code generation,.

Well, yes, it is that too in other circumstances, but that's not the
deeper issue.

The deeper issue is this:

> > Yes, you can make spaghetti code with goto and labels. But 'return
> > value in arguments' is worse, because it makes the *data flow* harder
> > to see.

This is the issue that is entirely independent of what the code
generation is. This is the issue that affects humans reading the
source.

It's *really* easy to miss the "oh, that changes X" when the only
little tiny sign of it is that "&" character inside the argument list,
and then the *normal* mental model is that arguments are arguments
*to* the function, not returns *from* the function.

(And yes, I admit that is inconsistent: we have lots of cases where we
have structures etc that get filled in or modified by functions, and
are passed by reference all the time. But I think there's a big
difference between a regular "value" like a user pointer, and a
complex data structure).

              Linus

