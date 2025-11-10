Return-Path: <linux-fsdevel+bounces-67747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 542B3C493A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 21:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F563B0455
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 20:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380E72ECE9B;
	Mon, 10 Nov 2025 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="0DXESfE9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AA82EC579
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806506; cv=none; b=ssE4qvKQP2SVToGQ9bqgwAlEdxx0s4+MHaUXAozgyVbxf9Ig0g478q5XW4KdIXl7y+ekWlVKbyIT9O05U+dG1B1ysP5ESvi/T5COPK/ec+N/3gXuG8MQLC1n6WCtG3Y7F4TVjOKHWahf3P9cZcyYoo3z6hGNJN3YdhRw1oGEAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806506; c=relaxed/simple;
	bh=U2KPE+a4Gjk2w8tXO3gOnH3+aIIjVM+sZqVcF9kbiaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOR0SfC2lAFIqPSIEF8CtK4l4fHxrc4OlxXjIH7qm9odMjC/QbxjrARUL1LNm5So9f6sAtcgBhn4FQaQ+lUkeIc3osJb1ifeeYLlrg8ZWieknm70iMPTRnlt8cgCpNFZqEpji65RtVPrci1frZgggjVG+9+SngdgjuK4x2NDu6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=0DXESfE9; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-780fc3b181aso2935993b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 12:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1762806504; x=1763411304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/v36x1hAUlyKd1IieWoklJ8pc6DivsQnj+M0ePT6nI=;
        b=0DXESfE9IgF6uIMHPBfVhT9MYO+Z/zPM9nYObFd6wb7gLGzb8ZLekHfT8BI8+vA7yr
         46cdVNBO0kTI6DdJU+k9wLHyk4DAs/A0p0sxjXuZVUKzWFRE65xSPsLNVit5H/n2Ddhv
         hoCX0C2cYzbicMfZeFYjvnmox4Qqqdv92C/xmaX+O51kOAQEG6QSHAuFVFUN0EeSntOL
         JfN6WXtzX0r1BFI1UJu4rFi/8UgfbGM8v5vvUnyj54k2hjuqxysPmvxvpNp7ecCLJVi4
         wKE6B1+n9ehk7mhdrtPJPJnp9/bNyi+D+oYRiQ1GClslcmi2tBKXH6BLNmeiE650kITd
         rFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762806504; x=1763411304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/v36x1hAUlyKd1IieWoklJ8pc6DivsQnj+M0ePT6nI=;
        b=KIVUJUsgeiMnQHFsF1z3OGBmgY0ZPd00jCG2Egfp1oBq2VE5LpTRKBMnyrdGowU2x1
         OTH2Q2eUdMZNhrzitYdOqZqDkYe1k9Y2bosKYc6YqHglq4jFmqxCTSKCS0WOTivH+JYp
         VA1FsMH6oBNeMVfB34IYjb+a5dYB50fu2QCNFFjyFNCRoiG0xHfrg1zYy5L97d7uXmMj
         TXU9DfZmbpJwqZXbf3lYHlo1gKSRF9CaIHYUn3zM1WWRSx//K8uKFTGla0HGVnfepGoP
         u+pGpSANTcwu3rf2waF5QTXkaeGktKh1qFfy5Hf6nGcadfWjWHTp5KWWAfTYFtpu1MdQ
         bkHw==
X-Forwarded-Encrypted: i=1; AJvYcCUX7wjJF+YZEswufIyhErvqidvY/Yu0YIzfyVbRf+pgBW+Qui3oBujSIAG8xKDO1rbRRBp8+ktwy1g8e2hW@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBEt9FY1MLvMXcRq2zzRREmdvtPVKdGAV3kjWECkHZqibfcPc
	mvo3srylGjvWE2DwYsH+TtWkx+ST/d9bpJpjUL19G4LTf49oQUf1WfELqKwEKbaKweI=
X-Gm-Gg: ASbGncsaaqwv4XhINDdpCa+D6u0n4AuzOdRYx0jW45Iglw4HC2fwQU2/twIGpQMSob1
	ZiKuEQFy7+58UYYpC84OwVvAX8gfoTNqa4mf2qqV5m7/hxen8CfI0A26lrfZJZKdzuPD3WYHw9o
	HSBtB+8J4amvhvF36slCQtYrENMgKEL4l2S/HyhxybGi5kTAJZkhZDfUGmUQV1aDfRu7f0wN6P5
	y8izh1susUanL5zlNZKSH4ti7Wsu4f/5RSTUD5Bd1+/0jb3hvg3wIQtF8s8iSQ6t55kcUoHz+vi
	hnX732tX1ZbiYky87TbWZeGd8r2PN6QGaIvnZJ28BRdoKK5yxIq5m50ZRk7+NAPeGMrfyjh0a6r
	6i7X7cbUvLH55wr0lBjLIAOtHmA8Ojh+KKlxv2VWYADnmyHA3+VamunAHo3DKyZSvCK5+3Q0F30
	5bfe9Fdr9j1M6Hgz/JrI3zZ+UNcqrKlfepK1rml5pu36pcwLVCz2lK3VWbTWoK0g==
X-Google-Smtp-Source: AGHT+IH39E62oY2rb1DPACln6LUbVJT652sq3AEwuo4V3SoBL2oWZyT4qZRjdpQUUFk3spj6hUT/4Q==
X-Received: by 2002:a05:6a20:6a1d:b0:340:fce2:a15c with SMTP id adf61e73a8af0-353a0ba080amr10349273637.9.1762806504055;
        Mon, 10 Nov 2025 12:28:24 -0800 (PST)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953d0a6sm12689594b3a.12.2025.11.10.12.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 12:28:23 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vIYUu-000000094pP-2u7e;
	Tue, 11 Nov 2025 07:28:20 +1100
Date: Tue, 11 Nov 2025 07:28:20 +1100
From: Dave Chinner <david@fromorbit.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
Message-ID: <aRJK5LqJnrT5KAyH@dread.disaster.area>
References: <20251106133530.12927-1-hans.holmberg@wdc.com>
 <lhuikfngtlv.fsf@oldenburg.str.redhat.com>
 <20251106135212.GA10477@lst.de>
 <aQyz1j7nqXPKTYPT@casper.infradead.org>
 <lhu4ir7gm1r.fsf@oldenburg.str.redhat.com>
 <20251106170501.GA25601@lst.de>
 <878qgg4sh1.fsf@mid.deneb.enyo.de>
 <aRESlvWf9VquNzx3@dread.disaster.area>
 <lhuseem1mpe.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lhuseem1mpe.fsf@oldenburg.str.redhat.com>

On Mon, Nov 10, 2025 at 06:27:41AM +0100, Florian Weimer wrote:
> * Dave Chinner:
> 
> > On Sat, Nov 08, 2025 at 01:30:18PM +0100, Florian Weimer wrote:
> >> * Christoph Hellwig:
> >> 
> >> > On Thu, Nov 06, 2025 at 05:31:28PM +0100, Florian Weimer wrote:
> >> >> It's been a few years, I think, and maybe we should drop the allocation
> >> >> logic from posix_fallocate in glibc?  Assuming that it's implemented
> >> >> everywhere it makes sense?
> >> >
> >> > I really think it should go away.  If it turns out we find cases where
> >> > it was useful we can try to implement a zeroing fallocate in the kernel
> >> > for the file system where people want it.
> >
> > This is what the shiny new FALLOC_FL_WRITE_ZEROS command is supposed
> > to provide. We don't have widepsread support in filesystems for it
> > yet, though.
> >
> >> > gfs2 for example currently
> >> > has such an implementation, and we could have somewhat generic library
> >> > version of it.
> >
> > Yup, seems like a iomap iter loop would be pretty trivial to
> > abstract from that...
> >
> >> Sorry, I remember now where this got stuck the last time.
> >> 
> >> This program:
> >> 
> >> #include <fcntl.h>
> >> #include <stddef.h>
> >> #include <stdio.h>
> >> #include <stdlib.h>
> >> #include <sys/mman.h>
> >> 
> >> int
> >> main(void)
> >> {
> >>   FILE *fp = tmpfile();
> >>   if (fp == NULL)
> >>     abort();
> >>   int fd = fileno(fp);
> >>   posix_fallocate(fd, 0, 1);
> >>   char *p = mmap(NULL, 1, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> >>   *p = 1;
> >> }
> >> 
> >> should not crash even if the file system does not support fallocate.
> >
> > I think that's buggy application code.
> >
> > Failing to check the return value of a library call that documents
> > EOPNOTSUPP as a valid error is a bug. IOWs, the above code *should*
> > SIGBUS on the mmap access, because it failed to verify that the file
> > extension operation actually worked.
> 
> Sorry, I made the example confusing.
> 
> How would the application deal with failure due to lack of fallocate
> support?  It would have to do a pwrite, like posix_fallocate does to
> today, or maybe ftruncate.  This is way I think removing the fallback
> from posix_fallocate completely is mostly pointless.
> 
> >> I hope we can agree on that.  I expect avoiding SIGBUS errors because
> >> of insufficient file size is a common use case for posix_fallocate.
> >> This use is not really an optimization, it's required to get mmap
> >> working properly.
> >> 
> >> If we can get an fallocate mode that we can use as a fallback to
> >> increase the file size with a zero flag argument, we can definitely
> >
> > The fallocate() API already support that, in two different ways:
> > FALLOC_FL_ZERO_RANGE and FALLOC_FL_WRITE_ZEROS.
> 
> Neither is appropriate for posix_fallocate because they are as
> destructive as the existing fallback.

You suggested we should consider "implement a zeroing fallocate",
and I've simply pointed out that it already exists. That is simply:

	fallocate(WRITE_ZEROES, old_eof, new_eof - old_eof)

You didn't say that you wanted something that isn't potentially
destructive when a buggy allocation allows multiple file extension
operations to be performed concurrently. 

> > You aren't going to get support for such new commands on existing
> > kernels, so userspace is still going to have to code the ftruncate()
> > fallback itself for the desired behaviour to be provided
> > consistently to applications.
> >
> > As such, I don't see any reason for the fallocate() syscall
> > providing some whacky "ftruncate() in all but name" mode.
> 
> Please reconsider.  If we start fixing this, we'll eventually be in a
> position where the glibc fallback code never runs.

Providing non-destructive, "truncate up only" file extension
semantics through fallocate() is exactly what
FALLOC_FL_ALLOCATE_RANGE provides.

Oh, wait, we started down this path because the "fake" success patch
didn't implement the correct ALLOCATE_RANGE semantics. i.e. the
proposed patch is buggy because it doesn't implement the externally
visible file size change semantics of a successful operation.

IOWs, there is no need for a new API here - just for filesystems to
correctly implement the file extension semantics of
FALLOC_FL_ALLOCATE_RANGE if they are going to return success without
having performed physical allocation.

IOWs, I have no problems with COW filesystems not doing
preallocation, but if they are going to return success they still
need to perform all the non-allocation parts of fallocate()
operations correctly.

Again, I don't see a need for a new API here to provide
non-destructive "truncate up only" semantics as we already have
those semantics built into the ALLOCATE_RANGE operation...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

