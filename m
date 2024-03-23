Return-Path: <linux-fsdevel+bounces-15156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7562B88778B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 09:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B594282D39
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 08:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E314E559;
	Sat, 23 Mar 2024 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="SjG+N2M/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F2C2C80
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Mar 2024 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711183023; cv=none; b=B5lJtEIvh4g20AyEBHGixm4LxQqwwN6dUcI71VeKvdVI5Z9SI2hEQ3tH61OR7RTV5v175d7wBNTn8zs8ry+WWwdd4TaIYrctIsF9JOfHCbeIMc46jUD7IV8E+YgtsGTHISSt+6mxHeZc+xHt9RZlDajDh21GC43b3gkUHQY6fiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711183023; c=relaxed/simple;
	bh=dC2LVd7E5zdQAqiu3P+Z+4YHfA/h87oz31DMsqsVT8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bij+oYhJpR8qRO+QDv18IgiuX/k+SeUPkmOWJb9hSPpwx4V4OFYkX2EFsCA+j5zGpoY2vkWPYELEjFaYy1T948DIznMOY6ApdGsMhcl2StseNborZ08FJ9PJBIjQkOzRQyUd7UAM5s6Qdv4RYmLg0Oo1aNd5suKAaVcqS88lMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=SjG+N2M/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e740fff1d8so1985582b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Mar 2024 01:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1711183019; x=1711787819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vF3vNo64kH4a02tVggWkhE6KRsHgNRWYeYG1IoM8SWA=;
        b=SjG+N2M/Njf2FqDzuwcWWpNiN+O2Yqi7MzJ2PDTcPQik8guslNZ5PSC9ZVUxL9HM7I
         CwD9B1cZpxymEa0JR23RrSPJN4c/wDNf/1TUVwyq/xIAMjNPFvx0xuo3GH23qT8T2imC
         sLu6xFsG6wgZvTpUNamrXbeeyN1oEaEPtYjt+MkJsUtHMT8zUepNPdnprAE10fGAC+W1
         V0/DGFWEJsjezqkr4wh6m9Uu/NGCIAGa2n3sbje9qvWZZ440UMtSqkAyPxW/0MXArIXA
         B0rjtjpkUlGRXDj8thtsjhB0r9kQqasPCmIBDP5jOJs5yWzqV8K3eSnIh6v4G/9XjlRn
         A2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711183019; x=1711787819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vF3vNo64kH4a02tVggWkhE6KRsHgNRWYeYG1IoM8SWA=;
        b=hL7RNvHKN6LveIu6UfJZPfIpu0boAp4/g7UHp34/Vbx2RPWmZPTSGP51LK4DRuRDcU
         Tm+F78qwG9pZw9W4Ub27JL0kegAYwT8236/RrkG76znDxHNNu5yZtmAak0Vl5xryFblL
         3OzNGgBE8jMqeVpKnA1BTxYL5ZXzzY+fiLJpZDidpcM88l7tUv/SEYWcjUryw9sUQALS
         fmtrNgW6RQmESxHp5uVNunlLdEMTxo5GL5YYNVAYc7InvUYz/w1s7JYpdnaaHyqpDSQx
         snsjIqCyWYvYANNqghGNK9ArzQZxKHaYItr4uNQWNK0WOIef1y+tiRxkZqKqikkTW3kb
         GNzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW4odqPU2XgsYlTuHi3NmLYoiHvzdW5O/vX3ktGl54+tnfucztuMyd2TqPb0flXoY2CU28AwI4SKv6y/8AszSTd83yX2HD+nh+oc7hPQ==
X-Gm-Message-State: AOJu0YzaQOfy1nZM85GFjEKbay9GMnP7u0S2/CMCZCH8B+3EpSKzqkKz
	jymSSbI6GWcl39eJIVGozJwhJqERbvRujv46XB0U3UOqlsShd8arz+tgvMP8gmTYlt0fyxrbPM0
	v
X-Google-Smtp-Source: AGHT+IE2BKcIsrn58oJrONY7S6aLv36/GiLg+yhedsmIXCRtotLLYq1++f32J4q5rN2RF9skCU532w==
X-Received: by 2002:a05:6a20:1e41:b0:1a3:a984:4b8b with SMTP id cy1-20020a056a201e4100b001a3a9844b8bmr1465864pzb.50.1711183019249;
        Sat, 23 Mar 2024 01:36:59 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-56-237.pa.nsw.optusnet.com.au. [49.181.56.237])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902e88100b001db8f7720e2sm505903plg.288.2024.03.23.01.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 01:36:58 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rnws3-0071X6-0D;
	Sat, 23 Mar 2024 19:36:55 +1100
Date: Sat, 23 Mar 2024 19:36:55 +1100
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+7766d4a620956dfe7070@syzkaller.appspotmail.com>
Cc: chandan.babu@oracle.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_icwalk_ag
Message-ID: <Zf6Up3AbYnELO6P2@dread.disaster.area>
References: <000000000000a1ce0006144f7533@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a1ce0006144f7533@google.com>

On Sat, Mar 23, 2024 at 01:09:28AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11525d81180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
> dashboard link: https://syzkaller.appspot.com/bug?extid=7766d4a620956dfe7070
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7766d4a620956dfe7070@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
> ------------------------------------------------------
> kswapd0/89 is trying to acquire lock:
> ffff88814af18118 (&xfs_dir_ilock_class){++++}-{3:3}, at: xfs_reclaim_inode fs/xfs/xfs_icache.c:945 [inline]
> ffff88814af18118 (&xfs_dir_ilock_class){++++}-{3:3}, at: xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1631 [inline]
> ffff88814af18118 (&xfs_dir_ilock_class){++++}-{3:3}, at: xfs_icwalk_ag+0x1216/0x1aa0 fs/xfs/xfs_icache.c:1713
> 
> but task is already holding lock:
> ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6774 [inline]
> ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xb3f/0x36e0 mm/vmscan.c:7146
> 
> which lock already depends on the new lock.

#syz dup: possible deadlock in xfs_qm_dqget_cache_insert

-- 
Dave Chinner
david@fromorbit.com

