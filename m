Return-Path: <linux-fsdevel+bounces-25887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D25269515A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 09:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027621C275F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788C513AD33;
	Wed, 14 Aug 2024 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSt/bTqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA629CFB
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620785; cv=none; b=P2hWaigxnF+kvbqV4BuqEoYGX7sOjT8xRLFaSPMM6VJzegHebZWlN//hZHv0vhNLaNBUhbgcfZg0OzD68ZAe9qTiQC9Din89kBMXYO48ny5brkwUsdcYdgu6LrQGnqeZRqILuCfisQPUHZ6IzmvAzeY5oDYcgFlBw+rGuUiWrns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620785; c=relaxed/simple;
	bh=xX/c9y/9P/4TSSuVmWo91XUEgvFAaJd+fqWjAt6GPuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AW4rwa3bs05wST6oCsBbKZE0yHSOI7yYl8JWEZBy5kt4HuXpiOTQvXx8gGX+wxrNmVOa1yrVZ93NsGqd+qfcaCms/hOgYBVYXRMa68ZYBytI50W/gzNCsNc3ypSdR4INCgkKSoktGVpP9ZQGcGph+YRcnM7IvVnt6hNkWAblRq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSt/bTqK; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-65fdfd7b3deso58225597b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 00:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723620783; x=1724225583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwXPWafGZ4R84u08fJaM2sWyE5li15RqmBSGPD0D4Cc=;
        b=mSt/bTqKRE8jLeDmvvdhA8JEG3t1koKBiTqkNOiFCwQ7GCONV0lDwqiMlU87quFUGf
         ZGT9R4PG3KwGgIQWCxt/+/EsgqXWGUmb707LW281KJLGbO7mDUR14RQ8DOmNnycOW9Tb
         Kob8ivVaayEJ6HKoKNfdsmVxUCsvWcqSUoZeOe+JfChaIIUsq4xPNj5aQRtj67ftxDx+
         VeL5d+ZcGTe99MDWCrDZB0emYglV+lvXT7Q08uhrjg8bHaShQdbDzOKxtZxvem0+DCCy
         udwAQ5/9uiGlagcKgH46oNWlkxrddtfX/Glm1drSM1nBs+mIxUNw+pp0kDOucwgSI+BC
         wCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723620783; x=1724225583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwXPWafGZ4R84u08fJaM2sWyE5li15RqmBSGPD0D4Cc=;
        b=GNbCHPhuMhuQN8w22jTgGPiWzdN5e/DbgIVCRpG8q8DfNcA+UhFvoycob8Q0WX63Xs
         eeK2dMdn6ZhtzlsLpBexPR0fR7yB4V3kwuGRr2qNi+EULMXFcUgEA0B3T5W+afhYCy8M
         qHjlJeOFwYpq4Z+oNbplHTJEj1D4UudZMfNA+uyjcbmnAhiLbZDzXHCgCaYdNr7gE8bF
         uesbgUcinEfPZ0Rq7X+xe2ULEm3zhqZzrapJNpiPUfRsGNQh17ov+NvAtibuo9PsjAJp
         d7tK6gjsBkL3yGglo/l48uNTH+ih+qGPLeth36R5j/2LubUXk3o0PDLSuFnt44EqPhfA
         9gTg==
X-Forwarded-Encrypted: i=1; AJvYcCX2Xhcl31TcMdJeG82CGamuvrpQ1ePdMrXPMkw0z5CNvB9X3uMItOUFjZfRiOwXQ/XWgmeeEFxTHXqUnSk76usbq7LQDNRI4y8/52k58w==
X-Gm-Message-State: AOJu0Yw8CEziPB7fWqZW6H1muH/QQIoabLcVGclVnrCe1eDQzKUltot0
	dPzcKsRlu/ZWTScXj0sOfo44LhB5yvQyY7zrM6gLyR7DYKx6shiui1I+NHM9RPKlpqtsewR6gvh
	dERqd4GxtGDna7ubzUa6Kx916dzE=
X-Google-Smtp-Source: AGHT+IFIgfOsTL3/m+IXLqQJTTNiiwhMGTFu9w0Gc22QIClt0jG590ERbPVfH0qAxfggSQcvyjc5FwWIDIBjqT6Vouc=
X-Received: by 2002:a05:690c:4241:b0:631:4da3:17ee with SMTP id
 00721157ae682-6ac9a478578mr20017007b3.40.1723620783009; Wed, 14 Aug 2024
 00:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812090525.80299-1-laoar.shao@gmail.com> <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrv6Fts73FECScyd@dread.disaster.area> <CALOAHbAfQPdpXt0SHGxQdJEi1R_u+1x2KSwZ5XfrQD-sQmhKiA@mail.gmail.com>
 <ZrxDrSjOJRmjTGvM@dread.disaster.area>
In-Reply-To: <ZrxDrSjOJRmjTGvM@dread.disaster.area>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 14 Aug 2024 15:32:26 +0800
Message-ID: <CALOAHbCTv5w4Lg3SeA43yCAww8DobJ_CN+9BcQDMJzaHVPNZZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
To: Dave Chinner <david@fromorbit.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 1:42=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Wed, Aug 14, 2024 at 10:19:36AM +0800, Yafang Shao wrote:
> > On Wed, Aug 14, 2024 at 8:28=E2=80=AFAM Dave Chinner <david@fromorbit.c=
om> wrote:
> > >
> > > On Mon, Aug 12, 2024 at 05:05:24PM +0800, Yafang Shao wrote:
> > > > The PF_MEMALLOC_NORECLAIM flag was introduced in commit eab0af905bf=
c
> > > > ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN"). To com=
plement
> > > > this, let's add two helper functions, memalloc_nowait_{save,restore=
}, which
> > > > will be useful in scenarios where we want to avoid waiting for memo=
ry
> > > > reclamation.
> > >
> > > Readahead already uses this context:
> > >
> > > static inline gfp_t readahead_gfp_mask(struct address_space *x)
> > > {
> > >         return mapping_gfp_mask(x) | __GFP_NORETRY | __GFP_NOWARN;
> > > }
> > >
> > > and __GFP_NORETRY means minimal direct reclaim should be performed.
> > > Most filesystems already have GFP_NOFS context from
> > > mapping_gfp_mask(), so how much difference does completely avoiding
> > > direct reclaim actually make under memory pressure?
> >
> > Besides the __GFP_NOFS , ~__GFP_DIRECT_RECLAIM also implies
> > __GPF_NOIO. If we don't set __GPF_NOIO, the readahead can wait for IO,
> > right?
>
> There's a *lot* more difference between __GFP_NORETRY and
> __GFP_NOWAIT than just __GFP_NOIO. I don't need you to try to
> describe to me what the differences are; What I'm asking you is this:
>
> > > i.e. doing some direct reclaim without blocking when under memory
> > > pressure might actually give better performance than skipping direct
> > > reclaim and aborting readahead altogether....
> > >
> > > This really, really needs some numbers (both throughput and IO
> > > latency histograms) to go with it because we have no evidence either
> > > way to determine what is the best approach here.
>
> Put simply: does the existing readahead mechanism give better results
> than the proposed one, and if so, why wouldn't we just reenable
> readahead unconditionally instead of making it behave differently
> for this specific case?

Are you suggesting we compare the following change with the current proposa=
l?

diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..ced74b1b350d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3455,7 +3455,6 @@ static inline int kiocb_set_rw_flags(struct
kiocb *ki, rwf_t flags,
        if (flags & RWF_NOWAIT) {
                if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
                        return -EOPNOTSUPP;
-               kiocb_flags |=3D IOCB_NOIO;
        }
        if (flags & RWF_ATOMIC) {
                if (rw_type !=3D WRITE)

Doesn't unconditional readahead break the semantics of RWF_NOWAIT,
which is supposed to avoid waiting for I/O? For example, it might
trigger a pageout for a dirty page.

--
Regards

Yafang

