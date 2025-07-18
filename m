Return-Path: <linux-fsdevel+bounces-55487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1944B0ABBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 23:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435741C80EC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 21:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532B2220F52;
	Fri, 18 Jul 2025 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HbA1ivvV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E213221D3F4
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 21:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752875405; cv=none; b=UVxCFQz+fTirFfpAHtU4bkEH4v0/y87zUDq4cL5NuDy9DlUCUCVP82ewMwIc1EmcsjRWV5CWhYlKGho5lWxMEDZVQOCrOmJpPa6g/LgtWY3grrDufVIsI3cPZ3p4iPi2iuZn9Xd80gFIhDluXdSpoe+A778yLGYyUzKmKB/9dtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752875405; c=relaxed/simple;
	bh=ltKlX/6V8eiGzqwSGoa5gPUbAJICZza9LmiBT1RB0UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7oOf5XnHpluOBMozvMBA0tkzVCZxfYktQtSRaZdlJab1j0hiP5dFvMtwp4rJPh8A58HIkPA/VVjySl1RulHtj8+mIMekvoqm+9M5raxlJBmIVyWpy12JE5OM/wh8gVs8ru5oLHb5ZEZ/opmIK1/2sJ0L8RW9tlPMAcCsrckLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HbA1ivvV; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60cc11b34f6so6355503a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 14:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752875402; x=1753480202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fXvc2xA25r+Dun5T9AdGpnAPv49cA2nPvvpwJnVhZbM=;
        b=HbA1ivvVnmlXhcjqVJbEv4KKk5OJr/qG51LplIcwe/hMw0GN8J4ipFXhQZm02aEDME
         4pRpYaIauj/zi0pH+hnJFcL/K6Amq66pEwItv9ohuas3rusOHAesGKD9hbzPzOBOHvoQ
         2Y60N3SjnI7hK8T3LYSpWVcC+8+1/YDGd5+7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752875402; x=1753480202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXvc2xA25r+Dun5T9AdGpnAPv49cA2nPvvpwJnVhZbM=;
        b=Vzamh1nFn0PbaXbKi43BOad3OSQHBhmaO4bQjDee9tWemfqitgAFrJJqsnVHavhX9O
         ej22UPWDNDiu+J9hCngzce5asG+dVOuMkqBmThYQz7KbuhMPK6LBJTvKPhfR+KDKVymW
         wPslujEzy534Hjg2f6D+LXXoPFiDf2sAlpsfAqNGCJJOHV8+FrQjXxVrQbZMRAcuu4mA
         7pdGrQ8zL1DnwZxNIO/4CMF3tWsCZU589VOtnoHs0sPil4ihlgyENL0y5W0NYviD+2Rh
         9ajgUTg9Zw6uK1esnTLwSuFyoDAeRRITJZFQpLRj7SYnH97wczH4ANNFFxfSO4XLzimv
         YKzA==
X-Forwarded-Encrypted: i=1; AJvYcCWdmVk95GjEMo8zQNBKBX8Q7GXV7gxBj5DYSYt2Enc3Eu6QGW+aNqsCq634w8Hho7oCuszaXmWsDDg50mu8@vger.kernel.org
X-Gm-Message-State: AOJu0YyLmlj5PE3UBVJcRfwnaTe6SAg+9Nzh74FnzZ0rS6v3jKarRn3P
	fwuwexWe2eOsZjouMSmM7fjTIgtyC7M9BZJMwnjLODdlYW9RECrHvLtTLLnpuzS8gKlXAOH8iXv
	RFJGAYpY=
X-Gm-Gg: ASbGncty3N0Ae7ABn5yshiGA8cq5pSaWrGzjVqyQGuompU2X3wB/WcQ1k6FgdzdlGfU
	6XVkk2L/QunE/mWan6S3VUmQ4HdTVENyvQ8HpDlZoI7LaeKG3q6o+/DphEd5cuP5s9nMTGNebns
	fWxWZPWHQzOtzrwQEHrcscqnhRlxF8rYzFzxRds02CB+R9zJrSBP4eCGJRPq/2xIlSEyr83Kv6D
	PoGmsvIdu4Xa7fIDhws3IT5gti7cCHZ1Eznsv+d05xoccGTnpPu+m0dyZQzLe1JpIkohZUHixea
	kLGW19kugcL7gtkMo0VxLdp7D9UDEd5vlq/HgB7YQCKPHKJjpxHAiTtjReuA71b8Hqa7iV6k7cV
	U0lMZE37kABgNlsjLFHLGI8tcojwFfExQDIcHLH3q4zGDSRDBAp5AKjigTn7Oz6V4I8BSgxbf
X-Google-Smtp-Source: AGHT+IG9jECzeRo9+Hdj66bu36ur6eSYye7I+O0dZEtuzZ4+GeahAfVJ2uUFh8WXAiXBjEgt7MiTLA==
X-Received: by 2002:a17:907:d7c9:b0:ae3:d0fe:a35e with SMTP id a640c23a62f3a-aec4de13f42mr862370566b.11.1752875401953;
        Fri, 18 Jul 2025 14:50:01 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d7bc9sm189175366b.51.2025.07.18.14.50.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 14:50:01 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so5538251a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 14:50:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXg8+3HaxPT9nSl1AdgQI0femAltp6jQUg08YkvnXauiez2/5SZywDsFgiE7QsspAT3EU3ye2YOuO7Sp6z1@vger.kernel.org
X-Received: by 2002:a05:6402:13c2:b0:60c:3ecd:5140 with SMTP id
 4fb4d7f45d1cf-612c0091a9amr4324302a12.0.1752875399525; Fri, 18 Jul 2025
 14:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213252.2384177-1-hpa@zytor.com> <20250718213252.2384177-5-hpa@zytor.com>
In-Reply-To: <20250718213252.2384177-5-hpa@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Jul 2025 14:49:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
X-Gm-Features: Ac12FXwcle_QXTMWRdj0MWMkwuJCKrti8An2oscUa99HJ5SDjVBQa7FesoFMBkk
Message-ID: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
Subject: Re: [PATCH 4/7] arch/nios: replace "__auto_type" with "auto"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Cong Wang <cong.wang@bytedance.com>, 
	Dan Williams <dan.j.williams@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Laight <David.Laight@aculab.com>, 
	David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Gatlin Newhouse <gatlin.newhouse@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Jul 2025 at 14:34, H. Peter Anvin <hpa@zytor.com> wrote:
>
> -       __auto_type __pu_ptr = (ptr);                                   \
> +       auto __pu_ptr = (ptr);                                  \
>         typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);            \

Side note: I think some coccinelle (or sed) script that replaces that
older form of

       typeof(x) Y = (typeof(x))(Z);

or

        typeof(Z) Y = Z;


with just

        auto Y = Z;

is also worthwhile at some point.

We have more of those, because that's the really traditional gcc way
to do things that predates __auto_type.

And the patterns are a bit more complicated, so they need care: not
all of the "typeof (x) Z = Y" patterns have the same type in the
assignment.

So it's not the universal case, but it's the _common_ case, I think.

For example, it's obviously the case in the above, where we use the
exact same "typeof" on both sides, but in other uaccess.h files we
also have patterns like

        __typeof__(*(ptr)) __x = (x); /* eval x once */
        __typeof__(ptr) __ptr = (ptr); /* eval ptr once */

where that *first* case very much needs to use that "__typeof__"
model, because 'x' typically does not necessarily have the same type
as '*(ptr)' (and we absolutely do not want to use a cast: we want
integer types to convert naturally, but we very much want warnings if
somebody were to mix types wrong).

But that second case obviously is exactly the "auto type" case, just
written using __typeof__.

               Linus

