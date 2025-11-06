Return-Path: <linux-fsdevel+bounces-67382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99408C3D7BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 22:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1DF1883BD0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 21:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AA3306497;
	Thu,  6 Nov 2025 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3ddCXpV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdEjIp8D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252121D432D
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464200; cv=none; b=sX4UF9F+IQrTWa84P39GYwLCxmiBdEEveGzuIroRJW3lVaBk7BEAoyZ0bo4gzaPVl3oy9+MO1D8IG89Fzt6fAn5epnw/sUueNoFjgaSWCjfZNCtfWGfiHwD0YzIDon4WGWnenu82B6gUIDjzfvOPahHTR+77FsnCVEyy2ggLYjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464200; c=relaxed/simple;
	bh=vhnj2EGSVLP3FkxR0lZwUI0398IK7iqhmauafTm4wMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3vWjyl0/riBYpOHh6CeJNHsmjmBwhdl5rHBud8pLW2q1bV/49lJzQw3Rj6wjkq8Pa6y6bLW17TyJtzeLRxRDeiH6PGJ9aucKJdyo2eQMqEWC5nYfSZAmQvUB4X4+CQjBNRqEfaTMiukIUtE2U0K0Im5tS5h87P5/1D3IOS5/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3ddCXpV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdEjIp8D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762464198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=usuQUhfQvr0g64KYfyoaUJEu3WWwfLZR2o6FU3CS9Hg=;
	b=c3ddCXpV9gBMlpfAC5QtdTVSG3IdhFBJsF/EAtYQR2eQLfBWablbhREQR+B074KGNTRGKu
	bPn+272ceicNFMc+doKvl6NMzXvSpE7VEhVvYo1jDPMTw31g3grPwUS2CkGW989QB2zJf/
	fW6O1S1BpbOYcDFCZpJQb9ov+y1GTvo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-DPT6NvfuMja32v02-pgw_g-1; Thu, 06 Nov 2025 16:23:15 -0500
X-MC-Unique: DPT6NvfuMja32v02-pgw_g-1
X-Mimecast-MFC-AGG-ID: DPT6NvfuMja32v02-pgw_g_1762464195
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-785d7ee74b7so1301817b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 13:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762464195; x=1763068995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usuQUhfQvr0g64KYfyoaUJEu3WWwfLZR2o6FU3CS9Hg=;
        b=UdEjIp8DrvpRA2zlvLKUQodcQINdX0q2+v3LFzuIBmfamyOidGOS2p0SAf0j+Y88TT
         nF91gTMvO5Zydj1LQ96+uzUo4sfUq4M8fVcGL8dq2z6CmQB13KTxslOFjnsGo2Vi+1SI
         F6Zj8Njzo1FfV+lQT9k1BEKARa/T3GwxLnlpaBHxkLQZzZP1wV81XcBG/+QuvzfRO829
         nB0slND+UiD2I0BlgGJavzETzbChIpv55W2I6ZY4iTASRUeV109+noBvvp/CKXTLRU9U
         GNSGXVVCiKRCyGmkW8YSLMHwpO6H/Wj6mgRNR1ddzEQnnZgkUrY+hbS2xYcu0KH4kASZ
         igkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762464195; x=1763068995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=usuQUhfQvr0g64KYfyoaUJEu3WWwfLZR2o6FU3CS9Hg=;
        b=gpb6tJZw6moN9nW7qN0W1p1Vn52Kmx+hSvg/zAPqBk5qXGeMKC+lsbxbZBYIHPgWlh
         rNU5ppVRVLjQcC0mlwnNWGu+QUJUwtCPA1B3TtKq2FaKaNNOxKyXJ2P+sCZgaVf/CC7H
         jgyqi5FIxTnsjsyHF6vqsMEZm3hWhCJ0Db8hxra1ot1g8H+W5IDRmeABLuI6qF3wUA/S
         YXDVJpOpmCbsHTq7v/VxLR3mDtYu1WJhErtO013FSg/QfmGqALsTl1XhO5epQIfm5T1D
         jfPdCGTYLjn0Pax5t4FiFBnvrO9uO0+0tn3AQt5uceIsGk/yt9GX6lmyQ/Wr2qG8sHR2
         xOmA==
X-Forwarded-Encrypted: i=1; AJvYcCU6qIajwOuvfErVq9qTRaqGT/hd8biCsc+JC6kori75oi/lozfJT3QX1xzhLqIk/7ZUA9benyoMFAfosZQ+@vger.kernel.org
X-Gm-Message-State: AOJu0YznUwM7q/XBxMH0Cg2MzgDob3yQmRfQ6/29a571RNFt3MzXLlwW
	O2/NImSyOqTj8wXaknXnBz92/V6NKeuf46cPcLLxOH6rY+3znEZ/YLNxDMoY81sNZQdD70iNLJi
	0vouZvQF8yXIDhtQF1Y/PojW+26MTf+oKE4ij1bSSBoESpKFyfyn9j2d85+a7vFNbmrAdpOGYIL
	Y0Uh9bh6g+Sx6VjcQ0dxxwTtVIXLhKe9n+1cop4w2E1g==
X-Gm-Gg: ASbGncu4gtl/1R8al9lUVuDbF4Z6HvDw0YOC6j/+JogiGHC89QX8h72dzmFqgJ5249/
	hwGUeh6pRaigFW3IJjUF8qzhl8LyefKAtD1OdTD0vk1qw3d8/Z/pjXLHtgBVTJKdNtyW2HxTUza
	elBZ9ZdZvRNy48mY/SJsKRteAi4k/7VjsovNgI4qcn4eyFtpD/RULvQQ==
X-Received: by 2002:a05:690c:a0a6:10b0:787:c613:821e with SMTP id 00721157ae682-787c6139ce5mr3327777b3.62.1762464194787;
        Thu, 06 Nov 2025 13:23:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrALypo3RCpOWTZPjonBqYfAEjYD4JEptJgGL223XNnnR49gBZ7kEd9W7p+Bp7QuhUwdE2hhTUhiEaUyal/m4=
X-Received: by 2002:a05:690c:a0a6:10b0:787:c613:821e with SMTP id
 00721157ae682-787c6139ce5mr3327647b3.62.1762464194492; Thu, 06 Nov 2025
 13:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202944.2344526-1-willy@infradead.org>
In-Reply-To: <20251106202944.2344526-1-willy@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 6 Nov 2025 22:23:03 +0100
X-Gm-Features: AWmQ_blaeFJ0E8PLBUi96SroZHzppdF6ZcE1KCjNsv15hEQHnW7e8ZAIf1JXh28
Message-ID: <CAHc6FU40AYoMDTxRwWuT8XtfWozsfwEzOqPoVQD1giPVT2GMkQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Use bio_add_folio_nofail()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 9:29=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> As the label says, we've just allocated a new BIO so we know
> we can add this folio to it.  We now have bio_add_folio_nofail()
> for this purpose.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/gfs2/lops.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 9c8c305a75c4..233b3aa8edca 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -562,8 +562,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs=
2_log_header_host *head)
>                         bio =3D gfs2_log_alloc_bio(sdp, dblock, gfs2_end_=
log_read);
>                         bio->bi_opf =3D REQ_OP_READ;
>  add_block_to_new_bio:
> -                       if (!bio_add_folio(bio, folio, bsize, off))
> -                               BUG();
> +                       bio_add_folio_nofail(bio, folio, bsize, off);
>  block_added:
>                         off +=3D bsize;
>                         if (off =3D=3D folio_size(folio))
> --
> 2.47.2
>

Added, thanks.

Andreas


