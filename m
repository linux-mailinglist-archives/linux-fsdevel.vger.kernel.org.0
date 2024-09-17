Return-Path: <linux-fsdevel+bounces-29612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 933F197B5B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 00:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E5F1F23C4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 22:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054EB17C9A7;
	Tue, 17 Sep 2024 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="GLy4aq7E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2D91607A4
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612078; cv=none; b=d4wJekt5fsOwWawQTb23jjTKaWGY7SPfWuyLmn7NQFUer0r2cXtwN/S4npjIrzaaacV7GisohnrAboyyhPOS1fYmba9AgoqGVVcaWxH1+rHRnSvBKCYcCNNODyVkexjxQIK9S/KsXOEiqMQy7vPl46iy6EL5MJpgPo/+pybWDQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612078; c=relaxed/simple;
	bh=EBE/kDYbk7dbdt1bwZQbkSfHD+9mMbCAVxtBBX4iXd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7E0KZpAc347ZHhcdVBvYAP65Wspzeof2gltiO2JRXtDSvBR6vrCN/zzCjCHjptbxaqkJ0BAAN3cnPD1KRhajrszLztb8pH7uFChQRpFFl0HncwnRDm3Xn+yCSrZ+yY0WhF4J0XdI09sXiufDdUzPKNH86jM4LqZyhrqtkNeBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=GLy4aq7E; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7db54269325so2415817a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 15:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726612076; x=1727216876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ccch/CYLhuEpupgCKar2vNrhn2tuHqzaZ85afBvK4mk=;
        b=GLy4aq7EVIZnz9mrA3JPZRvCxApyShjN4Wj7Qq3M7gnwM0YhDZ2Zq6VJKQnfFZoGgl
         XU6lp94UnvDLVdS/+nhTsceFmQgT/IRPfoBDcWeqxTJGOrDRLDApzLP9zNzM7N6a+NIo
         xPaZAAtjtst09mph6zpDWh4RHiPxTp0OtwgsKRYKYDWju691nFkonIneFdHWjcWLvDOs
         y9L3p+hCyL365/6RqIM7AtdvpqjVm87JleY7h0DloXuhRRI1pTknhc0LkCrNgNDHLKYo
         CQw32WR4MhoLt80tQUOAb0icz731QBiz5lx1u5Ul6v/8/Fvr82GdhEMwYlp/csGSrtmn
         WCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726612076; x=1727216876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccch/CYLhuEpupgCKar2vNrhn2tuHqzaZ85afBvK4mk=;
        b=CrPGiDgvsfiNADfpb3y7rC9zLuGGOWkuoDpcUrQOjTVlLW0KCBKlKA9fr8NNtDvGS5
         4Rnhj0jVHc8pPfgjxyQdL3Ll4jA75Pg5kGT0VQh6aOSczFOeYPeATuH1HbPwieUJ/uJz
         glCI//ofbS7udCWMMwxV2vE93By1mUNMN0s3q6qPaQIPiMdRAGcby/Vk1hX/ttVHVNt9
         ELVOwepPQzBLPT105ALfzBRjFeVMBG02s8+Csm/i+6SknncrcF6oPKHNH94nu/WTEmrm
         oHUrbYc188TTuW+ikU54NpMZLiuaZcTB6NjEpLBG7aAqtq/+kG7S+raBxreD4KtI+Jf/
         3kvg==
X-Forwarded-Encrypted: i=1; AJvYcCV6ViC3hM88I8bPSXJ0xjVYF1ohabRisd0JpI2NViGH0riJ7Vy9ihEX3Y/dhcJt57iSgZjEUAUAOEA7VG1v@vger.kernel.org
X-Gm-Message-State: AOJu0YyChLOMJAZuJKkICFWoDvRXIOB+2grm3GDvsl4gGYhJkSTl6eBP
	G0uNsShO3wIoAq/htqoUbGVqajo3TQ5Khbv40eiIN7+S4iDT2/LeiALa+QOTJdo=
X-Google-Smtp-Source: AGHT+IF0NtHcWGgQkVG/yMvHatmnpgG/DEnu8eXNlMFeupDDsk0kMCwvT1TDHdDTmoFzXGa/p8UhJg==
X-Received: by 2002:a05:6a21:a4c4:b0:1d2:e793:b35 with SMTP id adf61e73a8af0-1d2e7930d35mr5104220637.47.1726612076095;
        Tue, 17 Sep 2024 15:27:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a9809esm5583859b3a.39.2024.09.17.15.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 15:27:55 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sqgfp-006XwE-0D;
	Wed, 18 Sep 2024 08:27:53 +1000
Date: Wed, 18 Sep 2024 08:27:53 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, chandan.babu@oracle.com,
	djwong@kernel.org, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v4 00/14] forcealign for xfs
Message-ID: <ZuoCafOAVqSN6AIK@dread.disaster.area>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <87frqf2smy.fsf@gmail.com>
 <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <79e22c54-04bd-4b89-b20c-3f80a9f84f6b@oracle.com>
 <Ztom6uI0L4uEmDjT@dread.disaster.area>
 <ce87e4fb-ab5f-4218-aeb8-dd60c48c67cb@oracle.com>
 <Zt4qCLL6gBQ1kOFj@dread.disaster.area>
 <84b68068-e159-4e28-bf06-767ea7858d79@oracle.com>
 <ZufBMioqpwjSFul+@dread.disaster.area>
 <0e9dc6f8-df1b-48f3-a9e0-f5f5507d92c1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e9dc6f8-df1b-48f3-a9e0-f5f5507d92c1@oracle.com>

On Mon, Sep 16, 2024 at 10:44:38AM +0100, John Garry wrote:
> 
> > > * I guess that you had not been following the recent discussion on this
> > > topic in the latest xfs atomic writes series @ https://urldefense.com/v3/__https://lore.kernel.org/linux-xfs/20240817094800.776408-1-john.g.garry@oracle.com/__;!!ACWV5N9M2RV99hQ!JIzCbkyp3JuPyzBx1n80WAdog5rLxMRB65FYrs1sFf3ei-wOdqrU_DZBE5zwrJXhrj949HSE0TwOEV0ciu8$
> > > and also mentioned earlier in
> > > https://urldefense.com/v3/__https://lore.kernel.org/linux-xfs/20240726171358.GA27612@lst.de/__;!!ACWV5N9M2RV99hQ!JIzCbkyp3JuPyzBx1n80WAdog5rLxMRB65FYrs1sFf3ei-wOdqrU_DZBE5zwrJXhrj949HSE0TwOiiEnYSk$
> > > 
> > > There I dropped the sub-alloc unit zeroing. The concept to iter for a single
> > > bio seems sane, but as Darrick mentioned, we have issue of non-atomically
> > > committing all the extent conversions.
> > 
> > Yes, I understand these problems exist.  My entire point is that the
> > forced alignment implemention should never allow such unaligned
> > extent patterns to be created in the first place. If we avoid
> > creating such situations in the first place, then we never have to
> > care about about unaligned unwritten extent conversion breaking
> > atomic IO.
> 
> OK, but what about this situation with non-EOF unaligned extents:
> 
> # xfs_io -c "lsattr -v" mnt/file
> [extsize, has-xattr, force-align] mnt/file
> # xfs_io -c "extsize" mnt/file
> [65536] mnt/file
> #
> # xfs_io  -d -c "pwrite 64k 64k" mnt/file
> # xfs_io  -d -c "pwrite 8k 8k" mnt/file
> # xfs_bmap -vvp  mnt/file
> mnt/file:
> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>   0: [0..15]:         384..399          0 (384..399)          16 010000
>   1: [16..31]:        400..415          0 (400..415)          16 000000
>   2: [32..127]:       416..511          0 (416..511)          96 010000
>   3: [128..255]:      256..383          0 (256..383)         128 000000
> FLAG Values:
>    0010000 Unwritten preallocated extent
> 
> Here we have unaligned extents wrt extsize.
> 
> The sub-alloc unit zeroing would solve that - is that what you would still
> advocate (to solve that issue)?

Yes, I thought that was already implemented for force-align with the
DIO code via the extsize zero-around changes in the iomap code. Why
isn't that zero-around code ensuring the correct extent layout here?

> > FWIW, I also understand things are different if we are doing 128kB
> > atomic writes on 16kB force aligned files. However, in this
> > situation we are treating the 128kB atomic IO as eight individual
> > 16kB atomic IOs that are physically contiguous.
> 
> Yes, if 16kB force aligned, userspace can only issue 16KB atomic writes.

Right, but the eventual goal (given the statx parameters) is to be
able to do 8x16kB sequential atomic writes as a single 128kB IO, yes?

> > > > Again, this is different to the traditional RT file behaviour - it
> > > > can use unwritten extents for sub-alloc-unit alignment unmaps
> > > > because the RT device can align file offset to any physical offset,
> > > > and issue unaligned sector sized IO without any restrictions. Forced
> > > > alignment does not have this freedom, and when we extend forced
> > > > alignment to RT files, it will not have the freedom to use
> > > > unwritten extents for sub-alloc-unit unmapping, either.
> > > > 
> > > So how do you think that we should actually implement
> > > xfs_itruncate_extents_flags() properly for forcealign? Would it simply be
> > > like:
> > > 
> > > --- a/fs/xfs/xfs_inode.c
> > > +++ b/fs/xfs/xfs_inode.c
> > > @@ -1050,7 +1050,7 @@ xfs_itruncate_extents_flags(
> > >                  WARN_ON_ONCE(first_unmap_block > XFS_MAX_FILEOFF);
> > >                  return 0;
> > >          }
> > > +	if (xfs_inode_has_forcealign(ip))
> > > +	       first_unmap_block = xfs_inode_roundup_alloc_unit(ip,
> > > first_unmap_block);
> > >          error = xfs_bunmapi_range(&tp, ip, flags, first_unmap_block,
> > 
> > Yes, it would be something like that, except it would have to be
> > done before first_unmap_block is verified.
> > 
> 
> ok, and are you still of the opinion that this does not apply to rtvol?

The rtvol is *not* force-aligned. It -may- have some aligned
allocation requirements that are similar (i.e. sb_rextsize > 1 fsb)
but it does *not* force-align extents, written or unwritten.

The moment we add force-align support to RT files (as is the plan),
then the force-aligned inodes on the rtvol will need to behave as
force aligned inodes, not "rtvol" inodes.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

