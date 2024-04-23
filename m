Return-Path: <linux-fsdevel+bounces-17525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DCE8AF454
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 18:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDC128CA67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 16:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44CA13D250;
	Tue, 23 Apr 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiX2VGaF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2321C2A1;
	Tue, 23 Apr 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890233; cv=none; b=AX/HZGYu5YWUqMMw+0/l7M5vVDp7O8G8uZARP4Gr41QzH/w35UAinZKf18WDYn6verG50RR8RYnTIao7WGtOjP41TEgnsyLyxRZlrkmsQY/kjMwJSpOpWc5hzVtCyeuNX7mIb8+Lvun/CNgM/GwvjCsIUIU2UR4EdmqqPJcgvH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890233; c=relaxed/simple;
	bh=CmjlAmsHarxIiEWsFge6NmJfEnkNPYRMvN2/N4GbwAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEGGnigBFcef21dY0t5rafl9wu4ko/XVbJPW8E8X1p3hH0xqfWxAJyvD5Mk2Ts5yuh/PkoInrl8An4+s1POeiCAvNLSJiDRHi9k7Vm8970iUsoP9CE28POADCcaNgbe4GrzGBgh7LvM+za+bwLjty+nZ91vU0We9leA3CaxgU8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiX2VGaF; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51acb95b892so5042353e87.2;
        Tue, 23 Apr 2024 09:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713890230; x=1714495030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LatJzjJ2Zy5Z/X3OvFMvzgLag5wvzypiR/T5sSxVxjo=;
        b=TiX2VGaFrQseGaRZS28pA7MYexjbpdIvUALR6cq+MuijHacP5FE+nIWNJMfEo6uVjh
         B/GtH2G4relVMBwZUq91luyL3bgWXT+O517H1dAB8FFyH/ezp0cjuVYODWjOtz5333Ar
         z8xasJd0TM11By/TWdRyOI21DBpu2C2ZdsjNed4sPfd0qzoVDDImxtUhU4VVzW2jPgn3
         4vvzuW0xmbk8ZtEmJ3OetOYrAsP6ayzwober/rPHQEp1tCbb6KwQOg5+M7sTUiaB6khH
         IrOIYchXne4dLBY8qmvOaQPGYUu3u5DXkXHBcMaUJq+0f4VQaM/+CsZ4VfPOnClFHbb1
         LS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713890230; x=1714495030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LatJzjJ2Zy5Z/X3OvFMvzgLag5wvzypiR/T5sSxVxjo=;
        b=nrU5R8yVLFSXrflmNNGEZyuIgV6QtGpjoAsr8PtHSnqVoMOvC1//ltQsPTKSq3V53j
         AeszXcjDfblsnBr9RiSBSaDlhWYnshwOViZntxqsmqVGn0ePlLs9BvBKrahTdy1ZTdk5
         RPaZOMwgdnmx4OQSd9LDtCyPdFAetofw/Y+nqaWPkxneEf3I2N99XgHHdCM85pZ2Tsh6
         XHuH8S2EHXqMSetwrHnFja1Kg54jJvLa31en4+T6mEOagovmAs/KwD8NSXbUn6WkAl8/
         O+BWkgU4cJFlTcehW+aUeH2r6rYIyy2GteHn17A30no1nJp1rUdKn3Nyw4iBK5RFytwf
         MCxA==
X-Forwarded-Encrypted: i=1; AJvYcCWy8aDjc7w1vEAguYe1BJ54Bejt56KTqRNrJbzF2xJlNis5S7IXtdPVMckEXsAee4ciKNXCWcYuyoRb7410AEReG2EJJJHQUxC8umQ=
X-Gm-Message-State: AOJu0Yzs2sB+XPTKsMXPzz7zmfujO0QG3j60DFf+bviS090rllGuVQS0
	XkcWMOewwKXDYE1MWUfLSWw62XjPLkVR8YpaLHLetBg7kNKhZ149tS9JYCYrdoNCfss/YFDSDxo
	Nyuvq8KEapcvAfY0gkuV1+H2HDjw=
X-Google-Smtp-Source: AGHT+IHB32d5HQUMjxh+boA4ZJabUJ97cmEHPP8K61DSDNei9+vJBnDVh0KxxtFoHavvoZI5JNvzBGlv/82u/olm0Ec=
X-Received: by 2002:ac2:491e:0:b0:517:870b:a13d with SMTP id
 n30-20020ac2491e000000b00517870ba13dmr65612lfi.37.1713890229463; Tue, 23 Apr
 2024 09:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420025029.2166544-1-willy@infradead.org> <20240420025029.2166544-17-willy@infradead.org>
In-Reply-To: <20240420025029.2166544-17-willy@infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Wed, 24 Apr 2024 01:36:52 +0900
Message-ID: <CAKFNMonpNymFnG=YkmsStHdJXdrQOaEgPdkr8231DunXDiOyvQ@mail.gmail.com>
Subject: Re: [PATCH 16/30] nilfs2: Remove calls to folio_set_error() and folio_clear_error()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 11:50=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
>
> Nobody checks this flag on nilfs2 folios, stop setting and clearing it.
> That lets us simplify nilfs_end_folio_io() slightly.
>
> Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: linux-nilfs@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good to me.  Feel free to send this for merging along with other
PG_error removal patches:

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Or if you would like me to pick it up independently (e.g. to gradually
reduce the changes required for removal), I will do so.

Thanks,
Ryusuke Konishi

> ---
>  fs/nilfs2/dir.c     | 1 -
>  fs/nilfs2/segment.c | 8 +-------
>  2 files changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
> index aee40db7a036..a002a44ff161 100644
> --- a/fs/nilfs2/dir.c
> +++ b/fs/nilfs2/dir.c
> @@ -174,7 +174,6 @@ static bool nilfs_check_folio(struct folio *folio, ch=
ar *kaddr)
>                     dir->i_ino, (folio->index << PAGE_SHIFT) + offs,
>                     (unsigned long)le64_to_cpu(p->inode));
>  fail:
> -       folio_set_error(folio);
>         return false;
>  }
>
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index aa5290cb7467..8654ab8ad534 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -1725,14 +1725,8 @@ static void nilfs_end_folio_io(struct folio *folio=
, int err)
>                 return;
>         }
>
> -       if (!err) {
> -               if (!nilfs_folio_buffers_clean(folio))
> -                       filemap_dirty_folio(folio->mapping, folio);
> -               folio_clear_error(folio);
> -       } else {
> +       if (err || !nilfs_folio_buffers_clean(folio))
>                 filemap_dirty_folio(folio->mapping, folio);
> -               folio_set_error(folio);
> -       }
>
>         folio_end_writeback(folio);
>  }
> --
> 2.43.0

