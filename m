Return-Path: <linux-fsdevel+bounces-54011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B08AFA068
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 16:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CBB3B38A7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767D81CEEBE;
	Sat,  5 Jul 2025 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YpgW4ZNR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7VT+xvX2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DIEJxwfM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y+KdtF2P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61D119F127
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Jul 2025 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751724643; cv=none; b=Lq4RaCHjW+HbEf2cfxfVRx3V01IdodeDiCju8OjCr0Z0Nq/yGl3pahnQl5XiRXS3nDUP3g69kC/ENsqv5I8cEzLTDUXxd82sEaDfVzPckhIphpM+DM72tQPkuDXdNimzXiFuWxmu0j6JHhoK9SscjDAlmTDWnO5fnMp6+XIgKNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751724643; c=relaxed/simple;
	bh=uFWP1yVlWwHpan2UUQu3W2Q2ZAeFTZB+WGf43ph5Bpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7QIF5GXuMnzNCoqvCu+GcFIDRtuHoZXPHjfpL1A2tdqKKYZVsnxYBeWkc1sMxq6Nh/5LxsVrM92MF3Ac9ce7Dsmt/bBOKAJxkKOYNZw/88W/WAMZWFMiXoHjoYqIY/XEHNwuXd1ftnH23MrdcUP/6ce22l7QIutEIaS2ofq7Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YpgW4ZNR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7VT+xvX2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DIEJxwfM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y+KdtF2P; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7ADA21F798;
	Sat,  5 Jul 2025 14:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751724639;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DHsmwlKEc0DRmfUNr+JK88nlJBJC/WcwUSl3fq9b7rY=;
	b=YpgW4ZNRdC1TnLZ+AOuN0y7SbyH5tYCsBLOlcRCZUuqifiHYMFBGaqCB3sSLzks0aZCtQG
	9RfBcSRXNZfy1F1w4yKlWyGFIfOrzJaoQSiBGszLTPUjhqpjGI4HJDcBIzQ4w0FiW4yDGa
	ATQzWmkFN+W2gBMOJBYhZBI+w5ZCwS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751724639;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DHsmwlKEc0DRmfUNr+JK88nlJBJC/WcwUSl3fq9b7rY=;
	b=7VT+xvX2jrFzvhUSms2ZrEhLuBjMLYxnQuP5IZ2q6K26k/+OPdCAj+MLTZtDA+mNkF6Vt6
	5bxHbwOzuU6CW7Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DIEJxwfM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Y+KdtF2P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751724638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DHsmwlKEc0DRmfUNr+JK88nlJBJC/WcwUSl3fq9b7rY=;
	b=DIEJxwfMa7AWdoxSdSMASeP32OmNCnL+dxhOULuReXbEWvrLFaFwkHps4NqMgIx9aQKPp7
	ATBYWy5S6z2FD5iZ/b1hekrRAgoh5wmFLBuQKF8EZPZeCfU9WcJMuRMVP/fTmcNkUKBd4l
	m8OFiBhZZu8mRSzxFRsBCNgkdFXl5hE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751724638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DHsmwlKEc0DRmfUNr+JK88nlJBJC/WcwUSl3fq9b7rY=;
	b=Y+KdtF2PK/R4DFc2bGCs7H07w6gtVOcpXovRWuwvP9sgloIuaTrKR3GgxlNF5kEpBJKHUR
	Ne4/3Q2JXhJvBNCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4381C13757;
	Sat,  5 Jul 2025 14:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W6/FD14yaWjFXQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 05 Jul 2025 14:10:38 +0000
Date: Sat, 5 Jul 2025 16:10:33 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH v4 3/6] btrfs: reject file operations if in shutdown state
Message-ID: <20250705141033.GB4453@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1751589725.git.wqu@suse.com>
 <e818baae5bc6c55ceb9ee6ae56fe1ddafea04ac8.1751589725.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e818baae5bc6c55ceb9ee6ae56fe1ddafea04ac8.1751589725.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7ADA21F798
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.com:email]
X-Spam-Score: -4.21

On Fri, Jul 04, 2025 at 10:12:31AM +0930, Qu Wenruo wrote:
> This includes the following callbacks of file_operations:
> 
> - read_iter()
> - write_iter()
> - mmap()
> - open()
> - remap_file_range()
> - uring_cmd()
> - splice_read()
>   This requires a small wrapper to do the extra shutdown check, then call
>   the regular filemap_splice_read() function
> 
> This should reject most of the file operations on a shutdown btrfs.
> 
> The callback ioctl() is intentionally skipped, as ext4 doesn't do the
> shutdown check on ioctl() either, thus I believe there is some special
> require for ioctl() callback even if the fs is fully shutdown.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/file.c    | 25 ++++++++++++++++++++++++-
>  fs/btrfs/ioctl.c   |  3 +++
>  fs/btrfs/reflink.c |  3 +++
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 05b046c6806f..cb7d1d53fc13 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1419,6 +1419,8 @@ ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
>  	struct btrfs_inode *inode = BTRFS_I(file_inode(file));
>  	ssize_t num_written, num_sync;
>  
> +	if (unlikely(btrfs_is_shutdown(inode->root->fs_info)))

This looks like a repetitive pattern, it would be better to do something
like

#define IS_SHUTDOWN(fs_info) (unlikely(btrfs_is_shutdown(fs_info))

Eventually we can use _Generic to pick the fs_info from the most
commonly used types, like inode or root.

