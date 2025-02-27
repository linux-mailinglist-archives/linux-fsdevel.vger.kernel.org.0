Return-Path: <linux-fsdevel+bounces-42786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2CFA489AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 21:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2EFD3A718E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 20:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076EB26A0FD;
	Thu, 27 Feb 2025 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="2/qv77Hc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65D71AB6D8
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687524; cv=none; b=Ie0DW08kWYNgh1zCQ6zc3rERSweuqFFdTTjoX/TsdaPXGDX228AuACQTsPKY8mF2tHnDYBIRfDykzMAyU/rnP/c4kymCG4Q5vL21RBGG1X8CiCz+HxOBae38EMtXjQ126Dly8womm4iRuakIc+cZuPQvv6HsWQFGtQra9eBNclg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687524; c=relaxed/simple;
	bh=00JAUNRBO82Jpj6i/1z3tlutIj2CrE3y5m0nLjmSaZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcPFyu9CzWrbjErx0SSfDWy5jk8laMA9s4POLJK2XHF0mh0bSXyf5KjhjzSu/WqMiyx7+Rl5R6Bke0wmKqZTfpOos1GSW/8LhmHRANcXEy2mm7C8y7f9+T773fdVHrJRsvjuo7NCcofUQ9ww8qsJgDjLPkH93VkN/RtTRfiN//c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=2/qv77Hc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-219f8263ae0so26197985ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 12:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1740687521; x=1741292321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tav4xqr1XQO33V7brGh1x4z4ojxCyIzenuMBnymkdj0=;
        b=2/qv77HctFNnDRGEE65YYJ+FiL40u8gxOYdCD1sNMtwQWMQKXMtMVllMBbd4EODeh+
         Ix0oeiltrQ+DXbMQX7ISI1jOV1iDvM1+N/yZ5uqdC2xRf0IsUEocQsK7wckHmoA1juLY
         5JU+tAd/rhqkJPXKPkOaO4KV+EqG8oJOly3YCbf1mB9JD02YAb3T0wRo62N0Un4BbeyN
         lgO8fpo/W6oepmT+K/5uRIq5OkFP/IVvNUhNEHQfS3qwghS9/l25kuqtcS5cdrfTg4X9
         PTV/tbgmVUpphMz3m5ZgueHb8M3IJZZuLK5Z0MYsmgwyqw0qxp8MG3i0RCSIR1Dedg1z
         WoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740687521; x=1741292321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tav4xqr1XQO33V7brGh1x4z4ojxCyIzenuMBnymkdj0=;
        b=td9YMFQIzHFsnUX85Vxd0lHqOfhkywufRW8wXEZwZc5hnStIcHHmRBEOGyNOgjasv6
         HoL8YHvcELtEC4Quq74UDhrDLEvmLi7oRJpbLWQD+ZVXvD3RnoAci/XthZpzV2HlMyRp
         V3RlvYvJ5W5BXVlO9wM+VeAKMcUKNcfbz/oZJd1YjXP22SVnYM8xs8ej52NODtEzScUG
         YrhEq7NCjvJ9XzQBG+kZ8g94XJCNk/eWY7+ROYOtNEIO8GLqCgI3qXdO+PdPGnx7fiD/
         5e1S9hm6/ICDFwvcn7nNrJn5ewy4rUxYN6lazLLBgOj3OF+jr6kOHWnGxn2Paxf0mzpq
         2RMw==
X-Forwarded-Encrypted: i=1; AJvYcCVVT20I5pSLUXZ+a/8ChSq5mcDPQdm5ilDZpROxSqOnLj5MCDd8HR3vQSCCpZztix/XmeyM9Iwq6olWFnj9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75rJUN6hMLe4/OlD4SFmm0sOX9GKWw7Ven/q64UpWXErNwqHu
	9W6r566QFlqg+1rt0YxcQWZohvL3T+IcL2Wi1m55RDFC2LgGpXTv6qbgxf5b147iu03aBjCR+Vu
	sP8SN2piOyTd5UvuccSFRjU1U8wGo9/D3XNwZMC2mbyT5Xb3FUQ==
X-Gm-Gg: ASbGncuvwJXY+EK2DmoTCLUyIon8Q9whoh1pZaYXHsCTOxAOZVnQQULekXpy4hv3ZC3
	F05Dk/s7HIS+yUeP1gzXuH7jTBQHt2N08Pa0cE/J46J1PJFcqNkQV6iSqB9qa9mJEP3Rh2S0tnO
	0EIC727Em9YjX6XO3hCHQ=
X-Google-Smtp-Source: AGHT+IEwPeSZd+nviOPAGSCL8vdQ/b8GSfSOVyaWhXhLX4EBlFjIM1euIMkWJiJ4yw1/u/ogtDQea2xftPItkEUVjDw=
X-Received: by 2002:a05:6a20:4326:b0:1ee:e6a5:e9ba with SMTP id
 adf61e73a8af0-1f2f4c98541mr704801637.9.1740687520989; Thu, 27 Feb 2025
 12:18:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224180529.1916812-1-willy@infradead.org>
In-Reply-To: <20250224180529.1916812-1-willy@infradead.org>
From: Mike Marshall <hubcap@omnibond.com>
Date: Thu, 27 Feb 2025 15:18:30 -0500
X-Gm-Features: AQ5f1JrVpdhsBtW-z-FEoj6BWJVTUi2KV6HsBGiyAgHXFunOdlVyR66RkDE49jQ
Message-ID: <CAOg9mSQ2o0zaBhY37bBfR9CDKv=-EY3SzxEh0mFYiNvEjZaZKQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Orangefs fixes for 6.15
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org, 
	linux-fsdevel@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Howdy Matthew... I got your patch and deciphered the note
about leaving out the include files. It is compiling on top of
 Linux 6.14-rc4 now, and I'll let you know how testing goes...

-Mike

On Mon, Feb 24, 2025 at 1:05=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> The start of this was the removal of orangefs_writepage(), but it
> quickly spiralled out of hand.  The first patch is an actual bug fix.
> I haven't tagged it for backport, as I don't think we really care about
> 32-bit systems any more, but feel free to add a cc to stable.
>
> Patches 2 and 3 are compilation fixes for warnings which aren't enabled
> by default.
>
> Patches 4-9 are improvements which simplify orangefs or convert it
> from pages to folios.  There is still a little use of 'struct page'
> in orangefs, but it's not in the areas that deal with the page cache.
>
> Matthew Wilcox (Oracle) (9):
>   orangefs: Do not truncate file size
>   orangefs: Move s_kmod_keyword_mask_map to orangefs-debugfs.c
>   orangefs: make open_for_read and open_for_write boolean
>   orangefs: Remove orangefs_writepage()
>   orangefs: Convert orangefs_writepage_locked() to take a folio
>   orangefs: Pass mapping to orangefs_writepages_work()
>   orangefs: Unify error & success paths in orangefs_writepages_work()
>   orangefs: Simplify bvec setup in orangefs_writepages_work()
>   orangefs: Convert orangefs_writepages to contain an array of folios
>
>  fs/orangefs/file.c             |   4 +-
>  fs/orangefs/inode.c            | 149 ++++++++++++++-------------------
>  fs/orangefs/orangefs-debug.h   |  43 ----------
>  fs/orangefs/orangefs-debugfs.c |  43 ++++++++++
>  include/linux/mm_types.h       |   6 +-
>  include/linux/nfs_page.h       |   2 +-
>  include/linux/page-flags.h     |   6 +-
>  7 files changed, 116 insertions(+), 137 deletions(-)
>
> --
> 2.47.2
>

