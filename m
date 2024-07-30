Return-Path: <linux-fsdevel+bounces-24625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C53941B32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 18:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE201282CB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB54518B46E;
	Tue, 30 Jul 2024 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="WMAkSWml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83853189514
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358313; cv=none; b=tMacPz5ZsDLQ3wSJfK/Y8iTJsrgebqr5Y722dMRikdy4tyqA8DQ8FMYxw0rRROXV9klsqDRA/vOhznK4v/bSgtojZEtlqXkJtsfGxYKRWaFdrf5oopVQe6nlji84040WUNaGrsz/+tXzOChlH3yqoZ7dQ90AN8CbV+8h0vcrK9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358313; c=relaxed/simple;
	bh=5d6OI7h4OHmiQ6tMLwU1mLugYzOpWaHg0cCG8Q2bvnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qvje9wuWgtznFsZzm2NhgJs70GE7zgSZI4Zrd1Sfzyt8aevNYc0MIGbhxmGTEu7lbJ9RJHtV/pKEn01+9Z3kNE0wDLttIMLEsYJ98zSQ2J6pbDuRuKPgiAB4NM1mIEoaYwSBqc2eqz6CCsraMdMmkafB9LF+mCXs3toc47YlIIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=WMAkSWml; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-66acac24443so35575297b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 09:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722358310; x=1722963110; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N2XCQgEpuVmn0WdPUiJXoXeNWgP4VBI/PJdRvkP0yMM=;
        b=WMAkSWmlXKmNstHOcPXfK97YMkW5/RmnTGVozzYcdE1wio2Vl/VMS312vB9A+91Ucm
         o2Hls5pdEh14pY/DrJ8U8dr2zkVMSvEomLKXzT7iuzTN3jrz5d0escVsN773s6FY+Opk
         EozWsKXxtPhSO/MP5012y1z0TK0qhHW0eJBYufwvELB0GIiAPKALR/cFtFkq2pnOd3a/
         gM8leleMsGOwfVXCJpd0/L3NufUUjjJEvHvunND2G9ACWGbRKkKTGaVGn53tOCl2fhCY
         4Ye1EpYka0Kd+xhuRTuYuLzV02eFc+28nZaJKzrckb9vOwq5lImWElFf82cNZ7hyZt+0
         G5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722358310; x=1722963110;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2XCQgEpuVmn0WdPUiJXoXeNWgP4VBI/PJdRvkP0yMM=;
        b=ZOUKzsYGjoWwQi3rNO5l+OL6wtpaCOP6++WB/cz0YplNOfX9n/IBLqCGq2PYDSqLNL
         5/eyxZ5y7FAviYb10fKhb/bdSrqI30pluX4QrzmHv1htTVD8JmGr4/s97PmAxN2WNa8p
         v3oekIlZy3OA7LAUxbMcgxX9TQ1XP0jWyldwxOfCl/ms2CC+yfM/OyNOEeGpH8nHxbBA
         yNW/CzwaXqu9hyaGq/CyS1nvqiBUlGOcKxr/PFNXYl+UjxQvMEWmx+rEtGj7beIjPg0Y
         BXS7JwRmNHUF4cR0s4N31fFkVQeO3u2bmVX/Qd+7qo0lOFgiucNp3aGBPa/MaraXUhNE
         ZWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVHRAS1MUCFKi/APkYXhIQ/qJuLUaqjWKNVcJvpeDPkRmiC/gynHgBDlcG9dtI4O35VUbZaBq3iFQFj150ZBunX5EF2EnWRg0FrTla6A==
X-Gm-Message-State: AOJu0YzntRrN5GnkEPQG0AYJuGFOZzM8n+NFNcm0vf67UZ6huQk4NbEU
	khdFpFpJ5TjZiClbqXSYRCeWQTkXLrsRAZsiNR2wJfahz2yzM5eTWNcRjk9GB4M=
X-Google-Smtp-Source: AGHT+IEXO624WXqf4eUcX0w8nHFqiS+UMoBu+aGD+DWsJcqhDOaLtcJ/xmrLdE+oWp4W1o+3D2z+dg==
X-Received: by 2002:a0d:fe46:0:b0:650:82e0:63b1 with SMTP id 00721157ae682-67a0a13640bmr117998967b3.41.1722358310269;
        Tue, 30 Jul 2024 09:51:50 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd9059sm25815097b3.28.2024.07.30.09.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:51:49 -0700 (PDT)
Date: Tue, 30 Jul 2024 12:51:49 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH 10/10] fsnotify: generate pre-content permission event on
 page fault
Message-ID: <20240730165149.GA3828363@perftesting>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <1bc2855779e7ba1d80592be7d6257b43f1a91886.1721931241.git.josef@toxicpanda.com>
 <CAOQ4uxgXEzT=Buwu8SOkQG+2qcObmdH4NgsGme8bECObiobfTQ@mail.gmail.com>
 <20240729171120.GB3596468@perftesting>
 <CAOQ4uxjjBiPkg9uxyW12Xd+GZ7t3aP1m9Ayzr8WzqryfqK1x3g@mail.gmail.com>
 <20240730121837.fixxjcbbu7caxf2s@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240730121837.fixxjcbbu7caxf2s@quack3>

On Tue, Jul 30, 2024 at 02:18:37PM +0200, Jan Kara wrote:
> On Mon 29-07-24 21:57:34, Amir Goldstein wrote:
> > On Mon, Jul 29, 2024 at 8:11 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > > > If I am reading correctly, iomap (i.e. xfs) write shared memory fault
> > > > does not reach this code?
> > > >
> > > > Do we care about writable shared memory faults use case for HSM?
> > > > It does not sound very relevant to HSM, but we cannot just ignore it..
> > > >
> > >
> > > Sorry I realized I went off to try and solve this problem and never responded to
> > > you.  I'm addressing the other comments, but this one is a little tricky.
> > >
> > > We're kind of stuck between a rock and a hard place with this.  I had originally
> > > put this before the ->fault() callback, but purposefully moved it into
> > > filemap_fault() because I want to be able to drop the mmap lock while we're
> > > waiting for a response from the HSM.
> > >
> > > The reason to do this is because there are things that take the mmap lock for
> > > simple things outside of the process, like /proc/$PID/smaps and other related
> > > things, and this can cause high priority tasks to block behind possibly low
> > > priority IO, creating a priority inversion.
> > >
> > > Now, I'm not sure how widespread of a problem this is anymore, I know there's
> > > been work done to the kernel and tools to avoid this style of problem.  I'm ok
> > > with a "try it and see" approach, but I don't love that.
> > >
> > 
> > I defer this question to Jan.
> > 
> > > However I think putting fsnotify hooks into XFS itself for this particular path
> > > is a good choice either.
> > 
> > I think you meant "not a good choice" and I agree -
> > it is not only xfs, but could be any fs that will be converted to iomap
> > Other fs have ->fault != filemap_fault, even if they do end up calling
> > filemap_fault, IOW, there is no API guarantee that they will.
> > 
> > > What do you think?  Just move it to before ->fault(),
> > > leave the mmap lock in place, and be done with it?
> > 
> > If Jan blesses the hook called with mmap lock, then yeh,
> > putting the hook in the most generic "vfs" code would be
> > the best choice for maintenance.
> 
> Well, I agree with Josef's comment about a rock and a hard place. For once,
> regardless whether the hook will happen from before ->fault or from inside
> the ->fault handler there will be fault callers where we cannot drop
> mmap_lock (not all archs support dropping mmap_lock inside a fault AFAIR -
> but a quick grep seems to show that these days maybe they do, also some
> callers - most notably through GUP - don't allow dropping of mmap_lock
> inside fault). So we have to have a way to handle a fault without
> FAULT_FLAG_ALLOW_RETRY flag.
> 
> Now of course waiting for userspace reply to fanotify event with mmap_lock
> held is ... dangerous. For example consider application with two threads:
> 
> T1					T2
> page fault on inode I			write to inode I
>   lock mm->mmap_lock			  inode_lock(I)
>     send fanotify event			  ...
> 					  fault_in_iov_iter_readable()
> 					    lock mm->mmap_lock -> blocks
> 					      behind T1
> 
> now the HSM handler needs to fill in contents of inode I requested by the
> page fault:
> 
>   inode_lock(I) -> deadlock
> 
> So conceptually I think the flow could look like (in __do_fault):
> 
> 	if (!(vmf->flags & FAULT_FLAG_TRIED) &&
> 	    fsnotify_may_send_pre_content_event()) {
> 		if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
> 			return VM_FAULT_RETRY;
> 		fpin = maybe_unlock_mmap_for_io(vmf, NULL);
> 		if (!fpin)
> 			return ???VM_FAULT_SIGSEGV???;
> 		err = fsnotify_fault(...);
> 		if (err)
> 			return VM_FAULT_SIGBUS | VM_FAULT_RETRY;
> 		/*
> 		 * We are fine with proceeding with the fault. Retry the fault
> 		 * to let the filesystem handle it.
> 		 */
> 		return VM_FAULT_RETRY;
> 	}
> 
> The downside is that if we enter the page fault without ability to drop
> mmap_lock on a file needing HSM handling, we get SIGSEGV. I'm not sure it
> matters in practice because these are not that common paths e.g. stuff like
> putting a breakpoint / uprobe on a file but maybe there are some surprises.
> 

The only thing I don't like about this is that now the fault handler loses the
ability to drop the mmap sem.  I think in practice this doesn't really matter,
because we're trying to avoid doing IO while under the mmap sem, and presumably
this will have instantiated the pages to avoid the IO.

However if you use reflink this wouldn't be the case, and now we've
re-introduced the priority inversion possiblity.

I'm leaning more towards just putting the fsnotify hook in the xfs code for the
write case, and anybody else who implements their own ->fault without calling
the generic one will just have to do the same.

That being said I'm not going to die on any particular hill here, if you still
want to do the above before the ->fault() handler then I'll update my code to do
that and we can move on.  Thanks,

Josef

