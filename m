Return-Path: <linux-fsdevel+bounces-62037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26551B8231C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 00:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC7F2A23FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 22:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00BD3101BA;
	Wed, 17 Sep 2025 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="TAU1Xqlv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51F3285043
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149471; cv=none; b=ajjz0zBTm6CyW99TKpNPUIlsNEJKHfHfQE2wq1wG9Fpmy0IDXu3KxHEtIJoxVHqThtm4YgFTKaThFRNfXgqNXv4OoxIckQAKODH7BogWR2OdpIuVJ8C6X79h67YH3o9uvRbClnxvHCn30jz7rWi/L3xTNWW6NJchOxaKxywUhZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149471; c=relaxed/simple;
	bh=uXQN6FSQJnpjKMExP2GtxNzt35X+QqvTVhfhqwNmWL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQqsf7vmrezUeRMHimGTxuWd6uBYKWvfK8OH0dNhQ/TJ0fpink1Gq4g6IX8fS7VlpRtkr/ET2+AvkNeDl/s7/ckgsMlHcY6ZNrCL+lAdLZVr7eP6UltsvrMQ04xmm8F67yWH0+ydagJ9zNm/AMXxt2kE0lYGfijH6+TvFTOYwuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=TAU1Xqlv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77ce812f200so286081b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 15:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1758149468; x=1758754268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KiBmD6NJZU/wz6ZMowNVOrSIvY548tKi0Wxl6W6YNg4=;
        b=TAU1XqlvofEukbAmjo+VEdU5Mnx4ijqoqqVdK4YJmfIgs3W3oZ9Va28Y3p5GNmQqaP
         2eCsNtv73V9mqG8Vz4tGT1eaI04u3D6rgyZkkjQyadATFjWgJpvN162qHscx5AwDYfui
         5HVJQrD1tChDcQYEkpQaSnmLyxuBN5TH+oZ9tATUKM69Ydmtq1eFB0cWbAPqOm2eaUNc
         KBKxlO0assKAZ9UinfpobX+W7PxzbxLBVtlGeV5DH5I75vtlw2E2IKaDc6CBbVJAxQ1c
         ALFl3Hy7QQNzg96L5iWPxGBF6zCDv0gklfw8kJ33gJvlSO2eVl20VgOthX7j+YIpjpYO
         nB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758149468; x=1758754268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiBmD6NJZU/wz6ZMowNVOrSIvY548tKi0Wxl6W6YNg4=;
        b=IAKMOHaHSzFHarJMkgxGurBpuqfBh74HZymnE1khgKIxNt4YMF/4wSGMFZb7/z7+12
         hHkC40UEfJqpsHl4NXqTg8rlK/Gp9jKV1LmJKgNfYLLzodb69tTWvVz3UxNZcCEVM9PR
         ecGgrjRpbn9aUP2L68JQzXWtDJe87nt+pONeOKSzN9tw7lHaWzRF0CFiFMsWiK/6slDr
         /E7fexEEXqCKxH7Ihp4ONZIsOlvq+EQHl8aA9wuGHsDhilxNLXlFU9RqAi0i7UyxzvAi
         k6c2HbS7deyWsl3fk7I+a4Zf56ra2I7GI1B4/W4+xc5T2hVdzbABh59yeTyvCX+ZzebG
         ueTw==
X-Forwarded-Encrypted: i=1; AJvYcCVlPOt/gT6+DN7+X/rgkOIoVj2EDaoUXXaCeKbeMjBRMbUft2Qsd19Z0TjVHkFRt4GQLb724w7bFk2yhAdM@vger.kernel.org
X-Gm-Message-State: AOJu0YxxuaTTPVp4VTX9vjrC+oc48jUdaUaDq/K4qNTtgVMV5yg3pcnK
	TbDkk4F+WS3Sy88NptYA3ucmtlvZWsuwhkn6lIhpdcVizUOazXGdKrFYU6UcDrFILZK8HwGcd8z
	SurVy
X-Gm-Gg: ASbGncvNWbkkAVfq37a7pvXV80NU2h849615yyL3VNOyu7I0aVfTSw3cVlI6l319hsy
	aQ1TDs5bS1BkaMOBGIMasYURaaOW2I4nRxDq5H/n9G6ieESaF0F47EJh7aF4mqvKcSfHmyCku/8
	smD2Qfc27ViiWsFswGM242evMwtgRlpMoClt6KnqdoPiwWladEZb5mCGiXnbDAWWKOd5ak54sfh
	LizC5IkMVNHEPc8J23itiqjPp28sO0fX0rCxztv2LawG9Yi7vVeX4f2WLfy8srDsFahSVvjjZuh
	SmEPD8DyDcRmImasktL5CjnJfVXqfMhc5i4Go9cJZ6MuRRLNTTULNVShQCy4nOrkie8HRfJm5Ri
	pjKqvtREXhl48KYQpZtD0N7pSTaZm598/VnGm7IzGbzB8O2JkZXvc/4u01iCYhh/M294gm1uQjw
	sbz147wA==
X-Google-Smtp-Source: AGHT+IFwfCQkVNjD6CXMbnqb6iNxIizQ9+fDYixTv2KRx6v3UbkFCsyowVxUeZhQg3zfx+PNmkXznA==
X-Received: by 2002:a05:6a20:a127:b0:24d:d206:69ac with SMTP id adf61e73a8af0-284522d3d4fmr1738503637.14.1758149468140;
        Wed, 17 Sep 2025 15:51:08 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc248fa0sm454091b3a.30.2025.09.17.15.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:51:07 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uz0zR-00000003IYr-0zrK;
	Thu, 18 Sep 2025 08:51:05 +1000
Date: Thu, 18 Sep 2025 08:51:05 +1000
From: Dave Chinner <david@fromorbit.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com,
	amarkuze@redhat.com, ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls
 asynchronous
Message-ID: <aMs7WYubsgGrcSXB@dread.disaster.area>
References: <20250917124404.2207918-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917124404.2207918-1-max.kellermann@ionos.com>

On Wed, Sep 17, 2025 at 02:44:04PM +0200, Max Kellermann wrote:
> The iput() function is a dangerous one - if the reference counter goes
> to zero, the function may block for a long time due to:
> 
> - inode_wait_for_writeback() waits until writeback on this inode
>   completes
> 
> - the filesystem-specific "evict_inode" callback can do similar
>   things; e.g. all netfs-based filesystems will call
>   netfs_wait_for_outstanding_io() which is similar to
>   inode_wait_for_writeback()
> 
> Therefore, callers must carefully evaluate the context they're in and
> check whether invoking iput() is a good idea at all.
> 
> Most of the time, this is not a problem because the dcache holds
> references to all inodes, and the dcache is usually the one to release
> the last reference.  But this assumption is fragile.  For example,
> under (memcg) memory pressure, the dcache shrinker is more likely to
> release inode references, moving the inode eviction to contexts where
> that was extremely unlikely to occur.
> 
> Our production servers "found" at least two deadlock bugs in the Ceph
> filesystem that were caused by this iput() behavior:
> 
> 1. Writeback may lead to iput() calls in Ceph (e.g. from
>    ceph_put_wrbuffer_cap_refs()) which deadlocks in
>    inode_wait_for_writeback().  Waiting for writeback completion from
>    within writeback will obviously never be able to make any progress.
>    This leads to blocked kworkers like this:
> 
>     INFO: task kworker/u777:6:1270802 blocked for more than 122 seconds.
>           Not tainted 6.16.7-i1-es #773
>     task:kworker/u777:6  state:D stack:0 pid:1270802 tgid:1270802 ppid:2
>           task_flags:0x4208060 flags:0x00004000
>     Workqueue: writeback wb_workfn (flush-ceph-3)
>     Call Trace:
>      <TASK>
>      __schedule+0x4ea/0x17d0
>      schedule+0x1c/0xc0
>      inode_wait_for_writeback+0x71/0xb0
>      evict+0xcf/0x200
>      ceph_put_wrbuffer_cap_refs+0xdd/0x220
>      ceph_invalidate_folio+0x97/0xc0
>      ceph_writepages_start+0x127b/0x14d0
>      do_writepages+0xba/0x150
>      __writeback_single_inode+0x34/0x290
>      writeback_sb_inodes+0x203/0x470
>      __writeback_inodes_wb+0x4c/0xe0
>      wb_writeback+0x189/0x2b0
>      wb_workfn+0x30b/0x3d0
>      process_one_work+0x143/0x2b0
>      worker_thread+0x30a/0x450
> 
> 2. In the Ceph messenger thread (net/ceph/messenger*.c), any iput()
>    call may invoke ceph_evict_inode() which will deadlock in
>    netfs_wait_for_outstanding_io(); since this blocks the messenger
>    thread, completions from the Ceph servers will not ever be received
>    and handled.
> 
> It looks like these deadlock bugs have been in the Ceph filesystem
> code since forever (therefore no "Fixes" tag in this patch).  There
> may be various ways to solve this:
> 
> - make iput() asynchronous and defer the actual eviction like fput()
>   (may add overhead)
> 
> - make iput() only asynchronous if I_SYNC is set (doesn't solve random
>   things happening inside the "evict_inode" callback)
> 
> - add iput_deferred() to make this asynchronous behavior/overhead
>   optional and explicit
> 
> - refactor Ceph to avoid iput() calls from within writeback and
>   messenger (if that is even possible)
> 
> - add a Ceph-specific workaround

- wait for Josef to finish his inode refcount rework patchset that
  gets rid of this whole "writeback doesn't hold an inode reference"
  problem that is the root cause of this the deadlock.

All that adding a whacky async iput work around does right now is
make it harder for Josef to land the patchset that makes this
problem go away entirely....

> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index f67025465de0..385d5261632d 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -2191,6 +2191,48 @@ void ceph_queue_inode_work(struct inode *inode, int work_bit)
>  	}
>  }
>  
> +/**
> + * Queue an asynchronous iput() call in a worker thread.  Use this
> + * instead of iput() in contexts where evicting the inode is unsafe.
> + * For example, inode eviction may cause deadlocks in
> + * inode_wait_for_writeback() (when called from within writeback) or
> + * in netfs_wait_for_outstanding_io() (when called from within the
> + * Ceph messenger).
> + *
> + * @n: how many references to put
> + */
> +void ceph_iput_n_async(struct inode *inode, int n)
> +{
> +	if (unlikely(!inode))
> +		return;
> +
> +	if (likely(atomic_sub_return(n, &inode->i_count) > 0))
> +		/* somebody else is holding another reference -
> +		 * nothing left to do for us
> +		 */
> +		return;
> +
> +	doutc(ceph_inode_to_fs_client(inode)->client, "%p %llx.%llx\n", inode, ceph_vinop(inode));
> +
> +	/* the reference counter is now 0, i.e. nobody else is holding
> +	 * a reference to this inode; restore it to 1 and donate it to
> +	 * ceph_inode_work() which will call iput() at the end
> +	 */
> +	atomic_set(&inode->i_count, 1);

If you must do this, please have a look at how
btrfs_add_delayed_iput() handles detecting the last inode reference
and punting it to an async queue without needing to drop the last
reference at all.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

