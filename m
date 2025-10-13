Return-Path: <linux-fsdevel+bounces-64005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68021BD5B0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 20:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4D218A6F0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 18:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2D82D3ED2;
	Mon, 13 Oct 2025 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hI9HSNrT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E652D249E
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379833; cv=none; b=Kybq3D5F4Kcff2OMLOLE9rUKrxeoeRNX3u4M8lHc0wXuJ/UBJMmsXsRozwjv48Naf26jtFR6N20V2mDbd3vskmlF8zQE3bHyVOUsfq2K7z2dKDK76bVF9tQ4eMVT1GW5oOZUUCDH+eA4961pfRfxxsxhRqMKckHg9Uvj4Toc8nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379833; c=relaxed/simple;
	bh=oj3ymEY5ytiQnceXg4xjG/to1YEhk7x+D6HZVhrguMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHV8yEtoAhIDRk4/eg+8vnBQV4vLv6PKqkjAN68gLeuBsWUERvi9r93woAiIMNnz7keCa1zgIuF35q5LCPmKpbK/KcgJsMBTTPBzvrX2+CA8q6m1+Tfo40gAD22oYLIp/RyZvgb6GceulSEyYZHOZWKGOKOtT08rjqlI47Dn9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hI9HSNrT; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-78f30dac856so62893586d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1760379831; x=1760984631; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xGzGudAw74SkMnYY/UmMGm8N5SWqgNLK0B2d1FLukKw=;
        b=hI9HSNrT38RxDJ73UvqPoo2ffnFKe3fAn2psM1ejqq63dkhaBf7Nfc/IUaNq2cLiSX
         GI8kI6yJg6L9pxb97X372ssrMA8Ij2ImlfaeRzOD07bgkJfeLxBGXIsCNNcAL/mPNtX6
         BXK7EXhJifEO6NsDV44ItBNJahHb8sofLpSYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379831; x=1760984631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGzGudAw74SkMnYY/UmMGm8N5SWqgNLK0B2d1FLukKw=;
        b=AQqqcyPsfOYjHL8+DtGXGnV6ypMndNfVqArAcJ+DfQva9pyxHF7UCdHAE3FDqKs4eu
         hzQjlQ1D9Ax9w3urWfw2gktpUzNKtB8rQaZLgh02sWRfc/nr3B1qCWHrcA1f5T9RWRAG
         quPD85l6pkSN7Homg+tcFNYLW3Hir9djYtnATtmlFtZK6FBZFP9iZiJIb/ZiyZ5Qa3DG
         va+KnZV7kKUQ3n9L5J8hmvJ7Ku15StXmVRD6l59GPp60xfy2wAy1c0OcajJEwMYDHa8m
         W0VRLkrg5kz5b3tNi3yrI5Swx+tOX3QZBe/vOhy3tAzl2sQFMlwO9MdbAZw9YhveXBQK
         vh8w==
X-Forwarded-Encrypted: i=1; AJvYcCVc40LZCNzFadXDJ+VdSzO/5jQv0nmks10nhNaFTfygmdUirj6h1KqoNxDwQ47hsmuMqyhjlknmNlAJiZdG@vger.kernel.org
X-Gm-Message-State: AOJu0YzqTJk5VDvivVAcjVaRARRIzNN9PaibIytUd9UpFlIBTbX+supe
	Eu/A87rYK2Yi73lwFM5kGo4snkqHe9msFSFziHaavbiTTMxS8dA+olqxxVx0j54gB4u50SypwB1
	lKJTWk39l//kEvBalZoKbpznUNUWCoDRkv0NeRcmK98wHw0Zx6APcCSM=
X-Gm-Gg: ASbGncv/6PtlyoOgUXfNwE6GL+TShdLRfSPGi8tFO60+RInR5xSIcN2mj5LcVZZk4/0
	IiCXkPAHcR55NBktpM9BL5zOmqbKT7EHurKY67UuWQqeS2+uSY0L3PFQmylQnPwohYXGm5fy0pJ
	1wtkwDxJHnDO3YcD1ZYt8vY6wxAQicmBsNCjG3OzFGfJu+6DqTx6iHWby1Fw3OxIpoNGUOrkagF
	mobbp/UBnZVpewBFwDTPfNO7vo0Y/9ADQv7S11pwYS0gjApEzC0hs7eKZ7SQJIsI8YhgQ==
X-Google-Smtp-Source: AGHT+IGtyJAi0aIbXMlZXRmaD4YedN5oSr1kFc/9MCeuFwFc9dxYNGFtJjQx0gzvRr7c9odz+OcqN5vYrxq28kaovu8=
X-Received: by 2002:a05:6214:21ca:b0:810:e12a:48fd with SMTP id
 6a1803df08f44-87b2104ef39mr334138546d6.7.1760379830919; Mon, 13 Oct 2025
 11:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com> <aO06hoYuvDGiCBc7@bfoster>
In-Reply-To: <aO06hoYuvDGiCBc7@bfoster>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 13 Oct 2025 20:23:39 +0200
X-Gm-Features: AS18NWC-pZdrDsA29gb42TTRpRA_B_lB_N06Y7ycMZ61PDW2_vb89CoarPolXmY
Message-ID: <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Brian Foster <bfoster@redhat.com>
Cc: lu gu <giveme.gulu@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 19:40, Brian Foster <bfoster@redhat.com> wrote:

> If I follow the report correctly, we're basically producing an internal
> inconsistency between mtime and cache state that falsely presents as a
> remote change, so one of these attr change checks can race with a write
> in progress and invalidate cache. Do I have that right?

Yes.

>
> But still a few questions..
>
> 1. Do we know where exactly the mtime update comes from? Is it the write
> in progress that updates the file mtime on the backend and creates the
> inconsistency?

It can be a previous write.  A write will set STATX_MTIME in
fi->inval_mask, indicating that the value cached in i_mtime is
invalid.  But the auto_inval code will ignore that and use  cached
mtime to compare against the new value.

We could skip data invalidation if the cached value of mtime is not
valid, but this could easily result in remote changes being missed.

>
> 2. Is it confirmed that auto_inval is the culprit here? It seems logical
> to me, but it can also be disabled dynamically so couldn't hurt to
> confirm that if there's a reproducer.

Yes, reproducer has auto_inval_data turned on (libfuse turns it on by default).

>
> 3. I don't think we should be able to invalidate "dirty" folios like
> this. On a quick look though, it seems we don't mark folios dirty in
> this write path. Is that right?

Correct.

>
> If so, I'm a little curious if that's more of a "no apparent need" thing
> since the writeback occurs right in that path vs. that is an actual
> wrong thing to do for some reason. Hm?

Good question.  I think it's wrong, since dirtying the pages would
allow the witeback code to pick them up, which would be messy.

> Agreed in general. IIUC, this is ultimately a heuristic that isn't
> guaranteed to necessarily get things right for the backing fs. ISTM that
> maybe fuse is trying too hard to handle the distributed case correctly
> where the backing fs should be the one to implement this sort of thing
> through exposed mechanisms. OTOH so long as the heuristic exists we
> should probably at least work to make it internally consistent.

Yes, that's my problem.  How can we fix this without adding too much
complexity and without breaking existing uses?

Thanks,
Miklos

