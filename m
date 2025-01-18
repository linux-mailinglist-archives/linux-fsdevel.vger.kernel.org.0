Return-Path: <linux-fsdevel+bounces-39591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81970A15D86
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 16:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F1E3A8375
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 15:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA68191F7A;
	Sat, 18 Jan 2025 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="26AaB3l4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09717172BB9
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jan 2025 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737212561; cv=none; b=qBVhM+3gGtrnNZLfmVYNd09CBYeHdU6G2lbFofJYfj3PRqanXoVfihg0UfpHz1QR23N7pRPUaqM3sdYlz0Y1IWIfEL8d6u3LwuVJzCNwIqHmQKvM2nUpXKR3L/+QKjk8L83FZ2OmttEbdQxopDjCGCGhNT2ytQLf63Kon5idyAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737212561; c=relaxed/simple;
	bh=Ob0eexNFxLX/uszBPzKcXPy9tHfgF2F+/a4DmhBo8No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjYeZgMuurbpVszyb1IfwE57o9LWnsA63IwOzHyicNrpLVLeXJC7CLpM10ZPv/cezw1tefE+Zq2VMUCzU23H34ZKO6xJa8es5Kvgy4NkZ8SQ8eN1TIrFO5Iook3jKEq7Mm7KF3PXeRpht2IHSr/zi2TY9PVB8jAFPWeJ11GpsN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=26AaB3l4; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844e394395aso93625339f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jan 2025 07:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1737212557; x=1737817357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCVGHiLOIHwhwiWmLRg6KlEVGdmx+jR4E4pD9bsH/Tg=;
        b=26AaB3l4sYkacZZO5/54SdNLpzBr9aD7zvUZGfXBqJZRJJSXLOI4TSpioQkMWsY5Ad
         muL83DZ2v/TPN1rLpf8gUWHCugww/G0fVmDOP8MuGi0IOlO5QODOIIclpbDvmSdnU6bB
         EXTciJ9XmvFtBgqSB9SsKvkUyi83nb961sCib05o210/Q3rgzlUt+lCwbzBAzFd1k+X8
         5rOAXMvBRW0M0W4Colse6ODb+Huud+QiE8G+GwXEpwuYG2YVDcX6YvixbqDyMjzQW5Hl
         R8mloeiYKXfvG+QS8izOnsULMuTSNyp83cEmwClXlqvlVdCe/MCppxXpm2ljsNM0Uooy
         ZNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737212557; x=1737817357;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCVGHiLOIHwhwiWmLRg6KlEVGdmx+jR4E4pD9bsH/Tg=;
        b=Kug/qvWlnjOTEruFy+0DG51XLdOiAFe0lcDkMQdTczt3aO6ROwNceuE5cKkqf5xEng
         jJKx2M7XlDl7EnxJaP2vt42W+KoQzIuDETHpE7dH/Q91xL6kn7sHr5toAorLqZmjpVRd
         1eqjGi5h41b7WOYcnWMc42Qo1XWA21Wcy4rH5J0MlPEkjA3n2BC/cG9dY97srWUsDQ50
         A9D73GfnNyypPyb+KgjK1JW75gJ75JMfQOdGbc6adlv9zC9X3B+fxyHnLTU1khS495TL
         Ik6miNG7maGCdV9VUSEqVDzoZrMORa9qx3OpSPYfo99D9oi8EGcIN1euKja1jfjRthHg
         q0sg==
X-Forwarded-Encrypted: i=1; AJvYcCUiP0tUIc0z7dFFi7/42GDV/giJaaJ75zhYQpVrUCbz7OfNO0F7mSYyLRB4yT50AXSX+ES7fhDTVBBGLWcT@vger.kernel.org
X-Gm-Message-State: AOJu0YyrHqQg6Nq1TNG7y9XAeAB9Ey9Twfw875YWO2IFcLvN8gLOUDCe
	O6KvuFuYBQVe32LBk4Ual3CF55ZeErKSAwfPzMv8+tAULkgIWKbl/BAEQCLATVpaFh0dGyZxlKs
	0
X-Gm-Gg: ASbGncue5JIEt7vxPZhhd1RGmHjKfaHjlJ3dkVnu6Zm/GrapNTNTgbDHqefsRkU7nMw
	0RbAPEuj8YNDNpcu7HXP1TBSXhITdcO6qWvOa1mT0QZbnSKYSJKeqnbIK1EvdwTw8X8+RHUCi5h
	uFUR2W1pE4HKMdO9PIP2+qQqkNS0ofzLSMsPZAAsC1NTE7Nh5BNSvwr+0cgwKgWqDe7J7acYLKI
	Z1k0ItNg/12UCzI2GuvgggdgwqV1X6YSkB0JREsPkwYC8fIDLJNFKMVm6fh2kr2K68=
X-Google-Smtp-Source: AGHT+IG/G0F20vBCgcLgBLyQAt7AU7VvDlOWtwu1/dj16Rm+I+2RhznMyoeFB7hsHm/nGzUTg9R8/g==
X-Received: by 2002:a05:6602:2b8a:b0:84c:b404:f21f with SMTP id ca18e2360f4ac-851b65226c5mr501759839f.13.1737212556699;
        Sat, 18 Jan 2025 07:02:36 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-851b01f2c82sm120287739f.20.2025.01.18.07.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2025 07:02:35 -0800 (PST)
Message-ID: <cf13b64b-29fb-47b9-ae2d-1dcedd8cc415@kernel.dk>
Date: Sat, 18 Jan 2025 08:02:34 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] fix io_uring_show_fdinfo() misuse of ->d_iname
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20250118025717.GU1977892@ZenIV>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250118025717.GU1977892@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/17/25 7:57 PM, Al Viro wrote:
> 	The output of io_uring_show_fdinfo() is crazy - for
> each slot of io_uring file_table it produces either
> INDEX: <none>
> or
> INDEX: NAME
> where INDEX runs through all numbers from 0 to ctx->file_table.data.nr-1
> and NAME is usually the last component of pathname of file in slot
> #INDEX.  Usually == if it's no longer than 39 bytes.  If it's longer,
> you get junk.  Oh, and if it contains newlines, you get several lines and
> no way to tell that it has happened, them's the breaks.  If it's happens
> to be /home/luser/<none>, well, what you see is indistinguishable from what
> you'd get if it hadn't been there...
> 
> According to Jens, it's *not* cast in stone, so we should be able to
> change that to something saner.  I see two options:
> 
> 1) replace NAME with actual pathname of the damn file, quoted to reasonable
> extent.
> 
> 2) same, and skip the INDEX: <none> lines.  It's not as if they contained
> any useful information - the size of table is printed right before that,
> so you'd get
> 
> ...
> UserFiles:	16
>     0: foo
>    11: bar
> UserBufs:	....
> 
> instead of
> 
> ...
> UserFiles:	16
>     0: foo
>     1: <none>
>     2: <none>
>     3: <none>
>     4: <none>
>     5: <none>
>     6: <none>
>     7: <none>
>     8: <none>
>     9: <none>
>    10: <none>
>    11:	bar
>    12: <none>
>    13: <none>
>    14: <none>
>    15: <none>
> UserBufs:	....
> 
> IMO the former is more useful for any debugging purposes.
> 
> The patch is trivial either way - (1) is
> ------------------------
> diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
> index b214e5a407b5..1017249ae610 100644
> --- a/io_uring/fdinfo.c
> +++ b/io_uring/fdinfo.c
> @@ -211,10 +211,12 @@ __cold void io_uring_show_fdinfo(struct seq_file *m, struct file *file)
>  
>  		if (ctx->file_table.data.nodes[i])
>  			f = io_slot_file(ctx->file_table.data.nodes[i]);
> +		seq_printf(m, "%5u: ", i);
>  		if (f)
> -			seq_printf(m, "%5u: %s\n", i, file_dentry(f)->d_iname);
> +			seq_file_path(m, f, " \t\n\\<");
>  		else
> -			seq_printf(m, "%5u: <none>\n", i);
> +			seq_puts(m, "<none>");
> +		seq_puts(m, "\n");
>  	}
>  	seq_printf(m, "UserBufs:\t%u\n", ctx->buf_table.nr);
>  	for (i = 0; has_lock && i < ctx->buf_table.nr; i++) {
> ------------------------
> and (2) -
> ------------------------
> diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
> index b214e5a407b5..f60d0a9d505e 100644
> --- a/io_uring/fdinfo.c
> +++ b/io_uring/fdinfo.c
> @@ -211,10 +211,11 @@ __cold void io_uring_show_fdinfo(struct seq_file *m, struct file *file)
>  
>  		if (ctx->file_table.data.nodes[i])
>  			f = io_slot_file(ctx->file_table.data.nodes[i]);
> -		if (f)
> -			seq_printf(m, "%5u: %s\n", i, file_dentry(f)->d_iname);
> -		else
> -			seq_printf(m, "%5u: <none>\n", i);
> +		if (f) {
> +			seq_printf(m, "%5u: ", i);
> +			seq_file_path(m, f, " \t\n\\");
> +			seq_puts(m, "\n");
> +		}
>  	}
>  	seq_printf(m, "UserBufs:\t%u\n", ctx->buf_table.nr);
>  	for (i = 0; has_lock && i < ctx->buf_table.nr; i++) {
> ------------------------
> 
> Preferences?  The difference in seq_printf() argument is due to the need
> to quote < in filenames if we need to distinguish them from <none>;
> whitespace and \ needs to be quoted in either case.

I like #2, there's no reason to dump the empty nodes. Thanks Al!

-- 
Jens Axboe

