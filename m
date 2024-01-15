Return-Path: <linux-fsdevel+bounces-7936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E61EB82D8D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 13:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B996282034
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 12:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8658E2C6A0;
	Mon, 15 Jan 2024 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XHQ9hJHW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U0tKfAnw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="orzhm96q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SPPmrGB5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA1F2C695
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DCF312218C;
	Mon, 15 Jan 2024 12:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705321119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xROj9KtL80LNCGHeMoyEZqGzKYtoZ/IQJbml5dp/jik=;
	b=XHQ9hJHWHjAM2/wy/wKBl71kfasHhI5S57Y3QPfCfXQsm6a1fzvxf4UVBg3yHpWaUMazoD
	YJWqxXzObqjoUD65GXntaUjNbbB5fw4jWmZeUd/dXSQW5AmrLIZ7DtlD9krx7uEmUpp93Y
	E5NabpV80fwZXaAn4EKJ8CABZwVo17s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705321119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xROj9KtL80LNCGHeMoyEZqGzKYtoZ/IQJbml5dp/jik=;
	b=U0tKfAnwwddlaobdiZbrw92ebFjEVscZI0cdeswiWd5NwTBRqaatV/4J2xdDJv3Ux4fxA3
	0GyvXK/cDs3jYeBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705321118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xROj9KtL80LNCGHeMoyEZqGzKYtoZ/IQJbml5dp/jik=;
	b=orzhm96qh5UNpbg6FXKzKb06ondANqIPBJiIQdbfFOiZ6jADn8S8kJF7bykPsUYNI7KXvh
	P5qfIWkPp5azw3uduksD9370RahVpdZwHghGOxD+3EPtkv/bKl9CSyXg3qW5A74hfDIJPN
	KLEVGilw5/5SQr71kOClVc6VB4N5lCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705321118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xROj9KtL80LNCGHeMoyEZqGzKYtoZ/IQJbml5dp/jik=;
	b=SPPmrGB5mDK0e6ksVoP1EXgITTJgAfvyLxVcvsemMHkWYhADJTJVkWZhXvgcIO48cYKsMc
	xJz+56MY4QTi5qCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAF7E132FA;
	Mon, 15 Jan 2024 12:18:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Be9BMJ4ipWVFSwAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Mon, 15 Jan 2024 12:18:38 +0000
Date: Mon, 15 Jan 2024 13:19:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, mszeredi@redhat.com, brauner@kernel.org,
	Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [LTP] [PATCH v2 1/4] lib: Add tst_fd iterator
Message-ID: <ZaUius9Q_5U113q9@yuki>
References: <20231016123320.9865-1-chrubis@suse.cz>
 <20231016123320.9865-2-chrubis@suse.cz>
 <20240105004236.GA1451456@pevik>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105004236.GA1451456@pevik>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=orzhm96q;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SPPmrGB5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: DCF312218C
X-Spam-Flag: NO

Hi!
> centos stream 9 (glibc 2.34)
> https://github.com/pevik/ltp/actions/runs/7415994730/job/20180154319
> In file included from /usr/include/linux/fs.h:19,
>                  from /__w/ltp/ltp/include/lapi/io_uring.h:17,
>                  from /__w/ltp/ltp/lib/tst_fd.c:21:
> /usr/include/x86_64-linux-gnu/sys/mount.h:35:3: error: expected identifier before numeric constant
>    35 |   MS_RDONLY = 1,                /* Mount read-only.  */
>       |   ^~~~~~~~~
> CC lib/tst_fill_file.o
> make[1]: *** [/__w/ltp/ltp/include/mk/rules.mk:15: tst_fd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> 
> https://sourceware.org/glibc/wiki/Synchronizing_Headers
> does mention conflict between <linux/mount.h> and <sys/mount.h>,
> and that's what happen - <linux/fs.h> includes <linux/mount.h>.
> 
> I send a fix for this which should be applied before the release:
> https://patchwork.ozlabs.org/project/ltp/patch/20240105002914.1463989-1-pvorel@suse.cz/
> 
> It fixes most of the distros:
> https://github.com/pevik/ltp/actions/runs/7416413061/job/20181348475
> 
> But unfortunately it fails on one distro: Ubuntu Bionic (glibc 2.27):
> https://github.com/pevik/ltp/actions/runs/7416413061/job/20181348475
> 
> In file included from ../include/lapi/io_uring.h:17:0,
>                  from tst_fd.c:21:
> /usr/include/x86_64-linux-gnu/sys/mount.h:35:3: error: expected identifier before numeric constant
>    MS_RDONLY = 1,  /* Mount read-only.  */
>    ^
> ../include/mk/rules.mk:15: recipe for target 'tst_fd.o' failed
> 
> I'm not sure if we can fix it. Somebody tried to fix it for QEMU:
> https://lore.kernel.org/qemu-devel/20220802164134.1851910-1-berrange@redhat.com/
> 
> which got later deleted due accepted glibc fix:
> https://lore.kernel.org/qemu-devel/20231109135933.1462615-46-mjt@tls.msk.ru/
> 
> Maybe it's time to drop Ubuntu Bionic? We have Leap 42.2, which is the oldest
> distro we care and it works on it (probably it does not have HAVE_FSOPEN
> defined).
> 
> There is yet another error for very old distros ie. old Leap 42.2 (glibc 2.22),
> probably missing fallback definitions?
> https://github.com/pevik/ltp/actions/runs/7415994730/job/20180153354
> 
> In file included from ../include/lapi/io_uring.h:17:0,
>                  from tst_fd.c:21:
> /usr/include/sys/mount.h:35:3: error: expected identifier before numeric constant
>    MS_RDONLY = 1,  /* Mount read-only.  */
>    ^
> tst_fd.c: In function 'open_io_uring':
> tst_fd.c:195:9: warning: missing initializer for field 'sq_entries' of 'struct io_uring_params' [-Wmissing-field-initializers]
>   struct io_uring_params uring_params = {};
>          ^
> In file included from tst_fd.c:21:0:
> ../include/lapi/io_uring.h:198:11: note: 'sq_entries' declared here
>   uint32_t sq_entries;
>            ^
> tst_fd.c: In function 'open_bpf_map':
> tst_fd.c:208:3: warning: missing initializer for field 'key_size' of 'struct <anonymous>' [-Wmissing-field-initializers]
>    .key_size = 4,
>    ^
> In file included from tst_fd.c:22:0:
> ../include/lapi/bpf.h:185:12: note: 'key_size' declared here
>    uint32_t key_size; /* size of key in bytes */
>             ^
> tst_fd.c:209:3: warning: missing initializer for field 'value_size' of 'struct <anonymous>' [-Wmissing-field-initializers]
>    .value_size = 8,
>    ^
> In file included from tst_fd.c:22:0:
> ../include/lapi/bpf.h:186:12: note: 'value_size' declared here
>    uint32_t value_size; /* size of value in bytes */
>             ^
> tst_fd.c:210:3: warning: missing initializer for field 'max_entries' of 'struct <anonymous>' [-Wmissing-field-initializers]
>    .max_entries = 1,
>    ^
> In file included from tst_fd.c:22:0:
> ../include/lapi/bpf.h:187:12: note: 'max_entries' declared here
>    uint32_t max_entries; /* max number of entries in a map */
>             ^
> tst_fd.c:211:2: warning: missing initializer for field 'map_flags' of 'struct <anonymous>' [-Wmissing-field-initializers]
>   };
>   ^
> In file included from tst_fd.c:22:0:
> ../include/lapi/bpf.h:188:12: note: 'map_flags' declared here
>    uint32_t map_flags; /* BPF_MAP_CREATE related
>             ^
> make[1]: *** [tst_fd.o] Error 1
> ../include/mk/rules.mk:15: recipe for target 'tst_fd.o' failed

Uff, do we still support distros with these header failures?

I especailly used the lapi/ headers where possible in order to avoid any
compilation failures, if lapi/bpf.h fails it's lapi/bpf.h that is broken
though.

> > +static void destroy_pipe(struct tst_fd *fd)
> > +{
> > +	SAFE_CLOSE(fd->priv);
> > +}
> > +
> > +static void open_unix_sock(struct tst_fd *fd)
> > +{
> > +	fd->fd = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
> > +}
> > +
> > +static void open_inet_sock(struct tst_fd *fd)
> > +{
> > +	fd->fd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> > +}
> > +
> > +static void open_epoll(struct tst_fd *fd)
> > +{
> > +	fd->fd = epoll_create(1);
> > +
> > +	if (fd->fd < 0)
> > +		tst_brk(TBROK | TERRNO, "epoll_create()");
> > +}
> > +
> > +static void open_eventfd(struct tst_fd *fd)
> > +{
> > +	fd->fd = eventfd(0, 0);
> > +
> > +	if (fd->fd < 0) {
> > +		tst_res(TCONF | TERRNO,
> > +			"Skipping %s", tst_fd_desc(fd));
> Why there is sometimes TCONF? Permissions? I would expect some check which would
> determine whether TCONF or TBROK. Again, I suppose you'll be able to check, when
> TST_EXP_FAIL() merged, right?

The TCONF branch is added to the calls that can be disabled in kernel.
The CONFIG_EVENTFD can turn off the eventfd() syscall so we can't TBROK
here on a failure.

> > +	}
> > +}
> > +
> > +static void open_signalfd(struct tst_fd *fd)
> > +{
> > +	sigset_t sfd_mask;
> > +	sigemptyset(&sfd_mask);
> > +
> > +	fd->fd = signalfd(-1, &sfd_mask, 0);
> > +	if (fd->fd < 0) {
> > +		tst_res(TCONF | TERRNO,
> > +			"Skipping %s", tst_fd_desc(fd));
> > +	}
> > +}
> > +
> > +static void open_timerfd(struct tst_fd *fd)
> > +{
> > +	fd->fd = timerfd_create(CLOCK_REALTIME, 0);
> > +	if (fd->fd < 0) {
> > +		tst_res(TCONF | TERRNO,
> > +			"Skipping %s", tst_fd_desc(fd));
> > +	}
> > +}
> > +
> > +static void open_pidfd(struct tst_fd *fd)
> > +{
> > +	fd->fd = pidfd_open(getpid(), 0);
> > +	if (fd->fd < 0)
> > +		tst_brk(TBROK | TERRNO, "pidfd_open()");
> > +}
> > +
> > +static void open_fanotify(struct tst_fd *fd)
> > +{
> > +	fd->fd = fanotify_init(FAN_CLASS_NOTIF, O_RDONLY);
> FYI we have safe_fanotify_init(), which checks for ENOSYS.

But it calls tst_brk() on ENOSYS so we can't use that here.

> > +	if (fd->fd < 0) {
> > +		tst_res(TCONF | TERRNO,
> > +			"Skipping %s", tst_fd_desc(fd));
> > +	}
> > +}
> > +
> > +static void open_inotify(struct tst_fd *fd)
> > +{
> > +	fd->fd = inotify_init();
> > +	if (fd->fd < 0) {
> > +		tst_res(TCONF | TERRNO,
> > +			"Skipping %s", tst_fd_desc(fd));
> > +	}
> > +}
> > +
> > +static void open_userfaultfd(struct tst_fd *fd)
> > +{
> > +	fd->fd = syscall(__NR_userfaultfd, 0);
> Wouldn't be safe to use tst_syscall() ?

Again that one calls tst_brk() on ENOSYS, we can't call any of the tst_*
or safe_* variants because of that.

> > +
> > +	if (fd->fd < 0) {
> > +		tst_res(TCONF | TERRNO,
> > +			"Skipping %s", tst_fd_desc(fd));
> > +	}
> > +}
> 
> ...
> > +	[TST_FD_FSPICK] = {.open_fd = open_fspick, .desc = "fspick"},
> > +	[TST_FD_OPEN_TREE] = {.open_fd = open_open_tree, .desc = "open_tree"},
> > +	[TST_FD_MEMFD] = {.open_fd = open_memfd, .desc = "memfd"},
> > +	[TST_FD_MEMFD_SECRET] = {.open_fd = open_memfd_secret, .desc = "memfd secret"},
> > +};
> > +
> > +const char *tst_fd_desc(struct tst_fd *fd)
> > +{
> > +	if (fd->type >= ARRAY_SIZE(fd_desc))
> > +		return "invalid";
> Maybe use assert() instead?
> > +
> > +	return fd_desc[fd->type].desc;
> > +}
> > +
> > +void tst_fd_init(struct tst_fd *fd)
> This is not in tst_fd.h, thus check complains about not static.

Ah, right, this is a leftover that should be removed, will do.

-- 
Cyril Hrubis
chrubis@suse.cz

