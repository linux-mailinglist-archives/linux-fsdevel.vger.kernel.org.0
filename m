Return-Path: <linux-fsdevel+bounces-19039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE7E8BF85E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 10:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1192F1C22070
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E65145BE3;
	Wed,  8 May 2024 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Rsfkx9LY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6031DA53
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715156490; cv=none; b=XZfROOIOTjRlVz65DC+dMznWzsjuPRs9LUIIMMJ0eiQpF9/NgWY3LFAGCG2SvzXzsFlrbMRw7YSIAAOX6MjrtwGpBJdhQKUcstYelXBDrR4CONvA+ioQ0mzx0vvpEZHfX42xpwr7vFYZj8Pfz6ov1b2KqZyuyNSVKmFR7LD16qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715156490; c=relaxed/simple;
	bh=HL7En7OBTcPuMbQQapaF7sp8ONja5eBac9REyP9vuAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jq99jZM59HmwpPFRQSsBo5DulVXsk7MnpSL8/CpzRYnir5aX0tU2N34t4hMgc/rPL+eBe5OigetJoHty7YJiqHRR0+Yea1z9m9guAvvy4HFmrbyV4UNV9p+dSmqbflfm2g9OCEaQRuXfbdvwr77nO1wtmPn/ZxDsSZzKuHRQSak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Rsfkx9LY; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59a9d66a51so922018866b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 01:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715156486; x=1715761286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ixA6ZpFhbriwN643+FDPmx+8B3vSAEW3xMrMho4mmU=;
        b=Rsfkx9LYtrTVtrmzCEStY9k34OZFYmQfzWN8bDhMq5PH2SyXPKkVxKhKfZArDGVyna
         al/fwPeQqBRvmDVtZ/mBI4gFyeoJTWMdKJ0p9OFY2iKMAcPxYEVVV42NQlSzQKRNxO35
         dyugODuQnoWWgBhZn84RjeCxi+8ztcSw00WdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715156486; x=1715761286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ixA6ZpFhbriwN643+FDPmx+8B3vSAEW3xMrMho4mmU=;
        b=WxBMv0SDCAGdsEBmn/maIqRzhb00r3ILYMGVCNqlhW7ZNBDhSKUZbUURDdpeC4nUl/
         r2xwmIchIIg2wHndYLx4eIl8f6Hp608YBWY+fRotmpGDepz65LRdjwvhL2yRi7eGdGin
         q8wZHcSljoTvJ8QnfZ+9FBjic+S5n81Vt33LO0AG7cHhT/210069LNYBaCQSrqdCjKZK
         bSbVX5YYY2eHfeIeUbfQ9FxPke7SGvCtn2F6BJ2yH7iTsgXt085zLisg8esoNTBZHMEd
         GarcpkLuZn6LH3vCCrYW5xDeq+bt2dgwoULdhJk3aBGvULgZiQ3LJ4EjBSa1jZk4V1md
         sn0w==
X-Forwarded-Encrypted: i=1; AJvYcCX3BJi5kaaCW5YVZXSszwyg5cb57M1VAiNJPSQ1wDOBp3wA/xb/8Muv3EibNk78j645Wuz0JXbGNWZDKhP6wYl/l418vRNjUS2Jgdliew==
X-Gm-Message-State: AOJu0Yz4kXurIDYJrrv5+1zm59E//N57eHIsRvPkuCdFebSFf4X3Q/Hn
	kZTdslDXr2hJSRNrZ3oXQgHCUvmqtQPiXlD6wyaftY15ROvDr4uwDezv3YnAAd2+4x2L/4PLTBl
	Z72lTr2hjnWQYnoTbjGYnCJGoxBXSgU0W5Mx9UQ==
X-Google-Smtp-Source: AGHT+IEUwgNbxTRR94GvmkXfJy+HcI6FvAeWKvWbx/fHAbKjVPAPYyyg84Vq8bpWAtvA2x+cdeFgAm8Ossyl3nHARjc=
X-Received: by 2002:a17:906:f298:b0:a52:2486:299f with SMTP id
 a640c23a62f3a-a59fb9e9959mr112631066b.71.1715156486167; Wed, 08 May 2024
 01:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLwAe+hVUNe+bsYeKJJQ-G9svs7dR2ymZDh0PsfqFNMm2A@mail.gmail.com>
 <2625b40f-b6c5-2359-33fe-5c81e9a925a9@huaweicloud.com>
In-Reply-To: <2625b40f-b6c5-2359-33fe-5c81e9a925a9@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 May 2024 10:21:14 +0200
Message-ID: <CAJfpegvGhtLSxOHUQQ95a3skqEgEPt+MzpBT8vOOdqWcRxPR5Q@mail.gmail.com>
Subject: Re: WARNING in fuse_request_end
To: Hou Tao <houtao@huaweicloud.com>
Cc: lee bruce <xrivendell7@gmail.com>, linux-fsdevel@vger.kernel.org, 
	yue sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 15:30, Hou Tao <houtao@huaweicloud.com> wrote:

> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 3ec8bb5e68ff5..840cefdf24e26 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1814,6 +1814,7 @@ static void fuse_resend(struct fuse_conn *fc)
>
>         list_for_each_entry_safe(req, next, &to_queue, list) {
>                 __set_bit(FR_PENDING, &req->flags);
> +               clear_bit(FR_SENT, &req->flags);
>                 /* mark the request as resend request */
>                 req->in.h.unique |= FUSE_UNIQUE_RESEND;
>         }
>

ACK, fix looks good.

Would you mind resending it as a proper patch?

Thanks,
Miklos

