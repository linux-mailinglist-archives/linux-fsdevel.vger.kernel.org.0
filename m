Return-Path: <linux-fsdevel+bounces-15047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B71288655D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 04:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852122857E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 03:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79AF4A3E;
	Fri, 22 Mar 2024 03:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="fFcQNQQ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D143FEF
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 03:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711077500; cv=none; b=BjodcDqSgYcTbg9QAvCfvWrYYEKJTGWbH0quEpSuR2pSH3dDB380niy9YMd0GZAGYifZlc9p62z3thePVj3jcKYeIwRoa/umSGh2u4+S3oLYaa/O5/cZZS6d2jcfM1CpsUoOYsxoinEbHjZencwRbcFObI355+iTkDLT5ZqMqko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711077500; c=relaxed/simple;
	bh=Tpiqiv5LFq1Uvo1KeEvT4JCruYT5EDh1gq/p1Yn4NXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOs/4McdSN+xIPfYI4UaPpCgGRQvSsi5CSZdEEVQBeQDJM0WxKa28Y1F6f48TB4uf3BMSi743DBqN31DjwneSVgcAPojXhthbJR4FGPqFm3FSPlxTOLbaeRqD3CJ1+YVQQSQsiXJ4PC+8H8FGAVyledOliZ5XcVnOp7C3IkWQDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=fFcQNQQ4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ea7f2d093aso501280b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 20:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1711077498; x=1711682298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n84vaghGfbDLCoFpfil71Abo8071Ln4FsAGbxQu2tPw=;
        b=fFcQNQQ4APJfniIt/rro3b9otAtAY7CZ5furA2+3iuFEniUDfRmUrUFVzibyztAzJQ
         CJiUXMBRFWL6iwaYQAjbGDcHZOTAnjMx+PqTG7YuSa7idGYwSzTDtbsKLd6ST9r7BOp9
         orMAd8g0QltxuDOQ3e3tEnq+ipmil+vmKVasi2P5NCQM2X1ZOFt3N0oZLxn8VYudAYlF
         D/5AXngYyIoqs7DK4BEa4icmWc6l7bTVmoKvy8fq2x2OcxV0ETbyM5R1AzmVIuWtM1ex
         WK5iBPxdnz4/GD1EoFSkGPFis+kTpyTWgsHoJ8/anE1U+bwoOrLHcnR4NNmoQhIgv875
         XLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711077498; x=1711682298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n84vaghGfbDLCoFpfil71Abo8071Ln4FsAGbxQu2tPw=;
        b=CYTZVT/KpflWYfWGjg9WTjKH1nDKLO3b+cf9SKXtS0AZnytLgF2th6QqWv4fLOAD5q
         Jnt/P+VlWQG45+ZaadPX6ftCVBw8/Zu344H1Ftxva6KSfLCWiReUa9WAj9WAh1Uo3pKu
         XdIUSJjXE6PK9TXn0Ecr6nCkpGfkOF5OKXZgU0u4qzIsrmKpjIhm3UPRwRBV7bgot61E
         Vw8qjjw3JS3VGRDuPIK+iqkvP2z8X7vv1m06jQsiH40aUrxfFTTvOu58c4VKWYrccVvb
         sk5OBZqG7J/NMB2dz+F/QbuWMmaF1b7nsGWU0XZQrOSYKJnxXELBi9hsIWFFdxIW8S29
         KluA==
X-Forwarded-Encrypted: i=1; AJvYcCWPXXfpY95yFWdIysAV1p0KV6csjjUXGzgqALRVcT0OmfNcydV74VKlHyuPTxepiPECZROSb5bY0HPhdsuDqytJzBFO3jOG/UkMsEqJyQ==
X-Gm-Message-State: AOJu0Yw0cW0wpcLqvXErZ5/OP1F+3ENqva6ivYCWrS5qcJEe+G2i7qQS
	m0rioQaqlyFSIAWTTI8gubUdqS7Tc/VwYE/CwQKKsPdWrBQWzPtoyJ17CySz8XM=
X-Google-Smtp-Source: AGHT+IGlBISBZOl2AHGgNnki6HcX5k6G0GbLlF5Tla+rxx/OW7wqGuenHv++R8pDFbVQBt9lkwKjqQ==
X-Received: by 2002:a05:6a00:2d95:b0:6ea:7486:84ac with SMTP id fb21-20020a056a002d9500b006ea748684acmr1596494pfb.4.1711077497534;
        Thu, 21 Mar 2024 20:18:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-56-237.pa.nsw.optusnet.com.au. [49.181.56.237])
        by smtp.gmail.com with ESMTPSA id r11-20020aa79ecb000000b006ea6d1d3134sm585074pfq.119.2024.03.21.20.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 20:18:16 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rnVQ5-005aqD-2Y;
	Fri, 22 Mar 2024 14:18:13 +1100
Date: Fri, 22 Mar 2024 14:18:13 +1100
From: Dave Chinner <david@fromorbit.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
	jhubbard@nvidia.com, rcampbell@nvidia.com, willy@infradead.org,
	jgg@nvidia.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	djwong@kernel.org, hch@lst.de, david@redhat.com,
	ruansy.fnst@fujitsu.com
Subject: Re: ZONE_DEVICE refcounting
Message-ID: <Zfz4dT+YWpx5OYxM@dread.disaster.area>
References: <87ttlhmj9p.fsf@nvdebian.thelocal>
 <65f148866bc56_a9b42947@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <87y1ad776c.fsf@nvdebian.thelocal>
 <878r2c6t99.fsf@nvdebian.thelocal>
 <65fbcdaf2042f_aa222948c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <874jcz6ryu.fsf@nvdebian.thelocal>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jcz6ryu.fsf@nvdebian.thelocal>

On Fri, Mar 22, 2024 at 11:01:25AM +1100, Alistair Popple wrote:
> 
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > Alistair Popple wrote:
> >> 
> >> Alistair Popple <apopple@nvidia.com> writes:
> >> 
> >> > Dan Williams <dan.j.williams@intel.com> writes:
> >> >
> >> >> Alistair Popple wrote:
> >> >
> >> > I also noticed folio_anon() is not safe to call on a FS DAX page due to
> >> > sharing PAGE_MAPPING_DAX_SHARED.
> >> 
> >> Also it feels like I could be missing something here. AFAICT the
> >> page->mapping and page->index fields can't actually be used outside of
> >> fs/dax because they are overloaded for the shared case. Therefore
> >> setting/clearing them could be skipped and the only reason for doing so
> >> is so dax_associate_entry()/dax_disassociate_entry() can generate
> >> warnings which should never occur anyway. So all that code is
> >> functionally unnecessary.
> >
> > What do you mean outside of fs/dax, do you literally mean outside of
> > fs/dax.c, or the devdax case (i.e. dax without fs-entanglements)?
> 
> Only the cases fs dax pages might need it. ie. Not devdax which I
> haven't looked at closely yet.
> 
> > Memory
> > failure needs ->mapping and ->index to rmap dax pages. See
> > mm/memory-failure.c::__add_to_kill() and
> > mm/memory-failure.c::__add_to_kill_fsdax() where that latter one is for
> > cases where the fs needs has signed up to react to dax page failure.
> 
> How does that work for reflink/shared pages which overwrite
> page->mapping and page->index?

Via reverse mapping in the *filesystem*, not the mm rmap stuff.

pmem_pagemap_memory_failure()
  dax_holder_notify_failure()
    .notify_failure()
      xfs_dax_notify_failure()
        xfs_dax_notify_ddev_failure()
	  xfs_rmap_query_range(xfs_dax_failure_fn)
	     xfs_dax_failure_fn(rmap record)
	       <grabs inode from cache>
	       <converts range to file offset>
	       mf_dax_kill_procs(inode->mapping, pgoff)
	         collect_procs_fsdax(mapping, page)
		   add_to_kill_fsdax(task)
		     __add_to_kill(task)
		 unmap_and_kill_tasks()

Remember: in FSDAX, the pages are the storage media physically owned
by the filesystem, not the mm subsystem. Hence answering questions
like "who owns this page" can only be answered correctly by asking
the filesystem.

We shortcut that for pages that only have one owner - we just store
the owner information in the page as a {mapping, offset} tuple. But
when we have multiple owners, the only way to find all the {mapping,
offset} tuples is to ask the filesystem to find all the owners of
that page.

Hence the special case values for page->mapping/page->index for
pages over shared filesystem extents. These shared extents are

communicated to the fsdax layer via the IOMAP_F_SHARED flag
in the iomaps returned by the filesystem. This flag is the trigger
for the special mapping share count behaviour to be used. e.g. see
dax_insert_entry(iomap_iter) -> dax_associate_entry(shared) ->
dax_page_share_get()....

> Eg. in __add_to_kill() if *p is a shared fs
> dax page then p->mapping == PAGE_MAPPING_DAX_SHARED and
> page_address_in_vma(vma, p) will probably crash.

As per above, we don't get the mapping from the page in those cases.

If you haven't got access to the page though a filesystem method and
guaranteed that truncate() can't free it from under you, then you're
probably doing the wrong thing with fsdax...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

