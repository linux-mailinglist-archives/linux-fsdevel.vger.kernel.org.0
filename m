Return-Path: <linux-fsdevel+bounces-1200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EEC7D7242
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 19:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56A9281CBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 17:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203CD30CF9;
	Wed, 25 Oct 2023 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cB1/5KpC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2nP4ZuxT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA831D684
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 17:27:15 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BBC11F
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 10:27:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 825D221CA6;
	Wed, 25 Oct 2023 17:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698254460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ulJixYrD18757uXuZvt/bW5cRci/S6VJEeEyijEEO0A=;
	b=cB1/5KpCRaLik99XxbZZBaj+h2mjaSKOjM9b4DvwzDEMgR8iQH1Q31Dt+k1ug3JPj+hPvh
	o12Ve2aiIoQu+oESvg0hkxRXH9XMmmI73Hz7dqUCCgEth1HJZYAfF3/Oh69ada19TS6PKC
	mTtxHpuqWffJ6RJBj1Qsw3VtsULbMTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698254460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ulJixYrD18757uXuZvt/bW5cRci/S6VJEeEyijEEO0A=;
	b=2nP4ZuxTViMY93Fkjgkr88Ydn06uo1RyakOuX6OYwZyvUj6jYSvn+3Bfxuh0K3LI7InkGU
	UWE7HRe6KO+ACkAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73782138E9;
	Wed, 25 Oct 2023 17:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cjAqHHxOOWWuYwAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 25 Oct 2023 17:21:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 83F43A0679; Wed, 25 Oct 2023 19:20:57 +0200 (CEST)
Date: Wed, 25 Oct 2023 19:20:57 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] fs,block: yield devices
Message-ID: <20231025172057.kl5ajjkdo3qtr2st@quack3>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.23
X-Spamd-Result: default: False [-6.23 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.63)[98.37%]

Hello!

On Tue 24-10-23 16:53:38, Christian Brauner wrote:
> This is a mechanism that allows the holder of a block device to yield
> device access before actually closing the block device.
> 
> If a someone yields a device then any concurrent opener claiming the
> device exclusively with the same blk_holder_ops as the current owner can
> wait for the device to be given up. Filesystems by default use
> fs_holder_ps and so can wait on each other.
> 
> This mechanism allows us to simplify superblock handling quite a bit at
> the expense of requiring filesystems to yield devices. A filesytems must
> yield devices under s_umount. This allows costly work to be done outside
> of s_umount.
> 
> There's nothing wrong with the way we currently do things but this does
> allow us to simplify things and kills a whole class of theoretical UAF
> when walking the superblock list.

I'm not sure why is it better to create new ->yield callback called under
sb->s_umount rather than just move blkdev_put() calls back into
->put_super? Or at least yielding could be done in ->put_super instead of
a new callback if for some reason that is better than releasing the devices
right away in ->put_super.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

