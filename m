Return-Path: <linux-fsdevel+bounces-25015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676F2947BBB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 15:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8386F1C21B99
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 13:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEE215ADB8;
	Mon,  5 Aug 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sYgGW5Y+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6sB68xiQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tfuZLTHk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="54uX4sX/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9726E17C;
	Mon,  5 Aug 2024 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722864125; cv=none; b=BLFsbROR2IMiyluZ2YeFwxDqkWXIceQ/J5/nV5Od4OteDnxiOwn71kaX3a0C2IGGLbIudU1mTnmL2hDg02DoqZnrWHOfhFPuSmenoEhcfiLwL/YPb/D3vXQ9hj9Yh6/JF2iI18H+RxRR3gzbuEcmHHNOyJJjcW9QfCyf4dJ/L5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722864125; c=relaxed/simple;
	bh=7OGfwR/zgwwBxPUx6yGDlYM0xucqRFsFQ6xPDDzHxsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lob/DU8fU9rgwAk2O70mAqJgZxh9u0CFLNR9ZCfuH0c2zU5731P2dvWJ2dXOqRuK2Sxc9NkcH+78F/NT6hVh8+fkggtFoIGQAPMlezNOTarSRMESWh9CIlbuzOUMR0noXXf9f39HKJD0wXJ54tWUMlsLW1WT2W9G+zRuvbaGHaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sYgGW5Y+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6sB68xiQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tfuZLTHk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=54uX4sX/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 524BE1F841;
	Mon,  5 Aug 2024 13:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722864121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8WfQjMRo2kMlAm3AB0Jn5+W7504SrHL0ERodIfmovWI=;
	b=sYgGW5Y+qcmxFzGpmgCFNRNGTYb0cWhFJ6E/MZSzfUH4fGEdhtGXtG4gpy43plMXbDsMVK
	HY4JYblOuCfQr1FBa1G/1wYtPe2hvjzD19JomUZL5el9eA4fqb/15eFvFCmfbovtfOMbaX
	k7xPBJSVpV1RWO2Pbznyt1FGmroWcbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722864121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8WfQjMRo2kMlAm3AB0Jn5+W7504SrHL0ERodIfmovWI=;
	b=6sB68xiQPQiZYzEUAUflQD2OjeKQKib5d8aJprgNtcu8XBNmIvvThmGe//nmA13b5CNwcp
	JEaqUmfxA46KEuAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tfuZLTHk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="54uX4sX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722864120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8WfQjMRo2kMlAm3AB0Jn5+W7504SrHL0ERodIfmovWI=;
	b=tfuZLTHkkqpRtsD0J91NTTZ1lplsp6uJfQ9gHZ5d0Fqpd4Kb16uPgwWQp+7HV9MBOXK+RH
	ZE56yQRfDocMRl57RFDVo3VSOyJwSbSqqu9HQ7mD5xKvVN3k99iBboqGRq5LCoQa4aK6wP
	XhWwfOImiZeYauXeTYeXRP+uIUqW5eM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722864120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8WfQjMRo2kMlAm3AB0Jn5+W7504SrHL0ERodIfmovWI=;
	b=54uX4sX/Bi+THKFhz45YnknzmF3BTYucIXTum2Ds96zQI9dFOQC0WybzCXm29xIJEgtc8w
	0QpeCAEuz3fCZYAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4681013ACF;
	Mon,  5 Aug 2024 13:22:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2O4xEfjRsGaONwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Aug 2024 13:22:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EAC58A0897; Mon,  5 Aug 2024 15:21:59 +0200 (CEST)
Date: Mon, 5 Aug 2024 15:21:59 +0200
From: Jan Kara <jack@suse.cz>
To: Joel Savitz <jsavitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] file: remove outdated comment after close_fd()
Message-ID: <20240805132159.gumu57vmj7hrru6o@quack3>
References: <20240803025455.239276-1-jsavitz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803025455.239276-1-jsavitz@redhat.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 524BE1F841
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.org.uk:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Fri 02-08-24 22:54:55, Joel Savitz wrote:
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> 
> The comment on EXPORT_SYMBOL(close_fd) was added in commit 2ca2a09d6215
> ("fs: add ksys_close() wrapper; remove in-kernel calls to sys_close()"),
> before commit 8760c909f54a ("file: Rename __close_fd to close_fd and remove
> the files parameter") gave the function its current name, however commit
> 1572bfdf21d4 ("file: Replace ksys_close with close_fd") removes the
> referenced caller entirely, obsoleting this comment.
> 
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index a3b72aa64f11..cfc58b782bc4 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -676,7 +676,7 @@ int close_fd(unsigned fd)
>  
>  	return filp_close(file, files);
>  }
> -EXPORT_SYMBOL(close_fd); /* for ksys_close() */
> +EXPORT_SYMBOL(close_fd);
>  
>  /**
>   * last_fd - return last valid index into fd table
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

