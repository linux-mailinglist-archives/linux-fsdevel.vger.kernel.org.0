Return-Path: <linux-fsdevel+bounces-49460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DF1ABC872
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 22:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3861B6502B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 20:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DDE2185B1;
	Mon, 19 May 2025 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1X95dy3b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+VdRpCwv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1X95dy3b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+VdRpCwv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1641EDA3C
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747686824; cv=none; b=H0HIRPHHkcS/8QN5XS4i5NOCMmgplcCDfqYRCdJuK0hZj7/or+D/fTywvBhu/eAlzC7yFXG6faL3LECL6teL5gUzIPvwYfRXz7vGByWMNSjiNsUFagJ/onfPF4y8kvQND8LgGPkuksoYlqdvUiIO49ygSbQyKEEYwZQIVeyBiHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747686824; c=relaxed/simple;
	bh=JGcsFYegTb1zf6QNyvn5W/h4dFervDrxFIpxPlrF1vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVywBs2LG/tJMT2aJBX/JdBS3V/WkEHhrAMXPOOWsJa8m5jG+cPC3Wle6XBqgF6Qtr79f7bpl9Ct6aalbwyhn5llVHdGnu6AIi+IrdVKf5YPH+JDy7vemPIxCGJ+1OQdv8md/56c+aatU6UIvwwhP6MOl3zUgNhiSYl7OweowY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1X95dy3b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+VdRpCwv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1X95dy3b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+VdRpCwv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CD55224DD;
	Mon, 19 May 2025 20:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747686820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=olPQH59DbRjrqZV8m5Ohr9jVdSmPVkzuHCj4dVOxekY=;
	b=1X95dy3bKKInXBVyECRjge8z7fTzWPs+M3589HhzY4Bah4G0FwiP8e1ELgjXDg2FWoV7Rl
	8qW9aaB7w33L32BDcWFBV+YTYuYchooQXxXB0f0NWQM9thi6um689Ok2xJZnnBaZdPx4Fe
	cBKT1Wo0P9STaXTbJx5KbMPXO8OOSz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747686820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=olPQH59DbRjrqZV8m5Ohr9jVdSmPVkzuHCj4dVOxekY=;
	b=+VdRpCwvpNA1GYua4teNJqhwLx6EA7Vwtg8WRxBwoe8PEhc3kxo9PeramXE239JCGdWakD
	+v+NWJtx6dV+P6Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747686820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=olPQH59DbRjrqZV8m5Ohr9jVdSmPVkzuHCj4dVOxekY=;
	b=1X95dy3bKKInXBVyECRjge8z7fTzWPs+M3589HhzY4Bah4G0FwiP8e1ELgjXDg2FWoV7Rl
	8qW9aaB7w33L32BDcWFBV+YTYuYchooQXxXB0f0NWQM9thi6um689Ok2xJZnnBaZdPx4Fe
	cBKT1Wo0P9STaXTbJx5KbMPXO8OOSz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747686820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=olPQH59DbRjrqZV8m5Ohr9jVdSmPVkzuHCj4dVOxekY=;
	b=+VdRpCwvpNA1GYua4teNJqhwLx6EA7Vwtg8WRxBwoe8PEhc3kxo9PeramXE239JCGdWakD
	+v+NWJtx6dV+P6Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EBC31372E;
	Mon, 19 May 2025 20:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bct9B6SVK2jqGAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 May 2025 20:33:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D0E03A0A31; Mon, 19 May 2025 22:33:35 +0200 (CEST)
Date: Mon, 19 May 2025 22:33:35 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH v2 0/8] ext4: enable large folio for regular files
Message-ID: <jm6ncwmhhv35ebmqgkfizz2mrzcaapbpcpgsqo5joxvkmx5xfu@rgyukfmyer7d>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo]

On Mon 12-05-25 14:33:11, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Changes since v1:
>  - Rebase codes on 6.15-rc6.
>  - Drop the modifications in block_read_full_folio() which has supported
>    by commit b72e591f74de ("fs/buffer: remove batching from async
>    read").
>  - Fine-tuning patch 6 without modifying the logic.
> 
> v1: https://lore.kernel.org/linux-ext4/20241125114419.903270-1-yi.zhang@huaweicloud.com/
> 
> Original Description:
> 
> Since almost all of the code paths in ext4 have already been converted
> to use folios, there isn't much additional work required to support
> large folios. This series completes the remaining work and enables large
> folios for regular files on ext4, with the exception of fsverity,
> fscrypt, and data=journal mode.
> 
> Unlike my other series[1], which enables large folios by converting the
> buffered I/O path from the classic buffer_head to iomap, this solution
> is based on the original buffer_head, it primarily modifies the block
> offset and length calculations within a single folio in the buffer
> write, buffer read, zero range, writeback, and move extents paths to
> support large folios, doesn't do further code refactoring and
> optimization.
> 
> This series have passed kvm-xfstests in auto mode several times, every
> thing looks fine, any comments are welcome.
> 
> About performance:
> 
> I used the same test script from my iomap series (need to drop the mount
> opts parameter MOUNT_OPT) [2], run fio tests on the same machine with
> Intel Xeon Gold 6240 CPU with 400GB system ram, 200GB ramdisk and 4TB
> nvme ssd disk. Both compared with the base and the IOMAP + large folio
> changes.
> 
>  == buffer read ==
> 
>                 base          iomap+large folio base+large folio
>  type     bs    IOPS  BW(M/s) IOPS  BW(M/s)     IOPS   BW(M/s)
>  ----------------------------------------------------------------
>  hole     4K  | 576k  2253  | 762k  2975(+32%) | 747k  2918(+29%)
>  hole     64K | 48.7k 3043  | 77.8k 4860(+60%) | 76.3k 4767(+57%)
>  hole     1M  | 2960  2960  | 4942  4942(+67%) | 4737  4738(+60%)
>  ramdisk  4K  | 443k  1732  | 530k  2069(+19%) | 494k  1930(+11%)
>  ramdisk  64K | 34.5k 2156  | 45.6k 2850(+32%) | 41.3k 2584(+20%)
>  ramdisk  1M  | 2093  2093  | 2841  2841(+36%) | 2585  2586(+24%)
>  nvme     4K  | 339k  1323  | 364k  1425(+8%)  | 344k  1341(+1%)
>  nvme     64K | 23.6k 1471  | 25.2k 1574(+7%)  | 25.4k 1586(+8%)
>  nvme     1M  | 2012  2012  | 2153  2153(+7%)  | 2122  2122(+5%)
> 
> 
>  == buffer write ==
> 
>  O: Overwrite; S: Sync; W: Writeback
> 
>                      base         iomap+large folio    base+large folio
>  type    O S W bs    IOPS  BW     IOPS  BW(M/s)        IOPS  BW(M/s)
>  ----------------------------------------------------------------------
>  cache   N N N 4K  | 417k  1631 | 440k  1719 (+5%)   | 423k  1655 (+2%)
>  cache   N N N 64K | 33.4k 2088 | 81.5k 5092 (+144%) | 59.1k 3690 (+77%)
>  cache   N N N 1M  | 2143  2143 | 5716  5716 (+167%) | 3901  3901 (+82%)
>  cache   Y N N 4K  | 449k  1755 | 469k  1834 (+5%)   | 452k  1767 (+1%)
>  cache   Y N N 64K | 36.6k 2290 | 82.3k 5142 (+125%) | 67.2k 4200 (+83%)
>  cache   Y N N 1M  | 2352  2352 | 5577  5577 (+137%  | 4275  4276 (+82%)
>  ramdisk N N Y 4K  | 365k  1424 | 354k  1384 (-3%)   | 372k  1449 (+2%)
>  ramdisk N N Y 64K | 31.2k 1950 | 74.2k 4640 (+138%) | 56.4k 3528 (+81%)
>  ramdisk N N Y 1M  | 1968  1968 | 5201  5201 (+164%) | 3814  3814 (+94%)
>  ramdisk N Y N 4K  | 9984  39   | 12.9k 51   (+29%)  | 9871  39   (-1%)
>  ramdisk N Y N 64K | 5936  371  | 8960  560  (+51%)  | 6320  395  (+6%)
>  ramdisk N Y N 1M  | 1050  1050 | 1835  1835 (+75%)  | 1656  1657 (+58%)
>  ramdisk Y N Y 4K  | 411k  1609 | 443k  1731 (+8%)   | 441k  1723 (+7%)
>  ramdisk Y N Y 64K | 34.1k 2134 | 77.5k 4844 (+127%) | 66.4k 4151 (+95%)
>  ramdisk Y N Y 1M  | 2248  2248 | 5372  5372 (+139%) | 4209  4210 (+87%)
>  ramdisk Y Y N 4K  | 182k  711  | 186k  730  (+3%)   | 182k  711  (0%)
>  ramdisk Y Y N 64K | 18.7k 1170 | 34.7k 2171 (+86%)  | 31.5k 1969 (+68%)
>  ramdisk Y Y N 1M  | 1229  1229 | 2269  2269 (+85%)  | 1943  1944 (+58%)
>  nvme    N N Y 4K  | 373k  1458 | 387k  1512 (+4%)   | 399k  1559 (+7%)
>  nvme    N N Y 64K | 29.2k 1827 | 70.9k 4431 (+143%) | 54.3k 3390 (+86%)
>  nvme    N N Y 1M  | 1835  1835 | 4919  4919 (+168%) | 3658  3658 (+99%)
>  nvme    N Y N 4K  | 11.7k 46   | 11.7k 46   (0%)    | 11.5k 45   (-1%)
>  nvme    N Y N 64K | 6453  403  | 8661  541  (+34%)  | 7520  470  (+17%)
>  nvme    N Y N 1M  | 649   649  | 1351  1351 (+108%) | 885   886  (+37%)
>  nvme    Y N Y 4K  | 372k  1456 | 433k  1693 (+16%)  | 419k  1637 (+12%)
>  nvme    Y N Y 64K | 33.0k 2064 | 74.7k 4669 (+126%) | 64.1k 4010 (+94%)
>  nvme    Y N Y 1M  | 2131  2131 | 5273  5273 (+147%) | 4259  4260 (+100%)
>  nvme    Y Y N 4K  | 56.7k 222  | 56.4k 220  (-1%)   | 59.4k 232  (+5%)
>  nvme    Y Y N 64K | 13.4k 840  | 19.4k 1214 (+45%)  | 18.5k 1156 (+38%)
>  nvme    Y Y N 1M  | 714   714  | 1504  1504 (+111%) | 1319  1320 (+85%)
> 
> [1] https://lore.kernel.org/linux-ext4/20241022111059.2566137-1-yi.zhang@huaweicloud.com/
> [2] https://lore.kernel.org/linux-ext4/3c01efe6-007a-4422-ad79-0bad3af281b1@huaweicloud.com/
> 
> Thanks,
> Yi.

The patches look good to me besides that one issue with journal credits. I
can see Ted has already picked up the patches so this is probably moot but
still:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> 
> Zhang Yi (8):
>   ext4: make ext4_mpage_readpages() support large folios
>   ext4: make regular file's buffered write path support large folios
>   ext4: make __ext4_block_zero_page_range() support large folio
>   ext4/jbd2: convert jbd2_journal_blocks_per_page() to support large
>     folio
>   ext4: correct the journal credits calculations of allocating blocks
>   ext4: make the writeback path support large folios
>   ext4: make online defragmentation support large folios
>   ext4: enable large folio for regular file
> 
>  fs/ext4/ext4.h        |  1 +
>  fs/ext4/ext4_jbd2.c   |  3 +-
>  fs/ext4/ext4_jbd2.h   |  4 +--
>  fs/ext4/extents.c     |  5 +--
>  fs/ext4/ialloc.c      |  3 ++
>  fs/ext4/inode.c       | 72 ++++++++++++++++++++++++++++++-------------
>  fs/ext4/move_extent.c | 11 +++----
>  fs/ext4/readpage.c    | 28 ++++++++++-------
>  fs/jbd2/journal.c     |  7 +++--
>  include/linux/jbd2.h  |  2 +-
>  10 files changed, 88 insertions(+), 48 deletions(-)
> 
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

