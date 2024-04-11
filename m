Return-Path: <linux-fsdevel+bounces-16732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3588A1E8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5041C216DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 18:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CCC146D6E;
	Thu, 11 Apr 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TwQEVjBB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8266F145345
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859280; cv=none; b=Wq2gj9EBEy8PFWAMBUNPGfAmvFj4FM45KdS5GX76bLIAaLucDiIV3Ma0Lar69wGzZI/P0knnuTRz/cArVcL6YNqeqKwMqs/LmmVKlvv2UGSx9Q6azqxHcDjiLYwnGXFmB8vrSlfeTcz3tWIQJ3nZZYuO8Xfr68IOto6mxCuA05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859280; c=relaxed/simple;
	bh=DybY5geq/NnjXSSLgHJhlnzwn1nIcKVs1t5wzdMrvQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mX/784Y5zwAclkZgTbS2N6fZzdkFubuGuq82mI5B+Kt4yPHKRZSeDUrMgkibe1JeF9K/XHIvPLm3p/EqNy3BEPQMqk7vufeWPxJ9sUEHbMA76wIGYEKnkSCyVEDkjBGTA9H71ac6/2JtOnTj0cA7nzbEj9IAZZMJN0h1thfGv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TwQEVjBB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so2065720a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 11:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712859277; x=1713464077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHBaBIUoFklBaMtTfic4+fLd2+2/fo4UaDmh0hhFoUI=;
        b=TwQEVjBBaliWrLPOyOB7xjC6pYIU1S7rSx6GIMa3qP4kHqPw/TRP04c7qK3SN906iP
         sUz9fZ3XtTXREWDIfTAhPcn0UaoEXkvpO1hDayYM/vSOE/wsvfG8O23GezyBhLLHXGQj
         IxbZ6AKjIUl7cC1fysp0KBhHg7T1bf/jfMD5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712859277; x=1713464077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHBaBIUoFklBaMtTfic4+fLd2+2/fo4UaDmh0hhFoUI=;
        b=GwaBW8M5bsSxHYNU9uVwtLL6VLLOvrE+mdYvfgddU5ghvVzWAMlJivfxhT7PxkPw5q
         Y9VqdYAiagPbB6OUxLqa14yZyq83jDQ+sMMOodUkXXHCi+VsHZJGC+yjhX7Go6palUJQ
         ACmmpjm+CKaIybsXZdvWytrSzTD/aTwr2O8wZbwCtDkD6ULltcOUeGol8OblLIGcGheg
         BEx1kOHI8o8Po03dQV4yYTb00No4+WLVs6Qm9Z9QvZXDdTpiFwMsL8K3QOHBF3b8T3k6
         hd3MInejl50MjntNmq15Ll5R4ARw7b8FfpBi9WSgYgsoZK1mzuDhJbJbcfEsNeZd+U/k
         OJVg==
X-Forwarded-Encrypted: i=1; AJvYcCUVPA2sxRr555+Yw4esERbLomMhEEp8L5e1+pFlbT1mSPYqzDgK03icxCs24Z4XqNcVAIbqDfM2DHdzbGwP8Kn1RLieTscnWmmNYNYPrg==
X-Gm-Message-State: AOJu0YwxjI8RIDdo0/1mWV2W/pQBj6p0WYv8SxCl9a8fOKDHb8/z9jVZ
	OSlG1fmjd+4n6L32PONPKfkiqtg6yKRWNBGlTkBukBxnivEjut82S7x+aTeMFZOJC/ZnuEDTcLO
	zvsOBMQ==
X-Google-Smtp-Source: AGHT+IEqX7vShm1zN6WwyVB1J0LOSpK3y8ZZuuO9du3jLzqROVH6Ta/qkxhTO75MPf32dGowa2zrnA==
X-Received: by 2002:a17:907:7e95:b0:a52:1086:5c7e with SMTP id qb21-20020a1709077e9500b00a5210865c7emr451925ejc.24.1712859267072;
        Thu, 11 Apr 2024 11:14:27 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id qc28-20020a170906d8bc00b00a4e9cb0b620sm974662ejb.158.2024.04.11.11.14.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 11:14:26 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so1826665a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 11:14:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzOxK5c1qkf0/SyMT5FRwQs3PAIbdksbUuYWMiwRkfqR3cCnwFw7x3Plt040uXvnRU4RykC4+6kIO/mS77r7dVGlos8qtYmJKf/8B+dg==
X-Received: by 2002:a17:907:9450:b0:a52:1fe5:d1bb with SMTP id
 dl16-20020a170907945000b00a521fe5d1bbmr2535657ejc.11.1712859249933; Thu, 11
 Apr 2024 11:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
 <20240411-alben-kocht-219170e9dc99@brauner> <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
 <CABe3_aGbsPHY9Z5B9WyVWakeWFtief4DpBrDxUiD00qk1irMrg@mail.gmail.com>
 <CABe3_aGGf7kb97gE4FdGmT79Kh5OhbB_2Hqt898WZ+4XGg6j4Q@mail.gmail.com> <CABe3_aE_quPE0zKe-p11DF1rBx-+ecJKORY=96WyJ_b+dbxL9A@mail.gmail.com>
In-Reply-To: <CABe3_aE_quPE0zKe-p11DF1rBx-+ecJKORY=96WyJ_b+dbxL9A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Apr 2024 11:13:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuzUTH0ZiPe0dAZ4rcVeNoJxhK8Hh_WRBY-ZqM-pGBqg@mail.gmail.com>
Message-ID: <CAHk-=wjuzUTH0ZiPe0dAZ4rcVeNoJxhK8Hh_WRBY-ZqM-pGBqg@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Charles Mirabile <cmirabil@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 10:35, Charles Mirabile <cmirabil@redhat.com> wrote:
>
> And a slightly dubious addition to bypass these checks for tmpfiles
> across the board.

Does this make sense?

I 100% agree that one of the primary reasons why people want flink()
is that "open tmpfile, finalize contents and permissions, then link
the final result into the filesystem".

But I would expect that the "same credentials as open" check is the
one that really matters.

And __O_TMPFILE is just a special case that might not even be used -
it's entirely possible to just do the same with a real file (ie
non-O_TMPFILE) and link it in place and remove the original.

Not to mention that ->tmpfile() isn't necessarily even available, so
the whole concept of "use O_TMPFILE and then linkat" is actually
broken. It *has* to be able to fall back to a regular file to work at
all on NFS.

So while I understand your motivation, I actually think it's actively
wrong to special-case __O_TMPFILE, because it encourages a pattern
that is bad.

                    Linus

