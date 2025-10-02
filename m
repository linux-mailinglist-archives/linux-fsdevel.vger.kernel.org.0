Return-Path: <linux-fsdevel+bounces-63325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA33BB5243
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 22:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B8419C6E89
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 20:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3219728507C;
	Thu,  2 Oct 2025 20:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuAr4zji"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF4279DA1
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437837; cv=none; b=rrxUBW3zomdQYmgxI4qPg6gHpmOq/nZvZNzcLUmbRdGn8199DoEV0KFeCbbaAENQOAX38Z/2iCDDabqMTEpBj+kR2wSJzrTuBHOxfCOD1fZ9JMMO/Z7YUsmF4Hue8ZhQzmj/xty0gyOS1Oz9/J8UKHBNRDqQXAuZPyOlK7ZM1Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437837; c=relaxed/simple;
	bh=7LGwZze068Lu/GpaLJmytdItdIGOo4SAb+92tdQJQdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SP3WEEy3w61XVwCKGP/oSHj/LsiREWEK+ihn4olzrE1rhJnXCHCOnALUfS5lica2Wh9owvpX1oeFEhmskvrxUz0MPxcYB6MJUz5xSOuXUxZnpHTfKpeZT7SrIrZN0CCtJ6xtq6l0kEqOfaSgOsckHl/HkqCIl8WTUkxmOoERhxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuAr4zji; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f605f22easo1534325b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759437835; x=1760042635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4vbtDR42cphJfLdvZJgDXhBmOoMHXbOXYJDR621+K2M=;
        b=WuAr4zjio+u1bx4hV34RJMm2bp7GM0F3qJ2BGQKGGm2CGKd6R8h5418I11C0Cgtrq0
         S+ELk9AMtl/+SYW3WgJEFMiCKoUHzsms79APY810zWvLW8AywCCgC61GyY4s+ugDTmeL
         +lUnzRif1HeKB5mUjbnnpoE7BoGSYduazW+BYx6FH4iDea9OJ2Iae/AL7eNlFZuwldnl
         O+8Xi++rpo5gGXXwmpy0QRs7a76bku96cEXu299dGiJVv1MRq/CBce2LeyvEpbQFmGfz
         dUK+fllnTtu+22dz/2MHb8PiEVyF4hiR2HU0WK+GrMXLocXnWqOikqmB7et6f3FM+zuD
         lO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759437835; x=1760042635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vbtDR42cphJfLdvZJgDXhBmOoMHXbOXYJDR621+K2M=;
        b=VljZvLZ2DoJUwSQMhBlGIP5BhK2H0y8Ba/3olKlyT+hQAtbLRFTX++mK1InTJ68/XI
         gusJsge9LLPJyDN6yb7zWjXGIMpSiGH8mo9z1xyTB5HE6BRuUnx5WPNEdBNyxihJ4FDp
         txWA7LudXyUz7hxnuaJpbibbQtu6EqsD4SZYXBu6NaBKFSvo+JaCZmqK28B6ymxqYgsP
         0FkotU5YVh5p9oxv5/Y8lCRAQoJ+l2PQekN0haaorkGFboFNyU7jOlmxl68HK2cusJCZ
         5j0C4mS58h5XY98vwX+96UFnQZqCYMuV8HJavomyUHUecgk6/sVPQYMW9lup8TGY6b+S
         EyWw==
X-Gm-Message-State: AOJu0YxCBQt0ZONRfDQMdBphofnPvdYRk+1aKd2xTrdnXVkeJBXScVtI
	gH5O/ykHlj79/YA47TB4ApvTGfRhz2mSjBM06VIIgaAGIOurtZMt76N13RfGbQPBEr96Oauecbg
	wCC2XdvdyEobCAyUdOqhqe0gPnazualGBHsmHKpOo6g==
X-Gm-Gg: ASbGnct93l4WGWDXqRrXVe4S2vIzYBgJybTFXhPuy9Xi4c/fuIGc/pib6bnIAcBbyua
	GYlEZnLFNGwC8+hZ1+Mm/5m9hl9PwqRz0nh6Q5J0pyel3ML2Ic8D1l7GFkHbYD0m76B6cZmArcC
	zeff6qiMhaWD/s106uQnUxalDPIJ/8sYgO5r0qwOmUvTyuFFeCy6EkSmilSm70fZN6GTgws4rP+
	mGvPtzct37VC1BID3Pws88g9MUBZcEA
X-Google-Smtp-Source: AGHT+IHjFL8saymDRVQ/rhEf1pB6Ad9cgYyxP6w3X2wUis8VTUQlMZtvc3x2PGXVP/SJ6uxoKKWUcDPEnan5/CvomWM=
X-Received: by 2002:a17:90b:4ac4:b0:32e:345c:54fe with SMTP id
 98e67ed59e1d1-339c27b94b0mr680042a91.20.1759437835505; Thu, 02 Oct 2025
 13:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD8Qqac-3Oss=M4aU0B_gKCzBhuUo0ChH+8wFkWDPz=mQVqSiQ@mail.gmail.com>
 <20251002123505.GM39973@ZenIV> <CAD8QqadrK6nY3e1BZV7DHkBwUNevHnQC1cWi8akzxY2Z=B-b3w@mail.gmail.com>
In-Reply-To: <CAD8QqadrK6nY3e1BZV7DHkBwUNevHnQC1cWi8akzxY2Z=B-b3w@mail.gmail.com>
From: =?UTF-8?Q?Miroslav_Crni=C4=87?= <mcrnic@gmail.com>
Date: Thu, 2 Oct 2025 21:43:43 +0100
X-Gm-Features: AS18NWBGAG9-Y91pS76JcG4GtcK2v06FLAnXCz9BArlzEN0WWUKh-sdX43VchZY
Message-ID: <CAD8Qqae8McuXMcpeRdYT79DXS+fcQhh54iS7nAG000VQ_MR7sw@mail.gmail.com>
Subject: Re: shrink_dcache_parent contention can make it stall for hours
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Do you mean dentry_unlist()?  The problem is, how do you prevent those parents
> looking inexplicably busy?  Cross-fs disposal list existing in parallel with fs
> shutdown is very much possible; shrink_dcache_for_umount() should quietly steal
> everything relevant from that and move on, leaving the empty husks on the
> list to by freed by list owner once it gets to them.

Coming back to this after reading the code. What you are saying here
is not in line
with what the code does.  shrink_dcache_for_umount() will get stuck in
shrink_dcache_parent along with the rest of things looping there.
Nothing leaves that function until select_data.found == 0 which means
all things need to be unlinked as select_collect counts in select_data.found
things with ref_count < 0. (among other things it counts)
I am not saying select_collect should not count it.
I am saying that following is bad:

"Looping through a large list of already claimed work while holding a
lock needed for
this work to complete and then only claiming at most 1 item from there
is extremely
bad."

If we can agree that shrink_dcache_parent does the above we can start thinking
about what solution would be better.

