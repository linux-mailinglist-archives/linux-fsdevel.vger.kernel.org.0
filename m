Return-Path: <linux-fsdevel+bounces-5535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6615B80D338
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 18:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B6A1C21454
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 17:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE474D591;
	Mon, 11 Dec 2023 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QHrRQzZF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L0Pt7Vp/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QHrRQzZF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L0Pt7Vp/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9874A8E;
	Mon, 11 Dec 2023 09:04:05 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0256221F7;
	Mon, 11 Dec 2023 17:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702314244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CD7iaV6cc3gb69jV7WBGvgMN69Ui+vx3V8xrfnjKK80=;
	b=QHrRQzZFHyCixSljPWLi9c+a8RDuVkjSNmKyh5JEg4Ol5KuJFqz2DG3MONDYikzoAuxHT+
	Nixxgu1ZhvM1mgEIxET6Zv8fO51VjH6Ng7bEadOtaVlTxUlICpc64StQ+cv2lvDUg0ZNn9
	cxdy6tF4LjQOzYcYE4zUVsKnyld80o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702314244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CD7iaV6cc3gb69jV7WBGvgMN69Ui+vx3V8xrfnjKK80=;
	b=L0Pt7Vp/szVN+ANcrxugX88Vb1aU+aWLGiA4jCuuIVtTB8I0bAGu3MfcVIy3ILQLdMK15b
	9O6hLlKY6jyHGuCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702314244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CD7iaV6cc3gb69jV7WBGvgMN69Ui+vx3V8xrfnjKK80=;
	b=QHrRQzZFHyCixSljPWLi9c+a8RDuVkjSNmKyh5JEg4Ol5KuJFqz2DG3MONDYikzoAuxHT+
	Nixxgu1ZhvM1mgEIxET6Zv8fO51VjH6Ng7bEadOtaVlTxUlICpc64StQ+cv2lvDUg0ZNn9
	cxdy6tF4LjQOzYcYE4zUVsKnyld80o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702314244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CD7iaV6cc3gb69jV7WBGvgMN69Ui+vx3V8xrfnjKK80=;
	b=L0Pt7Vp/szVN+ANcrxugX88Vb1aU+aWLGiA4jCuuIVtTB8I0bAGu3MfcVIy3ILQLdMK15b
	9O6hLlKY6jyHGuCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DDDE7134B0;
	Mon, 11 Dec 2023 17:04:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oQUlNgNBd2USGAAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 11 Dec 2023 17:04:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8755AA07E3; Mon, 11 Dec 2023 18:04:03 +0100 (CET)
Date: Mon, 11 Dec 2023 18:04:03 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
	kent.overstreet@gmail.com, joern@lazybastard.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	nico@fluxnic.net, xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, agruenba@redhat.com, jack@suse.com,
	konishi.ryusuke@gmail.com, willy@infradead.org,
	akpm@linux-foundation.org, p.raghav@samsung.com, hare@suse.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nilfs@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v2 for-6.8/block 17/18] ext4: remove
 block_device_ejected()
Message-ID: <20231211170403.biwgd7l7pud7s7ip@quack3>
References: <20231211140552.973290-1-yukuai1@huaweicloud.com>
 <20231211140833.975935-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211140833.975935-1-yukuai1@huaweicloud.com>
X-Spam-Score: 15.90
X-Spamd-Result: default: False [18.87 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 R_RATELIMIT(0.00)[to_ip_from(RLa8hd5fybgmzcyr9mhbq8ey7y)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[50];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[35.38%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAM_FLAG(5.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 NEURAL_SPAM_SHORT(2.88)[0.961];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.dk,citrix.com,suse.de,gmail.com,lazybastard.org,bootlin.com,nod.at,ti.com,linux.ibm.com,oracle.com,fb.com,toxicpanda.com,suse.com,zeniv.linux.org.uk,kernel.org,fluxnic.net,mit.edu,dilger.ca,redhat.com,infradead.org,linux-foundation.org,samsung.com,vger.kernel.org,lists.xenproject.org,lists.infradead.org,lists.ozlabs.org,lists.linux.dev,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spamd-Bar: ++++++++++++++++++
X-Rspamd-Server: rspamd1
X-Spam-Flag: NO
X-Rspamd-Queue-Id: F0256221F7
X-Spam-Score: 18.87
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QHrRQzZF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="L0Pt7Vp/";
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz;
	dmarc=none

On Mon 11-12-23 22:08:33, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> block_device_ejected() is added by commit bdfe0cbd746a ("Revert
> "ext4: remove block_device_ejected"") in 2015. At that time 'bdi->wb'
> is destroyed synchronized from del_gendisk(), hence if ext4 is still
> mounted, and then mark_buffer_dirty() will reference destroyed 'wb'.
> However, such problem doesn't exist anymore:
> 
> - commit d03f6cdc1fc4 ("block: Dynamically allocate and refcount
> backing_dev_info") switch bdi to use refcounting;
> - commit 13eec2363ef0 ("fs: Get proper reference for s_bdi"), will grab
> additional reference of bdi while mounting, so that 'bdi->wb' will not
> be destroyed until generic_shutdown_super().
> 
> Hence remove this dead function block_device_ejected().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Agreed, this should not be needed anymore. We'll see whether this is true
also in practice :). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

