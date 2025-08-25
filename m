Return-Path: <linux-fsdevel+bounces-59014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B62B33EDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536F7189E453
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DB82F0C51;
	Mon, 25 Aug 2025 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t1ZmTaIM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="83HSOpmW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t1ZmTaIM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="83HSOpmW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D1D2EFD9C
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123648; cv=none; b=a5jN2JcHjh2ikbuIa8e++jf9H5Zy4qu2F4iPoBNNbQYwGeu8jCtvZ85/zpzPaozxvJDkEiA/Ax5R425i2ZiTMHZvzoQNY2dOSLTqheAWuTNpEh4P3I6IDEEHLewwOMfyadZFKyZP8yj9b7dhnIIgHlFnSOrVapG4KpWRwgjKYpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123648; c=relaxed/simple;
	bh=MWkWojGEIs+5EgCLVlLnBOjxSlqnFs4gPeEtmO3HGug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujJPQ/utKea1a/GBJJnx8+TRJ5f4eeuCMj35B+EcKD0AAodrK90g+DIxnWwQAeLNIHqrZHtM05/E0Fb8fdLmOVnUu6L+khGGIlIc96v/n3Qx2VC38cfjE66zFpqQtc87utYCx+K/wY9ZXWLCmc/ABDnUfzYhqxyRFlpoAzApNoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t1ZmTaIM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=83HSOpmW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t1ZmTaIM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=83HSOpmW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F26CE2125B;
	Mon, 25 Aug 2025 12:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756123644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5esCATGxFy1rPdQ5wxmc7jMFTL/ZNi1qRrQlBSRFzPk=;
	b=t1ZmTaIM0+z6zSJxxyOEwYyPqpiki++QwLvf6SbdhQDAXsJzbiPx6tgrlLwtDXBYKzjUz6
	XmNeoO6v4iiBYcICYhf9+vPppYOsxvqC0O4Z72aLVDKRmHnsaowAsXrRZ/ZkawLyUHVbbD
	GD4rB/NSxgCYXEY0yC3iDkhx6piJlwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756123644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5esCATGxFy1rPdQ5wxmc7jMFTL/ZNi1qRrQlBSRFzPk=;
	b=83HSOpmWO0E4yGKjz/4xp57phgsCaOgr6D95jxGWvKcSI3kfxKy5OpEcOUKKfaG93/AcKo
	9/pSeIvPZeujdIDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=t1ZmTaIM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=83HSOpmW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756123644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5esCATGxFy1rPdQ5wxmc7jMFTL/ZNi1qRrQlBSRFzPk=;
	b=t1ZmTaIM0+z6zSJxxyOEwYyPqpiki++QwLvf6SbdhQDAXsJzbiPx6tgrlLwtDXBYKzjUz6
	XmNeoO6v4iiBYcICYhf9+vPppYOsxvqC0O4Z72aLVDKRmHnsaowAsXrRZ/ZkawLyUHVbbD
	GD4rB/NSxgCYXEY0yC3iDkhx6piJlwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756123644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5esCATGxFy1rPdQ5wxmc7jMFTL/ZNi1qRrQlBSRFzPk=;
	b=83HSOpmWO0E4yGKjz/4xp57phgsCaOgr6D95jxGWvKcSI3kfxKy5OpEcOUKKfaG93/AcKo
	9/pSeIvPZeujdIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC8EC1368F;
	Mon, 25 Aug 2025 12:07:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cU+HNftRrGjtDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 Aug 2025 12:07:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 707ACA0951; Mon, 25 Aug 2025 14:07:15 +0200 (CEST)
Date: Mon, 25 Aug 2025 14:07:15 +0200
From: Jan Kara <jack@suse.cz>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org, hch@lst.de, 
	martin.petersen@oracle.com, djwong@kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.com>
Subject: Re: [PATCHv3 0/8] direct-io: even more flexible io vectors
Message-ID: <g35u5ugmyldqao7evqfeb3hfcbn3xddvpssawttqzljpigy7u4@k3hehh3grecq>
References: <20250819164922.640964-1-kbusch@meta.com>
 <87a53ra3mb.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a53ra3mb.fsf@gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: F26CE2125B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[17];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim]
X-Spam-Score: -2.51

On Fri 22-08-25 18:57:08, Ritesh Harjani wrote:
> Keith Busch <kbusch@meta.com> writes:
> 
> > From: Keith Busch <kbusch@kernel.org>
> >
> > Previous version:
> >
> >   https://lore.kernel.org/linux-block/20250805141123.332298-1-kbusch@meta.com/
> >
> > This series removes the direct io requirement that io vector lengths
> > align to the logical block size.
> >
> > I tested this on a few raw block device types including nvme,
> > virtio-blk, ahci, and loop. NVMe is the only one I tested with 4k
> > logical sectors; everything else was 512.
> >
> > On each of those, I tested several iomap filesystems: xfs, ext4, and
> > btrfs. I found it interesting that each behave a little
> > differently with handling invalid vector alignments:
> >
> >   - XFS is the most straight forward and reports failures on invalid
> >     vector conditions, same as raw blocks devices.
> >
> >   - EXT4 falls back to buffered io for writes but not for reads.
> 
> ++linux-ext4 to get any historical context behind why the difference of
> behaviour in reads v/s writes for EXT4 DIO. 

Hum, how did you test? Because in the basic testing I did (with vanilla
kernel) I get EINVAL when doing unaligned DIO write in ext4... We should be
falling back to buffered IO only if the underlying file itself does not
support any kind of direct IO.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

