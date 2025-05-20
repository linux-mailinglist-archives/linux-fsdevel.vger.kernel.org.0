Return-Path: <linux-fsdevel+bounces-49468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCCEABCC73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 03:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9FA4189CC57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 01:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5C7255F4D;
	Tue, 20 May 2025 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TCmOCbIO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A0F2E628;
	Tue, 20 May 2025 01:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747705795; cv=none; b=rWsIFvMB7nCHcs7bab2ISJXzYebHFgLl4WV0AaRpUu47I7tZak9erDxphrhlBEN9dq3peMo9VpWdVU4pAlumtfdGvsxXKbsKHcRZpCABflfDAI9fn/jjntb0xSsXY15PRwj7S5YjeVyMLx6T2p4OKd/9nJJqvLtdhFyMyuPCc2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747705795; c=relaxed/simple;
	bh=tjgdZhN+OuEJ5yG5UCg6mN4vKwI0aby5N97gzGTuyCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbEwF53UkkLMhq/zku0JvaKOXY8hKw9Mw0n6i/77tqoeWxLZb2RuMZkEyrd18xfoIjYgozBlu7B0Xgl+xp8nUimKXdOP+lWDg0e41d8vOYBbV2sJUhvT3FexW62R54617UlOgPES2TjvDTqKTgrNzePgyHx6EpJwa636n/CPyKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TCmOCbIO; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1747705784;
	bh=tjgdZhN+OuEJ5yG5UCg6mN4vKwI0aby5N97gzGTuyCk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=TCmOCbIOgQIeXikQSQB1ozY+xtpmBVyJmOYjAJ8T9H5njX6fBX5Esj2e1sVwLzqr9
	 AZcEncTlsDx/wXJTnsGoID2qExBM0nFy8UrH+Rjrgei/IV8dpO/FvsEc/W7kllQTXx
	 u1uu+Ifu3yBg7F1PICOOBfu6ddboYagg1RM3oxVw=
X-QQ-mid: zesmtpsz4t1747705779t2221b87c
X-QQ-Originating-IP: le8b3gHCP2RQLlA9jyaj+1lCF7gm/Q5QYaSKLrC7a7Q=
Received: from mail-yw1-f172.google.com ( [209.85.128.172])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 20 May 2025 09:49:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12257961901285456275
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70ddcdba474so7782387b3.1;
        Mon, 19 May 2025 18:49:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfwfTDsWSgirS12tEreFX3GL7RtcCK0fkrA4TUEa8GeCBB0WWoq2BQSzvLaV2WXWcavmB58829SMQ=@vger.kernel.org, AJvYcCWy2kQWdd1YSk/JEu6d3/rXCmEFhaGE233calE1fdVsdh+UJSpoOZe54ydM11HrpUokgdkJJg7KxjcybTIMGg==@vger.kernel.org, AJvYcCXyDW1KHNi/TkEExgVCOuAOFgNVdBpRCmYZ4ln+UEg2PLLUFf0bc3Pr82sPNiLei6xhGyZjibl7ed0j7VQ4@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWEkvEoK8AGh1lvWkfFI8Qn2qBuAWuURsoVjBI5Oyg8OJ/Jun
	dvwA2GJyrqOOA+zJDKblkRdGWR96trgpGZlI4fNmkLGJyoE8nEbx7HlHUGIQJJ4ECCwGNMeuTSn
	M246pAkrgu0BskuQz9t1kEyO/2w47LZ8=
X-Google-Smtp-Source: AGHT+IH810CjoYVfbOkhgjig/gQ9xaKS6QFeP6dyioXy8QiiAJzESs18soWLNXgX4ngPE49M6E9sOXnxpQYg9yXXdt8=
X-Received: by 2002:a05:690c:ed3:b0:70c:b882:2e9 with SMTP id
 00721157ae682-70cb8820581mr152005717b3.3.1747705776947; Mon, 19 May 2025
 18:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507-fuse-passthrough-doc-v1-0-cc06af79c722@uniontech.com>
 <20250507-fuse-passthrough-doc-v1-2-cc06af79c722@uniontech.com>
 <CAOQ4uxiMh+3JqzqMbK+HpFt-hWaM6A2nW3UHNK9nNntDRkRBeQ@mail.gmail.com> <87tt5giqz0.fsf@trenco.lwn.net>
In-Reply-To: <87tt5giqz0.fsf@trenco.lwn.net>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Tue, 20 May 2025 09:49:26 +0800
X-Gmail-Original-Message-ID: <31BB50458BC05D76+CAC1kPDP9d+vQGk0Y5OpDp88b3KLot0N_h=kazQb_G5nGtoCiVQ@mail.gmail.com>
X-Gm-Features: AX0GCFt18X2UERCjgrGPdUs4efMieIb2MBJHTjaEDO8l3Jo_-vV7H74ydc1xpwc
Message-ID: <CAC1kPDP9d+vQGk0Y5OpDp88b3KLot0N_h=kazQb_G5nGtoCiVQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs: filesystems: add fuse-passthrough.rst
To: Jonathan Corbet <corbet@lwn.net>
Cc: Amir Goldstein <amir73il@gmail.com>, chenlinxuan@uniontech.com, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Bernd Schubert <bernd.schubert@fastmail.fm>, Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: M4B45z97fsbxzGGTWoUxZYuYF+xIatUkGVd5OComXI7tqA0u/WUyjV7H
	gBuqsk3thLbP8HIMvqmwL4ZZ/lDNX/014QhULlunmJYHYKbr+TpDeGB1hGyX0m58TiJPkxm
	f/a2qTZtTf7seQRAFQt2NGL8sdepW3v9uQ6FRki5ipz4qP/ms0KCAnQzIz3nuPfpaY4UORk
	mbwcU7qxOXnLqjq084d0ymQgSKwkgfKIuvt42OfMej3AFvCM3fHMYL8BMBCuWi7X2m8DvQQ
	28oNag/AXq18yDjrrXvV8KWpKQHyBoVYcz0VRfjcd1RsgsxbXVT8cTMYgO6FXM8xuqi3vt2
	lvGBWNaKfjXwVhWvXgXEXVnkBGTM1hBCDlyPsEZhho20jymuBlgsOQ5fvP/bA2SBjwou7xr
	xZAG7XyK2+2pnUPULJAnyKkHpTcr5U55NRYZIr140EyOeElsD9YIWTicrRZB/nX/LFJTMN7
	hD43WdbVpGxBDpA9wSAqZyOW3uHRV/0jKPoxd/+gcY5g8Q75L1IQ2zcWuSYSuHDx5XQ74Uc
	ybget+H9pQcuz64k3LE5a3bu3boQ/+CoQl1H2OU7Q3mumgryy7exOc2Dd1gDswHbtoKguqM
	gf34TpBEQmSQD3nVi2gt5fgUTA8TSk6nXPTa/KDuv4uDBwh9Ro4sukFXb9poxkfeY+uyRaA
	xKsozVEm9SJ/rzY/i45EHFdJI31GYOQvEnUGEbGCJZU9RI72Yh8pJk29tr+kpuvhBrFWBfa
	iuTLp2rh0nO6NYq7Li19o+W90eJgkVK0Z+kYOfUdRnUDtp1ntCvGB2NlryiSo2fHsF30ukt
	7nCfatemYvVwHGHKHRqOTh/nGdfMhBIsV/0VhVsB1kbcBbHnLjM0frUJyZxEYR/2oUtqmaH
	wnEGQSZTL+CL7coOAB3r3rjD/sYKV9fVT2AsNuhIk30rH2UTCYXuEyPD3q3qZAHEX+zYL3w
	0y5CBk+u270imcukfo2aJZF/v9tx/jv1qBEseVwyD1is9oDpMxgdKdh+EGJ6AyOwmFe3mEC
	UNHrbkJXR3l+86rcFZNyS87nFTT8OaBo65FIqvfA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Mon, May 19, 2025 at 11:02=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> w=
rote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Wed, May 7, 2025 at 7:17=E2=80=AFAM Chen Linxuan via B4 Relay
> > <devnull+chenlinxuan.uniontech.com@kernel.org> wrote:
> >>
> >> From: Chen Linxuan <chenlinxuan@uniontech.com>
> >>
> >> Add a documentation about FUSE passthrough.
> >>
> >> It's mainly about why FUSE passthrough needs CAP_SYS_ADMIN.
> >>
> >
> > Hi Chen,
> >
> > Thank you for this contribution!
> >
> > Very good summary.
> > with minor nits below fix you may add to both patches:
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> It looks like these comments were never addressed ... ?
>

See https://lore.kernel.org/all/20250507-fuse-passthrough-doc-v2-0-ae7c0dd8=
bba6@uniontech.com/

Thanks,
Chen Linxuan.

> Thanks,
>
> jon
>
>

