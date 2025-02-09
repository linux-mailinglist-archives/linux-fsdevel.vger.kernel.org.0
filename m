Return-Path: <linux-fsdevel+bounces-41341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00638A2E0CD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 22:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA03163DDB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 21:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC02236432;
	Sun,  9 Feb 2025 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcY7fDX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6678D49659;
	Sun,  9 Feb 2025 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739135892; cv=none; b=ts126i7pJMYfoUojvcfU9Bt9d5efnErBCa6Rk9u8MCCdWNyKFxQfv2Z3BmUCSoUhIzbXSE0TZM3nsg64wpUubSm0t+IiGJut2X5IK2ul9YcwAHcy4sE/zYotUMHHa+QINyX/hwVcChYnUoMmMMc//CbDuQ3I2V9WzWkbNYmZRkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739135892; c=relaxed/simple;
	bh=bNKBfWNRKebQScua+Jos/7YyeDSQyrV7+cSkWBGdgwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWIFDfVg5gGO3QTO5PJKCz0RXgbxg0vMq/EjkLCdDlaNnK8qrTYTuTT8WEH/yORts6rLYzWP/t7DfVsTnPkivagrPYDH60shg4JakDKS8mtkw/51HFZ/OhlYAic006NixCFcE8A79V+9D2QSrIQriPlZcxyENzXEoJD5HwwSNLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcY7fDX7; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38dc660b56cso2654233f8f.0;
        Sun, 09 Feb 2025 13:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739135888; x=1739740688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saaUSOCD8VtQU0yd34D1cSRrbq4D1M8lc/5MSCCFPes=;
        b=KcY7fDX71RjN3fQNZog/FmHvYuKt8Rqz8xMYueMbuw83uJg53nYiw54v18BtiTSbAC
         x31gdTCJpCoXUs6f8xCelFJusuiPzWymGnexV4VNwm5SWht+C6yxRmQu5HX9e7Glhc7l
         eMwyKvnYEovAaznTZdCAvgbBptfyr+P0c1WdmfhB2zZxe7eZKsu6urjVhDkiKErZB9Ci
         Q0SIOzM5e1oTwMkJeJiJ9kPYO2g3GqPQkb57ZWblFHGId6k4BKqdB/x7ZVd+c6oLrp8Y
         NNZCHQ4LXd4vT5F0fU2KT3zQm56MD/co1dNMcfX5lj/rKz3Q8G2FNXYouRhIIn5LSRcP
         fHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739135888; x=1739740688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saaUSOCD8VtQU0yd34D1cSRrbq4D1M8lc/5MSCCFPes=;
        b=RV5CrRHlyY/JA1FFhv2BrxPZDw76Boeqr5P0+XTEeDAHYpTeGz8iqZpDlrBgMX3Dzo
         hc0J1xlLo1wAg/nNQ8/6qvZOl276OrSQ7jpNAOB66gIW4Ew+7+Qiw3N9XiFh/eTUHX8J
         TuS0EJS+TdGZWTkVzBF0BDPNkZ7ldqgjiwUqVX1jm3ON4txUU7za3GZa63b6UJqWx2Da
         r+YkcRfiR+qocntkt17WxyCOcBJiJcJh7HmwW1SMADIpdq5T0hYRZ6x7r4+i2n0L3KAB
         EkHJlACPaR/obKqvH1SysoYmb3NPJ+GEsakc9mlvVZ8Jd6rmmw5Oa62HNUuJ5obQgTJA
         6KDg==
X-Forwarded-Encrypted: i=1; AJvYcCUZabC6xZXm9DHnjXCyquXx5l5BGSBOqAWNPIb6hxHxfQDo+va/rYLbORjkSekCjxzgMGcM5ojpr6jIVlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw8S4whRk60QDOkQiCo89Wd4B+Qyyg48Gnlna3J7sLjR9tXW8G
	GCK8z3fwIEak2Km05WK/0NfAxTwhhaBYEPOLt9W2oreEV8Sm3RStUitS0w==
X-Gm-Gg: ASbGncvrXtWR1fSZBwbONrjUscaU1iUC5Hh83E9MxT+Dh2m8RTAR7YdGyKX6tYvGC1q
	n4YBwcpCw6PRbPFuo4/+Ft5iQTzY5XBHQCndfNskxOV0mQk6SjCCe0yCY6cyF3sIfeTf4YDoPCQ
	Q6oWySd9A3Ysj0lzvfO/uzF8k9KmS47onO987ZkoFQAgR/GPfiq7Wnz0EPyZarLXTlGvOd+Vhal
	mAYgYE3Yk1/ID7P9mCsKXbJVwBTuD0lthvNllLaQSPQZZ94xrP/ba4xDhmGMfoAoDooBy7JLuRl
	exJhJaov+gpzkMKfzfy4DCnaupQVTPYd1lePAWIU/Og8if5l9xP4HQ==
X-Google-Smtp-Source: AGHT+IFueWBoevUvxZNF+yIvoEj1Zp72nS6QGi9WB0jNAxF2Fm+OCUS3HsJE7nBo4Bp4i/L1TAZzrQ==
X-Received: by 2002:a05:6000:1448:b0:38b:ec34:2d62 with SMTP id ffacd0b85a97d-38dc8dddd1fmr8853062f8f.24.1739135888359;
        Sun, 09 Feb 2025 13:18:08 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc6b89ef5sm8692402f8f.31.2025.02.09.13.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 13:18:07 -0800 (PST)
Date: Sun, 9 Feb 2025 21:18:05 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Kees Cook
 <kees@kernel.org>
Subject: Re: [PATCH 1/2] uaccess: Simplify code pattern for masked user
 copies
Message-ID: <20250209211805.5fc2e9e4@pumpkin>
In-Reply-To: <CAHk-=wisZo7+-xmC_o8GQJ-G0qFp4u29t_FkjgPvgq7FXaTyDg@mail.gmail.com>
References: <20250209105600.3388-1-david.laight.linux@gmail.com>
	<20250209105600.3388-2-david.laight.linux@gmail.com>
	<CAHk-=wgu0B+9ZSmXaL6EyYQyDsWRGZv48jRGKJMphpO4bNiu_A@mail.gmail.com>
	<20250209194756.4cd45e12@pumpkin>
	<CAHk-=wisZo7+-xmC_o8GQJ-G0qFp4u29t_FkjgPvgq7FXaTyDg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Feb 2025 12:40:32 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 9 Feb 2025 at 11:48, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > You almost need it to be 'void masked_user_access_begin(&uaddr)'.  
> 
> Maybe we just need to make it a two-stage thing, with
> 
>         if (!user_access_ok(uaddr, size))
>                 return -EFAULT;
>         user_read_access_begin(&uaddr);
>         unsafe_get_user(val1, &uaddr->one, Efault);
>         unsafe_get_user(val2, &uaddr->two, Efault);
>         user_read_access_end();
>         ... all done ..
> 
> Efault:
>         user_read_access_end();
>         return -EFAULT;
> 
> and that would actually simplify some things: right now we have
> separate versions of the user address checking (for
> read/write/either): user_read_access_begin() and friends.
> 
> We still need those three versions, but now we'd only need them for
> the simpler non-conditional case that doesn't have to bother about the
> size.

Except for the ppc? case which needs the size to open a bounded window.
(I'm not sure how that handler r/w access.)
So you either have to pass the size twice or come back to:
	if (!user_read_access_begin(&uaddr, size))
		return -EFAULT;
	unsafe_get_user(...);

   David

