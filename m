Return-Path: <linux-fsdevel+bounces-28140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41DD96745D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 05:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B711F21EDC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 03:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B92C6BD;
	Sun,  1 Sep 2024 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zv3xNt67"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A421350
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Sep 2024 03:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725160442; cv=none; b=YrfKEJc77l628IsPo+D9TbG/vTBD0efb+nv3Erfjlgf/JpWZX1zpJcBcDiV9WXZv5CAipei0MKpzas5J3SuRoYZ3g2DQbBuI2NqrdBEfk6n1dZZcSslZdSOl29epqnHCTjWnwNGevLK7AtGXGamct5jvO3t5D7NoUcSy5Fi3m6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725160442; c=relaxed/simple;
	bh=YWMWPcMqHWLz5765/EzioozPxEQli1yw5/WJvX7GxB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkyheBsJQnMnKTSBVIKnJkQcTjbgs5CDvRgwA1rwzHTd4dK4Wjkj8lDUlBSK6BJ91VvoOfUPAEgvSMGQo1P/73wtCDPs/onChwSM+W9h4hRQfbIWVB5hEiPS7cLy0c07DT+bUohRiHGfedYMcK3S3e2fbnPTZ7LYUMH7XVJkmT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zv3xNt67; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a83562f9be9so294442566b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Aug 2024 20:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725160439; x=1725765239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vA9fKAepAjJP0Y+uK6ZVIFt69/fpi4A0HmGXHcekQRc=;
        b=Zv3xNt67ZjQzziEpwFTz33fuZbWvHn7A6OD2u2oisxiX8DVElO1G8jInHVHw8kTUUE
         miBYos3XJba2VQxUZMQP5hNL33qD32kP2CagGDqRu++jKRxpTWJNWB5MNUVrIIf++zJU
         x6kURTetG7vjMF39r/DBMMGN8hY2MGFwubcYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725160439; x=1725765239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vA9fKAepAjJP0Y+uK6ZVIFt69/fpi4A0HmGXHcekQRc=;
        b=OO/dnP2VrPYZ6+OjlZEa8xfplBL1d1f/tx515iOG8XbSUKUPBvJQvUXS07TVYEYHji
         ct6PUQriOZ+VFM+2APzuDrpfxfaBV21MkJgRrwrMoS/zcJLa5DgWFtTfIasV+VK5iSYs
         Ri7RFnYzqVZvp+yeyHGpWlBvRF8fYVLJgInwsCnWrbaOzBfSRHC3laZ5QaEpugY0Rnqv
         hGOD4id62FVB/KlannqCn+WiwH7UxV5GubdRwNjTuYGPUwK0JF30+EmBv8EQq0tUZX5G
         xIcIWlmf2r/bVJqmLpRpfnqJf0fYiGWt/b5cwhIUasCJ+J+xs55MpaRFuUVXxJ5HNugY
         dM7w==
X-Forwarded-Encrypted: i=1; AJvYcCX7PisLSzk3u4vLPeQsqH4N2cB2oXDXXQHCP7TzNZyRTwcd8w8+U6QX0ahe+dmnqXQEryhyeEYHZUG1ju1V@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ivThf+2TYGto2HrAHbduC16X3+5p+fJ6a+4MaE9/T9JABsRb
	9AZpmrmfQ1AbboOLDE1/eIHA+78oRfyGV3kK59nWLbKN2d+hOiIBRvcimzKpRjNSb3Ldm9JAsuR
	oHNa2mQ==
X-Google-Smtp-Source: AGHT+IHd5wAtmmPXQjh43eQ8RQN8Ytc46mUH4ALczeSHVAZzlWtbXH8A7XFGLBS9Xnm73lEN924rRQ==
X-Received: by 2002:a17:907:72d1:b0:a86:a41c:29e with SMTP id a640c23a62f3a-a89b93db7b8mr266470066b.2.1725160438436;
        Sat, 31 Aug 2024 20:13:58 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989230a9dsm383019266b.224.2024.08.31.20.13.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 20:13:58 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bede548f7cso3151711a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Aug 2024 20:13:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRQOICs09g7YcCSIDuMMifnBqREBQDpKu83gcNHEkWUi2knWDGtBGbgxnNzb80H0+SHSPLpHCYrTMUoLVl@vger.kernel.org
X-Received: by 2002:a05:6402:270c:b0:5c2:53a1:c209 with SMTP id
 4fb4d7f45d1cf-5c253a1c259mr266984a12.25.1725160436527; Sat, 31 Aug 2024
 20:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <erydumpfxcjakfllmh3y4d7wtgwz7omkg44pyvpesoisolt44v@kfa4jcpo7i73>
In-Reply-To: <erydumpfxcjakfllmh3y4d7wtgwz7omkg44pyvpesoisolt44v@kfa4jcpo7i73>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Sep 2024 15:13:39 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjBNzWL5MmtF86ETJzwato38t+NDxeLQ3nYJ3o9y308gw@mail.gmail.com>
Message-ID: <CAHk-=wjBNzWL5MmtF86ETJzwato38t+NDxeLQ3nYJ3o9y308gw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc6
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Sept 2024 at 14:44, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
>   git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-08-21

Hmm. Your git host is often slow, but now it seems to be even worse than usual.

I blamed my phone hotspot at first, but everything else is fine.

evilpiepirate.org takes a few minutes, and then I get a "Connection
reset by peer" error.

Maybe kick that machine? Or even just use something like a github mirror?

               Linus

