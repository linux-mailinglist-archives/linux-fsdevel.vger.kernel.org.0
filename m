Return-Path: <linux-fsdevel+bounces-17513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FA18AE898
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 15:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24694285681
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 13:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B09136E00;
	Tue, 23 Apr 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uWi7oEC1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bfeC/poB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v7xoW3W8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ecrfcJ4o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1518E28;
	Tue, 23 Apr 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880174; cv=none; b=POb0TGc5hWaG0PMvobsTXEYtf31zQgnES8hY+OgC9qZlzWH5S25IVIfdO7NQUA2m75Brmky8ycp3/kSqN4+yKkkVoLChwtUT3ijUU17xdo87lhRxYHmo9XZysfwP+lWMiC/smXGUhqCQFna6mMi5DmSxY3bVwH1A91mDfLtNb3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880174; c=relaxed/simple;
	bh=NhKe2YHGl5ISjIZ1V9kL7vfU+zEcRpuhapiZo1nEUQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZKwxxrj2PFQ2cTAfTGr+rn/ibBZy/NHqRrn55otcrq2+n1lSxnWVZidSEripEm87CgBj+B1OaTZq8ZfS+sy21vU8diQPWjF7DwKYCxV2MrUnHrrvmhwwg3hy/HMWqXpbYSGJULedb+cagp4hGGiw+ZeFNHKxy5XYYv6OjD6eTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uWi7oEC1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bfeC/poB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v7xoW3W8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ecrfcJ4o; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5ACC25FFCA;
	Tue, 23 Apr 2024 13:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713880169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=54otsI6UoDqq+k+Xp9PPa5eDRRf1d2Mx1uUAtmPc1nE=;
	b=uWi7oEC1LjmnzCwJirxtgcLddCwnd9NotMB8y7eRO9J9kGaDCe+rOmCjEVCVg9h2cjw5Yk
	msPVQj2z5TreO/tsDdFzjqCDU0iWfxRnmwjUPY9Q/410gWvVz2tuHA0C8JM29HQB5yfgK5
	uSCCtyBJxJJbAu29AGHnGnrt9b1zs0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713880169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=54otsI6UoDqq+k+Xp9PPa5eDRRf1d2Mx1uUAtmPc1nE=;
	b=bfeC/poBWxtSr94p6O5hAG6FYErmI0upu0VH1RgrY+qoBJ3dvgUGfZewJKznCz9Pr8tymr
	TEGg2403KrLE1nDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713880168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=54otsI6UoDqq+k+Xp9PPa5eDRRf1d2Mx1uUAtmPc1nE=;
	b=v7xoW3W8AAYjvlxIVXWQwGqud55udGK5f1upOXiEuBsyvkRJpUn15V4gmfENMwNiMGT8Qh
	/Nb3uDQNCzaqz4cEcaRi0gxiCTTsFGnxkkj8aK/6SKm1Gu2Yq0qH7s3JZ+0Rs+lro4KD47
	nF4SYUQqwVgHQ9w5XnKhGmb2+FcYAVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713880168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=54otsI6UoDqq+k+Xp9PPa5eDRRf1d2Mx1uUAtmPc1nE=;
	b=ecrfcJ4oxak7KaLj9A+5Cxr6ZMfddeMazoCRfrPaFrX5pqCcxyG7XQUDCghu1zJyaObgRn
	JFouHs3ce8B7nWCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4161C13929;
	Tue, 23 Apr 2024 13:49:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AB2mD2i8J2ahbwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Apr 2024 13:49:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DF70BA082F; Tue, 23 Apr 2024 15:49:23 +0200 (CEST)
Date: Tue, 23 Apr 2024 15:49:23 +0200
From: Jan Kara <jack@suse.cz>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next] cgroup: Introduce css_is_online() helper
Message-ID: <20240423134923.osuljlalsd27awz3@quack3>
References: <20240420094428.1028477-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420094428.1028477-1-xiujianfeng@huawei.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,huawei.com:email,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Sat 20-04-24 09:44:28, Xiu Jianfeng wrote:
> Introduce css_is_online() helper to test if whether the specified
> css is online, avoid testing css.flags with CSS_ONLINE directly
> outside of cgroup.c.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

One style nit below:

> +/*
> + * css_is_online - test whether the specified css is online
> + * @css: target css
> + */
> +static inline bool css_is_online(struct cgroup_subsys_state *css)
> +{
> +	return !!(css->flags & CSS_ONLINE);
> +}

Since the return type is 'bool', you don't need the !! magic in the
statement above.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

