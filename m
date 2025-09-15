Return-Path: <linux-fsdevel+bounces-61293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63409B574A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFE1443F5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ED92F3C2B;
	Mon, 15 Sep 2025 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y6rhBH2y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SJvrSjvI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dMec5VwZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NOo6WaFM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9352F3C1D
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927984; cv=none; b=qYUNiR1BcHvA88WEpput3iTyGHlp7TiMhWpA4mtl+/KjG1zZFXJydUcCnB/WgaAjBy6AIW0tPUsoGtq0VGtx9YI5pQlAsQUM+NzA0D9cq759YI4hFXifIzxZVcTsLVDiXoZh9EEXKKL879OMFi/R/6xDMRUG8IkjnbF1CzZNREA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927984; c=relaxed/simple;
	bh=XA6mXkBIPFgan+x1bf5BLCjXCwYPhLpEO9xTsEBGW0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMgUF7e9i+uSLxRuPUWdFbPk3+1LgloQy4/RZPaK/Sfq3xSmZl8Impbd5raSwfOMFbYK28EeXTWcdMlLf67hCmCWSnvLVJx3eus6xuJyyDWuN5GOXnO8+471NrwqOibDXcM0CowYbwHQjqCLDe/hD9R5Z+l3NUUIN9cpsjbEhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y6rhBH2y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SJvrSjvI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dMec5VwZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NOo6WaFM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EA1BB33712;
	Mon, 15 Sep 2025 09:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757927979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PhWypHhs76OUhW0wRhEmCSwbci4KHZ6s4gw5WflTcZE=;
	b=y6rhBH2yIHqcEhWvW3OK/M1MGL07yB+6JMwC6X/CknVE5ua038lWDkVtBxXcMW2YiW0/gB
	rSMv7hNa/JVKJWM7hARJEEPpYWbHOSmUMRbz8f4sVhqeny14kYvL5lcca9exMU9JyNeq6n
	Pyq6WFF1sN1B85usXfvLUNO8krTzzDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757927979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PhWypHhs76OUhW0wRhEmCSwbci4KHZ6s4gw5WflTcZE=;
	b=SJvrSjvI7wBdkhoQj3MZ4ZBU7tX1b1mGqMmsm9Le3rr8bw1HFENqVr83A7BDG7tAfD/H3I
	rh7jnWIRJSAAW1Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757927978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PhWypHhs76OUhW0wRhEmCSwbci4KHZ6s4gw5WflTcZE=;
	b=dMec5VwZSk27WNcuKLsJWYANLg5lWjboI6lQZXChre5tGBQy9LfQiob4gACGMYnIEyj7wt
	of5w1OHw8GaX5rzloEDHnRzUEa9We+whyL+vVkIgzkYI4qkYUE0EW8OsHCuSl7kqKZApPI
	R62vbkO0euBFSVizbuH5OjHtbfjlT3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757927978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PhWypHhs76OUhW0wRhEmCSwbci4KHZ6s4gw5WflTcZE=;
	b=NOo6WaFMZo/gSs0Cn6FVxnoIe/rbPumE4+eUSjak33WwfmR1YoYCMva3UzVfmUFBWfq4S4
	cDjh2ACDImG9O8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5CE31398D;
	Mon, 15 Sep 2025 09:19:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FQ3QMyrax2hoeQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 09:19:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 74FF7A0A2B; Mon, 15 Sep 2025 11:19:38 +0200 (CEST)
Date: Mon, 15 Sep 2025 11:19:38 +0200
From: Jan Kara <jack@suse.cz>
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, 
	initramfs@vger.kernel.org, linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>, 
	linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, devicetree@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Subject: Re: [PATCH RESEND 13/62] ext2: remove ext2_image_size and associated
 code
Message-ID: <5xr5efvf4dhy43fchbvfsxspzgde5bxezhszdgqcya4eqrocgy@lqqkaq5wok6a>
References: <20250913003842.41944-1-safinaskar@gmail.com>
 <20250913003842.41944-14-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913003842.41944-14-safinaskar@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,linuxfoundation.org,kernel.org,zeniv.linux.org.uk,suse.cz,lst.de,kernel.dk,gmail.com,cyphar.com,linutronix.de,cyberus-technology.de,linux.alibaba.com,redhat.com,amazon.com,landley.net,0pointer.de,lists.infradead.org,lists.linux.dev,lists.linux-m68k.org,lists.ozlabs.org,mit.edu,monstr.eu,linux.dev,linux.ibm.com];
	R_RATELIMIT(0.00)[to_ip_from(RLbyy5b47ky7xssyr143sji8pp)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Sat 13-09-25 00:37:52, Askar Safin wrote:
> It is not used anymore
> 
> Signed-off-by: Askar Safin <safinaskar@gmail.com>

Looks good.

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext2/ext2.h          |  9 ---------
>  include/linux/ext2_fs.h | 13 -------------
>  2 files changed, 22 deletions(-)
> 
> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index cf97b76e9fd3..d623a14040d9 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -608,15 +608,6 @@ struct ext2_dir_entry_2 {
>  					 ~EXT2_DIR_ROUND)
>  #define EXT2_MAX_REC_LEN		((1<<16)-1)
>  
> -static inline void verify_offsets(void)
> -{
> -#define A(x,y) BUILD_BUG_ON(x != offsetof(struct ext2_super_block, y));
> -	A(EXT2_SB_MAGIC_OFFSET, s_magic);
> -	A(EXT2_SB_BLOCKS_OFFSET, s_blocks_count);
> -	A(EXT2_SB_BSIZE_OFFSET, s_log_block_size);
> -#undef A
> -}
> -
>  /*
>   * ext2 mount options
>   */
> diff --git a/include/linux/ext2_fs.h b/include/linux/ext2_fs.h
> index 1fef88569037..e5ebe6cdf06c 100644
> --- a/include/linux/ext2_fs.h
> +++ b/include/linux/ext2_fs.h
> @@ -27,17 +27,4 @@
>   */
>  #define EXT2_LINK_MAX		32000
>  
> -#define EXT2_SB_MAGIC_OFFSET	0x38
> -#define EXT2_SB_BLOCKS_OFFSET	0x04
> -#define EXT2_SB_BSIZE_OFFSET	0x18
> -
> -static inline u64 ext2_image_size(void *ext2_sb)
> -{
> -	__u8 *p = ext2_sb;
> -	if (*(__le16 *)(p + EXT2_SB_MAGIC_OFFSET) != cpu_to_le16(EXT2_SUPER_MAGIC))
> -		return 0;
> -	return (u64)le32_to_cpup((__le32 *)(p + EXT2_SB_BLOCKS_OFFSET)) <<
> -		le32_to_cpup((__le32 *)(p + EXT2_SB_BSIZE_OFFSET));
> -}
> -
>  #endif	/* _LINUX_EXT2_FS_H */
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

