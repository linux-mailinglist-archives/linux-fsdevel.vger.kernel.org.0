Return-Path: <linux-fsdevel+bounces-44704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 815BEA6BA38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 13:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05EB319C4DDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 12:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DFB225768;
	Fri, 21 Mar 2025 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz1D0YZs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868B86250;
	Fri, 21 Mar 2025 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558450; cv=none; b=JLOkH0QlYjnGLaL6eF5wGuxx23dA7GqVgWZ5U9khlTqMPSZSL9lm31qS0keSkoK4+q5j9aqdvbsK7VwsLwM+BqqerGXAidVloCS1IGsEdpz8o4c9fuYq42Wk0OSJTsFXyWlvesmO6hIGe4PEZXhUukbc2Y2SGqFw3baf9L+1i0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558450; c=relaxed/simple;
	bh=74QhnzKbW9aHnDTtmDERlGimhlX1E287SbG7cG+icRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbeSOG3PFpHd6Re9lZHH8UhfIM1wSEJOJF41e3pp0zTNbc54XByLfHuAoRU/Ej2kUjquXht6nkj0xXHR1/bRDxqoDnUnO9F+qcE57oPb6YyVSbQOt0o3f158EeyJKBufX81/5xTTdU0v6hM2gWd/FAuvZ6naKWlv6RjWZmt28BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz1D0YZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EFEC4CEE7;
	Fri, 21 Mar 2025 12:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742558449;
	bh=74QhnzKbW9aHnDTtmDERlGimhlX1E287SbG7cG+icRI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mz1D0YZsM2pLNIT1SCovFGLqEX7Q46WY5mFHIv68qrOetghCx1G8lHbKRd07Ffv1J
	 UBVxom9NWgR60qqeI3mF3qVuiFGjN7uZLE9aiIhYyKPxTEhjjDPHi6HhNlU/ai24rq
	 8sKQhZfzQZ6Vo+E8iVoO1g6a+bix0YGC1q3p4lSHk4+rC5WQb9EF94avfYxQajTupR
	 YpoKL/ClJlFneRPeBYYYrMkEt3WOg26K0AE7WuPiZdtpT1ApK08485OWeKsov2Vx7m
	 CDHzr7ZJ2CqSLyL4iRsh7HgISo79zx1ztKvCqMl9jPsmsAq3MSTNh1CioibDEcjpaF
	 /q6XMPci5Rfvw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2c1c9b7bd9aso958408fac.0;
        Fri, 21 Mar 2025 05:00:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVr5eP8MNguHjMfRehT/1UxOZ5bx64JeGegXwGmOhzqReSwX12A/K/5YmuNXV6XQwM+JzLGZsyJtDX0F6lX@vger.kernel.org, AJvYcCWZzZNqB6cAwhfamHJ0bL0hVv+dIrFeGQdsQnWrD2VEFpboJh23R7jyWK2ohtXtaJW2vVE7lzYd@vger.kernel.org, AJvYcCWhd/gKzl3AaXeg0p6bm/9YS2AwH/bMWetHiii/MBaEyhTrYa6iC7+HDn8v8y8EkmKELovE/ZoZ0Eey7MrT@vger.kernel.org
X-Gm-Message-State: AOJu0YxaCr4YqEFtwP3h277G3cHkXqXMUqXVPNJI/tfGx9WhIGuL1ihn
	Dxa/JdHYkh29QmOBO1kfD+0jH3YlPMjcFk7Hg0O3YQKcpfJzirkQLciBFsCRjCrskIMgEdLqVly
	A2KYI8/RopZTausZ7fbCvZoHBRxY=
X-Google-Smtp-Source: AGHT+IGg70qn+JL2hDJ2egmXLZUTud2yr+t4hljxG8JLcN5gpp6kww4yC+6Y1ZvsgXF4Xmo0tmRupqHE60axkjxAFp0=
X-Received: by 2002:a05:6870:aa91:b0:288:6a16:fe1 with SMTP id
 586e51a60fabf-2c7802ffef7mr2087934fac.18.1742558449048; Fri, 21 Mar 2025
 05:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250321063454epcas1p2194c3e69371dd4f025202d727bfb93a4@epcas1p2.samsung.com>
 <158453976.61742539083228.JavaMail.epsvc@epcpadp2new>
In-Reply-To: <158453976.61742539083228.JavaMail.epsvc@epcpadp2new>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 21 Mar 2025 21:00:37 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_S3t6PX-TMJH5WiY1YqyFBLu=_fBKiCw=uDfb+n=xXPw@mail.gmail.com>
X-Gm-Features: AQ5f1JrZ_3lOK7hGKG_opFQuodPfEiB2Cjbi9_TFj8psvCs0xxwOXRVvTfPkCZs
Message-ID: <CAKYAXd_S3t6PX-TMJH5WiY1YqyFBLu=_fBKiCw=uDfb+n=xXPw@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: fix random stack corruption after get_block
To: Sungjong Seo <sj1557.seo@samsung.com>
Cc: yuezhang.mo@sony.com, sjdev.seo@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cpgs@samsung.com, stable@vger.kernel.org, 
	Yeongjin Gil <youngjin.gil@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 3:38=E2=80=AFPM Sungjong Seo <sj1557.seo@samsung.co=
m> wrote:
>
> When get_block is called with a buffer_head allocated on the stack, such
> as do_mpage_readpage, stack corruption due to buffer_head UAF may occur i=
n
> the following race condition situation.
>
>      <CPU 0>                      <CPU 1>
> mpage_read_folio
>   <<bh on stack>>
>   do_mpage_readpage
>     exfat_get_block
>       bh_read
>         __bh_read
>           get_bh(bh)
>           submit_bh
>           wait_on_buffer
>                               ...
>                               end_buffer_read_sync
>                                 __end_buffer_read_notouch
>                                    unlock_buffer
>           <<keep going>>
>         ...
>       ...
>     ...
>   ...
> <<bh is not valid out of mpage_read_folio>>
>    .
>    .
> another_function
>   <<variable A on stack>>
>                                    put_bh(bh)
>                                      atomic_dec(bh->b_count)
>   * stack corruption here *
>
> This patch returns -EAGAIN if a folio does not have buffers when bh_read
> needs to be called. By doing this, the caller can fallback to functions
> like block_read_full_folio(), create a buffer_head in the folio, and then
> call get_block again.
>
> Let's do not call bh_read() with on-stack buffer_head.
>
> Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")
> Cc: stable@vger.kernel.org
> Tested-by: Yeongjin Gil <youngjin.gil@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied it to #dev.
Thanks!

