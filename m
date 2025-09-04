Return-Path: <linux-fsdevel+bounces-60262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F16AB43936
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 12:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D914116F559
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 10:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E904C2F9C59;
	Thu,  4 Sep 2025 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="IAZAEt1w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AF84F5E0
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982977; cv=none; b=BZ26RQZACeT4qNvbHJ3UE8h/+ZthBRO4ljiZA1u8Oj2EAOAIMcCgI36wtNYlTHEobPHBTPFQnBzCl3KvkkM3/HwA1wDKAg3sThWnWIIkUqNuKDN50NWXcsrrjHyel5UgMEMP20sAytSrcxyH2y2DQ3MhIcbP+y08OjXigDhn4KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982977; c=relaxed/simple;
	bh=//8EBrL7bPSYlJCxIW2tBMkkiNZRusdYeYVdFgJJdfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJgLR9yc3zJ4wkfRiKzIrN33DdopOVbjhPn40Ityy7q2kpk2odaWPRTLrbua+Yun8juQfVjRWvqqC9cI2yJtVNh+VJ9Bqnq0YwwjL9No0Y7BXL9unBWD22qMM1sYd3ORjTdah+vXjHoj5kYPONdgE9o7vtORU4EkJKJ8M6ec6G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=IAZAEt1w; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b30f73ca19so6219941cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Sep 2025 03:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756982975; x=1757587775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=//8EBrL7bPSYlJCxIW2tBMkkiNZRusdYeYVdFgJJdfc=;
        b=IAZAEt1wtzaHWkvG0qLDSU6V2j90g0F5FiTZARKhWRZxOC+mdNvNDyjsEyn7yPvgHS
         /F6/vr4oUbL9ohoo343iJaGAskG+cYhHQqRcKu5t9M+I8lPGBT72G16+ZcOY4HOAC+Zg
         /sDHKpnauXII6Ur9ylM1fpPofR5K2Yyg3+oCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756982975; x=1757587775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//8EBrL7bPSYlJCxIW2tBMkkiNZRusdYeYVdFgJJdfc=;
        b=gwViVY1i5UK+VVVHeXN1xymhlZgSkOPLww6jPGz0lphZFUu4pPTt69Ft95Uae+pcSN
         H2MHF8CMdQ3zRt1NAhWhlRdBWuN1WVyPmAskwycgbL/lHVk58pgGrHyzbDyxhwuIovZs
         7qXa/sgrgD+bHGei1cHrjOHnQbwXSr1oX6QZURR0cAwGY5wB9Mlv9fniKzlMayW/ArzU
         boH1dE55wp8Dr5TY6NCb3nAMFRbZZ9AbL/L5TVF7X0GjE90CLlt+/CKi+1mx/fEc7KqC
         5N0/wZrsriGGSGALGTO192fT3uxdPzB8+lm8hdADnx19RDwCGHYgjNGNlQg12CXK+uA4
         DhKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWZ6kGv51NhWyWBnZZfITQZX410FFogJU1dX1YIVXjaO4jzdgDM0WGb5GTgyNZk4XRvToBFJiYTGRaL2x3@vger.kernel.org
X-Gm-Message-State: AOJu0YwWgnpkHd+o/JH+BJlh5AmXFHApIhsbZWfwYQe1z/TedcmXjnsL
	RGYMCufyXa5RX0HPwNHUZk7QD6GxQN1SQv6jUoOD0qi/UbPB5b04CIjuw3UOpzCcBqJxAcl0cAY
	FC/wi/eHlIHS7WtyGZl0fiV/ulYCYZ3cyC8Razsb8NA==
X-Gm-Gg: ASbGncuYAT7uXUZ0AqpCatVrO5BWV8T+6uunhCiLGwYjDJFoykiDXKnAocAX3JmAxS4
	TInSO3MEzX2PpIwHn9ZFLRyHaufT5FhvG0N213I9c/Bm6a2pPdYucd6ww7MrpZdP3EUJbkZlz0+
	90zVEx8osCeSdUa25v2B4aZeXvwPicTX3p5Y3KCc/PzH0ODwmTxfad8E5NwKEYNATYHBZMJJcMj
	yjTxfNCKgjxHIGkT1iMe6L4GJ+MmHw=
X-Google-Smtp-Source: AGHT+IE3FoBUVXlT3poBVYx3ZNc6/sCwJiRGX89iTNHmnhuNpD2F0YYBTg1JffTAFVBuCNUiUzsvYXvMaj/Tix2DUOE=
X-Received: by 2002:a05:622a:130a:b0:4b5:e06e:c691 with SMTP id
 d75a77b69052e-4b5e06ed271mr7028281cf.66.1756982974935; Thu, 04 Sep 2025
 03:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708651.15537.17340709280148279543.stgit@frogsfrogsfrogs>
 <CAJfpegtz01gBmGAEaO3cO-HLg+QwFegx2euBrzG=TKViZgzGCQ@mail.gmail.com> <20250903175114.GG1587915@frogsfrogsfrogs>
In-Reply-To: <20250903175114.GG1587915@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Sep 2025 12:49:23 +0200
X-Gm-Features: Ac12FXx2EZdDfvUaksmUYKAzVldH_kBpm-gLPdQ8wGCTg2ienZTM4lRxVFb5QJw
Message-ID: <CAJfpegvJYudgPE4NFrqmg4bLmNmmBmKOgXJWq7pRq8bfMXbRBA@mail.gmail.com>
Subject: Re: [PATCH 5/7] fuse: update file mode when updating acls
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Sept 2025 at 19:51, Darrick J. Wong <djwong@kernel.org> wrote:

> As suggested in the thread for the next patch, maybe I should just hide
> this new acl behavior behind (fc->iomap || sb->s_bdev != NULL)?

Okay, but please create a fc->is_local_fs that is set on the above
condition to make this more readable.

Thanks,
Miklos

