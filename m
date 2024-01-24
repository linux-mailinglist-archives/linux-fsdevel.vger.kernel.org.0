Return-Path: <linux-fsdevel+bounces-8821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF10583B40E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 22:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B98288928
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 21:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291B81353FE;
	Wed, 24 Jan 2024 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KBOxGNne"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A0135A40
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132149; cv=none; b=Tl+CBbLClvddAU64IIyCMbt196R1erzvKug2Pr3ztK7LJdeGtS6eFk9W8+VDpVXIrQL5WgFYbIi2H3ZXmFHn+DDqbE1ubjFZC5/I5spNdTJu+QXbP700Xpz52HWxPjZSqm+sZA8GBGFuBZ8dgH6/zvB2oE6T3mrlf6vOQ2xyzK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132149; c=relaxed/simple;
	bh=V7IQ7kS9DUeRP/FT/fcLyqNVyWlyReqOBUD6v7RmObw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWcI2YYOXYk7ZBwsQBr+M88c6JCMs3lTXpXyauRgITMKcr1Vr4rrRc98HEsMqhaKfyiO+yRajfSenVPpq/wHXKEKXZj8wq4tpqHJgay7Q4scfT+JuCKMW4rpGS8d74ExM/XKu463YSNn2k2jVRSUBunmr4v0paCnnc9PMgbPASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KBOxGNne; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d780a392fdso11680635ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 13:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706132147; x=1706736947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aMr39s7BL1n4zra41P8sj/1JtJjUcultg6mOjC4I5sU=;
        b=KBOxGNne/hpgGjS75gYKlqR0K3jE1L1Rp5Ecd66IM0w/2PJGo7EAMYBBuFV9gefixw
         QcQ6JTxSeTIRdtuC/E0846J+4X3+h3cwbeZNKpXd69sYZYy7WpLkt+DTcL1r+c6jvNy8
         a+sst6tTlIJmJEFxdTnErBFMfRImkzNrEmikoa5EkEs2FLrzqZe/dXpsSXv4+01nTNSf
         0wnrI9FEhfG6qJfhYwoa3HyAw/p6PuqyERJSTaTLLIIo51df+ebu32q7udlKEkA/9WZh
         GoNsepuBkIiaQpnAMAK6l4/yNkLgy+jMst+FVDz6KZU9A+6SDV8FE2WzLeBHp1v4TPha
         9/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706132147; x=1706736947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMr39s7BL1n4zra41P8sj/1JtJjUcultg6mOjC4I5sU=;
        b=Uc0t0perJBQqM2bscPpWT2OvzxtHS40I6g2w0wzXZ1/YQfuILswVvqHQmlbSQ9GGgD
         IGRPXhQ9x4XwOClIGzENA3z8GWYSVgHQqoYZ2CMNU2R5Myaz+mh9P4YUseQaZ5Qus13C
         brlAgTS1Xejv9mbVhFCFy6psuggmO1ABSNSJeN+FCn/4CzmU4/xx4cNAY+jymlNokCeH
         yud4+oazHtcSES/i/C6aqV5eC26RAv/znUln6nYig4r57Qhg8vbqGVH0vfI90nrDdSpw
         AUyym0/tCnWAqNopiekP6ZCwRQb9n7q07SUKNzV29PwDI/nlTkfX69Yz0P3uyKqy27Bo
         X5dA==
X-Gm-Message-State: AOJu0YwyRjyUGEDZkdZDQ50GaIIMzhIt5ysn86y5MiD0EhIBaYb/f4Eg
	4S5lkE+67HFU/J7gpiy9yQEYTB7Hvde1UOU3V4u3+6CKp7w1h7x7uW7fsJweREY=
X-Google-Smtp-Source: AGHT+IESUrGRV0tW1GPQVzNb0q5Hn0gCv2tMlNaVfVybHYCu+xkL4mFhwBRLwZrgNR9/Ms47rlsq7Q==
X-Received: by 2002:a17:903:2306:b0:1d7:6feb:b0b4 with SMTP id d6-20020a170903230600b001d76febb0b4mr37100plh.19.1706132147403;
        Wed, 24 Jan 2024 13:35:47 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id ki3-20020a170903068300b001d74048eb5dsm6374547plb.89.2024.01.24.13.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:35:47 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rSkuO-00EpGT-1h;
	Thu, 25 Jan 2024 08:35:44 +1100
Date: Thu, 25 Jan 2024 08:35:44 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	"linkinjeon@kernel.org" <linkinjeon@kernel.org>,
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] exfat: fix file not locking when writing zeros in
 exfat_file_mmap()
Message-ID: <ZbGCsAsLcgreH6+a@dread.disaster.area>
References: <PUZPR04MB63168A32AB45E8924B52CBC2817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ZbCeWQnoc8XooIxP@casper.infradead.org>
 <PUZPR04MB63168DC7A1A665B4EB37C996817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZPR04MB63168DC7A1A665B4EB37C996817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>

On Wed, Jan 24, 2024 at 10:05:15AM +0000, Yuezhang.Mo@sony.com wrote:
> From: Matthew Wilcox <willy@infradead.org> 
> Sent: Wednesday, January 24, 2024 1:21 PM
> To: Mo, Yuezhang <Yuezhang.Mo@sony.com>
> Subject: Re: [PATCH] exfat: fix file not locking when writing zeros in exfat_file_mmap()
> > On Wed, Jan 24, 2024 at 05:00:37AM +0000, mailto:Yuezhang.Mo@sony.com wrote:
> > > inode->i_rwsem should be locked when writing file. But the lock
> > > is missing when writing zeros to the file in exfat_file_mmap().
> > 
> > This is actually very weird behaviour in exfat.  This kind of "I must
> > manipulate the on-disc layout" is not generally done in mmap(), it's
> > done in ->page_mkwrite() or even delayed until we actually do writeback.
> > Why does exfat do this?
> 
> In exfat, "valid_size" describes how far into the data stream user data has been
> written and "size" describes the file size.  Return zeros if read "valid_size"~"size".
> 
> For example,
> 
> (1) xfs_io -t -f -c "pwrite -S 0x59 0 1024" $filename
>      - Write 0x59 to 0~1023
>      - both "size" and "valid_size" are 1024
> (2) xfs_io -t -f -c "truncate 4K" $filename
>      - "valid_size" is still 1024
>      - "size" is changed to 4096
>      - 1024~4095 is not zeroed

I think that's the problem right there. File extension via truncate
should really zero the bytes in the page cache in partial pages on
file extension (and likley should do it on-disk as well). See
iomap_truncate_page(), ext4_block_truncate_page(), etc.

Leaving the zeroing until someone actually accesses the data leads
to complexity in the IO path to handle this corner case and getting
that wrong leads directly to data corruption bugs. Just zero the
data in the operation that exposes that data range as zeros to the
user.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

