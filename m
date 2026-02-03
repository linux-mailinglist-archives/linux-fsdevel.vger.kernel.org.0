Return-Path: <linux-fsdevel+bounces-76169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMWsJua3gWkrJAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 09:55:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6D6D6731
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 09:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1B6B3035270
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 08:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814FF396B7B;
	Tue,  3 Feb 2026 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qfg9UBIG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="85VGgXzr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qfg9UBIG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="85VGgXzr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9900D38F243
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108892; cv=none; b=jZobWAjhK2RwjTAejMSzFmU3TWbrFBuVSt8QBaHKhwE2FFQ7424WMmr985n55hlSWOjkZLlV2BlJ9eSzQS5vWQyy7AB1Ca+GhWqlTB/SDgBuiuR6inagDjHJJonHLZgiAyugU713gyGHE85k6huyI98Jp00vP9RibFRDHkziBZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108892; c=relaxed/simple;
	bh=BWryBZZRyshDE7htWrmHtWdd9zfVnuMfoFW6bFs3XPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbVWeQrI9LCfKyPRRZXds1FGUTgg2Q9W3+K4j6bfvvGMqIg34amI6UDowF9+ij7xEmZs6utvEtDDypcEu3VS6wq5K9aYMDmQAvd4EUgzohB7lgke7PlIvjaQ/qcTsE4NpQ/x3w/5erarn6pU9VR/H0niZgr0s9VWyvLRzmVWwSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qfg9UBIG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=85VGgXzr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qfg9UBIG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=85VGgXzr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9FD95BCC3;
	Tue,  3 Feb 2026 08:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770108888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQTOyqizWTLSvlPvLkvLsGi8wPAIQqJDpShjC5krox0=;
	b=qfg9UBIGSgH//o2pc7XzE2Tdrsec5tHD04CTrKO4yR1hgamlnEAXgveGY5xySc6kVTDBMM
	FBtTNiy6cnBKNV5lFqic0T51+J3VDWmkipaUNI2E4ut3F7OCxCiWYdxXXTuQdbcoLeZSD2
	vSZF29nV5M0K0gmHt2Jx1nUeU9cJCWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770108888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQTOyqizWTLSvlPvLkvLsGi8wPAIQqJDpShjC5krox0=;
	b=85VGgXzrSzNkeSzq0o2VP6XObTC1XHtiYK5eyLdXWvx6ikNfrtbCTBjad4A/Ni2ndY0Xl4
	MkFZLxN+stAHjnCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770108888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQTOyqizWTLSvlPvLkvLsGi8wPAIQqJDpShjC5krox0=;
	b=qfg9UBIGSgH//o2pc7XzE2Tdrsec5tHD04CTrKO4yR1hgamlnEAXgveGY5xySc6kVTDBMM
	FBtTNiy6cnBKNV5lFqic0T51+J3VDWmkipaUNI2E4ut3F7OCxCiWYdxXXTuQdbcoLeZSD2
	vSZF29nV5M0K0gmHt2Jx1nUeU9cJCWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770108888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQTOyqizWTLSvlPvLkvLsGi8wPAIQqJDpShjC5krox0=;
	b=85VGgXzrSzNkeSzq0o2VP6XObTC1XHtiYK5eyLdXWvx6ikNfrtbCTBjad4A/Ni2ndY0Xl4
	MkFZLxN+stAHjnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A21253EA62;
	Tue,  3 Feb 2026 08:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +GaJJ9i3gWm2HQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Feb 2026 08:54:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 51467A08F8; Tue,  3 Feb 2026 09:54:44 +0100 (CET)
Date: Tue, 3 Feb 2026 09:54:44 +0100
From: Jan Kara <jack@suse.cz>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com, 
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Subject: Re: [PATCH v6 03/16] fs: add generic FS_IOC_SHUTDOWN definitions
Message-ID: <lr73r5xefcyv3je5ietj5wsqgdi5xwlut7u6nmxbnaxvtanmi4@zhgycwippa6o>
References: <20260202220202.10907-1-linkinjeon@kernel.org>
 <20260202220202.10907-4-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202220202.10907-4-linkinjeon@kernel.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76169-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.cz:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com,vger.kernel.org,lge.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2D6D6D6731
X-Rspamd-Action: no action

On Tue 03-02-26 07:01:49, Namjae Jeon wrote:
> Currently, several filesystems (e.g., xfs, ext4, btrfs) implement
> a "shutdown" or "going down" ioctl to simulate filesystem force a shutdown.
> While they often use the same underlying numeric value, the definition is
> duplicated across filesystem headers or private definitions.
> 
> This patch adds generic definitions for FS_IOC_SHUTDOWN in uapi/linux/fs.h.
> This allows new filesystems (like ntfs) to implement this feature using
> a standard VFS definition and paves the way for existing filesystems
> to unify their definitions later.
> 
> The flag names are standardized as FS_SHUTDOWN_* to be consistent with
> the ioctl name, replacing the historical GOING_DOWN naming convention.
> 
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

Good idea. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/uapi/linux/fs.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 66ca526cf786..32e24778c9e5 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -656,4 +656,16 @@ struct procmap_query {
>  	__u64 build_id_addr;		/* in */
>  };
>  
> +/*
> + * Shutdown the filesystem.
> + */
> +#define FS_IOC_SHUTDOWN _IOR('X', 125, __u32)
> +
> +/*
> + * Flags for FS_IOC_SHUTDOWN
> + */
> +#define FS_SHUTDOWN_FLAGS_DEFAULT	0x0
> +#define FS_SHUTDOWN_FLAGS_LOGFLUSH	0x1	/* flush log but not data*/
> +#define FS_SHUTDOWN_FLAGS_NOLOGFLUSH	0x2	/* don't flush log nor data */
> +
>  #endif /* _UAPI_LINUX_FS_H */
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

