Return-Path: <linux-fsdevel+bounces-69030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA52C6C034
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 00:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DEC035464E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 23:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0996F311C14;
	Tue, 18 Nov 2025 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="rKdfUEVi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64332FC024
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763508640; cv=none; b=Zjp72/AlApBAA8QZCkvBvDf1bOoXj9qGZqlO0vNiAmDLgWOIz2z1nfT+WQJQv7EdwO+kJT/Ua3JFskT2+u59fasxfgJ+XW1yfMPjiCff+zTzBXIvcpW3/qMIZnx+P8+6zBkmUxdt7KFkd23JhKNF+GoIcV38m1+KMhl+2CCbm/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763508640; c=relaxed/simple;
	bh=Ll890/m+4oA95x8d4X0J/e5b2OUfoKs6Dh9eC3XMaNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwnxRrR/HYFQi3lXUgeUgzgejtRbyRMWufS3Wsa8LBj9X80ucwD+0nAvm7DJiKymYP6bjoSwzt6AA+DqNNTz+OEGqfdLivKf5nqaaIl5xqPNB/1m8behTafwWgIovUVgsthpjbG20PMcszGwDICaBKUdgYoEr/8kM1FHhrnp7TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=rKdfUEVi; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34372216275so6698509a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1763508638; x=1764113438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MnIQ5czAIlDUTiRSsv9UfW61iWVDuRBQUnVcKZcJB1w=;
        b=rKdfUEViRk2eHns7ezpaBZ3rb6Xn7WELhxhLp9wibrXP37D45/opfQ8U/2wzneLYhX
         DQ+7yJTZg1ollHP+oUfyBZI59oSSk0ZNaittOqb35qxXB7TYcwqyWkl1mYc3GH5zdQQj
         DBpmc+wvoeVu45KKzzbWmimB+UiESiDxNl68cfSl0iCRpfZbmCZ8i37HM/G/rrPHkoNc
         GMinkDCJSMinucjmFt4pUg2qsRFxSAU+W1DBOcCF0bnw6eLIV3AFU5OOtcI2d0+EaLtZ
         UtHj0jNUF+ADLSBs01d3xl6rmfbMzWVob0j+RJIPAkZcpFOe85R2CIvTuWMo5/rNgalN
         KFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763508638; x=1764113438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnIQ5czAIlDUTiRSsv9UfW61iWVDuRBQUnVcKZcJB1w=;
        b=BCqqQj9e14NLYQPRHPCBsYR1M7u6pEeMvUFZ6l5oWFJrpYf5Dn+lsZ7eaOhsi393gB
         Ku6qWEx1io+ES0UE/uJ9sRXtSCVoZVyLa3pf/CXJjl1Pts9P5SUuvQ5h9itVk5hBFlcb
         nMjNQASJY+tOsF55zbYrxE235TvosVbnZgjJ/SYgHksXtKWpqP0iMHTS5I9j8IDpvOOG
         DQk7ISSHyhJ/51RSLrnGKZGOGL8SezrKBzn6/yfpErsew/EYB/sTINwZfS8HDcZR5Vnp
         1Dj391W5e/jMio1SCT5hvxvKjHkyVX4R+oEil6jHN3C8DpcEWag6fuIWXZ858BggVyIQ
         f7zA==
X-Forwarded-Encrypted: i=1; AJvYcCXLTxZgdEViu5YFWhWmqoCf96Ub3D36qp3QJeyMlB2H45d9kWO3VCF3OxZCoV4YbPC6FmiOpXOWGd002jLG@vger.kernel.org
X-Gm-Message-State: AOJu0YxmTVTSBCtTPOLSKfeI64ePu2iwIRdgeMzBhlYuPTdmAM95BHVR
	xVQnqUpmX5CmUFvWIIKERwkzzXAzB7oD/L+1Cx1wGy6F9JpbQ4MXn6sCt9M+fd00ROk=
X-Gm-Gg: ASbGncsxxjX7z4sqakR6XlQVxBvAba1ViJ0G3/9CVaRdPtb3HX1XOIBzm+scG1MhDTk
	i31pyLjcFhdkTOk/CVPdVxOalcxFMIe+nUojsgni33/ZzsALquuf3b7hyRAoHInkxdkDidIVkHn
	12q3KPHsJRmGVUnuFpFysgJZ14JiLerdZ1COH1WUbirbUz85fcijTDT/OAPVt7Vic/XmeuRMR/W
	G32perGvW2zKNXuJEX5gYEEp2IUsINvH0wXuko+0qA+yluDTxKLJ68bOajlzk490XqsenR2lA2b
	Iw3qshVG9ZpszPK22CmqwGsQcSz8uAkEAP815FHtaXIj08z+6exogYJDPvuMUOyIzIAXgMw3o6T
	o7fOnVVtzOLGMRNT3LUqWgTs35ybKj5qe2OzkL5lopd41npgX7j2Z1FPTPPdeFiQWCRwDr/rubB
	7VRVm6a/F+xOxzvxLp5AJfTne9ihhPS0osvyhL7GiVfvOBgyvEmK9JFdCL/y89+2+EDQjhx4EUG
	nkB4cLHnik=
X-Google-Smtp-Source: AGHT+IG0xrV617/K2Q2zctZIX2rlkSw5B1Jp1MywYakVFhxJ0IxXfb/aHGJIAHe675+ap1LI/Djfwg==
X-Received: by 2002:a17:90b:570c:b0:340:cb39:74cd with SMTP id 98e67ed59e1d1-345bd413f51mr358384a91.32.1763508637774;
        Tue, 18 Nov 2025 15:30:37 -0800 (PST)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345bc110a6dsm560282a91.14.2025.11.18.15.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 15:30:37 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vLV9e-0000000Ceqh-0jNc;
	Wed, 19 Nov 2025 10:30:34 +1100
Date: Wed, 19 Nov 2025 10:30:34 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	john.g.garry@oracle.com, tytso@mit.edu, dchinner@redhat.com,
	hch@lst.de, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
	martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] mm: Add PG_atomic
Message-ID: <aR0BmpbQe0s4B80S@dread.disaster.area>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
 <5f0a7c62a3c787f2011ada10abe3826a94f99e17.1762945505.git.ojaswin@linux.ibm.com>
 <aRSuH82gM-8BzPCU@casper.infradead.org>
 <87ecq18azq.ritesh.list@gmail.com>
 <aRcrwgxV6cBu2_RH@casper.infradead.org>
 <878qg32u3d.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qg32u3d.ritesh.list@gmail.com>

On Tue, Nov 18, 2025 at 09:47:42PM +0530, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Fri, Nov 14, 2025 at 10:30:09AM +0530, Ritesh Harjani wrote:
> >> Matthew Wilcox <willy@infradead.org> writes:
> >> 
> >> > On Wed, Nov 12, 2025 at 04:36:05PM +0530, Ojaswin Mujoo wrote:
> >> >> From: John Garry <john.g.garry@oracle.com>
> >> >> 
> >> >> Add page flag PG_atomic, meaning that a folio needs to be written back
> >> >> atomically. This will be used by for handling RWF_ATOMIC buffered IO
> >> >> in upcoming patches.
> >> >
> >> > Page flags are a precious resource.  I'm not thrilled about allocating one
> >> > to this rather niche usecase.  Wouldn't this be more aptly a flag on the
> >> > address_space rather than the folio?  ie if we're doing this kind of write
> >> > to a file, aren't most/all of the writes to the file going to be atomic?
> >> 
> >> As of today the atomic writes functionality works on the per-write
> >> basis (given it's a per-write characteristic). 
> >> 
> >> So, we can have two types of dirty folios sitting in the page cache of
> >> an inode. Ones which were done using atomic buffered I/O flag
> >> (RWF_ATOMIC) and the other ones which were non-atomic writes. Hence a
> >> need of a folio flag to distinguish between the two writes.
> >
> > I know, but is this useful?  AFAIK, the files where Postgres wants to
> > use this functionality are the log files, and all writes to the log
> > files will want to use the atomic functionality.  What's the usecase
> > for "I want to mix atomic and non-atomic buffered writes to this file"?
> 
> Actually this goes back to the design of how we added support of atomic
> writes during DIO. So during the initial design phase we decided that
> this need not be a per-inode attribute or an open flag, but this is a
> per write I/O characteristic.
> 
> So as per the current design, we don't have any open flag or a
> persistent inode attribute which says kernel should permit _only_ atomic
> writes I/O to this file. Instead what we support today is DIO atomic
> writes using RWF_ATOMIC flag in pwritev2 syscall.

Which, if we can't do with REQ_ATOMIC IO, we fall back to the
filesystem COW IO path to provide RWF_ATOMIC semantics without
needing to involve the page cache.

IOWs, DIO REQ_ATOMIC writes are simply a fast path for the atomic
COW IO path inherent in COW-capable filesystems.

This is no different for buffered RWF_ATOMIC writes. We need to
ingest the data into the page cache as a COW operation, then at
writeback time we optimise away the COW operations if REQ_ATOMIC IO
can be performed instead.

Using COW for buffered RWF_ATOMIC writes means don't need to involve
the page caceh at all - this can all be implemented at the
filesystem extent mapping and iomap layers....

> Having said that there can be several policy decision that could still be
> discussed e.g. make sure any previous dirty data is flushed to disk when a
> buffered atomic write request is made to an inode. 

We don't need to care about mixed dirty non-atomic/atomic data on the
same file if REQ_ATOMIC is used as an optimisation for COW-based
atomic IO.  Filesystems like XFS naturally separate COW and non-COW
extents. If we combine non-atomic and atomic data into a single
atomic update at writeback(be it COW or REQ_ATOMIC IO), then we
have still honoured the requested atomic semantics required to
persist the data. It just doesn't matter.

IMO, trying to hack atomic physical IO semantics through the page
cache creates all sorts of issues that simply don't exist when we
use the atomic overwrite paths present in modern COW capable
filesystems....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

