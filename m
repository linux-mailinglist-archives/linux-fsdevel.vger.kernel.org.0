Return-Path: <linux-fsdevel+bounces-13626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43D87217C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 15:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181961C21A30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FD05B5BD;
	Tue,  5 Mar 2024 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fxEdGatf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EA141C6B
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649131; cv=none; b=m1592u1RdV8rDxK00xfWNDlYtAuvbGCsNrKcnZxuvrFqfGoL5e9z0YJ+EZ8Z3JNNgK/AHTNapBCo4liHFc9hYgMmkMO26bc8g3HHK75JPAvg4hwZmwSo//vEwK6ZXFts1F46nZ7KOv/nrYyvQrlExzmJcXoTDpI7ZrDVHmwxzwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649131; c=relaxed/simple;
	bh=m4gwp8Brrok6cSY1uv1i8iyUlUiai0KjLje5iF+z1Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWP8+WqOlOcJusgfZC00rPxGyL3xhx3p8VtGZrDdMX0qErC5COWGMz/pvBmb7QMRSYbATzvnd1bRRdz8IyM4EMco5qrsJNorjXQ/wg59bHrsAC4ET/D8MX9jpTvu4IykCgM2ab6b+EMUM5fombHqvGp+MJFJd3zXiE08eUhjW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=fxEdGatf; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a45606c8444so255131566b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 06:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709649128; x=1710253928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m4gwp8Brrok6cSY1uv1i8iyUlUiai0KjLje5iF+z1Ys=;
        b=fxEdGatfJG0Lyf4faOdQf+X1B3ERlfeRuda+H8bokVyJQ7jLnTsIEoUdQ3yrwUs4Vx
         N9Be5PBUSRsiynBhgOPsemDMkTHAuwy73q+dQAPIEOQQpxYb/Nu/elloioQsPrEUlCvB
         W0RH3IJLLEj1EMqav3vlSrM2Ff5Fij94WTdfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709649128; x=1710253928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4gwp8Brrok6cSY1uv1i8iyUlUiai0KjLje5iF+z1Ys=;
        b=RtHSQOi134bj5xpOyJBKrLMnkb9xqa6/R0X1bePRABtaCuCGpOgsXGRY5CWnMOfLdo
         vM0SVTZ7wb3VjCa+Umt8L4mJbCfYpguWHRkV2RRI0gHDVvsGlCo3SUGK3Bge4IOJ1kMJ
         LSYLCRiyQR9M4hlTJi657OEJ3U6JRKB/HQWn9hO8O8+M3TVI6KU7+uMmTJ6mqsKaU/oC
         wLONZI6i42bejhISCELj9CwR+UQ1IEWogEr3DjU8I50d+CK+JibMTvGQSxGSsSxQWI2m
         MEAEZypLFpkZ4gITU4bnlYsubz8hN5xV6Y8ZP0bskWZg4hdCr0uZ0m44wyauYbJtrhzd
         vR2w==
X-Forwarded-Encrypted: i=1; AJvYcCXCn5Yo6N3mK1BAV+bsaxumPSPw4IVQsF/vhJ0PwWBiwj9sYIYpj7hOwa9Iq6tlItn+924lBLC4tGTNO8YbRMiPeAv176EvbQboeHv9Dg==
X-Gm-Message-State: AOJu0Yw9InVXJJCz5sRIjIEanVpCnLmFZcFoW1ehv+xsuo45Wha2kItW
	ey5l0T7fKQsTeLKzK3t/fJFqYEzDOUCgEx8FwU9aUreKJo9Km/LWE10Dzo18dtCro2jDx4fatYE
	KicWdKpCo3rtIr8JsJnAO18nbGyZPT53zPqKOVQ==
X-Google-Smtp-Source: AGHT+IH74N86OpW+SCu9HB+VdyGPJtDL2TD+L4UUv0iiCACiyZphJleePA1BBASnlVYeN04Cq5uHAMBZ1lSh4QA6w3Q=
X-Received: by 2002:a17:906:8309:b0:a40:46f1:7263 with SMTP id
 j9-20020a170906830900b00a4046f17263mr7553753ejx.22.1709649128288; Tue, 05 Mar
 2024 06:32:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com> <20240105152129.196824-2-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20240105152129.196824-2-aleksandr.mikhalitsyn@canonical.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Mar 2024 15:31:57 +0100
Message-ID: <CAJfpegvhLx0v=kPhFFXg5p+0AaSUfeqDRZTyYnFLvGiaY6HrJw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] fuse: fix typo for fuse_permission comment
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 16:21, Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Found by chance while working on support for idmapped mounts in fuse.
>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: <linux-fsdevel@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Applied, thanks.

