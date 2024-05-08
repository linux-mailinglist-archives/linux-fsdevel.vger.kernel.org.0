Return-Path: <linux-fsdevel+bounces-19034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B589E8BF7CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 09:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68911C22479
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 07:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BE33A28E;
	Wed,  8 May 2024 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="foruWnwH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488F2C6B2
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154949; cv=none; b=cS4a0ks/VpcKC8ePhNLsmm33lhXYtMv0jj6UJ08NgXplw+X7hPEtgUe2l+DOc3oPwFXfqkfGHfOX0GHAIjuOT2oZpj2fBSwPTTjtEaeKEVjJ27NcjzaCFIOU3IdMpIXo4vhrhrvuWqpEiCQmHzWNlPPOxyB7X5P+8MbXxOFHgvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154949; c=relaxed/simple;
	bh=OkqGuhOxaU7HxMYbc6AzQtyjmkMCn1mBGImnm1Mkob4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1O2mxZMsbWXnHaikEfrkX7AJMpSh4EkiKDlW5EsH0RhlSZ15ezIu0NcG5+H88l+2X0eWEkX2kc7Bp5B1fP9j76HFnj8W3/nsbmsi7Ca7JHw8Xq7XXk8EbA97RKmk4BCWzPf+kRJD1fYBB1zdudYG2XnbiYgmS5ZDcqs7/H71Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=foruWnwH; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a599a298990so1086137066b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 00:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715154945; x=1715759745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xQNAr1uUHB/7WYv++/+YDdR1v8mmn8+Is88zwvtgTJk=;
        b=foruWnwH2uHEJbTOj56ccrQwUmEK0w1Gzpg7Ry54lXNsXoaw11OFdQyZ02mYPKTR0u
         K7awCz8my/Iu7hHMiYGjeTaZ365dK4f6EjW+lwR4gtD4L4aR8KxdRYLuv21j/BomRwnn
         LCY8Kgl6Dv9IWf9MSj3wspixNUr5XEhdeNRVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154945; x=1715759745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQNAr1uUHB/7WYv++/+YDdR1v8mmn8+Is88zwvtgTJk=;
        b=NEAXFk4zJVb2ZPdEav6Kj0fs6CxLu2CfbmFfa6Y4X14OEUrKlpG304evUDrA5oG1SE
         Of9T7TdwmQVL/al2lRfGADfaLligZRcFMFas0zst8SHBiYdSWMmu9+X+5B8d7/IcpXBx
         GHhH7czRHqc50qnl9h285nxrnOZezra+h7hNcFmwMnxAAiHYcAoyYsbr7z5WxOxXeoee
         PtCFwUiCsCVxIQ+dJ8hz5y/Ga6dxQw+obuGTmSBTeBRiyh+cFAacjs5KML6pQP4fdujd
         jZhyetSUVY+lvYfvxiu2EIQVaOzLfiymiw3uvPq2Xmkv6fyNdZc7Vswi3KkBVjUlWoHd
         M2dw==
X-Forwarded-Encrypted: i=1; AJvYcCWotVc2F9kWDSByMnZTQgrHEI700G3RZ3nBg+DzRI5GouOPjlJBv8/QRKmcD14eUaT6/Ia1rOLIaWrVOmUOe76nY7KmyMSvoCTbmV1AUA==
X-Gm-Message-State: AOJu0Yw2Q4coRvsEVPwbvdmU5UcwYLOuqobS9uhbwJaOaEy1iNbwMHFU
	w/QD8monEhsNInnUW2TC8SOb/g7UMUFdr3k6WqVlDMo/pnjrCQe+wIROZtThXWtfjt04tGyiopG
	aBYTK7LAxKZOmVCahbZXkXJXipddHd9UHNp4LtrevX8UivoHL
X-Google-Smtp-Source: AGHT+IG3kHS9N6LOHiX9qwgQeU0VRbKc5WSl8AKWI1QVQSHoC74jPQqVVlvsUS9w9D16MIj1UmJSyxYVHkHuSP/lMwI=
X-Received: by 2002:a17:906:ce5a:b0:a55:acd8:996c with SMTP id
 a640c23a62f3a-a59fb94bf12mr96735666b.29.1715154944651; Wed, 08 May 2024
 00:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425104400.30222-1-bfoster@redhat.com> <20240430173431.GA390186@fedora.redhat.com>
 <ZjkoDqhIti--j1F5@bfoster> <20240507140330.GD105913@fedora.redhat.com>
In-Reply-To: <20240507140330.GD105913@fedora.redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 May 2024 09:55:33 +0200
Message-ID: <CAJfpegtQLy2dxnXy+XNujPweVvSFO9XajPQZEmh=NMMUNXd3wg@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: include a newline in sysfs tag
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <mszeredi@redhat.com>, vgoyal@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 16:03, Stefan Hajnoczi <stefanha@redhat.com> wrote:

> The v6.9 release will happen soon and I'm not sure if we can still get
> the patch in. I've asked Miklos if your patch can be merged with the
> newline added for v6.9. That would solve the userspace breakage
> concerns.

Will do.  There was already a fix queued for 6.9 waiting for a companion.

Thanks,
Miklos

