Return-Path: <linux-fsdevel+bounces-24698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7CF94337A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 17:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D038F1C23BA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8821BC074;
	Wed, 31 Jul 2024 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tjDYWkLA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fym+rblO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ODJxQCDH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0xVv1I9u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EB11BC064
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440250; cv=none; b=IKGyB7D8RiOoMfpJf8zdT46pPzrAASXsU1ZJ3gG4oFFTZwlIDqzlxkwsLHMb0sQOQ/2yt9R8sVpXDOWFOlzWAtZKfLT48wI6Q4EzT2jKtjoVLxngRWT37inSUkhUGkgfqXcmRf6huaCWHSupX8EorXOFsO1dW076drQWZs6mJ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440250; c=relaxed/simple;
	bh=WYkgWs6Q2bhzOk3VD9Caq73f5g+VV4vYkg8jwqniKpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCah217zIiIBvO7WAXHB/OxkT208kCu/6Hbt6prFxOJsfvcN74eNyA3YPaMKb81KJl1mVhGHAZ9NVObYH2rlrL80ElVIoKypCijeZc+NM11M+gZf/2XhG2lPoRHSDAy9eAjITzF6Ma6qPE5QrUOeHBkKQxEu/LiEjMUq2S3WcCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tjDYWkLA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fym+rblO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ODJxQCDH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0xVv1I9u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C50651F6E6;
	Wed, 31 Jul 2024 15:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722440243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVlHZeoYX/BfvHEo1VZe4Eq3M2SonCjsjbDkdUEeMMM=;
	b=tjDYWkLApLTUmv0gYrXMdTzO4J9Z5/K2SatGd1niSlxCUJmZ7yNofYtCx+SgRyWMPfSckE
	E1qMSN33Kv1qmZVRJB5JGNkNYn7j5BhInu0Y1HKBy6Frw4LzCupH4RVfwlK44v3PnqL8DE
	1JcfnPDaZOVC1wpnA+7IbCatvdCVi1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722440243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVlHZeoYX/BfvHEo1VZe4Eq3M2SonCjsjbDkdUEeMMM=;
	b=fym+rblOxnnzpke4E/xmQeEr1RMq8JTIQL1kYyJXwwi+0ufKcs1YAfcq3j/hIMKd619u7W
	SMjRa9hE+EpkOnBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ODJxQCDH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0xVv1I9u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722440242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVlHZeoYX/BfvHEo1VZe4Eq3M2SonCjsjbDkdUEeMMM=;
	b=ODJxQCDHIC/rcHtZXRF5BNZkAzq8DlRPF1Uj2+INw3xKFFlckEjV6wrPWl5tJhVye+nkCQ
	O3rck6T+0VQcSli+JqWnW7JAxSaFBZkGfutMA8djrsx5ZCeZe8ZvTrcvN+TOdEwXJTZ5nB
	elug8lX8vLnGip6bw8rj9No5VpMkzCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722440242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVlHZeoYX/BfvHEo1VZe4Eq3M2SonCjsjbDkdUEeMMM=;
	b=0xVv1I9uDcO7HcyGijEH7XwVCALCI9yzXUWVEwvgFkb3k7SEosFG5h9K7268X1zRm54tSY
	mJIDfUKyi8acYICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E1DE1368F;
	Wed, 31 Jul 2024 15:37:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yQTmDjJaqmZUCgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 31 Jul 2024 15:37:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1F60FA099C; Wed, 31 Jul 2024 17:37:12 +0200 (CEST)
Date: Wed, 31 Jul 2024 17:37:12 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: chuck.lever@oracle.com, jack@suse.cz, yangerkun <yangerkun@huawei.com>,
	hughd@google.com, zlang@kernel.org, fdmanana@suse.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	yangerkun@huaweicloud.com, hch@infradead.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] libfs: fix infinite directory reads for offset dir
Message-ID: <20240731153712.hffmznoujzrck2t6@quack3>
References: <20240731043835.1828697-1-yangerkun@huawei.com>
 <20240731-pfeifen-gingen-4f8635e6ffcb@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-pfeifen-gingen-4f8635e6ffcb@brauner>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.81 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: C50651F6E6
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.81

On Wed 31-07-24 16:16:42, Christian Brauner wrote:
> On Wed, 31 Jul 2024 12:38:35 +0800, yangerkun wrote:
> > After we switch tmpfs dir operations from simple_dir_operations to
> > simple_offset_dir_operations, every rename happened will fill new dentry
> > to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
> > key starting with octx->newx_offset, and then set newx_offset equals to
> > free key + 1. This will lead to infinite readdir combine with rename
> > happened at the same time, which fail generic/736 in xfstests(detail show
> > as below).
> > 
> > [...]
> 
> @Chuck, @Jan I did the requested change directly. Please check!

Thanks! Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
> 
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
> 
> [1/1] libfs: fix infinite directory reads for offset dir
>       https://git.kernel.org/vfs/vfs/c/fad90bfe412e
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

