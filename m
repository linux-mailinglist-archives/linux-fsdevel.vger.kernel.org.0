Return-Path: <linux-fsdevel+bounces-4720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C900802ADC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 05:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0FF28035F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 04:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7670281E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 04:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XueloJ4X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC06C5;
	Sun,  3 Dec 2023 18:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LVTxDRpbm4m8/L9l+PdmnoSZZXeKUDl437Ufb7hbh2I=; b=XueloJ4XOx6AvGagXXqf5zKEn6
	Kd5AGBMar6KgXfVvTp/7bdTGl3DdqsgzJxNve8zpIAvjgBZF3V0eQGEADal6zwOjS3aNKL4ftzMLN
	rjoiFwGFS3yizzESIkiPgOhziQogNXixp2rvMHVbe9hH6vo5z528uimva4HJN9LTEaMy3hA4xJJ6p
	2J6Go6+2sdlMnM6i2xxXWn5D9YFtLk7fb+WBiY5TRAwsMUSUTJSyv4r4slX7mtCWJzKfssciHJsOZ
	28eiZSUBaWqnd0eNWVAQ3j0FXQmUQpq9iWRRp65vJ4AaWDeVACyNu+yHrrr2reHauRZY7zS8495/5
	wOj7nPaA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r9ysp-006nG8-1T;
	Mon, 04 Dec 2023 02:40:31 +0000
Date: Mon, 4 Dec 2023 02:40:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <20231204024031.GV38156@ZenIV>
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204014042.6754-2-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 04, 2023 at 12:36:41PM +1100, NeilBrown wrote:

> This means that any cost for doing the work is not imposed on the kernel
> thread, and importantly excessive amounts of work cannot apply
> back-pressure to reduce the amount of new work queued.

It also means that a stuck ->release() won't end up with stuck
kernel thread...

> earlier than would be ideal.  When __dput (from the workqueue) calls

WTF is that __dput thing?  __fput, perhaps?

> This patch adds a new process flag PF_RUNS_TASK_WORK which is now used
> instead of PF_KTHREAD to determine whether it is sensible to queue
> something to task_works.  This flag is always set for non-kernel threads.

*ugh*

What's that flag for?  task_work_add() always can fail; any caller must
have a fallback to cope with that possibility; fput() certainly does.

Just have the kernel threads born with ->task_works set to &work_exited
and provide a primitive that would flip it from that to NULL.

> @@ -1328,7 +1328,7 @@ static void mntput_no_expire(struct mount *mnt)
>  
>  	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
>  		struct task_struct *task = current;
> -		if (likely(!(task->flags & PF_KTHREAD))) {
> +		if (likely((task->flags & PF_RUNS_TASK_WORK))) {
>  			init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
>  			if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
>  				return;

Now, *that* is something I have much stronger objections to.
Stuck filesystem shutdown is far more likely than stuck
->release().  You are seriously asking for trouble here.

Why would you want to have nfsd block on that?

