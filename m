Return-Path: <linux-fsdevel+bounces-43076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173EAA4DACF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 11:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F76163E01
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4197A1FF7B3;
	Tue,  4 Mar 2025 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VAYz5Ty7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uVbkhjAL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VAYz5Ty7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uVbkhjAL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E698D1FE46F
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084588; cv=none; b=NKzqCKUaudJVFVRLx8E8MqiqI+HkYqGsX6QM2fKykxAKULuVAqDzATSkYiRR8q/20N5p69GsxAo59xyrNfp1fspNEdGgw9E3Cx2UkzwdcyqJu4DDLjgbrXymxVDH8BGQASCStAJQW3SUchXInwHLb1Zc3xLh93hILj7hzHACiOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084588; c=relaxed/simple;
	bh=18WhqvCbD9q5ODml6hZZjlMzAICwru9ezM/RTkgD4sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDMiJRaO+AjqVshGjA4FHI2y2jZTHwHSDwgIbb0V7aWx9h2t1IkYvLjHLUSgzxhxcLL3Q0W+9VdlOjv/xXfzAcnsarhzwp1t6fe3z7qow3BXsU8nmuZQ/Ac6UaWcv2duIwEWo61ZG86ykSJhd0H4V4e99Pd7fy6NRIXoN2F2GKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VAYz5Ty7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uVbkhjAL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VAYz5Ty7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uVbkhjAL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F115B21187;
	Tue,  4 Mar 2025 10:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741084585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kq6bIMmQpRsPx+88177cEglk5IuaXzzPRRa8l7EGYHU=;
	b=VAYz5Ty7bR8FcW/I8Xp5URLT7XrKCcIlE1q9xtL9Lq2tqEb79hPd1enwmroATilQvu95CI
	NivdlswOD7lPUQTgAbe9SRxeyTldCsY5eK3LtTKJbpj5saTX4uclyMm9OKIgMHWSVjm0fU
	TxjvO3ldh+U8EG0T/RvGQK4dsopJ1CI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741084585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kq6bIMmQpRsPx+88177cEglk5IuaXzzPRRa8l7EGYHU=;
	b=uVbkhjALOkZ9uTHHo2fMWbUNZadORVU5Meiz+VKZZEx4OWusAiTbW/zluvUfVTh51kHaz+
	qKfh/hxETV88Z1Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741084585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kq6bIMmQpRsPx+88177cEglk5IuaXzzPRRa8l7EGYHU=;
	b=VAYz5Ty7bR8FcW/I8Xp5URLT7XrKCcIlE1q9xtL9Lq2tqEb79hPd1enwmroATilQvu95CI
	NivdlswOD7lPUQTgAbe9SRxeyTldCsY5eK3LtTKJbpj5saTX4uclyMm9OKIgMHWSVjm0fU
	TxjvO3ldh+U8EG0T/RvGQK4dsopJ1CI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741084585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kq6bIMmQpRsPx+88177cEglk5IuaXzzPRRa8l7EGYHU=;
	b=uVbkhjALOkZ9uTHHo2fMWbUNZadORVU5Meiz+VKZZEx4OWusAiTbW/zluvUfVTh51kHaz+
	qKfh/hxETV88Z1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCA4A1393C;
	Tue,  4 Mar 2025 10:36:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ABTZNajXxmclZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Mar 2025 10:36:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8C5EFA0912; Tue,  4 Mar 2025 11:36:24 +0100 (CET)
Date: Tue, 4 Mar 2025 11:36:24 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Pan Deng <pan.deng@intel.com>, 
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, tianyou.li@intel.com, 
	tim.c.chen@linux.intel.com, lipeng.zhu@intel.com
Subject: Re: [PATCH] fs: place f_ref to 3rd cache line in struct file to
 resolve false sharing
Message-ID: <upzftocvmcmbqrtnquww5zwtobeguhdx4arewbxayb7bdjagru@peb5hktbtv7u>
References: <20250228020059.3023375-1-pan.deng@intel.com>
 <uyqqemnrf46xdht3mr4okv6zw7asfhjabz3fu5fl5yan52ntoh@nflmsbxz6meb>
 <20250301-ermahnen-kramen-b6e90ea5b50d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301-ermahnen-kramen-b6e90ea5b50d@brauner>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat 01-03-25 11:07:12, Christian Brauner wrote:
> > > @@ -1127,6 +1127,7 @@ struct file {
> > >  		struct file_ra_state	f_ra;
> > >  		freeptr_t		f_freeptr;
> > >  	};
> > > +	file_ref_t			f_ref;
> > >  	/* --- cacheline 3 boundary (192 bytes) --- */
> > >  } __randomize_layout
> > 
> > This keeps struct file within 3 cachelines but it actually grows it from
> > 184 to 192 bytes (and yes, that changes how many file structs we can fit in
> > a slab). So instead of adding 8 bytes of padding, just pick some
> > read-mostly element and move it into the hole - f_owner looks like one
> > possible candidate.
> 
> This is what I did. See vfs-6.15.misc! Thanks!

Thanks. Looks good! BTW now I've realized that with struct file having 184
bytes, the cacheline alignment of the structure need not be the one
described by the struct definition due to the allocation starting in the
middle of the cacheline. It will introduce some noise in the results but I
guess overall this should still be a win.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

