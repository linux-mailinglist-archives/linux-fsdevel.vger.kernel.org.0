Return-Path: <linux-fsdevel+bounces-3589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9D17F6B52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 05:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3912B281328
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 04:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC33BAD4B;
	Fri, 24 Nov 2023 04:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E87101
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 20:21:27 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F6C821AE6;
	Thu, 23 Nov 2023 17:30:17 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6ECB9132F8;
	Thu, 23 Nov 2023 17:30:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +ebLGimMX2XUKwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 17:30:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0D797A07D9; Thu, 23 Nov 2023 18:30:17 +0100 (CET)
Date: Thu, 23 Nov 2023 18:30:17 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 13/16] fs: move kiocb_start_write() into
 vfs_iocb_iter_write()
Message-ID: <20231123173017.a6se73qyfmguzk2b@quack3>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-14-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-14-amir73il@gmail.com>
X-Spamd-Bar: +++++
X-Spam-Score: 5.31
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 7F6C821AE6
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Spamd-Result: default: False [5.31 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.10)[-0.484];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,toxicpanda.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.98)[99.91%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]

On Wed 22-11-23 14:27:12, Amir Goldstein wrote:
> In vfs code, sb_start_write() is usually called after the permission hook
> in rw_verify_area().  vfs_iocb_iter_write() is an exception to this rule,
> where kiocb_start_write() is called by its callers.
> 
> Move kiocb_start_write() from the callers into vfs_iocb_iter_write()
> after the rw_verify_area() checks, to make them "start-write-safe".
> 
> The semantics of vfs_iocb_iter_write() is changed, so that the caller is
> responsible for calling kiocb_end_write() on completion only if async
> iocb was queued.  The completion handlers of both callers were adapted
> to this semantic change.
> 
> This is needed for fanotify "pre content" events.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

