Return-Path: <linux-fsdevel+bounces-72074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8EBCDCFD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 19:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD98D3034344
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 18:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF54E33ADA7;
	Wed, 24 Dec 2025 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IBKrHv6H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AE526D4C3
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766599322; cv=none; b=prGa/wSRsR9H8tvhMe7rC57Klm5e1ZeEjF3bHsHmuDLQmnUBvqw2kCeZ6oPNhci3fr/Z28JGP/o8lGUj3jGaMPM2pc2dkFwDv5qjuOHfiB1bCdzGpCIi8ZNn3iI5wsr3832BwELzka8/4+FjiIi0rEOxkJxyxj+rCp/o7nr8n38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766599322; c=relaxed/simple;
	bh=ffr8BuiqR1HXDARhf4WRKjYaZRBbwe/ETGa9BNLzfkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGe08uY58rwJv+06yM2rvBbXyl5Sxj/h3I/ujwQosr/AuVCtyv0yC3zVuBvgdosLKX7aU7+EO+gEazuCvKR8aSISdWpZY1eANGaLb1bBmQdYpfUnYHV8xa3crJ3ZrDxKTfzWVzCRsudXrMtly6YlvFFeiSR7uQ5MvZRJau6qzp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IBKrHv6H; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c78d30649aso4030443a34.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 10:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766599318; x=1767204118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31Zv6z83wAMfU9zE8KFoguUGkPYnxjQorySjBsQWmUo=;
        b=IBKrHv6HrW2iA/iq3RIbQOS3QFkpkOIwhAtdCEdcMwpL5tkf9XNfhu/jGZJ5+A2jDM
         3dzBNJI0bnbIq3ghv3WNUOkwTRPnieTWTGmH15E2lSsD41NK3reD8DmfknQzZ29whT9v
         xUchTkByUW57AniMOcZKJtQCg5SUY8v7ETMyy57YJgUEIXrYl/qKYp8MTaW6gyBOeE5S
         Y0ccCTPRus7SeeN+xw9iyXlbNOYQP1c9w6gORDBqwGTguIMFr7m6Dr2boEChFR2N8P3n
         eJFV6kjDCWv1/AqKeeXd+CvvfQGzHGn1/6VHLLVSezC1O8OsbHSCoTT/TDiItGAylB/l
         H9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766599318; x=1767204118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31Zv6z83wAMfU9zE8KFoguUGkPYnxjQorySjBsQWmUo=;
        b=lbaDit04jsNFdZy22bjtv0wN6yppZeqYIy9aQ+qzK5A+XuDWnWCJgpjTbpzzaJSC7/
         mH8sjHUSj+7WKeoKYskwPJ7IoNADGC0TmaUPYbk9xLDNojwN8Zvd6ifPifbPlVnhXYCR
         oes0vlNkDncL/guutac+TOnLWBUgT/wWw3/KEUKadFPXSLEE5he2DzEwA9ite63PCxmh
         CaMz8BQniS0RzZznk9zTFr2xo1WQnWlxVuyORJExsEpt4+zI0JbcaARdmezwb0YWZP6C
         AYH3gdRRs2XRPnKisBepYS7TCuCvTkxbFxZaZokKuPdXknOJ3Sff6sgx0uma+faTyc/+
         CAJA==
X-Forwarded-Encrypted: i=1; AJvYcCVe57lpwkQUAOIbqDtPjMr3LnKaRP4Z+kgHIEqp14A5moF2Q1MClN4k+/HxIj+6gMjXd3ONcbgUgpzV1B0+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf1HcdjkWln58r70he1wrRUPfHt1jU5F7++C1gqcpvBACB6pbJ
	P6yxLq7a6Ef+XeiufDf2Mx2K/FvqqPdZQ4/xQ+BrZwkE5Hr1wfm9tQhzgj47v+y1e+U=
X-Gm-Gg: AY/fxX6ba9UYhXA03RC9ItNMeaXTLlMxgWdrVpN7RsIjqItY+hlV4Tmt99M7tBNFhWh
	XekGNGH8L2sWvGlvEaQ1ml8UO3zFoQbUvOiWUcRMGvCD5CiMFpJTqs7HbKx4cukMf4QCDGCOT+o
	nE8s5mpRUzY96T1L+jL02uY2ydr8vuS3dLKQHrIU6/eo2xiO+/tr+4OgolFiql9UG+aHRv4zYur
	2+CpUPKUksLx5aFJPjQ8xtuEiP1wBNPekBnn2CVFOPTTFNOD5uLhTCRgoRGr16RrqCcJliYgE86
	h9QGREXWOka1cyDW3sxjLG2WpJg4EOMu5BfjcFwH9UVYQKegwsz3sAxTOIm71f/u7cXFpx0JGjx
	e4gFWxmQgJtbXZ6Aipb0tyOO98F47bo9tlO8scX15h9zgizusqCqT6ZlZNf9+nUKedl3HuCjA4R
	nul/Bvmo81
X-Google-Smtp-Source: AGHT+IGfEWIgxDSU+uANNE79e+2413xwqBZuFut4L1sp7glYjUDAwIPMADbg+343p4Lu36fqv0j2bg==
X-Received: by 2002:a05:6830:2546:b0:7ca:ee2d:fd8d with SMTP id 46e09a7af769-7cc668bb2abmr9050695a34.9.1766599318375;
        Wed, 24 Dec 2025 10:01:58 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc66645494sm11921405a34.0.2025.12.24.10.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 10:01:57 -0800 (PST)
Message-ID: <dc51a709-e404-4515-8023-3597c376aff5@kernel.dk>
Date: Wed, 24 Dec 2025 11:01:55 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: fix filename leak in __io_openat_prep()
To: Prithvi Tambewagh <activprithvi@gmail.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org,
 syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20251224164247.103336-1-activprithvi@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251224164247.103336-1-activprithvi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/24/25 9:42 AM, Prithvi Tambewagh wrote:
> __io_openat_prep() allocates a struct filename using getname(), but
> it isn't freed in case the present file is installed in the fixed file
> table and simultaneously, it has the flag O_CLOEXEC set in the
> open->how.flags field.
> 
> This is an erroneous condition, since for a file installed in the fixed
> file table, it won't be installed in the normal file table, due to which
> the file cannot support close on exec. Earlier, the code just returned
> -EINVAL error code for this condition, however, the memory allocated for
> that struct filename wasn't freed, resulting in a memory leak.
> 
> Hence, the case of file being installed in the fixed file table as well
> as having O_CLOEXEC flag in open->how.flags set, is adressed by using
> putname() to release the memory allocated to the struct filename, then
> setting the field open->filename to NULL, and after that, returning
> -EINVAL.
> 
> Reported-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=00e61c43eb5e4740438f
> Tested-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
> ---
>  io_uring/openclose.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/io_uring/openclose.c b/io_uring/openclose.c
> index bfeb91b31bba..fc190a3d8112 100644
> --- a/io_uring/openclose.c
> +++ b/io_uring/openclose.c
> @@ -75,8 +75,11 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
>  	}
>  
>  	open->file_slot = READ_ONCE(sqe->file_index);
> -	if (open->file_slot && (open->how.flags & O_CLOEXEC))
> +	if (open->file_slot && (open->how.flags & O_CLOEXEC)) {
> +		putname(open->filename);
> +		open->filename = NULL;
>  		return -EINVAL;
> +	}
>  
>  	open->nofile = rlimit(RLIMIT_NOFILE);
>  	req->flags |= REQ_F_NEED_CLEANUP;

You can probably fix it similarly by just having REQ_F_NEED_CLEANUP set
earlier in the process, then everything that needs undoing will get
undone as part of ending the request.

-- 
Jens Axboe

