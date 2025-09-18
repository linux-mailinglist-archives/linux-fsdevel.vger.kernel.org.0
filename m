Return-Path: <linux-fsdevel+bounces-62110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE9DB8420A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C118541132
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301ED1B85F8;
	Thu, 18 Sep 2025 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="smsSNOim";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8dPheFvY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rgOraeby";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CST8FAnX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1148286427
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191479; cv=none; b=LBA7ynoADGjda/SkyeBo0MoQ15H20De210jvUa1rJTmnj8QrtdoUP0ZhmJ870qyZ8AHCpkscIKp0oNcIQ2fEnw+oYma2T0a9SR16Z0qC00ylilPyGhRphaVSPsB8lQlPonIHSfjjhSxzGtgTBPDULvsymb4IQVC986xzK8mo7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191479; c=relaxed/simple;
	bh=3cviVv/3I8UOCOnfV72jRWbD4vTf+ix+hA+DIuJduv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpMI9v/2KupkXT01pLTIp+zyfkdGuPCgXiKpQdyNLuGbGBrVkPlI1A/9s/h+JoNSGmr+yP3iriJ3zfwm3QKuzxlnWksFdvDq6vGwPt7/5dajf4jd4Rjp0PII+NQdG7seCk/o69eRyYQVj15z0uGfOY1I6wZGk3VosMvtvNwY49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=smsSNOim; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8dPheFvY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rgOraeby; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CST8FAnX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F1DE01F7EE;
	Thu, 18 Sep 2025 10:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758191476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0Ns9XhnZ32JgcGUrHJ5Nt14DJFCCE274WJNT+vWATg=;
	b=smsSNOimHHbgK2d6iwAGvY4pBm/ej9l7gsJRBFlPqreHSXfqyjCcW2g5wx1PgqNKj8OwhN
	V7CgWKWIsDMjmMavUYD1D61rwNtd5Ksfwt9foPV9xW+lXVTBPzSNVFJBUL2BVmE1ibWg/K
	Oqyi720GpkiSGVaVyCwn93ZTkHP/ZkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758191476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0Ns9XhnZ32JgcGUrHJ5Nt14DJFCCE274WJNT+vWATg=;
	b=8dPheFvYQT/YxXZ5ZE41SYTeCT+O/wTZq6VRHM7DbB5q3UXefwn24lOb7fiADcygUL68nM
	ZBS1ZEjXo7xv++Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758191475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0Ns9XhnZ32JgcGUrHJ5Nt14DJFCCE274WJNT+vWATg=;
	b=rgOraebyjvFiI6ZohpYfzTUI3vKlb1OVB44iq64t/jX4qOHjC2679yn7v3WfTVGK0foFzz
	Isv6xLcYvxesWp11YV4CfYk9pGRjfIdYDQuLRfmvnqBptVns8EHLS2fx+WcARVCzX5hqbU
	9uhNEYGmexnbiYh3rcR9cMJYZMMP7V4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758191475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0Ns9XhnZ32JgcGUrHJ5Nt14DJFCCE274WJNT+vWATg=;
	b=CST8FAnX7tYPYkce21hbZ6f7uuU4Wz4LvSwSXRv5s076M1b6MJiisoqZwbR7I+bsEbO2vR
	hTyH4NoINElpJrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1CBC13A39;
	Thu, 18 Sep 2025 10:31:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7dgXN3Pfy2gHbwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Sep 2025 10:31:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 413DFA09B1; Thu, 18 Sep 2025 12:31:15 +0200 (CEST)
Date: Thu, 18 Sep 2025 12:31:15 +0200
From: Jan Kara <jack@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] writeback: Avoid contention on wb->list_lock when
 switching inodes
Message-ID: <2f4qw4y5jxqzblcdfnuxo34tny2lwtjscnwanxntpibyo4iuft@o4bfi46kfhir>
References: <aMvWdo1EjHoPA-BH@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMvWdo1EjHoPA-BH@stanley.mountain>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

Hello Dan!

On Thu 18-09-25 12:52:54, Dan Carpenter wrote:
> Commit 67c312b4e9bf ("writeback: Avoid contention on wb->list_lock
> when switching inodes") from Sep 12, 2025 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	fs/fs-writeback.c:730 cleanup_offline_cgwb()
> 	error: uninitialized symbol 'new_wb'.
> 
> fs/fs-writeback.c
>     709 bool cleanup_offline_cgwb(struct bdi_writeback *wb)
>     710 {
>     711         struct cgroup_subsys_state *memcg_css;
>     712         struct inode_switch_wbs_context *isw;
>     713         struct bdi_writeback *new_wb;
>     714         int nr;
>     715         bool restart = false;
>     716 
>     717         isw = kzalloc(struct_size(isw, inodes, WB_MAX_INODES_PER_ISW),
>     718                       GFP_KERNEL);
>     719         if (!isw)
>     720                 return restart;
>     721 
>     722         atomic_inc(&isw_nr_in_flight);
>     723 
>     724         for (memcg_css = wb->memcg_css->parent; memcg_css;
>     725              memcg_css = memcg_css->parent) {
> 
> The concern here is that do we know for sure that we enter the loop?

Yes. The root memcg never gets offlined and all the others have non-zero
parent.

> 
>     726                 new_wb = wb_get_create(wb->bdi, memcg_css, GFP_KERNEL);
>     727                 if (new_wb)
>     728                         break;
>     729         }
> --> 730         if (unlikely(!new_wb))
>                               ^^^^^^
> These are a common source of false positives, but I just wanted to be
> sure.  Thanks!

But initializing new_wb to NULL is still a reasonable defensive
programming. I'll send a fixup.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

