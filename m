Return-Path: <linux-fsdevel+bounces-4556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F71800866
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 11:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2D01F20F41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D54210E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:37:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55200C7
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 02:12:05 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3FD361FD63;
	Fri,  1 Dec 2023 10:12:02 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D6711344E;
	Fri,  1 Dec 2023 10:12:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +b3QCnKxaWUQcwAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 01 Dec 2023 10:12:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A7FDEA07DB; Fri,  1 Dec 2023 11:11:57 +0100 (CET)
Date: Fri, 1 Dec 2023 11:11:57 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 16/16] fs: create {sb,file}_write_not_started() helpers
Message-ID: <20231201101157.ngebxqwhcwrurjvw@quack3>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-17-amir73il@gmail.com>
 <20231123173532.6h7gxacrlg4pyooh@quack3>
 <CAOQ4uxjrvWXR6MwiUUfEQdw1hDNmzO6KfhzWjc20VYp9Rf_ypw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjrvWXR6MwiUUfEQdw1hDNmzO6KfhzWjc20VYp9Rf_ypw@mail.gmail.com>
X-Spamd-Bar: ++++++++
X-Spam-Score: 8.69
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz;
	dmarc=none
X-Rspamd-Queue-Id: 3FD361FD63
X-Spamd-Result: default: False [8.69 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]

On Fri 24-11-23 10:20:25, Amir Goldstein wrote:
> On Fri, Nov 24, 2023 at 6:17 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 22-11-23 14:27:15, Amir Goldstein wrote:
> > > Create new helpers {sb,file}_write_not_started() that can be used
> > > to assert that sb_start_write() is not held.
> > >
> > > This is needed for fanotify "pre content" events.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > I'm not against this but I'm somewhat wondering, where exactly do you plan
> > to use this :) (does not seem to be in this patch set).
> 
> As I wrote in the cover letter:
> "The last 3 patches are helpers that I used in fanotify patches to
>  assert that permission hooks are called with expected locking scope."
> 
> But this is just half of the story.
> 
> The full story is that I added it in fsnotify_file_perm() hook to check
> that we caught all the places that permission hook was called with
> sb_writers held:
> 
>  static inline int fsnotify_file_perm(struct file *file, int mask)
>  {
>        struct inode *inode = file_inode(file);
>        __u32 fsnotify_mask;
> 
>        /*
>         * Content of file may be written on pre-content events, so sb freeze
>         * protection must not be held.
>         */
>        lockdep_assert_once(file_write_not_started(file));
> 
>        /*
>         * Pre-content events are only reported for regular files and dirs.
>         */
>        if (mask & MAY_READ) {
> 
> 
> And the assert triggered in a nested overlay case (overlay over overlay).
> So I cannot keep the assert in the final patch as is.
> I can probably move it into (mask & MAY_WRITE) case, because
> I don't know of any existing write permission hook that is called with
> sb_wrtiers held.
> 
> I also plan to use sb_write_not_started() in fsnotify_lookup_perm().
> 
> I think that:
> "This is needed for fanotify "pre content" events."
> sums this up nicely without getting into gory details ;)
> 
> > Because one easily
> > forgets about the subtle implementation details and uses
> > !sb_write_started() instead of sb_write_not_started()...
> >
> 
> I think I had a comment in one version that said:
> "This is NOT the same as !sb_write_started()"
> 
> We can add it back if you think it is useful, but FWIW, anyone
> can use !sb_write_started() wrongly today whether we add
> sb_write_not_started() or not.
> 
> But this would be pretty easy to detect - running a build without
> CONFIG_LOCKDEP will catch this misuse pretty quickly.

Yeah, fair enough. Thanks for explanation!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

