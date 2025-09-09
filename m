Return-Path: <linux-fsdevel+bounces-60667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A297B4FD7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 15:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A041C6291C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 13:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9532B34AB15;
	Tue,  9 Sep 2025 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN6L6Nl1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1293451A3;
	Tue,  9 Sep 2025 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424951; cv=none; b=Vvo7Ntkupk9RIiRF/cuBJ1O+ABnKvdk2kJP+DnrJ5vi5d1M+JT/NH1xJqkavquiS4Pt4bHYqGk3C3ZvcfkJIuC6JdvdwrbmkkLtpMS1ry3IrTuMH+7gVKbnqCdt2BLatIlHtI2sx7dpADAvCW6rQmjALrU5dc8qZd0hpCEuTMiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424951; c=relaxed/simple;
	bh=0uqewsNJRppxmhLbRxkhsb06qh232+OirkSTxVQyuak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=deKxD3i6yhzLNz8tD4nyAFaHh7e1TPwkD3if5PC8x6QbTeteYfZKYcUE0F1sx/dE0MLxbvryyqN6ogQ4+hqsDJu2cAXUOb1WMbaFGzlVvWZTfg33BZR7ctsPR6lHqz2CyJfqlY+ECCv0sOub8+Nj3HuOGuq7WYuJLbw+k89bhuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dN6L6Nl1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6229f5ed47fso4809289a12.1;
        Tue, 09 Sep 2025 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757424947; x=1758029747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/DFjvabh+Crv2HI1L5X9lsS0Izjk3JHWzvsY2mfML8=;
        b=dN6L6Nl1pVM8uR0zQyW/sx98qoLNa5xjWbAKXDCJGeSoX9N8j70gnWrgaGulIUjSaw
         OFHMZzY61OpWM3ZoXImDuvkMlzy+O0SOpWj69jIPj+KusSthAxdnD2Brk5Es6f//c2B2
         93UAQGRsy+GdaxS2RLVgzKNJA+IDiFQ2TBbm9SJ67vaaYrUmoRY6uiTTdskKTDWUMQ5J
         GQmPwMHWukYToMeSwfI3nvFfTUZXGMNG0ail1CEszKIrqoruTfNeF2TU/UkYrFgJRcvd
         /2A5AfBnAiJ0Q5TDlASa+a2UkvadisdDsvdcjpgdmJPf8elf2v36hjKureWAPs5sRwKn
         qMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424947; x=1758029747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/DFjvabh+Crv2HI1L5X9lsS0Izjk3JHWzvsY2mfML8=;
        b=JYUqkqy0iDapfRXkLyRySGYQC3gzl278jK+PiVpELZ8QZZRZICbrHDqYNOZN4Xr589
         vM1W/tZsCWqNfXFFcg89DcaKybogrLRVnJmUL2M1qJzZQ463yKIkVoZd8IKvNlSJkICI
         4e5HQaQUQjGLt1s7AjoDqQExHVMbDGN7jYZuzblpcmfufWp8k8WudbkaAl27qwKPGhq8
         3GJg/+bS42av1xxE7QxsYwCDQkcSGJZjWV8ifWeVAxcToqBoSLrYpIHPfmTdnNyhYgpH
         h5QV4PQqjatUdvvBLUk0q/u5F/021peWoU6C3cqVAiuMq2EXQ1vxmrI9scZlxLoNngJZ
         m9HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK3gn88gploEkVeGZ9Pf8qAVGt9x5/m19qU98whUBf9BiaQw0HyvRNG7wrjQgUVEARW6iVb3n+QLeaKOlo@vger.kernel.org, AJvYcCUKseGbXvDpktAyPDsynjR8QOf1NaEmivSLmYz0tG4tKf2kjW9fPjDA3fBN6efEKYNRnjCj6gHfWvYHvfuWjY6u3w==@vger.kernel.org, AJvYcCUxlJsqC5fHiJZaAxUjxPcoeHKmAr/hDrSf8PZHz4U0V2svs8uXZFVxl5AqSOjO6jB5eqDha8NapqmI1h9e@vger.kernel.org
X-Gm-Message-State: AOJu0YyreBdPG1yqFt8Uytp3mKJiLay8fvHNsplWNOpLqnGSTiC2070f
	ZJW3tntP1X/HrqywKziLn+Hx/np1ghrx/1jLApoNY+u75K2CmdLa5KyZ3FeCB57Ufu5BdzRW59Z
	lMBgImIzn43RhglsvVQiwDFvt1YAyVa4=
X-Gm-Gg: ASbGncsySZYjo+70/8kvvmsEUezfk8nuDaYlXSxwrF7pU5yPnTNFuZmAnURb7z2ZWN/
	ZieGnk9yF5Z/c7dvIpXfmlgPi2IauFu7gF6ZMXjWRyo9wLveSXtZFWTkPrVvoVjejkSf70ThfAC
	p2cMNWFFx5FeEImnpvDfTbVqz5+1nnTrCFpCWfqqL7FelgcnHjGtxiQ2QV9c6MFRoEbYwnmYE9M
	fTWQzo=
X-Google-Smtp-Source: AGHT+IGL5tn8Jf0e3o9yUCm2+CbPk2HiFscLaxC8amo2qQeERvPZHlpWN7h3oq+c5wj50rCLKXrsJliEBfTo+xGAy0w=
X-Received: by 2002:a05:6402:27d3:b0:62b:ae0f:11cf with SMTP id
 4fb4d7f45d1cf-62bae0f287amr2866455a12.19.1757424947274; Tue, 09 Sep 2025
 06:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909124222.222945-1-adrian.hunter@intel.com> <20250909124222.222945-3-adrian.hunter@intel.com>
In-Reply-To: <20250909124222.222945-3-adrian.hunter@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 9 Sep 2025 15:35:36 +0200
X-Gm-Features: AS18NWAymEKtcCowmWVyxkQJgVDpF4mASLmZGIlnJDFe4PeOlMb9bOj0SXJwX9o
Message-ID: <CAOQ4uxgSb2cOj0-H5oCrkXPcD=_i81qvRnS0S+UdLLWEdYRjhA@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf/core: Fix MMAP event path names with backing files
To: Adrian Hunter <adrian.hunter@intel.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:42=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> Some file systems like FUSE-based ones or overlayfs may record the backin=
g
> file in struct vm_area_struct vm_file, instead of the user file that the
> user mmapped.
>
> Since commit def3ae83da02f ("fs: store real path instead of fake path in
> backing file f_path"), file_path() no longer returns the user file path
> when applied to a backing file.  There is an existing helper
> file_user_path() for that situation.
>
> Use file_user_path() instead of file_path() to get the path for MMAP
> and MMAP2 events.
>
> Example:
>
>   Setup:
>
>     # cd /root
>     # mkdir test ; cd test ; mkdir lower upper work merged
>     # cp `which cat` lower
>     # mount -t overlay overlay -olowerdir=3Dlower,upperdir=3Dupper,workdi=
r=3Dwork merged
>     # perf record -e intel_pt//u -- /root/test/merged/cat /proc/self/maps
>     ...
>     55b0ba399000-55b0ba434000 r-xp 00018000 00:1a 3419                   =
    /root/test/merged/cat
>     ...
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.060 MB perf.data ]
>     #
>
>   Before:
>
>     File name is wrong (/cat), so decoding fails:
>
>     # perf script --no-itrace --show-mmap-events
>              cat     367 [016]   100.491492: PERF_RECORD_MMAP2 367/367: [=
0x55b0ba399000(0x9b000) @ 0x18000 00:02 3419 489959280]: r-xp /cat
>     ...
>     # perf script --itrace=3De | wc -l
>     Warning:
>     19 instruction trace errors
>     19
>     #
>
>   After:
>
>     File name is correct (/root/test/merged/cat), so decoding is ok:
>
>     # perf script --no-itrace --show-mmap-events
>                  cat     364 [016]    72.153006: PERF_RECORD_MMAP2 364/36=
4: [0x55ce4003d000(0x9b000) @ 0x18000 00:02 3419 3132534314]: r-xp /root/te=
st/merged/cat
>     # perf script --itrace=3De
>     # perf script --itrace=3De | wc -l
>     0
>     #
>
> Fixes: def3ae83da02f ("fs: store real path instead of fake path in backin=
g file f_path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Feel free to add
Acked-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 184f3dc7b03b..e203b8d90fd2 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9416,7 +9416,7 @@ static void perf_event_mmap_event(struct perf_mmap_=
event *mmap_event)
>                  * need to add enough zero bytes after the string to hand=
le
>                  * the 64bit alignment we do later.
>                  */
> -               name =3D file_path(file, buf, PATH_MAX - sizeof(u64));
> +               name =3D d_path(file_user_path(file), buf, PATH_MAX - siz=
eof(u64));
>                 if (IS_ERR(name)) {
>                         name =3D "//toolong";
>                         goto cpy_name;
> --
> 2.48.1
>

