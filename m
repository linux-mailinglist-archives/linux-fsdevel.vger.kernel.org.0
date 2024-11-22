Return-Path: <linux-fsdevel+bounces-35554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AB69D5C25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 10:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233FE1F21E8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 09:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FB61D86E8;
	Fri, 22 Nov 2024 09:48:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F8B18BC0B;
	Fri, 22 Nov 2024 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268892; cv=none; b=llMQa6i0S0U+zSpDNv9fba6NHfCyxJtbkFQfAdUXXY4INUz1opHiCORUb2x5KK6K+cDDPpfUtBKVv3E2AFtq7FZhB5qyKxZdqZupgi+4cpekHzHsRiEr7CJlhSCdf9q+kiFTSQQ1xAuy4fRam3VFy9nnEKbp1fDMx2nD4WiH5bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268892; c=relaxed/simple;
	bh=JvUgqjr6s2/FRqHk+qrgV73fODETPiHdTUu5OJJit9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHfKBv2LUM7+9nWw7OTpBa9/EmzHAHaUEI0b6nXf8dWiFitTK1UcbeP7uQbtWBaY0uua/XFw4d4n7QqZV3FgSrXogBAjAPbzmGDICx27vYyN+9cB2M7xs6STHN2FryDq2k+FcBn9dZImIqYmL8xtliLdWO0itmHrxZoYYy6PM7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ee7a400647so20866247b3.1;
        Fri, 22 Nov 2024 01:48:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268888; x=1732873688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVP/HAZ7MlP4xLGhGVdb8+DpQFHiUFQZZ+lgLfcrmgE=;
        b=WeEdEE4y/70ZNjHCyBuGYWDDnljxkX1oulXtdm/iIDFmq1b8NhonsasCvSnYiQEjFR
         7Ejcm1jB8/UBGp/AibnkU45YeeVkRbzhkOFq6j8Zr1C8D2vIPmtSGQUppaqVsCPAYkoP
         VB7v3Q7lNcu3wKnNaIH+ktONr/8iXDPKz6x4d/S1chsPEvBCNoWD4d2YoPnWBW8a8eM6
         6d257i8ljSRG1b+45Z63d8GrKFjvO2R8q0bGIpvT7o/2IQcTmxHXrVQGOCzllVU33iwk
         ihjuznXmmtYNCnHUXFna/9s1O0t3z03N7JeShpfAxWQ3RK/llSHIiw7PqcPL2Mz9dUIg
         o25w==
X-Forwarded-Encrypted: i=1; AJvYcCUUom7ZQAcWMfIYX05+dMY64F6DqwbQoe+f+Y2BCCtGPyB6WvaPOaUYZgc3LfU1/vYMYf4ADxA4s4PJ7O9I@vger.kernel.org, AJvYcCV6xToqUMZl5+Ivr7TUx54rDftGT5aiF5OkLJN2934i10wUM86gLN/O5xLKGMH6Sw1AtuDs/241KwtOa9LrOQ==@vger.kernel.org, AJvYcCVjHNHGQ5fYbbRPliR/Ni3nADfpEvTB95z404hQ08eTimwPw0yJLB3tONCdgrd88gSV9pyot5rsQ6qh9XBarOz4dVRv1fVH@vger.kernel.org, AJvYcCWHx/kT88t3k3WTfviA1gn8phguglm6eDI3qUXKarlIqLMv+K0lDvm02ZNF2I5vElxdkJT8I8jtTOaEV6VhfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYq0PyPhvFmfFGx1qQ/puI/ZE+bJYprXsqZtrCY0KxSVZx/yt7
	DRVHzAkP58y1Mb+IA4B/ld+oEyDtdvlJxDP56OT68uSzlf055TLx0gwQ0NQm
X-Gm-Gg: ASbGncu0Kr++nTCQQW35MajfrVt1frly60g5/9izNNkIrRGruIrlZXzOnpHjFqYExV0
	Gkn4h/Paayrno0BjG41gpowVvFa0WralTajQxaiVFWOGfADJjiGAkY+mzcQEo2CiRGVdsBU71wN
	sp7FfSukRXoFlVkqpYxj2rLcVsLu2NZ222DNhSpeuH1VJlhHNxht1ew1Uo8WxKmqZ3PdjhqgriI
	OjP9K5a+MSC0g7gNCG8kk3RhkzIHewEXFOVUIhcYqE/w44qyKTl4FKMi7MvRJfpU9F8ZEpQbRxd
	yLa9AWEq/oq29SeX
X-Google-Smtp-Source: AGHT+IG4Volgu69JCo1TR4kVUOkN6Aj3ZwlBQTrI5rwr6zHvNjcw6OsUKiTmodaGWpsQg60xPfS62Q==
X-Received: by 2002:a05:690c:6406:b0:6d7:f32:735b with SMTP id 00721157ae682-6eee0a12f65mr25962087b3.27.1732268888168;
        Fri, 22 Nov 2024 01:48:08 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee00836a6sm3791867b3.71.2024.11.22.01.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 01:48:07 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ee7a400647so20865617b3.1;
        Fri, 22 Nov 2024 01:48:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCXcKV4au1J//hgjHBYrgccerBhlNf9PqkFyYFa+KWPvNtY5aO4ZzFku4272sbWSUW9gyDrP1CV1cYhDXfdA==@vger.kernel.org, AJvYcCVWZvG4fj5TTZlmNvGgPEMaulxeVikSTBbTmJ9SOtINBpJrmwYdaybGkJyPekvsRwHsdpFfrQSfD5SAL8HmH5OxQEMINUzQ@vger.kernel.org, AJvYcCXHZf48Xb4Z6DWIot2QekBAVPjt+UcKToXtIT7h7ZSsNiDXshEMgze47uGj/HJI26Ru7gxLCLjHvoGVPoPR@vger.kernel.org, AJvYcCXOhY3ZJbjR6v9q+WvkjzDxGWkdJukumFTxK9bq352Nn0GYNytrA0T1rjhnX2BoUpEjqsyZBqEnFekLpCD8Xg==@vger.kernel.org
X-Received: by 2002:a05:690c:3501:b0:6e7:e68b:f883 with SMTP id
 00721157ae682-6eee0a2fa53mr23853727b3.39.1732268886935; Fri, 22 Nov 2024
 01:48:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZtWH3SkiIEed4NDc@tiehlicka> <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
 <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
 <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
 <v2ur4jcqvjc4cqdbllij5gh6inlsxp3vmyswyhhjiv6m6nerxq@mrekyulqghv2> <20241120234759.GA3707860@mit.edu>
In-Reply-To: <20241120234759.GA3707860@mit.edu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 Nov 2024 10:47:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVdF8S_dsktOaRM49st+tfyrx6NPK8k2AK96-v=G6LYzw@mail.gmail.com>
Message-ID: <CAMuHMdVdF8S_dsktOaRM49st+tfyrx6NPK8k2AK96-v=G6LYzw@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"conduct@kernel.org" <conduct@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 12:49=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrot=
e:
> If you look at the git history of the kernel sources, you will see
> that a large number of your fellow maintainers assented to this
> approach --- for example by providing their Acked-by in commit
> 1279dbeed36f ("Code of Conduct Interpretation: Add document explaining
> how the Code of Conduct is to be interpreted").

404

The correct reference is commit 79dbeed36f7335ec ("Code of Conduct
Interpretation: Add document explaining how the Code of Conduct is to
be interpreted").

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

