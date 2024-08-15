Return-Path: <linux-fsdevel+bounces-26017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AE1952845
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 05:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4641C21FFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 03:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5376381B9;
	Thu, 15 Aug 2024 03:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+goqlj8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902A039FCE
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 03:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723692410; cv=none; b=cF43GB0lY1FXQCRdj1sUNLsP5SZSDoH2VpbOV4ov1JJuoP9DPSjC0/4x1WKZxWkNprt5vUr83gUxRiraK1Ql7fPsoxh7UOlq7R/3+u4OG3VdCHdyDWJ+R4g6xk2Kmf+hKqDE/eT55K4wDrm22CzQ2T1pEm94wreQDgThbLgx2Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723692410; c=relaxed/simple;
	bh=zU14v+afsfNjTh0+w1NtH8vpNujk4z4nT9Kopur5ocI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvaerinmZBeXIJ+1auOzhaiHN22aBKyiwW7KwuIZk5LBDmygxLjt0u7jwCPtM2l2cLWDyArNsoSHqTJEe4JlKRvxmbS8uFGBWM7am/yf2Sy1SBOYd4cW0lcdBeV8Ad5A922nG2KdvbOBGUQlyDIGpWxd7rrw98CYSD0E4liQAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+goqlj8; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e115ef5740dso636683276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 20:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723692407; x=1724297207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFfMWORYoBpF0kpuHqcETmw0Fcag3tVw/GjGoSWPTvM=;
        b=D+goqlj81NEqhuu4h9DW36IcketpNXxC+rEfDaQGV+9rDhcJ+4XgxabBsfDB28TuKD
         T7hp24DaIGR3OKepmfnHn93vkVn9LZMR2N9JEQvYnObIozxWUKiMFrKETQB5w3pEV50T
         5YZkcR75pxBJxJpZb6fAhAljEcRuIVqWKA018auJFgkl2a+DJF37prOYWVFWWwUN+Uam
         fMLLTtgzrA8e5uZdTaJuVPjkGxye821rVNnlpensgicxNIiPpStR+oYDLc3N6iAIMvjJ
         Ad5CRABxDhXSjlqHLxYL0NAUrquz3XrdSQihsuKuTDfH1cpNU9xVlwnnVyO2CRuKq93o
         2zeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723692407; x=1724297207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFfMWORYoBpF0kpuHqcETmw0Fcag3tVw/GjGoSWPTvM=;
        b=AKGnY9Ja+cy/STt/PHIDIpBsBD9XVifSTuDaIZ71eK93MCsbS048XP5L2Anx77M2W4
         RcCa9xx3o1ieVgptE6Ysp6kDOE917ZLQdah64qToNn1OcEjYUDpsU7VQXw4cZmAzOBbq
         roNF3iitPM24YOAKI7SJI0QVH/0kw80OKCFzoFHrzld1AVdPQf3ht3k/uI7a68SFONi1
         zAFGVEPfnuoZW7BtrIPYTZLmhbbMQ2HwMTL1GWEuRYc5L6wki0VOdsTWWeTiVzMJjzfP
         hHtJIkz4SSn6L8g7lzWXPbLByIomm7NUDdgHMAMByDwGAQmOrEfVqB/MW7LkWS9dVcm5
         vwBg==
X-Forwarded-Encrypted: i=1; AJvYcCVQH/cS22lE3xpLvDafbC+dnWZOkjL4d6tydxO8PPbHH3i5oLNY9mWE28sLJYlWQx3/MnziLwLV4jwyv016wrlnAo6/u0bqbmZJ3ly5mQ==
X-Gm-Message-State: AOJu0YyydybHHZcKjUG8h/GxLbLLtUINKSwi+eVwQgpJOb1GsBBYTwtN
	vvv7daVo4QdB8MM5vrqs0JtywmkE1DWC34yEvAWXRf+nIas2lxcfxIETK/AJyqK+sUFl2oAjwDN
	hg146seurU30iDRBFixSZfXiqHVE=
X-Google-Smtp-Source: AGHT+IG7Hn4LJy0dye4N83a07fHjFom4Pikv7OZAHH9fYak5Ir8TNfRuLLFsamKGohm3jtAIbhl4tMMBHDfA4tYJrWM=
X-Received: by 2002:a05:6902:2506:b0:e11:44b9:6bb7 with SMTP id
 3f1490d57ef6-e1155ae252amr5061387276.24.1723692407495; Wed, 14 Aug 2024
 20:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812090525.80299-1-laoar.shao@gmail.com> <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrn0FlBY-kYMftK4@infradead.org> <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
 <Zrxfy-F1ZkvQdhNR@tiehlicka> <CALOAHbCLPLpi39-HVVJvUj=qVcNFcQz=3cd95wFpKZzUntCtdw@mail.gmail.com>
 <ZrymePQHzTHaUIch@tiehlicka>
In-Reply-To: <ZrymePQHzTHaUIch@tiehlicka>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 15 Aug 2024 11:26:09 +0800
Message-ID: <CALOAHbDw5_hFGsQGYpmaW2KPXi8TxnxPQg4z7G3GCyuJWWywpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
To: Michal Hocko <mhocko@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, david@fromorbit.com, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 8:43=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Wed 14-08-24 16:12:27, Yafang Shao wrote:
> > On Wed, Aug 14, 2024 at 3:42=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Mon 12-08-24 20:59:53, Yafang Shao wrote:
> > > > On Mon, Aug 12, 2024 at 7:37=E2=80=AFPM Christoph Hellwig <hch@infr=
adead.org> wrote:
> > > > >
> > > > > On Mon, Aug 12, 2024 at 05:05:24PM +0800, Yafang Shao wrote:
> > > > > > The PF_MEMALLOC_NORECLAIM flag was introduced in commit eab0af9=
05bfc
> > > > > > ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN"). To=
 complement
> > > > > > this, let's add two helper functions, memalloc_nowait_{save,res=
tore}, which
> > > > > > will be useful in scenarios where we want to avoid waiting for =
memory
> > > > > > reclamation.
> > > > >
> > > > > No, forcing nowait on callee contets is just asking for trouble.
> > > > > Unlike NOIO or NOFS this is incompatible with NOFAIL allocations
> > > >
> > > > I don=E2=80=99t see any incompatibility in __alloc_pages_slowpath()=
. The
> > > > ~__GFP_DIRECT_RECLAIM flag only ensures that direct reclaim is not
> > > > performed, but it doesn=E2=80=99t prevent the allocation of pages f=
rom
> > > > ALLOC_MIN_RESERVE, correct?
> > >
> > > Right but this means that you just made any potential nested allocati=
on
> > > within the scope that is GFP_NOFAIL a busy loop essentially. Not to
> > > mention it BUG_ON as non-sleeping GFP_NOFAIL allocations are
> > > unsupported. I believe this is what Christoph had in mind.
> >
> > If that's the case, I believe we should at least consider adding the
> > following code change to the kernel:
>
> We already do have that
>                 /*
>                  * All existing users of the __GFP_NOFAIL are blockable, =
so warn
>                  * of any new users that actually require GFP_NOWAIT
>                  */
>                 if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
>                         goto fail;

I don't see a reason to place the `goto fail;` above the
`__alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE, ac);`
line. Since we've already woken up kswapd, it should be acceptable to
allocate memory from ALLOC_MIN_RESERVE temporarily. Why not consider
implementing the following changes instead?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9ecf99190ea2..598d4df829cd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4386,13 +4386,6 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned
int order,
         * we always retry
         */
        if (gfp_mask & __GFP_NOFAIL) {
-               /*
-                * All existing users of the __GFP_NOFAIL are blockable, so=
 warn
-                * of any new users that actually require GFP_NOWAIT
-                */
-               if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
-                       goto fail;
-
                /*
                 * PF_MEMALLOC request from this context is rather bizarre
                 * because we cannot reclaim anything and only can loop wai=
ting
@@ -4419,6 +4412,14 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned
int order,
                if (page)
                        goto got_pg;

+               /*
+                * All existing users of the __GFP_NOFAIL are blockable, so=
 warn
+                * of any new users that actually require GFP_NOWAIT
+                */
+               if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask)) {
+                       goto fail;
+               }
+
                cond_resched();
                goto retry;
        }

>
> But Barry has patches to turn that into BUG because failing NOFAIL
> allocations is not cool and cause unexpected failures. Have a look at
> https://lore.kernel.org/all/20240731000155.109583-1-21cnbao@gmail.com/
>
> > > I am really
> > > surprised that we even have PF_MEMALLOC_NORECLAIM in the first place!
> >
> > There's use cases for it.
>
> Right but there are certain constrains that we need to worry about to
> have a maintainable code. Scope allocation contrains are really a good
> feature when that has a well defined semantic. E.g. NOFS, NOIO or
> NOMEMALLOC (although this is more self inflicted injury exactly because
> PF_MEMALLOC had a "use case"). NOWAIT scope semantic might seem a good
> feature but it falls appart on nested NOFAIL allocations! So the flag is
> usable _only_ if you fully control the whole scoped context. Good luck
> with that long term! This is fragile, hard to review and even harder to
> keep working properly. The flag would have been Nacked on that ground.
> But nobody asked...

It's already implemented, and complaints won't resolve the issue. How
about making the following change to provide a warning when this new
flag is used incorrectly?

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 4fbae0013166..5a1e1bcde347 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -267,9 +267,10 @@ static inline gfp_t current_gfp_context(gfp_t flags)
                 * Stronger flags before weaker flags:
                 * NORECLAIM implies NOIO, which in turn implies NOFS
                 */
-               if (pflags & PF_MEMALLOC_NORECLAIM)
+               if (pflags & PF_MEMALLOC_NORECLAIM) {
                        flags &=3D ~__GFP_DIRECT_RECLAIM;
-               else if (pflags & PF_MEMALLOC_NOIO)
+                       WARN_ON_ONCE_GFP(flags & __GFP_NOFAIL, flags)
+               } else if (pflags & PF_MEMALLOC_NOIO)
                        flags &=3D ~(__GFP_IO | __GFP_FS);
                else if (pflags & PF_MEMALLOC_NOFS)
                        flags &=3D ~__GFP_FS;

--
Regards


Yafang

