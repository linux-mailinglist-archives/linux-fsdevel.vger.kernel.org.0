Return-Path: <linux-fsdevel+bounces-52889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB211AE7FBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 12:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84DD3A7ACA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EFA29E0EB;
	Wed, 25 Jun 2025 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ijej8eJQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB898F5B
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848073; cv=none; b=HOOVmoDS9Ayua0Hs6sAyzq5LoGfZkWmUA5GNchq+64dCz+dtgzKSSgkCmkQFVeNL++7A+nxVX8ebRwljGJDBpaZhm7OVBa8L4A/NuPaT6xaXkVCK/nneFrfYCp3PYhXC51R57u60/U/QZu9heHyFdgkG7Mo8UIqJ3esQhw0ZZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848073; c=relaxed/simple;
	bh=AIVz62DuTVWDixko6X2LPuwXhOwmi4DqwR/TSjDPY3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMWPac1MKpSqDupNVnGevORgY/KeB2WRG5gSw98Z5NLb8aNnVdjzBMcHr0yasgXlEi7pN4TMaJDFtPeb5qnPLAez6pV1ycTCoZChSN/kdk+9hdH6SMZF8T+FvwuHoZmB7q/37dEit3v/ZeHbZ5dLoJ7phEfzqbTsQXUMWwI+l5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ijej8eJQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750848070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKr+DQBtFyizAsw1988hOJcgz/t/EULmqa75FsXdoB8=;
	b=Ijej8eJQljxvmn5hX+bSGXt61sIOOIKkPj3p2cpcERbKIv81QJ7B9tmY3Vlm7Rf/C24/wf
	J6Ib58ma7X4ITp6LlF38WeewJZdF8jZOY4rz9dhwiyIccFdtxpCFCfl9hY2KyRRA9JSwKk
	376VVI1sQD0frxHxwnLzXhJGUdSs/v4=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-tY_uxDH8MgKgqTbSEhIekA-1; Wed, 25 Jun 2025 06:41:09 -0400
X-MC-Unique: tY_uxDH8MgKgqTbSEhIekA-1
X-Mimecast-MFC-AGG-ID: tY_uxDH8MgKgqTbSEhIekA_1750848069
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-53169549f5aso470705e0c.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 03:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750848069; x=1751452869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKr+DQBtFyizAsw1988hOJcgz/t/EULmqa75FsXdoB8=;
        b=uIzSHKqHJ6RMYwGkk9SF0hoSFtS0RyMbA8hLOQqhAwYp6n1T18iodcQ5NyOooQTQYV
         7Kelwup7BkERjkOncwEspUQfjV8FkSBDBbqguV+5lKFTVtMK1B3ug/hPfHnf6A5dSpYB
         bqhCX1XS9QkSmfiIyheqLXL9Hu312obpCfS+mtgZLW5w5vtsTPWKwRnQjfK32AHSb7Ba
         kcMlqv5NXupvN4Lg3VoIioS373Ulc+Wkm+UPXwEwNqbo+ibr891CwktWu1X8igvf4iYk
         35NLB1oyK/L41biKyO0KLGX3fH/V5ceZHhh2TfruIINbBGXu9BBl0foEEzQLEjtlhccy
         oYKA==
X-Forwarded-Encrypted: i=1; AJvYcCUKXc+cbJqsyQjdw7raoVMf57pwhMFsGhocbozJjgf7UujL67AmbEBykQ3GlpO8f/rYmK+mdgEM+TK2elru@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZElDtcT2y9a9+/QHQy2mBCceBwvkdSCTbxx2Eal9+HRKyb+i
	eeCn9kajHlQ1qTlOpMWdmYZa3uHwD1KhGmTX03hlZcT9JshSI97lhAvxlbLXinEpZrv006Xpb+1
	oLpN7EcDJ5OFGQ4mD+yBPv2P9U9JXTmR9gJe4js+EJWXxbpcSzh8zhCKauA3wjFC+K8u1D/Yc2D
	ziAuzRUzSR7XbUlgifeAuV0yjfOv/QO/xw8RhsP6Ep1w==
X-Gm-Gg: ASbGncsQ6Gh/lS35CNuYSWru2FbL65JSEhRbqrQxK7UiIHTPl21xzN8VoBwSJbgW41N
	+36C2dKnoYYQTGMd/MFlaV1rdtoE5ksw0wQkS/g+svb8IUfmMdw8rA66+DPW1bG9FUYTJlBLJT+
	7m
X-Received: by 2002:a05:6122:1314:b0:531:312c:a715 with SMTP id 71dfb90a1353d-532ef36d88bmr1312857e0c.2.1750848069187;
        Wed, 25 Jun 2025 03:41:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKSrlq1vbTvn3Juc6W5KhrcexBGZURwwZbo6o+xxVCTx25vGfBDJ/xWAUugd4sgcE788El/lgs5X0WkOKHVaQ=
X-Received: by 2002:a05:6122:1314:b0:531:312c:a715 with SMTP id
 71dfb90a1353d-532ef36d88bmr1312845e0c.2.1750848068518; Wed, 25 Jun 2025
 03:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612143443.2848197-1-willy@infradead.org> <20250612143443.2848197-2-willy@infradead.org>
In-Reply-To: <20250612143443.2848197-2-willy@infradead.org>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 25 Jun 2025 13:40:57 +0300
X-Gm-Features: Ac12FXyp1o1FcravfvrXONE97kHRXN5UStXCBn6AB_JACNodeZdJ-QuOTaMpRIc
Message-ID: <CAO8a2ShgtKP-_V=YZ1NUvSUeoS8_mX7de20nP=P=RfdH5n=XTA@mail.gmail.com>
Subject: Re: [PATCH 1/5] bio: Use memzero_page() in bio_truncate()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good cleanup.

Reviewed-by: Alex Markuze amarkuze@redhat.com

On Thu, Jun 12, 2025 at 5:35=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> memzero_page() is the new name for zero_user().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  block/bio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index 3c0a558c90f5..ce16c34ec6de 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -653,13 +653,13 @@ static void bio_truncate(struct bio *bio, unsigned =
new_size)
>
>         bio_for_each_segment(bv, bio, iter) {
>                 if (done + bv.bv_len > new_size) {
> -                       unsigned offset;
> +                       size_t offset;
>
>                         if (!truncated)
>                                 offset =3D new_size - done;
>                         else
>                                 offset =3D 0;
> -                       zero_user(bv.bv_page, bv.bv_offset + offset,
> +                       memzero_page(bv.bv_page, bv.bv_offset + offset,
>                                   bv.bv_len - offset);
>                         truncated =3D true;
>                 }
> --
> 2.47.2
>
>


