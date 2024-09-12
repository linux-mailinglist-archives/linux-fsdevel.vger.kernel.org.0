Return-Path: <linux-fsdevel+bounces-29227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E4897744E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 00:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66471286590
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 22:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE68A1C32F6;
	Thu, 12 Sep 2024 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BkFjIvr+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2461C243E
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 22:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726179974; cv=none; b=KtKU+JPwzi1R5HuoXx963OWrXgX2E+vFGB6ggvC+2YPAi8kBfwzQrpxbGhvjxvgpN1lYM8SgiHkUssqnMOTVcVRDfKUCWSsv2kFovXL9+W7Us6osED3fqEEqwisqNpbs98C7VFiGIl3x+pTTukp3lfeJN9HY7c5EYKcJ55Xbkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726179974; c=relaxed/simple;
	bh=KbS83rDiWhetHVtFkjA/wbafpTGhtpNgKVkrYNxEn7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ec3LSO/+trejr9U/ITCHYJeJPpsVOdXTIIvT4L55NkATfsIoPkkYz4fsLsOzEqOdlxMKaqY5Hg6SFuzuqCrPAj5aWDE1uVOpOeMwbMQnFi31u41Se5kzGPpD0cf6u9mK4Ta1ApjAk/ObzbLoTXckx36PbQqSKiLXSgByWEsnlAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BkFjIvr+; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f74e613a10so5588201fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 15:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726179970; x=1726784770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QeNLQ4zvks3207JaJjctekem2eb/h7As09d+6h+vRY8=;
        b=BkFjIvr+HHXZ3sZsoXhx4wZ3LxYh8nADt/LX3wubYVn+C0ddM4RC+QTpnlVKEU4fRI
         opIuQqOuvAt40eNNRrnowahVJeHuZYnw+QfnlpsNLBcm3qJzulG/Ug93B9gHJKPquD/g
         YlX1cwJXhYMF2AKn+LQq6HE11WbiV3Eg+90aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726179970; x=1726784770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeNLQ4zvks3207JaJjctekem2eb/h7As09d+6h+vRY8=;
        b=S7lc3punYKQUK1IYaXSHzbnr4EKArAlhq8qvYYmZQsjguky1yaUQV1S9PBKgUdY/jW
         8z4CBuhXEUO0IWTdcHMoUx8KFMOMpaeaVPsHfzmgM65QrBFge2b/u0+Ua5aUd5IrDV20
         x6Hm2D9W64oWxQS9uxM+/F70L+28wqwmK7fPIO0Qw9LoVmqnBplQhjysqoirFfgnWbgM
         GqElUNRdzoMKZPw0DFquNXfhcnDm7btgZ06OKsvhPKLwzSFv+28MWCQ/D1iFw0NYNFrM
         ebIG+zSMSdNJ6QmFZmuAgfb42eH9K+lrFzo7/ZKGWcXZauG4N5Wb0KflakPygP9dd1Jl
         TXsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFnEWTGKEO3EhIJymfkWQr9A++Are1MTr2xiWDtuH6LqwdOG4LjmAX5Y4juJUJ9j+b3Y/hK/ius0Lxxkf2@vger.kernel.org
X-Gm-Message-State: AOJu0YzwIXLb0ghRitVxsDOYCjizboTT+ZoqT7ttz0jcWXMAVWeAJg0Z
	qAv3bQP5DHT7edaF9wuNzFFRflhZ7EIZe1JgBZHbAFfbuxAtK4zhkaqlt54Yi2Ua5U2QOPeaU/E
	6JH0=
X-Google-Smtp-Source: AGHT+IHJZw3ki9mctG+o/iemXY26sAv/498Q2mR/w/rEvQC7trl8tCk660bG8ybcQCHoc5O9YaRaPQ==
X-Received: by 2002:a05:651c:1509:b0:2f7:4c79:27fe with SMTP id 38308e7fff4ca-2f791b59772mr5590651fa.30.1726179970193;
        Thu, 12 Sep 2024 15:26:10 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8cc28sm7035385a12.83.2024.09.12.15.26.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 15:26:09 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bef295a45bso108848a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 15:26:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBJRz1Yv8PLkEgRpjTQZTi4KqfsfxrwwYkujXzXSmiIQLI1gIyggYy9VbhhLbXrSQEFQxG+rPKToEdaCRX@vger.kernel.org
X-Received: by 2002:a05:6402:43cd:b0:5c4:ae3:83bd with SMTP id
 4fb4d7f45d1cf-5c41e193d3dmr666054a12.21.1726179967306; Thu, 12 Sep 2024
 15:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org> <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
In-Reply-To: <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Sep 2024 15:25:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
Message-ID: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>, Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	Dave Chinner <david@fromorbit.com>, clm@meta.com, regressions@lists.linux.dev, 
	regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 15:12, Jens Axboe <axboe@kernel.dk> wrote:
>
> When I saw Christian's report, I seemed to recall that we ran into this
> at Meta too. And we did, and hence have been reverting it since our 5.19
> release (and hence 6.4, 6.9, and 6.11 next). We should not be shipping
> things that are known broken.

I do think that if we have big sites just reverting it as known broken
and can't figure out why, we should do so upstream too.

Yes,  it's going to make it even harder to figure out what's wrong.
Not great. But if this causes filesystem corruption, that sure isn't
great either. And people end up going "I'll use ext4 which doesn't
have the problem", that's not exactly helpful either.

And yeah, the reason ext4 doesn't have the problem is simply because
ext4 doesn't enable large folios. So that doesn't pin anything down
either (ie it does *not* say "this is an xfs bug" - it obviously might
be, but it's probably more likely some large-folio issue).

Other filesystems do enable large folios (afs, bcachefs, erofs, nfs,
smb), but maybe just not be used under the kind of load to show it.

Honestly, the fact that it hasn't been reverted after apparently
people knowing about it for months is a bit shocking to me. Filesystem
people tend to take unknown corruption issues as a big deal. What
makes this so special? Is it because the XFS people don't consider it
an XFS issue, so...

                Linus

