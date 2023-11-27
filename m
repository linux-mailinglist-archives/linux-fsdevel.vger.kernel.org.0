Return-Path: <linux-fsdevel+bounces-4002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1097FADA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 23:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFC81C20BF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 22:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF7B48CF9;
	Mon, 27 Nov 2023 22:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5540137;
	Mon, 27 Nov 2023 14:43:43 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2996021923;
	Mon, 27 Nov 2023 22:43:42 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A69051379A;
	Mon, 27 Nov 2023 22:43:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NT+lFZkbZWXsRAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 Nov 2023 22:43:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Oleg Nesterov" <oleg@redhat.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
In-reply-to: <20231127223054.GL38156@ZenIV>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>,
 <20231127223054.GL38156@ZenIV>
Date: Tue, 28 Nov 2023 09:43:30 +1100
Message-id: <170112501017.7109.11367576354770728388@noble.neil.brown.name>
X-Spamd-Bar: ++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of neilb@suse.de) smtp.mailfrom=neilb@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [6.66 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[16.34%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.13)[-0.134];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 6.66
X-Rspamd-Queue-Id: 2996021923

On Tue, 28 Nov 2023, Al Viro wrote:
> On Tue, Nov 28, 2023 at 09:05:21AM +1100, NeilBrown wrote:
>=20
> > A simple way to fix this is to treat nfsd threads like normal processes
> > for task_work.  Thus the pending files are queued for the thread, and
> > the same thread finishes the work.
> >=20
> > Currently KTHREADs are assumed never to call task_work_run().  With this
> > patch that it still the default but it is implemented by storing the
> > magic value TASK_WORKS_DISABLED in ->task_works.  If a kthread, such as
> > nfsd, will call task_work_run() periodically, it sets ->task_works
> > to NULL to indicate this.
>=20
> >  		svc_recv(rqstp);
> >  		validate_process_creds();
> > +		if (task_work_pending(current))
> > +			task_work_run();
>=20
> What locking environment and call chain do you have here?  And what happens=
 if
> you get something stuck in ->release()?

No locking. This is in the top level function of the kthread.
A ->release function that waits for an NFS filesystem to flush out data
through a filesystem exported by this nfsd might hit problems.
But that really requires us nfs-exporting and nfs filesystem which is
loop-back mounted.  While we do support nfs-reexport and nfs-loop-back
mounts, I don't think we make any pretence of supporting a combination.

Is that the sort of thing you were think of?

>=20
> > =20
> >  	p->pdeath_signal =3D 0;
> > -	p->task_works =3D NULL;
> > +	p->task_works =3D args->kthread ? TASK_WORKS_DISABLED : NULL;
>=20
> Umm... why not have them set (by helper in kernel/task_work.c) to
> &work_exited?  Then the task_work_run parts wouldn't be needed at all...
>=20

I hadn't tried to understand what work_exited was for - but now I see
that its purpose is precisely to block further work from being queued -
exactly what I need.
Thanks - I make that change for a v2.

I've realised that I'll also need to change the flush_delayed_fput() in
fsd_file_close_inode_sync() to task_work_run().

Thanks,
NeilBrown



