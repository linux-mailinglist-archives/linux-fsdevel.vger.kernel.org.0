Return-Path: <linux-fsdevel+bounces-22541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E263491974B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 21:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52898B2331F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 19:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4661922C9;
	Wed, 26 Jun 2024 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5EP0pAy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F086119149D;
	Wed, 26 Jun 2024 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719429204; cv=none; b=lFbEt7wBZZO3XuGOT0XMDk4twmF2YYiuI6fCdo1AFrTK6uxc0rQ6L6PsQ2Bq40tTWpBo5UIkeH8UTRI0hJzQ4PS61PRcxIHwm78meOTVhAF8BUOjUeIc/8+VAoiShdwIiO51Msfjg8XAYSbJboWePNqCB/ApItjj1RC0CKlw4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719429204; c=relaxed/simple;
	bh=MWTBysIiZBjdlvLaaaaFkn1GlDBtZ5ei9Z3XWrXTXCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQty+3b9rFUlfsIx6x9qOYAX59OTNeSiqBGdgn1I8PKH91WxpT9+VLG4jK0HU+pDeFrMhMj0phSzkk+3RAj3KRLlZ4gjz5hB9GNie4lBXktuftG9qN1oL+FD4+G9+qQvDT+QaKvMnsb1dYkcN4bKYI85f385Mcr4Pj24foenLNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5EP0pAy; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a72517e6225so530235166b.0;
        Wed, 26 Jun 2024 12:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719429201; x=1720034001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbHp1m88v5P1bw/uDYtoRLbiy7jJybUGKhLATYsYsAY=;
        b=j5EP0pAyv3722cQmXdOd/wqJiheM4db6YLzu7Rhf1a1v2oqXKsm8SmUMOlIQ4eKzD2
         aV9AMKYCIyh/3WT4V6Pr2BrCHbiUrd6D1NUE6dyl9R/lELygFLVZf6FcOvGQ60vwQBYV
         EWRXFgP/2RKwL3gBTqj3Lu3JsvL9N08/g0jBcG3NGIm84BboqknhbEFlUtS9QDhnHTIw
         vHiL1gZkJ6iWHY2dBaQ4xooKjfoetdffuTUDj1A6Csc3QiA1B+M965Ag4DjDe2wLwjov
         vRMDrjJwTjfY+lKEk8ZxJn4uCWvMBgiVuyUXMDBqb3ZPbLfaj1bJDOvHNmUPLX7j9ZpT
         uf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719429201; x=1720034001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbHp1m88v5P1bw/uDYtoRLbiy7jJybUGKhLATYsYsAY=;
        b=M0zCOaVgjhNSPIa+iqlXXRs4pGq/YFO71XEiD4M8nGxDBToSah1KzumJu+fJ1ikGsy
         C3KlZyxcNTuKtToYQLdpAMf0tkEv/VmNzLqGpggfGNFK9RPzUu7TLFkOqEeaKGfko9lx
         f3m6cixArSljl+RuouedpgeNVTbKs5n3BtRevMJgafgdASFmvSSEuHMjjXW7Vu6us+Do
         9zsXZ/URsct6oIqOOr6tU/67ovsmJ2zTs7LW63ftKf+J+qiG5ndUar8lf8DSNlzgirXN
         ITsync785rVKSmFjfgzpmkuuoxcEMPLjEpqql4mmERnqtNPNkDOVVqL7SAY/R46I8Zb5
         XuEw==
X-Forwarded-Encrypted: i=1; AJvYcCVCH1TqeVqWbH3p4phQZWO7nsxINR4+4LQykeE+/koPRHG8qC79Zhodt5Yo3pGqw0cKeFd1p3z63z9WbvLaejKYkXfrwzXfvBiVH7yvQDCxvJIR0QsRII43mI21syy6fLFWDarJndr37EYaZA==
X-Gm-Message-State: AOJu0YxCZHWXPDzLk1Gb/NZ/90TNN4Q7mJLnYDEzx0bp6CLR7quZEMJp
	fzxkEcuQ3QQi1GT0vlyHckVIKZhRJtJ3fQXovzRXvk4OFH/7YLsA/tNhWwe+fTfo3C9uQ4UqUcE
	kr+D2qxPqCjxCOoKTaNHzPNe5ulA=
X-Google-Smtp-Source: AGHT+IEXp5RQKNfI9JqKuIBclAPVcd4xCVBCu6z7CwGa+cRrF9EVaQwPab8PcE/ZZKeA3pwviZCg+oL0UIWvh26ZbQ8=
X-Received: by 2002:a17:906:9c96:b0:a72:5598:f03d with SMTP id
 a640c23a62f3a-a725598f1dfmr749547666b.59.1719429201169; Wed, 26 Jun 2024
 12:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614163416.728752-1-yu.ma@intel.com> <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-2-yu.ma@intel.com> <20240625115257.piu47hzjyw5qnsa6@quack3>
 <20240625125309.y2gs4j5jr35kc4z5@quack3> <87a1279c-c5df-4f3b-936d-c9b8ed58f46e@intel.com>
 <20240626115427.d3x7g3bf6hdemlnq@quack3>
In-Reply-To: <20240626115427.d3x7g3bf6hdemlnq@quack3>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 26 Jun 2024 21:13:07 +0200
Message-ID: <CAGudoHEkw=cRG1xFHU02YjkM2+MMS2vkY_moZ2QUjAToEzbR3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
To: Jan Kara <jack@suse.cz>
Cc: "Ma, Yu" <yu.ma@intel.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	edumazet@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com, 
	tim.c.chen@intel.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 1:54=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> So maybe I'm wrong but I think the biggest benefit of your code compared =
to
> plain find_next_fd() is exactly in that we don't have to load full_fds_bi=
ts
> into cache. So I'm afraid that using full_fds_bits in the condition would
> destroy your performance gains. Thinking about this with a fresh head how
> about putting implementing your optimization like:
>
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -490,6 +490,20 @@ static unsigned int find_next_fd(struct fdtable *fdt=
, unsigned int start)
>         unsigned int maxbit =3D maxfd / BITS_PER_LONG;
>         unsigned int bitbit =3D start / BITS_PER_LONG;
>
> +       /*
> +        * Optimistically search the first long of the open_fds bitmap. I=
t
> +        * saves us from loading full_fds_bits into cache in the common c=
ase
> +        * and because BITS_PER_LONG > start >=3D files->next_fd, we have=
 quite
> +        * a good chance there's a bit free in there.
> +        */
> +       if (start < BITS_PER_LONG) {
> +               unsigned int bit;
> +
> +               bit =3D find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, =
start);
> +               if (bit < BITS_PER_LONG)
> +                       return bit;
> +       }
> +
>         bitbit =3D find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit)=
 * BITS_PER_LONG;
>         if (bitbit >=3D maxfd)
>                 return maxfd;
>
> Plus your optimizations with likely / unlikely. This way the code flow in
> alloc_fd() stays more readable, we avoid loading the first open_fds long
> into cache if it is full, and we should get all the performance benefits?
>

Huh.

So when I read the patch previously I assumed this is testing the bit
word for the map containing next_fd (whatever it is), avoiding looking
at the higher level bitmap and inlining the op (instead of calling the
fully fledged func for bit scans).

I did not mentally register this is in fact only checking for the
beginning of the range of the entire thing. So apologies from my end
as based on my feedback some work was done and I'm going to ask to
further redo it.

blogbench spawns 100 or so workers, say total fd count hovers just
above 100. say this lines up with about half of more cases in practice
for that benchmark.

Even so, that's a benchmark-specific optimization. A busy web server
can have literally tens of thousands of fds open (and this is a pretty
mundane case), making the 0-63 range not particularly interesting.

That aside I think the patchset is in the wrong order -- first patch
tries to not look at the higher level bitmap, while second reduces
stores made there. This makes it quite unclear how much is it worth to
reduce looking there if atomics are conditional.

So here is what I propose in terms of the patches:
1. NULL check removal, sprinkling of likely/unlikely and expand_files
call avoidance; no measurements done vs stock kernel for some effort
saving, just denote in the commit message there is less work under the
lock and treat it as baseline
2. conditional higher level bitmap clear as submitted; benchmarked against =
1
3. open_fds check within the range containing fd, avoiding higher
level bitmap if a free slot is found. this should not result in any
func calls if successful; benchmarked against the above

Optionally the bitmap routines can grow variants which always inline
and are used here. If so that would probably land between 1 and 2 on
the list.

You noted you know about blogbench bugs and have them fixed. Would be
good to post a link to a pull request or some other spot for a
reference.

I'll be best if the vfs folk comment on what they want here.
--=20
Mateusz Guzik <mjguzik gmail.com>

