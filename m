Return-Path: <linux-fsdevel+bounces-43376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6DFA553D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 19:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5A8189AD5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 18:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF55276D3B;
	Thu,  6 Mar 2025 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N6nHPydl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC11627182B
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283967; cv=none; b=JZYQOueewRc4fbktB3bESrUulgzZn8BIsCdxFpo8deixY3v3ZD341yIC3ZKdVAVYKnr+8EFOtmc3HPR9uldSgG6hdl0+3n0UltoJNp79vCJ0cJduMHNYJ14Snw7CrxxKfSOdwhoHxDtxjaQ/2ab1CtDWn1HMigm9PECCN57Ad+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283967; c=relaxed/simple;
	bh=NWT0F/KJlYO1vT3bElv/lrz4CjmK9qNstQ1RSsLhO5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6mr7IgUutLEyQh8nY623K1M1y3uJkUv1ZMHELuP+7q7Thp0z6g5CQzQmEWUUIKX3M8dM29z3xbd1KLVfNA8acHkzmhPoGbMSPUoA9BbmvlHgpoAXw83xunb44vVz0U+kUz/PEkISB6I3JkZWM0OTtKJdq15UW8hoTO2BadBVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N6nHPydl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab78e6edb99so153518166b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Mar 2025 09:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741283963; x=1741888763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bSYRkarb+7IJw2j2ISIxVnW8mglX4UBJdNIvXLsVq6k=;
        b=N6nHPydlZWCkpeTREh8vGnL9mIU5wSVBonj+s+sjyYGwuXCmaWzn0AY0ILBun37+lG
         dNVeJ4/iLniiBvuxS9i7vzYYUNdUnigaB2X15jjpxFJwfQMil/iSDc2vYuv7tDa3WaRb
         bQ+5kkn/4IQ5V08ieBcf7+6WJIzbLCRFV2Clo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741283963; x=1741888763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSYRkarb+7IJw2j2ISIxVnW8mglX4UBJdNIvXLsVq6k=;
        b=vLJw/WsgvwzP7/k3wvEaByxZzAiK+imN7ufVH3xtf186elzh7ydAYKYAOxLYJI9HQ0
         Pv44cnp/HpSNH1HnmKzG1zE0TCf1mALozndqHhobO3WCNs2cudi3af/ZAKcAAmTBWJtu
         Z9Vcw3nmmR2QXlVC9LSMv57ULj7hfRkxgvaXHcXivLi0f2vYFSdVvPmZM8MLdcinykZt
         c9yQVC9nibw8beoxN+EUaZMj7ZNJcdf68wPdtV1e0i2gAL8hKxSoYEgIgEr7ABzXB7kO
         wcB5Q3/pEKiT5HzCdSCJ8PcDn//uk9wmsU/Wli77+GbWH26lkYx+NEocJML+ur4+rx9r
         BOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMWzyDXI8L80bZZaGlYHEPUkuvE3kfWXicEbv35tb8g7jITSE5jkGuj48AaltBD3a+bQE9G+m/O7kO7I+2@vger.kernel.org
X-Gm-Message-State: AOJu0YyLKmqQDFs0ak5WloZDirQrdDdQ960csPgXLlgK9cAcjw1q48+c
	Hsl2DtGaoH3wr+7wK4pnzP8Agfzg6e8j0Pw7epWLniKcGEfOHlZ89GZ/aqMpeJiTjQkHP9Xxdf1
	yw5g=
X-Gm-Gg: ASbGncs+XRUviFeLewdW06566qia1yFTxdqwMl4Bp3nr3CMCYx4Ef/qOl0z7bKHU+SC
	s88UIJgvSugs14fw3v7c0xuLkIAOi1Eb4jMXyATnxtn8Y/Ykc5G2VFO9EX0I/Uu6EoeZeUfhxVU
	lCvmR5infV9Arx9Cr/1QAxEwt+jI2ty6oE0UM+ou8TP0mtQe4AhxT7ZSbJ7/0UR2AHYQ4j46LhD
	ng/xC/Ze/JSzB2TiqoU3eBnUbBqOPc+hdGVV/nucix8FaMdqeSij/JBKoY9fp1qD+0eUilK941l
	rSAHotTQmIExy3VUKgUmbh/ORg6h4bUwiP056ELZeZqppVR4oposxE6VMVnk/3FfKtHDPT3oDQO
	AZrI6oIyAlv/8go33ri4=
X-Google-Smtp-Source: AGHT+IEtQidwH6INzF8gJ57Ui35Fe3MOQrxm0ZxaY4FufZh9YkttByRdX/u24vzZ5OUljuRXDjTSqA==
X-Received: by 2002:a17:906:4fce:b0:abe:fdfc:47d6 with SMTP id a640c23a62f3a-ac20d8ccc35mr772306166b.23.1741283962773;
        Thu, 06 Mar 2025 09:59:22 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2394389a7sm129133466b.5.2025.03.06.09.59.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 09:59:20 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab78e6edb99so153508366b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Mar 2025 09:59:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDvesShVC5KgLFSj7RLgO9LRS/yO49xLqp97s1yzLZS0wvKQzJWpmjVTkBdCmvOCnabLL1+TtR7/mlHjbG@vger.kernel.org
X-Received: by 2002:a17:907:3d86:b0:ac1:e6b9:57ce with SMTP id
 a640c23a62f3a-ac20d852d1dmr848759766b.7.1741283960242; Thu, 06 Mar 2025
 09:59:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com>
 <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com> <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com> <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
 <20250303202735.GD9870@redhat.com> <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
 <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com> <87cyeu5zgk.fsf@prevas.dk>
In-Reply-To: <87cyeu5zgk.fsf@prevas.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Mar 2025 07:59:03 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg8e77mmVWZrSjhDe3+3MfF_h1op7VjTJv570zrE2s9Jw@mail.gmail.com>
X-Gm-Features: AQ5f1Jq3Yhgvw2xjomqRUNpCHfEfMY6rND9DoGhv3ZSJetivAGgMEt8CTPE_-Kw
Message-ID: <CAHk-=wg8e77mmVWZrSjhDe3+3MfF_h1op7VjTJv570zrE2s9Jw@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, 
	Manfred Spraul <manfred@colorfullife.com>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 22:35, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Wed, Mar 05 2025, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > and there might be other cases where the pipe_index_t size might matter.
>
> Yeah, for example
>
>       unsigned int count, head, tail, mask;
>
>       case FIONREAD:

Thanks. I've hopefully fixed this (and the FUSE issue you also
reported), and those should work correctly no on 32-bit. Knock wood.

Mind taking a look and double-checking the fixes?

                Linus

