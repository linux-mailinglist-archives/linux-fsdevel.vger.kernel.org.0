Return-Path: <linux-fsdevel+bounces-23142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F297C927A48
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 17:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF531F283C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 15:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7121B1428;
	Thu,  4 Jul 2024 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xxteEm+m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MclA0BBB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xxteEm+m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MclA0BBB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1173A1AC252;
	Thu,  4 Jul 2024 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720107458; cv=none; b=eRTssMDWP/3MvJyFYY4larWWpbaFxaQ4VPYFb49hAkRVqkfiSFjuIlTAsV3ijvzSbl8O8iuOEiZeuDmQDi6bfkxU205Fe0LhWohBjgXbpV+EmC+DS134bbo6+P0K/yuNTiGg9jqkmKBZMgGHwCk1Zs+hWgrQE8htM1qodtiuGRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720107458; c=relaxed/simple;
	bh=TLsODB7IpRx1+ly6ijHcxH6cy8GuqwWiYIVrnoeymTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUMaNKWeDQZD+UMW/YRiljkqTp69QVbW9SdnwHBcoHIS+VtoQhljNDq4lNUEy23uGWxEDmdZ8WuLLrhWskMUn5cfjrNbk92/yKBWRizucptfX+85lehA92/Ew9LMITtPeMotpfPx1gqS11vXd6GweUCz/Ro24Tjzx3Jt5kt78fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xxteEm+m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MclA0BBB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xxteEm+m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MclA0BBB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 24D3E21BAE;
	Thu,  4 Jul 2024 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720107455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65H5k5hn17k/Q6t1nmNt687lwrCYMhgfHjot9SPgp4A=;
	b=xxteEm+muxQ6xQ5W4wzo7OSGywE8UZCZ2Jw6C4wVUrgLqi7pDYTWj1p7gvtE/G+dBL5tda
	yJyIvJzydqJR7X5hCkVmwrlIY8O8++SdPAzzS/jc5Sit4ESbz/eMlafTuG2LVvWMQYz7Jq
	HXVgB9vDYxzO7R+MlEdgd/pSHOxqAHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720107455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65H5k5hn17k/Q6t1nmNt687lwrCYMhgfHjot9SPgp4A=;
	b=MclA0BBBumTYPxMCItA/7dEXtz3Aa0cBhwEjXaJzAWqpsDisAWyzgvA5QerIzs40QYquVG
	KFdkBHT5oKIdrXBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xxteEm+m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MclA0BBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720107455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65H5k5hn17k/Q6t1nmNt687lwrCYMhgfHjot9SPgp4A=;
	b=xxteEm+muxQ6xQ5W4wzo7OSGywE8UZCZ2Jw6C4wVUrgLqi7pDYTWj1p7gvtE/G+dBL5tda
	yJyIvJzydqJR7X5hCkVmwrlIY8O8++SdPAzzS/jc5Sit4ESbz/eMlafTuG2LVvWMQYz7Jq
	HXVgB9vDYxzO7R+MlEdgd/pSHOxqAHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720107455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65H5k5hn17k/Q6t1nmNt687lwrCYMhgfHjot9SPgp4A=;
	b=MclA0BBBumTYPxMCItA/7dEXtz3Aa0cBhwEjXaJzAWqpsDisAWyzgvA5QerIzs40QYquVG
	KFdkBHT5oKIdrXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C38601369F;
	Thu,  4 Jul 2024 15:37:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zlDxLb3BhmZERQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 04 Jul 2024 15:37:33 +0000
Message-ID: <2c09ebbd-1704-46e3-a453-b4cd07940325@suse.de>
Date: Thu, 4 Jul 2024 17:37:32 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/10] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, david@fromorbit.com,
 willy@infradead.org, chandan.babu@oracle.com, djwong@kernel.org,
 brauner@kernel.org, akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
 p.raghav@samsung.com, mcgrof@kernel.org, gost.dev@samsung.com,
 cl@os.amperecomputing.com, linux-xfs@vger.kernel.org, hch@lst.de,
 Zi Yan <ziy@nvidia.com>
References: <20240704112320.82104-1-kernel@pankajraghav.com>
 <20240704112320.82104-7-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240704112320.82104-7-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 24D3E21BAE
X-Spam-Score: -5.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 7/4/24 13:23, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> size < page_size. This is true for most filesystems at the moment.
> 
> If the block size > page size, this will send the contents of the page
> next to zero page(as len > PAGE_SIZE) to the underlying block device,
> causing FS corruption.
> 
> iomap is a generic infrastructure and it should not make any assumptions
> about the fs block size and the page size of the system.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   fs/iomap/buffered-io.c |  4 ++--
>   fs/iomap/direct-io.c   | 45 ++++++++++++++++++++++++++++++++++++------
>   2 files changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f420c53d86acc..d745f718bcde8 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -2007,10 +2007,10 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
>   }
>   EXPORT_SYMBOL_GPL(iomap_writepages);
>   
> -static int __init iomap_init(void)
> +static int __init iomap_buffered_init(void)
>   {
>   	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
>   			   offsetof(struct iomap_ioend, io_bio),
>   			   BIOSET_NEED_BVECS);
>   }
> -fs_initcall(iomap_init);
> +fs_initcall(iomap_buffered_init);
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f3b43d223a46e..c02b266bba525 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -11,6 +11,7 @@
>   #include <linux/iomap.h>
>   #include <linux/backing-dev.h>
>   #include <linux/uio.h>
> +#include <linux/set_memory.h>
>   #include <linux/task_io_accounting_ops.h>
>   #include "trace.h"
>   
> @@ -27,6 +28,13 @@
>   #define IOMAP_DIO_WRITE		(1U << 30)
>   #define IOMAP_DIO_DIRTY		(1U << 31)
>   
> +/*
> + * Used for sub block zeroing in iomap_dio_zero()
> + */
> +#define IOMAP_ZERO_PAGE_SIZE (SZ_64K)
> +#define IOMAP_ZERO_PAGE_ORDER (get_order(IOMAP_ZERO_PAGE_SIZE))
> +static struct page *zero_page;
> +

There are other users of ZERO_PAGE, most notably in fs/direct-io.c and 
block/blk-lib.c. Any chance to make this available to them?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


