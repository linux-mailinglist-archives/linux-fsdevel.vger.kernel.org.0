Return-Path: <linux-fsdevel+bounces-41335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9082A2E019
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 20:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16833A5A7E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 19:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442ED1DFE3A;
	Sun,  9 Feb 2025 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8npWeFw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A471119A;
	Sun,  9 Feb 2025 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739127736; cv=none; b=QaOpRZXI3rXJxhxtVvBnmb4vppgjyKtKHZQmHKIIBqNQ/eebT8LLF2FAApto+XzF4TcOBfy9Yf5sLYHrQ9uUULHswExWuIDOmXAUqfr2VexDcoam8691e1CeU5h9biEi5F8bEE1eJqpg/W1uZghab953f9hTkjA8fVieIsdjD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739127736; c=relaxed/simple;
	bh=TW+4+E+7+XZP/g+s7R6oa8NpnYXtrdMq9PE27UIWXjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gfc6q9dlB6UpXqtet+shpw2pJilJiEVnhpwt22YdOLxdUbTcDygZU6F49DVW/X9B7k+9vHDhdR5bVG0jcBthghfn3CQ27waPKIhZDacJMq3gapVsTa5UuXSQzMP5Qj2Dv31CSMeGu0w7xsGcc4hddyFDPvq43GsjDhTX/hydfsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8npWeFw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso5648115e9.0;
        Sun, 09 Feb 2025 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739127733; x=1739732533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XP+FJqFsJoVUSV9/Q4BgbMERBLwXpp95kX3C9awegos=;
        b=P8npWeFwyKELq7vD5dpNs993362vXeJa5zKozBUYFHZEO+8vjCIWNjcYBiINjBO8vm
         zK360+dYTHf+uErocR8sFDJBgje2dZbgTdG/jdQIu9JS/WVXaEemLRqUN2Gc5SAMYheu
         Kw90pHGvNnaHfiEiweW+Vof/IFwUaXda8/8myphSlLLJK6wVzEw4KHe/6LD9NWBBGIaS
         L5NLOPKvrWK78X1q0BYG/E2hDzj4NybjfMhF1uflpKgFZn2BAGQb0S9CBplTrU54D7Hs
         ICDJDjtX7XiVWbbA364Yh29/wbujbWPatbHcNt/B7GGdmjyGkR7wEUw7iYEoTHTzFie+
         634Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739127733; x=1739732533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XP+FJqFsJoVUSV9/Q4BgbMERBLwXpp95kX3C9awegos=;
        b=UfZR2kR1PngVMs2c8vJbmaTka8xGNMOc0F8Uppb+la4Wo7MdPhNLmIOuS/Z/wRqmbD
         +UDGEPZJv8CCxdpsAp2253/iaR8wXo67gj5mBmkwZKN5yM4IC3vFhk9j3+DdICfRnnSw
         HXdKdu39V+7o0CeV5grpm8uu5H9FMeF5OFQM2JVe/Cwsp38fFaPT+GR3aubvzi2UnaAE
         w8ez5Jfg8JyOLUnf+gBLWK6uXBFDc8ObGrVoDX0KAM5A9VCZoblbz7UUCRAY2wcakOmg
         ZoPuQDljS/AfmN8on2A9Yzs1cO56TbPaNnb1+jy6Rowh5CtYpSrEZYfV0DoP97d1WBan
         8hMw==
X-Forwarded-Encrypted: i=1; AJvYcCVaR8Devr26Px2k3iy49Bwq64g0T6GGK6tSyd3jnCHIwRO2P6YdcOc6JIdY0/zUnA2u0r9DkRKn8WLyuKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF7njhG7Wm+F4N4OPSPogIb1niuvwiWjANMuFjlYg806ChDFJN
	sevTpIKER4QLg+Gy0pa6SN7bHtZWoQ+MWFqrsRZRC7F3zEBQQK8s7wrTmg==
X-Gm-Gg: ASbGncsENsfhPLJvI1Kw3yy4JVjfdVh4f6EKI4NR+zwoTdnYvQFlnwfTf5V+qt6tqBw
	9zgkvwxcukogne7gFTJWWljAWqu1cdDUMFaLv1Hen0YMCz9yUFlaD48Qqv7xABmHaXStsDX0nos
	6XoCwzvvHqInafnRw7IkCcq0l2bJW0l+ELh2rgY+tHaDU88ncAisFeH0hEa7GhTs432G1VXH1ua
	a/8iZeD8S54LZHlhHR7m92EJD8rSXrzUeRFJsLDKsDM8PCMkA7LiIruTcO/teBQNaYRhBf2bClk
	oG82OzXsxWZ4rSHr9JggJ2wAia/2FvbUvAYTIX6ts3Kl2NHtsmtMUw==
X-Google-Smtp-Source: AGHT+IFXfne07FMOmsZHlzDGsNHD50KSPwTdX3y2XpB44iLobk3mfvWg1U9XQDm4wLgCh1q8VL9w7A==
X-Received: by 2002:a05:600c:4f8f:b0:434:fe3c:c662 with SMTP id 5b1f17b1804b1-439255b817cmr67733615e9.12.1739127733205;
        Sun, 09 Feb 2025 11:02:13 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43943cd4442sm10137305e9.24.2025.02.09.11.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 11:02:12 -0800 (PST)
Date: Sun, 9 Feb 2025 19:02:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Kees Cook
 <kees@kernel.org>
Subject: Re: [PATCH 1/2] uaccess: Simplify code pattern for masked user
 copies
Message-ID: <20250209190211.5a11d6d6@pumpkin>
In-Reply-To: <CAHk-=wjv5x4ee-nKLfwoYwgJ9OqBkd+wqGn-dgWpHdpA2oZqqw@mail.gmail.com>
References: <20250209105600.3388-1-david.laight.linux@gmail.com>
	<20250209105600.3388-2-david.laight.linux@gmail.com>
	<CAHk-=wgu0B+9ZSmXaL6EyYQyDsWRGZv48jRGKJMphpO4bNiu_A@mail.gmail.com>
	<20250209183437.340dcee6@pumpkin>
	<CAHk-=wgkEDmf7V+F5jP6On3=pEewRYGbZyvs1E3K-3n3HYr4=Q@mail.gmail.com>
	<CAHk-=wjv5x4ee-nKLfwoYwgJ9OqBkd+wqGn-dgWpHdpA2oZqqw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Feb 2025 10:46:03 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 9 Feb 2025 at 10:40, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > It's *really* easy to miss the "oh, that changes X" when the only
> > little tiny sign of it is that "&" character inside the argument list,
> > and then the *normal* mental model is that arguments are arguments
> > *to* the function, not returns *from* the function.  
> 
> While I'm ranting, this is just another case of "C++ really got this
> very very wrong".
> 
> C++ made pass-by-reference really easy, and removed the need for even
> that tiny marker in the caller.
> 
> So then you really can't even visually see that "oh, that call changes
> its argument", and have to just know.

Or make a habit of appending '+ 0' to every argument :-)

> 
>               Linus


