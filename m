Return-Path: <linux-fsdevel+bounces-17550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9D38AF8D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 23:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D022C1F26296
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 21:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97352143884;
	Tue, 23 Apr 2024 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ToSxqQtj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U/KvoAXA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ToSxqQtj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U/KvoAXA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E34143866;
	Tue, 23 Apr 2024 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907158; cv=none; b=BIGa3kd6lBiPN3qQhUWeXQ/9Dmd8sh+vdlbCgokoEwSX4rcPLI1VBsgn9IyLNAEgsO8j7Rcaoo3Ooha7xSmveAPsxGitr72GQF13Gnxz54SCJpxjtX+boiIPKSsKwlzmZk0wRytiGkhdExZqR9fWZI6wgPBg2INt66XGX1pF5Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907158; c=relaxed/simple;
	bh=65jyqrzopsOdGYIPlbDKl6wixPGu13rGPdjxvxmGXco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRxmYkb9o4Oo1JZqjrte7DUEyILd8N+G07tyOdsbFhA+d0H8kWYnn/69F3llGSfBVSVYJ034tvSpgnrnFWkeQajAHBPdwkgQzGPZY3gWh6ip4K/TCtV3Z8dwF6zNJIASygeNsCjeNcP5YU/O6MUmYRWtlfFV6KvhwnnauCmZBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ToSxqQtj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U/KvoAXA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ToSxqQtj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U/KvoAXA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4BEA65CFA9;
	Tue, 23 Apr 2024 21:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713907148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YyDric3YYV0XdWbcFJ6RrE+aUMRfuXf3pK3qRnTRTvM=;
	b=ToSxqQtj3qjqU0bq2rO1neq2pAHQh8D/OFN8n4vTSCSguNJokHOIDXy3fqtOFwMW8LpWNh
	RmRau+vuNWiEg7hdZmjUI1wbNKTnrOWw4PKx1bJz7Qc3R3dJp8Ud3rnZ3lhVTOeLt7Edvc
	cF1+o98DUrwUBBFFpSK7L3FDh4ehIp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713907148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YyDric3YYV0XdWbcFJ6RrE+aUMRfuXf3pK3qRnTRTvM=;
	b=U/KvoAXAEubNHHWzWLTB8CMknft+2WzOqu2Vcsu0mPVFS6KFCX3+z1DYfYDi4FjnROwXt1
	E4ThNzT8M+mCBxBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ToSxqQtj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="U/KvoAXA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713907148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YyDric3YYV0XdWbcFJ6RrE+aUMRfuXf3pK3qRnTRTvM=;
	b=ToSxqQtj3qjqU0bq2rO1neq2pAHQh8D/OFN8n4vTSCSguNJokHOIDXy3fqtOFwMW8LpWNh
	RmRau+vuNWiEg7hdZmjUI1wbNKTnrOWw4PKx1bJz7Qc3R3dJp8Ud3rnZ3lhVTOeLt7Edvc
	cF1+o98DUrwUBBFFpSK7L3FDh4ehIp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713907148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YyDric3YYV0XdWbcFJ6RrE+aUMRfuXf3pK3qRnTRTvM=;
	b=U/KvoAXAEubNHHWzWLTB8CMknft+2WzOqu2Vcsu0mPVFS6KFCX3+z1DYfYDi4FjnROwXt1
	E4ThNzT8M+mCBxBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CE8213894;
	Tue, 23 Apr 2024 21:19:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qeOYDswlKGatcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Apr 2024 21:19:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E2E0BA082F; Tue, 23 Apr 2024 23:19:03 +0200 (CEST)
Date: Tue, 23 Apr 2024 23:19:03 +0200
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Xiu Jianfeng <xiujianfeng@huawei.com>,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next] cgroup: Introduce css_is_online() helper
Message-ID: <20240423211903.aofflj5wanozhat7@quack3>
References: <20240420094428.1028477-1-xiujianfeng@huawei.com>
 <20240423134923.osuljlalsd27awz3@quack3>
 <ZifaNsx9wFDp8m-_@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZifaNsx9wFDp8m-_@slm.duckdns.org>
X-Spam-Level: 
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
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4BEA65CFA9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Tue 23-04-24 05:56:38, Tejun Heo wrote:
> Hello,
> 
> On Tue, Apr 23, 2024 at 03:49:23PM +0200, Jan Kara wrote:
> > On Sat 20-04-24 09:44:28, Xiu Jianfeng wrote:
> > > Introduce css_is_online() helper to test if whether the specified
> > > css is online, avoid testing css.flags with CSS_ONLINE directly
> > > outside of cgroup.c.
> > > 
> > > Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> > 
> > Looks good. Feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> 
> I'm a bit skeptical about these trivial helpers. If the test is something
> more involved or has complications which need documentation (e.g. regarding
> synchronization and what not), the helper would be useful even if it's just
> as a place to centrally document what's going on. However, here, it's just
> testing one flag and I'm not sure what benefits the helper brings.

Yeah OK. I felt the motivation was so that writeback code doesn't have to
peek into cgroup "internals" so I'm fine with the change from writeback
POV.  But if you don't see the point from cgroup side than sure I'm fine
without this change as well.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

