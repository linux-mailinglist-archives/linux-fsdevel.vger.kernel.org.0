Return-Path: <linux-fsdevel+bounces-75151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEk1Fl6McmlJmAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:45:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C09DF6D83E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B73603008769
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 20:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5A33A7326;
	Thu, 22 Jan 2026 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcmER34L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0263A7034
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114712; cv=none; b=ftIz9mkFUKufLQpvWDjBebLsPsFZRgaiNx5phalbqnzFypj1hl3jRvxiIX3GfUaKT4dD11RNOdElJPEshmGBeoXxOMwM2LjJddNtcl+SAS0OxByEeZf3+AVqXagz/6Zm8HuXDjROYGCmNH3LQAuKhgh46IXSKqWx8bwIo4fXr90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114712; c=relaxed/simple;
	bh=WpjdkZr7gZqb2N0wQQcH0LtMh0wWbvw+Iwn8aCgLLuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9IenOrKQF1JHrur+UhJuFWte39XrVFlWdFycb2E8xzqsvCWTi9FOD/nnTKROD/DjMsV1cLufBOuaqJ/9v7gFeGNaV0r+1Ud+iqwUL2tJK2BABFtL1QlYv8jVIQuR0GWBdBFyPRZ8gVkTZm/pWhSsvyWuUX1LQfGuP0qU+K//W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcmER34L; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4359a302794so973530f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 12:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769114698; x=1769719498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4HXJHkDaMXh/2DJp2ACfR897wjQMnrDONUo/R82h0M0=;
        b=gcmER34LfFAnAfhzDkM7m4TDar+DJeE0qDIqfc+RUpua99uBzXOqoPnKiz3ZiY5Ayy
         Tr3jZtsz5A64o6uZTP+c+hJ08YSReoYVCO4cgWA7yvMO0SbSjJnPWYhJzlw+yuyYF8/7
         /BlfCfHEpyHQ5MLftDHk5birLXRtT8kWWRV+Rt0yjfm06wn9xEW8J/lWDjFdUXQ0IxoF
         V+7laWiohni37wjl1LFbXV8Q2VNKzyWrtmm1NgrHtKV1fJWXbZq3WjY65cqaYlZ1fnH3
         /AMSMb3xCRYDMMJuN3LihcbUbAbwXIPdQ1iLddqbukRxrYJEtuJ33pe+BKp68iz/WB/P
         IsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769114698; x=1769719498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HXJHkDaMXh/2DJp2ACfR897wjQMnrDONUo/R82h0M0=;
        b=ZrvvKAU+HA/qRiwZUpigiv0hsL6cMdAtax40QeBFrGAsGAENS+Upy2+JlEq+7X+nnm
         7/k296bBCLBTVYK8p70+O1ew1QiuIW9Ky5A+XZ5sN1ss3o13C+T5ZqMgd0gTcZ62k6fR
         /BoWn+LZT0aJo/QsNiYxTTFARi1jTcp6N59F0b0oSdo9HrM566dxNRr4F9j621DT3IRD
         oNIwl1iY9DdCFy6gQ5lWofgaWKBqbfuGHiVRrMAKxcO76xpS6EgRnZtiSu50lLYHAOg9
         0nOjodNaywWxl8Hwm+db/NQKumw+2BU6Vel0b8QGGkJFg8WaJl/dMh9SkWtFrXZTSUF4
         2UIw==
X-Forwarded-Encrypted: i=1; AJvYcCU6dCmboIPeTLTAIbCbRAK3XKhdZuuzO9rMU2S/nYW8AS/6xd1VI3Lgp1EIf2xEEFdSbjaT7oj/WSyZ1CHg@vger.kernel.org
X-Gm-Message-State: AOJu0YwlanCbk76uEfFooTc9KtYpsOHuqng9p16lkbSJrQE5Huy6jNeB
	absbhjZsJ/ogm1oLIBLuHMSJAqEXszfOeFiiHzw78WbxgAzK7zBPYSHz
X-Gm-Gg: AZuq6aKXC3ptgDkbm6xMr3JQZLZXAQ/iD4aBhlDvJdNhj3RWRVsQFkAVxQ0cnUpWFR5
	scGhYwqwtg4TYqM8dJTASZ/JODiJ87CHL0VmW3Q5Up9jUkuzaW/lukSSzQHg/2MEYQEL8ILiBS1
	xBnvTA1gJ3YUusRVVkCqL6tV8s0K3BfHMGYPneGEK+JRDyKuQIJvqllklT/QwuWIgLj+7yR/ghH
	VgR1CxGicWZF4zdxvl3IQ7PKM4xZwEaucPCn9KCYOmfHWSwep5sbedddpWw8cb0I6ivepLYZn6R
	IQOcrF9Q+3Z+XJKXQBkY4Aybt7BtPRttowHfy2aEhssWZ9Y35Hp0NJv7Urp+K291+DpwnWC9gMr
	zW5JqSZX02NV/BaPXADY8C7VtMEabZzIzzlyga12vxYT3OgBqa1zNUBDt0McrhHaGTiQ1PLYSFi
	IgXhYf6yuCjsjED7F60LADPYReIlsac9BOqVs2tnDEzwuBckYnCklA3xJgS6LpLuJ7TrL5bQ==
X-Received: by 2002:a05:6000:1447:b0:435:9432:a407 with SMTP id ffacd0b85a97d-435b161c131mr1619126f8f.54.1769114697795;
        Thu, 22 Jan 2026 12:44:57 -0800 (PST)
Received: from f (cst-prg-85-136.cust.vodafone.cz. [46.135.85.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02cf6sm1311240f8f.7.2026.01.22.12.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 12:44:57 -0800 (PST)
Date: Thu, 22 Jan 2026 21:44:50 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, yuanql9@chinatelecom.cn
Subject: Re: [PATCH] fs/file: optimize FD allocation complexity with 3-level
 summary bitmap
Message-ID: <4qzknwustcw7vkpky3z5kvkmjp3burhwipivfeqr4cine3i4x5@772ocqtmmcoj>
References: <20260122170345.157803-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260122170345.157803-1-realwujing@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75151-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: C09DF6D83E
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 12:03:45PM -0500, Qiliang Yuan wrote:
> Current FD allocation performs a two-level bitmap search (open_fds and
> full_fds_bits). This results in O(N/64) complexity when searching for a
> free FD, as the kernel needs to scan the first-level summary bitmap.
> 
> For processes with very large FD limits (e.g., millions of sockets),
> scanning even the level 1 summary bitmap can become a bottleneck during
> high-frequency allocation.
> 
> This patch introduces a third level of summary bitmap (full_fds_bits_l2),
> where each bit represents whether a 64-word chunk (4096 FDs) in open_fds
> is fully allocated. This reduces the search complexity to O(N/4096),
> making FD allocation significantly more scalable for high-concurrency
> workloads.
> 

Do you have results to justify this change?

Note this adds more bouncing memory accesses to the lock-protected area.

The centralized locking is a long stranding problem and I'm not
convinced there is more place for lipstick on that pig.

The real solution(tm) would instead make it feasible to not need said
locking.

As is all programs are shafted because any fd-allocating syscall is
required to obtain lowest fd available.

In another life I suggested introducing a new flag for accept, open et
al which would waive that requirement for that specific invocation in
turn allowing scalable allocation instead.

Say it would be called O_ANYFD/SOCK_ANYFD.

Then the fd space can be partitioned in some capacity -- maybe per
thread, maybe per cpu, maybe some other granularity, but it would no
longer be centralized.

Code which knowns about the feature and is fine with it can pass the
flag and in turn allocate from one of the extra tables by default.

Code oblivious to the feature would not see a change in behavior, as
absent the flag the kernel would ensure to find the lowest fd.

Ultimately any program written with performance in mind can be then
trivially tweaked to use it and get the benefit. The hard part is making
it sensibly work.


> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> ---
>  fs/file.c               | 45 +++++++++++++++++++++++++++++++++--------
>  include/linux/fdtable.h |  2 ++
>  2 files changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 0a4f3bdb2dec..1163160e81af 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -114,6 +114,8 @@ static void free_fdtable_rcu(struct rcu_head *rcu)
>  
>  #define BITBIT_NR(nr)	BITS_TO_LONGS(BITS_TO_LONGS(nr))
>  #define BITBIT_SIZE(nr)	(BITBIT_NR(nr) * sizeof(long))
> +#define BITBITBIT_NR(nr) BITS_TO_LONGS(BITBIT_NR(nr))
> +#define BITBITBIT_SIZE(nr) (BITBITBIT_NR(nr) * sizeof(long))
>  
>  #define fdt_words(fdt) ((fdt)->max_fds / BITS_PER_LONG) // words in ->open_fds
>  /*
> @@ -132,6 +134,8 @@ static inline void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
>  			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
>  	bitmap_copy_and_extend(nfdt->full_fds_bits, ofdt->full_fds_bits,
>  			copy_words, nwords);
> +	bitmap_copy_and_extend(nfdt->full_fds_bits_l2, ofdt->full_fds_bits_l2,
> +			BITS_TO_LONGS(copy_words), BITS_TO_LONGS(nwords));
>  }
>  
>  /*
> @@ -222,7 +226,7 @@ static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
>  	fdt->fd = data;
>  
>  	data = kvmalloc(max_t(size_t,
> -				 2 * nr / BITS_PER_BYTE + BITBIT_SIZE(nr), L1_CACHE_BYTES),
> +				 2 * nr / BITS_PER_BYTE + BITBIT_SIZE(nr) + BITBITBIT_SIZE(nr), L1_CACHE_BYTES),
>  				 GFP_KERNEL_ACCOUNT);
>  	if (!data)
>  		goto out_arr;
> @@ -231,6 +235,8 @@ static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
>  	fdt->close_on_exec = data;
>  	data += nr / BITS_PER_BYTE;
>  	fdt->full_fds_bits = data;
> +	data += BITBIT_SIZE(nr);
> +	fdt->full_fds_bits_l2 = data;
>  
>  	return fdt;
>  
> @@ -335,16 +341,24 @@ static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt, bool set)
>  	__set_bit(fd, fdt->open_fds);
>  	__set_close_on_exec(fd, fdt, set);
>  	fd /= BITS_PER_LONG;
> -	if (!~fdt->open_fds[fd])
> +	if (!~fdt->open_fds[fd]) {
>  		__set_bit(fd, fdt->full_fds_bits);
> +		unsigned int idx = fd / BITS_PER_LONG;
> +		if (!~fdt->full_fds_bits[idx])
> +			__set_bit(idx, fdt->full_fds_bits_l2);
> +	}
>  }
>  
>  static inline void __clear_open_fd(unsigned int fd, struct fdtable *fdt)
>  {
>  	__clear_bit(fd, fdt->open_fds);
>  	fd /= BITS_PER_LONG;
> -	if (test_bit(fd, fdt->full_fds_bits))
> +	if (test_bit(fd, fdt->full_fds_bits)) {
>  		__clear_bit(fd, fdt->full_fds_bits);
> +		unsigned int idx = fd / BITS_PER_LONG;
> +		if (test_bit(idx, fdt->full_fds_bits_l2))
> +			__clear_bit(idx, fdt->full_fds_bits_l2);
> +	}
>  }
>  
>  static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
> @@ -402,6 +416,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
>  	new_fdt->close_on_exec = newf->close_on_exec_init;
>  	new_fdt->open_fds = newf->open_fds_init;
>  	new_fdt->full_fds_bits = newf->full_fds_bits_init;
> +	new_fdt->full_fds_bits_l2 = newf->full_fds_bits_init_l2;
>  	new_fdt->fd = &newf->fd_array[0];
>  
>  	spin_lock(&oldf->file_lock);
> @@ -536,6 +551,7 @@ struct files_struct init_files = {
>  		.close_on_exec	= init_files.close_on_exec_init,
>  		.open_fds	= init_files.open_fds_init,
>  		.full_fds_bits	= init_files.full_fds_bits_init,
> +		.full_fds_bits_l2 = init_files.full_fds_bits_init_l2,
>  	},
>  	.file_lock	= __SPIN_LOCK_UNLOCKED(init_files.file_lock),
>  	.resize_wait	= __WAIT_QUEUE_HEAD_INITIALIZER(init_files.resize_wait),
> @@ -545,22 +561,35 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
>  {
>  	unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
>  	unsigned int maxbit = maxfd / BITS_PER_LONG;
> +	unsigned int maxbit_l2 = BITBIT_NR(maxfd);
>  	unsigned int bitbit = start / BITS_PER_LONG;
> +	unsigned int bitbit_l2 = bitbit / BITS_PER_LONG;
>  	unsigned int bit;
>  
>  	/*
> -	 * Try to avoid looking at the second level bitmap
> +	 * Try to avoid looking at the upper level bitmaps
>  	 */
>  	bit = find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
>  				 start & (BITS_PER_LONG - 1));
>  	if (bit < BITS_PER_LONG)
>  		return bit + bitbit * BITS_PER_LONG;
>  
> -	bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
> -	if (bitbit >= maxfd)
> +	/* Algorithmic Optimization: O(N) -> O(1) via 3rd-level summary bitmap */
> +	bitbit_l2 = find_next_zero_bit(fdt->full_fds_bits_l2, maxbit_l2, bitbit_l2);
> +	if (bitbit_l2 >= maxbit_l2)
>  		return maxfd;
> -	if (bitbit > start)
> -		start = bitbit;
> +
> +	if (bitbit_l2 * BITS_PER_LONG > bitbit)
> +		bitbit = bitbit_l2 * BITS_PER_LONG;
> +
> +	bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit);
> +	if (bitbit >= maxbit)
> +		return maxfd;
> +
> +	bit = bitbit * BITS_PER_LONG;
> +	if (bit > start)
> +		start = bit;
> +
>  	return find_next_zero_bit(fdt->open_fds, maxfd, start);
>  }
>  
> diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> index c45306a9f007..992b4ed9c1e0 100644
> --- a/include/linux/fdtable.h
> +++ b/include/linux/fdtable.h
> @@ -29,6 +29,7 @@ struct fdtable {
>  	unsigned long *close_on_exec;
>  	unsigned long *open_fds;
>  	unsigned long *full_fds_bits;
> +	unsigned long *full_fds_bits_l2;
>  	struct rcu_head rcu;
>  };
>  
> @@ -53,6 +54,7 @@ struct files_struct {
>  	unsigned long close_on_exec_init[1];
>  	unsigned long open_fds_init[1];
>  	unsigned long full_fds_bits_init[1];
> +	unsigned long full_fds_bits_init_l2[1];
>  	struct file __rcu * fd_array[NR_OPEN_DEFAULT];
>  };
>  
> -- 
> 2.51.0
> 

