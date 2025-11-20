Return-Path: <linux-fsdevel+bounces-69330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D5AC76946
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 00:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 901624E4332
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028392EA171;
	Thu, 20 Nov 2025 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SSSw5Krf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F962EFD9C
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763680150; cv=none; b=KtHVkt+dJnbf5bQJXx3eVnIy4qBwm7b7drdTR0F+/71Xz+5ArIOkBm1nz/jqy/1sz2gQ0wabI47EYvnDIYStJnywWUkIjoo2hD9o4gPTpZQVa+EjXzoARBroQeDl9w9lOtHvh6nqopjE7GwMTBKqCQP51s0GDhlhlEBPPoqhiJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763680150; c=relaxed/simple;
	bh=TKnw+OoeFXKrSIMOkDLLXN8wfsBqkPiaZwhXse0nKiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/e2K2Li1qUceh41IWcN47Ojc7t+OGbXyqFCOnpxPPLHYnq9tR19ScjXxtHV/DE6AEmv0W6HYybkJM5ASo2mlAi+I6SZZe/gCnPUQWUF8GJlfHpBU7c3WseoUBb8ZM6mkUtEe4/MWNR2KYopB5dHyEQO6MLMYrgpmxz53mVbQjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SSSw5Krf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b736ffc531fso219884066b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 15:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763680145; x=1764284945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nd0tv/L5fCexSxeIvmkzK+SbOnMMqlQT0pF+PJBx99g=;
        b=SSSw5KrfXLz4RfSkCiMxPrp5GCY3XwssoY2KGJy6pnYAZ4myEa6k1e6qF5+M2Z9s2V
         Ybf3D36mEVV3Di8e9g0h4TDWWX75N3IqLksWxbuM7kk1nXVErf2d5dhPO2ehAOeux9+W
         b9EorJmlyDHoGEtqIcUG4gn76laVo38+gviLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763680145; x=1764284945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nd0tv/L5fCexSxeIvmkzK+SbOnMMqlQT0pF+PJBx99g=;
        b=rnDGYTBNni9iLVgM3yYh3WmBLnHw79M+4/BRDjso2o7Te1KUMS3LLM/wLSsViZkXgi
         CnnAN08kt7eVO0GEAfDsSJAOpT9SrRmoa5OsPAQND+CPWARqqK56ZowD5w9ksLSKtulf
         +oe/UTi+OqH+MqDbjlnImjc9pc+cuwYjXCCh/OvLVDENFrUnWH6av10qTXpYKOZnWatc
         z6PqdqNFLpD8yZ2dxGWjMabrVaMftpsteFhPbSWhM9VeT8jPDPQ80bHEYaYYCwya8gog
         PI686YkQ9AJCPJNiw5lHcvEEn58qbajA51cFFFIrXqFiJNPnTwpXplX2qlEBRrxvuDAM
         FRHg==
X-Forwarded-Encrypted: i=1; AJvYcCUxUAfweMLwXDog447dSe8DozrmkZJS3/C90VVXTnI+WR0AzynJWMq2v/J4pbmS3Z3k0ZHDT7r8RM5SBPS8@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZVJN9Rzu/VTSTH61w9lzPLsFCPuGc6parL8SE42OG+3/GRmV
	5+lNQ0zQ9KmxWRYZsj+eoMGA6MNlvxYVHOaYgfYGiMQRPS+B0mNLF6QrQququsxJsCZ2aw2Oa4C
	cCo0tFkdg6A==
X-Gm-Gg: ASbGnctEHRos7QHkejClc7Dgi1U6lr/ytPJUnbogNkhCZOdX1N2+RvbAUTMKzoBEosk
	UA2jr0QNug8Mz0kHIgcIdv6VBXYir+kDq87w8Cqp8dnTYeGtieZELKZDBBz4jw1tkRIAjCfFqrJ
	X+GIN03m2EIB23kTEsjSfIvuKHS2ycWQQJZ0SugUuds9OuK1/iQbkuJrLt7fxN2FeXq0zSxnHIw
	lcAVExz4TEqu9sYrmmi7quixj/kCWF2BbV2o7tjT2LeYdN6Q15mnpUpWR9V4lSGHykXz4I9u/Wx
	yNQaIUKXYXJfBm+lGQrz5B+OcXnzmagMJbqqdXfMC3D3+N5G9eO0+YjLXoHTCjFmmhsur0DoJtb
	dXCzKO59U/xmzrDR/maQz54pOhaTJMk6El/lpmCFH0FlTwfzYLFE/s0Yss1VprmPazglxxl4sax
	HXhXqO7kZqU/PG+vlNd4nrLV2q2HnloUyTcMYeizUCYT25+hRGrAv99VI7g9fk
X-Google-Smtp-Source: AGHT+IHweIRyUaN1R1Pe76i+TliaNEOInkTL7NBxFI63D5aSYhiIrzVm5fluoQ7D6ZbUynGBHe3Xcw==
X-Received: by 2002:a17:906:dc90:b0:b04:c373:2833 with SMTP id a640c23a62f3a-b7671695555mr2445266b.32.1763680144852;
        Thu, 20 Nov 2025 15:09:04 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b765502840csm304927566b.59.2025.11.20.15.09.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 15:09:03 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b73161849e1so373371466b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 15:09:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6Uu0W3LxlQqTrZkkXqBqhmynCKl2vHH3OBj++g3GW1C/tc/C/cmbnRYnRCqioEiwPBlsNy8TV7FI8r57D@vger.kernel.org
X-Received: by 2002:a17:907:9618:b0:b73:6495:fa91 with SMTP id
 a640c23a62f3a-b7671547e9fmr5323766b.16.1763680143091; Thu, 20 Nov 2025
 15:09:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Nov 2025 15:08:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg+61ucgtDpK4kAL0cpNi1pk-t6=hTWumbF+L7b4_pfTg@mail.gmail.com>
X-Gm-Features: AWmQ_blWme1kiGn6EN4-PgsxVK1iEinPS6vjF76rAIjMZbQcYxATSCKbnCGYgpc
Message-ID: <CAHk-=wg+61ucgtDpK4kAL0cpNi1pk-t6=hTWumbF+L7b4_pfTg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/48] file: add and convert to FD_PREPARE()
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Nov 2025 at 14:32, Christian Brauner <brauner@kernel.org> wrote:
>
> My take is to add a scope-based FD_PREPARE() primitive that work as
> follows:
>
> FD_PREPARE(fdprep, open_flag, file_open_handle(&path, open_flag)) {
>         if (fd_prepare_failed(fdprep))
>                 return fd_prepare_error(fdprep);
>
>         return fd_publish(fdprep);
> }

I'm really not a fan of the syntax.

The scoping in particular makes absolutely no sense. The fallthrough
case is just a silent and very non-obvious failure case - I don't
think there is any sane use case that falls through. You *have* to
basically end it with fd_publish(), nothing else makes sense, but it
means that the whole usage pattern effectively *has* to be that

        FD_PREPARE(fdf, flags, something()) {
                if (fd_prepare_failed(fdf))
                        return fd_prepare_error(fdf);
                ...
                return fd_publish(fdf);
        }

and absolutely nothing else. Yes, the variations are of the form "do
extra cleanup of other things before the returns", and some of those
are then done *outside* the scope by having other variables from
outside the scope, but it all feels really nasty.

And so in most cases, all the scoping does is to make for an extra
indentation level - it doesn't make the code clearer.

The docs you add in 01/48 are showing some other syntax entirely, ie
the comments say

+ * FD_PREPARE(fdf, O_RDWR | O_CLOEXEC,
+ *                  anon_inode_getfile("[eventpoll]",
&eventpoll_fops, ep, O_RDWR));
+ * if (fd_prepare_failed(fdf))
+ *     return fd_prepare_error(fdf);
+ *
+ * ep->file = fd_prepare_file(fdf);
+ * return fd_publish(fdf);

and that non-scoped version would actually be more legible, I feel.
But given the implementation, that's actively *wrong*, because it
doesn't do the scope at all. The scope silently ended at the
FD_PREPARE, and I don't think that example would ever even compile, as
far as I can tell. You need to add the  { } around the block that then
uses the fdf. No?

And I think the reason the docs are wrong is that the syntax makes so
little sense.

Now, if the whole odd sequence of   FD_PREPARE / fd_prepare_failed /
fd_prepare_error / fd_publish coudl somehow be encapsulated by the
macro, that would be one thing. But this macro forces that really
stilted and odd format for the code that uses it.

Admittedly then most cases do pretty much *only* that minimum required
pattern and absolutely nothing else, but I feel like you made the odd
syntax choices for the few cases that wanted something more, and in
the process made everybody have that nasty thing.

And yes, the code that uses this ends up shorter, so you do remove
more lines than you add overall.

But I really wish the end result wouldn't look so odd. This is a case
where the scoping seems to hurt more than help.

                  Linus

