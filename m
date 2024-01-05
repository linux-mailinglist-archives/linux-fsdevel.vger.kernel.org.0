Return-Path: <linux-fsdevel+bounces-7485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3AD825B91
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 21:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92B2B22297
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 20:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563FF36094;
	Fri,  5 Jan 2024 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ODeaNIWx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329DF3608F
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55719cdc0e1so1669286a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jan 2024 12:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704486359; x=1705091159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jlHlTQ7UwNnsRaaZVTPe3koXZRT/RuAbWyf3puCIBE4=;
        b=ODeaNIWx2t7CashZkz1hXWkxYEfxBhKORMFfvuOacVhjq7OOMERQwGyQyCpQFcLp4h
         aLEf3Lcc26VivNBMcilEfeIkMOxm3T+1mGc1/bS0Jr9EfaunDbePXzKnRnyiljB71IBy
         EboFbe6nCFACPzykrGEaovL09sP3UfwrjIg7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704486359; x=1705091159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlHlTQ7UwNnsRaaZVTPe3koXZRT/RuAbWyf3puCIBE4=;
        b=AwOmcPWuTMHNqPZ0O3y5dhwIKd6LrTdLUHbfZbVh0G+LGcwoREsrFgvLT0IngQKYc0
         0uYb93k0kGGHCmk4uM6NlzNLz88atHl1285cF+0xVndqFJlNYFw/UtxckP4TPdf7nVv+
         H7PYld7iEoFNx/9UZQ+rI2V6L7AEeIbIK4OT40WJ5+6rhamOWwx2t5z7o89rtPDwQW/D
         yaL33wSxZuuf/dZo3nj4ymqBaJAEXqqxoO0azCWzgapfNtU2SAS76vlBIzjrleRlOHGR
         mh8FZRUO2utYN5kYb7StA4J1rJp3f+c2qSti0zrik2AtAyxMnKssKO9bpvSp0Pzt2BaY
         jjcQ==
X-Gm-Message-State: AOJu0Yw14gXNbG26wygI8UKizEveWL3RsEh55Qo25KeAPz7rZBEhLkJ+
	UXSDSjyPQO7Rh8jNgadfIgCA9k260xfrMLF5UnH0whdNPsKfvgDv
X-Google-Smtp-Source: AGHT+IHkZZPauNgAhNteQhjub3U/auhbtdAZBSqOfYOPIAr14tPxZgD8NYkSKa/blJdpJi0W/QNCJw==
X-Received: by 2002:a17:906:5a5a:b0:a23:3303:df45 with SMTP id my26-20020a1709065a5a00b00a233303df45mr1314665ejc.130.1704486359828;
        Fri, 05 Jan 2024 12:25:59 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id r10-20020a1709063d6a00b00a1df4387f16sm1231533ejf.95.2024.01.05.12.25.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 12:25:59 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a277339dcf4so208726266b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jan 2024 12:25:59 -0800 (PST)
X-Received: by 2002:a17:906:25d4:b0:a27:9365:ef73 with SMTP id
 n20-20020a17090625d400b00a279365ef73mr1360283ejb.38.1704486358728; Fri, 05
 Jan 2024 12:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
In-Reply-To: <20240103222034.2582628-4-andrii@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 5 Jan 2024 12:25:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com>
Message-ID: <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

I'm still looking through the patches, but in the early parts I do
note this oddity:

On Wed, 3 Jan 2024 at 14:21, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> +struct bpf_token {
> +       struct work_struct work;
> +       atomic64_t refcnt;
> +       struct user_namespace *userns;
> +       u64 allowed_cmds;
> +};

Ok, not huge, and makes sense, although I wonder if that

        atomic64_t refcnt;

should just be 'atomic_long_t' since presumably on 32-bit
architectures you can't create enough references for a 64-bit atomic
to make much sense.

Or are there references to tokens that might not use any memory?

Not a big deal, but 'atomic64_t' is very expensive on 32-bit
architectures, and doesn't seem to make much sense unless you really
specifically need 64 bits for some reason.

But regardless, this is odd:

> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> +
> +static void bpf_token_free(struct bpf_token *token)
> +{
> +       put_user_ns(token->userns);
> +       kvfree(token);
> +}

> +int bpf_token_create(union bpf_attr *attr)
> +{
> ....
> +       token = kvzalloc(sizeof(*token), GFP_USER);

Ok, so the kvzalloc() and kvfree() certainly line up, but why use them at all?

kvmalloc() and friends are for "use kmalloc, and fall back on vmalloc
for big allocations when that fails".

For just a structure, a plain 'kzalloc()/kfree()' pair would seem to
make much more sense.

Neither of these issues are at all important, but I mention them
because they made me go "What?" when reading through the patches.

                  Linus

