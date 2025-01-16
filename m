Return-Path: <linux-fsdevel+bounces-39420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 800B9A13EBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 17:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA041640F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F7E22C9F7;
	Thu, 16 Jan 2025 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx5zAb9P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05231DDA17;
	Thu, 16 Jan 2025 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043565; cv=none; b=bhKDYSxVBjHhk96t1xT3PV2faTNaz57PweXsgKSIOyhr9oJk2S82uQOgXbvsY+DNXq6VtAygrqGLIXbWVHU4688Hd8+FyFH9IzrMpG8SwYKBalSUyr3OUAIkOZfw9OZzxToasW1CZr1iHp7XP0QWQFg0ZB3mCg3qksauAq2Hc70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043565; c=relaxed/simple;
	bh=wGjAkxNlNfMWfYhBXWkTb+tr/vegOfJqguOfkP7ndzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXWHLAK1mROkcZocu1302ZhXdPRZpUqEiUSIuPKYshizEmN9cxVLoow60uVH4j14I9X+0MpaVl6BGQGXL8ahanqaahRc5j1qiktQLWaR6p5j2OxDOm4f/8tUYJDpkoyHgeEdYgw1yvuqj8ITQI2N5m7Bav5VzeeGFjWwmVEjUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hx5zAb9P; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-215770613dbso14866585ad.2;
        Thu, 16 Jan 2025 08:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737043563; x=1737648363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+WqPhV7Nyyh9gf5ceF9ds73DoDeZ3VqzjEcPveU+tA=;
        b=Hx5zAb9P5+ky+T8yH3hNxPw6cLrcbzgEJY/UYzydWXpyZgC8lKO0OMR5mqxGLyY5uG
         JE+GGKnBWC9xN7buQmEoJElaIXSLXSfR0cUT+ezVCaSou1uQJxGhx6tIKn9HzuETrMBh
         qvgrefGoANOi7ipEnp2cCM8LvahGqJ5jcG7j7FFmpFMDe39fm9dst5w9wz2pYVb0kh/u
         DY1Iqp28ZcxWCp6XTRkAFtOMTcjJWvzfkAtHCjFeisN49UPMQJWqh9HDuF8tlGWiaUMg
         T9A/c5swais14SaD3aop8zppdEuMvGrr/oI5MKhkDsIC3Q5pt79xKTeCaupPaJXngR1f
         6lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737043563; x=1737648363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+WqPhV7Nyyh9gf5ceF9ds73DoDeZ3VqzjEcPveU+tA=;
        b=U1zFsuKYU+QtFIVUIxKL4dKrfPmFCewm4aAHDJ7REbV97gnYg9k6ufdkYb1DsVboyO
         lfX7JFqT8E7hUBMDgpWcaZBEkRzNtJ66aDMPxzQVjarsqhpMEqH0/p4N+JYsm55Wf9t/
         Xuk4VsGs5vO0TWBI4F8PwhztzJb4fGFe5Oks/FblSS7eAbky+BYE0hS2/7+Rs+ao95/j
         a9Br7hjg7Vlzghx111mX/jgvIZzwSZgzjjjj59jGteHEAxt3snYlL4Bt+OVOrSOxsNWr
         qOlraUs/p6LqeLg5eqJ1DV8v+CS5aHAh2GpLRILiZyivQ69iLc5QTSE+MFEvkxxnKaKr
         xwJg==
X-Forwarded-Encrypted: i=1; AJvYcCVE2U2UIT4GJuL4PwCa9bEHOn6NQiVHTnPTVwWLmkXUekixGD9SXbO1DpS+2Di0mfJCxsJ26TP6aU9EGbtT@vger.kernel.org, AJvYcCW++TjZcHaLUgHTre+5QTlwT+pDSah6YGIsWgWy7E3LZn0A7jMO/oP349cMeNOjJzigCrS1FuikKZOF+Fkl@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj1qOSMb1Xv8gMISY17uomGBM7xTaGY4Cu44+d4cpgjqiB5XTj
	2IF5X+hO55A3oQhUqjs+uvryIw4/KdviaBMmRZEBfNU0qHQzAIsY0yy//w==
X-Gm-Gg: ASbGncs7ST6BGK82tnq/9ldy1VSEdklVP5CsYJxDjVlsk/HyvGIDCiYFVd10YoyIsj9
	4o/M6Eooxyqw7Gw6jHy9njBIAc9z7WOa3N2yACYmvneGrzhlp03O/VY1RSwgui1f0akXMb0IhLQ
	bNdBqv/BpKVpQvxDT7/HJ5nBlZ81/EaA5Nf/SpG/2zGDacCzR4A5JTlpsqdlSxYEzFg2920i2PF
	TLgEBPTSh+dyZzpZ1//71lc8Dpc08Mhm+Vv4T4wyTpVQtgaRe4BbIjFa3kEJ5MWqpO/DA==
X-Google-Smtp-Source: AGHT+IG6G4/bgTk6C4+QqxKFuhA2iSXSQbqDIexA+rufjN251HRup57Q4JZZFN/a5CUl0x91k4a3zg==
X-Received: by 2002:aa7:88cd:0:b0:725:f097:ed21 with SMTP id d2e1a72fcca58-72d21f471d6mr43213862b3a.15.1737043562960;
        Thu, 16 Jan 2025 08:06:02 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bcc3234c4sm243113a12.19.2025.01.16.08.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:06:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 16 Jan 2025 08:05:59 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jan Kara <jack@suse.cz>
Cc: Jim Zhao <jimzhao.ai@gmail.com>, akpm@linux-foundation.org,
	willy@infradead.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/page-writeback: Consolidate wb_thresh bumping logic
 into __wb_calc_thresh
Message-ID: <897b426d-7ca7-4bfe-8342-d2af910f8202@roeck-us.net>
References: <20241121100539.605818-1-jimzhao.ai@gmail.com>
 <a0d751f8-e50b-4fa5-a4bc-bccfc574f3bb@roeck-us.net>
 <b4m3w6wuw3h6ke7qlvimly7nok4ymjvnej2vx3lnds3vysyopr@6b5bnifyst24>
 <64a44636-16ec-4a10-aeb6-e327b7f989c2@roeck-us.net>
 <mqe2boksd5ztaz7xyabyp4sbtufxthcnrbwrjayghe4hpfbp4w@wjqsm467sjp5>
 <0e5dc5f1-c2c2-4893-902b-4677c21a38c0@roeck-us.net>
 <2xndprbkr5k5qer4zb6ov35fa5ym7c36q6mcyapdh22ypqxivh@ahuvuqs47yd4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2xndprbkr5k5qer4zb6ov35fa5ym7c36q6mcyapdh22ypqxivh@ahuvuqs47yd4>

On Thu, Jan 16, 2025 at 03:56:57PM +0100, Jan Kara wrote:
...
> > 
> > Interesting. Is there some endianness issue, by any chance ? I only see the problem
> > with sheb (big endian), not with sh (little endian). I'd suspect that it is an
> > emulation bug, but it is odd that the problem did not show up before.
> 
> So far I don't have a good explanation. Let me write down here the facts,
> maybe it will trigger the aha effect.
> 
> 1) Ext2 stores the metadata in little endian ordering. We observe the
> problem with the first directory entry in the folio. Both entry->rec_len
> (16-bit) and entry->inode (32-bit) appear to be seen in wrong endianity
> 
> 2) The function that fails is ext2_check_folio(). We kmap_local() the folio
> in ext2_get_folio(), then in ext2_check_folio() we do:
> 
> 	ext2_dirent *p;
> 
> 	p = (ext2_dirent *)(kaddr + 0);
> 	rec_len = ext2_rec_len_from_disk(p->rec_len);
> 	^^^ value 3072 == 0x0c00 seen here instead of correct 0x000c
> 	this value is invalid so we go to:
> 	ext2_error(sb, __func__, "bad entry in directory #%lu: : %s - "
>                         "offset=%llu, inode=%lu, rec_len=%d, name_len=%d",
>                         dir->i_ino, error, folio_pos(folio) + offs,
>                         (unsigned long) le32_to_cpu(p->inode),
>                         rec_len, p->name_len);
> 
> 	Here rec_len is printed so we see the wrong value. Also
> le32_to_cpu(p->inode) is printed which also shows number with swapped byte
> ordering (the message contains inode number 27393 == 0x00006b01 but the
> proper inode number is 363 == 0x0000016b). This actually releals more about
> the problem because only the two bytes were swapped in the inode number
> although we always treat it as 32-bit entity. So this would indeed point
> more at some architectural issue rather than a problem in the filesystem /
> MM.
> 
> Note that to get at this point in the boot we must have correctly
> byteswapped many other directory entries in the filesystem. So the problem
> must be triggered by some parallel activity happening in the system or
> something like that.
> 
> 3) The problem appears only with MTD storage, not with IDE/SATA on the same
> system + filesystem image. It it unclear how the storage influences the
> reproduction, rather than that it influences timing of events in the
> system.
> 
> 4) The problem reliably happens with "mm/page-writeback: Consolidate wb_thresh
> bumping logic into __wb_calc_thresh", not without it. All this patch does
> is that it possibly changes a limit at which processes dirtying pages in
> the page cache get throttled. Thus there are fairly limited opportunities
> for how it can cause damage (I've checked for possible UAF issues or memory
> corruption but I don't really see any such possibility there, it is just
> crunching numbers from the mm counters and takes decision based on the
> result). This change doesn't have direct on the directory ext2 code. The only
> thing it does is that it possibly changes code alignment of ext2 code if it
> gets linked afterwards into vmlinux image (provided ext2 is built in). Another
> possibility is again that it changes timing of events in the system due to
> differences in throttling of processes dirtying page cache.
> 
> So at this point I don't have a better explanation than blame the HW. What
> really tipped my conviction in this direction is the 16-bit byteswap in a
> 32-bit entity. Hence I guess I'll ask Andrew to put Jim's patch back into
> tree if you don't object.

I agree that this is most likely an emulation problem (it would not be the
first one), so please go ahead.

Thanks,
Guenter

