Return-Path: <linux-fsdevel+bounces-67590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECCEC441C9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 17:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 033304E653A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206132FFF98;
	Sun,  9 Nov 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSHLP7+b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9DF2D595A
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704264; cv=none; b=d6VDNlZJ4scVDTzNJynpbcArr9AZBVgPX2F7MLc8JNeaSsHQYZLIVBx0E+SFx5NtQYsXxtdDx4zTT2kJr7PBkOHJhO+aTGSGnvxR6rMh/PMMNxXNfnxn9KRHVqDUsis66xs6dprd88fglFCx7LwarPBr4m+N75mh73h8A3AdUY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704264; c=relaxed/simple;
	bh=ZwznLFivANyU8ZlKEutMzt9MzcWHkhSBL7kC5XjFM0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VR/2id/k20fmKEl+QAB93BC8kvYzUlMCzzGedrJ1at/KtKr8ZMJi+ADI5Qv/8GfeyUlZF1gBNiXbTf/J9QVX78lagZH3RRAk1VvYNdFNWXgC4Gp+d1GRYAIrJnxgYGS8YCX05ZKCZS29ErijagAWIalI3zIl/p+X1lhLoi6/8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSHLP7+b; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429c7869704so1675808f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 08:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762704261; x=1763309061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZ/3k/Szvk85XYtPGcfXcb2ddiNwOVeYZcc0QlEd1Dg=;
        b=PSHLP7+bXzYqOd4Ca6cAxh9ydRiOhY+xMmvsx64dw4n11vSAFQa+NX2vbnF65zsOIG
         O4Z94tsib0MhmWkvg8I5+lD7nQ3fwhEgWQApjAqe4sA1PT+YnaQOqvCp84Ycrn5WmF3+
         rcnmiR0mEmgvu4vfoU2mLuelcztdKEre3liXk83x61OcSYCa7kR2ShXhV0PCX0rY4U7N
         WtBCT1d8Rxu1daJg5wpMi7JV6Wn9nHyXStcGc1ugLStqkccB0Mw3M1+ASFfUK22W/CIS
         XFtjxq3z8HcZQLx41kkRI/oAiR0eieyp/w9kkcHcxExiJWeMHux+VSFUQNEdy1FeRtpV
         BFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762704261; x=1763309061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yZ/3k/Szvk85XYtPGcfXcb2ddiNwOVeYZcc0QlEd1Dg=;
        b=TF5e7meW6+hmNPL3BFnpvGZvIbX+pv5r92xESv59DtPEkQqRYcWHiGj+rzhV95bkbk
         +/HeTpkWFVrLGUb0FW6XflB665JEIr2r1acaI5NccI7Xd9/yKhG6cQzkiJp0j8W1jE9w
         /CE5HcYdLWSsmJL8FVsZkuu8HxwXX0QWnLi3hEMKiLSp/foE62bhU/zn9Ark7S2A/koX
         nzYOnnkHFBRPhd0WN0NIULnUZKyPZpbZdbeg7USZG5sXN59XYvNI5GKHBJsfH1ennc8Z
         HGcFqOjBKpTicFKwzWwdmdjzF8Zi4xHdWjrMI48SJ9Q50o0gyEF4V2bX5bN51Z3QkVxM
         +VXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1HnOJ5TJ81jxCvSjwfxYrB0Imqje65wJYQIHWaVe39dnMtucwoNEGXa0RLTm8Oa5nXL4WGIuScoKbOlGI@vger.kernel.org
X-Gm-Message-State: AOJu0YzS7WhoyfFyemfa8+k2VhJcaipGAkBnFRFSfhPpJr4GYJU2PzEL
	gZUnpJHWLbEXSPOc1JdZ01cPlQsJtWUVlcU+VKfrdn2O2EBy7oAYXwao
X-Gm-Gg: ASbGncusQfNPY5/6ZifuzNtsoiiaeD6mGSBS3J8EBbdXfP3tDbOnPPebMmWDBVMTmYl
	zlM2urTl3KgRAO+ed43LfOwptLIUIVHixTqrA4TyEp88aQZVxo6ETplmgX5U4rNxylXZ3TPgA5v
	4F9BJaYfLPsu9GwgV7a89s4tFtiueKgXy4DMz8ZBhRBOE63cyyrWHt8cNVkU5nptlKkK7qIIUhy
	40GuDu/XK1GR4u45GzP7hIzzp4irV+JyqwbjnFaPe6euKtaiF7RbW3YeIEWitSfEOuFUmafrFK2
	YUDA3r0Qg7u9s+D9FwhSuYdKYmjzKjqBw7E+3MVek27W1TSAcKBN63d3QGHanEflU4X63TnR4z/
	OJKvNe1N7+nCOVK3aESAqbbzCZVZjaYg5EppKnFxy+uH0dxDeCgkzGpqPhmpQy3zsA/fX51BsJj
	C9oPo4sQM9zEU4wdeI9F0Qjo3HT8qiV59Y/EaL/TcP8owPU9mEXzE2
X-Google-Smtp-Source: AGHT+IF4v4kRAm85ejXHBzeoSJZ5rv1Sf/e1KUUS5XVDP4wZrYVo3g/uJNxMF3qT2VLVXhWlbGOhHA==
X-Received: by 2002:a05:6000:24c4:b0:42b:3978:157a with SMTP id ffacd0b85a97d-42b3978176fmr1366422f8f.39.1762704260877;
        Sun, 09 Nov 2025 08:04:20 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2dd927d5sm10518562f8f.24.2025.11.09.08.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 08:04:20 -0800 (PST)
Date: Sun, 9 Nov 2025 16:04:19 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Masaharu Noguchi <nogunix@gmail.com>
Cc: jesperjuhl76@gmail.com, Jeff Layton <jlayton@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] samples: vfs: avoid libc AT_RENAME_* redefinitions
Message-ID: <20251109160419.5a16411a@pumpkin>
In-Reply-To: <20251109071304.2415982-3-nogunix@gmail.com>
References: <CAHaCkme7C8LDpWVX8TnDQQ+feWeQy_SA3HYfpyyPNFee_+Z2EA@mail.gmail.com>
	<20251109071304.2415982-1-nogunix@gmail.com>
	<20251109071304.2415982-3-nogunix@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Nov 2025 16:13:04 +0900
Masaharu Noguchi <nogunix@gmail.com> wrote:

> Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
> ---
>  samples/vfs/test-statx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
> index 49c7a46cee07..eabea80e9db8 100644
> --- a/samples/vfs/test-statx.c
> +++ b/samples/vfs/test-statx.c
> @@ -20,6 +20,15 @@
>  #include <sys/syscall.h>
>  #include <sys/types.h>
>  #include <linux/stat.h>
> +#ifdef AT_RENAME_NOREPLACE
> +#undef AT_RENAME_NOREPLACE
> +#endif
> +#ifdef AT_RENAME_EXCHANGE
> +#undef AT_RENAME_EXCHANGE
> +#endif
> +#ifdef AT_RENAME_WHITEOUT
> +#undef AT_RENAME_WHITEOUT
> +#endif

There is no need for the #if, just #undef the symbols.
It is probably worthy of a short comment.

	David

>  #include <linux/fcntl.h>
>  #define statx foo
>  #define statx_timestamp foo_timestamp


