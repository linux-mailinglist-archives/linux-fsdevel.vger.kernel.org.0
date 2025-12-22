Return-Path: <linux-fsdevel+bounces-71820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C42FCD5BD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 12:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4CA8301CE6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 11:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D99F3328F4;
	Mon, 22 Dec 2025 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="28zOu2au";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qIMGPcsP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="28zOu2au";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qIMGPcsP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5895B3321D4
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766398547; cv=none; b=BFUdYe4wXF03UvG2azU68Kq73U15Rtk8dWAn5sP648qgvonTrg7ypx1svvCDmcDQbLO9pJWrpWtal8nINBPqNWM3GbCFaEJXiPh57x8I49l1xrtSizi1WHv0XN+roEDYRgWUUMXy3ifXc0Y2OBewrdytHEZMt8Fh6PwaRCL6BL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766398547; c=relaxed/simple;
	bh=ljximbqsUSqTUJVI2uzmBObCt4KqRCqGekBkrKXJ+aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvTRZ025TG0QVT0SXzfHnKoxrF7RhHC3slSqHcJjhnOzJZUEIMaGXKCaKfuTfvPrzuXLoeNXawAKB4ssOvKfnvRzJVK8W9jotBjJOLPujOFYkhAJ+LkodGD2dm3B0/NurLEBRAnnioU9iN4S4/KA4jM6mzmbjZkFIfZ8RWa0VTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=28zOu2au; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qIMGPcsP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=28zOu2au; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qIMGPcsP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 418325BE9B;
	Mon, 22 Dec 2025 10:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766398542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UR+LyydI/uuNTc7n7yKBYK5kGEIJHkct55zFm6J1VN8=;
	b=28zOu2auz2d/1y6aZBUU0u5gT4YhT4J3SUC5FK+roRoxjLGPY+HnL/puY+omvvBPbRmHQw
	J8FG1EiINhXJT2EUkhNZN1Xe7MMDHGk3FzOGrU4KIY6oTjS9KfxdAzPuNbXRyKufoU/xFE
	XOc6KPzCq+gbjCYCUidh9PRHTIGookk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766398542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UR+LyydI/uuNTc7n7yKBYK5kGEIJHkct55zFm6J1VN8=;
	b=qIMGPcsPlKy0FbcdSw/ssS0inqmUOfLcpWO4UIvExVLfqBCsZrtwKIXQDtDkeXZ6WMuMQF
	IVynAUQjPm6YstDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=28zOu2au;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qIMGPcsP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766398542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UR+LyydI/uuNTc7n7yKBYK5kGEIJHkct55zFm6J1VN8=;
	b=28zOu2auz2d/1y6aZBUU0u5gT4YhT4J3SUC5FK+roRoxjLGPY+HnL/puY+omvvBPbRmHQw
	J8FG1EiINhXJT2EUkhNZN1Xe7MMDHGk3FzOGrU4KIY6oTjS9KfxdAzPuNbXRyKufoU/xFE
	XOc6KPzCq+gbjCYCUidh9PRHTIGookk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766398542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UR+LyydI/uuNTc7n7yKBYK5kGEIJHkct55zFm6J1VN8=;
	b=qIMGPcsPlKy0FbcdSw/ssS0inqmUOfLcpWO4UIvExVLfqBCsZrtwKIXQDtDkeXZ6WMuMQF
	IVynAUQjPm6YstDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 350C73EA65;
	Mon, 22 Dec 2025 10:15:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jQHsDE4aSWn9UQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Dec 2025 10:15:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C7733A09CB; Mon, 22 Dec 2025 11:15:26 +0100 (CET)
Date: Mon, 22 Dec 2025 11:15:26 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, ritesh.list@gmail.com, 
	yi.zhang@huawei.com, yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com, 
	yukuai@fnnas.com
Subject: Re: [PATCH -next 3/7] ext4: avoid starting handle when dio writing
 an unwritten extent
Message-ID: <7btwyxrkixgmv45jeh3bf4uf4fqmauypb2ss67uqsiicklz6gq@rmll5ujssmwx>
References: <20251213022008.1766912-1-yi.zhang@huaweicloud.com>
 <20251213022008.1766912-4-yi.zhang@huaweicloud.com>
 <6kfhyiin2m3iook5c4s6dwq45yeqshv4vbez3dfvwaehltajuc@4ybsharot344>
 <5f6f9588-52a0-4ab8-a1ad-3d466488b985@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f6f9588-52a0-4ab8-a1ad-3d466488b985@huaweicloud.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,linux.ibm.com,gmail.com,huawei.com,fnnas.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 418325BE9B
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Sat 20-12-25 15:16:41, Zhang Yi wrote:
> On 12/19/2025 11:25 PM, Jan Kara wrote:
> > On Sat 13-12-25 10:20:04, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> Since we have deferred the split of the unwritten extent until after I/O
> >> completion, it is not necessary to initiate the journal handle when
> >> submitting the I/O.
> >>
> >> This can improve the write performance of concurrent DIO for multiple
> >> files. The fio tests below show a ~25% performance improvement when
> >> wirting to unwritten files on my VM with a mem disk.
> >>
> >>   [unwritten]
> >>   direct=1
> >>   ioengine=psync
> >>   numjobs=16
> >>   rw=write     # write/randwrite
> >>   bs=4K
> >>   iodepth=1
> >>   directory=/mnt
> >>   size=5G
> >>   runtime=30s
> >>   overwrite=0
> >>   norandommap=1
> >>   fallocate=native
> >>   ramp_time=5s
> >>   group_reporting=1
> >>
> >>  [w/o]
> >>   w:  IOPS=62.5k, BW=244MiB/s
> >>   rw: IOPS=56.7k, BW=221MiB/s
> >>
> >>  [w]
> >>   w:  IOPS=79.6k, BW=311MiB/s
> >>   rw: IOPS=70.2k, BW=274MiB/s
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >> ---
> >>  fs/ext4/file.c  | 4 +---
> >>  fs/ext4/inode.c | 4 +++-
> >>  2 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> >> index 7a8b30932189..9f571acc7782 100644
> >> --- a/fs/ext4/file.c
> >> +++ b/fs/ext4/file.c
> >> @@ -418,9 +418,7 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
> >>   *   updating inode i_disksize and/or orphan handling with exclusive lock.
> >>   *
> >>   * - shared locking will only be true mostly with overwrites, including
> >> - *   initialized blocks and unwritten blocks. For overwrite unwritten blocks
> >> - *   we protect splitting extents by i_data_sem in ext4_inode_info, so we can
> >> - *   also release exclusive i_rwsem lock.
> >> + *   initialized blocks and unwritten blocks.
> >>   *
> >>   * - Otherwise we will switch to exclusive i_rwsem lock.
> >>   */
> >> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> >> index ffde24ff7347..08a296122fe0 100644
> >> --- a/fs/ext4/inode.c
> >> +++ b/fs/ext4/inode.c
> >> @@ -3819,7 +3819,9 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> >>  			 * For atomic writes the entire requested length should
> >>  			 * be mapped.
> >>  			 */
> >> -			if (map.m_flags & EXT4_MAP_MAPPED) {
> >> +			if ((map.m_flags & EXT4_MAP_MAPPED) ||
> >> +			    (!(flags & IOMAP_DAX) &&
> > 
> > Why is here an exception for DAX writes? DAX is fine writing to unwritten
> > extents AFAIK. It only needs to pre-zero newly allocated blocks... Or am I
> > missing some corner case?
> > 
> > 								Honza
> 
> Hi, Jan!
> 
> Thank you for reviewing this series.
> 
> Yes, that is precisely why this exception is necessary here. Without this
> exception, a DAX write to an unwritten extent would return immediately
> without invoking ext4_iomap_alloc() to perform pre-zeroing.

Ah, you're right. I already forgot how writing to unwritten extents works
with DAX and it seems we convert the extents to initialized (and zero them
out) before copying the data. Can you please expand the comment above by
"For DAX we convert extents to initialized ones before copying the data,
otherwise we do it after IO so there's no need to call into
ext4_iomap_alloc()." Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

