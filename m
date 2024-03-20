Return-Path: <linux-fsdevel+bounces-14926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D39E88195A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 23:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB231C216BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 22:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D909F8615C;
	Wed, 20 Mar 2024 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="EQwLo6qS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442F8614C
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972331; cv=none; b=T31vrXK2yWVTaHVLU7+w3PBmV76hxQt+WFLzIIol5a34XZcmNx7XmFZpWLihbrRC8VGCda0XwTlsMTo8flpqv4ZMtZ8hNQMsI9wGLDeCxe6XZdsVe40VyMLxH/mClvQqeBPuK4y7GCw75j5irZCNCiah2ZQJm4owS8i+bFFUFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972331; c=relaxed/simple;
	bh=Oeu7rdXWA4971bc3OxpDw1f3XuRP//T8cKHKOg1P2xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgIl8PARjQZLkqhltj3EFzv2NNqr0mjmepZxOkk9EwcICj4bvkPbde3EeMKI3gF/K0k3xyu6rajtJNgDWbnODxkmVfDnozklI5iIbANPCNRfcHmlDK9sVUpdtOu4QzXQP4qit70w/cxBGqS1LW1tMCMsvIggygVnJAM3JtQQdNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=EQwLo6qS; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a20792be16so131359eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1710972328; x=1711577128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eQ/e29WSSo3Aqpd4gclbExfI2Hkevo9pemMXbO02yFo=;
        b=EQwLo6qS1BL52ZOkoeWJJ/bsLAVdBPivCZ2SRuS+TcXyUFqS8FkqnFQnU03hXtygFe
         ubdnWe35OjQ2fRrP0eY0Ys+wydlthWAKMMTq6nEdkqvO+fe1+vlbDWzeitCDN+X/Ypjn
         M8KktPmq1crEdkGxnj18FDloS+hHHROQZx+gFjZ47xCRgmr25iQGHtwMqXMrAqHHpdER
         7YETul0u6ypochgEQdwQSzfctUHh5P9jPuKTdrWGWf0bAS8z99ZiBFiaukI9IvAb6aWH
         WsOmNvIeajNZEZYFURRUhbSKNcwzORZBuW+zEaV8DSP5eWDhKcq1Ln9sj1opZYwm91vi
         SPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972328; x=1711577128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQ/e29WSSo3Aqpd4gclbExfI2Hkevo9pemMXbO02yFo=;
        b=PAdLjSJvp8d+6AWkfApCQFYO6oL5GRifIkyGSIpHkAfP/2E5QnhtTjoS/e/IBDRnJ/
         56CYXLgQdZ7sDswf9LMoCzHZ46G8HfSLmXTH/JysaMZK9/frKjFb3EyPGJUBNx0ASPOc
         5WYkloL0YlbWfVKxBY1v/SByjb0/jeM/XsmPnKh3yiJB6sJgObMFiqkoyNHjqbCjy1sq
         IiLF/x/eaYq/64Exr1gtqjcAjzKy5rlFwat5sLs/57UIViP2peuLumGWleJvnSEPyWdK
         JOSIgtqcsw6GHgh8sba5mb2hBsSnn5fo+ApawKc4ha5exWhD/92WIE5r/DneSihE2qxE
         nRYw==
X-Gm-Message-State: AOJu0YxmQY6QfKAeUkg4ey6v0v6w2tq5MKylJoxSYWD1fT3nNHDEFUpE
	CfK80oK+suJw3/qFvjf2lk3o78ae+fcPE3ZSqBHCZvuX25l1TveDWM4wFEuoFe4LsP1yVP/RNf2
	c
X-Google-Smtp-Source: AGHT+IECNn224WfqyzUhNWe4oa7hGsI3QXINRaJ7Nnk0NPQbU1/9Ocv9UDNy8NG+eoeS2vtQc3wdUQ==
X-Received: by 2002:a05:6a20:54a4:b0:1a3:6f13:b11b with SMTP id i36-20020a056a2054a400b001a36f13b11bmr1254112pzk.4.1710971900438;
        Wed, 20 Mar 2024 14:58:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-185-123.pa.nsw.optusnet.com.au. [49.180.185.123])
        by smtp.gmail.com with ESMTPSA id z25-20020aa785d9000000b006e6c61b264bsm12207992pfn.32.2024.03.20.14.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 14:58:19 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rn3wu-004kqw-2B;
	Thu, 21 Mar 2024 08:58:16 +1100
Date: Thu, 21 Mar 2024 08:58:16 +1100
From: Dave Chinner <david@fromorbit.com>
To: Phillip Susi <phill@thesusis.net>
Cc: linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: Uneccesary flushes waking up suspended disks
Message-ID: <Zftb+PwS3GkKbCAv@dread.disaster.area>
References: <877cieqhaw.fsf@vps.thesusis.net>
 <Ze5fOTojI+BhgXOW@dread.disaster.area>
 <87h6h78uar.fsf@vps.thesusis.net>
 <ZfdyoJ90mxRLzELg@dread.disaster.area>
 <87r0g5ulgj.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0g5ulgj.fsf@vps.thesusis.net>

On Wed, Mar 20, 2024 at 08:38:52AM -0400, Phillip Susi wrote:
> Dave Chinner <david@fromorbit.com> writes:
> 
> > That's what I expected - I would have been surprised if you found
> > problems across multiple filesystems...
> 
> How do the other filesystems know they don't need to issue a flush?
> While this particular method of reproducing the problem ( sync without
> touching the filesystem ) only shows on ext4, I'm not sure this isn't
> still a broader problem.

It may well be a broader problem, but it's a filesystem
implementation issue and not a generic VFS issue. Unfortunately,
without knowly a lot about storage stacks and filesystem
implementations, it's hard to understand why this is the case.
I'll use XFS as an example of how a filesystem can know if it
needs to issue cache flushes or not on sync.

> Say that a program writes some data to a file.  Due to cache pressure,
> the dirty pages get written to the disk.

Now the filesystem is idle, with no dirty data or metadata.

In the case of XFS, this will begin the process of "covering the
log". This takes 60-90s (3 consecutive log sync worker executions),
and it involves the journal updating and logging the superblock and
writing it back to mark the journal as empty.

These log writes are integrity writes (REQ_PREFLUSH|REQ_FUA) and so
issuing a log write guarantee all data written and completed will be
stable on disk before the log write is -submitted-. This is
guaranteed via the pre-submission cache flush (REQ_PREFLUSH) that
provides completion-to-submission IO ordering via pre-flush
semantics. The log write itself is guaranteed to be stable on disk
before it completes (REQ_FUA), and so when the journal writes
complete, all data and metadata is guaranteed to be on stable
storage.

So while this covering process takes up to 90s after the last change
in memory has been written to disk, after the first 30s of idle
time, XFS has already issued cache flushes to ensure all data and
metadata is stable on disk.  The device can be safely powered down
at that time without concern.

Put simply: for general purpose filesystems, it's considered a bug
to leave data and/or metadata in volatile caches indefinitely,
because that guarantees data loss on crash and/or power failure will
occur...

> Some time later, the disk is
> runtime suspended ( which flushes its write cache ).

Which is a no-op on devices with XFS filesystems on them, because
the cache should already be clean.

> After that,
> someone does some kind of sync ( whole fs or individual file ).  Doesn't
> the FS *have* to issue a flush at that point?

No, because the filesystem often already knows that it is completely
clean on stable storage.
Hence we don't need to do anything when a sync is run, not even a
cache flush...

> Even though there is
> nothing in the disk's cache, the FS doesn't know that.

On the contrary: filesystems need to know if they are clean all the
way down to stable storage - the filesystem layer is what iprovides
the guarantees for user data integrity, so they *must* understand
and control the volatile caches below them in the storage stack
correctly.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

