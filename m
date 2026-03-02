Return-Path: <linux-fsdevel+bounces-78891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCz/EneLpWk4DgYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:07:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 563561D9773
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8BC0303A8BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F583E0C61;
	Mon,  2 Mar 2026 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sa0eumLa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z+bGIWNS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p/KXgvPs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FZQ/Ame9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BED336495A
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772456500; cv=none; b=gdMFV3er2vaR+6Jwm677xqUjQkQy9Lseg1zv1hhATAOsscSsJFXcz0+/vmDaOt1Q7+H7OAyORln54cNuhaBeN/ACdVfxapPK6fR7rjvtXMmWvBDXABe1JpQXTz6t83XYkwEiIA+pOS3QXdqH1NC3CKvDD2zMzrDqeVPFBdu02pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772456500; c=relaxed/simple;
	bh=xGwSV26LdCjiNLhVbbZlN+97mEotcPLH1qgtIlOwu0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/OeIsCLo0+xB6koFkv90UTJH7Sbv3inR+X3Hpo4jvpOoU15A1fyR1sQL6b+wf1y2iAmPwmdZ9k7hFl1CjwEljU6zuluRIPbMnfCEBi/DE4i0OYftZnKyQrqRAdwhb+rOyYIRMF/Pe8sobLQZzxonAMrIC7cK6pRCt6PYw1NiFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sa0eumLa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z+bGIWNS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p/KXgvPs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FZQ/Ame9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6063C3E71B;
	Mon,  2 Mar 2026 13:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772456496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=veDmyBVTWr5b7pSCd1QFkoCpBzq0+j/LESeohDLDHy4=;
	b=Sa0eumLaJeBR5mLZ4afeMWYmxWUZ6PTmIRcmrOKazeUGqxa04Q/t4KzNbFe0KjEkEMXpeP
	uI7Sg6KXmaiOhIibv+t2aAtdNoVOy83Q1yyC11cBTjlwYeia5UBVc9TDwAe6sUfMQGGkYg
	yUqoGmTsBwov3Ok/hINs5z3oLRZ7W7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772456496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=veDmyBVTWr5b7pSCd1QFkoCpBzq0+j/LESeohDLDHy4=;
	b=z+bGIWNS5lIoqQ0qevO80196eirz12+NtcwLvBCs+UxoQP/oPfA7u0XGw+J8imhf8JkPz+
	UPH3jDps4cWugaBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772456493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=veDmyBVTWr5b7pSCd1QFkoCpBzq0+j/LESeohDLDHy4=;
	b=p/KXgvPsHgJIEhyAMxziR3IRqhbHmjwtiH7FzJl8dL1oi9h6a0uLiIc2SAGxu2FZWKnfsy
	kergXLW8zoQTnbVxpU6IYQ+p+Q1r5V7oJriXSg1NkC9A0mK3PRyrcr+mYZPiQb5nJ4KXge
	THPtqbFlnpLHGOZenjPFW4xS6BQqyBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772456493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=veDmyBVTWr5b7pSCd1QFkoCpBzq0+j/LESeohDLDHy4=;
	b=FZQ/Ame9DtN+xIy8pjv/131WN/5jM2thsSUOpDdpSGP90eAyITMLJeEWd64z9Lr+p6SXfo
	Zy+5dJt2aGg+hqDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 560513EA69;
	Mon,  2 Mar 2026 13:01:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dGT4FC2KpWkiWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Mar 2026 13:01:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0D2E1A0A0B; Mon,  2 Mar 2026 14:01:33 +0100 (CET)
Date: Mon, 2 Mar 2026 14:01:33 +0100
From: Jan Kara <jack@suse.cz>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com, 
	brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] ext4: avoid infinite loops caused by data conflicts
Message-ID: <4x3xixojbclwq45cpitmylbhis4ya4g3sugtnmj2yzv6avngqb@5xkwu6l467rm>
References: <699ebd11.a00a0220.21906d.0005.GAE@google.com>
 <tencent_4C5966F83C65375A97D236684A6C75237609@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4C5966F83C65375A97D236684A6C75237609@qq.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78891-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,qq.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:dkim,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel,1659aaaaa8d9d11265d7];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 563561D9773
X-Rspamd-Action: no action

On Sun 01-03-26 18:12:47, Edward Adam Davis wrote:
> In the execution paths of mkdir and openat, there are two different
> structures, struct ext4_xattr_header and struct ext4_dir_entry_2,
> that both reference the same buffer head.
> 
> In the mkdir path, ext4_add_entry() first sets the rec_len member of
> the struct ext4_dir_entry_2 to 2048, and then sets the file_type value
> to 2 in add_dirent_to_buf()->ext4_insert_dentry()->ext4_set_de_type().

If I understand it right, the filesystem is corrupted so that directory
block of some directory is also pointed to as xattr block of some inode.
The right question to investigate here is why the block passed validation
as both xattr block and directory block - that needs explanation. Likely
metadata checksums were disabled and with some effort we could then create
a block that will be both valid directory block and valid xattr block. If
that is indeed the case, this is game over and we can't fix this in ext4
(the kernel just doesn't have enough resources to validate against such
cases) - enable metadata checksums if you need to protect against such
corruptions.

Your attempt at a "fix" changes the on disk filesystem format. I don't
think you've put too much thought into that, did you?

								Honza

> This causes the h_refcount value in the other struct ext4_xattr_header,
> which references the same buffer head, to be too large in the openat
> path.
> 
> The above causes ext4_xattr_block_set() to enter an infinite loop about
> "inserted" and cannot release the inode lock, ultimately leading to the
> 143s blocking problem mentioned in [1].
> 
> When accessing the ext4_xattr_header structure in xattr, the accessed
> buffer head data is placed after ext4_dir_entry_2 to prevent data
> collisions caused by data overlap.
> 
> [1]
> INFO: task syz.0.17:5995 blocked for more than 143 seconds.
> Call Trace:
>  inode_lock_nested include/linux/fs.h:1073 [inline]
>  __start_dirop fs/namei.c:2923 [inline]
>  start_dirop fs/namei.c:2934 [inline]
> 
> Reported-by: syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1659aaaaa8d9d11265d7
> Tested-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
> Reported-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=512459401510e2a9a39f
> Tested-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/ext4/ext4.h  | 2 ++
>  fs/ext4/xattr.c | 2 +-
>  fs/ext4/xattr.h | 3 ++-
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 293f698b7042..4b72da4d646f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2425,6 +2425,8 @@ struct ext4_dir_entry_2 {
>  	char	name[EXT4_NAME_LEN];	/* File name */
>  };
>  
> +#define DIFF_AREA_DE_XH sizeof(struct ext4_dir_entry_2)
> +
>  /*
>   * Access the hashes at the end of ext4_dir_entry_2
>   */
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 7bf9ba19a89d..313c460a93c5 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2160,7 +2160,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
>  				error = -EIO;
>  				goto getblk_failed;
>  			}
> -			memcpy(new_bh->b_data, s->base, new_bh->b_size);
> +			memcpy(new_bh->b_data + DIFF_AREA_DE_XH, s->base, new_bh->b_size);
>  			ext4_xattr_block_csum_set(inode, new_bh);
>  			set_buffer_uptodate(new_bh);
>  			unlock_buffer(new_bh);
> diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
> index 1fedf44d4fb6..4a28023c72e8 100644
> --- a/fs/ext4/xattr.h
> +++ b/fs/ext4/xattr.h
> @@ -8,6 +8,7 @@
>  */
>  
>  #include <linux/xattr.h>
> +#include "ext4.h"
>  
>  /* Magic value in attribute blocks */
>  #define EXT4_XATTR_MAGIC		0xEA020000
> @@ -90,7 +91,7 @@ struct ext4_xattr_entry {
>  #define EXT4_XATTR_MIN_LARGE_EA_SIZE(b)					\
>  	((b) - EXT4_XATTR_LEN(3) - sizeof(struct ext4_xattr_header) - 4)
>  
> -#define BHDR(bh) ((struct ext4_xattr_header *)((bh)->b_data))
> +#define BHDR(bh) ((struct ext4_xattr_header *)((bh)->b_data + DIFF_AREA_DE_XH))
>  #define ENTRY(ptr) ((struct ext4_xattr_entry *)(ptr))
>  #define BFIRST(bh) ENTRY(BHDR(bh)+1)
>  #define IS_LAST_ENTRY(entry) (*(__u32 *)(entry) == 0)
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

