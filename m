Return-Path: <linux-fsdevel+bounces-25914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7A5951B10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 14:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA79282D56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 12:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD63319FA86;
	Wed, 14 Aug 2024 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KmFV+lTq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0593A1E498
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639421; cv=none; b=Usfs8Pe9d4w4JTXqfznS2zSMI5/gvFJqs0Hc+dsaqWL6oTtQA9g+1PwTEKtvyuzaFPx+G+p/QWgvPueSwOWcH3mj/A2TO8iHp6Jy/ozTKVal2sb+yJMz5kCjG32R6cF1Qysy/neBOSBhNQkHUBYQw09BMpRzP7vZtXSgkauk8nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639421; c=relaxed/simple;
	bh=evgg8ridhsj9AdiXWkL0DlKKBEGhSogGjSaqY1vNkfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxEv+YUooHz1A+IaKxgyqRHRnbUGRBQfco+LJOcch+3EDnOGNSeY9zWH/wlJQMhFeEwleWO2jXoU7hHIY/saHRpio4sPQrPOsr0wLr/ChoWA1E8swNJ23hNn9ZzVGfbz9m2qIeJ17H9sCtUXJIZcUf40qbW2HIbIpHx5Ij67JDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KmFV+lTq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-368663d7f80so3426169f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 05:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723639417; x=1724244217; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ypomk+HJlRap9+lz8oD/wJ+MqAQGpQKIAWyfRaZGgio=;
        b=KmFV+lTqc2W95Zvg+CklS8oxN88GKVrWvDJw13Yb99nIGt/yyB5Q1p9cUHJJlcvK10
         lkn/0q9fP8qvCvQueZta7V1jjpXh2kSeiBEwuprEWmBXkaf4wUPOi5Bh38YWiIQL2+e3
         /kTYNOHAfi2+Km4mbZryQ/IAsh+frv9OVNDwaqdPWGvQspjyoCa72uVNA/LVqGjVsCUL
         2fMaV/l/kVdNnycONglxVQZO27rlW0sbmIJxmxw/+6ZPc70tjmDwSZGYx1mhUK4lKArH
         bI5ADW1/hCD1KW3jnOx2Y7OZaxKhYam3pvtZWqrmpHGLZLUP+c6m30dsF/wKXRlfdrKJ
         5KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723639417; x=1724244217;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypomk+HJlRap9+lz8oD/wJ+MqAQGpQKIAWyfRaZGgio=;
        b=hZMWsu+sTeY814DoeBvND5K4oG0bEe9CUgA+8VcrdVvH7pX1hySWkTTo9iHEm5HpBh
         2hxTdp8OQoVG1sT2eZYujH59oEMnqkHSQcsW+LWW6TypxP+MQ17c8tcdXY4e0yfOzwxi
         1oorfFYe/GGyGWv3BwfmNy662rJcu2rm5hZUuysKmFTjWCl+8oXAdM6Fxi/MTCjsC+H3
         RwJ4riuPkEorAo3hGIg7BjFnhqEAw/Svl+mBZFOVViZdL/R4dtbV3A+/c5cmht4Hn2ET
         uxk7sT2M7zUwM5pQFI1Kms+/DDRWSRV+/yA6siuoWouOgVKr2fEOZq0IY3bWahMQnWCh
         TPPw==
X-Forwarded-Encrypted: i=1; AJvYcCVakdUTON2IpQkC8L9UMedTysEjUrjTPjyCAFanI2JUuBWw/lq5i7rJBHEW7UgfuUhwgFUibE4CwmVUKwtw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs2V53EiPrg8mkU+vDzEnSbdhyIbMjGk9LlrYXgeezay5C4wBL
	cFj/cDhu01QM5bFkM7abBnDsMRGyPZP3w2dWoRv2nGzF0R6tziemUwUAtmGdsLs=
X-Google-Smtp-Source: AGHT+IG8GAJoiQZJUBkzacdtcwF40DeKG3vAyhQ3gVD0geVHLmeVuo6ZEHKUw5aW7JibBFEaEdZuAg==
X-Received: by 2002:a05:6000:4388:b0:371:8319:4dcc with SMTP id ffacd0b85a97d-371831950c5mr115307f8f.2.1723639417172;
        Wed, 14 Aug 2024 05:43:37 -0700 (PDT)
Received: from localhost (109-81-83-166.rct.o2.cz. [109.81.83.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfeeb09sm12790032f8f.51.2024.08.14.05.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:43:36 -0700 (PDT)
Date: Wed, 14 Aug 2024 14:43:36 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	david@fromorbit.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
Message-ID: <ZrymePQHzTHaUIch@tiehlicka>
References: <20240812090525.80299-1-laoar.shao@gmail.com>
 <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrn0FlBY-kYMftK4@infradead.org>
 <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
 <Zrxfy-F1ZkvQdhNR@tiehlicka>
 <CALOAHbCLPLpi39-HVVJvUj=qVcNFcQz=3cd95wFpKZzUntCtdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCLPLpi39-HVVJvUj=qVcNFcQz=3cd95wFpKZzUntCtdw@mail.gmail.com>

On Wed 14-08-24 16:12:27, Yafang Shao wrote:
> On Wed, Aug 14, 2024 at 3:42 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 12-08-24 20:59:53, Yafang Shao wrote:
> > > On Mon, Aug 12, 2024 at 7:37 PM Christoph Hellwig <hch@infradead.org> wrote:
> > > >
> > > > On Mon, Aug 12, 2024 at 05:05:24PM +0800, Yafang Shao wrote:
> > > > > The PF_MEMALLOC_NORECLAIM flag was introduced in commit eab0af905bfc
> > > > > ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN"). To complement
> > > > > this, let's add two helper functions, memalloc_nowait_{save,restore}, which
> > > > > will be useful in scenarios where we want to avoid waiting for memory
> > > > > reclamation.
> > > >
> > > > No, forcing nowait on callee contets is just asking for trouble.
> > > > Unlike NOIO or NOFS this is incompatible with NOFAIL allocations
> > >
> > > I don’t see any incompatibility in __alloc_pages_slowpath(). The
> > > ~__GFP_DIRECT_RECLAIM flag only ensures that direct reclaim is not
> > > performed, but it doesn’t prevent the allocation of pages from
> > > ALLOC_MIN_RESERVE, correct?
> >
> > Right but this means that you just made any potential nested allocation
> > within the scope that is GFP_NOFAIL a busy loop essentially. Not to
> > mention it BUG_ON as non-sleeping GFP_NOFAIL allocations are
> > unsupported. I believe this is what Christoph had in mind.
> 
> If that's the case, I believe we should at least consider adding the
> following code change to the kernel:

We already do have that
                /*
                 * All existing users of the __GFP_NOFAIL are blockable, so warn
                 * of any new users that actually require GFP_NOWAIT
                 */
                if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
                        goto fail;

But Barry has patches to turn that into BUG because failing NOFAIL
allocations is not cool and cause unexpected failures. Have a look at
https://lore.kernel.org/all/20240731000155.109583-1-21cnbao@gmail.com/

> > I am really
> > surprised that we even have PF_MEMALLOC_NORECLAIM in the first place!
> 
> There's use cases for it.

Right but there are certain constrains that we need to worry about to
have a maintainable code. Scope allocation contrains are really a good
feature when that has a well defined semantic. E.g. NOFS, NOIO or
NOMEMALLOC (although this is more self inflicted injury exactly because
PF_MEMALLOC had a "use case"). NOWAIT scope semantic might seem a good
feature but it falls appart on nested NOFAIL allocations! So the flag is
usable _only_ if you fully control the whole scoped context. Good luck
with that long term! This is fragile, hard to review and even harder to
keep working properly. The flag would have been Nacked on that ground.
But nobody asked...
-- 
Michal Hocko
SUSE Labs

