Return-Path: <linux-fsdevel+bounces-9366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8BC840482
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 13:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B54B2434E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6B55C8FC;
	Mon, 29 Jan 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iWc7hjDd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XpGhfhgp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gsc9SwyM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hEM3AAa/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB535C8E8
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529597; cv=none; b=BEsnsm/ZsxwRd9fIkVfRuDC5NTeb/klPpP4ixG+1j98mYXdLal+eTARW5RwcVOYiOgDUOp3O6LM4pRQzupxkYDwQbYGic+46/ZGx6vH/NFrMoidfdggVuuaPIemDEZxjCIRNQJxOwAsMTC5pimgQ7BpwOh4jkPrYP8kk2AgqmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529597; c=relaxed/simple;
	bh=E+CSG+EVOj2ql6+HF7KPeUFvGjZkYaY0J61H4zjZ3oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyXrOBF1at7hDPexSGg/XlfGK3yWYqIGLYGqJ1rFwMr1S9wtPIFV0+GIfykg4C6Khk63Z+pQmhyCW9tlEhVKBHP+9NYFPeASaTGY98PDXt+unU4jlsORZ5KjWl0+++q0/V+9TbHjYQmWm4a/XmLhe18Sf+wNI80EaDgybX07vMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iWc7hjDd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XpGhfhgp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gsc9SwyM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hEM3AAa/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0182A21A5D;
	Mon, 29 Jan 2024 11:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706529592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GpoY+LPouPHgMzQq/ERofsMEZAw12k9O02IJucJVx2Q=;
	b=iWc7hjDda5V/ZqouIWUAuIIGAuI+viFo/68Y/ruQdqAHYDbr9MxyD/BPzLSBKpdKomzGib
	6G+xNt8UAbKdrjIrxR8bWeMSLT716SHvTplS7lZJ411BnZ8Ze8DnlpWlb7RZa1H9LGKh0p
	QKrawDeCwME81H1wUzf2oaDnAHwknSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706529592;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GpoY+LPouPHgMzQq/ERofsMEZAw12k9O02IJucJVx2Q=;
	b=XpGhfhgpw1L8BP0QDzxj21TP1zYVxq5LOAgYSJE+GufsTeLpWfx0TlpMw4VMm0F5levvkU
	aPI+h6Bwb7WTEeDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706529590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GpoY+LPouPHgMzQq/ERofsMEZAw12k9O02IJucJVx2Q=;
	b=Gsc9SwyMaHle04PhRt6F0yv6ZUWrAOTH899701QAAdO/GGx1BNRtyEtCMC+LEHYvN3PTjV
	Vo0eJoyoW4i+xg8NDMmYCBiKq9lfPxQkJ6I6PKDIxIqb5ClX6Ckc5I38z7mLPTyam79kIr
	5L4g+y0cQKJQjzUfdtXG1pi+nD7STFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706529590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GpoY+LPouPHgMzQq/ERofsMEZAw12k9O02IJucJVx2Q=;
	b=hEM3AAa/+83oFkkVJqXbph1iCXTUw09WyxlCREWZ2gdrKqAHHJwG4tNNREUpMzG1kq+jci
	5UTJ9IkXQXjTeiCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E9493132FA;
	Mon, 29 Jan 2024 11:59:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id p/7qODWTt2X5ZgAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 29 Jan 2024 11:59:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 82D26A0807; Mon, 29 Jan 2024 12:59:49 +0100 (CET)
Date: Mon, 29 Jan 2024 12:59:49 +0100
From: Jan Kara <jack@suse.cz>
To: cem@kernel.org
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/3] Add support for tmpfs quotas
Message-ID: <20240129115949.5pqeskav7jkvvxuv@quack3>
References: <20240126180225.1210841-1-cem@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126180225.1210841-1-cem@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.78
X-Spamd-Result: default: False [-0.78 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.18)[-0.889];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[36.35%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Hi Carlos!

On Fri 26-01-24 19:02:08, cem@kernel.org wrote:
> From: Carlos Maiolino <cem@kernel.org>
> 
> Sending again with Jan's correct email address.
> 
> This series add suport for quota management on tmpfs filesystems. Support for
> quotas in tmpfs has been added to Linux 6.6, so, give enable users to manage it.
> 
> This series add 2 new helpers, one named do_quotactl(), which switches between
> quotactl() and quotactl_fd(), and the quotactl_handle() helper within quotaio,
> which passes quota_handle data to do_quotactl() depending on the filesystem
> associated with the mountpoint.
> 
> The first patch is just a cleanup.

Thanks for the patches! I did a few small tweaks (e.g. renamed
tmpfs_fstype() to nodev_fstype(), included nfs_fstype() in that function
and used it where appropriate; fixed up compilation breakage with RPC
configured on quotastats) and merged everything. Thanks again.

								Honza

> Carlos Maiolino (3):
>   Rename searched_dir->sd_dir to sd_isdir
>   Add quotactl_fd() support
>   Enable support for tmpfs quotas
> 
>  Makefile.am       |  1 +
>  mntopt.h          |  1 +
>  quotacheck.c      | 12 +++----
>  quotaio.c         | 19 +++++++++--
>  quotaio.h         |  2 ++
>  quotaio_generic.c | 11 +++----
>  quotaio_meta.c    |  3 +-
>  quotaio_v1.c      | 11 +++----
>  quotaio_v2.c      | 11 +++----
>  quotaio_xfs.c     | 21 ++++++------
>  quotaon.c         |  8 ++---
>  quotaon_xfs.c     |  9 +++---
>  quotastats.c      |  4 +--
>  quotasync.c       |  2 +-
>  quotasys.c        | 82 ++++++++++++++++++++++++++++++++++++-----------
>  quotasys.h        |  3 ++
>  16 files changed, 134 insertions(+), 66 deletions(-)
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

