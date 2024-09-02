Return-Path: <linux-fsdevel+bounces-28228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 968B2968491
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 12:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B231C21FA2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 10:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43765149C6F;
	Mon,  2 Sep 2024 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t0ZMyoLN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4nUCsoLr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t0ZMyoLN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4nUCsoLr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DCD13D503;
	Mon,  2 Sep 2024 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272628; cv=none; b=CtYFgFX7+OhB6LRHJEzDj1BuemYahrfxW2gNECsKiLbATA2lat2AbF+a8v0sOabk1mNN9liS0MFKT3Z9GKrOgMgn2tBJVMw0Gb2+5/Tk2XlCCpM1EuqgdTUCEUVmhP8Nq73HTpcMIOQMsMg+3GQKjuC5jc/rK4QK04TMIaIxtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272628; c=relaxed/simple;
	bh=N8oazSSiWhM8MmQJ05BE+dKrBh8QnfEgDtFuFZgxa1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIHTbLy1An0PKXc9tHEXJhfjAt4aToBMLufX7m9qvQYqUFPLL9/1GuFj9RMbdfR1o70kkmAFV+R9G6s5MOcClW6snn5kBDtv9xEuiTLPEIq1kcz9FKd/2ga9dQ6j05FnbYcLSxM3Yh+y5GzSgtvfDiTRNHcN294p1Uz/c2VMG/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t0ZMyoLN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4nUCsoLr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t0ZMyoLN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4nUCsoLr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC93E1F78A;
	Mon,  2 Sep 2024 10:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725272624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2La409HlsVP43DvNdlRrcc4P/nFvA33DMAMaKY/R8N0=;
	b=t0ZMyoLNCpz8mZm+IWqY6DiLFKyf09kIutXhEuQE2q68/XZLfZeWotmbMCmp7P1JG5J+B1
	kQ8OrZm+FfewsDUvPnS/ak/GeJdNJtbji9r5zrpkgjsjZZLNDpSnfMyy9izWsbJ3wnov26
	pjtsaIT86gtB2qJtepSbYd/5jNsuM9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725272624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2La409HlsVP43DvNdlRrcc4P/nFvA33DMAMaKY/R8N0=;
	b=4nUCsoLrv0mpcvKWQijwPvMuPKbyUIVF3aJIrFW2G0GPFhhqiiv/OXp13H8zovmhTr7ZIK
	9r0R8xkPE6nFYuAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=t0ZMyoLN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4nUCsoLr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725272624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2La409HlsVP43DvNdlRrcc4P/nFvA33DMAMaKY/R8N0=;
	b=t0ZMyoLNCpz8mZm+IWqY6DiLFKyf09kIutXhEuQE2q68/XZLfZeWotmbMCmp7P1JG5J+B1
	kQ8OrZm+FfewsDUvPnS/ak/GeJdNJtbji9r5zrpkgjsjZZLNDpSnfMyy9izWsbJ3wnov26
	pjtsaIT86gtB2qJtepSbYd/5jNsuM9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725272624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2La409HlsVP43DvNdlRrcc4P/nFvA33DMAMaKY/R8N0=;
	b=4nUCsoLrv0mpcvKWQijwPvMuPKbyUIVF3aJIrFW2G0GPFhhqiiv/OXp13H8zovmhTr7ZIK
	9r0R8xkPE6nFYuAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D2D613AE0;
	Mon,  2 Sep 2024 10:23:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fxcaJjCS1WbyZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Sep 2024 10:23:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4D2B7A0965; Mon,  2 Sep 2024 12:23:44 +0200 (CEST)
Date: Mon, 2 Sep 2024 12:23:44 +0200
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 16/16] xfs: add pre-content fsnotify hook for write
 faults
Message-ID: <20240902102344.evvpipetu6zghrwz@quack3>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <631039816bbac737db351e3067520e85a8774ba1.1723670362.git.josef@toxicpanda.com>
 <20240829111753.3znmdajndwwfwh6n@quack3>
 <20240830232833.GR6216@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830232833.GR6216@frogsfrogsfrogs>
X-Rspamd-Queue-Id: AC93E1F78A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,toxicpanda.com,fb.com,vger.kernel.org,gmail.com,kernel.org,lists.linux.dev,fromorbit.com,infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 30-08-24 16:28:33, Darrick J. Wong wrote:
> On Thu, Aug 29, 2024 at 01:17:53PM +0200, Jan Kara wrote:
> > On Wed 14-08-24 17:25:34, Josef Bacik wrote:
> > > xfs has it's own handling for write faults, so we need to add the
> > > pre-content fsnotify hook for this case.  Reads go through filemap_fault
> > > so they're handled properly there.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > 
> > Looks good to me but it would be great to get explicit ack from some XFS
> > guy...  Some selection CCed :)
> 
> Looks decent to me, but I wonder why xfs_write_fault has to invoke
> filemap_maybe_emit_fsnotify_event itself?  Can that be done from
> whatever calls ->page_mkwrite and friends?

So we were discussing this already here [1]. The options we have:

1) Call filemap_maybe_emit_fsnotify_event() from filesystem hooks
(filemap_fault() for those who use it). This is a bit ugly because it
requires modification to filesystems with their own fault handlers.

2) Call filemap_maybe_emit_fsnotify_event() from generic code before
calling ->fault() and if we needed to send event (and thus dropped
mmap_lock), we will retry the fault. This requires no special fs awareness
but the ->fault hook will then be called after retry most of the times on
HSM managed fs and thus without possibility to drop mmap_lock making
contention there possibly worse.

3) (I don't think we've discussed this option yet): Call
filemap_maybe_emit_fsnotify_event() in generic code before calling ->fault
and then continue to call ->fault even if we've dropped mmap_lock. This
will require changing calling convention for ->fault as vmf->vma must not
be touched after we've dropped mmap_lock and practically all users end up
using it to get vmf->vma->vm_file. With per-fs opt in flag to enable HSM
events this could be manageable but frankly I'm not convinced the
complicated calling convention would be better outcome than 1). But I'm
open for discussion.
								Honza

[1] https://lore.kernel.org/all/CAOQ4uxgXEzT=Buwu8SOkQG+2qcObmdH4NgsGme8bECObiobfTQ@mail.gmail.com
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

