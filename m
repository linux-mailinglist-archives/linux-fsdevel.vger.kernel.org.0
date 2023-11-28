Return-Path: <linux-fsdevel+bounces-4009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D5B7FB044
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 03:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899FC1C20AC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 02:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF9563B7;
	Tue, 28 Nov 2023 02:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X7BZn+Or";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UsROQUjP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E48BD;
	Mon, 27 Nov 2023 18:57:38 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ADDC82191E;
	Tue, 28 Nov 2023 02:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701140256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uloWfDy1qO999yjRt0c60XuGtbzcIMfOgvsyUIhr8g=;
	b=X7BZn+OrqnDGoi1OdIncbADYdlFkNrRZw5Nn14akM+QT+2ZRJr6I37h0HEQ0btengO+IJl
	rEf1vvF2D4etev9EQXscU8II4glksxNp03IKfypO1IKPJcEt4SWYNZSj2eeITPnXunOnR/
	HsRlYmtkHR3r9Asir0tBDN5FdnUaKrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701140256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uloWfDy1qO999yjRt0c60XuGtbzcIMfOgvsyUIhr8g=;
	b=UsROQUjPLnG6QALj8IyTnCBXCUzcvOCuAJuUSgfnDlW0ZBphTQzksDsv0u5O9ID/5o6HrQ
	xsR87J2Y6mXsNnAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29C0513763;
	Tue, 28 Nov 2023 02:57:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dowRMx1XZWWefQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 28 Nov 2023 02:57:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
  linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
In-reply-to: <ZWVEcasahyVQ4QqV@tissot.1015granger.net>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>,
 <ZWUfNyO6OG/+aFuo@tissot.1015granger.net>,
 <170113056683.7109.13851405274459689039@noble.neil.brown.name>,
 <ZWVEcasahyVQ4QqV@tissot.1015granger.net>
Date: Tue, 28 Nov 2023 13:57:30 +1100
Message-id: <170114025065.7109.15330780753462853254@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -8.10
X-Spamd-Result: default: False [-8.10 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]


(trimmed cc...)

On Tue, 28 Nov 2023, Chuck Lever wrote:
> On Tue, Nov 28, 2023 at 11:16:06AM +1100, NeilBrown wrote:
> > On Tue, 28 Nov 2023, Chuck Lever wrote:
> > > On Tue, Nov 28, 2023 at 09:05:21AM +1100, NeilBrown wrote:
> > > >=20
> > > > I have evidence from a customer site of 256 nfsd threads adding files=
 to
> > > > delayed_fput_lists nearly twice as fast they are retired by a single
> > > > work-queue thread running delayed_fput().  As you might imagine this
> > > > does not end well (20 million files in the queue at the time a snapsh=
ot
> > > > was taken for analysis).
> > > >=20
> > > > While this might point to a problem with the filesystem not handling =
the
> > > > final close efficiently, such problems should only hurt throughput, n=
ot
> > > > lead to memory exhaustion.
> > >=20
> > > I have this patch queued for v6.8:
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=
=3Dnfsd-next&id=3Dc42661ffa58acfeaf73b932dec1e6f04ce8a98c0
> > >=20
> >=20
> > Thanks....
> > I think that change is good, but I don't think it addresses the problem
> > mentioned in the description, and it is not directly relevant to the
> > problem I saw ... though it is complicated.
> >=20
> > The problem "workqueue ...  hogged cpu..." probably means that
> > nfsd_file_dispose_list() needs a cond_resched() call in the loop.
> > That will stop it from hogging the CPU whether it is tied to one CPU or
> > free to roam.
> >=20
> > Also that work is calling filp_close() which primarily calls
> > filp_flush().
> > It also calls fput() but that does minimal work.  If there is much work
> > to do then that is offloaded to another work-item.  *That* is the
> > workitem that I had problems with.
> >=20
> > The problem I saw was with an older kernel which didn't have the nfsd
> > file cache and so probably is calling filp_close more often.
>=20
> Without the file cache, the filp_close() should be handled directly
> by the nfsd thread handling the RPC, IIRC.

Yes - but __fput() is handled by a workqueue.

>=20
>=20
> > So maybe
> > my patch isn't so important now.  Particularly as nfsd now isn't closing
> > most files in-task but instead offloads that to another task.  So the
> > final fput will not be handled by the nfsd task either.
> >=20
> > But I think there is room for improvement.  Gathering lots of files
> > together into a list and closing them sequentially is not going to be as
> > efficient as closing them in parallel.
>=20
> I believe the file cache passes the filps to the work queue one at

nfsd_file_close_inode() does.  nfsd_file_gc() and nfsd_file_lru_scan()
can pass multiple.

> a time, but I don't think there's anything that forces the work
> queue to handle each flush/close completely before proceeding to the
> next.

Parallelism with workqueues is controlled by the work items (struct
work_struct).  Two different work items can run in parallel.  But any
given work item can never run parallel to itself.

The only work items queued on nfsd_filecache_wq are from
  nn->fcache_disposal->work.
There is one of these for each network namespace.  So in any given
network namespace, all work on nfsd_filecache_wq is fully serialised.

>=20
> IOW there is some parallelism there already, especially now that
> nfsd_filecache_wq is UNBOUND.

No there is not.  And UNBOUND makes no difference to parallelism in this
case.  It allows the one work item to migrate between CPUs while it is
running, but it doesn't allow it to run concurrently on two different
CPUs.


(UNBOUND can improve parallelism when multiple different work items are
 submitted all from the same CPU.  Without UNBOUND all the work would
 happen on the same CPU, though if the work sleeps, the different work
 items can be interleaved.  With UNBOUND the different work items can
 enjoy true parallelism when needed).


>=20
>=20
> > > > For normal threads, the thread that closes the file also calls the
> > > > final fput so there is natural rate limiting preventing excessive gro=
wth
> > > > in the list of delayed fputs.  For kernel threads, and particularly f=
or
> > > > nfsd, delayed in the final fput do not impose any throttling to preve=
nt
> > > > the thread from closing more files.
> > >=20
> > > I don't think we want to block nfsd threads waiting for files to
> > > close. Won't that be a potential denial of service?
> >=20
> > Not as much as the denial of service caused by memory exhaustion due to
> > an indefinitely growing list of files waiting to be closed by a single
> > thread of workqueue.
>=20
> The cache garbage collector is single-threaded, but nfsd_filecache_wq
> has a max_active setting of zero.

This allows parallelism between network namespaces, but not within a
network namespace.

>=20
>=20
> > I think it is perfectly reasonable that when handling an NFSv4 CLOSE,
> > the nfsd thread should completely handle that request including all the
> > flush and ->release etc.  If that causes any denial of service, then
> > simple increase the number of nfsd threads.
> >=20
> > For NFSv3 it is more complex.  On the kernel where I saw a problem the
> > filp_close happen after each READ or WRITE (though I think the customer
> > was using NFSv4...).  With the file cache there is no thread that is
> > obviously responsible for the close.
> > To get the sort of throttling that I think is need, we could possibly
> > have each "nfsd_open" check if there are pending closes, and to wait for
> > some small amount of progress.
>=20
> Well nfsd_open() in particular appears to be used only for readdir.
>=20
> But maybe nfsd_file_acquire() could wait briefly, in the garbage-
> collected case, if the nfsd_net's disposal queue is long.
>=20
>=20
> > But don't think it is reasonable for the nfsd threads to take none of
> > the burden of closing files as that can result in imbalance.
> >=20
> > I'll need to give this more thought.
>=20
>=20
> --=20
> Chuck Lever
>=20

Thanks,
NeilBrown

