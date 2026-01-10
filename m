Return-Path: <linux-fsdevel+bounces-73125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E2ED0CFE7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 06:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 841093013BE7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 05:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F37A33890D;
	Sat, 10 Jan 2026 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h/+eanTw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217281DF736
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jan 2026 05:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768023243; cv=none; b=R71pDWqGL+uuOHkcOPT09YuocUrh1KeNr+wglPftnAVw1HRMJ2jU/084V3VfLxsC8yGq5x1+d9mVfK7hPgPmX9nypSAF/hSv0cdZ4yYx2YrVYJFdWW1R5ZobWhFxY7f6BQImSuq3LnVR23mLfOUXgWnokoAljD2LFwEV9dTicXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768023243; c=relaxed/simple;
	bh=6pwomIVnrR12zTpAtQFvRUZW4X7RJuoi5+P+H1COhLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uL2LJOnH69IiHVD2WoAHlc13EzH6FiRbHXIZEIQypIKXq6Ugy7t1FW8qOgCKRtVYwIeBVoGb3XTJzX4O8KT5UcsqPeLGzKyqU/nC0HRXP+ImQzcNZygXyPVt8AHxaidLtqPLlStnUXOzLofjhpC+Y3iuDPEwrzUUt9Ew+4w17Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h/+eanTw; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64b9230f564so7004193a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 21:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1768023240; x=1768628040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4wyW1DTuW/y7tVtllh5RzaabVaZZ0QjTpvnBZEV9Z4w=;
        b=h/+eanTwwEJZM9lrNsk3peydXnCtVIY+mm1cnMpg4cf0NZlbvX0iO3W9qrVaWo/g3K
         /COi1EbmBn5sC22nPZLfvcMVoU2EP7JfTslJ95/YjhBvGqdX1jM6y93wB9946+i/FNUS
         uHsyocPO8rRza50CImtKZVfiOFmWyKm3KHJw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768023240; x=1768628040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wyW1DTuW/y7tVtllh5RzaabVaZZ0QjTpvnBZEV9Z4w=;
        b=ij69MNx+llTLz9sSWiYoy6oSeFYfsV66GRFu3pgbEn9buj6LlbJA8KYH9PtBJVJNOu
         NGvTz+xUkvuzK0+Jef496fpAW5aHhNzGEAvAkSgWahehsLzjESWICFxDdmwM81CpUwf+
         +cuqgQEIomf8FCoa2ZjvGt+VJkeODvf+kdcDJ0oYtjHsPK5unYlUpcGXwZ99D52NPn5x
         Xxn1T6oSxxwENxeqq8+1ZN/LwghOPHwcRY9eRO4K3Ib+8SMvnIe1eAVGX5DmMjIKMS53
         jCuMejoxL5r+e4y2XqOMQX+/c1KTfB28r9fDO44gl7voGrAw1zh0Kgd0qunxQe0MZw4p
         Rmzw==
X-Forwarded-Encrypted: i=1; AJvYcCWS+p+k/+of7GKvP9mI81unuqQScTDvlfTaNx43aXlolT75JuZDaHSneaAHF/1IRd83qkJPG5npf0yCQDLo@vger.kernel.org
X-Gm-Message-State: AOJu0YzinTRrdFx3hUK6sYcYbP+b2ATzL+Klraws9pGVTJAD/hcUcCOr
	6OyE+o9h3xy/m24sZUUab5lEaOZdLAZMqNxtpxWYz437eLWuotOQbn1+6HtJnq4WwuG7swT+J1S
	x1qLdeuo=
X-Gm-Gg: AY/fxX5L6/Vq1wyRZaGN+xnjZMFBgJzRI6Z7CRQHIDaFMTjoJxeeo0/CmqyWTxBzcGz
	rLncHR6tp5QvbTwa7G4OgTBfDabmu75IZQjwgSTR1b3/117gSPiPQ8qVvGPF7zwdSNkpMerkwR9
	YmGNJL6PpHoeR5co0PRRIZ5auPFSTz59BGBUDqgO0ZWbi2HGIbqM/6UBzAfLplV1IQ8xB0K63JT
	T3LstlaAw3pAxymNq5VXI30P+bwjWT8X3cUlhitnOFqlIYyje6JiX4fE22rH7DMeKOTiEo1KlHU
	pPGk2vKkMSCKRF6nPq6oIs1mjQrO0Vm1SMYfAO06Gf5z9l0rVH8v5ZFPUP8zpcak2QSlsqza8X6
	dxOtuInDDqWRYV0Da1VjrUgI0LH8GlCltegNCyPr3MaMi6+FB5SPy8wYCBQ6QJsuNLSLZvQZHKz
	LaB6oKQFaOpTpN8ksY2VgqR8VUrQOPGYr4H+XgM0BM27T06RVX5UG7YcFIDA7h
X-Google-Smtp-Source: AGHT+IFStmgtfBvT59PvItTGhdURiCmjN51pUPo1VFIXcC/IsNRcJsYOmZLuywUTZ+fYNjXQvpIsWw==
X-Received: by 2002:a05:6402:35c3:b0:643:e2d:1d6c with SMTP id 4fb4d7f45d1cf-65097dd1042mr10089026a12.4.1768023240361;
        Fri, 09 Jan 2026 21:34:00 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507be64efasm11513573a12.21.2026.01.09.21.33.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 21:33:59 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b7a38f07eso7593611a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 21:33:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4TZYgiIQPtl9b0DsktWtoTU8Gpz3yab9DIRmCZWX9E+lIoB/8CWxDfv0CVrbLCg8AEQw6fw8ZMJ/TwIvz@vger.kernel.org
X-Received: by 2002:a17:907:3e20:b0:b7a:1bde:1224 with SMTP id
 a640c23a62f3a-b84451adc45mr1025593866b.65.1768023237683; Fri, 09 Jan 2026
 21:33:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Jan 2026 19:33:41 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiibHkNcsvsVpQLCMNJOh-dxEXNqXUxfQ63CTqX5w04Pg@mail.gmail.com>
X-Gm-Features: AZwV_Qj8IjwLAZBCGylKcDX863bYH6zw4Q89VsNZ53a8fR2SwhwzXKAkrSSBlRw
Message-ID: <CAHk-=wiibHkNcsvsVpQLCMNJOh-dxEXNqXUxfQ63CTqX5w04Pg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/15] kmem_cache instances with static storage duration
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Mateusz Guzik <mguzik@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Jan 2026 at 18:01, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         There's an alternative approach applicable at least to the caches
> that are never destroyed, which covers a lot of them.  No matter what,
> runtime_const for pointers is not going to be faster than plain &,
> so if we had struct kmem_cache instances with static storage duration, we
> would be at least no worse off than we are with runtime_const variants.

I like it. Much better than runtime_const for these things.

That said, I don't love the commit messages. "turn xyzzy
static-duration" reads very oddly to me, and because I saw the emails
out of order originally it just made me go "whaa?"

So can we please explain this some more obvious way. Maybe just "Make
xyz be statically allocated". Yes, I'm nitpicking, but I feel like
explaining core patches is worth the effort.

And maybe that's for the sad reason that I read more explanations than
code these days '/

                Linus

