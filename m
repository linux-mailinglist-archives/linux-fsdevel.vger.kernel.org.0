Return-Path: <linux-fsdevel+bounces-36688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0889E7E48
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 06:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAD6282433
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 05:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4135B1FB;
	Sat,  7 Dec 2024 05:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0hgBjfL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F307F1BDCF;
	Sat,  7 Dec 2024 05:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733548860; cv=none; b=ZQ29LsJJr3zWWLETfJIZgWEXW2tJbYQZvNGEnWIAaapDFwrAcqMaaUv7J05n2WNkSYZA0TAwdndhgCHnfEYYjMeMStsW0jvBsumJHAMyw1DyHt06Af7+TZFlN7rrIkgMYOnQ5yBj5b4ku92Xk173V+rdnslJsazDQBhaAVhb+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733548860; c=relaxed/simple;
	bh=UmRWd+KnaOk8lwGdV90X50BQsmkbfC+/nmOzsHXJwnc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=EigJSuVw7KOFH74cDG/sSYRsREzFCS8cgTUGWZ1xS1RH744wxD719KDRrSe7+LNBLuYwl5JrelLKIPMHmSyhUhLtePG6S55YMNWGLa2/3grCbf5uQ/W/lLQMypb2pXCrETXTVKpREEgt/lBTFEZBfqNwdd7Tma2Qrcv/9HEUSQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0hgBjfL; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso2003136a91.1;
        Fri, 06 Dec 2024 21:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733548858; x=1734153658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBXfTQztGpMrB5MxGg0g8xradodaYggvMylTYoes3J4=;
        b=L0hgBjfLwivLDTYPGdFXhdD1TRu20L7u8xoBPnac+h2Hi+9qNmhz96wejpj9h2MpxH
         Rl9ZmFeMpjW41oIxdSuN9zlnCd0SfKy4+eQN5pGYoIuj61c0/Hw4srhTbH642jHLjyPl
         6BUuw6U4ntX7doY53KjeIq7KeHuJkghKtZJw5z/zvNRoqpw0DueRiQs0ryhEJdUWr9Hb
         VkjFlEpYkqDpmcFirxXt5Z9PK24it9xwsQayUUYCmDH/nRxqY3lKnIOY92XNaOoXjfcy
         HXM5h/+IRGhc0IRucU2ILWSy881gsVCqGTu2XdEkDmyD3pVM57/T8vvp3gDgDiWAwqau
         98zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733548858; x=1734153658;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBXfTQztGpMrB5MxGg0g8xradodaYggvMylTYoes3J4=;
        b=QCWuagvDnUjRVL57DU7G3ls+aiEU15u11ixKTSfmnqBM11+WGJIRHTAq9UUDJOBnEA
         FUbc3Ffy1qE5c5cOd8yOpSXBsuD92YK4ea4R0peeo/DXGrjM/PZQ/3l4xFjmAvtuW6Al
         RPcKCRy34y44cQ36k5Ij8qcDfX9mxP2nlOXVhI0eVyMe1oDTwQVbkrLY2MbO9JxBFHnE
         XOD3qgHv8dKgeqF4KuIsWbpCPKgnphPZdPtHNkfSupCJ8qvc/7PkT87szei1mA+OYyLy
         HvNLW/YNAtRuKSMjYYKaEQV0zcNWvG7X+5EXNHqKk75KOorx7rn6tApyNVWjcihIMNw1
         AgLg==
X-Forwarded-Encrypted: i=1; AJvYcCVlYSnmkHbvzrrh/VwiTRVtGP0vbU81mkhhfzwLfExiVGowfonURt9EV9YRmd6CuTjSP33cnc0HwNLCA5nG@vger.kernel.org, AJvYcCWs2ZQAjrdglXac/umJq9ujRXhP7xPvNbrJ7pljS+tNo4NHW5DPBoTHpClZn5fbydOAgwzfEiPlxj588wNw@vger.kernel.org
X-Gm-Message-State: AOJu0YwgIULT10nXYx105e7Om+0Q4UAufpWW+AN2kQ+BOfEbXKmZdX39
	NUWUTpaWz+3DRtN+ZYT2tcHQANfASfvq2F4FvdRR4aNw5hdkyWbG
X-Gm-Gg: ASbGnctvjhwt/ka0aux0B5b6YUv65YLR5xDUfY+66xfewxA09+mSQaBdIJSCO3mwcA/
	IsnOhfWnecBSFqwgAamdjjHIMuTJCK6LBLxpmumcCHYScsWAc+v6feRG38UYi4MSDLKhNCuuvRV
	S+1yaDsuReXHSJsAGzwE/yGPEOTjJ5x8G2Afdelj+P+pk3Zhu77VMh/PBdT0B0zDn4akr8c15a1
	debou7ZJY8dXQ4+CdEU35gkP6K4aAk+MzY5E/dM/6R1MrbeuDt5ydf5rrMNgvL3MBzJ4EhWpDhb
	n9qn8VFL/xUJzQsP
X-Google-Smtp-Source: AGHT+IGmlPlf7hPuoZfoUynZKjAb1C9EVkjuhhuVc0cdTY2nEaJ/tIrMel/mgXhdgGlrmCJKR82ViQ==
X-Received: by 2002:a17:90b:3944:b0:2ee:b4d4:78 with SMTP id 98e67ed59e1d1-2ef6ab1052amr8897289a91.24.1733548858076;
        Fri, 06 Dec 2024 21:20:58 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45f95899sm4052365a91.12.2024.12.06.21.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 21:20:57 -0800 (PST)
Message-ID: <69667b21-9491-458d-9523-6c2b29e1a7e6@gmail.com>
Date: Sat, 7 Dec 2024 14:20:55 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: zilin@seu.edu.cn, dhowells@redhat.com
Cc: jianhao.xu@seu.edu.cn, jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfs@lists.linux.dev, mjguzik@gmail.com
References: <20241207021952.2978530-1-zilin@seu.edu.cn>
Subject: Re: [PATCH] fs/netfs: Remove redundant use of smp_rmb()
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20241207021952.2978530-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[+CC: Mateusz, who responded ZiLin's original question at:
  https://lore.kernel.org/ulg54pf2qnlzqfj247fypypzun2yvwepqrcwaqzlr6sn3ukuab@rov7btfppktc/ ]

On Sat,  7 Dec 2024 02:19:52 +0000, Zilin Guan wrote:
> The function netfs_unbuffered_write_iter_locked() in
> fs/netfs/direct_write.c contains an unnecessary smp_rmb() call after
> wait_on_bit(). Since wait_on_bit() already incorporates a memory barrier
> that ensures the flag update is visible before the function returns, the
> smp_rmb() provides no additional benefit and incurs unnecessary overhead.
> 
> This patch removes the redundant barrier to simplify and optimize the code.
> 
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>  fs/netfs/direct_write.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
> index 88f2adfab75e..173e8b5e6a93 100644
> --- a/fs/netfs/direct_write.c
> +++ b/fs/netfs/direct_write.c
> @@ -104,7 +104,6 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
>  		trace_netfs_rreq(wreq, netfs_rreq_trace_wait_ip);
>  		wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
>  			    TASK_UNINTERRUPTIBLE);
> -		smp_rmb(); /* Read error/transferred after RIP flag */
>  		ret = wreq->error;
>  		if (ret == 0) {
>  			ret = wreq->transferred;

You are removing a barrier which is deemed to be required by LKMM.
See section "SLEEP AND WAKE-UP FUNCTIONS" in Documentation/memory-barriers.txt.

Quoting relevant note below:

-----------------------------------------------------------------------------

[!] Note that the memory barriers implied by the sleeper and the waker do *not*
order multiple stores before the wake-up with respect to loads of those stored
values after the sleeper has called set_current_state().  For instance, if the
sleeper does:

	set_current_state(TASK_INTERRUPTIBLE);
	if (event_indicated)
		break;
	__set_current_state(TASK_RUNNING);
	do_something(my_data);

and the waker does:

	my_data = value;
	event_indicated = 1;
	wake_up(&event_wait_queue);

there's no guarantee that the change to event_indicated will be perceived by
the sleeper as coming after the change to my_data.  In such a circumstance, the
code on both sides must interpolate its own memory barriers between the
separate data accesses.  Thus the above sleeper ought to do:

	set_current_state(TASK_INTERRUPTIBLE);
	if (event_indicated) {
		smp_rmb();
		do_something(my_data);
	}

and the waker should do:

	my_data = value;
	smp_wmb();
	event_indicated = 1;
	wake_up(&event_wait_queue);

-----------------------------------------------------------------------------

Are you sure removing the smp_rmb() is realy the right thing to do?

        Thanks, Akira

> -- 
> 2.34.1



