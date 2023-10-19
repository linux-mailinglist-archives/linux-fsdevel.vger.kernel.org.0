Return-Path: <linux-fsdevel+bounces-774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDEC7CFFB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 18:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF3CFB213F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2CF32C7E;
	Thu, 19 Oct 2023 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NdAuZKrr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C1932C75
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 16:37:46 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C64E11D
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 09:37:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso2193587a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697733462; x=1698338262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KVg72uPUJlCNP5ZghklHQ33G/OMrolR4hmAv20/o7n0=;
        b=NdAuZKrrXymKctFN1ivCrJa0AVUdvVikwwSoA24LZqajnOpokfMjpkfcSLfDKTLPMd
         4RMuv0r7da8unFutLJTc2aQ827eaqf/9FXsMLM9aoVgXWiLQynA3HPqv+ozy2Bl/sg7X
         7wLnNMVkFNBORgN284Tykgde7I+QZK/658pgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697733462; x=1698338262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVg72uPUJlCNP5ZghklHQ33G/OMrolR4hmAv20/o7n0=;
        b=uaYYWGc7OoLB3f3RTjq2OFVM+zSJp+l6/Drlz41eCeof9vBdaBNytCrH7gL/+BYTpu
         SEUlWD9rmA/TxCLlImRkVlJ6fWobkrlkfdcHjWh8/M8eOf9/UsJMYyCv+4qoxKhQZZja
         QJSjwJVmO9F8CEBamts8ny/foa8jkKH84PeLIsDP5QQR0lWLPfJGIKOahgRm727hCiZ7
         LvcumZ5tI6OPU6DbOtXX7suJwB+ZHS9SA/mtXyawkfABNM+YiaSfmji7Qw2GIjd7UfXq
         HoU6D2EoH3KLPyXHYTA3IqTsUEIphyGpTXqJr8NooMNHrIY2V30pFajkrGcFMYoE4YVS
         K4nw==
X-Gm-Message-State: AOJu0YzBqZz9QV2NfXRhY7UwODtuClWflMWT7k3AZD/8rTfVdCQuk6cF
	lN6lzicMqFaOxcWV/HqazDkWcES9QR6j+Ti2npY5xA9N
X-Google-Smtp-Source: AGHT+IGnjZBt+XqqDQL2jSBG96XE15XpiyvM+tbsDIwt+NKyyUOPVjwqtXS5R6GJ6UoIVqeW8Vq3dQ==
X-Received: by 2002:a05:6402:26c9:b0:53d:b59c:8f8d with SMTP id x9-20020a05640226c900b0053db59c8f8dmr2499927edd.8.1697733462455;
        Thu, 19 Oct 2023 09:37:42 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id d25-20020a50cd59000000b0053f9578ec97sm1347014edj.56.2023.10.19.09.37.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 09:37:41 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-53e16f076b3so2157572a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 09:37:41 -0700 (PDT)
X-Received: by 2002:a17:907:97d6:b0:9a9:405b:26d1 with SMTP id
 js22-20020a17090797d600b009a9405b26d1mr2298936ejc.5.1697733461464; Thu, 19
 Oct 2023 09:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019-kampfsport-metapher-e5211d7be247@brauner>
In-Reply-To: <20231019-kampfsport-metapher-e5211d7be247@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Oct 2023 09:37:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBXdLJ=QDpYmDEH-Tn71dXasGJSX4Jz4qMo8V4-7vYkg@mail.gmail.com>
Message-ID: <CAHk-=whBXdLJ=QDpYmDEH-Tn71dXasGJSX4Jz4qMo8V4-7vYkg@mail.gmail.com>
Subject: Re: [GIT PULL] vfs fixes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Oct 2023 at 03:09, Christian Brauner <brauner@kernel.org> wrote:
>
> An openat() call from io_uring triggering an audit call can apparently
> cause the refcount of struct filename to be incremented from multiple
> threads concurrently during async execution, triggering a refcount
> underflow and hitting a BUG_ON(). That bug has been lurking around since
> at least v5.16 apparently.

Ouch. That filename ref by audit was always supposed to be
thread-local in a "for this system call" kind of sense.

But yes, looks like the io_uring stuff ended up making it no longer
thread-local.

That said, using atomics for reference counting is our default
behavior and should be normal, so the patch isn't wrong, it's just
annoying since getname/putname is very much in the critical path of
filename handling.

That said, the extra atomics are hopefully not really noticeable.

Some people might want to use the non-refcounted version (ie we have
getname/putname used by ksmbd too, for example), if they really care.

It already exists, as __getname/__putname.

But the normal open/stat/etc system call paths are obviously now going
to hit those extra atomics. Not lovely, but I guess it's the best we
can do.

> Switch to an atomic counter to fix that. The underflow check is
> downgraded from a BUG_ON() to a WARN_ON_ONCE() but we could easily
> remove that check altogether tbh and not waste an additional atomic. So
> if you feel that extra check isn't needed you could just remove in case
> you're pulling.

Well, the atomic *read* is cheap - the expensive part is the
atomic_dec_and_test() (and the atomic_inc in the audit code.

I'm not sure why you made it check just for zero in the WARN_ON_ONCE,
rather than <= 0 as it used to, but that check is racy regardless, so
it doesn't matter. It would miss two concurrent decrements coming in
with a count of 1.

We don't have the ternary test of atomic decrement results (positive,
zero or negative), so it is what it is.

                 Linus

