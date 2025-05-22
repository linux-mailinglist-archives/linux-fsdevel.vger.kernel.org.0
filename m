Return-Path: <linux-fsdevel+bounces-49691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2D7AC13B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 20:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468C23AB123
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 18:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761B71DF728;
	Thu, 22 May 2025 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StS0NVZc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5831DE8B3;
	Thu, 22 May 2025 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940000; cv=none; b=jhJVhxAU9hPAicCw9EVHYQmTT7/NDCDr6/8ud+R8/MfJaiiW8iXUZFbg6wDRvRvZCqKo3/7R2NzoF3ebRNzVZHLBxKUYYvSo92c07lipGLMhn4IL3UquwDmMr5MB34VOonfIeGT+ReGhuEp8xhO8tM0b14pjXPFDHM2FcV3VOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940000; c=relaxed/simple;
	bh=KJbnwLO9PnKS+o/OspihaxX0IQGxbr3s73qXik1soWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkSPgIdOL+SGF7As6xRmSmLPzcJJA60CND5KSzH8sXGplerw2CqnoxSie3PYg7fTcZ9qW2MIfyC1dMBnzRiklvz244U9pl+xGL+DfNSVYz9AR0KhMkaAhE4l9XKw7fuXheTQRQCT0bf72cCpph+gdfdecTd63ZO5FZFzgazULns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StS0NVZc; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso7183536b3a.2;
        Thu, 22 May 2025 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747939997; x=1748544797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBANE17upGJtSfo2ziwlQRYaEyGo/7aP/0TWDN69oCo=;
        b=StS0NVZcoeRM6d84IDFgACUGwgZYMH8jwI7DM352jnDvLLFNbV9Xr0/9G1CZ3QpRGt
         ixBSuET1mZklQGVsxVHXkW8eRmdOxsNOG/MciYmALkKwb66cQAbvER9jt82Q3fRzj0po
         /GIK5lBQ5ErU8bRXT2cOhiE040kRHp2+Fb2qMKtMsSFEpBTmFAt4AS3pxQbzNEcP6mNo
         XMOZvqLGn4c/n+TwXkwDOtYr14T4OsUUXt/4pmVk34qJxfH1wiZmDEYaYLBt8AIq1UFA
         RmT2uh1ixo8+JUtrXv8zNfxDIBGRFEXjJAODeD3hqIL1IiGhWe3tfLPSR0KzvsAf6FHd
         ItMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747939997; x=1748544797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBANE17upGJtSfo2ziwlQRYaEyGo/7aP/0TWDN69oCo=;
        b=QO/jQdTPjyoJESeG2FKIvrDYoT/FD9DSYm9x0LU959HXIetUdE0TMk/77hwX/kVIbR
         i6bWMS95VyIjkXEoQ40+mriYpVvIUMYVt7KDwPPI3u7Zy1PB4HDkRCFXJNetZR7dcjVn
         6/0F1NAvs/UAibwpe7NmFyke7rmY3xDlx550zUtgc3xPCVXjBXPgKqMqnryAsRaO7r1T
         paGHZy3+Vym28dWGUBVkKTSKoI0HPGcAlNAt8/1JxNEriWTHPNDfsFxr6j12TGtRbHYs
         C2fQfwZyzHVfzQHoX/ElORr32e8Hy/B4HUoo59Ju2bFY8jWcKhx8+6drUVRe/Oaz71HN
         Y+TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLkQpzDudcYPBZvR/HX7KoaPi6KWmVlgKef8xIa4PVv59V/J8cnQagJPlh5RlmLgY0Of21JsmnINbv95KQ@vger.kernel.org, AJvYcCX5rRaznROk5kLpt3dwT1lTRWIuoFJ6sxyWJDX6jzDM5wdWGeDlT01A46vkNP2LRfTge4fNfSwKq/7wlBgv@vger.kernel.org
X-Gm-Message-State: AOJu0YxSofdaK1cfA23vh889iEkjC6FroS/oJWTfZTd/6bKWUBrVWSUB
	/UmOhahNH+5iF+pBx6R/VNqdXT5p6es2sv31BpMAyrSYuTh9SinVvaxz
X-Gm-Gg: ASbGncto2h3gBg2Woa0P0uBgM2dv8WI70yEOuI656tQNvpdjEjhej9sC48ZlkrxMrFo
	lPDCrzdpX/2OSizJkwvP7MUEf4MfY1FkUISQtVf8Ot6L4hsFbV00+8jWiQn1dNCDcJu8sBhX5c1
	3PGaaHnzRNDKIiXS0xx5vgodBOAA15mgDY4ksPCi+ttG5Cz6AlFzo1/y74FOxr7UvsCSxdER1NA
	zUv06o9fkaV1jbv4OyzQxuCSylBrR1w/zeSFx/AZqWWKOh9l71Pwa4RVBzU3K+T4kjEqBoUaVEb
	7UGzI21OffK8AcoxJlj+vJMlr6bKLrjGbuF3UeGNvX4ubTBwO4iPfZFt1mURVETS
X-Google-Smtp-Source: AGHT+IH4FHr6TKK37LSw/N7pyVC03rjqy4ufLuDp4wUmG7w6e/+v49oWOzOCGRwFlYTZKsMryyJI9w==
X-Received: by 2002:a05:6a00:3985:b0:742:a334:466a with SMTP id d2e1a72fcca58-742a97eb677mr36355117b3a.12.1747939997420;
        Thu, 22 May 2025 11:53:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6e609sm11622477a12.19.2025.05.22.11.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 11:53:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 22 May 2025 11:53:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kees Cook <kees@kernel.org>
Cc: Joel Granados <joel.granados@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH] kernel/sysctl-test: Unregister sysctl table after test
 completion
Message-ID: <ce50a353-e501-4a22-9742-188edfa2a7b2@roeck-us.net>
References: <20250522013211.3341273-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522013211.3341273-1-linux@roeck-us.net>

On Wed, May 21, 2025 at 06:32:11PM -0700, Guenter Roeck wrote:
> One of the sysctl tests registers a valid sysctl table. This operation
> is expected to succeed. However, it does not unregister the table after
> executing the test. If the code is built as module and the module is
> unloaded after the test, the next operation trying to access the table
> (such as 'sysctl -a') will trigger a crash.
> 
> Unregister the registered table after test completiion to solve the
> problem.
> 

Never mind, I just learned that a very similar patch has been submitted
last December or so but was rejected, and that the acceptable (?) fix seems
to be stalled.

Sorry for the noise.

Guenter

