Return-Path: <linux-fsdevel+bounces-13727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D6687323F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB40283CAC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6A05EE61;
	Wed,  6 Mar 2024 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bhBhU5fN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4195C8EB
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716426; cv=none; b=j3xvKJDT2eRhQZcnWY+Q35DSfHySi5uSJOIQtYHlpg8EP1x9L6x5iuxT07d/nmKH2fPqtxsRFNyi/9XZZtgw9St8GIVJDEDoEZkdX1e2zY6c7HSq/5iIzJ5GMhLLfqu3onpRZB8zGIQdlE7Q16+utGUqF6esGlIVHjWRzOxD2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716426; c=relaxed/simple;
	bh=Qk/DgjzzjMSGlkOr40MEBE4bLbSg4IfJnGTatQO/eMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+wHGktMMs15i15UD+TdkQrrAzxt2jWnHSYQTnLqe6dLHSIE1UtIVNtGy1bPA0BXS9va9I+KkvwGdiIrXhOs+Sk3dtq2LLBHpWvVTa5mLAkQ6cLPFuJLax7ezMelAe6eoB+C8KEjjLDZYKdXrYnnZHIKu2eN8T6POZi+0DoAocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bhBhU5fN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a450bedffdfso410282666b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 01:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709716421; x=1710321221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qk/DgjzzjMSGlkOr40MEBE4bLbSg4IfJnGTatQO/eMo=;
        b=bhBhU5fNwZ5NqT0bjBfmI8yYE8497uLD5ocbat8fgeLSUHkpHADu4CV6Px/N7I7wzg
         5mKP+wC8FaeYdcidDoxMNECGlkyX5G9DEE+nGgi0lls+5HPUXm/Opo6mOPt0FA/iIH4H
         DIBbg1aujcIteGxEv9Zr4ci4GHnXD1eiZHVWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709716421; x=1710321221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qk/DgjzzjMSGlkOr40MEBE4bLbSg4IfJnGTatQO/eMo=;
        b=bKVU+1lJfuvGo/4nJbUSEFmVIR8dt7W0WBUgQq5ZblLCke3jYHohPituQV4O2W3Uhu
         JO5rcI3k2CVyM3L0wWRkFuvrZH4iCElnSJpO+ovo9Ac1gLte7h55dn+oNC15YgsCr9Ur
         b2T05tAkmb8zyrD/wtqatVQTxgZgm/A1kcLlWlRFlgA69DGAce/RSdlIUoxFq5inqc6d
         uvdZkYN1W5sdJOi5sX7GhZRn4GGWG5AR5VY3nxT7MtGyyxq29V64AG/qBOHYVOSFyOG/
         OqAKpLRaNB0IYb/ei1qSTBA9eCLQZmovJ+SvJ+bqz6yrecqkW9so+HdrgTldjum7pZIh
         yetA==
X-Gm-Message-State: AOJu0Yw+rPiMv1RVxshPdJtwFlshTwpax4EIfmpEeabw9LJmpGeToiVo
	J+rn+JanTpVXiesZMtK/jcFY/vMag2ySv1YylmueJINUfTF20o2YX3fqXBPpgKlwyItN09CZtPs
	UrvN5auTqFYj8OuellrjfDNl5qlXko783wjtZog==
X-Google-Smtp-Source: AGHT+IF5uZKkvzzVvH1pdzaj4G0tyPvVgc2P1x6T/jfjAEtk8AF3FusxtxHz4G91nr1NSpZWjbsyOBQrRGKPsU4HqrE=
X-Received: by 2002:a17:907:20b9:b0:a43:eb29:a293 with SMTP id
 pw25-20020a17090720b900b00a43eb29a293mr9389627ejb.5.1709716420766; Wed, 06
 Mar 2024 01:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608084609.14245-1-zhangjiachen.jaycee@bytedance.com> <20230608084609.14245-3-zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20230608084609.14245-3-zhangjiachen.jaycee@bytedance.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 6 Mar 2024 10:13:29 +0100
Message-ID: <CAJfpegtnTafRiHGG6jpZaZ_XbOhT2aGFyZM3FeDdPoSSEanNNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: remove an unnecessary if statement
To: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@osdl.org>, me@jcix.top
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Jun 2023 at 10:47, Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> FUSE remote locking code paths never add any locking state to
> inode->i_flctx, so the locks_remove_posix() function called on
> file close will return without calling fuse_setlk().
>
> Therefore, as the if statement to be removed in this commit will
> always be false, remove it for clearness.
>
> Fixes: 7142125937e1 ("[PATCH] fuse: add POSIX file locking support")
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>

Applied, thanks.

Miklos

