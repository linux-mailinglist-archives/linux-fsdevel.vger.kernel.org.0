Return-Path: <linux-fsdevel+bounces-8184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE28830B6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 17:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF6F1F26CB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 16:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187A3224EF;
	Wed, 17 Jan 2024 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oWuEoXHn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h/bodwBg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gdZjzZwe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4ohGp0gV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA12224DA;
	Wed, 17 Jan 2024 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510010; cv=none; b=iObAVQg5kuiAP8zL+Z2Zf0Q174PFlWCf01KmLrSLEAq/viu3ZEvvlHcLys6Dj5gO+mZ64/MSZDlFa6SssHCZy4It5aMPXNJKTDCQY1dto/hBaeSvIgDpnwLcZEWt+giaVHZjuhKqgBY8japcTlu5ZvqR0IvJNc48x9Zn7qdSr94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510010; c=relaxed/simple;
	bh=SBDyEhkvjG6umiDsx40Tyl9tWANMzgVgqypPgmdJaxY=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Level:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Flag; b=Sd3QiXxJUfb9DwJ4doeiZhgoCQdKXXNKuzz67om2eIKdzWSK2hZniNch9IPt27oFPR+EF7uPNXCiyWeyA+uCHYpRv875/16Iq9DtNPKj4o6uPVp5GZa55KGpiXv8qtd+ZYoKQiwJTrq7jnxD+lpYAZIYS/28aEIdVIeQg4qdc4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oWuEoXHn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h/bodwBg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gdZjzZwe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4ohGp0gV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E71691FCDA;
	Wed, 17 Jan 2024 16:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705510007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sAVf3FNqk0d5oQTKyz83Is6ZquFpZpCQOqC7tozxc+o=;
	b=oWuEoXHn6lFGV8zBfd7QGxFQRp63BT5Uo2Zm9u3L3KlyneTB5IxLLTk2T/Bv52Lwm7nQSe
	OuUe/A0swKYukFGVvZ/Z6foICZoFXusVh7rhXvcsx0zGrF1zMetQlowYrk4/1tab+68qQI
	aVPtSy6bEPo8lJKci/NqfUXvEpIWYgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705510007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sAVf3FNqk0d5oQTKyz83Is6ZquFpZpCQOqC7tozxc+o=;
	b=h/bodwBge+P12MiDVlRkYpKJ26fKGSzu2XtuzrzaxxiPhOqerYKi+AlCyz6HWrTtH7YrEY
	Byv4RYil2dMPWSCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705510006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sAVf3FNqk0d5oQTKyz83Is6ZquFpZpCQOqC7tozxc+o=;
	b=gdZjzZweNvUta5fSgL4Wb2YE4gj7KGUTuBatm0IaPT9DexuCVqA9vL1wmvyonInpp6D+gM
	dCBsl3HyWWqCeRDa2P9BDId6UJKiiisCliI60Cvg0asMNQ6DJIHtFa0Yvbk53xLjiAXFid
	ZReUQ0G5F74jDBJZdXI6aAx4HvjL48g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705510006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sAVf3FNqk0d5oQTKyz83Is6ZquFpZpCQOqC7tozxc+o=;
	b=4ohGp0gV112rRm38XBTodO78fnpSEk+xCWc8S1IRtLdNDJuNKqhayk0c/V4HUpm8ky2MCB
	x0X4eToPjGnciJBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0B9B13800;
	Wed, 17 Jan 2024 16:46:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ho/yMnYEqGURMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jan 2024 16:46:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 704E5A0803; Wed, 17 Jan 2024 17:46:46 +0100 (CET)
Date: Wed, 17 Jan 2024 17:46:46 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 00/34] Open block devices as files & a bd_inode
 proposal
Message-ID: <20240117164646.mpxmxx3dimx2f6ap@quack3>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gdZjzZwe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4ohGp0gV
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[30.11%]
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: E71691FCDA
X-Spam-Flag: NO

On Wed 03-01-24 13:54:58, Christian Brauner wrote:
> I wanted to see whether we can make struct bdev_handle completely
> private to the block layer in the next cycle and unexport low-level
> helpers such as bdev_release() - formerly blkdev_put() - completely.
> 
> And afaict, we can actually get that to work. Simply put instead of
> doing this bdev_open_by_*() dance where we return a struct block_device
> we can just make bdev_file_open_by_*() return a struct file. Opening and
> closing a block device from setup_bdev_super() and in all other places
> just becomes equivalent to opening and closing a file.

So I've checked the patchset (not too carefully) and overall I like the
direction. I've commented on the few things I didn't quite understand /
like but overall I like this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

