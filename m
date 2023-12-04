Return-Path: <linux-fsdevel+bounces-4718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76964802A53
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 03:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E873280C40
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 02:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC52D8F60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CVVlyVrJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1013101;
	Sun,  3 Dec 2023 18:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SsyO4lSpIna9nQlHkHCb+VcH3551LY+52acm9hFhGCc=; b=CVVlyVrJxEBg2Dlyh4y8vfflT7
	q2uxs8LdAfB6rw6+ZOUhBW5EvZn+htCaCeLPtnK64sYUfOf+boOrTzgABjSap5FtNXKTXTqs01pH+
	TteMtKPJeELKRGpg42mJ1yP65XdMsC/4XIhEPKtku+cCgt/US+Bko0Xzrk4MZicvNpAMZywDWn/1J
	HnUOfGuX+rc/YAojLqIB/NX/oTh7cMZsT5t0u32JYN5OxAhBuzl4DxNfx2MfCbDJAUw0/jNoh1wp1
	unuFQeip7ehpmpPjhFWgewImA3jCgKuYneeAcdfLvj+lg9OgbpWsxqSKiNnnv9d3Ol6YlcLB4TA4w
	60Qae1vw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r9ye0-000FhU-Fi; Mon, 04 Dec 2023 02:25:12 +0000
Date: Mon, 4 Dec 2023 02:25:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Message-ID: <ZW04iGENbNm3A/Ki@casper.infradead.org>
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

On Mon, Dec 04, 2023 at 12:36:41PM +1100, NeilBrown wrote:
> +++ b/fs/namespace.c
> @@ -1328,7 +1328,7 @@ static void mntput_no_expire(struct mount *mnt)
>  
>  	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
>  		struct task_struct *task = current;
> -		if (likely(!(task->flags & PF_KTHREAD))) {
> +		if (likely((task->flags & PF_RUNS_TASK_WORK))) {

You could lose one set of parens here ...

		if (likely(task->flags & PF_RUNS_TASK_WORK)) {

>  #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
> -#define PF__HOLE__00800000	0x00800000
> +#define PF_RUNS_TASK_WORK	0x00800000	/* Will call task_work_run() periodically */

And you could lose "Will" here:

#define PF_RUNS_TASK_WORK    0x00800000      /* Calls task_work_run() periodically */

> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index 95a7e1b7f1da..aec19876e121 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -183,3 +183,4 @@ void task_work_run(void)
>  		} while (work);
>  	}
>  }
> +EXPORT_SYMBOL(task_work_run);

_GPL?

