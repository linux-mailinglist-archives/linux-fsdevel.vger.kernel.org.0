Return-Path: <linux-fsdevel+bounces-20865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E788FA564
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 00:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A28E1F260CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 22:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EEF13C90F;
	Mon,  3 Jun 2024 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="srpa8opl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D10813B791
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717452606; cv=none; b=gZit+nGp6rTeyv2AgeN1evbCOmOUDwyo3kcjqxXP3zBzzzeYksOxbfnY1+KGnxEokVDCEVrILYFX3qQZEHJnKuZMb4E6Zg06cIfhOIPVIJODJi7Q9qIowQbRHvqgc6iTxfcU87u0ffIZTU13RQ/ldtkdTCUhR2dLRVu7Uyoxkmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717452606; c=relaxed/simple;
	bh=6JYUK/JYFtBaQXk5Wd3j593s8c/SjwpSDffu/EOZPtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvSFJ4UKe3Sb+WRgJUEN8mRgcoiKzmmUAuwSPCSk0IK0PsKT7jGMJ9okxqtEZXU34WUnw7O9Uiqi6saz5oLhFmDRYHV0OOkTKaNlplz9cFT04RxCTaRb0pcUme9vll+0nKtJDXhAXPFIUe1B6bJOVbgp8FJciZCbvSf+m6UDP3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=srpa8opl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f480624d0dso39192885ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1717452604; x=1718057404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7GKUQMjJhl3ipM3zR31k8Ko1N1r8B30w07RRIKYgq4=;
        b=srpa8oplsXgiu6bczYQgBXvvkq2slK5PLSHEUghf2Z0cxTAoh/H0N+KJlNXHtZbZUk
         kEbeozoxv23bFPpB78LRQ3oxmyEOPhJ+NatqfqU7jfNnYYBAaf4a5IFydee8+ryiAKyV
         am1LYBVdNA581qbXRV4dhO2afYDFjd/AsysudYi0LJv9tnOmd7wM+R0AQmiFi3qOvCUR
         iLaQ/TAQhBkgohImwFzzwoIJdwoDvwhDV84k3gRYc1pH/RUhVuSnkKsx4xW9qeS04SSm
         twK2WnavdmM85UWYRij7V+I3IAMjwbIvInm+no9giNZ2TRrRB/3v5oz/aSL7zDxOj/7P
         0NaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717452604; x=1718057404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7GKUQMjJhl3ipM3zR31k8Ko1N1r8B30w07RRIKYgq4=;
        b=YCNr7U3uT8/5we0Ul4H096/JdvGAvwPgoFxFlFPzdnxLiMm8P8Ae6fZoT9hqvL5W52
         98ex3XPmkEWSZ7VxxaxG9FnfsvpBisDFVKCYuQuw08zxZ2Ljt4iki5FfUpUCtII2blD8
         2GXB51BP27TrQIeSxHvAMTGpuKSZ6F9erlZiFHpkME9CiXx4litn/h4PLREF3V/RkKSV
         dFw2SvIdmG5iqBNwb3ByU8SsREL5OmVS1bMeLG6vJEN7JwfKsQZILYIopvxrYqmviF9q
         t18kC1XSMmt0iS2PyJFaIEqr1YXgOjPJMlklx0V48EKMzez09xmxGINbyTyl9+qwGUXO
         nvXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkg1cjHGWifb6iJBDYz78pqH67/7axL1qs5JoyUuQQUQxX1U+xPClYvznP77gGhT0EICAAhVjaUYHW6ODuz8zlpiGBsWzDI0m8fGuuIQ==
X-Gm-Message-State: AOJu0Yz3SH1W3S5Pk+/us3pRjVia/zxGX8gIBL5Fd55SYvb0zf/BS134
	Ed/rw2ZA2GbQsM1gZ44DJukZ268qXTQ90rAOCjGtOgeNrTyY9Rq7aFmnNI4LkVtB+8aVKMqpwP/
	I
X-Google-Smtp-Source: AGHT+IH5yMClkcY+6/WbP2qYz4dW8LFjoQ+vX8JMxAX2MslIbXm1VlEjEbivmMhYyH34HOly6saJ6A==
X-Received: by 2002:a17:902:eccc:b0:1f6:65b1:1208 with SMTP id d9443c01a7336-1f665b1145amr85868595ad.47.1717452603776;
        Mon, 03 Jun 2024 15:10:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f691cdd674sm5019255ad.80.2024.06.03.15.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 15:10:03 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sEFsO-003KJd-0g;
	Tue, 04 Jun 2024 08:10:00 +1000
Date: Tue, 4 Jun 2024 08:10:00 +1000
From: Dave Chinner <david@fromorbit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	lege.wang@jaguarmicro.com
Subject: Re: [HELP] FUSE writeback performance bottleneck
Message-ID: <Zl4/OAsMiqB4LO0e@dread.disaster.area>
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm>
 <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>

On Mon, Jun 03, 2024 at 05:19:44PM +0200, Miklos Szeredi wrote:
> On Mon, 3 Jun 2024 at 16:43, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> >
> >
> >
> > On 6/3/24 08:17, Jingbo Xu wrote:
> > > Hi, Miklos,
> > >
> > > We spotted a performance bottleneck for FUSE writeback in which the
> > > writeback kworker has consumed nearly 100% CPU, among which 40% CPU is
> > > used for copy_page().
> > >
> > > fuse_writepages_fill
> > >   alloc tmp_page
> > >   copy_highpage
> > >
> > > This is because of FUSE writeback design (see commit 3be5a52b30aa
> > > ("fuse: support writable mmap")), which newly allocates a temp page for
> > > each dirty page to be written back, copy content of dirty page to temp
> > > page, and then write back the temp page instead.  This special design is
> > > intentional to avoid potential deadlocked due to buggy or even malicious
> > > fuse user daemon.
> >
> > I also noticed that and I admin that I don't understand it yet. The commit says
> >
> > <quote>
> >     The basic problem is that there can be no guarantee about the time in which
> >     the userspace filesystem will complete a write.  It may be buggy or even
> >     malicious, and fail to complete WRITE requests.  We don't want unrelated parts
> >     of the system to grind to a halt in such cases.
> > </quote>
> >
> >
> > Timing - NFS/cifs/etc have the same issue? Even a local file system has no guarantees
> > how fast storage is?
> 
> I don't have the details but it boils down to the fact that the
> allocation context provided by GFP_NOFS (PF_MEMALLOC_NOFS) cannot be
> used by the unprivileged userspace server (and even if it could,
> there's no guarantee, that it would).

I thought we had PR_SET_IO_FLUSHER for that. Requires
CAP_SYS_RESOURCES but no other privileges, then the userspace
server will then always operate in PF_MEMALLOC_NOIO |
PF_LOCAL_THROTTLE memory allocation context.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

