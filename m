Return-Path: <linux-fsdevel+bounces-4387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91AA7FF2A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058B51C20BD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678FC51014
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D9910D9
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 05:30:12 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0691B1FCF1;
	Thu, 30 Nov 2023 13:30:10 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DC571138E5;
	Thu, 30 Nov 2023 13:30:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Wq3INWGOaGXCYAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 13:30:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 176A1A07DB; Thu, 30 Nov 2023 14:30:09 +0100 (CET)
Date: Thu, 30 Nov 2023 14:30:09 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: fork do_splice_copy_file_range() from
 do_splice_direct()
Message-ID: <20231130133009.pufons7adm7mjndl@quack3>
References: <20231129200709.3154370-1-amir73il@gmail.com>
 <20231129200709.3154370-2-amir73il@gmail.com>
 <CAOQ4uxixp3YRE0xRDe5EkTmTvnRU_qeJ=R=MqxRWkqHRtLf+4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxixp3YRE0xRDe5EkTmTvnRU_qeJ=R=MqxRWkqHRtLf+4A@mail.gmail.com>
X-Spamd-Bar: ++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [6.88 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.51)[80.10%]
X-Spam-Score: 6.88
X-Rspamd-Queue-Id: 0691B1FCF1

On Thu 30-11-23 12:09:09, Amir Goldstein wrote:
> On Wed, Nov 29, 2023 at 10:07 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > The new helper is meant to be called from context of ->copy_file_range()
> > methods instead of do_splice_direct().
> >
> > Currently, the only difference is that do_splice_copy_file_range() does
> > not take a splice flags argument and it asserts that file_start_write()
> > was called.
> >
> > Soon, do_splice_direct() will be called without file_start_write() held.
> >
> > Use the new helper from __ceph_copy_file_range(), that was incorrectly
> > passing the copy_file_range() flags argument as splice flags argument
> > to do_splice_direct(). the value of flags was 0, so no actual bug fix.
> >
> > Move the definition of both helpers to linux/splice.h.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
...
> > +/**
> > + * do_splice_copy_file_range - splices data for copy_file_range()
> > + * @in:                file to splice from
> > + * @ppos:      input file offset
> > + * @out:       file to splice to
> > + * @opos:      output file offset
> > + * @len:       number of bytes to splice
> > + *
> > + * Description:
> > + *    For use by generic_copy_file_range() and ->copy_file_range() methods.
> > + *
> > + * Callers already called rw_verify_area() on the entire range.
> > + */
> > +long do_splice_copy_file_range(struct file *in, loff_t *ppos, struct file *out,
> > +                              loff_t *opos, size_t len)
> 
> FYI, I renamed do_splice_vfs_copy_file_range => splice_file_range in v2
> for brevity.

Yeah, after the rename things look better :). Otherwise I didn't find any
problem so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

