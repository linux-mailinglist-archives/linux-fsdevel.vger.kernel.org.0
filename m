Return-Path: <linux-fsdevel+bounces-12575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DB686130A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4BB11F254B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87BA823A9;
	Fri, 23 Feb 2024 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="isGHVTgz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DYBMofGE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c5sBL+k7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O7729KZl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3A381ADE;
	Fri, 23 Feb 2024 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695737; cv=none; b=Ny8LnRJcZ/S8848VwwpiwK7H14JcgEfKWv28jZ7YptBX4CjGQN6yAjUS5YAPIm2GgG3WDBmltQU9yv7pG0iOQViMCTTsFZj4srv6uI0iplSi+MbfBLf+FJBkYoG8C/yspJSQ27D8wUtMLznsUp8aBkYWqQgL9sAaDTo5yd53IA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695737; c=relaxed/simple;
	bh=co9TBmahRWlnnr+BIl5fYCTO6yVhwLHWKyr1ZWa40Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZW4x8XDDhN3d4nI0Qxxc723D2sWw5jz+mAaIVls3c9UWYiYctBFGEKBNk321VLjICCv8QxA8XtveTLnFP0LINy3yfYwyCx+bANB3hKC2yU8vMxxA76/8+A2l/sno2qFG6RmvsJKPlyJah5Iuigq11B9ztF5jlVihpdz/71ht3x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=isGHVTgz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DYBMofGE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c5sBL+k7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O7729KZl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A4C921FAD;
	Fri, 23 Feb 2024 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708695733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eeTtVEXkupSTa/3nDQq0eO36PeKJG/GQj2FgA1Q5D5I=;
	b=isGHVTgzOce/eXrISdmIxLNDM19t2ME6ojdwZfOL13ZFjnCZ91rdbDWlUPcVq0yd50kSDM
	99u6ofhDLNAgJyR8wkFROqvT2oGCbvVAbLuncD+QLj2khHtJq6R2gdgJbEO0gz/D9F4nk5
	WnzcPxN7LW9KD/V3/3VHqPtqPxb9X5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708695733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eeTtVEXkupSTa/3nDQq0eO36PeKJG/GQj2FgA1Q5D5I=;
	b=DYBMofGEE9XkGbRx76zulJl0PY9JyMl3jj1fRt4CRQ9n/KQj6iJR3mcybWKoIUXusRRrxC
	2srWSOfz1uyMiKBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708695732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eeTtVEXkupSTa/3nDQq0eO36PeKJG/GQj2FgA1Q5D5I=;
	b=c5sBL+k7DIsv/spwyNaWv8589+hwVdRdLicY0fNCaiB5tXTH3zBG1vNMY1134DdBhSzEDB
	2RTwrpaeaHSTx7n+xDRAi5hHJPT85K1YXYoRwIghnpf1xxbelinVHswnl8nkrwAZnMmez4
	osBJoHlpwJ5SdbHHBr4PZhOzwugdkmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708695732;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eeTtVEXkupSTa/3nDQq0eO36PeKJG/GQj2FgA1Q5D5I=;
	b=O7729KZlKuf4ZDApvUwkQEbctptmlwVpYbGuiAHWm30+xwIEBePBDl1H8rBfjHdN5Hak+G
	7rdQ2Z7YPtK6YdDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BE4613776;
	Fri, 23 Feb 2024 13:42:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id JU4PGrSg2GXAegAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 23 Feb 2024 13:42:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E5B5A07D1; Fri, 23 Feb 2024 14:42:12 +0100 (CET)
Date: Fri, 23 Feb 2024 14:42:12 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] fs/writeback: avoid to writeback non-expired inode
 in kupdate writeback
Message-ID: <20240223134212.g6m7oluhkjlpur2r@quack3>
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
 <20240208172024.23625-2-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208172024.23625-2-shikemeng@huaweicloud.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri 09-02-24 01:20:18, Kemeng Shi wrote:
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
> Fix this by moving non-expired inode in io list from last wb_writeback to
> dirty list in kudpate writeback.
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
> Result before fix (run three tests):
> 1360MB/s
> 1329MB/s
> 1455MB/s
> 
> Result after fix (run three tests);
> 790MB/s
> 1820MB/s
> 1804MB/s
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

OK, I don't find this a particularly troubling problem but I agree it might
be nice to fix. But filtering the lists in wb_writeback() like this seems
kind of wrong - the queueing is managed in queue_io() and I'd prefer to
keep it that way. What if we just modified requeue_inode() to not
requeue_io() inodes in case we are doing kupdate style writeback and inode
isn't expired?

Sure we will still possibly writeback unexpired inodes once before calling
redirty_tail_locked() on them but that shouldn't really be noticeable?

								Honza
> ---
>  fs/fs-writeback.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 5ab1aaf805f7..a9a918972719 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2046,6 +2046,23 @@ static long writeback_inodes_wb(struct bdi_writeback *wb, long nr_pages,
>  	return nr_pages - work.nr_pages;
>  }
>  
> +static void filter_expired_io(struct bdi_writeback *wb)
> +{
> +	struct inode *inode, *tmp;
> +	unsigned long expired_jiffies = jiffies -
> +		msecs_to_jiffies(dirty_expire_interval * 10);
> +
> +	spin_lock(&wb->list_lock);
> +	list_for_each_entry_safe(inode, tmp, &wb->b_io, i_io_list)
> +		if (inode_dirtied_after(inode, expired_jiffies))
> +			redirty_tail(inode, wb);
> +
> +	list_for_each_entry_safe(inode, tmp, &wb->b_more_io, i_io_list)
> +		if (inode_dirtied_after(inode, expired_jiffies))
> +			redirty_tail(inode, wb);
> +	spin_unlock(&wb->list_lock);
> +}
> +
>  /*
>   * Explicit flushing or periodic writeback of "old" data.
>   *
> @@ -2070,6 +2087,9 @@ static long wb_writeback(struct bdi_writeback *wb,
>  	long progress;
>  	struct blk_plug plug;
>  
> +	if (work->for_kupdate)
> +		filter_expired_io(wb);
> +
>  	blk_start_plug(&plug);
>  	for (;;) {
>  		/*
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

