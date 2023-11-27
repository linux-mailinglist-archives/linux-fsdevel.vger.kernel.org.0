Return-Path: <linux-fsdevel+bounces-4000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F557FAD77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 23:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47AEB1C20CDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 22:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94980495CC;
	Mon, 27 Nov 2023 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ki96iRt+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B287EA;
	Mon, 27 Nov 2023 14:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3PzatJTAFuI9AA1q1PyzjD6sj+4//yZnqVg5MvBFhPA=; b=Ki96iRt+2k9IAxyOJxJ69225dH
	3s3CGMlrXW/53HNxRWoBDzzXcnGWu5Ff4/gLdtkaJtQinjTzDpWqihWFUR25cxJRqFS+0UQluG7SR
	0S52ZJhREva+EtvoYVhP/jbOuuWKnTXsj5HEhwqtCNpmLpxgQ1c4L9pqHYrBvzspDphzrZAmK8luR
	OFJVf0yBF0Bxj4qrXQ1GwEUWhW4fXKlxwc0MmJNGS/BBJTCff5TPyNdLFolh5sGo0U2MTz5EgwxO6
	ZAI6uCvgmRosdhvpHCxf3munWLk4SEXl86W/ambCxIHb40BdfE1S7tzfNLE45+EJOsR9z7+M7wEKm
	u1k/McjA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7k7y-004Ai6-2j;
	Mon, 27 Nov 2023 22:30:54 +0000
Date: Mon, 27 Nov 2023 22:30:54 +0000
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
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <20231127223054.GL38156@ZenIV>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 28, 2023 at 09:05:21AM +1100, NeilBrown wrote:

> A simple way to fix this is to treat nfsd threads like normal processes
> for task_work.  Thus the pending files are queued for the thread, and
> the same thread finishes the work.
> 
> Currently KTHREADs are assumed never to call task_work_run().  With this
> patch that it still the default but it is implemented by storing the
> magic value TASK_WORKS_DISABLED in ->task_works.  If a kthread, such as
> nfsd, will call task_work_run() periodically, it sets ->task_works
> to NULL to indicate this.

>  		svc_recv(rqstp);
>  		validate_process_creds();
> +		if (task_work_pending(current))
> +			task_work_run();

What locking environment and call chain do you have here?  And what happens if
you get something stuck in ->release()?

>  
>  	p->pdeath_signal = 0;
> -	p->task_works = NULL;
> +	p->task_works = args->kthread ? TASK_WORKS_DISABLED : NULL;

Umm... why not have them set (by helper in kernel/task_work.c) to
&work_exited?  Then the task_work_run parts wouldn't be needed at all...

