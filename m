Return-Path: <linux-fsdevel+bounces-37559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2E59F3CBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 22:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBE81886D49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C621D9A51;
	Mon, 16 Dec 2024 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="E/iRc5EN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB21D88DB
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383966; cv=none; b=Q/jzzDVb8MxGkV6Xtn7v9w3DlJdAU9PYi4v7Pea31R3Lo7t34fqIVB0dAtUxGLBS7QmqKZr9izd9q1J9LjemSzqbZ//+yfcGyMF7worKmiQ9y3sQFO2Sgiczd7UjVHI092ALau+1Y+wqI4zU7S74EIGIt29dqpGlwdiEYD0a/8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383966; c=relaxed/simple;
	bh=UgpGZxTf5UQdIYmtdIP8NZxHh5R9BQB6qq3HWNcsdqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzJ7zqUWe47CSz3HEzWmyvO0JeY/vjIVgpzO5uPYIlB78G+SQtG2LCrtiToQp1rP4gTcRLxv9srLvie/UXL1if4CWl0fO5sgpupKqFOomMh6jjV1EcdqJrI/mlZprW+er74ydODXnrxfxhzPMaBuEayKcNwBfoo5uJZebABusCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=E/iRc5EN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21636268e43so56222785ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 13:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1734383964; x=1734988764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wohT2F7jYZ35oimi/vbojDnE+U2A1uWaD+2RnW9eqbI=;
        b=E/iRc5ENQeKdHaUOHgdk6VoeKQHDbFgG7ajE/JYKq5GOOYThc2R7jpOOvlDPKKQ6Sn
         WoWPlhBCnbCDm0pqh0n/T0jGA8KngtvylIF2sKB1ruMz8fvDUZ8polovGumPwKNxFqOn
         QUVY3/lULGALVM9s0rsOtn4UWk+oZnRxGQc08wbCDhAdz8Dtd43R5PSk5tsUFmI28HXu
         LxZRBxmFxSYDEDGuQdHV6/oDGp/cyQJ1jmnA5gojrNgS6dXgd+LJ6tl+h0lwrzo1yqHP
         FYZLZqbu416c9/66QyUPL+V9B/aIdb0H9uOnQ0KoMna7XxRhfvMGiXtPcJlnIGakEwBB
         jO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734383964; x=1734988764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wohT2F7jYZ35oimi/vbojDnE+U2A1uWaD+2RnW9eqbI=;
        b=cxKcz31DixLgrenWLErx/H4twMGWCSS2zP60x0oc8t++MBuCVJ+kvHiWC0SDgD+Xkl
         UkDhTkckADQEX6YDpNqRir2YhD1hdRbcQjQPUrrZMAUg//b3JD9EPqZhTXp+zYArIZG7
         w0b0P7ZErhKvhsGhzCM80TMUAIY4Y6t6hQd2Badw/ta13Qu6vceQEn4XNROoLr7AU3L/
         1vcTHaKRPZUiMUEslJefm94TLl+69M40f1HJIiGHfJkWqTLmh2eFmzjj5dXVAgToCqp9
         KNCp1PnwXuKnOizgar14UXFGEpxRlP3oL9vGshKmRw87XQ5jWieZ5rBJfJaCoq3gWwcb
         a3Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXoehe7CevWSGH1eDPsUzYHLyJYrfWpKoq8HEhFHnx6CVVeEG0Z8aMhMy5dalfVbkO2CZQBCyajwYD8lvyZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ed1NpOUfpxhBdbANZqdUEePmHt+axy6D+UAog9ANyEo6bWlC
	Mz4DTT7t41qwxhI5WxPLG0nhxwzvaPp/Z52psaK8MR0h/Fy5oR0kftNBGeHlLm4=
X-Gm-Gg: ASbGncvd5HDWpN/sVIGxgyXA6lc7Enzos41R2005XwLS9Ci8Yw90KhcT6c/511LrJZX
	dVHoqkXR0ZcEJvvZmdGD77R66xvookclzPhyrvIaLd26eXI+suclx/JZSGpefn3u33vQnN4Fik7
	K2xf4o2NdITQY1Fu65W9xOrnl6c3IO97VHf4+/lvahpZn8Cf81rDkVcuFnIRj2wYew9UqURcJ2i
	QB+9hMTuBjpp1ER58lm89ImnWrZZ0jZVcArAoUzBk4pihL2ASi3DDlLXHREmViDu7Tcd8/0KjBH
	htZOAsmrGBIKy6TV4qOiDk/18FgAvg==
X-Google-Smtp-Source: AGHT+IHEsdhbCDgka5o47U5eofFnUtG2e7lMRgiPnk+cFgQez8mk5mBf/lRikZSBGI3uUJ0PbA0HZQ==
X-Received: by 2002:a17:902:ea0e:b0:216:5e6e:68cb with SMTP id d9443c01a7336-218929a1ec5mr162916225ad.16.1734383963721;
        Mon, 16 Dec 2024 13:19:23 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dccb88sm47461665ad.95.2024.12.16.13.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:19:23 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tNIUq-0000000BafX-1DYM;
	Tue, 17 Dec 2024 08:19:20 +1100
Date: Tue, 17 Dec 2024 08:19:20 +1100
From: Dave Chinner <david@fromorbit.com>
To: Tianxiang Peng <luminosity1999@gmail.com>
Cc: chandan.babu@oracle.com, djwong@kernel.org, p.raghav@samsung.com,
	mcgrof@kernel.org, brauner@kernel.org, dchinner@redhat.com,
	Tianxiang Peng <txpeng@tencent.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	allexjlzheng@tencent.com, flyingpeng@tencent.com
Subject: Re: [PATCH 0/2] xfs: make cluster size tunnable for sparse allocation
Message-ID: <Z2CZWNT_SLeoBNJi@dread.disaster.area>
References: <20241216130551.811305-1-txpeng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216130551.811305-1-txpeng@tencent.com>

On Mon, Dec 16, 2024 at 09:05:47PM +0800, Tianxiang Peng wrote:
> This patch series makes inode cluster size a tunnable parameter in
> mkfs.xfs when sparse allocation is enabled, and also makes xfs use
> inode cluster size directly from the superblock read in rather than
> recalculate itself and verify.
> 
> Under extreme fragmentation situations, even inode sparse allocation
> may fail with current default inode cluster size i.e. 8192 bytes. Such
> situations may come from the PUNCH_HOLE fallocation which is used by
> some applications, for example MySQL innodb page compression. With xfs
> of 4K blocksize, MySQL may write out 16K buffer with direct I/O(which
> immediately triggers block allocation) then try to compress the 16K
> buffer to <4K. If the compression succeeds, MySQL will punch out the
> latter 12K, leave only the first 4K allocated:
> 	after write 16k buffer: OOOO
> 	after punch latter 12K: OXXX
> where O means page with block allocated, X means page without.
> 
> Such feature saves disk space(the 12K freed by punching can be used
> by others), but also makes the filesystem much more fragmented.
> Considering xfs has no automatic defragmentation mechanism, in the
> most extreme cases, there will be only 1-3 physically continuous
> blocks finally avaliable.
> 
> For data block allocation, such fragmentation is not a problem, as
> physical continuation is not always required. But inode chunk
> allocation requires so. Even for sparse allocation, physical
> continuation has also to be guaranteed in a way. Currently this
> value is calculated from a scaled inode cluster size. In xfs, inodes
> are manipulated(e.g. read in, logged, written back) in cluster, and
> the size of that cluster is just the inode cluster size. Sparse
> allocation unit currently is calculated from that:
> 	(inode size / MIN_INODE_SIZE) * inode cluster size
> 		-> sparse allocation aligmnet
> 			-> sparse allocation unit
> For example, under default mkfs configuration(i.e. crc and sparse
> allocation enabled, 4K blocksize), inode size is 512 bytes(2 times
> of MIN_INODE_SIZE=256 bytes), then sparse allocation unit will be
> 2 * current inode cluster size(8192 bytes) = 16384 bytes, that is
> 4 blocks. As we mentioned above, under extreme fragmentation, the
> filesystem may be full of 1-3 physically continuous blocks but can
> never find one of 4, so even sparese allocation will also fail. If
> we know application will easily create such fragmentation, then we
> had better have a way to loose sparse allocation requirement manually.

Please go an study mkfs.xfs -i align=1 does, how it affects
sb->s_inoalignmnt, and how that then affects sparse inode cluster
size and alignment. i.e.  Sparse inode clusters must be correctly
aligned and they have a fixed minimum size, so we can't just
arbitrarily select a sparse cluster size like these patches enable a
user to do.

> This patch series achieves that by making the source of sparse
> allocation unit, inode cluster size a tunnable parameter.

Fundamentally, I think this is the wrong way to solve the
problem because it requires the system admin to know ahead of time
that this specific database configuration is going to cause
fragmentation and inode allocation issues.

Once the problem manifests, it is too late to run mkfs to change the
geometry for the fs, so we really need to change the runtime
allocation policy code to minimise the impact of the data
fragmentation as much as possible.

As to that policy change, it has been discussed here:

https://lore.kernel.org/linux-xfs/20241104014439.3786609-1-zhangshida@kylinos.cn/

and my preferred generic solution to the problem is to define the
high AG space as metadata preferred, thereby preventing data
allocation from occurring in it until all other AGs are full of
data.

I'm still waiting to hear back as to whether the inode32 algorithm
behaves as expected (which uses metadata preferred AGs to direct
data to fill high AGs first) before we move forward with a
allocation policy based fix for this workload issue. If you can
reproduce the issue on demand, then perhaps you could also run the
same experiement - build a 2TB filesystem with ~300 AGs mounted
with inode32 and demonstrate that the upper AGs are filled to near
full before data spills to the lower AGs.

If inode32 behaves as it should under the mysql workload, then it
seems like a relatively trival tweak to the AG setup at mount time
to always reserve some space in the high AG(s) for inode allocation
and hence largely mitigate this problem for everyone....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

