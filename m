Return-Path: <linux-fsdevel+bounces-36410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A2A9E3869
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7900161BA0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 11:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0871B414D;
	Wed,  4 Dec 2024 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kss6DhRP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0CF1B4146
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310430; cv=none; b=cVzUYqoh3/+j1tgU18su/QeCN76/q0H8/WFu+lVt4CtM68DjLrDnphWJUoq5YxrHNgXWDoYKIYyiCVxHkLx2RAChyVSMQgHNFcfFKXKHCYDigAk/udwC/L/2PiuW7SyE/+9UagmbA8dWM/CBjo7p8UkmSVS8NZ2WW8UVLFC0AjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310430; c=relaxed/simple;
	bh=S1vVYD2en2uAs2YumjFEXqaFVF2rKcfEB2qNU4o3of4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IULBU3QVtbX2PjFN2WD99I9FOHk+LyGzR/E++7ZNLuFrDZSRzVmFIGgmOWu5820RH6IQzx51ehFFTdv0jM6RXeGwLmFWcevxUxDE8g4agUJK4ioZ7k2yLTYHY8fP1q6fFxxjan7FgLzWrhq7FOJJGgxdmKiAHXbelIS/LNcg6Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kss6DhRP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso10411609a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 03:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733310427; x=1733915227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Kk2uvahuxMpLkAzs/fs8pEsAzTgLXJwdV7dFEs5gtg=;
        b=Kss6DhRPNNMyYsW8fqFzVpjF5vm27Osa6jbddwVRZLKCB2RNTVv0oJ2yXGlVcoagj8
         BoC/Mk1WsunEm6StiK2+M3HknXpH6TpGMi+yf5L74Agax6XZPn+GJ+fwmVgsQQvWJ5Sw
         jo6k7Xw/CCgKQyHYPOwcwyhjlJUfis5B8POJQujtGLNG0x0/kOEDYmvI0wX2I7nixMzy
         XTmAT0wjjIheiga/IGF9aZn9YeP33i/MBhe/1kSXmXOt0a85v67/4C5j3As5slKOcAeZ
         vPI1i1aJTNyXG+bp30X+MkJmbFGGVlAEYOsk2A+3lgucMCPzje21i7Hl8mCPaE9st5Nv
         s4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310427; x=1733915227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Kk2uvahuxMpLkAzs/fs8pEsAzTgLXJwdV7dFEs5gtg=;
        b=StwVBzHurt0+sO/ihjYX97CV/zFz8Egj1S5LeZEN/CzLPJL0/B4IM1zrorINkSyCnZ
         x/exiIfgae1McUNTbckntRDup+7vZ5fIpQ6hzbmKbdDBZNTA9fQSjz+rmgzecZi+Yphy
         OHzsbKdOJjCspIk0L2j5JV//n61iK6UjrdKMmZy447B0E+cIzk4hqSAhwVFAwT7YPKzL
         O3sUmlSplLkPn6j50dLkgv8RP/+/fqwiUpLKrjkHhpRz39W82uUEiRDG0jK6Otv/SbqJ
         IdU8nZHO1pkHopurjZ0KZPEaWMGoZUh8VlgHom9RHqC4fnYGAnnTccHFUUqqU4HCuA0W
         vDCA==
X-Forwarded-Encrypted: i=1; AJvYcCWi4BAk8rT7vxh7S5HkfjAPeMf5u1K8qY3OM2HTC87E9FMs1kaA71GeqJcxf+60bSYO3D4RHDsQBYl2M+9B@vger.kernel.org
X-Gm-Message-State: AOJu0YzCe8QxINCfIB6szxhyYxxjAHACJOUxkyjYCXuCzqrntTZxjlnh
	whKT+EPKhMr9D6EaGEH22OpO7jsyoxExhEoeg9VYY9IFu/jyw/mE
X-Gm-Gg: ASbGnctIyfO7mXq3jUVooozzZ5NzemSgSW06loxV78QhQYUlmR0Y4sY4yscSmrnhz84
	aSBMynA0GDeZpiJKbLf02Yd4C3j+luss4h72QLgB2Jndrq7cJU5zrTQgNCQaBTo/bakzJ5N4+uA
	W2ULRQKsdNYH+Sx49zR1pvXbr1hwDD0lMa2SCucZZqijoGONRLIKQkNuhNB5YTthIyoW1AubW8/
	CZzYeABeHbfFltz32a1lAG5r0/q4qHQuvpcqlJ7kKacsu45F5z85Ba1djMZnQs=
X-Google-Smtp-Source: AGHT+IGH0RqtlQN3Cle6hj47w3f80Q2CL+asIskixVWGbLLxpDDT1W5ADhfJSaQoxx6ohwzkCfHdSw==
X-Received: by 2002:a17:906:9d1:b0:aa6:3c0:7595 with SMTP id a640c23a62f3a-aa603c0881amr373384066b.17.1733310426832;
        Wed, 04 Dec 2024 03:07:06 -0800 (PST)
Received: from f (cst-prg-17-59.cust.vodafone.cz. [46.135.17.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5999575a1sm719065666b.193.2024.12.04.03.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:07:06 -0800 (PST)
Date: Wed, 4 Dec 2024 12:06:54 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: don't block write during exec on pre-content watched
 files
Message-ID: <locrapgjuqnmkhhduydix2geekh5qe7eq2roiv5hmancbl2y53@zz75zx5w53cs>
References: <20241128142532.465176-1-amir73il@gmail.com>
 <20241203172440.hjmwhfg6b3uiuxaz@quack3>
 <20241204-felswand-filmverleih-b5a694ca46a4@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204-felswand-filmverleih-b5a694ca46a4@brauner>

On Wed, Dec 04, 2024 at 11:56:39AM +0100, Christian Brauner wrote:
> Only one question: The FMODE_FSNOTIFY_HSM(exe_file->f_mode) cannot
> change once it's set, right?
> 
> The reason I'm asking is that we don't want to end up in a scenario
> where we didn't block writecount in exe_file_deny_write_access() but
> then unblock someone else's writecount in exe_file_allow_write_access().
> 

What's what I brought up, turns out its fine and the code will get a
comment to that extent.

see https://lore.kernel.org/linux-fsdevel/CAGudoHGzfjpukQ1QbuH=0Fot2vAWyrez-aVdO5Fum+330v-hmA@mail.gmail.com/

