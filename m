Return-Path: <linux-fsdevel+bounces-52541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC7EAE3EC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1259170FE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718132417C3;
	Mon, 23 Jun 2025 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TmTquzXb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1m+ZVodl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TmTquzXb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1m+ZVodl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDDB221F1E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679944; cv=none; b=MolT/Q3NhB12zlGEPH1Kw9kS341YO44sGxCpO+BgclodLQ5LcYGI7x91q7Ky6Sd31PWVHXvRJ0zGns5ygVVPITkvLA2qwspJCBthxAMlX0c7rCbCDDoTA1Uutu/7cYvx6pkecAm6FG6VHXpur0n5rOVl1ZIp2XHili+9phsCfxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679944; c=relaxed/simple;
	bh=1zHRjNkpesi7VD5FCHUQTOxCYQIgwUW7CPA7r2lBm4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/i9xqDT4qE/XQ7xA1MlvIhtmeJaZadvhlUULxDub2ZQntqcDsEA3d4ErqKPXIRaYCPv2q9w4vll+zAJbB4iUp3oYDpw2ECrmB/f5lvu4hd8f0wHGL3IARrqIBvRy5OvFKkdn80kwRW6ZtWooz4To5hmWyM5GGYZWNJ+EYAa/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TmTquzXb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1m+ZVodl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TmTquzXb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1m+ZVodl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 785091F388;
	Mon, 23 Jun 2025 11:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750679941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JtrHDjLpQewB160oW+ku/EwiCtSl/2iTXGBi+eX3wD4=;
	b=TmTquzXbr6ffDw7Pz0UBGmfD5WMg7bYFzMUtJ84gmhIO5ZuswPRdhpuOfsFU/ukPePy45E
	KZoNz5Eb/eJ/abj1AfLqXy1SO1rXQ02GVkfX1wxjAjlz/ZqwuEhFMdCJ4xHPdFlCDmvxbd
	3MHZTN9k00EvEpqjjEP7+gYcNgqZEFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750679941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JtrHDjLpQewB160oW+ku/EwiCtSl/2iTXGBi+eX3wD4=;
	b=1m+ZVodl/SRCoFN/q4CnBK1ph/2HhIeopLKGh7wtg9Xs/qbrYM04sGNqKCof4ksXRWlMtv
	hBH4zKqOe2IhQvDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TmTquzXb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1m+ZVodl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750679941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JtrHDjLpQewB160oW+ku/EwiCtSl/2iTXGBi+eX3wD4=;
	b=TmTquzXbr6ffDw7Pz0UBGmfD5WMg7bYFzMUtJ84gmhIO5ZuswPRdhpuOfsFU/ukPePy45E
	KZoNz5Eb/eJ/abj1AfLqXy1SO1rXQ02GVkfX1wxjAjlz/ZqwuEhFMdCJ4xHPdFlCDmvxbd
	3MHZTN9k00EvEpqjjEP7+gYcNgqZEFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750679941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JtrHDjLpQewB160oW+ku/EwiCtSl/2iTXGBi+eX3wD4=;
	b=1m+ZVodl/SRCoFN/q4CnBK1ph/2HhIeopLKGh7wtg9Xs/qbrYM04sGNqKCof4ksXRWlMtv
	hBH4zKqOe2IhQvDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5934713485;
	Mon, 23 Jun 2025 11:59:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mz3oFYVBWWjHOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Jun 2025 11:59:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B3AC8A0951; Mon, 23 Jun 2025 13:58:51 +0200 (CEST)
Date: Mon, 23 Jun 2025 13:58:51 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 7/9] fhandle: add EXPORT_OP_AUTONOMOUS_HANDLES marker
Message-ID: <qonvmbf5cqgcj6rshspxfjwb537vz25ahi2jk773gqgppplydh@7ohq6aw3qhez>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-7-75899d67555f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623-work-pidfs-fhandle-v1-7-75899d67555f@kernel.org>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 785091F388
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 23-06-25 11:01:29, Christian Brauner wrote:
> Allow a filesystem to indicate that it supports encoding autonomous file
> handles that can be decoded without having to pass a filesystem for the
> filesystem. In other words, the file handle uniquely identifies the
> filesystem.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

...

> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 45b38a29643f..959a1f7d46d0 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -194,7 +194,8 @@ struct handle_to_path_ctx {
>  /* Flags supported in encoded handle_type that is exported to user */
>  #define FILEID_IS_CONNECTABLE	0x10000
>  #define FILEID_IS_DIR		0x20000
> -#define FILEID_VALID_USER_FLAGS	(FILEID_IS_CONNECTABLE | FILEID_IS_DIR)
> +#define FILEID_IS_AUTONOMOUS	0x40000
> +#define FILEID_VALID_USER_FLAGS	(FILEID_IS_CONNECTABLE | FILEID_IS_DIR | FILEID_IS_AUTONOMOUS)

Is there a reason for FILEID_IS_AUTONOMOUS? As far as I understand the
fh_type has to encode filesystem type anyway so that you know which root to
pick. So FILEID_IS_AUTONOMOUS is just duplicating the information? But
maybe there's some benefit in having FILEID_IS_AUTONOMOUS which I'm
missing...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

