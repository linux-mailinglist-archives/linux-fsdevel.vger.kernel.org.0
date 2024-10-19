Return-Path: <linux-fsdevel+bounces-32427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC239A4FAE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 18:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446541C2181E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 16:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D6918DF9E;
	Sat, 19 Oct 2024 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OhxqgBUb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC7818CC0B
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729354556; cv=none; b=XMA7c/ZbWpvz8RWNuhXDy9Mk4YGyQlxfc4yAtTCO8T1Gyb45RMa4LaweXd7NvxMc2isBnMC7G7+9Gk9K9CJO0w3BIspc6hwZ8+disgh602pYUlEvFafM3Pnxo7ooKEtH+5t4u+Qjfuzf4b4/shy+bkvTwF3zRssjPJSsGaY7lKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729354556; c=relaxed/simple;
	bh=yT9ZD4FDFuc5x8O3oBEW70x/qCTSWl7WfY4CXZxSuf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scAbi5ApM4TLg4eg8F1lt8kxe8G+jH4iIs5ZdqI0fW0KOkVST0CvzdSJYfTtARKdKoXAUXtNB83tR1rsJDELOJPupUQCaE1OSEE3VupixKy7LZL+JWl1jyvaqhtt6j1EebU0WPgSp5YauRP0CHm6m5+uzrGAaX0PHZAIrvLO7/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OhxqgBUb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso5491613a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729354553; x=1729959353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lCWwJLziMutFuJ2wTIygZ8Rgovdw4uEoMXoh9mlHWkM=;
        b=OhxqgBUbpq4jQwBA+bTpmUtAYCp3pEC6CKH+JzRV05r9nw5JwNARb8hWUbo+Zx0nDb
         8eJuac5Avea1IyQiFBOfDqDY6QbLtmdZrQT6pQbvna1hWdMKAkx8TVooyLyj1jQ+Il/2
         RXdBXr6OIGK/1eluXV3x7MDNiVHEDChFcOEWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729354553; x=1729959353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCWwJLziMutFuJ2wTIygZ8Rgovdw4uEoMXoh9mlHWkM=;
        b=P6rwloodvaJstMZt7Ozdi32UJybjJn2pJZJo2t7Ffrn5P0u0BR4esg2cddHSV4xFf4
         +otdDVGERUxX88xXo1Es9ANTsZ614S6Oy7GCBHSfY2ihOn9/sTtrMmbhGgdnijEMKr3Y
         x0W34T71jKl03MkDWnC+Sk2gD4bUQsWP6u+PIDqzmY8QNJZwFkI/pGPBWhZJ9eduUBRL
         WW84gJnSI/+tbmZVpwcYmLgajzHLrcv1jRft+/+rg8l/vylkJEtXg/a135zTq4CRiEiq
         Nu3qjrHtnk5LlMfuq+aOtN7+FB5F+DOVlXu4r1MNyfDqKbzYMf/EJ0zd2yd7O8uWowd9
         bvAA==
X-Forwarded-Encrypted: i=1; AJvYcCX1LKPv45Yaq29ZOWDPObhg/OKB+GC0y73/W5utn6Ois9qiPqArj6j/cEsG+1EMSORzlPvquJUwZpRkB1Fy@vger.kernel.org
X-Gm-Message-State: AOJu0YzfaGJ9XERjF6z5iRZRZDVqdsN9v4lqoF/hf1TorJ9QW+DMf5TT
	bBJtFVQoAWoEAH4LYnISFPFjeNIjCeF+UIIHcXoUJ5p3fU4SglxJmGZOZJd+uviO2PMwKj2MBO9
	zJVw=
X-Google-Smtp-Source: AGHT+IEaFOQ3bCtdt26ze4khAAKGoL0hgV7m4jz76AqNHEalCBCmuuEmDOt+PBIHB+uzA58OnHiSjg==
X-Received: by 2002:a05:6402:524c:b0:5c9:7f41:eb19 with SMTP id 4fb4d7f45d1cf-5ca0ac790a0mr4035524a12.4.1729354550945;
        Sat, 19 Oct 2024 09:15:50 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ca0b076d67sm1942985a12.10.2024.10.19.09.15.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 09:15:49 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a86e9db75b9so392468966b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 09:15:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9rHcoUQBZkIViFnWshaW0eQ07MLiubm5heGVfpEO/sx8HjK4/xtePM5eKMSNSsAwr+vzx0Cj7LW5Uq8mW@vger.kernel.org
X-Received: by 2002:a17:907:3f27:b0:a9a:5a50:3e42 with SMTP id
 a640c23a62f3a-a9a6996a5f6mr642194566b.12.1729354549411; Sat, 19 Oct 2024
 09:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009040316.GY4017910@ZenIV> <20241015-falter-zuziehen-30594fd1e1c0@brauner>
 <20241016050908.GH4017910@ZenIV> <20241016-reingehen-glanz-809bd92bf4ab@brauner>
 <20241016140050.GI4017910@ZenIV> <20241016-rennen-zeugnis-4ffec497aae7@brauner>
 <20241017235459.GN4017910@ZenIV> <20241018-stadien-einweichen-32632029871a@brauner>
 <20241018165158.GA1172273@ZenIV> <20241018193822.GB1172273@ZenIV> <20241019050322.GD1172273@ZenIV>
In-Reply-To: <20241019050322.GD1172273@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 19 Oct 2024 09:15:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_QbELYAqcfvSdF7mBcu+6peXSCzeJVyg+N+Co+wWg5g@mail.gmail.com>
Message-ID: <CAHk-=wh_QbELYAqcfvSdF7mBcu+6peXSCzeJVyg+N+Co+wWg5g@mail.gmail.com>
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of pathname copy-in
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Oct 2024 at 22:03, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> See #getname.fixup; on top of #base.getname and IMO worth folding into it.
> I don't believe that it's going to give any measurable slowdown compared to
> mainline.  Again, if the concerns about wasted cycles had been about routing
> the dfd,"" and dfd,NULL cases through the filename_lookup(), this does *NOT*
> happen with that patch.  Christian, Linus?

I'm certainly ok with this, although I did react to the

-       if (!name)
+       if (!name && dfd >= 0)

changes.

I see why you do them, but it makes me wonder if maybe
getname_maybe_null() should just get the dfd too.

And then in getname_maybe_null(), the

        if (!name)
                return NULL;

would become

       if (!name)
                return dfd >= 0 ? NULL : ERR_PTR(-EBADF);

because while I'm not entirely against it, I'm not convinced we really
want to support

        fstatat(AT_FDCWD, NULL, &st, AT_EMPTY_PATH);

becoming the same as

        fstat(".", &st);

IOW, I think the (NULL, AT_EMPTY_PATH) tuple makes sense as a way to
pass just an 'fd', but I'm _not_ convinced it makes sense as a way to
pass in AT_FDCWD.

Put another way: imagine you have a silly library implementation that does

    #define fstat(fd,buf) fstatat(fd, NULL, buf, AT_EMPTY_PATH)

and I think *that* is what we want to support. But if 'fd' is not a
valid fd, you should get -EBADF, not "fstat of current working
directlry".

Hmm?

This is not a hugely important thing. If people really think that
doing "fstat()" on the current working directory is worth doing this
for, then whatever.

And yes, there's some argument for returning -EFAULT, but I do think
that "treat NULL+AT_EMPTY_PATH as the non-at version" argument is
stronger.

But the whole "some argument" does mean that I can certainly be
convinced that I'm just wrong.

                    Linus

