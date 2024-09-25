Return-Path: <linux-fsdevel+bounces-30112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E60986475
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 18:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D904928A600
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 16:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48773D55D;
	Wed, 25 Sep 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSv6tBBX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDE52F5B;
	Wed, 25 Sep 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727280399; cv=none; b=QZvc7hdc4rsE+OQ3iWQK/McS/Yp/6XCAq5U9FC3m/P/sAta2vHfv3GErhihk25h++4t7G8GceX57LqPbEcpAZIGsFOPIspgt1dSHBmBrXm06w4qmbgCUhXlGwYTdsTQlSEcOY63j66fi1ErSTDDhrcOE1RhEWSMSpT8plOAYzXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727280399; c=relaxed/simple;
	bh=2Wpg2PjOSk/M4D8f3ZoLXyifchNF3HCLIWirDmcvRPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rg1xCo3kWdXEsZrXxamruv4p58X4bmBUYzmdjPJxAoG8CWR8JcL2dZz+eXnuRIila2V0AXZBpQdXZz/BFcutMqSGKqGA/QrspwXC9JUe57L3lJhp2mDCNsniaTzNNOj9aGKOcC+MDOrtupyPQGdoMy9b+nxzyyHZ3z/U71ldv8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSv6tBBX; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f6580c2bbfso9618481fa.1;
        Wed, 25 Sep 2024 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727280395; x=1727885195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Wpg2PjOSk/M4D8f3ZoLXyifchNF3HCLIWirDmcvRPE=;
        b=PSv6tBBXqtYRf+bFFSSyY6Gz5ZS+09z9IYDPl6qDIXcrzNzyVXrtZ9/5E7MYgqjBo2
         MUkIrn6YLgEdsR2rTrwbRRv2Rg3QXuBxH4BYEuuYRjIfOIKb5bCKdrh580ow4+XnZE/T
         8YI8M8bE9SyvY9QhkHtkSi7TaiuJIXGicTMI/PjEWaJ2TmaPGQ59SX+U54jvmX6zZho2
         uaWntNgC4/S9WO8piOey9B+9h0MarHXZy5FEgtrf4h0A7ZgpTanxPTLLUiWzIQHdoNbX
         8IBeOmNHbigJzFN3K+y3xwDa1SVxzvYxixrroN+Q3ThwcErPrNaKqnIpQ1SR/2QBrmnq
         cnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727280395; x=1727885195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Wpg2PjOSk/M4D8f3ZoLXyifchNF3HCLIWirDmcvRPE=;
        b=EBkTaJSJmPrSMu+9IIYNd7v+/EV/3uwiy4L4i0Fudf/2t7vhMll6ONsuSdibCfYfKM
         Wbw6J2XCxEsok4T8wXcaiuswHYwp5wrHmYEfCCSBNJ5k0ljigKOQR6JOO+oDGA51skVB
         yxkN2vwf9q7UV7N/HFl4u4slOguJYXSHNER/3EeWCmff3o1OcfzEXiG1SNmyEq5iQyXq
         etXKtGXZXjWTP/YycapRzWMizd4pviVltPIU31DFL13DGhhEHBhSKv3yTeQhMGdhXsAx
         eyvyTh/14m2u8oHw1k9VKc+oZjQBQFwvMVnUR/OW7D0wp1CJ+ey2/Ydzb1LYnOmqUxqk
         fxxw==
X-Forwarded-Encrypted: i=1; AJvYcCU2HhC03z0KOWw9AKsN0gZCY2xP4NUY+eEwynG/jDN6ZbrbxOeVKgz25V1BJ6VH5Q8NwjNBdWOmJ91P@vger.kernel.org, AJvYcCVoB+t7UMNkoAOlXpUelOVIsf6OD8xiLGH53QPABKmmD9/2mG0LfolketJ57Cxjf3y2Iy/kenN/PGq2NAVt@vger.kernel.org, AJvYcCWGm/bIK2IU6Re41H0JVa1RPK8oxC//2uPXGRSgaCnMMESVLOUxaDj5CkYqYqT5TyCSm7GQb8UH9dHlKQ1O@vger.kernel.org
X-Gm-Message-State: AOJu0YxtgGFpIYIbEQgpvhFvCJoCE9DRJ3QNSrWmJLeghWjkYoVBT0/o
	fI9EKgO8phvf5a1jE9Hf38zdCxqZzKfsxC0KWf3kQWIvy6x4hDMSaU4Smh1/ZddH7zKqYD+PnMq
	+ElXwPRixkgRM8EsEdIBAp7k8+Uc=
X-Google-Smtp-Source: AGHT+IFfTUuhRjGyeGP067T50/GeAjOgvxwBokvoT72wr9zTIkRSPAAxAiRwC3Lcnvamx1vFFxiaaHJQqlay4IHWcBk=
X-Received: by 2002:a2e:611a:0:b0:2ef:1f5e:92be with SMTP id
 38308e7fff4ca-2f9c6c66aa6mr392431fa.9.1727280395131; Wed, 25 Sep 2024
 09:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a3b09db-23e8-4a06-85f8-a0d7bbc3228b@meta.com> <87plotvuo1.fsf@gentoo.org>
In-Reply-To: <87plotvuo1.fsf@gentoo.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 26 Sep 2024 00:06:18 +0800
Message-ID: <CAMgjq7A3uRcr5VzPYo-hvM91fT+01tB-D3HPvk6_wcx3pq+m+Q@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Sam James <sam@gentoo.org>, stable@kernel.org
Cc: clm@meta.com, Matthew Wilcox <willy@infradead.org>, axboe@kernel.dk, ct@flyingcircus.io, 
	david@fromorbit.com, dqminh@cloudflare.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	regressions@leemhuis.info, regressions@lists.linux.dev, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 1:16=E2=80=AFAM Sam James <sam@gentoo.org> wrote:
>
> Kairui, could you send them to the stable ML to be queued if Willy is
> fine with it?
>

Hi Sam,

Thanks for adding me to the discussion.

Yes I'd like to, just not sure if people are still testing and
checking the commits.

And I haven't sent seperate fix just for stable fix before, so can
anyone teach me, should I send only two patches for a minimal change,
or send a whole series (with some minor clean up patch as dependency)
for minimal conflicts? Or the stable team can just pick these up?

