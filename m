Return-Path: <linux-fsdevel+bounces-4790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFF2803D33
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 19:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0121C208DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FD42FC37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FjftHUpq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TUm2Azsq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA94BA
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 09:16:50 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0330220D8;
	Mon,  4 Dec 2023 17:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701710207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DE0QHXA0M6rWnkpWRhS3DyBemzlH0WbrgsZ4p/3Dk+Y=;
	b=FjftHUpq06zaORlH4Z46U1c2yavI8UM7Y4rPQQl4W9lyHcu4vzAt7QIcvVunEzXifs7SM4
	SwpSrQjXskMe7gDI3kSV4Yoa+bxf8ZBi1/3Daxd27mEbn1PXvvtjYms1zdlaqgjKCn8zS6
	sh9VXWZ8g1LT1GMeuJ+lvl218s37csU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701710207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DE0QHXA0M6rWnkpWRhS3DyBemzlH0WbrgsZ4p/3Dk+Y=;
	b=TUm2AzsqRCbgeNzeeMpwQnjA+dIGCXUa8J1MxRWk6Stf9KUcsqr7jwoQKSvjD1uI2KbJzo
	iL6hs9XckD1u3PAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A993413588;
	Mon,  4 Dec 2023 17:16:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id K1BjKX8JbmU0SwAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 04 Dec 2023 17:16:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E2F62A07DB; Mon,  4 Dec 2023 18:16:46 +0100 (CET)
Date: Mon, 4 Dec 2023 18:16:46 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fs: fork splice_file_range() from
 do_splice_direct()
Message-ID: <20231204171646.fwfa2chhuj5qsesh@quack3>
References: <20231130141624.3338942-1-amir73il@gmail.com>
 <20231130141624.3338942-2-amir73il@gmail.com>
 <20231204083733.GA32438@lst.de>
 <20231204083849.GC32438@lst.de>
 <CAOQ4uxjZAjJSR-AUH+UQM3AX9Ota3DVxygFSVkpEQdxK15n_qQ@mail.gmail.com>
 <20231204140749.GB27396@lst.de>
 <CAOQ4uxg+agJ7ybOHfY5bKk_oi=f11zvPLzgnNF5zqZxnkTsUCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg+agJ7ybOHfY5bKk_oi=f11zvPLzgnNF5zqZxnkTsUCA@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-0.88 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.08)[63.26%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.88

On Mon 04-12-23 16:29:02, Amir Goldstein wrote:
> On Mon, Dec 4, 2023 at 4:07 PM Christoph Hellwig <hch@lst.de> wrote:
> > On Mon, Dec 04, 2023 at 03:29:43PM +0200, Amir Goldstein wrote:
> > Well, splice_file_range makes sense if it is a separate helper.  But when
> > is the default implementation for ->copy_file_range and matches the
> > signature, naming it that way is not only sensible but required to keep
> > sanity.
> >
> 
> It is NOT a default implementation of ->copy_file_range(), but
> a fallback helper.
> Specifically, it is never expected to have a filesystem that does
> .copy_file_range = generic_copy_file_range,
> so getting rid of generic_copy_file_range() would be good.
> 
> Note also that generic_copy_file_range() gets a flags argument
> that is COPY_FILE_* flags (currently only for the vfs level)
> and this flags argument is NOT the splice flags argument, so
> I intentionally removed the flags argument from splice_file_range()
> to reduce confusion.
> 
> I like the idea of moving MAX_RW_COUNT into splice_file_range()
> and replacing generic_copy_file_range() calls with splice_file_range().
> 
> I do not feel strongly against splice_copy_file_range() name, but
> I would like to get feedback from other reviewers that approved the
> name splice_file_range() before changing it.

For me the name is not a big deal either way.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

