Return-Path: <linux-fsdevel+bounces-35563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B759D5DF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71641F2155A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 11:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E501DE4FC;
	Fri, 22 Nov 2024 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LJB67VJ0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q2TeauU/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="24PHf3oR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MiehijWU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6F1CBE81;
	Fri, 22 Nov 2024 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732274554; cv=none; b=qxfzxhF7QG+SEqSVgo8rXCgdbgpk/smL12neOmNxur1jLBMiV9sZPFwuyPU6NZjqiFrb63som3w35thO0SszGYlJIIAdEoR45p0FWkJmZnM+FQ4FmDlqdBhA1B1I+mXGyUFXXLKd+709sgcyQzK3QChX6m3UpOsFC1k2RHhOBV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732274554; c=relaxed/simple;
	bh=+3elVARTpgPl0+TFsdMK74bMTLEELajCRkpQMlyPAWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuiS06Bu5gORIUd4SYK5lu3B0uGxZQRvHao+dg8UwODIZCf+/W4iJ4KBEJQb7gehPnO6c0ekghJanOHaLO2Zhox+Xh9EdQkRzFsznS1e+nVDSmxC6BBt5UD8Gf6ilKeMwG2xBCDIfBS7pSWQbh6PPovzgnvmO2O9jjDALG6x4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LJB67VJ0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q2TeauU/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=24PHf3oR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MiehijWU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 961F31F37E;
	Fri, 22 Nov 2024 11:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732274549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnZ5fRolbcpG6gnZkZpzgdua/PNESxchKOKstewCQjM=;
	b=LJB67VJ0vq2ag+ZczC4yc3MsJ8RushEOXnMeGaEJkP35dgkRRzXHL3SdY3826vhUjdqnBJ
	mZlh/kvU0OdHZzJa2i3qghRlz1yH2ZAWQjifQqL7IKirV7wyoplODsHZKkrbk0IWb/McYD
	97N56cprv9H/sWtznY5mMMLSodFFhEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732274549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnZ5fRolbcpG6gnZkZpzgdua/PNESxchKOKstewCQjM=;
	b=q2TeauU/lB/5UHzZuW8TcrPCdRxI6z0l8pwCai06ljY0rNqPrCrlXedux+zo0wKpcb/fkF
	Ct9pXiaNyjQahlAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=24PHf3oR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MiehijWU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732274548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnZ5fRolbcpG6gnZkZpzgdua/PNESxchKOKstewCQjM=;
	b=24PHf3oRVIk4BLr8c6z1pdCNCQreZqFLTWKojvv8Hi5uZVaFbREaHIRL12joIRaclUVnSQ
	TPi/8NNJU16ngraNrGiygPVbxnk70Hm4kq9od0SYe3CW/sSDMilfmFyDgPWiRm5nT82V+A
	POI3QQIGMaz5oEiIFQ0rbRgnI6DJU1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732274548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnZ5fRolbcpG6gnZkZpzgdua/PNESxchKOKstewCQjM=;
	b=MiehijWUcSRmbvxBnGVMtriWuT0PjoCJQqdoTGwr1l5yXVQ7xiKT9CIpBhgQqN2mcjhzOz
	Zo7oe2BY4G82fBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8637713998;
	Fri, 22 Nov 2024 11:22:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FgJuIHRpQGcyMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 22 Nov 2024 11:22:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 285DDA08B8; Fri, 22 Nov 2024 12:22:28 +0100 (CET)
Date: Fri, 22 Nov 2024 12:22:28 +0100
From: Jan Kara <jack@suse.cz>
To: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Subject: Re: [PATCH v2] fs: Fix data race in inode_set_ctime_to_ts
Message-ID: <20241122112228.6him45jdtibue26s@quack3>
References: <20241121113546.apvyb43pnuceae3g@quack3>
 <20241122035159.441944-1-zhenghaoran@buaa.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122035159.441944-1-zhenghaoran@buaa.edu.cn>
X-Rspamd-Queue-Id: 961F31F37E
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,gmail.com,buaa.edu.cn];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 22-11-24 11:51:59, Hao-ran Zheng wrote:
> V2:
> Thanks for Honza's reply and suggestions. READ_ONCE should indeed
> be added to the reading position. I added READ_ONCE to
> `inode_get_ctime_sec()`. The new patch is as follows.
> -----------------------------------------------------------------
> V1:
> A data race may occur when the function `inode_set_ctime_to_ts()` and
> the function `inode_get_ctime_sec()` are executed concurrently. When
> two threads call `aio_read` and `aio_write` respectively, they will
> be distributed to the read and write functions of the corresponding
> file system respectively. Taking the btrfs file system as an example,
> the `btrfs_file_read_iter` and `btrfs_file_write_iter` functions are
> finally called. These two functions created a data race when they
> finally called `inode_get_ctime_sec()` and `inode_set_ctime_to_ns()`.
> The specific call stack that appears during testing is as follows:

Changelogs of the patch belong below the --- marker (so that they are not
part of the final commit message). So this changelog should look like:

A data race may occur when the function `inode_set_ctime_to_ts()` and
the function `inode_get_ctime_sec()` are executed concurrently. When
....

Signed-off-by: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>

---
<diffstat here>

changes since v1:
  - ...

<patch here>

Please see 'The canonical patch format' chapter in
Documentation/process/submitting-patches.rst for more details.

> ```

Also our changelogs are not in ReST or whatever other format. They are
plain ASCII text. Hence quotes like above are pointless and mostly reducing
readability.

> ============DATA_RACE============
> btrfs_delayed_update_inode+0x1f61/0x7ce0 [btrfs]
> btrfs_update_inode+0x45e/0xbb0 [btrfs]
> btrfs_dirty_inode+0x2b8/0x530 [btrfs]
> btrfs_update_time+0x1ad/0x230 [btrfs]
> touch_atime+0x211/0x440
> filemap_read+0x90f/0xa20
> btrfs_file_read_iter+0xeb/0x580 [btrfs]
> aio_read+0x275/0x3a0
> io_submit_one+0xd22/0x1ce0
> __se_sys_io_submit+0xb3/0x250
> do_syscall_64+0xc1/0x190
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> ============OTHER_INFO============
> btrfs_write_check+0xa15/0x1390 [btrfs]
> btrfs_buffered_write+0x52f/0x29d0 [btrfs]
> btrfs_do_write_iter+0x53d/0x1590 [btrfs]
> btrfs_file_write_iter+0x41/0x60 [btrfs]
> aio_write+0x41e/0x5f0
> io_submit_one+0xd42/0x1ce0
> __se_sys_io_submit+0xb3/0x250
> do_syscall_64+0xc1/0x190
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> ```
> 
> The call chain after traceability is as follows:
> 
> ```
> Thread1:
> btrfs_delayed_update_inode() ->
> fill_stack_inode_item() ->
> inode_get_ctime_sec()
> 
> Thread2:
> btrfs_write_check() ->
> update_time_for_write() ->
> inode_set_ctime_to_ts()
> ```

No need to repeat the stack traces again here. The output from KCSAN above
is enough.

> To address this issue, it is recommended to
> add WRITE_ONCE when writing the `inode->i_ctime_sec` variable.
> --------------------------------------------------------------

Also this line of '-' is really unexpected. Please just leave empty line
here.

> Signed-off-by: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
> ---
>  include/linux/fs.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3559446279c1..869ccfc9a787 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1655,7 +1655,7 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
>  
>  static inline time64_t inode_get_ctime_sec(const struct inode *inode)
>  {
> -	return inode->i_ctime_sec;
> +	return READ_ONCE(inode->i_ctime_sec);
>  }

Good. But please fix inode_get_ctime_nsec() as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

