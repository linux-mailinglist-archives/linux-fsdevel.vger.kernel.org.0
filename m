Return-Path: <linux-fsdevel+bounces-5775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7343A810677
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 01:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADD2282379
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 00:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0B6A31;
	Wed, 13 Dec 2023 00:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sbO4uE9g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wrw+HDkO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sbO4uE9g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wrw+HDkO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC58AD;
	Tue, 12 Dec 2023 16:28:12 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 567BA1FD04;
	Wed, 13 Dec 2023 00:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702427291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nk1IyI/Qw8q4KfaqeA0p6yZTB4fXE68g6N6s8m6YJss=;
	b=sbO4uE9gS9knOM9eF/X/gHFAtd5CarW7KjoagfnTy66elmcq1gl8I4xLP+RiVfMnApK9B0
	vBgjAsHAg/GJSL2cgTJXxB3vR5ZBbBvnYz/AOcRhWFcZwR7qAYpFnMg9s4Ph3y6fSpcxjk
	vQWmMNuOPgPl7jqpcWeYASpxB8eqSQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702427291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nk1IyI/Qw8q4KfaqeA0p6yZTB4fXE68g6N6s8m6YJss=;
	b=wrw+HDkOAM35jSetsfybXlJ0VUlo+g3B8JEf53EawQqIf8Jkq8jFf+OJRpWTQhRCIawUa6
	S3ZGW6grbkruPlDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702427291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nk1IyI/Qw8q4KfaqeA0p6yZTB4fXE68g6N6s8m6YJss=;
	b=sbO4uE9gS9knOM9eF/X/gHFAtd5CarW7KjoagfnTy66elmcq1gl8I4xLP+RiVfMnApK9B0
	vBgjAsHAg/GJSL2cgTJXxB3vR5ZBbBvnYz/AOcRhWFcZwR7qAYpFnMg9s4Ph3y6fSpcxjk
	vQWmMNuOPgPl7jqpcWeYASpxB8eqSQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702427291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nk1IyI/Qw8q4KfaqeA0p6yZTB4fXE68g6N6s8m6YJss=;
	b=wrw+HDkOAM35jSetsfybXlJ0VUlo+g3B8JEf53EawQqIf8Jkq8jFf+OJRpWTQhRCIawUa6
	S3ZGW6grbkruPlDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19DDF137E8;
	Wed, 13 Dec 2023 00:28:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2nf1LZf6eGXuPAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 13 Dec 2023 00:28:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Christian Brauner" <brauner@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Oleg Nesterov" <oleg@redhat.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of files.
In-reply-to: <20231211232135.GF1674809@ZenIV>
References: <20231208033006.5546-1-neilb@suse.de>,
 <20231208033006.5546-2-neilb@suse.de>,
 <ZXMv4psmTWw4mlCd@tissot.1015granger.net>,
 <170224845504.12910.16483736613606611138@noble.neil.brown.name>,
 <20231211191117.GD1674809@ZenIV>,
 <170233343177.12910.2316815312951521227@noble.neil.brown.name>,
 <20231211231330.GE1674809@ZenIV>, <20231211232135.GF1674809@ZenIV>
Date: Wed, 13 Dec 2023 11:28:04 +1100
Message-id: <170242728484.12910.12134295135043081177@noble.neil.brown.name>
X-Spam-Level: 
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 567BA1FD04
X-Spam-Flag: NO
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sbO4uE9g;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wrw+HDkO;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of neilb@suse.de) smtp.mailfrom=neilb@suse.de
X-Spamd-Result: default: False [-11.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 R_SPF_SOFTFAIL(0.00)[~all:c];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 WHITELIST_DMARC(-7.00)[suse.de:D:+];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -11.81

On Tue, 12 Dec 2023, Al Viro wrote:
> On Mon, Dec 11, 2023 at 11:13:30PM +0000, Al Viro wrote:
> 
> > dentry_kill() means ->d_release(), ->d_iput() and anything final iput()
> > could do.  Including e.g. anything that might be done by afs_silly_iput(),
> > with its "send REMOVE to server, wait for completion".  No, that's not
> > a deadlock per se, but it can stall you a bit more than you would
> > probably consider tolerable...  Sure, you could argue that AFS ought to
> > make that thing asynchronous, but...
> > 
> > Anyway, it won't be "safe to use in most contexts".  ->mmap_lock alone
> > is enough for that, and that's just the one I remember to have given
> > us a lot of headache.  And that's without bringing the "nfsd won't
> > touch those files" cases - make it generally accessible and you get
> > to audit all locks that might be taken when we close a socket, etc.
> 
> PS: put it that way - I can buy "nfsd is doing that only to regular
> files and not on an arbitrary filesystem, at that; having the thread
> wait on that sucker is not going to cause too much trouble"; I do *not*
> buy turning it into a thing usable outside of a very narrow set of
> circumstances.
> 

Can you say more about "not on an arbitrary filesystem" ?
I guess you means that procfs and/or sysfs might be problematic as may
similar virtual filesystems (nfsd maybe).

Could we encode some of this in the comment for __fput_sync ??

/**
 * __fput_sync : drop reference to a file synchronously
 * @f: file to drop
 *
 * Drop a reference on a file and do most cleanup work before returning.
 *
 * Due the the wide use of files in the design of Linux, dropping the
 * final reference to a file can result in dropping the final reference
 * to any of a large variety of other objects.  Dropping those final
 * references can result in nearly arbitrary work.  It should be assumed
 * that, unless prior checks or actions confirm otherwise, calling
 * __fput_sync() might:
 * - allocate memory
 * - perform synchronous IO
 * - wait for a remote service (for networked filesystems)
 * - take ->i_rwsem and other related VFS and filesystem locks
 * - take ->s_umount (if file is on a MNT_INTERNAL filesystem)
 * - take locks in a device driver if the file is CHR, BLK or SOCK
 *
 * If the caller cannot be confident that none of these will cause a
 * problem, it should use fput() instead.
 *
 * Note that the final unmount of a lazy-unmounted non-MNT_INTERNAL
 * filesystem will always be handled asynchronously.  Individual drivers
 * might also leave some clean up to asynchronous threads.
 */

Thanks,
NeilBrown

