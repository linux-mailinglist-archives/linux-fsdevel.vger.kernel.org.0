Return-Path: <linux-fsdevel+bounces-40931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72491A295B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 17:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0523A291F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5DB194094;
	Wed,  5 Feb 2025 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="euaXf8nh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F92B17B505
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771612; cv=none; b=rQh03xq2kwNXpKe1B1/cl68QNQVmjL4ICCKPoYY2AvvpbJ3S5Kq5Q3DKJshgeWY96AD8ZqRxmt/qolJ6LDZIWUU8aoyx3yUeRIQNCJDnEbtrj98yFJMPs9OvvGrpY3iJf6XNZiChlAIdTMKjU9savF9vIbWkD4rTvURZIhmxqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771612; c=relaxed/simple;
	bh=RqbmmJCSs+vqeDfuEh3LyaagpG45I9aLSsrx8U8tdKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1KWDIYC9tT8I3GoA906FfS0kvxOAqOvGudT9KiidfiEwM7fgh2Uu8elDPMNiDfcqHGKMOi1cTtuAnvpsp40Slg2l8q13TiUg1CyvJZIIjtCsBsY0wjXTbYbLmU2zG4YGvOB+ajXHmXsfngDIJ362NM5lQfssvKltDzBnWiUsnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=euaXf8nh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so2273448a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2025 08:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738771609; x=1739376409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yuUa4gQEbOKQJW4ZYh4orIOUTVK6GAF0b47tSOHp+ks=;
        b=euaXf8nhhjEYiOx98Eod1y0FcjzpauQ+1C/8uinx2dYl+2N6+/QqNOfOsSibE8LTnM
         CJWzkFxRHMmkWf9vglWnwJu7c2NqDgjjeBHB76Sx8OgTuD3GbKQOJ257uzOmJGgYYa8h
         j/vRcVDXlO7SCO14zky4VX5vBfxYIrgVkfo78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738771609; x=1739376409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuUa4gQEbOKQJW4ZYh4orIOUTVK6GAF0b47tSOHp+ks=;
        b=bf74FN4yIlu0JBqWv1Q/43eXqn3vJNvXMhZLkK+krlVHsARvGOnN7iobL4xs95lHc6
         Ghq97S02zPBer22q+/TCt8ACE/owYmMsjor2ERcYb3Sa8mXrGHvvXlXt0xMAK3qLrY5Q
         sEKfNA3DdATgM/742moxnrcWLO09GF1EM9rDGUTfXwwbkToMXTZvd5r6IvnaoEsjZo/M
         VWNFaFIVOT30iq+o678JJYWk2KQKNcFnLECqIKRrPNePJIKvDTgLZzfwfUMsqbympbyn
         aPd+N8jz103R2Ahd4fQoLCJOiFrmeEZhhRzWWYbFSclPpunmg0ETsB5sUiB0ckNx9XWL
         du/w==
X-Forwarded-Encrypted: i=1; AJvYcCWTvGE/5cdLQoYTmrRblTU4ic32ada2fkobLcZtMDAxyVYKd5oOknsZcSxCH9kY0s5KctgdughqeAfje4o/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0aYzAWUT41J0OKeDQ91OqrhcuSxlELSCxwuOdrigZ7NMFLmJa
	xUhLGvXdXwRLuVnFSEjcHGf5i+JAC4h+bT5jcfFjAUfvKNjC+v93MEFV9BiAXuE+ZI2cLjYUI8/
	pJ9Q=
X-Gm-Gg: ASbGnctZg85TNQJ8N7kcasTVJEoExv0GwK6sDt/C0yw0QpDa0Qp6yq6CCxH0NUibHOj
	uHTce3BDrmmCdSIlqWMbJ1y5IIrPrAIY4KiDZ+EkzVxEZzMt6JmSxJmkTZX+g0HpEZZdiSTUGk2
	hn79zOjmk1FcedfhC0BoQOtUNDYvWGuXyZu25I7G2hE28IOo/P8+FNl3Ra2De2mZSEBHPkljwly
	LPhWjGqsiN7nEVv7ZuNUpCGlnBdsknBbtFcUDFj+cI4CwgdkjgBMA8uqm10MBgQKi47sGzk0d84
	girzUc+ZlL5Lyh2fAlahdcD92HUasusDl5P4kdhjfB/luRzr5UqUFVq3zKwrUF8zqg==
X-Google-Smtp-Source: AGHT+IHmBH2QZpaEbfV3fXeoHi1UAa7OM11hVLL9hLZ+brhgRAkG7zZON3Nt9EdsPTSgrU6yQRuM2Q==
X-Received: by 2002:a05:6402:e83:b0:5dc:db58:a1c6 with SMTP id 4fb4d7f45d1cf-5dcebee8cbfmr52163a12.1.1738771608896;
        Wed, 05 Feb 2025 08:06:48 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc8838d5a1sm9284022a12.42.2025.02.05.08.06.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 08:06:48 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso1870403a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2025 08:06:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2E63gIdwJBMzxjwyFQiIXfp0ZnJ7ljVfBFfJOEyGabdr0rsrqxbz+q9vGvZ4CoPycWiazE5rpzVchy3tj@vger.kernel.org
X-Received: by 2002:a05:6402:27d3:b0:5dc:dd24:a7a8 with SMTP id
 4fb4d7f45d1cf-5dcebf087f4mr17433a12.7.1738771606125; Wed, 05 Feb 2025
 08:06:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205153302.GA2216@redhat.com> <20250205153329.GA2255@redhat.com>
In-Reply-To: <20250205153329.GA2255@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Feb 2025 08:06:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiqUibNm0W-KcCb3H+aiSVr4Uz3COZq=LjqGd__6guFEg@mail.gmail.com>
X-Gm-Features: AWEUYZl4pQ3MfEjALYySg2NdNqfiE2xSNb-ZlC7tv2BTOe4-AKTgE2QsLD76NI0
Message-ID: <CAHk-=wiqUibNm0W-KcCb3H+aiSVr4Uz3COZq=LjqGd__6guFEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pipe: introduce struct file_operations pipeanon_fops
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	David Howells <dhowells@redhat.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, Oliver Sang <oliver.sang@intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Feb 2025 at 07:34, Oleg Nesterov <oleg@redhat.com> wrote:
>
> So that fifos and anonymous pipes could have different f_op methods.
> Preparation to simplify the next patch.

Looks good, except:

> +++ b/fs/internal.h
>  extern const struct file_operations pipefifo_fops;
> +extern const struct file_operations pipeanon_fops;

I think this should just be 'static' to inside fs/pipe.c, no?

The only reason pipefifo_fops is in that header is because it's used
for named pipes outside the pipe code, in init_special_inode().

So I don't think pipeanon_fops should be exposed anywhere outside fs/pipe.c.

            Linus

