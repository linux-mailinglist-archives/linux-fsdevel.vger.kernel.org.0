Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4D118033E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 17:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCJQ2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 12:28:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45134 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgCJQ2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:28:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGMYQ5152066;
        Tue, 10 Mar 2020 16:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=kkPMDKXLTM2iEh+aZWGKygt+GgRaqCOy3rbqrHqUm4E=;
 b=u1EDe8tfBpZdMRye89W8zqWmBkKGJpIyHrpGuFDZFHJQ0pcgR2C7QsnVOoilSnwg98yX
 Uy9DXVd/98k7+g0jd+PBqN+RtCKRtqz9exO9Gmoean7qCQfaC2SleiI4cawro7iEWQJX
 m2Qy/vh/XzT76/OOybi8YCexJxdZOcfUYLuXel4fG2Y2oTyTcHxt/4tkd22W/Civ2irx
 UV1MmN/y2QnaJoqNO7wwssdlz5FhEcsUKv8tvA1uoDOst6IgyXBt/1vE1TS3Zsn0dJXU
 21G8S1F2xQ6AamR6HtwZr1JNnnyKu0MY6+XekVD5KML4/nIXLpdeXtEqvnz8mInwmNHG SA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ym31uep2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 16:28:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGBWH4025707;
        Tue, 10 Mar 2020 16:28:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2yp8rju8k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 16:28:00 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AGRxcK027962;
        Tue, 10 Mar 2020 16:27:59 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 09:27:59 -0700
Date:   Tue, 10 Mar 2020 09:27:58 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs/direct-io.c: avoid workqueue allocation race
Message-ID: <20200310162758.GJ8036@magnolia>
References: <CACT4Y+Zt+fjBwJk-TcsccohBgxRNs37Hb4m6ZkZGy7u5P2+aaA@mail.gmail.com>
 <20200308055221.1088089-1-ebiggers@kernel.org>
 <20200308231253.GN10776@dread.disaster.area>
 <20200309012424.GB371527@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309012424.GB371527@sol.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100102
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 08, 2020 at 06:24:24PM -0700, Eric Biggers wrote:
> On Mon, Mar 09, 2020 at 10:12:53AM +1100, Dave Chinner wrote:
> > On Sat, Mar 07, 2020 at 09:52:21PM -0800, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > When a thread loses the workqueue allocation race in
> > > sb_init_dio_done_wq(), lockdep reports that the call to
> > > destroy_workqueue() can deadlock waiting for work to complete.  This is
> > > a false positive since the workqueue is empty.  But we shouldn't simply
> > > skip the lockdep check for empty workqueues for everyone.
> > 
> > Why not? If the wq is empty, it can't deadlock, so this is a problem
> > with the workqueue lockdep annotations, not a problem with code that
> > is destroying an empty workqueue.
> 
> Skipping the lockdep check when flushing an empty workqueue would reduce the
> ability of lockdep to detect deadlocks when flushing that workqueue.  I.e., it
> could cause lots of false negatives, since there are many cases where workqueues
> are *usually* empty when flushed/destroyed but it's still possible that they are
> nonempty.
> 
> > 
> > > Just avoid this issue by using a mutex to serialize the workqueue
> > > allocation.  We still keep the preliminary check for ->s_dio_done_wq, so
> > > this doesn't affect direct I/O performance.
> > > 
> > > Also fix the preliminary check for ->s_dio_done_wq to use READ_ONCE(),
> > > since it's a data race.  (That part wasn't actually found by syzbot yet,
> > > but it could be detected by KCSAN in the future.)
> > > 
> > > Note: the lockdep false positive could alternatively be fixed by
> > > introducing a new function like "destroy_unused_workqueue()" to the
> > > workqueue API as previously suggested.  But I think it makes sense to
> > > avoid the double allocation anyway.
> > 
> > Fix the infrastructure, don't work around it be placing constraints
> > on how the callers can use the infrastructure to work around
> > problems internal to the infrastructure.
> 
> Well, it's also preferable not to make our debugging tools less effective to
> support people doing weird things that they shouldn't really be doing anyway.
> 
> (BTW, we need READ_ONCE() on ->sb_init_dio_done_wq anyway to properly annotate
> the data race.  That could be split into a separate patch though.)
> 
> Another idea that came up is to make each workqueue_struct track whether work
> has been queued on it or not yet, and make flush_workqueue() skip the lockdep
> check if the workqueue has always been empty.  (That could still cause lockdep
> false negatives, but not as many as if we checked if the workqueue is
> *currently* empty.)  Would you prefer that solution?  Adding more overhead to
> workqueues would be undesirable though, so I think it would have to be
> conditional on CONFIG_LOCKDEP, like (untested):

I can't speak for Dave, but if the problem here really is that lockdep's
modelling of flush_workqueue()'s behavior could be improved to eliminate
false reports, then this seems reasonable to me...

--D

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 301db4406bc37..72222c09bcaeb 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -263,6 +263,7 @@ struct workqueue_struct {
>  	char			*lock_name;
>  	struct lock_class_key	key;
>  	struct lockdep_map	lockdep_map;
> +	bool			used;
>  #endif
>  	char			name[WQ_NAME_LEN]; /* I: workqueue name */
>  
> @@ -1404,6 +1405,9 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
>  	lockdep_assert_irqs_disabled();
>  
>  	debug_work_activate(work);
> +#ifdef CONFIG_LOCKDEP
> +	WRITE_ONCE(wq->used, true);
> +#endif
>  
>  	/* if draining, only works from the same workqueue are allowed */
>  	if (unlikely(wq->flags & __WQ_DRAINING) &&
> @@ -2772,8 +2776,12 @@ void flush_workqueue(struct workqueue_struct *wq)
>  	if (WARN_ON(!wq_online))
>  		return;
>  
> -	lock_map_acquire(&wq->lockdep_map);
> -	lock_map_release(&wq->lockdep_map);
> +#ifdef CONFIG_LOCKDEP
> +	if (READ_ONCE(wq->used)) {
> +		lock_map_acquire(&wq->lockdep_map);
> +		lock_map_release(&wq->lockdep_map);
> +	}
> +#endif
>  
>  	mutex_lock(&wq->mutex);
