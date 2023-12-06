Return-Path: <linux-fsdevel+bounces-5004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A478072AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 15:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479A31C208C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 14:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E3F3EA74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKUOnAop"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1A83A8DB;
	Wed,  6 Dec 2023 14:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32C9C433C8;
	Wed,  6 Dec 2023 14:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701872695;
	bh=yAxNP/KsmR/YNvGy0F+OIyCx0P0kPH7Ro1vjgdv39v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iKUOnAopy+9rCODM+ULoF5aR7g4kWkvVq7zr2ALjiooHMlhT3d154QyU85z32LLKr
	 4GgBz/jBeSyIT/51QqITsP3GZqwu4UaQhALIqdBu6ndfLwOL6yAJWcUXU36Q/1PHQs
	 SnttLSgAITbBWgzgfoHIaR8YEK5+ccICJLMFxir/m0QkGn4Qg8eTJPhOTwGh2o/ie3
	 DQGwZFvYYwz7vA48SvQudXbIwt3xb23GhgTVmR5o2QfudJyVXSgF5nSAPK5zoWankR
	 rxE8to6FR/ZPiw1z97hQZGMagG5/7EMEcerSlzyp1lZVAlIGgaNBtJzaQWSLTim2RN
	 D5p9KdI7Keg9Q==
Date: Wed, 6 Dec 2023 15:24:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Oleg Nesterov <oleg@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Message-ID: <20231206-karawane-kiesgrube-4bbf37bda8e1@brauner>
References: <e9a1cfed-42e9-4174-bbb3-1a3680cf6a5c@kernel.dk>
 <170172377302.7109.11739406555273171485@noble.neil.brown.name>
 <a070b6bd-0092-405e-99d2-00002596c0bc@kernel.dk>
 <20231205-altbacken-umbesetzen-e5c0c021ab98@brauner>
 <170181169515.7109.11121482729257102758@noble.neil.brown.name>
 <fb713388-661a-46e0-8925-6d169b46ff9c@kernel.dk>
 <3609267c-3fcd-43d6-9b43-9f84bef029a2@kernel.dk>
 <170181458198.7109.790647899711986334@noble.neil.brown.name>
 <170181861776.7109.6396373836638614121@noble.neil.brown.name>
 <c24af958-b933-42dd-9806-9d288463547b@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c24af958-b933-42dd-9806-9d288463547b@kernel.dk>

On Tue, Dec 05, 2023 at 04:31:51PM -0700, Jens Axboe wrote:
> On 12/5/23 4:23 PM, NeilBrown wrote:
> > On Wed, 06 Dec 2023, NeilBrown wrote:
> >> On Wed, 06 Dec 2023, Jens Axboe wrote:
> >>> On 12/5/23 2:58 PM, Jens Axboe wrote:
> >>>> On 12/5/23 2:28 PM, NeilBrown wrote:
> >>>>> On Tue, 05 Dec 2023, Christian Brauner wrote:
> >>>>>> On Mon, Dec 04, 2023 at 03:09:44PM -0700, Jens Axboe wrote:
> >>>>>>> On 12/4/23 2:02 PM, NeilBrown wrote:
> >>>>>>>> It isn't clear to me what _GPL is appropriate, but maybe the rules
> >>>>>>>> changed since last I looked..... are there rules?
> >>>>>>>>
> >>>>>>>> My reasoning was that the call is effectively part of the user-space
> >>>>>>>> ABI.  A user-space process can call this trivially by invoking any
> >>>>>>>> system call.  The user-space ABI is explicitly a boundary which the GPL
> >>>>>>>> does not cross.  So it doesn't seem appropriate to prevent non-GPL
> >>>>>>>> kernel code from doing something that non-GPL user-space code can
> >>>>>>>> trivially do.
> >>>>>>>
> >>>>>>> By that reasoning, basically everything in the kernel should be non-GPL
> >>>>>>> marked. And while task_work can get used by the application, it happens
> >>>>>>> only indirectly or implicitly. So I don't think this reasoning is sound
> >>>>>>> at all, it's not an exported ABI or API by itself.
> >>>>>>>
> >>>>>>> For me, the more core of an export it is, the stronger the reason it
> >>>>>>> should be GPL. FWIW, I don't think exporting task_work functionality is
> >>>>
> >>>>>>
> >>>>>> Yeah, I'm not too fond of that part as well. I don't think we want to
> >>>>>> give modules the ability to mess with task work. This is just asking for
> >>>>>> trouble.
> >>>>>>
> >>>>>
> >>>>> Ok, maybe we need to reframe the problem then.
> >>>>>
> >>>>> Currently fput(), and hence filp_close(), take control away from kernel
> >>>>> threads in that they cannot be sure that a "close" has actually
> >>>>> completed.
> >>>>>
> >>>>> This is already a problem for nfsd.  When renaming a file, nfsd needs to
> >>>>> ensure any cached "open" that it has on the file is closed (else when
> >>>>> re-exporting an NFS filesystem it can result in a silly-rename).
> >>>>>
> >>>>> nfsd currently handles this case by calling flush_delayed_fput().  I
> >>>>> suspect you are no more happy about exporting that than you are about
> >>>>> exporting task_work_run(), but this solution isn't actually 100%
> >>>>> reliable.  If some other thread calls flush_delayed_fput() between nfsd
> >>>>> calling filp_close() and that same nfsd calling flush_delayed_fput(),
> >>>>> then the second flush can return before the first flush (in the other
> >>>>> thread) completes all the work it took on.
> >>>>>
> >>>>> What we really need - both for handling renames and for avoiding
> >>>>> possible memory exhaustion - is for nfsd to be able to reliably wait for
> >>>>> any fput() that it initiated to complete.
> >>>>>
> >>>>> How would you like the VFS to provide that service?
> >>>>
> >>>> Since task_work happens in the context of your task already, why not
> >>>> just have a way to get it stashed into a list when final fput is done?
> >>>> This avoids all of this "let's expose task_work" and using the task list
> >>>> for that, which seems kind of pointless as you're just going to run it
> >>>> later on manually anyway.
> >>>>
> >>>> In semi pseudo code:
> >>>>
> >>>> bool fput_put_ref(struct file *file)
> >>>> {
> >>>> 	return atomic_dec_and_test(&file->f_count);
> >>>> }
> >>>>
> >>>> void fput(struct file *file)
> >>>> {
> >>>> 	if (fput_put_ref(file)) {
> >>>> 		...
> >>>> 	}
> >>>> }
> >>>>
> >>>> and then your nfsd_file_free() could do:
> >>>>
> >>>> ret = filp_flush(file, id);
> >>>> if (fput_put_ref(file))
> >>>> 	llist_add(&file->f_llist, &l->to_free_llist);
> >>>>
> >>>> or something like that, where l->to_free_llist is where ever you'd
> >>>> otherwise punt the actual freeing to.
> >>>
> >>> Should probably have the put_ref or whatever helper also init the
> >>> task_work, and then reuse the list in the callback_head there. Then
> >>> whoever flushes it has to call ->func() and avoid exposing ____fput() to
> >>> random users. But you get the idea.
> >>
> >> Interesting ideas - thanks.
> >>
> >> So maybe the new API would be
> >>
> >>  fput_queued(struct file *f, struct llist_head *q)
> >> and
> >>  flush_fput_queue(struct llist_head *q)
> >>
> >> with the meaning being that fput_queued() is just like fput() except
> >> that any file needing __fput() is added to the 'q'; and that
> >> flush_fput_queue() calls __fput() on any files in 'q'.
> >>
> >> So to close a file nfsd would:
> >>
> >>   fget(f);
> >>   flip_close(f);
> >>   fput_queued(f, &my_queue);
> >>
> >> though possibly we could have a
> >>   filp_close_queued(f, q)
> >> as well.
> >>
> >> I'll try that out - but am happy to hear alternate suggestions for names :-)
> >>
> > 
> > Actually ....  I'm beginning to wonder if we should just use
> > __fput_sync() in nfsd.
> > It has a big warning about not doing that blindly, but the detail in the
> > warning doesn't seem to apply to nfsd...
> 
> If you can do it from the context where you do the filp_close() right
> now, then yeah there's no reason to over-complicate this at all... FWIW,

As long as nfsd doesn't care that it may get stuck on umount or
->release...

> the reason task_work exists is just to ensure a clean context to perform
> these operations from the task itself. The more I think about it, it
> doesn't make a lot of sense to utilize it for this purpose, which is
> where my alternate suggestion came from. But if you can just call it
> directly, then that makes everything much easier.

And for better or worse we already expose __fput_sync(). We've recently
switched close(2) over to it as well as it was needlessly punting to
task work.

