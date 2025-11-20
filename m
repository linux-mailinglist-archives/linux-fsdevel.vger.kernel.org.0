Return-Path: <linux-fsdevel+bounces-69331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85959C769CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 00:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA7F44E5F65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AA12F6588;
	Thu, 20 Nov 2025 23:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E0I58kYd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D928A2FD7B9
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763681329; cv=none; b=hyRCmXLPvw88Mgr1Y8ki6SUaWpDP2jofpBTu4083yich4vNwBeceKIPRt5UQGbWYiAqcaDPa6sjvFduErj0nPR8KANeQzrrYP2EzSsuueeZ8f9AD55V5TTr7avwkk0d0pBchePk0WlMlgXGkYhhtkj1E2CdFYAVXDO22gdynH04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763681329; c=relaxed/simple;
	bh=3fbHUj6M2pwcm0BO2q1SEeGbh2JYHnGl0RCab5z0jMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evP0QQD8cuoEeMsceFV4r8O0SGLWsVufcACUE+b0in6ymXM9v2ojmDfKU74LxkdqsQcqYjshNZBmDASwiarvHxUYcP6bpXzPFcSZiYzB5HaK9HMf1/WYiNrPbTeyNwswtj3NbjbaiJ5GCMtnvfTxB6w8AC41l1M+dIxXdbxutos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E0I58kYd; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so2557460a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 15:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763681323; x=1764286123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bmj1vgQHkSaKDVofOK3FL7tVQEr5ch9743+4LcsaUU0=;
        b=E0I58kYdLP9HeQ/TFOgjmXCnCnpnX2XTX3iH84ZYPFRKcuPwefvABo+YgQyngogv3T
         lZvjkyPEwgk3vVl8zoTKUdQuBbPniyMckdnwyeGMl008B9GL3c06jgZoz1N5A+JKWcwH
         1b5oag57rXiy1y7zvLOSLqDsuZYr4VtI3fUH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763681323; x=1764286123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmj1vgQHkSaKDVofOK3FL7tVQEr5ch9743+4LcsaUU0=;
        b=vMmUAeF02ZoTJNarXiLywz2/BjxdFyckoa0tT+oUj1sVSgxzWEaxYRRO4mTrSM9cj7
         Zlhdo1IGpKy7PV3vgxtFROhNs/idKXGt0WicjHO3aBNFPzq700oaejZxggGbNWgYr0jd
         Z03s2qmrVxstdxhXva3kfHWxl9HE7xCHdz1pJiywg8bCfhoIGAROp/Wo1UFs8Z4DkLuU
         ZeXNFVJaRoi5sHbm/mE0osywc6w9ytIaH5rT6b9IHQl/sVUWDH896UVqsG0iRXp5F66c
         o+XR/Ij9pxlGiKW2Iw+ufz1MuLhP3Ed5SoVX5KUSAVvtPLlozB8wutO5ABcj+GVLdtS9
         VgaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAeUkacW89jaKz8g2loYqr+mM2pK1q4aqJf3hR39wkB/WqrF2Ux7D3zoIOYh5l4O/Ov4IhjwMLHeCDFfBE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6O2y3SMJ2cAP6s/NnMyuTu2QrmyEeGxhd/4LOHTuXUaH4AyaP
	84BQ5NkITfSVTRmshulBRgwvH3RgIrb1bJo+/zkmlLPG2btmtyFWtPY4k/h46tl5p6agMmQ8SQB
	hM7zRl4c+ZQ==
X-Gm-Gg: ASbGnctlYMn4sjtOKZitiOpcpuR3ZXTzEzpmvyS0OTQSlCyi/5ltA500e5ozktnEwy9
	hHnRi8vZUxcPOX+qWmFjn4+q8P9Tuxgw8C0030LhXXzOPndmvBYmL1VZ1JPTm7Y+fmYwx4sWvnX
	EbBRu6xsrLenjRq9wZHHc/RxI4nwK7Pz2YX83lG/G8hs1Tyc8euB7PntbSMqbHvxA6RbVf9lX4u
	gp1aX0r8ydkthc8fF00HIyWdv7Pxg1lcPT3jRvmwwk/UUmUMeJ/QzUSNc/RXAL7NyxwoSRR3RJG
	6dzKqSNlHlJJ5o30BZ4VEbdYpjsFdVoactNtsI+P7rxqbPgJhmVv2q/GS1cj50tbeYi7TMgZFa/
	jl3arQCvttvrmN3jj6LIAu7XZScPfOP10HpkxkpkOJ7HOq/RfUh8ipoZa2Y/PlrU/NPgGC3m84A
	SUPVHstAc5LLVdQP2TpIlisfMPga5u/yeCKeSoPV1KS11vAfOk17zp8ruNKWXc
X-Google-Smtp-Source: AGHT+IHVub1J8vxOkBomN7DGA5Ojr4sCYeQBzlln9LsKQK5Tz44zvWUeAyrtwzxiBuM+dqxU8pJPcg==
X-Received: by 2002:a05:6402:4405:b0:643:129f:9d8e with SMTP id 4fb4d7f45d1cf-64555b9aafamr107207a12.8.1763681323335;
        Thu, 20 Nov 2025 15:28:43 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76550283f4sm307136466b.55.2025.11.20.15.28.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 15:28:41 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so2557418a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 15:28:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUciWmdA7sXMuCPVOXScTRLdqeqOhC4C3MB0g7Xse+fdLHi9WH4xX7Rp+NncmA/q7fB8e9KS1imfqGtF8/b@vger.kernel.org
X-Received: by 2002:a05:6402:4306:b0:63c:1e15:b9fb with SMTP id
 4fb4d7f45d1cf-64555ceb4a5mr103187a12.22.1763681321471; Thu, 20 Nov 2025
 15:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org> <CAHk-=wg+61ucgtDpK4kAL0cpNi1pk-t6=hTWumbF+L7b4_pfTg@mail.gmail.com>
In-Reply-To: <CAHk-=wg+61ucgtDpK4kAL0cpNi1pk-t6=hTWumbF+L7b4_pfTg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Nov 2025 15:28:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgmCtGuXVD2Q5jjCzxj5jBVAxXZOyVyq3+f+jAyxuUyMQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkvOegt5MAxL1nPN1yZjsqN5QYgs-Di-ql_4XBXixiB9DTW-Lv5IRlgX3g
Message-ID: <CAHk-=wgmCtGuXVD2Q5jjCzxj5jBVAxXZOyVyq3+f+jAyxuUyMQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/48] file: add and convert to FD_PREPARE()
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Nov 2025 at 15:08, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I really wish the end result wouldn't look so odd. This is a case
> where the scoping seems to hurt more than help.

Maybe you could make the basic building blocks not start a new scope
at all, which would make the docs in the comment actually match
reality?

And then the (few) cases that want a new scope and actually have
something that follows the final

        return fd_publish(fdf);

would have to do their own scope themselves, possibly with a statement
expression?

From quick (and possibly incomplete) look through the patches, of 48
patches, only *two* had a

        variable = fd_publish();

pattern with code after the scope. The rest all seemed to just want to
finish with that fd_publish() and the scope didn't really help them.

eg media_request_alloc() ended up doing

                *alloc_fd = fd_publish(fdf);
                return 0;

instead, and kcm_ioctl() does

                        err = fd_publish(fdf);

and then breaks out of the case statement. Maybe there were others.
But all that the second case actually does is then "return err"
outside the case statement anyway.

Now, those do probably want scoping, just because they do have other
code after the "return" anyway (due to this all being inside a case
statement, or they had a error label or something). But I think they
could have actually used a statement expression (or even just a bare
nested block) for that.

A statement expression might even look reasonable, something like

        int fd = ({
                FD_PREPARE(fdf, 0, kcm_clone(sock));
                if (fd_prepare_failed(fdf))
                        return fd_prepare_error(fdf);
                info.fd = fd_prepare_fd(fdf);
                if (copy_to_user((void __user *)arg, &info, sizeof(info)))
                        return -EFAULT;
                fd_publish(fdf);
        });

certainly looks *very* odd too (those returns inside the statement
expression are downright evil), but I think it would actually be
preferable to the odd "you have to do a block scope after the
FD_PREPARE()".

I dunno. There may be some reason you did it the way you did that I
don't immediately see.

                 Linus

