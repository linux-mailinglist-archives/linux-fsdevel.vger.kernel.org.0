Return-Path: <linux-fsdevel+bounces-18684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEE98BB5CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 23:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3842866F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 21:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767535BAD7;
	Fri,  3 May 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I041ed7w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ACB56443
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772038; cv=none; b=V23l34kdNfaH16q4wnisNSBQMfr6yer77SHp+vbv3sM8dUyH52i2pFtuBSudz2oUZK7XhJ6Cs/yE4CKZPbCjQkfcDdyDWbEgwFY3DFBoc9w/R2gNlErGreUoibrxT9BImlrNCrZHaiJDQipbstNoz5KRwt3nERp0rTp/sR0rosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772038; c=relaxed/simple;
	bh=9Qapmfzm6lSNA1KjLLEHmaWSypEB5MZ/Duccomf7UwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbVzQVh1SznxwWGKLm+C9srm60jsrAY6sEzt/M36TXGVwNej9QkmC2cbqoAP0RMb8b+Wu7jFmccXaaYKWQeg13mlzy5kSH7cW0rc3K1UTeaJsx+KeGTbCcFCsqBPxzha6xd7NiSVvyq3sHZRnoNaA/x+Hp//bhxMgsgJ0gPrzH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I041ed7w; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a599a298990so13924366b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714772035; x=1715376835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H0cKj1/eeDlsag1nYyx5cuj3RktPC8YvvhuCxa/6SIc=;
        b=I041ed7wq74EqHv+lLpw/4OnY1kI3FzQ0ynGOUp7811sa7ORamvQCjH55bC3YnkSar
         Klx1rhzeK82r5sekSRH+Cic3Wo0satWx94LLNP051CXWwirSPCCliSE8FVQHfxNUSvej
         uk8KtcOJLyEkqe0pyZgWuEHuRw49MMa4Hn1p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772035; x=1715376835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0cKj1/eeDlsag1nYyx5cuj3RktPC8YvvhuCxa/6SIc=;
        b=dfGHI1j9Hn5Zjtz1+4yfG0crMtWFxKdB1Wmy4OBXnCGsJUqI5zhO6/GTFnsGddp0Ei
         jsQ5nWSMYVcvUN1eneNmSlvlhtjvyHuHQ8lyiLg8tCTqALFY7sXXE53JHI3IIytv6hHB
         Wafly4TJBl4OTT3jmHkruxhgkWHytR56s+UHRxDBLmDJw75tXm6Ck9ODJkxoQ6cwP6qk
         stOjo5yyOg06JeLWj+ytIKufDQerajq3d034HwPnZ103qzmZXRb0NFLyTMgTIm0zWafC
         rvu2g8jsUM71RiVRkBdYsA9YekIgmlwEEEqY3OZ7QLs6cxJzf13d5JijslNzagGj6S1m
         rEwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4JteynAeC7sQsGZ32He7b+5klems6DbroQQ0zFkyCKS3BNbCAZFqGvLluD49jvrCT9Pvy060hAmzU7WUj+DikE3lJ8YaKGQ9hoOOwPg==
X-Gm-Message-State: AOJu0YxT5IaGbn2kiX5HFyxX8fQC2iPJteJRXSK4oMNjv89wKLAuoLrV
	QzKYtA93nOsD7swm5NUxt/uxJukh1YJldZrv9DnFham1WuVZq/JXTRyhibeFt+oh7UQ1GeJ8Ajk
	fK6P5mw==
X-Google-Smtp-Source: AGHT+IGY73jqj3/lrK47VXOcwSDBVx+B2Hyh5/QtB6hOwEZkD5bf9349sGAcFwP1qu8vBtUnH8OzTQ==
X-Received: by 2002:a17:907:1b06:b0:a59:99cb:d862 with SMTP id mp6-20020a1709071b0600b00a5999cbd862mr2001402ejc.39.1714772035570;
        Fri, 03 May 2024 14:33:55 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id n21-20020a1709062bd500b00a5995f61081sm987266ejg.190.2024.05.03.14.33.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 14:33:54 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a598e483ad1so13919766b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 14:33:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6IMKZcTvV28xoJMHqWjA0CgzINb5KXzU7XauNBrKP+MbsW+oUoNYjH21d8nxKn1prohHYx4YfL6osIx7weIPhpRB760g5YLzA7S1/xg==
X-Received: by 2002:a17:906:2c50:b0:a59:761d:8291 with SMTP id
 f16-20020a1709062c5000b00a59761d8291mr2183947ejh.9.1714772033952; Fri, 03 May
 2024 14:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV>
In-Reply-To: <20240503212428.GY2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 May 2024 14:33:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
Message-ID: <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: keescook@chromium.org, axboe@kernel.dk, brauner@kernel.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 14:24, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Can we get to ep_item_poll(epi, ...) after eventpoll_release_file()
> got past __ep_remove()?  Because if we can, we have a worse problem -
> epi freed under us.

Look at the hack in __ep_remove(): if it is concurrent with
eventpoll_release_file(), it will hit this code

        spin_lock(&file->f_lock);
        if (epi->dying && !force) {
                spin_unlock(&file->f_lock);
                return false;
        }

and not free the epi.

But as far as I can tell, almost nothing else cares about the f_lock
and dying logic.

And in fact, I don't think doing

        spin_lock(&file->f_lock);

is even valid in the places that look up file through "epi->ffd.file",
because the lock itself is inside the thing that you can't trust until
you've taken the lock...

So I agree with Kees about the use of "atomic_dec_not_zero()" kind of
logic - but it also needs to be in an RCU-readlocked region, I think.

I wish epoll() just took the damn file ref itself. But since it relies
on the file refcount to release the data structure, that obviously
can't work.

                Linus

