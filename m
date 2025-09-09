Return-Path: <linux-fsdevel+bounces-60666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDD1B4FCB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 15:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7BF4E72B9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01909340DB2;
	Tue,  9 Sep 2025 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrW7QQry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4FA337687;
	Tue,  9 Sep 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424282; cv=none; b=d2exVYFzgdyZemr+UP64CP591qOB76k1TupoxVVPpePMSOySbVpDCL7CpzNkJ2IkHYP4yJzlmoaQHkpy+hjkOl2Hudmv4c2k5nXihcD/lAQHjFUx3wTC+k8xmafso+1IbwWdzxPDe9j2uG0MZWbL7WN6Gz2eNAboium3SeENqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424282; c=relaxed/simple;
	bh=fpsjqqNDSQjgsDI+nQ5ZcLwqq0EdVpOkXCEPydJUMJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZPuO1WJlQw1b3kfZG6cUIUx8eOiRYyIVogzp7XuWuEAz/0W1yxO1ox6yIbfoqEiyGWYSu62P1G7nDn2gEZwqETDiAXYh4M8DmzhaPHDz4bj7dPlEka5cAZKYHSHqRv+kLnWihxR+S9edw2zZ6diGCyoAoGp97TVwSf2AYLDESI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrW7QQry; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62733e779bbso2684878a12.1;
        Tue, 09 Sep 2025 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757424279; x=1758029079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9W4mhSrPI67T8KA1IekV94x2JuZ4WwTJiWrQXPvqhRU=;
        b=lrW7QQryGLAteT86YVnv0+0mjsCEVJDMLgZTpsiBPHc8rUqxxo356s2gfoJn92xMS0
         Kb4YHS8KmBLBS9psrMEKDhVMQ1CMLByVRgGMexdm5CuK4JFMiNuvfPf4JXDDpsrtoqF2
         7twevgQZqD+qEX2Yhp+WMj2THQ49hOQ5OAJZN6mQigrkJLO5apuSvOzuEgwZg/nfQq7I
         ID9kpQeM8frISknSYec1ZVBb+oLLB6Pj5npnoirtB4glAFSWr9HvSTpXFWgrWmmsMq4D
         ZYaLNCyoo1HlXfcE2MwauMeKnXeGpjhn4K8mjZRytDLMUJfK6EKKSkBtzKPC6Kyf76uB
         LORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424279; x=1758029079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9W4mhSrPI67T8KA1IekV94x2JuZ4WwTJiWrQXPvqhRU=;
        b=skF5DXQFE87k8qysbh4fH8jEOFNNOZTCDIdQ/LWAF71ro4ijSwV5F/x7MkExRNsvJj
         llNwLlB6lUfB+RUTowhqQUu5GGlfNiWiWOaOwEt5o/Ozk4rx2BNW8bo32zj/vaXito1a
         P0S2r/FXyOSEIrkWNW09zHs3ooSR+gh1QwsN8zRMMzfcVgm+W0LvIbzIVN/snNTjcuhh
         utyd3lNW06j3rs3TNqTp0ZRIbtlX0p3xgO79NhGF1VimQl1bWuETe8myi2CPA6KNJif4
         LGHalM+Xwi1Ee0JiPEsFWUVC3KIJkKy9xRcok7lYndGQSo1WKD3l5DjN/dxYJDt+ZezJ
         1z4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYZNl9S8cQ96To6phfxuQVSbUf816eRj8YnFBi0W///cOXlmGxtsSPpkEohfKTukefXbws0vO5lsUGb86L@vger.kernel.org, AJvYcCUihu/EAB0d1YByT9D/ka4mfQGOzwovHyDeoEfIxt3LKOhUsMUXpdvptFUSFXx3FszybgyIO5oB2LOxCJHE@vger.kernel.org, AJvYcCXqP40dE7jldv5sWFM4XvZt6oREKOxIwcj36ioyYaAnvcDYbXxhERTgVXfVBf1E+NuPVEqTcItoy2IBGW32L4adNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl8/JxYbwIWWieP9ejEGdXPQdoI9pdIp+gKrql8gI3WDllUcJE
	MIWRSAA+3fHYYgtnGVb9rUcflIq1NTxa+o8iu1WHmyznO9BMHAOhC6BL+nGnYhnZIZE8IoRarLw
	fM21g2MKxZxeNOZDnt7cFp9nyJXVuBtU=
X-Gm-Gg: ASbGncsdpxdEhWgg8dxeOIEags+v4bDpaPzthbOquKSkl/9ln2QnrlTVXjG76Fdv0+Z
	Ci3rh1XRX20dIZJTB4sDZcV6GEgw1qgFNOABOUsST3NyUqsFmKOyBhlMxIIE/pHc/Ke5ZY9dhD/
	cBq+FQ+H2+f4O/SLg7Mor6PjxuxLX1OZEAw0d/uDHC+LT/Zm4J10lK5Cflt0n+34RjykRjs3MpP
	6yWULI=
X-Google-Smtp-Source: AGHT+IGl4XI+ZtmcJ1b64ZTNKqM1k+KAny9TAWMyaeqEg3Rym5eMWtwHDLAMkso27/WfxgPoUDSj8SfWefKhWoRlFZo=
X-Received: by 2002:a05:6402:35c4:b0:625:6523:293a with SMTP id
 4fb4d7f45d1cf-62565232d22mr10065761a12.8.1757424278458; Tue, 09 Sep 2025
 06:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909124222.222945-1-adrian.hunter@intel.com> <20250909124222.222945-2-adrian.hunter@intel.com>
In-Reply-To: <20250909124222.222945-2-adrian.hunter@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 9 Sep 2025 15:24:27 +0200
X-Gm-Features: AS18NWC2CR_cImOupCNdStAa9jMaQbZXVOFvOPgo46BzjSbVk9_s0ewaVBBZPRQ
Message-ID: <CAOQ4uxiNdXXvX6gRtNk6bg17ixoUMkeJ70N6hEHVtt1vQz=HOA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf/core: Fix address filter match with backing files
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:42=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> It was reported that Intel PT address filters do not work in Docker
> containers.  That relates to the use of overlayfs.
>
> overlayfs records the backing file in struct vm_area_struct vm_file,
> instead of the user file that the user mmapped.  In order for an address
> filter to match, it must compare to the user file inode.  There is an
> existing helper file_user_inode() for that situation.
>
> Use file_user_inode() instead of file_inode() to get the inode for addres=
s
> filter matching.
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
>     # perf record --buildid-mmap -e intel_pt//u --filter 'filter * @ /roo=
t/test/merged/cat' -- /root/test/merged/cat /proc/self/maps
>     ...
>     55d61d246000-55d61d2e1000 r-xp 00018000 00:1a 3418                   =
    /root/test/merged/cat
>     ...
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.015 MB perf.data ]
>     # perf buildid-cache --add /root/test/merged/cat
>
>   Before:
>
>     Address filter does not match so there are no control flow packets
>
>     # perf script --itrace=3De
>     # perf script --itrace=3Db | wc -l
>     0
>     # perf script -D | grep 'TIP.PGE' | wc -l
>     0
>     #
>
>   After:
>
>     Address filter does match so there are control flow packets
>
>     # perf script --itrace=3De
>     # perf script --itrace=3Db | wc -l
>     235
>     # perf script -D | grep 'TIP.PGE' | wc -l
>     57
>     #
>
> With respect to stable kernels, overlayfs mmap function ovl_mmap() was
> added in v4.19 but file_user_inode() was not added until v6.8 and never
> back-ported to stable kernels.  FMODE_BACKING that it depends on was adde=
d
> in v6.5.  This issue has gone largely unnoticed, so back-porting before
> v6.8 is probably not worth it,

Agreed.

> so put 6.8 as the stable kernel prerequisite
> version, although in practice the next long term kernel is 6.12.
>
> Reported-by: Edd Barrett <edd@theunixzoo.co.uk>
> Closes: https://lore.kernel.org/linux-perf-users/aBCwoq7w8ohBRQCh@fremen.=
lan
> Cc: stable@vger.kernel.org # 6.8
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Feel free to add
Acked-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index fb1eae762044..184f3dc7b03b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9492,7 +9492,7 @@ static bool perf_addr_filter_match(struct perf_addr=
_filter *filter,
>         if (!filter->path.dentry)
>                 return false;
>
> -       if (d_inode(filter->path.dentry) !=3D file_inode(file))
> +       if (d_inode(filter->path.dentry) !=3D file_user_inode(file))
>                 return false;
>
>         if (filter->offset > offset + size)
> --
> 2.48.1
>

