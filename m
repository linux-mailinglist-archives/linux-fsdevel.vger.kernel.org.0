Return-Path: <linux-fsdevel+bounces-66493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BFDC211FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 17:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B00BD4E888F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DE6366FB7;
	Thu, 30 Oct 2025 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UId4TLOE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ED12836A3
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840971; cv=none; b=A6pKWV3V/Nx5q7dRagrgIpXow5BwC4ut9WpjTIcxMQjTShdMPSnO4B+Q76sAq8KNNv8TYfGvlbhxnnIy5EceWUDmN69EctLHbqy03ew06l52TI5fqxMNoHo5p0ux8votc6/3BeYnufNYvW+p+Bk5yX795xAy0fkPHIp3tlxOp48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840971; c=relaxed/simple;
	bh=3PZCpmv1UBcJosb3KtjhEsOvPeKs1OWlWrA5tIUqwow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqTtzsicRBZVVqxYQcV2TfBB/vQM+yq9W/vLWFVqBxb/BteZVwC9eQKn62qN+WIZ3pUoqdKZzYQ/N+urnUbShFs3aATwNTnt9cIHFAcYJqhq6oaLdGVoyNqUB1TPcH/KBauWq4uVwLXqAIGjIfO9JHTg5epWA6qDpW39ARIG11w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UId4TLOE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso1899946a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761840967; x=1762445767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=37QCyIeGwvA6HmR+BTiKhh74UwXuJsbblG2L67MaTUg=;
        b=UId4TLOEWDiFacmi0zzUEyROjX6Va3NYjnd4sqp5HWq3WfyzEaDaXPIDBo8Rg7MOTY
         EtWNIEN0cy2QqJ4q1n+DYtvdvA5hIXxsuisI1GfSuZcJKG06+3zdVnb2yGA7JiVLipZP
         cSVfCfdG4NvL0DkXj1f/6TO8fDZTVYtYoVhjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761840967; x=1762445767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37QCyIeGwvA6HmR+BTiKhh74UwXuJsbblG2L67MaTUg=;
        b=a4KmELQf8tG1rAbKmlvuqGPJbB8gvdJ303OVaPrtXkOB4g+1Ythl0Pik+gCComqcur
         j/4lp4vgozz8syv+wqhaELNCCD5EnPW6e31MB5NOYpAa3Pa3QOinE32F3i2Do5H+rrfq
         W36MZY5F50cIyo/00pL2cqYK34FJa9ZXZ71988fQ81Hb76RgAhDNjj+Vbhdi2o3+tCdQ
         HTGb0hYwjNfpHX6x2tcXl3jMkbC+pJV8b9ZImx4pinTRr9dYuG2ARFzFm42i+QBdTJP2
         fmGvPMk6vyfi8qlkpcrZ/VJAc5994Fae1/vYE17+ilfRw+V8O7bgG5MyORuX88rFxMZn
         JiYw==
X-Forwarded-Encrypted: i=1; AJvYcCUznRlcNw8WYyTLrx/MSfuOx9ECMezWoAzPw0x6y2CdE+sraYL1Ou618JC54i6Nbjn15NWab/aF8s69S8+0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63Pk9jEbB8F+PWM5Ly0AK85uxniODr3SazDcKiE1VYDb27Vit
	QV7a0hSxMQIJSlba/co/dLBCAHc1TOuRwOCz7rpmczyHU3TOwM+hRHZsA5mn8fLYtbB3U/3g27f
	0hAZrnc8=
X-Gm-Gg: ASbGnctv9gpiqpKCaOSqUZDRO0XiilQ0155+LSVvwLSXPIvGtjRgnOnnAxV3h94X+vV
	FqOyLVYIWJaGKjmJWS+7pDbqXPpnZ4TgG6mkFUedL+PU4Y0okJr3mRYjCyZ/eDBJxAiDx50+iXd
	WCrFAT0ZQJAceOXyBu4gyXU9+RPqoPHV6Uy/LJGhIhEx1Sp+ufuYDKk8zwmdlhNuGXxlF7GvvWD
	wsm77IbGrGnEnsKkazb4g1iRh2i8zWKliXgTbe0EVUCjU3JDyC5uls0cxjlCHpYCbRqqhxxWLKZ
	FHQIVe6IXBFto7NycyV6dMbMqDNvfG6WAPkdX2XJmesoIFbZTh4TxqiE0RZJXVeeWUxjy9Apx2h
	+4ndp6vuSn8WdW0q5vqav5Oz8rBc0Byy83NZlaHDMvoaGpEoVUEt5yfvyOdNkPX1c+Xf4vfty/S
	ZZFau7D9zMNucifejQmT6o07TsGOxYTxWptY/wM6CyJ50UPsCW9lPIZR3ASyMT
X-Google-Smtp-Source: AGHT+IHfOU9uqip5J9zxwxH0O5VszPyc7cq61ny7OY6/DW28jaTmXbrLVjpLjG/MB4xC+jxfEb4gAg==
X-Received: by 2002:a05:6402:50cb:b0:63c:4537:75c0 with SMTP id 4fb4d7f45d1cf-64061a88dcdmr2683468a12.38.1761840966797;
        Thu, 30 Oct 2025 09:16:06 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6402a6be2eesm7849654a12.16.2025.10.30.09.16.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 09:16:06 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c31c20b64so1888957a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 09:16:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVduePhtKL/xP6g6sNyuSK6MhOay+bBQ5AW/pnve0uvmeB0iTyDI7AHIU+eXlddsUcL5U+WRfc+2NKroRQM@vger.kernel.org
X-Received: by 2002:a05:6402:158a:b0:638:d4bb:6c80 with SMTP id
 4fb4d7f45d1cf-64061a85a65mr2751516a12.36.1761840965644; Thu, 30 Oct 2025
 09:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com>
In-Reply-To: <20251030105242.801528-1-mjguzik@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Oct 2025 09:15:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmbYP_XajbVrJr4WKmI6U_GU3vIz5LIod-PXSCdTIzn0TCAmvCzK8JZig4
Message-ID: <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Oct 2025 at 03:52, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Should someone(tm) make this work for modules I'm not going to protest.

Btw, that's a good point. When I did this all originally, I explicitly
did *not* want to make it work for modules, but I do note that it can
be used for modules very easily by mistake.

> Vast majority of actual usage is coming from core kernel, which *is*
> getting the new treatment and I don't think the ifdef is particularly
> nasty.

I suspect we should make that #ifdef be an integral part of the
runtime const headers. Because right now it's really much too easy to
get it wrong, and I wonder if we already do.

              Linus

