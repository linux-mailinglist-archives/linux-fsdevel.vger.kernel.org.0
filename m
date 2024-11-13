Return-Path: <linux-fsdevel+bounces-34707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7809C7EAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 00:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A41AAB233BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 23:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D1218C331;
	Wed, 13 Nov 2024 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c+fjZKm8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A742717BB1A
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731539280; cv=none; b=q6lPqwUXz0I9xEPeF6vD3sVODq4HfwGFPw/J8/jJaoOGg2T6G8yOasVGumHUAZPiGupf6Fs1X41CZQef4HVq11bYtMvQVodiZxzod/vtG3vCUxOL1w2w5lixtqRkPhlsUr1kPEXDMlFhmXTwMv1DTTN+HqLO/+cUwp/wjdVEscU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731539280; c=relaxed/simple;
	bh=/tltkOoQpP8bcM74mMy2gPuKWTvbxMmV0LsxinTpOwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4eG1G2hiKdctOasuszFggqybY3mPvT5j0kJLhhSNfmHrP5mix1F2LuGaDoCIx+4xbAfgdIPTjlM580nDu0KUJhjgbrNYyTZuTKq/knVPDPYWumz2Z5xP+u4eRro6B3i3c4Rph89d92slXDrBITyCESPYosIhB/a+z7nEQee2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c+fjZKm8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cec93719ccso9604632a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 15:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731539276; x=1732144076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3uMAHPF1ytklJO173iJZDrJhJUNgUA50IG0+xtq7Xjg=;
        b=c+fjZKm8p3UEZc0j7u89ojYhXO/bX+KAVKzzCsxemjYevPZn5JAS7h8lYsaomNYGmB
         T77nAEwb8LdmBztPo1lpBo5HtLLgSoMOHz0w6KSm4ohWzXQ9FpUDNdWHUIIvp85peqPi
         hYPh6upICpbrrxfJcKEBLLg6FgbeK5IPhWrRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731539276; x=1732144076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uMAHPF1ytklJO173iJZDrJhJUNgUA50IG0+xtq7Xjg=;
        b=tmvftSGL13mUt/i/dMZCjyH7Qn+zVvvEOhEfxyKqmu//rHl0DGZuhBB37UfYMlxDvo
         vWEL0BaEsridHI2khu+bkxgmJh3bZh7o3YoJIqOEq+jyRK3WNr8N01kYlezW+mZjHwaz
         tB4gJSfe73u5HP04NoBZn3zKpVbq8kKNajDPi88ZunBoX0CScKp7Qkzgd7KXm6Q44PMT
         LGU7djhpK2aJIOMu2YyeqqsACE5OjPCbEymdoOwBKXN5XYVNPUEQGI3oGmpxws6HNPaI
         15/f2I7QebAQ+aAeiwxkLuS7FnbLbXc5Gtplv1wCu0nugx9WbbdEf/gqoz+zsZYiUcyc
         d+PA==
X-Forwarded-Encrypted: i=1; AJvYcCXoC6Zn+e9sE6T+PZDZxHk7XGwbZEraqkHz98BXbvIhBOwktx8tTO2ncJMNyGxbuJmfHOtvczZj5y2hq3a3@vger.kernel.org
X-Gm-Message-State: AOJu0YyMWX8v8PjbHuhPotvZLcXr8ZAN7+hRiXnyk5NQzOxqw+BdxxfH
	B3unmyt/nUIkV+yUwu07IWqFuNY7Ru/+Xi/A/Xf2OSPsd3+lDzuTNSEbYWcv7OmYq2XjeCJVv2I
	bgHE=
X-Google-Smtp-Source: AGHT+IEUsVgDjDYAlmPhWJIMnAUSYGiCu3Fw/14wMsf4yd5dSfev+K+I+0fjd54rnN3Xrf1Z6BTqaw==
X-Received: by 2002:a17:907:3e02:b0:a9e:b378:6c13 with SMTP id a640c23a62f3a-aa1b1058071mr800504966b.17.1731539275816;
        Wed, 13 Nov 2024 15:07:55 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0defc3csm920177366b.166.2024.11.13.15.07.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 15:07:55 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so14414766b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 15:07:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUR6S3589e25+HdDFQXsbIdP1EdoxkozfQTU3Je24wnEy7DVPpyG3li9apkMnYy900TSWNfrxqX6fDwzg3d@vger.kernel.org
X-Received: by 2002:a17:907:5ce:b0:a99:5234:c56c with SMTP id
 a640c23a62f3a-aa1b10a372fmr767667166b.33.1731539274832; Wed, 13 Nov 2024
 15:07:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxjQHh=fUnBw=KwuchjRt_4JbaZAqrkDd93E2_mrqv_Pkw@mail.gmail.com>
 <CAHk-=wirrmNUD9mD5OByfJ3XFb7rgept4kARNQuA+xCHTSDhyw@mail.gmail.com> <CAOQ4uxgFJX+AJbswKwQP3oFE273JDOO3UAvtxHz4r8+tVkHJnQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgFJX+AJbswKwQP3oFE273JDOO3UAvtxHz4r8+tVkHJnQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Nov 2024 15:07:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiTEQ31V6HLgOJ__DEAEK4DR7HdhwfmK3jiTKM4egeONg@mail.gmail.com>
Message-ID: <CAHk-=wiTEQ31V6HLgOJ__DEAEK4DR7HdhwfmK3jiTKM4egeONg@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 14:35, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Sure for new hooks with new check-on-open semantics that is
> going to be easy to do. The historic reason for the heavy inlining
> is trying to optimize out indirect calls when we do not have the
> luxury of using the check-on-open semantics.

Right. I'm not asking you to fix the old cases - it would be lovely to
do, but I think that's a different story. The compiler *does* figure
out the oddities, so usually generated code doesn't look horrible, but
it's really hard for a human to understand.

And honestly, code that "the compiler can figure out, but ordinary
humans can't" isn't great code.

And hey, we have tons of "isn't great code". Stuff happens. And the
fsnotify code in particular has this really odd history of
inotify/dnotify/unification and the VFS layer also having been
modified under it and becoming much more complex.

I really wish we could just throw some of the legacy cases away. Oh well.

But because I'm very sensitive to the VFS layer core code, and partly
*because* we have this bad history of horridness here (and
particularly in the security hooks), I just want to make really sure
that the new cases do *not* use the same completely incomprehensible
model with random conditionals that make no sense.

So that's why I then react so strongly to some of this.

Put another way: I'm not expecting the fsnotify_file() and
fsnotify_parent() horror to go away. But I *am* expecting new
interfaces to not use them, and not write new code like that again.

                  Linus

