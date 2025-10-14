Return-Path: <linux-fsdevel+bounces-64094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B67BD7FF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 09:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43EBA4EA63D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 07:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115A330E827;
	Tue, 14 Oct 2025 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="F079Hd0Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA3530DEBE
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428130; cv=none; b=su4QPcn/A1tKlRSV82hzYfEXAPUmGVdOGCv/uwApsZq5kTXqpLSircayS3jHODJuckdZye5PzWZHjEF/cTfMeRdriHEE9LfE4AeCfhkjyCByom/VUCyl+abT35UpLWU5waKtzOoc+Z+b6aDSeXsxDBJrkDQuC14w7LOWjSasi8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428130; c=relaxed/simple;
	bh=zPfak/uLuE6QIa2Kix1FYCn474UeI220vFuuIJA6bBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYq4jSLLPJxGMrVQw4FpUNjXWYHdW8HhcmP5rqB5iuuD9AAn6jnQ4BIRclJw8zVXad/mQwhGPZxBFgiQQ3jFLL3MaWihb8kUe0Fqof2tcfGAahwBnaLGR9id2sbA/NSopkO5dwj23ITnNEpvSYD8DYPw1jcrX+l2uqTNdJpOB8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=F079Hd0Z; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-855733c47baso977393185a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 00:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1760428126; x=1761032926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BSbg7IxQb2NmRhKX1MyQBOKjUnzdftnCDBYAUuaxwcA=;
        b=F079Hd0ZdgTO0VKMN1pYXagD3ZLMyvWJ1g2Dvv9VHOnGlXexk1t6VjizP5CDo1xpBl
         S0UF8XGNDWkgrj/rTiiEPIFUYwk14+1p0nSstbPk+HLuEdv3ALJ6x92KCNNGAHOBt8ns
         etsg+4RvRgZ28oF3Y/jIayMXwG+Nh0ffBjd+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428126; x=1761032926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSbg7IxQb2NmRhKX1MyQBOKjUnzdftnCDBYAUuaxwcA=;
        b=eaO0LEwRaIVdM5cFS7ETDLmk7xz32Dr8CZqYlWKjz+lS+7cXIOdpmxCNXtqi4eGBDK
         bqDisAYThRWQIPwIjTiJuzqgeHIrH8dkYwy+Pj1sk3rSPhCS9pz818WcNSr9s6X9GoAg
         ru3vExKcZzpb4pP2jW6DL5UqVJoxc4fapWsyc8/c0TzbGacmFh2NqXTUpOQ3HGv7s3o7
         6vAbqTDybuTNdId53QotAGS3HgAkiZxcp5/FyxO3TOiT0HIblpUUq5P48NodP35dSswT
         T5FreofPZcLZbyM1hgzNfvIDXwDut9or5edoc+89UfSaUoQEKNP3If5dOUnYeEvlBQJi
         HlvA==
X-Forwarded-Encrypted: i=1; AJvYcCWO6W1QCmLj+KFuWOj9f1ILP7HpzH3Nzn0tlTcHkrN+he1DfqPTfRRJ6U6h12f2dyZQsFqTriRtv9q9N42X@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9QkbKb//d0ZpQuaqAPF0YLxYcDA1F46m0knvnpFPtxx34R4Q1
	1BYbK+PO+E1xiiYxDcremrJbMKNHaDr3AqMgxkvQYhU0A3MAXQAynPP5hMIxo164s1sOFj229cL
	ilDEpugCoNNeEIXxRr0KKDhsXm9pmHrswb5q6ZF8pKw==
X-Gm-Gg: ASbGncu1c6kiXY78Ekyn6MBp/GUzU3nGMbC8rPkWsiab2IdwmsZGjEqVpnvWk6fZSPF
	/7yDma1pqYAipRH+RrE1wtmtpoYIvNppsqk5QawP/ZUmrjInWYb3KLA8i4JIm2cX8jvEvPmM+KZ
	S2b9KCpLirWO3XDnlU4fDVenqYp2EeFV7L8IBqCb3/e0C69A95YObARlayDTHiyl3lL9YFwdzK9
	Df8UJQeacii1XkPk1O+GoVuyvG9eytKXVQGVs3Vlsdk4KnfOmSnewfZg56q9oYH5lUn5A==
X-Google-Smtp-Source: AGHT+IGvncMdJBcaFFlcJKGNDdS3S6WpUqvcLztZPqtXvHeu0D5NWwCna3KyK4CVJzrme0al0MWNsayaUn1S8sAsCrY=
X-Received: by 2002:a05:620a:394d:b0:85b:8a42:eff9 with SMTP id
 af79cd13be357-883525c0d7amr3079631585a.53.1760428125643; Tue, 14 Oct 2025
 00:48:45 -0700 (PDT)
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
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster> <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster>
In-Reply-To: <aO1Klyk0OWx_UFpz@bfoster>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Oct 2025 09:48:34 +0200
X-Gm-Features: AS18NWBf3ks7a6dxyjB1ace7scEWFB77UTP0wHqY44cLPDV1w5ckKEDyJMj02IQ
Message-ID: <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Brian Foster <bfoster@redhat.com>
Cc: lu gu <giveme.gulu@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 20:49, Brian Foster <bfoster@redhat.com> wrote:

> Hrm Ok. But even if we did miss remote changes, whose to say we can even
> resolve that correctly from the kernel anyways..?

No, I'm worrying about the case of

- range1 cached locally,
- range1 changed remotely (mtime changed)
- range2 changed locally (mtime changed, cached mtime invalidated)
- range1 read locally

That last one will update mtime in cache, see that old cached mtime is
stale and happily read the stale data.

What we currently have is more correct in the sense that it will
invalidate data on any mtime change, be it of local or remote origin.

> > Yes, reproducer has auto_inval_data turned on (libfuse turns it on by default).
> >
>
> I was more wondering if the problem goes away if it were disabled..

I haven't tried, @guangming?

> Ah, yeah that makes sense. Though invalidate waits on writeback. Any
> reason this path couldn't skip the dirty state but mark the pages as
> under writeback across the op?

Maybe that'd work.  It *is* under writeback after all.

Maybe the solution is to change the write-through to regular cached
write + fsync range?  That could even be a complexity reduction.

Thanks,
Miklos

