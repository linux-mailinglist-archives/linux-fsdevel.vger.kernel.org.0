Return-Path: <linux-fsdevel+bounces-21581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D2990614F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 03:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC062836D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 01:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FE118028;
	Thu, 13 Jun 2024 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AJ9MZTqp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6A4DDB1
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 01:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243361; cv=none; b=oqsZ1YB22JFsOR/luQnkb4CqeD/PAItd8zSSnOLzCUhb9RYjXOASrpq1zyggS28DKNhRNmDB5S7GIZ76f6VuYSHelgmjbsOxpP2gvCPoA/MLWLBEELa5VzTM3qBIIoc5IelmlRWWYzdLQzu2ZVW4mWa9XcoIb1EpBOtnjF4ftmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243361; c=relaxed/simple;
	bh=MKXNxvjvDMlEDAFGJ+FZDsHfj2sWvELkDCT2U73q0SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8QOfCsUy5xg85+56A0tUTCfILJ5hKWwQAmr8oirJiI1Bl+J7lTrXMGfmh1vE8PexJZGV2DEc8uyKGyDFgjbYskSjzvrkfv6Uvcb2cSMXchhWXMLtv9Zk+xzoNKVJNVjNuWhpfdkbLlI4Q0S+lKt9MUfN58ZdwSCfPxnWDS+w5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AJ9MZTqp; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57c60b13a56so345936a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2024 18:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718243358; x=1718848158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u7oeDTF4u1EiwyzNNT5qA5Y4WKuC5XsAbUMmFlcK0R8=;
        b=AJ9MZTqpsDIki8eGBZhJhIpVC3BYX0NdDln2KSv2lGxd3t48V5x9Wxr6U+fMpINALR
         QtIn0liIvzPSYKEvHPa8RaAx37Qr/KvCecrzp7cAzb3Ivh650dTX7Y4nxTRxr3R0gmv0
         jpPvoDtTSQ6wS5WaoMseGleCRxEs+ahv9R83o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718243358; x=1718848158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7oeDTF4u1EiwyzNNT5qA5Y4WKuC5XsAbUMmFlcK0R8=;
        b=qLoMTGnRYbYNu/qoSxFXGbHN9Jg62q2o3hpq5/2CV+zEnUmIoqrjwYEaXcCOHsFIEK
         5Zz3Iz6O+SEOeg7Hfy+H7h+ToLwERk8FABYgpUEj1x+24ISkPWvbt2PBUrRoyaDTYKZR
         JyfubNPrNyQCvMJAZVbd1nEvT5Tlec1j5MoOMufyZYb0z7dSOyiKMGZ8dkP+XaE+3ZNI
         999QkSglSD13qb/wCR/D2gbqsZBob5vFXn5Bpd1LCbAFmVWSDcjGieM0wdJd4zI0d60m
         GLR0W+pGI+O6+GujXkEA6xNE4NZl1EAie/8o7DrfPEkvE0RF58bOaQqQ5cUXfqpFJR7i
         Z/nA==
X-Forwarded-Encrypted: i=1; AJvYcCVm12QeJOdGT/AITrNisJkAnSrx3l/lnDqppIC+upZGTcIPXG3yu58UlXL1938AGB4BajqNjr4w61aJle++OqSYycdkxGcE9XrMgB6mxw==
X-Gm-Message-State: AOJu0YyhNKWIvxSn4MSP89iKtHHmotqqL/w7PL6wwdfnfEcbLOUfw2Wc
	pj+R2q/OgA1HYtuK2MostzA6iEa3QMFgNvMQpboYCv8rgmO59vuwWfIteyOW9u4L583XFX+FqI5
	+QKWbZg==
X-Google-Smtp-Source: AGHT+IFWuQLt2h8wXwnPfS3vSH2oVFQYLVl7N2zPwjw3Fofn000+CWjmWMMB2AHfTZJ0+VbS96Ed0g==
X-Received: by 2002:a50:a692:0:b0:57c:6000:88e1 with SMTP id 4fb4d7f45d1cf-57ca97496damr2051805a12.6.1718243357868;
        Wed, 12 Jun 2024 18:49:17 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb743adf1sm228881a12.93.2024.06.12.18.49.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 18:49:16 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a68b41ef3f6so65862666b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2024 18:49:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNA3rfOlL5czvvxsa74juxmJxRNjC353RMGot3ximD3jXjS1b1uOO9hz3StrCSc3L5FB5NLWRaE0m+wGg+/62cGE9uL7aUe+oCS10KhA==
X-Received: by 2002:a17:907:eac:b0:a6f:5815:f5d9 with SMTP id
 a640c23a62f3a-a6f5815f6f8mr12518166b.52.1718243356240; Wed, 12 Jun 2024
 18:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
In-Reply-To: <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 12 Jun 2024 18:49:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
Message-ID: <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 18:23, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The natural thing to do is to just make the "wait for unlocked" be
> part of the same loop.

Oh, and while I like my approach a lot more than your patch, I do
think that the real issue here is likely that something takes the
d_lock way too much.

One of the ideas behind the reflux was that locking should be an
exceptional thing when something special happens. So things like final
dput() and friends.

What I *think* is going on - judging by your description of how you
triggered this - is that sadly our libfs 'readdir()' thing is pretty
nasty.

It does use d_lock a lot for the cursor handling, and things like
scan_positives() in particular.

I understand *why* it does that, and maybe it's practically unfixable,
but I do think the most likely deeper reason for that "go into slow
mode" is the cursor on the directory causing issues.

Put another way: while I think doing the retry loop will help
benchmarks, it would be lovely if you were to look at that arguably
deeper issue of the 'd_sib' list.

                   Linus

