Return-Path: <linux-fsdevel+bounces-72460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0C8CF73FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 09:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5BF33007230
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 08:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C29D30AAAE;
	Tue,  6 Jan 2026 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aCmzV12C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p/Vmesk3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aCmzV12C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p/Vmesk3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E360223B63E
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767687310; cv=none; b=iBdbplZG63Jyaaowgr6w7DDWuEPuKlya1XeQv+sxLV11O5wvxcc3a2TSFqtkXO7jGIJC65RdFZREiO8SIOvM1Ka5X1iyvHO8tZyPdqiKt351wRE683/+k2W6DyKgNdzNUMIIYUnl6/fMJ+UHpeTB/2JEViafSCL3mfuiQkPQKS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767687310; c=relaxed/simple;
	bh=qFedVycq/sLccS0QvFNDRJJZJeKGcI5HCbDPxtsW5MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujJoaUWBsshx8MpcIccWMTLF3/cgmBka4kYD0D82fquWXl7TsP1kexC9X+YuA3ulKhqAotMeifnrXcfu8B7iI4ib7u+tJpHTSug7GyArxtUrK/6tddbWU9Z6RXxgUSsmTr5WVgTja8EhidfdKC5fKj5IQymik7AhoreJsvcwKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aCmzV12C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p/Vmesk3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aCmzV12C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p/Vmesk3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9795F338FB;
	Tue,  6 Jan 2026 08:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767687306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSeZdu4HTkm7IanjiD4isRA5SjuD5qvUIvUf3zSCjJw=;
	b=aCmzV12CDZWpiaYsOTc7Nj5EGPuKQW2Y8wrSMUsYtPj9/nuhFZXETQAvkreUuB5vCc+ahB
	8iFVV+PAOE/GW+MTw5Pms96RR4O6reRBfj0dFV8wiQi2zOpritKcfgl/LEBJEcB2hifue3
	xhsGS/3ELD+94CjWZdsRcPuZua5gSEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767687306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSeZdu4HTkm7IanjiD4isRA5SjuD5qvUIvUf3zSCjJw=;
	b=p/Vmesk3piboapFzfTttsmhh3PNxRdIEuZcYwHLJElWaC1zXZbe2ZKrfGYKEZaRiPtbWpA
	a1FlA4XjeTCjwsBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aCmzV12C;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="p/Vmesk3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767687306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSeZdu4HTkm7IanjiD4isRA5SjuD5qvUIvUf3zSCjJw=;
	b=aCmzV12CDZWpiaYsOTc7Nj5EGPuKQW2Y8wrSMUsYtPj9/nuhFZXETQAvkreUuB5vCc+ahB
	8iFVV+PAOE/GW+MTw5Pms96RR4O6reRBfj0dFV8wiQi2zOpritKcfgl/LEBJEcB2hifue3
	xhsGS/3ELD+94CjWZdsRcPuZua5gSEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767687306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSeZdu4HTkm7IanjiD4isRA5SjuD5qvUIvUf3zSCjJw=;
	b=p/Vmesk3piboapFzfTttsmhh3PNxRdIEuZcYwHLJElWaC1zXZbe2ZKrfGYKEZaRiPtbWpA
	a1FlA4XjeTCjwsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 899313EA63;
	Tue,  6 Jan 2026 08:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tC1QIYrEXGn2KAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Jan 2026 08:15:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3A61BA08E3; Tue,  6 Jan 2026 09:15:06 +0100 (CET)
Date: Tue, 6 Jan 2026 09:15:06 +0100
From: Jan Kara <jack@suse.cz>
To: Yuto Ohnuki <ytohnuki@amazon.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] fs: improve dump_inode() to safely access inode
 fields.
Message-ID: <d73zx7srt4todun77vlhx4k4o5sv4q4vu2nk3iecz4eu7cih4i@6fillvgbgpgq>
References: <20260101165304.34516-1-ytohnuki@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260101165304.34516-1-ytohnuki@amazon.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 9795F338FB
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Thu 01-01-26 16:53:04, Yuto Ohnuki wrote:
> Use get_kernel_nofault() to safely access inode and related structures
> (superblock, file_system_type) to avoid crashing when the inode pointer
> is invalid. This allows the same pattern as dump_mapping().
> 
> Note: The original access method for i_state and i_count is preserved,
> as get_kernel_nofault() is unnecessary once the inode structure is
> verified accessible.
> 
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>

Very nice, thanks! Just one nit below:

> +	state = inode_state_read_once(inode);
> +	count = atomic_read(&inode->i_count);
>  
> +	if (!sb) {
> +		pr_warn("mode:%ho opflags:0x%x flags:0x%x state:0x%x count:%d\n",
> +			mode, opflags, flags, state, count);
> +		return;
> +	}

I'd merge this variant with the variant below because NULL inode->i_sb is
invalid as well and I think it's better to print that sb is invalid
explicitely instead of just not printing sb info. Otherwise feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> +
> +	if (get_kernel_nofault(s_type, &sb->s_type) || !s_type ||
> +	    get_kernel_nofault(fs_name_ptr, &s_type->name) || !fs_name_ptr) {
> +		pr_warn("invalid sb:%px mode:%ho opflags:0x%x flags:0x%x state:0x%x count:%d\n",
> +			sb, mode, opflags, flags, state, count);
> +		return;
> +	}
> +
> +	if (strncpy_from_kernel_nofault(fs_name, fs_name_ptr, sizeof(fs_name) - 1) < 0)
> +		strscpy(fs_name, "<invalid>");
> +
> +	pr_warn("fs:%s mode:%ho opflags:0x%x flags:0x%x state:0x%x count:%d\n",
> +		fs_name, mode, opflags, flags, state, count);
> +}
>  EXPORT_SYMBOL(dump_inode);
>  #endif
> -- 
> 2.50.1
> 
> 
> 
> 
> Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284
> 
> Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

