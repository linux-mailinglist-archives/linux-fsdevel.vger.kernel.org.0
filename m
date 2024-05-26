Return-Path: <linux-fsdevel+bounces-20167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C31598CF296
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 07:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CBE1C2094C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 05:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE2C3D7A;
	Sun, 26 May 2024 05:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="evPhrcd+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F3917FD
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2024 05:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716701513; cv=none; b=Nodv4jWJKYZQTwp3xEX+RvIwwRGkKzvfdTuXyZHgLwv12ThOmHFIWWA1rr1U7+HfCXUEf/TqbmhA4RbLjcS+mc90NY5WVIQl8qosdzcDLMmJDE2lv+VAz/scaFhDnOOEyYfs/ow6mYkbKjpo7H9fgJ51bDif1c1nJIGc5FY2Nmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716701513; c=relaxed/simple;
	bh=mpnfXpjAi2fDJsiDaipKOwOB8d+RQ8jngRsgQeS5Ud0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcgjlBlTZdSPEM0T7+NVwL0plAx6wZBMWMu2FohBis63ayo7oslWNtnRNWx/aXu3qpL6ybEFWtBfKrdqEr1HfezYDTExS0iJNaY3ZNy6/nOnq4fCrhT3RtQLLWg5LGtuCEQTzsFrQCKZpz/G6jwpVWlrbdvTU47PxaB3L1H5+58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=evPhrcd+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6265d3ccf7so256047166b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2024 22:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716701510; x=1717306310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QoPb+xb5kS8JqRVBZTvBweTNH2JipcWtH42HkUJVj5s=;
        b=evPhrcd+OcZLbBvCO5JE5ICFukvwLhjhL4U6lcSCeyVtU+gkMMX3WtkzVvzQNsHkVk
         Fz+SVCxVRBKBlNhLbNogaNBkvp9KHf1ZXB5KTaei+cMYrzyHHM05jsZ4TKICJcZrfrWc
         zPn7ham1qoyCj+IgwkkLHQQaFrrFbIz/XB0WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716701510; x=1717306310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QoPb+xb5kS8JqRVBZTvBweTNH2JipcWtH42HkUJVj5s=;
        b=YM0leFG+hHtZZwjvLeipaE2dmQpvaQFFEkPaH/FIXDVqEu1YUihaDgazdawvUPKXbW
         1NoeR8LAflG6aO5g7nw6LohmEA8GvWYrmdcMWqO5t1jVJ9XepA7IQmu4e+EWKEGdku7E
         ZwdRa7OUMBpKnbuPEXtN1CP6meCB7AvESa1bhCFQHnOC6uyCg358zf+Qi1DvwQ7fdWJY
         G+KG8xBJ5qbgodsBdbVcLzDcInpJIb1FJljDAMqc7GAegJhSydnkRIki2sFY+c22RaJN
         eBiVl5tluta0/Zrqrcny0mY1Cm+Bj6Q2hXrPbiPw8bo++optrrf1wgLObhyTd7Oc5H3y
         qEAg==
X-Forwarded-Encrypted: i=1; AJvYcCXZPLM07JNBmels6S8oRPxnr9zsH1nx5eRxYEginrol/w6wwf5PzoNNfv8/1t0urWU3QycgEJ8PO8jaStxTp2ICi5sHBLsmGtDY71xzxw==
X-Gm-Message-State: AOJu0YzALO5caUJOSjmYfpEZRH5KzE8GwFXy4caIoJwdJnVzYCR7Tn5F
	SCXQuS72bhG0PU2aMaGYelH6XhR+Mje0pU7Vf3fBr+7iJlgBcBs5oq/CA2YcMpC8CfUC5lMOnox
	6DIi1Bg==
X-Google-Smtp-Source: AGHT+IHWYlVkDbztmQdEbfXEgBLoOCwEaJ2KFJcKqDmqftTeUraPoKuStbcUdFXubt7uZFhNWB1hcQ==
X-Received: by 2002:a17:907:930e:b0:a5a:6f4f:e54e with SMTP id a640c23a62f3a-a626501ca62mr461310066b.65.1716701509905;
        Sat, 25 May 2024 22:31:49 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817ab8sm333007466b.7.2024.05.25.22.31.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 22:31:49 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6265d3ccf7so256046466b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2024 22:31:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWTv8HQ7lFPSkodI2rQ+j0aOJHiuPFxbB0nanqCqbKaS9ZXGPKIBK+mLWTvMDvHnEOeoMk9mYYuRsSznEfmtTWKwtCiJsUdBfWPpBPrg==
X-Received: by 2002:a17:906:bca:b0:a5a:743b:20d2 with SMTP id
 a640c23a62f3a-a62643e2436mr365879466b.38.1716701508955; Sat, 25 May 2024
 22:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526034506.GZ2118490@ZenIV> <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
In-Reply-To: <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 May 2024 22:31:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1_Sfgr6HsfjsCg_B-5b9sGKuWFpWnkwhdwNaODekraQ@mail.gmail.com>
Message-ID: <CAHk-=wh1_Sfgr6HsfjsCg_B-5b9sGKuWFpWnkwhdwNaODekraQ@mail.gmail.com>
Subject: Re: [PATCH][CFT][experimental] net/socket.c: use straight fdget/fdput (resend)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 May 2024 at 22:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> IOW, we could do something like the attached. I think it's actually
> almost a cleanup [..]

The reason I say that is this part of the patch:

  -static inline struct fd __to_fd(unsigned long v)
  +static inline struct fd __to_fd(struct rawfd raw)
   {
  -       return (struct fd){(struct file *)(v & ~3),v & 3};
  +       return (struct fd){fdfile(raw),fdflags(raw)};
   }

which I think actually improves on our current situation.

No, my fdfile/fdflags functions aren't pretty, but they have more type
safety than the bare "unsigned long", and in that "__to_fd()" case I
think it actually makes that unpacking operation much more obvious.

It might be good to have the reverse "packing" helper inline function
too, so that __fdget() wouldn't do this:

                return (struct rawfd) { FDPUT_FPUT | (unsigned long)file };

but instead have some kind of "mkrawfd()" helper that does the above,
and we'd have

                return mkrawfd(file, FDPUT_FPUT);

instead. That would obviate my EMPTY_RAWFD macro, and we'd just use
"mkrawfd(NULL, 0)"?

Maybe this is bikeshedding. But I'd rather have this kind of explicit
one-word interface with a wrapped tagged pointer than have something
as subtle as your fd_empty() that magically generates better code in
certain very specific circumstances.

                     Linus

