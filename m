Return-Path: <linux-fsdevel+bounces-39219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFF6A11672
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 02:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDFC188B1CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 01:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D5F2E630;
	Wed, 15 Jan 2025 01:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="gINc097W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273681BDC3
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736904105; cv=none; b=rYBQ6Os1fy6hfHQCV6T1nFG2C7OioWjIBE9w2EgwLFd+SJTirNn3iB8z2S0c3Zu213k9FHlVVWVOmiqfrotDpmu1WZNcmE9/Jh7m7AxAUUb9lcWka5sJxe1VwKa7pYaoaMj3/XU9u8T8UEOobxzp5Lx2Ss2eKxxQ+aX0F8+d5e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736904105; c=relaxed/simple;
	bh=vMGmE8pQCf6eTl0p/jiGTKWXDSrR2+1LJaoQBM6z/Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQoMKjphIXjZ2PCf2OKGUsICb8heBcwrkR6wug072qLSWeavD2JvodFPRoFTirKlPABN1W8vLaRhuqeUAZV7cRroMtHWt+SX+Gy8C971CoYORCe7kNOlTicfIuUHG8pIuv7h+cowPVn4QhWdGthRU+pfsCgTn9NJNoxNRQgvVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=gINc097W; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-219f8263ae0so101685195ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 17:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1736904101; x=1737508901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBOBPA8Ipngxc0B42kthsUrQ7FIam0y2QCMQkPQgvcc=;
        b=gINc097Wh9L+0EEa3XJHABAp62o2a+DD4ACB9YXkqTUEXyw/wfcT5QbQ78aDZCoUi4
         fsMBPShEOjj0ehGDKgcAWYsS1O1+ERPpppQiMsWWRXscpSZtMLNa2QYTOoLysn0JFBfe
         I1OaUym/G32w+FqEDCHukfS4OLrMsksq37qFudvx4jNGswVwBOgFjHKnHK1arLSAIDA2
         fYGCRvXtxvzejT/7TMpOYQByPtRfbktkrXhf5XpD9DcM++LJc2BhU6Wu+lOO2m10fRZ5
         yMBX+sTEYJEtnGXZC1nnhOXJNHXeNterQmuMm183ufUpruvj+tHTSYi4TpJrTw0eqNCf
         aZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736904101; x=1737508901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBOBPA8Ipngxc0B42kthsUrQ7FIam0y2QCMQkPQgvcc=;
        b=WOaEzS8670dDCEHKzjrFD5fN4WZFNhTVWS0gz2O6NzrVF5zwOylcipTx4c2BPn/Wqj
         Z3vDzflhhr4x4gPHPcFM9QBUabZbUPev17aNxNutOYMBHDxXoH/iudgs/tpD5WIPfqhe
         v/NwqWFmDm+SInWik27cg/as3U1++OFBdFTadHaZtbvcbczcp68phY67BIaghChUs38F
         f6H/E3RnY6UpLfBj7LS3ITQzzVbqTb1qxGMsS39QLx/dtOHu3/qna4rHnelPWhM8CNU4
         s3eIW2V9AAw7NPoBuZzXjB0ZAG8/kZHBjshkKODmgEtj39CfgwVJKNZzgaaHvUeTeFNu
         e1MA==
X-Forwarded-Encrypted: i=1; AJvYcCWIuovn3Q34UAa7obEa5uQHNVm5u+Yzk3FPGDsGFG7NjqhHzo87qZTosqBdy6SsUZ3DWLEVkAxejdxT7QB7@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEHJEVHXQAhTRubu3gCCBB0UljxAqkpfJ8fixtQUhtJ4h/3uW
	G/h6M0kdisYm3M5Nm4ygJDelnaq+gxcmvB8J5JVCOSgrYz66/R7FnBTNdeU5EWY=
X-Gm-Gg: ASbGncvMPE5WJdZ7opQPqkJ9l+DnuSIjGVjh4ObYH5rjHAzcrd6kKoEUErpgH8n0p+S
	9f/tQMErFwCi3jy8+Wos25x9/uPAl5iHpUdwOcRQ7v6fXCfXawx16m7N3amofDKhXFw3C9InYs7
	HPIVWijZuVL+YVceduINNk4Zx1Z1XsVOgO8GepvCR8WftwEFF8qjF9fNz6BNmVbisymHI+XjH48
	mZY8HpGlLsdX09rZeAfnMpUpEpM/QivqXTRLqt6eXd565xeSOQ1Wxw3lHreVczGMdf7bMj0Im+3
	8/wZaWadwnq9FoORKd240Z4Nxl961etj
X-Google-Smtp-Source: AGHT+IHuZaMET3OrKLCAUT+QNZSCbeemRrlNpVTGqf1GqmIeLz5Cfauklsp95HyiIXeV02U3eBuz/g==
X-Received: by 2002:a17:90b:2748:b0:2f1:30c8:6e75 with SMTP id 98e67ed59e1d1-2f5490e89e0mr33201668a91.32.1736904101339;
        Tue, 14 Jan 2025 17:21:41 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c17f949sm213531a91.17.2025.01.14.17.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 17:21:40 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tXs6D-00000005yrJ-1Q3m;
	Wed, 15 Jan 2025 12:21:37 +1100
Date: Wed, 15 Jan 2025 12:21:37 +1100
From: Dave Chinner <david@fromorbit.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Improving large folio writeback performance
Message-ID: <Z4cNoWIWnC7XwCT8@dread.disaster.area>
References: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>

On Tue, Jan 14, 2025 at 04:50:53PM -0800, Joanne Koong wrote:
> Hi all,
> 
> I would like to propose a discussion topic about improving large folio
> writeback performance. As more filesystems adopt large folios, it
> becomes increasingly important that writeback is made to be as
> performant as possible. There are two areas I'd like to discuss:
> 
> 
> == Granularity of dirty pages writeback ==
> Currently, the granularity of writeback is at the folio level. If one
> byte in a folio is dirty, the entire folio will be written back. This
> becomes unscalable for larger folios and significantly degrades
> performance, especially for workloads that employ random writes.

This sounds familiar, probably because we fixed this exact issue in
the iomap infrastructure some while ago.

commit 4ce02c67972211be488408c275c8fbf19faf29b3
Author: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Date:   Mon Jul 10 14:12:43 2023 -0700

    iomap: Add per-block dirty state tracking to improve performance
    
    When filesystem blocksize is less than folio size (either with
    mapping_large_folio_support() or with blocksize < pagesize) and when the
    folio is uptodate in pagecache, then even a byte write can cause
    an entire folio to be written to disk during writeback. This happens
    because we currently don't have a mechanism to track per-block dirty
    state within struct iomap_folio_state. We currently only track uptodate
    state.
    
    This patch implements support for tracking per-block dirty state in
    iomap_folio_state->state bitmap. This should help improve the filesystem
    write performance and help reduce write amplification.
    
    Performance testing of below fio workload reveals ~16x performance
    improvement using nvme with XFS (4k blocksize) on Power (64K pagesize)
    FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
    
    1. <test_randwrite.fio>
    [global]
            ioengine=psync
            rw=randwrite
            overwrite=1
            pre_read=1
            direct=0
            bs=4k
            size=1G
            dir=./
            numjobs=8
            fdatasync=1
            runtime=60
            iodepth=64
            group_reporting=1
    
    [fio-run]
    
    2. Also our internal performance team reported that this patch improves
       their database workload performance by around ~83% (with XFS on Power)
    
    Reported-by: Aravinda Herle <araherle@in.ibm.com>
    Reported-by: Brian Foster <bfoster@redhat.com>
    Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
    Reviewed-by: Darrick J. Wong <djwong@kernel.org>


> One idea is to track dirty pages at a smaller granularity using a
> 64-bit bitmap stored inside the folio struct where each bit tracks a
> smaller chunk of pages (eg for 2 MB folios, each bit would track 32k
> pages), and only write back dirty chunks rather than the entire folio.

Have a look at how sub-folio state is tracked via the
folio->iomap_folio_state->state{} bitmaps.

Essentially it is up to the subsystem to track sub-folio state if
they require it; there is some generic filesystem infrastructure
support already in place (like iomap), but if that doesn't fit a
filesystem then it will need to provide it's own dirty/uptodate
tracking....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

