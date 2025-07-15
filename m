Return-Path: <linux-fsdevel+bounces-54943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010B2B0588B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 13:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5D03B971B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 11:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154F42D94A8;
	Tue, 15 Jul 2025 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQ+S4PrH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9FA2D8DB0
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578032; cv=none; b=NyiUXDfBqXEoGlAIyZrVg4c0jYaeNh6B7+Nfa2szzDhiEgWpZXSU6rrNJxsF304qsvqk7yXocaurc0zaiP9TVKAPiIa5frexZkJF8G0hA39eOb+IQSUkaKDD0huvA721lcI42DgzD7ef1fedSTlAo1PrSn0bFY0zcwNadVwPGnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578032; c=relaxed/simple;
	bh=0Psq+LF0fFXBjFzE7pcErI5N1pXJT4eRpt7sxYHTe/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qr67RdpJZK+pG0Rx+gCRpx6xsuatwZYzvcaMDpjJrYQ3ofTYqf1zSdXME738qoPmQryFxrY7OpcaGIRTjD6oFyWB8O5Peo535MDMg7/kEFeeULsnVkBDyuUEtTtWhJpaFxSdXi937Epcbwl2XAUmk61DZuVACYCNvmOChzmoK9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQ+S4PrH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752578029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOL35FYxBgi0boRyCseienvrlvRyobXfNrbobxVWpFo=;
	b=aQ+S4PrHGWd4cqwDie/BgMlbRjcIgYoLU8ERQRpgGTd7s2Wl9Z2cqNSFCTnH/u+HS3JFha
	LCs5G8QDr9r+VSJSX3lUaTUfIrpx2rou96A1Brchaf9vZ4JG86nlN1Qjl+MBJOZxJBU7LY
	BA6OlV9UYzbkCpsYGHkPcqQPqqFE3H8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-DO3pQRFFOKmoboErK2M4LA-1; Tue, 15 Jul 2025 07:13:48 -0400
X-MC-Unique: DO3pQRFFOKmoboErK2M4LA-1
X-Mimecast-MFC-AGG-ID: DO3pQRFFOKmoboErK2M4LA_1752578027
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23689228a7fso76788445ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 04:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752578027; x=1753182827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOL35FYxBgi0boRyCseienvrlvRyobXfNrbobxVWpFo=;
        b=PUSsDRk9bdke1XKdcooKZbc0DIrw2RI67yM1ouGCveSccmMzTcP/Sjr3fOczGiIobQ
         DXhsh3tpYGVYz/OU8a7kvQCXqbSFDz9SGMBR/pt6nCsLQRizPL84IOS8TYSmSRjjgz9P
         upUZvEiboUjkctmCzf+QXkO8rj7hb3K4daH7E3v1COOv/dguvD20uPJCdCfZZ6LcObXW
         Wz0sGoP+SuFsTmtpPhvM5iZfVov8XG35t3Ttf2z3mzOLfnDl7MXOnDu9U4Fgda/fJAWc
         L5JWnE7ZS798nkTTWI+vQYhodwlKgJBRjGbSPuds4bQc30HWSlJW+47Pg239hwY5lgB9
         XHWA==
X-Forwarded-Encrypted: i=1; AJvYcCUfNOB2mvpr/sYHYU6SL0WillAv9ILEjeb62LNf2Lyh0zNBfI9r6tPuOC2/W/YA72NONVpHvosPDyVZ7dxm@vger.kernel.org
X-Gm-Message-State: AOJu0YxMkqbvLfJob3Cco/Siz5+MCybleSOtZjqDGLShrw08OlKeeDJJ
	1PbOH7GOj/wUGD9eAapFbw+2egxJWdSAIjwWlbLMhxNUqIx+xylbEpfZdyCnDpSAb7IftoF9vun
	H1VPVnSUrixFdziOyPz9YseTzBQmmlOEcEmddBzpbX+s2Gv2fqkMw4IG67nOrfxAjxKraEPttDj
	qTaq2Zfx7CmeUL8Z+CTKAyHeg/zbXk6hD3xDA+Brezvw==
X-Gm-Gg: ASbGncuM15T2aB7e6JM9BUfyoezPD/WVDtYGy+F0ypkFUURzlAr8HAgsPu+vp63WOix
	wgopNOQKB34bctnaGeDt4Hv/fPmPdBTelF6JiTEQjbOUGVH2grDtqZqigB1IULktZppgpff2IIx
	G7KzJDoc7nlIMrvyXxXS8=
X-Received: by 2002:a17:902:f98f:b0:23c:7b9e:1638 with SMTP id d9443c01a7336-23dede8c409mr183252835ad.35.1752578027103;
        Tue, 15 Jul 2025 04:13:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF20jPBqkCK5sC7WCGmfd+awMU214WUALxZwme8+8AHshin2FxLGCsX8aAVtc4qUtWoxelwIAVEpM1d5uqJBI=
X-Received: by 2002:a17:902:f98f:b0:23c:7b9e:1638 with SMTP id
 d9443c01a7336-23dede8c409mr183252615ad.35.1752578026726; Tue, 15 Jul 2025
 04:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714165459.54771-1-anprice@redhat.com>
In-Reply-To: <20250714165459.54771-1-anprice@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 15 Jul 2025 13:13:35 +0200
X-Gm-Features: Ac12FXyu0WcA3bhI3kVxis6z3U10Kd9CzdAwCQ4I1WlglQCtZFNFnmFITUbiot0
Message-ID: <CAHc6FU7sGV4OJ5EpEqzHXmCdN07uW8hFDirvoqgJeZVOySXmsw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Set .migrate_folio in gfs2_{rgrp,meta}_aops
To: Andrew Price <anprice@redhat.com>
Cc: gfs2@lists.linux.dev, willy@infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 6:55=E2=80=AFPM Andrew Price <anprice@redhat.com> w=
rote:
> Clears up the warning added in 7ee3647243e5 ("migrate: Remove call to
> ->writepage") that occurs in various xfstests, causing "something found
> in dmesg" failures.
>
> [  341.136573] gfs2_meta_aops does not implement migrate_folio
> [  341.136953] WARNING: CPU: 1 PID: 36 at mm/migrate.c:944 move_to_new_fo=
lio+0x2f8/0x300
>
> Signed-off-by: Andrew Price <anprice@redhat.com>
> ---
>  fs/gfs2/meta_io.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> index 9dc8885c95d07..66ee10929736f 100644
> --- a/fs/gfs2/meta_io.c
> +++ b/fs/gfs2/meta_io.c
> @@ -103,6 +103,7 @@ const struct address_space_operations gfs2_meta_aops =
=3D {
>         .invalidate_folio =3D block_invalidate_folio,
>         .writepages =3D gfs2_aspace_writepages,
>         .release_folio =3D gfs2_release_folio,
> +       .migrate_folio =3D buffer_migrate_folio_norefs,
>  };
>
>  const struct address_space_operations gfs2_rgrp_aops =3D {
> @@ -110,6 +111,7 @@ const struct address_space_operations gfs2_rgrp_aops =
=3D {
>         .invalidate_folio =3D block_invalidate_folio,
>         .writepages =3D gfs2_aspace_writepages,
>         .release_folio =3D gfs2_release_folio,
> +       .migrate_folio =3D buffer_migrate_folio_norefs,
>  };
>
>  /**

Thanks, I've added this to for-next.

Andreas


