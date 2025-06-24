Return-Path: <linux-fsdevel+bounces-52727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9B5AE60A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6AD1925916
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4016E27C14B;
	Tue, 24 Jun 2025 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wfNvPWes";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HrDN5L7o";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wfNvPWes";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HrDN5L7o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22630279DDF
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756664; cv=none; b=XT1v8VMhvowF9BTywFopZYU/lrekclWSUbz1/wIrKf5dxnVsnJlDAxa+nLzcD0bgm2+ryIGwHKTLZALyQ4U7gtYE/RwGCF2BBY6yup7cFOMIiLw4oGlkVPmr58+biuxZXPC2jvZTCskWaDL6RxX3BmoVnf0tcHI1TBUn6yVG324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756664; c=relaxed/simple;
	bh=9i0EDdiZ/J/JreJWJdHcHkB3ZOcp/n6zQJ5Vks1D5GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR8vNpZ5kT9etdd4Ig7f77LFVQM+WOy7b/1GuD4yhSeQ9+JECJK4Geiy/3MUbwOlwwWGi0HN+f6SZ2DxD2X1EunY25QH+YV1+ajGM+fsit7abzithm12wAQuhv81t3AYiq8V3BiNxbl+Y3mhMeOIt6mh1AxYPkHDPkdq3q1w5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wfNvPWes; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HrDN5L7o; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wfNvPWes; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HrDN5L7o; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 489A021186;
	Tue, 24 Jun 2025 09:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750756661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TC8AzdrhI045+c1Rb66Z3DOZD17u/Siac2RcTs+v0eE=;
	b=wfNvPWesGQNWu3Qarrp04sukChhmMt82BpArUzpHbCiFtlXui80MNqoYAMBaRV9bYqZQYL
	dcaJkx7JT6GmW8Uuw4CH7wF5f6DhHUBONK4uk5niX0xLQgZ5Bq4jpnzUIT3XctlKMIN+Uv
	fKPHe0SMhsQxw04JaHE2qMB2k7Vq3ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750756661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TC8AzdrhI045+c1Rb66Z3DOZD17u/Siac2RcTs+v0eE=;
	b=HrDN5L7oXl59i9LrFL19zCF0Ut9r0Y2+5AnXQC4g3HaP1DoCZPk0bIrElv77f1u5Cy+2KP
	7l+z2lETuzA/IgDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wfNvPWes;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HrDN5L7o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750756661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TC8AzdrhI045+c1Rb66Z3DOZD17u/Siac2RcTs+v0eE=;
	b=wfNvPWesGQNWu3Qarrp04sukChhmMt82BpArUzpHbCiFtlXui80MNqoYAMBaRV9bYqZQYL
	dcaJkx7JT6GmW8Uuw4CH7wF5f6DhHUBONK4uk5niX0xLQgZ5Bq4jpnzUIT3XctlKMIN+Uv
	fKPHe0SMhsQxw04JaHE2qMB2k7Vq3ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750756661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TC8AzdrhI045+c1Rb66Z3DOZD17u/Siac2RcTs+v0eE=;
	b=HrDN5L7oXl59i9LrFL19zCF0Ut9r0Y2+5AnXQC4g3HaP1DoCZPk0bIrElv77f1u5Cy+2KP
	7l+z2lETuzA/IgDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E52313751;
	Tue, 24 Jun 2025 09:17:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HXI1DzVtWmgiGgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Jun 2025 09:17:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 00A5FA0A03; Tue, 24 Jun 2025 11:17:40 +0200 (CEST)
Date: Tue, 24 Jun 2025 11:17:40 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 08/11] exportfs: add FILEID_PIDFS
Message-ID: <5culcgnj3ekcadqhx4rvvp72rh2tnlvjn2t6bm5idsveh2hsdq@3z2vfudgudl7>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-8-d02a04858fe3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-work-pidfs-fhandle-v2-8-d02a04858fe3@kernel.org>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 489A021186
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -4.01
X-Spam-Level: 

On Tue 24-06-25 10:29:11, Christian Brauner wrote:
> Introduce new pidfs file handle values.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/exportfs.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 25c4a5afbd44..5bb757b51f5c 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -131,6 +131,11 @@ enum fid_type {
>  	 * Filesystems must not use 0xff file ID.
>  	 */
>  	FILEID_INVALID = 0xff,
> +
> +	/* Internal kernel fid types */
> +
> +	/* pidfs fid type */
> +	FILEID_PIDFS = 0x100,
>  };
>  
>  struct fid {
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

