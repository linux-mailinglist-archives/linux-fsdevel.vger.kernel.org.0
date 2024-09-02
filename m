Return-Path: <linux-fsdevel+bounces-28195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F27967E09
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 05:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41B51C21C77
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 03:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831516F2F3;
	Mon,  2 Sep 2024 03:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="corBn7BM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA256455;
	Mon,  2 Sep 2024 03:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725246060; cv=none; b=VvWOWcjgyZWe3paDii7igwARxsPgOWf07vvJ5/2Y7w4Wh3/6gOQIA0isOkO9yFlwDuaVhsVpFgImxITjDZGshGVdT7Vf0JEh38AutB9UsrjFqtbMX0TMJO5MWqjs7TDULjDJitnrTXdejEsBcGrmB5wesoASi4Xp0pjWBfHgDgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725246060; c=relaxed/simple;
	bh=edAOJAmsZw3975fOsodLPJi2UQo+cY3XRH19urTIDbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuSLmuNOUDxnuY6ofX5k2cIMVW9VdmECJKCbHFDyjKQffbabHXZOi69CS2Y260AhJJGhB3eXDIxIMCJu/dCie/r4iNzezadQAGirQFEQX90u3xwJlkyGrhWmiQA0XI4KYV70W0Bfkedp9sPbLDEdupYTkImJeYXWd9zdeh/FeVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=corBn7BM; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e1a819488e3so2415884276.3;
        Sun, 01 Sep 2024 20:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725246057; x=1725850857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edAOJAmsZw3975fOsodLPJi2UQo+cY3XRH19urTIDbY=;
        b=corBn7BM0pl+b3HhcWruOEgag+46o6dAbkqiQTuMPG6fpgVn79XHKENBl2P1dJ1VJa
         OjUnrWa7xoYC/iroOf7FSEWU7tJt/C4oBperUjPeumoyWK4Wg5o7oFut+Q0PHmE24eFZ
         9f4L+gwx/qa2h1cLVAGsJBUl59MGWQWQLqmbB3NXf883upRJyGfB70mbVpv6YIXBtDCO
         I59+HiZ1NwsqqIt9SH1sOez7PRDRKXfPN+ayyiNTm0YDYkq78GWhZCoSt1mjz8NGL2NA
         B+BN5tFnM33/ACRWFzJ61Pp9HjX+FaPE3KFMjwRRNkd3WklqPXhLxIxix1+uCDcEzeyq
         Hb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725246057; x=1725850857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edAOJAmsZw3975fOsodLPJi2UQo+cY3XRH19urTIDbY=;
        b=G7fBl9+yQL/Ift8T+yduAyj/Vi+ocSsolFry1kgpkeEzT+XY9t4J+sSC9sRLnMMCrq
         dEQS3xLkyyRs3Dw3x03XWSR3O9W+MTiwfvkDweGVUqX7kfpkSCT9NYw1Omtp1OKNiZKK
         bxXaqL7qeQOw48gfilXkjJBd2vvCQQCtGDPTPgNZUMRIwO1P1csf6yEnA3hwWK4rpayv
         7oZfPllGpfr2BKnsQbCIXdTqoQijxFs2Cy++DZLmWPy2zbjwOhSGrexHX4ChTdY5SaLV
         SpOLavXrOABjpIdw4NbgtooLQKswudFEd85aTtoMHVIVQfZ2es2RHN8vbmxcY5bDrb/r
         b8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCV/q3f8dcZl0VXcbpEHFhN7VNOx4fwGegCKNSfdakPovVeRGCO6xiUO0u0w9qJpZ2J0K4OUFC8D2qwETiqs@vger.kernel.org, AJvYcCXo1+LLQdYX+k9z0RRb0QTT4w9/uYo95iqaVm6zMRr28B551VubaTrx6RDgfCvkza2GLTl5YOq4i2+jbq70@vger.kernel.org
X-Gm-Message-State: AOJu0YyrGE84fkIxWbfYgSaFZuga9cq44XeKjLnXJMRM7vob/S5/ppQs
	zpFWb1uCkK5JC/0cSEUmlNHCtltlJj+7gu4kH+G8+gqLgFGYGVTtqkbTHBCOX1ubG97mh3styZ+
	d8hFz9W9YeUaZrfEQ1cJ6wODaz+E=
X-Google-Smtp-Source: AGHT+IF5Cjbyc1u2E5YIqEaXq1jH6gbFBHgZFuhUPu8+BRfDQXy8bRu8L1XCnhFIKLjj0jYfWHQ9t9TKxlFN9rT5L8o=
X-Received: by 2002:a05:6902:c06:b0:e16:19f7:9702 with SMTP id
 3f1490d57ef6-e1a7a01cc00mr10955110276.24.1725246057273; Sun, 01 Sep 2024
 20:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org> <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
 <Zs959Pa5H5WeY5_i@tiehlicka> <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
 <ZtBWxWunhXTh0bhS@tiehlicka> <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
 <ZtCFP5w6yv/aykui@dread.disaster.area> <CALOAHbCssCSb7zF6VoKugFjAQcMACmOTtSCzd7n8oGfXdsxNsg@mail.gmail.com>
 <f62e400e-49ab-4d0a-b2e2-c3bbb66c2ab1@suse.cz>
In-Reply-To: <f62e400e-49ab-4d0a-b2e2-c3bbb66c2ab1@suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 2 Sep 2024 11:00:22 +0800
Message-ID: <CALOAHbCPiDbQuSzZE-9VuHwkjX-UfXsHPMfdowdG31KhTPMXPQ@mail.gmail.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc allocations
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 11:25=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 8/30/24 11:14, Yafang Shao wrote:
> > On Thu, Aug 29, 2024 at 10:29=E2=80=AFPM Dave Chinner <david@fromorbit.=
com> wrote:
> >
> > Hello Dave,
> >
> > I've noticed that XFS has increasingly replaced kmem_alloc() with
> > __GFP_NOFAIL. For example, in kernel 4.19.y, there are 0 instances of
> > __GFP_NOFAIL under fs/xfs, but in kernel 6.1.y, there are 41
> > occurrences. In kmem_alloc(), there's an explicit
> > memalloc_retry_wait() to throttle the allocator under heavy memory
> > pressure, which aligns with your filesystem design. However, using
> > __GFP_NOFAIL removes this throttling mechanism, potentially causing
> > issues when the system is under heavy memory load. I'm concerned that
> > this shift might not be a beneficial trend.
> >
> > We have been using XFS for our big data servers for years, and it has
> > consistently performed well with older kernels like 4.19.y. However,
> > after upgrading all our servers from 4.19.y to 6.1.y over the past two
> > years, we have frequently encountered livelock issues caused by memory
> > exhaustion. To mitigate this, we've had to limit the RSS of
> > applications, which isn't an ideal solution and represents a worrying
> > trend.
>
> By "livelock issues caused by memory exhaustion" you mean the long-standi=
ng
> infamous issue that the system might become thrashing for the remaining
> small amount of page cache, and anonymous memory being swapped out/in,
> instead of issuing OOM, because there's always just enough progress of th=
e
> reclaim to keep going, but the system isn't basically doing anything else=
?
>

Exactly

> I think that's related to near-exhausted memory by userspace,

If user space is the root cause, the appropriate response should be to
terminate the offending user tasks. However, this doesn't happen at
all.

> so I'm not
> sure why XFS would be to blame here.

Honestly, I'm not sure what to blame, as I don't have a clear
understanding of what's happening during memory allocation. One server
among tens of thousands in production randomly experiences a livelock
within days, making it extremely difficult to pinpoint the root cause.

>
> That said, if memalloc_retry_wait() is indeed a useful mechanism, maybe w=
e
> could perform it inside the page allocator itself for __GFP_NOFAIL?

Perhaps an additional wait or exit mechanism should be implemented
specifically for __GFP_NOFAIL.

--
Regards
Yafang

