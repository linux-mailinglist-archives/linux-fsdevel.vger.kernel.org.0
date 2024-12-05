Return-Path: <linux-fsdevel+bounces-36564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D93D9E5EC0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 20:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5039B16C427
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 19:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA6322D4FA;
	Thu,  5 Dec 2024 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ROYskDul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0134D218EBC
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733426817; cv=none; b=g3vmnkz7CDmhK9mHxfkwLE0yI1mK0DZfZ3CJqiFdDO8O6IKy7C0jXycuU/gb5pPEMR2J1BBCHiRz9aBgBfphWfqww3mGMhwAl6mzoesUso1azxYwtxvFeqj77nXbLcdivabcC9dMxRVkiYfnNRgC5hv2qnCbT27v9LIHztwCeZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733426817; c=relaxed/simple;
	bh=RKXhCMXvfJXkHiVgHUqpW4IGz6rcjdhtT4SjnmZZ6WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEBBxlnIQ266BG9V32/WaadBq1QfRv4jDUDFcHWA4OhIRgVzGmUad9vIazIcypTA96V2tv9ue3dCJlaU0Sc5ny2Vr+Or2/I2DOl647B1P/2UK1rR49Pwi4p1OsinsLfVrPmb97NlyvBUt+pKhh5o65uyCGbybL3IAFfYO8YSx8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ROYskDul; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0d3dd3097so2073931a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 11:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733426813; x=1734031613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XWh2Ea994aJGegiZF+JWYE2IVRgn2FJbG2ZX4otv3lI=;
        b=ROYskDullIt2hHKGG3DZHwAoSdf9kqjXxSY5bAnxpibdvhzljEpWnmHRcB3FJBEaoh
         UrLtt11Os6Kc1FwDC4RPMNBgxU/nHruhhbk8JxkxiCXxS6UiLcbLO7PEcu6WL4ffBSyP
         Fz/Hkl0QfvyiBl/0TJ9ylds0vfwAIWWAHaPfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733426813; x=1734031613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWh2Ea994aJGegiZF+JWYE2IVRgn2FJbG2ZX4otv3lI=;
        b=ueRJxVCMzVhS/bF7aQg7m73VS+pqAxPejWcVKGMgVLxA+ZR9OBsWw1Z6h9cEkjeC7w
         WhQFuQ26xNzEie9PZYQfM2DDO2XlvnfiDiW1i0b5VNmwJSDkqzOA4ZokuPAAvJNEi7/J
         whv+XhxZxZ2KIIZQyfi8TFeELlGZfSd88eqJFZ7Z8bIZQcd7UR4kqAlzxREyuYHaOg7z
         z3EDWDYNR9o8Sdb2Y3moEQGQz4s/oYXASWpmqYUYGBEntiZk0eBHt6w/0NS2VEsUyHO4
         mANfuExzvLN7JUtAUPlifptgVm+J2gwIKdlaMvjC88L21RYrrqpHMBskWw7EbieTc9L2
         tHIA==
X-Forwarded-Encrypted: i=1; AJvYcCXjWnp3RpqozG1zthKCp9ytsXbP2MDhSZp5bN6oxD6BUBpQZm3RNrP7vDPfyT4MVd7VZT0LRmhUDECB4FLq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+tFM/2rdLCusvt2ieX1wXPhOzTiARhcWLmPOZV1lXIOQSxO7R
	lfWQOQlAR97CUGGyFbo+4ji9jA3DGEpleVT9ZM5W6wWy3dG/IDcZDJuTr/2jmDFN5tF/1DbgQGn
	vTURNSA==
X-Gm-Gg: ASbGncux3nsgicVUOmmujZ1s0s3782SxHdqO6+MkNCJJNVOCHobgIdsAFqlJHCNh1dc
	j8UR6rtXa5P+3WmBWFB0AQ+uQhefEkt9OA+cdP0oUWFbbEiqZNOq/Vr5n7KNT6gSQnGS+LgyjaC
	AbWu9INrgIZnA+HLFNTYNw9gofGKC9yEnERypAmQW5z0oLXjoinRbtvz0CbH9/jhtvqwvXr4Vu3
	bA0+lW+w/1kF6SAyxZ5E92MdWZyYgn+I2I3dXlzkMA6SAbGYm8/CDrAkKhvETgOqZqPSKAtMeTm
	9CHpqBoeiAz2YiNDxxyL2+ij
X-Google-Smtp-Source: AGHT+IG+3xL/aAqT15PnEd+bsrfI2q4TMY/t7pU+R8Ob21sLFxwq5g6gs0cR74FiXemfN3swQpPtUQ==
X-Received: by 2002:a05:6402:3485:b0:5d2:8f70:75f6 with SMTP id 4fb4d7f45d1cf-5d3be7215cemr237862a12.30.1733426813037;
        Thu, 05 Dec 2024 11:26:53 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c7aa9fdsm1148789a12.84.2024.12.05.11.26.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 11:26:52 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso237391266b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 11:26:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWffj56uvX05RYYqogjHClPBx8btAYZTnDvzxI4eSh7GQ6hvZvIV6WylG92AEurvXbA53mU91v9z4Zj/96g@vger.kernel.org
X-Received: by 2002:a17:906:310c:b0:aa6:2605:b9ec with SMTP id
 a640c23a62f3a-aa63a26904bmr3273666b.43.1733426812112; Thu, 05 Dec 2024
 11:26:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com> <20241205141850.GS3387508@ZenIV>
 <CAGudoHH3HFDgu61S4VW2H2DXj1GMJzFRstTWhDx=jjHcb-ArwQ@mail.gmail.com> <a9b7f0a0-bd15-4990-b67b-48986c2eb31d@paulmck-laptop>
In-Reply-To: <a9b7f0a0-bd15-4990-b67b-48986c2eb31d@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Dec 2024 11:26:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjNb1G19p3efTsD9SmM3PzWdde1K2=nYb6OUgUdmmgS=g@mail.gmail.com>
Message-ID: <CAHk-=wjNb1G19p3efTsD9SmM3PzWdde1K2=nYb6OUgUdmmgS=g@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
To: paulmck@kernel.org
Cc: Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, edumazet@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Dec 2024 at 10:41, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> > To my understanding this is the idiomatic way of spelling out the
> > non-existent in Linux smp_consume_load, for the resize_in_progress
> > flag.
>
> In Linus, "smp_consume_load()" is named rcu_dereference().

Linux.

But yes and no.

It's worth making it really really clear that "rcu_dereference()" is
*not* just a different name for some "smp_consume_load()" operation.

Why? Because a true smp_consume_load() would work with any random kind
of flags etc. And rcu_dereference() works only because it's a pointer,
and there's an inherent data dependency to what the result points to.

Paul obviously knows this, but let's make it very clear in this
discussion, because if somebody decided "I want a smp_consume_load(),
and I'll use rcu_dereference() to do that", the end result would
simply not work for arbitrary data, like a flags field or something,
where comparing it against a value will only result in a control
dependency, not an actual data dependency.

             Linus

