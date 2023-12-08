Return-Path: <linux-fsdevel+bounces-5289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B6080994B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 03:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024C31F211F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 02:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4739B23A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 02:35:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879FC11D;
	Thu,  7 Dec 2023 17:40:32 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDEB0220D6;
	Fri,  8 Dec 2023 01:40:30 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7024413725;
	Fri,  8 Dec 2023 01:40:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mp1ECAp0cmXfEwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 08 Dec 2023 01:40:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Jens Axboe" <axboe@kernel.dk>, "Al Viro" <viro@zeniv.linux.org.uk>,
 "Oleg Nesterov" <oleg@redhat.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH 1/2] Allow a kthread to declare that it calls task_work_run()
In-reply-to: <20231206-karawane-kiesgrube-4bbf37bda8e1@brauner>
References: <e9a1cfed-42e9-4174-bbb3-1a3680cf6a5c@kernel.dk>,
 <170172377302.7109.11739406555273171485@noble.neil.brown.name>,
 <a070b6bd-0092-405e-99d2-00002596c0bc@kernel.dk>,
 <20231205-altbacken-umbesetzen-e5c0c021ab98@brauner>,
 <170181169515.7109.11121482729257102758@noble.neil.brown.name>,
 <fb713388-661a-46e0-8925-6d169b46ff9c@kernel.dk>,
 <3609267c-3fcd-43d6-9b43-9f84bef029a2@kernel.dk>,
 <170181458198.7109.790647899711986334@noble.neil.brown.name>,
 <170181861776.7109.6396373836638614121@noble.neil.brown.name>,
 <c24af958-b933-42dd-9806-9d288463547b@kernel.dk>,
 <20231206-karawane-kiesgrube-4bbf37bda8e1@brauner>
Date: Fri, 08 Dec 2023 12:40:23 +1100
Message-id: <170199962326.12910.10739164577987751755@noble.neil.brown.name>
X-Spamd-Result: default: False [3.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
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
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of neilb@suse.de) smtp.mailfrom=neilb@suse.de
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: EDEB0220D6
X-Spam-Score: 3.79

On Thu, 07 Dec 2023, Christian Brauner wrote:
> On Tue, Dec 05, 2023 at 04:31:51PM -0700, Jens Axboe wrote:
> > On 12/5/23 4:23 PM, NeilBrown wrote:
> > > On Wed, 06 Dec 2023, NeilBrown wrote:
> > >> On Wed, 06 Dec 2023, Jens Axboe wrote:
> > >>> On 12/5/23 2:58 PM, Jens Axboe wrote:
> > >>>> On 12/5/23 2:28 PM, NeilBrown wrote:
> > >>>>> On Tue, 05 Dec 2023, Christian Brauner wrote:
> > >>>>>> On Mon, Dec 04, 2023 at 03:09:44PM -0700, Jens Axboe wrote:
> > >>>>>>> On 12/4/23 2:02 PM, NeilBrown wrote:
> > >>>>>>>> It isn't clear to me what _GPL is appropriate, but maybe the rul=
es
> > >>>>>>>> changed since last I looked..... are there rules?
> > >>>>>>>>
> > >>>>>>>> My reasoning was that the call is effectively part of the user-s=
pace
> > >>>>>>>> ABI.  A user-space process can call this trivially by invoking a=
ny
> > >>>>>>>> system call.  The user-space ABI is explicitly a boundary which =
the GPL
> > >>>>>>>> does not cross.  So it doesn't seem appropriate to prevent non-G=
PL
> > >>>>>>>> kernel code from doing something that non-GPL user-space code can
> > >>>>>>>> trivially do.
> > >>>>>>>
> > >>>>>>> By that reasoning, basically everything in the kernel should be n=
on-GPL
> > >>>>>>> marked. And while task_work can get used by the application, it h=
appens
> > >>>>>>> only indirectly or implicitly. So I don't think this reasoning is=
 sound
> > >>>>>>> at all, it's not an exported ABI or API by itself.
> > >>>>>>>
> > >>>>>>> For me, the more core of an export it is, the stronger the reason=
 it
> > >>>>>>> should be GPL. FWIW, I don't think exporting task_work functional=
ity is
> > >>>>
> > >>>>>>
> > >>>>>> Yeah, I'm not too fond of that part as well. I don't think we want=
 to
> > >>>>>> give modules the ability to mess with task work. This is just aski=
ng for
> > >>>>>> trouble.
> > >>>>>>
> > >>>>>
> > >>>>> Ok, maybe we need to reframe the problem then.
> > >>>>>
> > >>>>> Currently fput(), and hence filp_close(), take control away from ke=
rnel
> > >>>>> threads in that they cannot be sure that a "close" has actually
> > >>>>> completed.
> > >>>>>
> > >>>>> This is already a problem for nfsd.  When renaming a file, nfsd nee=
ds to
> > >>>>> ensure any cached "open" that it has on the file is closed (else wh=
en
> > >>>>> re-exporting an NFS filesystem it can result in a silly-rename).
> > >>>>>
> > >>>>> nfsd currently handles this case by calling flush_delayed_fput().  I
> > >>>>> suspect you are no more happy about exporting that than you are abo=
ut
> > >>>>> exporting task_work_run(), but this solution isn't actually 100%
> > >>>>> reliable.  If some other thread calls flush_delayed_fput() between =
nfsd
> > >>>>> calling filp_close() and that same nfsd calling flush_delayed_fput(=
),
> > >>>>> then the second flush can return before the first flush (in the oth=
er
> > >>>>> thread) completes all the work it took on.
> > >>>>>
> > >>>>> What we really need - both for handling renames and for avoiding
> > >>>>> possible memory exhaustion - is for nfsd to be able to reliably wai=
t for
> > >>>>> any fput() that it initiated to complete.
> > >>>>>
> > >>>>> How would you like the VFS to provide that service?
> > >>>>
> > >>>> Since task_work happens in the context of your task already, why not
> > >>>> just have a way to get it stashed into a list when final fput is don=
e?
> > >>>> This avoids all of this "let's expose task_work" and using the task =
list
> > >>>> for that, which seems kind of pointless as you're just going to run =
it
> > >>>> later on manually anyway.
> > >>>>
> > >>>> In semi pseudo code:
> > >>>>
> > >>>> bool fput_put_ref(struct file *file)
> > >>>> {
> > >>>> 	return atomic_dec_and_test(&file->f_count);
> > >>>> }
> > >>>>
> > >>>> void fput(struct file *file)
> > >>>> {
> > >>>> 	if (fput_put_ref(file)) {
> > >>>> 		...
> > >>>> 	}
> > >>>> }
> > >>>>
> > >>>> and then your nfsd_file_free() could do:
> > >>>>
> > >>>> ret =3D filp_flush(file, id);
> > >>>> if (fput_put_ref(file))
> > >>>> 	llist_add(&file->f_llist, &l->to_free_llist);
> > >>>>
> > >>>> or something like that, where l->to_free_llist is where ever you'd
> > >>>> otherwise punt the actual freeing to.
> > >>>
> > >>> Should probably have the put_ref or whatever helper also init the
> > >>> task_work, and then reuse the list in the callback_head there. Then
> > >>> whoever flushes it has to call ->func() and avoid exposing ____fput()=
 to
> > >>> random users. But you get the idea.
> > >>
> > >> Interesting ideas - thanks.
> > >>
> > >> So maybe the new API would be
> > >>
> > >>  fput_queued(struct file *f, struct llist_head *q)
> > >> and
> > >>  flush_fput_queue(struct llist_head *q)
> > >>
> > >> with the meaning being that fput_queued() is just like fput() except
> > >> that any file needing __fput() is added to the 'q'; and that
> > >> flush_fput_queue() calls __fput() on any files in 'q'.
> > >>
> > >> So to close a file nfsd would:
> > >>
> > >>   fget(f);
> > >>   flip_close(f);
> > >>   fput_queued(f, &my_queue);
> > >>
> > >> though possibly we could have a
> > >>   filp_close_queued(f, q)
> > >> as well.
> > >>
> > >> I'll try that out - but am happy to hear alternate suggestions for nam=
es :-)
> > >>
> > >=20
> > > Actually ....  I'm beginning to wonder if we should just use
> > > __fput_sync() in nfsd.
> > > It has a big warning about not doing that blindly, but the detail in the
> > > warning doesn't seem to apply to nfsd...
> >=20
> > If you can do it from the context where you do the filp_close() right
> > now, then yeah there's no reason to over-complicate this at all... FWIW,
>=20
> As long as nfsd doesn't care that it may get stuck on umount or
> ->release...

I think we do *care* about getting stuck.  But I don't think we would
*expect* to get stuck..

I had a look at varous ->release function.  Quite few do fsync or
similar which isn't a problem.  nfsd often waits for writes to complete.
Some lock the inode, which again is something that nfsd threads often
do.

Is there something special that ->release might do but that other
filesystem operation don't do?

I'd really like to understand why __fput is so special that we often
queue it to a separate thread.

>=20
> > the reason task_work exists is just to ensure a clean context to perform
> > these operations from the task itself. The more I think about it, it
> > doesn't make a lot of sense to utilize it for this purpose, which is
> > where my alternate suggestion came from. But if you can just call it
> > directly, then that makes everything much easier.
>=20
> And for better or worse we already expose __fput_sync(). We've recently
> switched close(2) over to it as well as it was needlessly punting to
> task work.
>=20

exit_files() would be another good candidate for using __fput_sync().
Oleg Nesterov has reported problems when a process which a large number
of files exits - this currently puts lots of entries on the task_works
lists.  If task_work_cancel is then called before those are all dealt
with, it can have a long list to search while holding a hot lock.  (I
hope I got that description right).

Thanks,
NeilBrown

