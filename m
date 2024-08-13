Return-Path: <linux-fsdevel+bounces-25749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CD594FBA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 04:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704FA281F15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 02:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AA91173F;
	Tue, 13 Aug 2024 02:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLZ4cQvA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E686AB8
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723515002; cv=none; b=WJKuQ0EbIrK6xSt+rGT5RFi0JJAMuisKDe3Z3qmIuIGgQj8/Bu4u4KfIgHQsJDW6c2kiarrmtK/pOhimNbrfgWqVRxZo5M4HPINi9aCNsLO/SVpkjy0WtUR1q0fD5M6poHM/jAGeWVjJGFKW0sxQJdp08aNswCXt7oqcSNCMFIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723515002; c=relaxed/simple;
	bh=9+E80Lsjcn13gZ6bcfWRidYya32AR9TvenUvK0jOBkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RvF0p9lDXsGUeohJoucwAoKde5Y27xwzMsjmxEkY4fQFEnjV0cfB+cOtILxfGQe/lZnXfR1qrnkqcgXZjP+NJMFZlHFnVyIpZlIo90ABv9ezEqB3rh5Kj4t0G+HjfEAxkSl6l4ZLfsjeZJaUn6bKWl2sJG6uN42IJlMPwolDI2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLZ4cQvA; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5da6865312eso505281eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 19:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723515000; x=1724119800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWTXWJaSuJqXRYZNghI1V7yuEE01g8xrWbX3wwO/YSg=;
        b=NLZ4cQvARLfxsNRze7rhDHydhyXetaUYTtroLmKYXROdpWJLObQEz31lu/VcYg7skq
         ccC/IejGI/V+Mw2AXVEaLc1NIAqmRWKOzJCm/vDVhaCXBf8chRIBIqXb5vTszV9rnuYC
         GOwSjLocrboHCpyO4praAXK6OXnaCfmAdKfbudaT1fDmIrsI/pKAcdEmpTRQTVPiP1Ld
         9+nQcMlJiyryjJfHe6lDwcTeVuipheVzim0AD8DiM7jrPr/kewX0FxY7mn2l9TZQiw76
         v2w0LWkdNIywrDval1zqFaIVLUvWgzOcmpghuU7vfnIYzYnfctsJzKpONxB8K56azpaO
         jOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723515000; x=1724119800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWTXWJaSuJqXRYZNghI1V7yuEE01g8xrWbX3wwO/YSg=;
        b=jS0oy/5dYWxnCqePS10T+lMrq9Txs+fuHr/lOTE9J9w1AVYBBdreiw9EeBM8+QXoFv
         GIlpgG9NxbfJTqtx20iJZT7ACLCVuYcKobNJnPFBnnhJ2sOycSI6dqt/ZsqPsqP9KASp
         NSdSaHhaDi/vPITpgfqYQ6OkJ2P9a0Hax/QeHseAP1BFK45t4HzQXn4NbIW8vIlcY3Gu
         vdmyU5/eq2NeiarH6FMKkcNwA+gv2n86z7iWEg9ZBexoBSJ/ydeEWc92B8JsjHfQNN1r
         kYaiXjI0ox7zA7Tl7ejB+w3AmuGNJ9oO9xAIy9swVxJNd7ZSduChav9dg0BRoxLubOrJ
         CTlA==
X-Forwarded-Encrypted: i=1; AJvYcCV/yYrEKIlBo9r9IpFv/exSPvMPnhlVUCbbvncma0K4HUW1byQH5cK2eUeohE9+50HH0d93iOrBE3DVgMNwm2BK+OMl8ya1ql6u99uVJg==
X-Gm-Message-State: AOJu0YzpaNoIy7TuVLO2FlSvMVdJJxZFeA/2iht+oM4sqhB5NDgHqxj7
	22uRVnhX+7uiDx2uqxXW4lk/ycX5NeCXnZdWfIuUz9pZktXivGOEka18HtRDZSGoYw/XpWcecvn
	ax42mQvz6fcsloGX/N1sC4Rp6nZY=
X-Google-Smtp-Source: AGHT+IHRZrGX87cuGJRiUHttBtwhs8p+UCodXELlCDBbkFapXCMyAly9V29tY8JwT210q4nacgpgx2nFxvBIhZrCkVE=
X-Received: by 2002:a05:6358:12a6:b0:1aa:d6fe:f424 with SMTP id
 e5c5f4694b2df-1b19d2ceac7mr295616955d.13.1723515000263; Mon, 12 Aug 2024
 19:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812090525.80299-1-laoar.shao@gmail.com> <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrn0FlBY-kYMftK4@infradead.org> <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
 <ZroMalgcQFUowTLX@infradead.org>
In-Reply-To: <ZroMalgcQFUowTLX@infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 13 Aug 2024 10:09:24 +0800
Message-ID: <CALOAHbC=fB0h-YgS9Fr6aTavhPFWKLJzzfM4huYjVaa9+97Y4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, david@fromorbit.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 9:21=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Aug 12, 2024 at 08:59:53PM +0800, Yafang Shao wrote:
> >
> > I don=E2=80=99t see any incompatibility in __alloc_pages_slowpath(). Th=
e
> > ~__GFP_DIRECT_RECLAIM flag only ensures that direct reclaim is not
> > performed, but it doesn=E2=80=99t prevent the allocation of pages from
> > ALLOC_MIN_RESERVE, correct?
> >
> > > and thus will lead to kernel crashes.
> >
> > Could you please explain in detail where this might lead to kernel cras=
hes?
>
> Sorry, I misread your patch as doing what your subject says.
> A nestable noreclaim is probably fine, but please name it that way,
> as memalloc_nowait_{save,restore} implies a context version
> of GFP_NOWAIT.

There are already memalloc_noreclaim_{save,restore} which imply __GFP_MEMAL=
LOC:

  memalloc_noreclaim_save - Marks implicit __GFP_MEMALLOC scope.

That is why I name it memalloc_nowait_{save,restore}. GFP_NOWAIT has
the same meaning with ~__GFP_DIRECT_RECLAIM:

  %GFP_NOWAIT is for kernel allocations that should not stall for direct
  reclaim, start physical IO or use any filesystem callback.

--=20
Regards
Yafang

