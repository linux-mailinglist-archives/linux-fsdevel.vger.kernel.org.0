Return-Path: <linux-fsdevel+bounces-14721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F228C87E574
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 10:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FE5282A0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 09:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5392D054;
	Mon, 18 Mar 2024 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VrxgmsHq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h+FEq8zE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VrxgmsHq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h+FEq8zE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624642D04A;
	Mon, 18 Mar 2024 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753111; cv=none; b=EEzlUwh1Jwhx69MRJE8uqa0lVDcaYD4Qj1MG37uLqONFLLI+LbYC2u3xT7PyQWje0P4cenWKY5qulqxs3NNt1Qgbd47Ydpv3116wD0p6WDeyT3EUhDKYHCQCwNOpbXhbTevHxrkLKSRP0ygO1SnjEPZ76pYUP8DyLUBJ8OAmNzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753111; c=relaxed/simple;
	bh=NGPxM3ePelGE9OoKjLaCdD21Pwp3suHNv4klUXcVzz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4LR+E3AT/hbxjhGoZQ53g8bGmzrp7MPE+3s0PDw6FjUpKeBAmToMTMVfVrC/NuR4uEg9rbFEQayLzstFVIit7fGSMhlmZHZ2FJDXLk+Q9NxgnQNuLemOL2Rm11GC1j4sZ3IoWSGD9JtHvgHs1gtuNSosTFnr74tfuBsjdKi+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VrxgmsHq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h+FEq8zE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VrxgmsHq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h+FEq8zE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 354D35C30C;
	Mon, 18 Mar 2024 09:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710753107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=677TjaCUQSX2hJih4YdxJOT9I6fNvCQk20JBajmy0tA=;
	b=VrxgmsHq4NtH2ERWocJYyx3W/6qgMDT6Wb6I8y+29mVPgESDQEJS67Fmx2dsfAH0kF6QIn
	cssbXXlY+ns4XigNGftjY/W62MaJtKS+lwxAklV0b8p3o1qU3O2R+qZxR/XFRuXAiqTQm/
	tNl1ckP66c/3vQIWRgpnX/hm/2Y6oEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710753107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=677TjaCUQSX2hJih4YdxJOT9I6fNvCQk20JBajmy0tA=;
	b=h+FEq8zESdk0YAi6qP0DKkFKMxaPe/JV49MGmtlJf350BLZ6jb8rM6Isb/NASI2y33ZDWl
	l728bB2Vze+x7uCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710753107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=677TjaCUQSX2hJih4YdxJOT9I6fNvCQk20JBajmy0tA=;
	b=VrxgmsHq4NtH2ERWocJYyx3W/6qgMDT6Wb6I8y+29mVPgESDQEJS67Fmx2dsfAH0kF6QIn
	cssbXXlY+ns4XigNGftjY/W62MaJtKS+lwxAklV0b8p3o1qU3O2R+qZxR/XFRuXAiqTQm/
	tNl1ckP66c/3vQIWRgpnX/hm/2Y6oEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710753107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=677TjaCUQSX2hJih4YdxJOT9I6fNvCQk20JBajmy0tA=;
	b=h+FEq8zESdk0YAi6qP0DKkFKMxaPe/JV49MGmtlJf350BLZ6jb8rM6Isb/NASI2y33ZDWl
	l728bB2Vze+x7uCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29B7C1349D;
	Mon, 18 Mar 2024 09:11:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pf8oClMF+GXCRgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 Mar 2024 09:11:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 92469A07D9; Mon, 18 Mar 2024 10:11:46 +0100 (CET)
Date: Mon, 18 Mar 2024 10:11:46 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 17/19] dm-vdo: prevent direct access of
 bd_inode
Message-ID: <20240318091146.rgu5wtq6e23szzwn@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-18-yukuai1@huaweicloud.com>
 <Zd84IulYNpcKuxC-@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd84IulYNpcKuxC-@infradead.org>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VrxgmsHq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=h+FEq8zE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.48 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.47)[91.43%]
X-Spam-Score: -2.48
X-Rspamd-Queue-Id: 354D35C30C
X-Spam-Flag: NO

On Wed 28-02-24 05:41:54, Christoph Hellwig wrote:
> On Thu, Feb 22, 2024 at 08:45:53PM +0800, Yu Kuai wrote:
> > From: Yu Kuai <yukuai3@huawei.com>
> > 
> > Now that dm upper layer already statsh the file of opened device in
> > 'dm_dev->bdev_file', it's ok to get inode from the file.
> 
> Where did this code get in?

I was surprised as well but apparently 61387b8dcf1dc0 ("Merge tag
'for-6.9/dm-vdo' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm")
during this merge window...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

