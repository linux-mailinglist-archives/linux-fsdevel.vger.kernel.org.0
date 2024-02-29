Return-Path: <linux-fsdevel+bounces-13148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936C586BD04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 01:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E28286D92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 00:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC622D048;
	Thu, 29 Feb 2024 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="GwDx+Nw8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B270E2CCA7
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167975; cv=none; b=ARkPGRwXMX7uLnRjx7uM9i2wa4fIZZNAEX5VQtuBRqoPNr7fqpAr1+mqeKYQ6s0cLbJcroHtCJxm1tUp7zdJUhWSnxgnJh3oM8xw62LWiIRLRliaHmAr1Ih+1QdZbEOAGdFFl2TP4iZh7wFhzHeB4DYUxBclSDlWiFhK9FBIAOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167975; c=relaxed/simple;
	bh=niqHhmhk0IJhg9e4h5p+6cpdCGnaxAZDcfsfhFj/+aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMz58t7cBv5C0FhM+w7rSufuZc6AWeX2lUsa5V7ghDwaAp84MZeVE6Zy03eDzBKjVGs2vs7EuWRY2R3gEJ/w+fFsdziPXPUZnH68UJtD0LiCEBb8fbPeUAyUn0bG1294kRdlThe7TvJqmCJD7ICg7v9OE6hqsiS6PTVvMVW4/54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=GwDx+Nw8; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso310530a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 16:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709167973; x=1709772773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bRPtOHA8q7w11Gt6w0XsUApI979ncB9qZgRk4xQ8tKE=;
        b=GwDx+Nw8AbN4Ntxpa58Jriscbw70H3C80dxfXF6aDlybGAzofNC2pVaBmlSD/nJQ2t
         b5b2BsDprjVOUQyqjlhN7+zemoiAaC0p1DyR2k3BXJcOv1Pc/st4vQ8P89Qxe3p0kJzm
         ouFl5CM0g5bWBZXa3x+5jR+DW7CxYi35+7zSvWP0PX00xTe3/Oblgo75CIHOIBdRxmtI
         w4/262+mPM1iZ8uM1fka6cGFnF919gj1q2oIUQaWCN6ss9fWdvCemVpPhnMwbvMBAj2K
         nXNbAa1NcevMZwCTyngtjYigiDg8p076HgtAv/8JZtAKwW/58mFXOHiZz9euwOI0BLq3
         xU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709167973; x=1709772773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRPtOHA8q7w11Gt6w0XsUApI979ncB9qZgRk4xQ8tKE=;
        b=Sixy+ByfFEWn+aDUyoodiDyUq0/fGrPvDWxEHJuaaooV3tb+GWwFeNYzk+KmIOCs4o
         gvDzAvPK0LRN9A4R79zywtqV92DKCNR3WZAvq42MLzou77XwLgeMLkmnVaA4EvIcE/PG
         +SEejKNK9I77E0g1Lf2Lp+wCdwe5OmubVc0Ko88gAmvt4otk8I+Y9VxlCn7uUHC31oom
         7f282QIegdIB2aD8gREgCcnH3HvMrRsKIFcYUGdRQfbPs7ucG00AsGHO6flJBkBKzYv5
         7uDxQyHfnbdgoYbMrs3oxi2juFZ8m9ecGjwXr/Ihfcg+f8DWC9CtsE5u9b8yTSli4fiB
         kkeg==
X-Forwarded-Encrypted: i=1; AJvYcCUD85+lBwqH5utEJb8Dpy9TR2mE+D+IYFQdMgbg9sLWAilbE2q4rq+xJcqxk6J/85mnWUbB9hdqX9HnXoP69nkHLO95jwE4c3/FZpOKaA==
X-Gm-Message-State: AOJu0YxC1BS6xYSZpfDSpiLqWVSsDRl1Jjt+2ASgDlHzQRnFudcQvV/H
	wXo3uqFhF1uo66q1rx5RzlxCUU3NuWkKJ24cDAGuGDdtbiP7bQNGj3fr3RZsEE0=
X-Google-Smtp-Source: AGHT+IHZv4R8vV5ScLj+kiQlb1IjyXUyFs5eHZ5CJYZuwZ8I//i8fTYXGEIJ7gBO+oRrEtqsW+SmGw==
X-Received: by 2002:a17:902:f60c:b0:1db:ff7b:d203 with SMTP id n12-20020a170902f60c00b001dbff7bd203mr696384plg.31.1709167972966;
        Wed, 28 Feb 2024 16:52:52 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903120800b001dcc129cc2esm77221plh.60.2024.02.28.16.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:52:52 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rfUfK-00CtAZ-07;
	Thu, 29 Feb 2024 11:52:50 +1100
Date: Thu, 29 Feb 2024 11:52:50 +1100
From: Dave Chinner <david@fromorbit.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
Message-ID: <Zd/VYiB0GyNjNB/J@dread.disaster.area>
References: <20240228061257.GA106651@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228061257.GA106651@mit.edu>

On Wed, Feb 28, 2024 at 12:12:57AM -0600, Theodore Ts'o wrote:
> Last year, I talked about an interest to provide database such as
> MySQL with the ability to issue writes that would not be torn as they
> write 16k database pages[1].
> 
> [1] https://lwn.net/Articles/932900/
> 
> There is a patch set being worked on by John Garry which provides
> stronger guarantees than what is actually required for this use case,
> called "atomic writes".  The proposed interface for this facility
> involves passing a new flag to pwritev2(2), RWF_ATOMIC, which requests
> that the specific write be written to the storage device in an
> all-or-nothing fashion, and if it can not be guaranteed, that the
> write should fail.  In this interface, if the userspace sends an 128k
> write with the RWF_ATOMIC flag, if the storage device will support
> that an all-or-nothing write with the given size and alignment the
> kernel will guarantee that it will be sent as a single 128k request
> --- although from the database perspective, if it is using 16k
> database pages, it only needs to guarantee that if the write is torn,
> it only happen on a 16k boundary.  That is, if the write is split into
> 32k and 96k request, that would be totally fine as far as the database
> is concerned --- and so the RWF_ATOMIC interface is a stronger
> guarantee than what might be needed.
> 
> So far, the "atomic write" patchset has only focused on Direct I/O,
> where this stronger guarantee is mostly harmless, even if it is
> unneeded for the original motivating use case.  Which might be OK,
> since perhaps there might be other future use cases where they might
> want some 32k writes to be "atomic", while other 128k writes might
> want to be "atomic" (that is to say, persisted with all-or-nothing
> semantics), and the proposed RWF_ATOMIC interface might permit that
> --- even though no one can seem top come up with a credible use case
> that would require this.
> 
> 
> However, this proposed interface is highly problematic when it comes
> to buffered writes, and Postgress database uses buffered, not direct
> I/O writes.   Suppose the database performs a 16k write, followed by a
> 64k write, followed by a 128k write --- and these writes are done
> using a file descriptor that does not have O_DIRECT enable, and let's
> suppose they are written using the proposed RWF_ATOMIC flag. 

Not problematic at all, we're already intending to handle this
"software RWF_ATOMIC" situation for buffered writes in XFS via a
forced COW operation.  That is, we'll allocate new blocks for the
write, and then when the data IO is complete we'll do an atomic swap
of the new data extent over the old one. We'll probably even enable
this for direct IO on hardware that doesn't support REQ_ATOMIC so
that software can just code for RWF_ATOMIC existing for all types of
IO on XFS....

> In
> order to provide the (stronger than we need) RWF_ATOMIC guarantee, the
> kernel would need to store the fact that certain pages in the page
> cache were dirtied as part of a 16k RWF_ATOMIC write, and other pages
> were dirtied as part of a 32k RWF_ATOMIC write, etc, so that the
> writeback code knows what the "atomic" guarantee that was made at
> write time.   This very quickly becomes a mess.

The simplification of this is using a single high-order folio for
the RWF_ATOMIC write data, then there's just a single folio that
needs to be written back. RWF_ATOMIC alreayd has a constraint of
only being supported for aligned power of 2 IOs, so it matches
hig-order folio cache indexing exactly. We can then run RWF_ATOMIC
IO as a write-through operation (i.e.  fdatawrite_range()) and IO
completion will then swap the entire range with the new data.

Hence on return from the syscall, we have new data on disk, and the
only thing that we need to do to make it permanent is commit the
journal (e.g. via RWF_DSYNC or explicit fdatasync()). This largely
makes the software RWF_ATOMIC behave exactly the same as hardware
based direct IO RWF_ATOMIC. i.e. the atomic extent swap on data IO
compeltion is the data integrity pivot that provides the RWF_ATOMIC
semantics, not the REQ_ATOMIC bio flag...

Yes, I know that ext4 has neither COW nor high order folio support,
but that just means that ext4 needs to add high-order folio support
and whatever internal code it needs to implement write-anywhere data
semantics for software RWF_ATOMIC support.

> Another interface that one be much simpler to implement for buffered
> writes would be one the untorn write granularity is set on a per-file
> descriptor basis, using fcntl(2).  We validate whether the untorn
> write granularity is one that can be supported when fcntl(2) is
> called, and we also store in the inode the largest untorn write
> granularity that has been requested by a file descriptor for that
> inode.  (When the last file descriptor opened for writing has been
> closed, the largest untorn write granularity for that inode can be set
> back down to zero.)

fcntl has already been rejected for reasons (i.e. alignment is a
persistent inode property, not a ephemeral file property). The way
we intend to do this is via fsx.fsx_extsize hints and a
FS_XFLAG_FORCEALIGN control of a on-disk inode flag. This triggers
all the alignment restrictions needed to guarantee atomic writes
from the filesystem and/or hardware.

> I'd like to discuss at LSF/MM what the best interface would be for
> buffered, untorn writes (I am deliberately avoiding the use of the
> word "atomic" since that presumes stronger guarantees than what we
> need, and because it has led to confusion in previous discussions),
> and what might be needed to support it.

I think we're almost all the way there already, and that it is
likely this will already be scheduled for discussion at LSFMM...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

