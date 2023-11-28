Return-Path: <linux-fsdevel+bounces-4006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684EE7FAEE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 01:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8FCB212D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 00:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717F07F4;
	Tue, 28 Nov 2023 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B562192;
	Mon, 27 Nov 2023 16:16:16 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08EC121940;
	Tue, 28 Nov 2023 00:16:15 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E086136C7;
	Tue, 28 Nov 2023 00:16:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id it1xB0oxZWXoWwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 28 Nov 2023 00:16:10 +0000
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
 "Christian Brauner" <brauner@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Oleg Nesterov" <oleg@redhat.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
 "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
In-reply-to: <ZWUfNyO6OG/+aFuo@tissot.1015granger.net>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>,
 <ZWUfNyO6OG/+aFuo@tissot.1015granger.net>
Date: Tue, 28 Nov 2023 11:16:06 +1100
Message-id: <170113056683.7109.13851405274459689039@noble.neil.brown.name>
X-Spamd-Bar: ++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of neilb@suse.de) smtp.mailfrom=neilb@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [6.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(2.70)[0.771];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 6.49
X-Rspamd-Queue-Id: 08EC121940

On Tue, 28 Nov 2023, Chuck Lever wrote:
> On Tue, Nov 28, 2023 at 09:05:21AM +1100, NeilBrown wrote:
> >=20
> > I have evidence from a customer site of 256 nfsd threads adding files to
> > delayed_fput_lists nearly twice as fast they are retired by a single
> > work-queue thread running delayed_fput().  As you might imagine this
> > does not end well (20 million files in the queue at the time a snapshot
> > was taken for analysis).
> >=20
> > While this might point to a problem with the filesystem not handling the
> > final close efficiently, such problems should only hurt throughput, not
> > lead to memory exhaustion.
>=20
> I have this patch queued for v6.8:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=3Dn=
fsd-next&id=3Dc42661ffa58acfeaf73b932dec1e6f04ce8a98c0
>=20

Thanks....
I think that change is good, but I don't think it addresses the problem
mentioned in the description, and it is not directly relevant to the
problem I saw ... though it is complicated.

The problem "workqueue ...  hogged cpu..." probably means that
nfsd_file_dispose_list() needs a cond_resched() call in the loop.
That will stop it from hogging the CPU whether it is tied to one CPU or
free to roam.

Also that work is calling filp_close() which primarily calls
filp_flush().
It also calls fput() but that does minimal work.  If there is much work
to do then that is offloaded to another work-item.  *That* is the
workitem that I had problems with.

The problem I saw was with an older kernel which didn't have the nfsd
file cache and so probably is calling filp_close more often.  So maybe
my patch isn't so important now.  Particularly as nfsd now isn't closing
most files in-task but instead offloads that to another task.  So the
final fput will not be handled by the nfsd task either.

But I think there is room for improvement.  Gathering lots of files
together into a list and closing them sequentially is not going to be as
efficient as closing them in parallel.

>=20
> > For normal threads, the thread that closes the file also calls the
> > final fput so there is natural rate limiting preventing excessive growth
> > in the list of delayed fputs.  For kernel threads, and particularly for
> > nfsd, delayed in the final fput do not impose any throttling to prevent
> > the thread from closing more files.
>=20
> I don't think we want to block nfsd threads waiting for files to
> close. Won't that be a potential denial of service?

Not as much as the denial of service caused by memory exhaustion due to
an indefinitely growing list of files waiting to be closed by a single
thread of workqueue.

I think it is perfectly reasonable that when handling an NFSv4 CLOSE,
the nfsd thread should completely handle that request including all the
flush and ->release etc.  If that causes any denial of service, then
simple increase the number of nfsd threads.

For NFSv3 it is more complex.  On the kernel where I saw a problem the
filp_close happen after each READ or WRITE (though I think the customer
was using NFSv4...).  With the file cache there is no thread that is
obviously responsible for the close.
To get the sort of throttling that I think is need, we could possibly
have each "nfsd_open" check if there are pending closes, and to wait for
some small amount of progress.

But don't think it is reasonable for the nfsd threads to take none of
the burden of closing files as that can result in imbalance.

I'll need to give this more thought.

Thanks,
NeilBrown


