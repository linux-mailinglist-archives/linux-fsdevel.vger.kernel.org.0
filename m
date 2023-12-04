Return-Path: <linux-fsdevel+bounces-4808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EC28041C4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 23:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031C71F2131E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 22:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896BC3C464
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 22:40:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF62990;
	Mon,  4 Dec 2023 13:20:40 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 496631FE75;
	Mon,  4 Dec 2023 21:20:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBC7F1398A;
	Mon,  4 Dec 2023 21:20:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GGOwGqJCbmUoWAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Dec 2023 21:20:34 +0000
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
Cc: "Christian Brauner" <brauner@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Oleg Nesterov" <oleg@redhat.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH 1/2] Allow a kthread to declare that it calls task_work_run()
In-reply-to: <20231204024031.GV38156@ZenIV>
References: <20231204014042.6754-1-neilb@suse.de>,
 <20231204014042.6754-2-neilb@suse.de>, <20231204024031.GV38156@ZenIV>
Date: Tue, 05 Dec 2023 08:20:31 +1100
Message-id: <170172483155.7109.15983228851050210918@noble.neil.brown.name>
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of neilb@suse.de) smtp.mailfrom=neilb@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [3.59 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.20)[-0.198];
	 MIME_GOOD(-0.10)[text/plain];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 3.59
X-Rspamd-Queue-Id: 496631FE75

On Mon, 04 Dec 2023, Al Viro wrote:
> On Mon, Dec 04, 2023 at 12:36:41PM +1100, NeilBrown wrote:
> 
> > This means that any cost for doing the work is not imposed on the kernel
> > thread, and importantly excessive amounts of work cannot apply
> > back-pressure to reduce the amount of new work queued.
> 
> It also means that a stuck ->release() won't end up with stuck
> kernel thread...

Is a stuck kernel thread any worse than a stuck user-space thread?

> 
> > earlier than would be ideal.  When __dput (from the workqueue) calls
> 
> WTF is that __dput thing?  __fput, perhaps?

Either __fput or dput :-)
->release isn't the problem that I am seeing.
The call trace that I see causing problems is
__fput -> dput -> dentry_kill -> destroy_inode -> xfs_fs_destroy_inode

so both __fput and dput are there, but most of the code is dput related.
So both "put"s were swimming in by brain and the wrong combination came
out.
I changed it to __fput - thanks.

> 
> > This patch adds a new process flag PF_RUNS_TASK_WORK which is now used
> > instead of PF_KTHREAD to determine whether it is sensible to queue
> > something to task_works.  This flag is always set for non-kernel threads.
> 
> *ugh*
> 
> What's that flag for?  task_work_add() always can fail; any caller must
> have a fallback to cope with that possibility; fput() certainly does.

As Oleg pointed out, all threads including kernel threads call
task_work_run() at exit, and some kernel threads depend on this.  So
disabling task_work_add() early for all kernel threads would break
things.

Currently task_work_add() fails only once the process has started
exiting.  Only code that might run during the exit handling need check.

> 
> Just have the kernel threads born with ->task_works set to &work_exited
> and provide a primitive that would flip it from that to NULL.
> 
> > @@ -1328,7 +1328,7 @@ static void mntput_no_expire(struct mount *mnt)
> >  
> >  	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
> >  		struct task_struct *task = current;
> > -		if (likely(!(task->flags & PF_KTHREAD))) {
> > +		if (likely((task->flags & PF_RUNS_TASK_WORK))) {
> >  			init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
> >  			if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
> >  				return;
> 
> Now, *that* is something I have much stronger objections to.
> Stuck filesystem shutdown is far more likely than stuck
> ->release().  You are seriously asking for trouble here.
> 
> Why would you want to have nfsd block on that?
> 

I don't *want* nfsd block on that, but I don't care if it does.  nfsd
will only call task_work_run() at a safe time.  This is no different to
user-space processes only calling task_work_run() at a safe time.

The new flag isn't "I_AM_NFSD" or "QUEUE_FPUT_WORK_TO_TASK".  It is
"RUNS_TASK_WORK".  So any code that would prefer to call task_work_add()
but has a fall-back for tasks that don't call run_task_work() should
test the new flag.  Doing otherwise would be inconsistent and
potentially confusing.

I don't think that nfsd getting stuck would be any worse than systemd
getting stuck, or automount getting stuck, or udiskd getting stuck.

Thanks,
NeilBrown

