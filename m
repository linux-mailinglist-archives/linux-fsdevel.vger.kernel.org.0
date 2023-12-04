Return-Path: <linux-fsdevel+bounces-4813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6168041C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 23:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56579B20B34
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 22:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA44A3C088
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 22:41:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEBE102;
	Mon,  4 Dec 2023 14:21:19 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D2E451FE77;
	Mon,  4 Dec 2023 22:21:17 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B734F139AA;
	Mon,  4 Dec 2023 22:21:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IJHnFthQbmX8bAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Dec 2023 22:21:12 +0000
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
Subject:
 Re: [PATCH 2/2] nfsd: Don't leave work of closing files to a work queue.
In-reply-to: <ZW4FMaXIbJpz9q1P@tissot.1015granger.net>
References: <20231204014042.6754-1-neilb@suse.de>,
 <20231204014042.6754-3-neilb@suse.de>,
 <ZW4FMaXIbJpz9q1P@tissot.1015granger.net>
Date: Tue, 05 Dec 2023 09:21:08 +1100
Message-id: <170172846859.7109.7793736990503454731@noble.neil.brown.name>
X-Spamd-Bar: ++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of neilb@suse.de) smtp.mailfrom=neilb@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [6.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(2.61)[0.745];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 6.40
X-Rspamd-Queue-Id: D2E451FE77

On Tue, 05 Dec 2023, Chuck Lever wrote:
> On Mon, Dec 04, 2023 at 12:36:42PM +1100, NeilBrown wrote:
> > The work of closing a file can have non-trivial cost.  Doing it in a
> > separate work queue thread means that cost isn't imposed on the nfsd
> > threads and an imbalance can be created.
> >=20
> > I have evidence from a customer site when nfsd is being asked to modify
> > many millions of files which causes sufficient memory pressure that some
> > cache (in XFS I think) gets cleaned earlier than would be ideal.  When
> > __dput (from the workqueue) calls __dentry_kill, xfs_fs_destroy_inode()
> > needs to synchronously read back previously cached info from storage.
> > This slows down the single thread that is making all the final __dput()
> > calls for all the nfsd threads with the net result that files are added
> > to the delayed_fput_list faster than they are removed, and the system
> > eventually runs out of memory.
> >=20
> > To avoid this work imbalance that exhausts memory, this patch moves all
> > work for closing files into the nfsd threads.  This means that when the
> > work imposes a cost, that cost appears where it would be expected - in
> > the work of the nfsd thread.
>=20
> Thanks for pursuing this next step in the evolution of the NFSD
> file cache.
>=20
> Your problem statement should mention whether you have observed the
> issue with an NFSv3 or an NFSv4 workload or if you see this issue
> with both, since those two use cases are handled very differently
> within the file cache implementation.

I have added:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The customer was using NFSv4.  I can demonstrate the same problem using
NFSv3 or NFSv4 (which close files in different ways) by adding
msleep(25) to for FMODE_WRITE files in __fput().  This simulates
slowness in the final close and when writing through nfsd it causes
/proc/sys/fs/file-nr to grow without bound.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

>=20
>=20
> > There are two changes to achieve this.
> >=20
> > 1/ PF_RUNS_TASK_WORK is set and task_work_run() is called, so that the
> >    final __dput() for any file closed by a given nfsd thread is handled
> >    by that thread.  This ensures that the number of files that are
> >    queued for a final close is limited by the number of threads and
> >    cannot grow without bound.
> >=20
> > 2/ Files opened for NFSv3 are never explicitly closed by the client and a=
re
> >   kept open by the server in the "filecache", which responds to memory
> >   pressure, is garbage collected even when there is no pressure, and
> >   sometimes closes files when there is particular need such as for
> >   rename.
>=20
> There is a good reason for close-on-rename: IIRC we want to avoid
> triggering a silly-rename on NFS re-exports.
>=20
> Also, I think we do want to close cached garbage-collected files
> quickly, even without memory pressure. Files left open in this way
> can conflict with subsequent NFSv4 OPENs that might hand out a
> delegation as long as no other clients are using them. Files held
> open by the file cache will interfere with that.

Yes - I agree all this behaviour is appropriate.  I was just setting out
the current behaviour of the filecache so that effect of the proposed
changes would be easier to understand.

>=20
>=20
> >   These files currently have filp_close() called in a dedicated
> >   work queue, so their __dput() can have no effect on nfsd threads.
> >=20
> >   This patch discards the work queue and instead has each nfsd thread
> >   call flip_close() on as many as 8 files from the filecache each time
> >   it acts on a client request (or finds there are no pending client
> >   requests).  If there are more to be closed, more threads are woken.
> >   This spreads the work of __dput() over multiple threads and imposes
> >   any cost on those threads.
> >=20
> >   The number 8 is somewhat arbitrary.  It needs to be greater than 1 to
> >   ensure that files are closed more quickly than they can be added to
> >   the cache.  It needs to be small enough to limit the per-request
> >   delays that will be imposed on clients when all threads are busy
> >   closing files.
>=20
> IMO we want to explicitly separate the mechanisms of handling
> garbage-collected files and non-garbage-collected files.

I think we already have explicit separation.
garbage-collected files are handled to nfsd_file_display_list_delayed(),
either when they fall off the lru or through nfsd_file_close_inode() -
which is used by lease and fsnotify callbacks.

non-garbage collected files are closed directly by nfsd_file_put().

>=20
> In the non-garbage-collected (NFSv4) case, the kthread can wait
> for everything it has opened to be closed. task_work seems
> appropriate for that IIUC.

Agreed.  The task_work change is all that we need for NFSv4.

>=20
> The problem with handling a limited number of garbage-collected
> items is that once the RPC workload stops, any remaining open
> files will remain open because garbage collection has effectively
> stopped. We really need those files closed out within a couple of
> seconds.

Why would garbage collection stop?
nfsd_filecache_laundrette is still running on the system_wq.  It will
continue to garbage collect and queue files using
nfsd_file_display_list_delayed().
That will wake up an nfsd thread if none is running.  The thread will
close a few, but will first wake another thread if there was more than
it was willing to manage.  So the closing of files should proceed
promptly, and if any close operation takes a non-trivial amount of time,
more threads will be woken and work will proceed in parallel.

>=20
> We used to have watermarks in the nfsd_file_put() path to kick
> garbage-collection if there were too many open files. Instead,
> waiting for the GC thread to make progress before recycling the
> kthread might be beneficial.

"too many" is only meaningful in the context of memory usage.  Having
the shrinker callback is exactly the right way to address this - nothing
else is needed.

The GC thread is expected to be CPU intensive.  The main cause of delay
is skipping over lots of files that cannot be closed yet - looking for
files that can.  This could delay the closing of files, but not nearly
as much as the delays I saw caused by synchronous IO.

We might be able to improve the situation a bit by queuing files as soon
as list_lru_walk finds them, rather than gathering them all into a list
and the queuing them one by one from that list.

It isn't clear to me that there is an issue here that needs fixing.

>=20
> And, as we discussed in a previous thread, replacing the per-
> namespace worker with a parallel mechanism would help GC proceed
> more quickly to reduce the flush/close backlog for NFSv3.

This patch discards the per-namespace worker.

The GC step (searching the LRU list for "garbage") is still
single-threaded.  The filecache is shared by all net-namespaces and
there is a single GC thread for the filecache.

Files that are found *were* filp_close()ed by per-net-fs work-items.
With this patch the filp_close() is called by the nfsd threads.

The file __fput of those files *was* handled by a single system-wide
work-item.  With this patch they are called by the nfsd thread which
called the filp_close().

>=20
>=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/filecache.c | 62 ++++++++++++++++++---------------------------
> >  fs/nfsd/filecache.h |  1 +
> >  fs/nfsd/nfssvc.c    |  6 +++++
> >  3 files changed, 32 insertions(+), 37 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index ee9c923192e0..55268b7362d4 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/fsnotify.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/rhashtable.h>
> > +#include <linux/task_work.h>
> > =20
> >  #include "vfs.h"
> >  #include "nfsd.h"
> > @@ -61,13 +62,10 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_total_=
age);
> >  static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
> > =20
> >  struct nfsd_fcache_disposal {
> > -	struct work_struct work;
> >  	spinlock_t lock;
> >  	struct list_head freeme;
> >  };
> > =20
> > -static struct workqueue_struct *nfsd_filecache_wq __read_mostly;
> > -
> >  static struct kmem_cache		*nfsd_file_slab;
> >  static struct kmem_cache		*nfsd_file_mark_slab;
> >  static struct list_lru			nfsd_file_lru;
> > @@ -421,10 +419,31 @@ nfsd_file_dispose_list_delayed(struct list_head *di=
spose)
> >  		spin_lock(&l->lock);
> >  		list_move_tail(&nf->nf_lru, &l->freeme);
> >  		spin_unlock(&l->lock);
> > -		queue_work(nfsd_filecache_wq, &l->work);
> > +		svc_wake_up(nn->nfsd_serv);
> >  	}
> >  }
> > =20
> > +/**
> > + * nfsd_file_dispose_some
>=20
> This needs a short description and:
>=20
>  * @nn: namespace to check
>=20
> Or something more enlightening than that.
>=20
> Also, the function name exposes mechanism; I think I'd prefer a name
> that is more abstract, such as nfsd_file_net_release() ?

Sometimes exposing mechanism is a good thing.  It means the casual reader
can get a sense of what the function does without having to look at the
function.
So I still prefer my name, but I changed to nfsd_file_net_dispose() so
as suit your preference, but follow the established pattern of using the
word "dispose".  "release" usually just drops a reference.  "dispose"
makes it clear that the thing is going away now.

/**
 * nfsd_file_net_dispose - deal with nfsd_files wait to be disposed.
 * @nn: nfsd_net in which to find files to be disposed.
 *
 * When files held open for nfsv3 are removed from the filecache, whether
 * due to memory pressure or garbage collection, they are queued to
 * a per-net-ns queue.  This function completes the disposal, either
 * directly or by waking another nfsd thread to help with the work.
 */
=20
>=20
> > + *
> > + */
> > +void nfsd_file_dispose_some(struct nfsd_net *nn)
> > +{
> > +	struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> > +	LIST_HEAD(dispose);
> > +	int i;
> > +
> > +	if (list_empty(&l->freeme))
> > +		return;
> > +	spin_lock(&l->lock);
> > +	for (i =3D 0; i < 8 && !list_empty(&l->freeme); i++)
> > +		list_move(l->freeme.next, &dispose);
> > +	spin_unlock(&l->lock);
> > +	if (!list_empty(&l->freeme))
> > +		svc_wake_up(nn->nfsd_serv);
> > +	nfsd_file_dispose_list(&dispose);
..
> > @@ -949,6 +950,7 @@ nfsd(void *vrqstp)
> >  	}
> > =20
> >  	current->fs->umask =3D 0;
> > +	current->flags |=3D PF_RUNS_TASK_WORK;
> > =20
> >  	atomic_inc(&nfsdstats.th_cnt);
> > =20
> > @@ -963,6 +965,10 @@ nfsd(void *vrqstp)
> > =20
> >  		svc_recv(rqstp);
> >  		validate_process_creds();
> > +
> > +		nfsd_file_dispose_some(nn);
> > +		if (task_work_pending(current))
> > +			task_work_run();
>=20
> I'd prefer that these task_work details reside inside
> nfsd_file_dispose_some(), or whatever we want to call to call it ...

I don't agree.  They are performing quite separate tasks.
nfsd_file_net_dispose() is disposing files queued for this net.
task_run_work() is finalising the close of any file closed by this
thread, including those used for NFSv4 that are not touched by
nfsd_file_dispose_some().
I don't think they belong in the same function.

Thanks,
NeilBrown

