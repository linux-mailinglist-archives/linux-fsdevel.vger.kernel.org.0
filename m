Return-Path: <linux-fsdevel+bounces-14753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1CF87EE68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 18:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9781F23AA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EC254F9F;
	Mon, 18 Mar 2024 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iXb1PKuu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ArCWwG1v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eWbbtdtO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SjSCGtwr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE9A3A8F9;
	Mon, 18 Mar 2024 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781651; cv=none; b=H3jgvkDTJN9zd+sEWqJ6q3CTQl1l7V2Lrrdl1ox/HdHGf1J1xDC0UPuQs/DuE9t02yWcihUxF/1i/5PqoPIVrychd3jFj0aNlY0qT57fUpUOaNRhNjIEXJfgBsE/wXSrGtYL4XekJQ4ygA8BCjkAcS39xWg97/KumcudSIKvjes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781651; c=relaxed/simple;
	bh=HUsRDo7Jc5bEEXI3vYu8ImWAopUkQ+k9hXHhlIthcTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY2lS5wc/veQi5dbaYSQXapbXh9fZ0WBL7EqVqwu0Ma38j4bUtspfJCdLSGHd7Sy+LflU99VE5agF4/Y3iAwslLdkRDweb2xUlaRmVbmwDpBlqqvWchw//JtBl7Ef+rNkiFRPoCR/ZAIxWyD5y3zzGh3bzsgifqFTVB8MArc2z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iXb1PKuu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ArCWwG1v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eWbbtdtO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SjSCGtwr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CC8A5C7BB;
	Mon, 18 Mar 2024 17:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710781647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qJZVd+/t6/T/I9QFCHsi+gcMomJFVa7ZLsqdOX6uWZg=;
	b=iXb1PKuuDGGCUjN++LNeztrlwGPPl5GVIL7V3Tdp+zZdGYaYdahKg+NHbPHbhi/PKzpe7Y
	dgP8XvlcUGXPWShxVmkN1XpQX34Ux5Vf/Pjo0SLK+aEu5mWoS3BAPAWoFA634S+3eO24eX
	xucZej1YO5JdNJji+1F0Ev2V16XlszY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710781647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qJZVd+/t6/T/I9QFCHsi+gcMomJFVa7ZLsqdOX6uWZg=;
	b=ArCWwG1vdwHamxfg99VxdZN8c+1mIzBU44jSfNkbuHWVCJJJItjVVkSZANQvxQgWvb78/q
	aamt7wMT193xJfDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710781645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qJZVd+/t6/T/I9QFCHsi+gcMomJFVa7ZLsqdOX6uWZg=;
	b=eWbbtdtOfLsZiZcNne86jekbsLCwozzSBlkEHIlQrYhWPqGSjo9b+npLAPfX8DkjXFM56t
	MHz+4VEs3F4lPy22g79/522qIchYPlnaEXahsJThkKrpKJx0dnGCMxfr025QhpLVv0NfYv
	rAhgGCvxP4nM5Mr/v5ZWUVnTLx9L/tY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710781645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qJZVd+/t6/T/I9QFCHsi+gcMomJFVa7ZLsqdOX6uWZg=;
	b=SjSCGtwrz2xaeId9fVFnKt9Q87nZpbeDyOifBMGZ1ImmOGPfmMwsLD21+VHHMSSligcrA+
	njFbUXQwDPx1KqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0036C136A5;
	Mon, 18 Mar 2024 17:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cYsDAM10+GUtdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 Mar 2024 17:07:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 997CCA07D9; Mon, 18 Mar 2024 18:07:24 +0100 (CET)
Date: Mon, 18 Mar 2024 18:07:24 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	tim.c.chen@linux.intel.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] fs/writeback: avoid to writeback non-expired
 inode in kupdate writeback
Message-ID: <20240318170724.zatj2bgfv36fkkos@quack3>
References: <20240228091958.288260-1-shikemeng@huaweicloud.com>
 <20240228091958.288260-2-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228091958.288260-2-shikemeng@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Wed 28-02-24 17:19:53, Kemeng Shi wrote:
> In kupdate writeback, only expired inode (have been dirty for longer than
> dirty_expire_interval) is supposed to be written back. However, kupdate
> writeback will writeback non-expired inode left in b_io or b_more_io from
> last wb_writeback. As a result, writeback will keep being triggered
> unexpected when we keep dirtying pages even dirty memory is under
> threshold and inode is not expired. To be more specific:
> Assume dirty background threshold is > 1G and dirty_expire_centisecs is
> > 60s. When we running fio -size=1G -invalidate=0 -ioengine=libaio
> --time_based -runtime=60... (keep dirtying), the writeback will keep
> being triggered as following:
> wb_workfn
>   wb_do_writeback
>     wb_check_background_flush
>       /*
>        * Wb dirty background threshold starts at 0 if device was idle and
>        * grows up when bandwidth of wb is updated. So a background
>        * writeback is triggered.
>        */
>       wb_over_bg_thresh
>       /*
>        * Dirtied inode will be written back and added to b_more_io list
>        * after slice used up (because we keep dirtying the inode).
>        */
>       wb_writeback
> 
> Writeback is triggered per dirty_writeback_centisecs as following:
> wb_workfn
>   wb_do_writeback
>     wb_check_old_data_flush
>       /*
>        * Write back inode left in b_io and b_more_io from last wb_writeback
>        * even the inode is non-expired and it will be added to b_more_io
>        * again as slice will be used up (because we keep dirtying the
>        * inode)
>        */
>       wb_writeback
> 
> Fix this by moving non-expired inode to dirty list instead of more io
> list for kupdate writeback in requeue_inode.
> 
> Test as following:
> /* make it more easier to observe the issue */
> echo 300000 > /proc/sys/vm/dirty_expire_centisecs
> echo 100 > /proc/sys/vm/dirty_writeback_centisecs
> /* create a idle device */
> mkfs.ext4 -F /dev/vdb
> mount /dev/vdb /bdi1/
> /* run buffer write with fio */
> fio -name test -filename=/bdi1/file -size=800M -ioengine=libaio -bs=4K \
> -iodepth=1 -rw=write -direct=0 --time_based -runtime=60 -invalidate=0
> 
> Fio result before fix (run three tests):
> 1360MB/s
> 1329MB/s
> 1455MB/s
> 
> Fio result after fix (run three tests):
> 1737MB/s
> 1729MB/s
> 1789MB/s
> 
> Writeback for non-expired inode is gone as expeted. Observe this with trace
> writeback_start and writeback_written as following:
> echo 1 > /sys/kernel/debug/tracing/events/writeback/writeback_start/enab
> echo 1 > /sys/kernel/debug/tracing/events/writeback/writeback_written/enable
> cat /sys/kernel/tracing/trace_pipe
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 5ab1aaf805f7..4e6166e07eaf 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1561,7 +1561,8 @@ static void inode_sleep_on_writeback(struct inode *inode)
>   * thread's back can have unexpected consequences.
>   */
>  static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
> -			  struct writeback_control *wbc)
> +			  struct writeback_control *wbc,
> +			  unsigned long dirtied_before)
>  {
>  	if (inode->i_state & I_FREEING)
>  		return;
> @@ -1594,7 +1595,8 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
>  		 * We didn't write back all the pages.  nfs_writepages()
>  		 * sometimes bales out without doing anything.
>  		 */
> -		if (wbc->nr_to_write <= 0) {
> +		if (wbc->nr_to_write <= 0 &&
> +		    !inode_dirtied_after(inode, dirtied_before)) {
>  			/* Slice used up. Queue for next turn. */
>  			requeue_io(inode, wb);
>  		} else {
> @@ -1862,6 +1864,11 @@ static long writeback_sb_inodes(struct super_block *sb,
>  	unsigned long start_time = jiffies;
>  	long write_chunk;
>  	long total_wrote = 0;  /* count both pages and inodes */
> +	unsigned long dirtied_before = jiffies;
> +
> +	if (work->for_kupdate)
> +		dirtied_before = jiffies -
> +			msecs_to_jiffies(dirty_expire_interval * 10);
>  
>  	while (!list_empty(&wb->b_io)) {
>  		struct inode *inode = wb_inode(wb->b_io.prev);
> @@ -1967,7 +1974,7 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		spin_lock(&inode->i_lock);
>  		if (!(inode->i_state & I_DIRTY_ALL))
>  			total_wrote++;
> -		requeue_inode(inode, tmp_wb, &wbc);
> +		requeue_inode(inode, tmp_wb, &wbc, dirtied_before);
>  		inode_sync_complete(inode);
>  		spin_unlock(&inode->i_lock);
>  
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

