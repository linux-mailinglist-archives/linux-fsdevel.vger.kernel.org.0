Return-Path: <linux-fsdevel+bounces-17086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5783E8A783E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 01:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E471C22BE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 23:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD65513B7AF;
	Tue, 16 Apr 2024 23:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="unWi6W2m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12C313A3E8
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308537; cv=none; b=hhBgynRQ7k3XNn6bvtV7EIHzQt6f1xPT044yjWRDc3FxLcFAfG095O/ACDLxDcG3ANJAjbdh4KAn0E1hCr7neIOlH2rI/ZF9q1uaSwJoTEUaNK5hdWn2VVtKmFYoziDJwDXqnzKZgOcjrOkEMyju5McNNVUuAMrbKpKIZxmFTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308537; c=relaxed/simple;
	bh=pIdeMYNrMzBlbRxMzrHlxkby4o0Yd9ue1rGwdfoY+c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HR6SCOqarF0cYfYQxxL/Su3vZjleoMF25dto2t00hcNMve2tFRDQmbyLCre6zjmbpt/Idg5jjIBHDk+lMJCk/SOOggZHixE7Bae5NROHUtNvcqHd2tG3XnGdCRDcKBYuAAHA3pOdxuQBt5sOMi4EuKyPAzWTuKsyZpAW0cRmMwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=unWi6W2m; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-233f389a61eso2141743fac.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 16:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1713308535; x=1713913335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VyUenxBfFtcmwGbb9155aMEE/BR3/Y+XRnqfs75Xk/g=;
        b=unWi6W2mu3UYpU+c9zrW1xO0ZXyloGNiR/m8jAXu2f0v3g/+D9ol1J9Q5C5gwwtIvQ
         FXlA+/4WyeoMJwlqfEegPsnhUUWwU0GM8RsCeuJCow8WaSUKKNqrLtaoPUVb28DJmLYM
         IrDpVeZYlbejhdi8c90zlvuk4vx6rIq0NISCcnIe8qeg9EWRtWEs30EvzbNvotQ2YCi4
         APKySwh2ZC6QqOrfCXQE4r7eB0sLX21BnXA/KEzUPEYbQGOA3Ih5VmtnRDnPq2pAF0CX
         /lr+29aD6qLNqPLOfvz7sMzQNU5REvct5jkaTrtqpJQ6iP1VrJ/fEDTtj9L7IlXmu+EZ
         uuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713308535; x=1713913335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyUenxBfFtcmwGbb9155aMEE/BR3/Y+XRnqfs75Xk/g=;
        b=JrQATzcvhCAYtGxvPL+oArebm6l3lR7fCO077zn0mRw66TEKXSv0uY0KrTpDr0jvnp
         mhPD4zVVvnGWuc6QezelXIjgF1Vp0tOIpQ2drO43E8tDDfmcEfR4Vy+HNhASY41a81ti
         JVSNR0rpYksraaC168hgIW2ySKe0RFGq0FHq//XX+jE5IMOj48xfpcY3VXabRLByxN/S
         silMKg06QdX5w6A5pe6OSVQKW71ofUBiG60NbYVVUuWIcOLWf8fTZ29NCwyBmi+iLypP
         t3GJ6RAUwf1BU8MjFxyuBhum1gZ9EjuJlXbsTE6ZY42d+3iDYlpFkcjntsHQy7W24K7a
         HeCg==
X-Forwarded-Encrypted: i=1; AJvYcCVZA/dtcm4/qwEBtgaL22s2QgMHrCumWngnp+QcPuE93IKB+l65x24xbsT3520BrQry0pLIQpyR05VQ/u+MMHK9YRTHXDWb7y4BvIshAQ==
X-Gm-Message-State: AOJu0YwyWprS8tM9jTnye4Iex1C3O65SIipoC3lvZacW3Pr6ACjGFniH
	mjaa3R08nSi8qPrTpEM0pZbv8Bz2kugwpZJEU1IFllq78is34rYLs8Zg12QkFM0=
X-Google-Smtp-Source: AGHT+IHuloQ+UDZeluJWHUTYqtfsz0L1w5ePvqc5SGwiMGgoFB8RdMrShLhE2hp2VMrEEsA5TiKkmQ==
X-Received: by 2002:a05:6870:15c4:b0:235:458e:c8d0 with SMTP id k4-20020a05687015c400b00235458ec8d0mr2504312oad.45.1713308534686;
        Tue, 16 Apr 2024 16:02:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-56-237.pa.nsw.optusnet.com.au. [49.181.56.237])
        by smtp.gmail.com with ESMTPSA id ka42-20020a056a0093aa00b006e04ca18c2bsm9411790pfb.196.2024.04.16.16.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:01:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rwrnj-000W54-0A;
	Wed, 17 Apr 2024 09:01:19 +1000
Date: Wed, 17 Apr 2024 09:01:19 +1000
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+d88216a7af9446d57d59@syzkaller.appspotmail.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] possible deadlock in exfat_page_mkwrite
Message-ID: <Zh8DP48j0ECw5BeN@dread.disaster.area>
References: <000000000000145ce00616368490@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000145ce00616368490@google.com>

On Tue, Apr 16, 2024 at 06:14:20AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    66e4190e92ce Add linux-next specific files for 20240416
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15817767180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c247afaa437e6409
> dashboard link: https://syzkaller.appspot.com/bug?extid=d88216a7af9446d57d59
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/86891dae5f9c/disk-66e4190e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1ca383660bf2/vmlinux-66e4190e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bf6ff37d3fcc/bzImage-66e4190e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d88216a7af9446d57d59@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.9.0-rc4-next-20240416-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor.0/17125 is trying to acquire lock:
> ffff88805e616b38 (&sb->s_type->i_mutex_key#24){++++}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
> ffff88805e616b38 (&sb->s_type->i_mutex_key#24){++++}-{3:3}, at: exfat_page_mkwrite+0x43a/0xea0 fs/exfat/file.c:629

exfat_page_mkwrite() is taking the inode_lock() in the page fault
handler:

	folio_lock(folio);
	.....
	if (ei->valid_size < folio_pos(folio)) {
		inode_lock(inode);
		err = exfat_extend_valid_size(file, ei->valid_size, folio_pos(folio));
		inode_unlock(inode);
		if (err < 0) {
			ret = vmf_fs_error(err);
			goto out;
		}
	}

This is can deadlock in a couple of ways:

1. page faults nest inside the inode lock (e.g. read/write IO path)
2. folio locks nest inside the inode lock (e.g. truncate)
3. IIUC, exfat_extend_valid_size() will allocate, lock and zero new
folios and call balance_dirty_pages_ratelimited(). None of these
things should be done with some other folio already held locked.

As I've previously said: doing sparse file size extension in page
fault context is complex and difficult to do correctly. It is far
easier and safer to do it when the file is actually extended, and in
that case the context doing the extension takes the perf penalty of
allocaiton and zeroing, not the downstream application doing mmap()
operations on the (extended) file....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

