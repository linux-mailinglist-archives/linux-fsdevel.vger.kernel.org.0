Return-Path: <linux-fsdevel+bounces-9213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20DB83EE8D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 17:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113471C20FF0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BA531A83;
	Sat, 27 Jan 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jF3MusBl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4589060DC9;
	Sat, 27 Jan 2024 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372456; cv=none; b=PY+KhNjxBkJyXQwJaEiHMoOE6HoxG+DZUGYnS0Y2ZNzWVGfhablMNLHAKsdvlp84bXpuLoO0566ZWxkD/brWyJFCO2jNGHz+lOubJiwzWAd5+0y9OBRbuADo0CwmyBfMgoc/KYN/C2aZCs5JeCbytX/dMfQN9FHgosaDV9MWBa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372456; c=relaxed/simple;
	bh=vuJqFnZtTpTssMFoMa9G7Fw9QNg4vClPrMPI4Vl+fQo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fafJxih7yCJwLVqGxaNM4DGQWx80i4IBNBWBGI3YjxUljNFdb+Ajn6UyfUoFh/pYQW1qvWtk7VOLERAZEMIPMI0hSdH9i2zcPtaDbobR1FO4g2PEH1ZIceyyRpz1WphrNYGgkwaHCckgfUX40bAIML/9vFBOUCYoTXvzTWotA0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jF3MusBl; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68c37bf73aaso9925036d6.2;
        Sat, 27 Jan 2024 08:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706372452; x=1706977252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khozqR2J5qyGoQPqSuwAokWTqr1QO39YPwi2HTUl2g4=;
        b=jF3MusBlQFXatW7qXIZGK2UaaN+1M9baONpaP/BIfrGdix5COoJp+mc1fQNsL24Qjw
         xV+ASIUQhjc27doTnXRWVUUDo4UTFylG1IvsrJO87Q5dHCG+n8AGEfLocqIv2cy52a3J
         s+7KIxvm54f+DLC5SlDlbOOf0qtfQyGqG+bFxFjpMSFO59AVQamlcSxC5v/XesvaS8m1
         qA2uPtTbqdRtSE5Ks3IByQb1GLaKmd/lHk/e+S0DIiGj3VDirSN3oMv1bz9mOZTIOY7T
         x5f++Yx5wtyqyyC0QpTHvTDnbBZpJsX3VKqkVbfyu3kpyHXXiVyN7c3saEkOT0i75cXN
         /Xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706372452; x=1706977252;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=khozqR2J5qyGoQPqSuwAokWTqr1QO39YPwi2HTUl2g4=;
        b=JoNYKuC6NP42vw6qW6PekBOYr5OEQbp4p+HS0HreG7Db5PElSjZROKze6RSFhL5q6W
         TfvNNzGD7nRKjG6D20runw8xszcZSZrspayeOzp3oaGUO7qL6HYOD5PU+H5375hItqQs
         TPd14NmdavbSl0xbYv2z4pbfUUBina1hbeSraKuiMEzfuG7P5VYmLrth1xtm4nsHQdUp
         HjxVz2z3YnwpDCbKFq/Y16aW/x1zYIuK5lJEsL/3+6HMbmF/Sf0cPbDoKpLpVdYaJn3d
         kddguNUGcdQWG+XKp7Dep/kd9SxjIzBJFqvKsv4Pq1NSRIxsRB52QmD/iB+j1+8kRpSk
         P5eg==
X-Gm-Message-State: AOJu0YxRSBZsHQPEy47QB6CyuzKn62Pd1gU3QdKYJ+vplNj4V0XFbe8B
	QvAxxjAtoEfyFVUbLRpxBAid54PtCbXKRLnJ0axAVBajaxPl/cPz
X-Google-Smtp-Source: AGHT+IEtYpnrWB7Pm3yuX4jPsKtMVMAT7CxIrt/thqrPJmnt6o0+3z1I+ItZujRzlRejHx8eF/YXDg==
X-Received: by 2002:a05:6214:d4b:b0:67f:c133:3922 with SMTP id 11-20020a0562140d4b00b0067fc1333922mr2597732qvr.129.1706372452055;
        Sat, 27 Jan 2024 08:20:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU3+LBrHc5Zp2e/HJFvVOcowk2itTDRWVCeBu9FGgIoLhx1ERum609+VtwSXCmHZuqS5yjQCmPIOTKaPjOQe/dQTVYgq22FobAr2B/krJF/ABfPP6m7x4EnV1WSKu3Favw3R/CbLgjf5/KoV1SK7vMijxAF6bl7l3CjFbqXYhiVyfr3NdcT1IalWJrnDIDvwQXAH+8vMcCn58UmXIbIdpGi+QIRmYUiAKDZeK8dweFrlaJHhu4odqc7bkwALp38FVz8uctVXmeUDwB2/lw9r84h8fC5wfZhacmiPwbaeYB3uK3FMUsy8WMyqwZXvQ662JodMK+Ckz8Vlrh7uJX+WpaEhUDH4HWu9luhqqgzcCnUIez7adveWXYigeEOT6Zs2Evn+zFaqWUOPBcTgbt4mcOuWRmZGrpy3P4iXeTwtZWOD0UK0KTMIWxIPwu4cEAA2yoetHwyrCqg1YG4B4J6RX3Q7rnAuGmWy0F4Gy6JaivBNAUqAkkiQZgBXJpME8ViDxeKurO8zLRLDOGIuFJPQ88yzzDp/OTK3y5gqH5eSq8NpgoEKKTj1WZFsCugbWRMRWNXvOegG169A2OY8YlYSBY4PUT5sbUgfxPMVKXw9UCzIkqmEqs1SBrOvjAuDw1VaUfY1RD1QerhxTAoKJLFboH6DAaoR5tB7H6C1ZgOQC0MGvtl5XP66jVYbk3z4nIo7ssbaJuvZFei+ixltrx+QSNWmB6p9dDBN4po1+Vyn1pRQo8ZgWv/HC+BAFi/v8Gywoc8ablY6S2+UpeRQTwJHYvapimI5O/v3A//4++ejuPmhlC+hAFzmidM7s5mCcyBZchB8mGo1SGwUnUTcXnlopGASubLZKb11JA4GUSgJYN7obbCcauHOF5YwR9g7BW1x1AfpwyR0pDLQzI6wG4HgQG9mxfQlJ0QswjplomeljUhaHVAE0x1mVra5t3f
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id ly9-20020a0562145c0900b0068509353fb6sm991500qvb.133.2024.01.27.08.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:20:51 -0800 (PST)
Date: Sat, 27 Jan 2024 11:20:51 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <jdamato@fastly.com>, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: chuck.lever@oracle.com, 
 jlayton@kernel.org, 
 linux-api@vger.kernel.org, 
 brauner@kernel.org, 
 edumazet@google.com, 
 davem@davemloft.net, 
 alexander.duyck@gmail.com, 
 sridhar.samudrala@intel.com, 
 kuba@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 weiwan@google.com, 
 Joe Damato <jdamato@fastly.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Andrew Waterman <waterman@eecs.berkeley.edu>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Dominik Brodowski <linux@dominikbrodowski.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jan Kara <jack@suse.cz>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Julien Panis <jpanis@baylibre.com>, 
 linux-doc@vger.kernel.org (open list:DOCUMENTATION), 
 "(open list:FILESYSTEMS \\(VFS and infrastructure\\))" <linux-fsdevel@vger.kernel.org>, 
 Michael Ellerman <mpe@ellerman.id.au>, 
 Nathan Lynch <nathanl@linux.ibm.com> (open list:FILESYSTEMS \(VFS and infrastructure\)), 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Steve French <stfrench@microsoft.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <65b52d6381de7_3a9e0b2943d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240125225704.12781-1-jdamato@fastly.com>
References: <20240125225704.12781-1-jdamato@fastly.com>
Subject: Re: [PATCH net-next v3 0/3] Per epoll context busy poll support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> Greetings:
> 
> Welcome to v3. Cover letter updated from v2 to explain why ioctl and
> adjusted my cc_cmd to try to get the correct people in addition to folks
> who were added in v1 & v2. Labeled as net-next because it seems networking
> related to me even though it is fs code.
> 
> TL;DR This builds on commit bf3b9f6372c4 ("epoll: Add busy poll support to
> epoll with socket fds.") by allowing user applications to enable
> epoll-based busy polling and set a busy poll packet budget on a per epoll
> context basis.
> 
> This makes epoll-based busy polling much more usable for user
> applications than the current system-wide sysctl and hardcoded budget.
> 
> To allow for this, two ioctls have been added for epoll contexts for
> getting and setting a new struct, struct epoll_params.
> 
> ioctl was chosen vs a new syscall after reviewing a suggestion by Willem
> de Bruijn [1]. I am open to using a new syscall instead of an ioctl, but it
> seemed that: 
>   - Busy poll affects all existing epoll_wait and epoll_pwait variants in
>     the same way, so new verions of many syscalls might be needed. It

There is no need to support a new feature on legacy calls. Applications have
to be upgraded to the new ioctl, so they can also be upgraded to the latest
epoll_wait variant.

epoll_pwait extends epoll_wait with a sigmask.
epoll_pwait2 extends extends epoll_pwait with nsec resolution timespec.
Since they are supersets, nothing is lots by limiting to the most recent API.

In the discussion of epoll_pwait2 the addition of a forward looking flags
argument was discussed, but eventually dropped. Based on the argument that
adding a syscall is not a big task and does not warrant preemptive code.
This decision did receive a suitably snarky comment from Jonathan Corbet [1].

It is definitely more boilerplate, but essentially it is as feasible to add an
epoll_pwait3 that takes an optional busy poll argument. In which case, I also
believe that it makes more sense to configure the behavior of the syscall
directly, than through another syscall and state stored in the kernel.

I don't think that the usec fine grain busy poll argument is all that useful.
Documentation always suggests setting it to 50us or 100us, based on limited
data. Main point is to set it to exceed the round-trip delay of whatever the
process is trying to wait on. Overestimating is not costly, as the call
returns as soon as the condition is met. An epoll_pwait3 flag EPOLL_BUSY_POLL
with default 100us might be sufficient.

[1] https://lwn.net/Articles/837816/


>     seems much simpler for users to use the correct
>     epoll_wait/epoll_pwait for their app and add a call to ioctl to enable
>     or disable busy poll as needed. This also probably means less work to
>     get an existing epoll app using busy poll.


