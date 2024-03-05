Return-Path: <linux-fsdevel+bounces-13650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF01887269A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 19:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E31A1F29393
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 18:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E3C23758;
	Tue,  5 Mar 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a7nk0ZbF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2BC1B957
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663628; cv=none; b=pE9NqnDdAJ9/jGJsEToJat1C15fHalSqRxEa5M0Vs3az43PufuTU+vp34/ljhvzSCmGziedk3skNi97/cjW/uGzP4BjHvgINvVk3FU31RPNLy7dc0R3ycQJK0/sYr49O3KYxc8/gZ7GvOem7BPLdA/gQe09j7mo/qjoSF5uJqGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663628; c=relaxed/simple;
	bh=owF45A5U8RazsW2KrYptuABA1Q6yhy0RwNPs4QQaAno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAb0ocT4KPHg4vvmmZyMQYNNPzLDUW8+8IDqoPWRc1GKMUlp2n+1JC2bjb74JlZWmZt0bP4Jty6oShlA9PN5p0JChi6xkqu7fEOzsWY+wdfWf+5LY/WkSTsIjhL1QoUokfugck3skz/vpyUYbs6zEb3YbWjBXINhxcZiocBRR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a7nk0ZbF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc5d0162bcso52012155ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 10:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709663626; x=1710268426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZoQI1fT8QfmmvEDY9ZYWRkDR8aVhX37TS8JWY66OSk=;
        b=a7nk0ZbFLpOKCFbMBKU0gUAQUc7qq9urOdSEiVF65f8wWNcGnMeIsSpN9MREdmM0n2
         /Z3N2EV6LDzSJPpi2G9bzoCzy4Lh52cfNOBF9OWxAwrtm6GPMPnCNp0jJQegnc/Gf+Ob
         Aq9ed+/5oXavnOlTe8xg0YGd163lqwSdmFxVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709663626; x=1710268426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZoQI1fT8QfmmvEDY9ZYWRkDR8aVhX37TS8JWY66OSk=;
        b=wIVyE260yWR4DzHFt+k7FwXmbdvajPVs9wVGWpgj1Rw6HkR/xSu87Smt6r7uuxyWiy
         CPRKNdrV1XqCbCVYIPFT2fggyvyToaDR8S9IAIr/VOETzfe41ATaj+ZsLco1xAYKwDdt
         a11sWv8G+k3Yh0INNT2l2ckRqP/YwuCALWUcs32CaBU8x/I1uaghN34lSlSn9d0wnlo7
         V+qaGnATaVGJektXqfAMvJBtF3IkbQQG9vKjow8yeXiXxKjheL4MNclk1oVNRURe1/Dt
         hhKKMiJ/mJwTrt9YEuYROIxnf/L3jHtOV/CHKXftONYRZzFCKG9VYmTPaEQV2Q/xYppc
         svTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgi6xomqHAUK3sz8+uGSOlV1oJI9XAlg9SLe98viTouh9Jp+JdgIk0XlUTqCJu3IABCDLH0ZR/fcPsxRbePYPcLXdxISKxK0rGfGsNcg==
X-Gm-Message-State: AOJu0Yz8U4iGrUEtIG1QV1oozWYmNSYAllAB3yTqJZCGCOMIAPqh7Nal
	JjWjNgTBHlS2Nbw1tioTuDfojZYRrI0D3pLRE7Iik1H1MtYkZUcbCa/Ofbeo01bz8rlrkqgmUH0
	=
X-Google-Smtp-Source: AGHT+IFWgP1XMzzTAo9S4FmzwND5LVJWMFuSfybGA+o5U5mxtPKyFuUMpJm5Tbtd0lqsISkQUgsviA==
X-Received: by 2002:a17:902:a98c:b0:1db:cb13:10f1 with SMTP id bh12-20020a170902a98c00b001dbcb1310f1mr2522864plb.19.1709663626654;
        Tue, 05 Mar 2024 10:33:46 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b001dc95205b56sm10890809pla.53.2024.03.05.10.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:33:46 -0800 (PST)
Date: Tue, 5 Mar 2024 10:33:45 -0800
From: Kees Cook <keescook@chromium.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Denton <mpdenton@chromium.org>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	linux-fsdevel@vger.kernel.org, kernel@collabora.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v2] proc: allow restricting /proc/pid/mem writes
Message-ID: <202403051032.783210E95@keescook>
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <20240304-zugute-abtragen-d499556390b3@brauner>
 <202403040943.9545EBE5@keescook>
 <20240305-attentat-robust-b0da8137b7df@brauner>
 <202403050134.784D787337@keescook>
 <20240305-kontakt-ticken-77fc8f02be1d@brauner>
 <20240305-gremien-faucht-29973b61fb57@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-gremien-faucht-29973b61fb57@brauner>

On Tue, Mar 05, 2024 at 12:03:21PM +0100, Christian Brauner wrote:
> What btw, is the Linux sandbox on Chromium doing? Did they finally move
> away from SECCOMP_RET_TRAP to SECCOMP_RET_USER_NOTIF? I see:
> 
> https://issues.chromium.org/issues/40145101
> 
> What ever became of this?

I'm not entirely sure. I don't think it's been a priority lately
(obviously).

-- 
Kees Cook

