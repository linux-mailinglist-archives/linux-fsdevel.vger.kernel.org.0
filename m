Return-Path: <linux-fsdevel+bounces-70997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 239BCCAE9CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 02:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08BC8301CE47
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 01:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB302750ED;
	Tue,  9 Dec 2025 01:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="JOBTs1wK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4918F4A
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 01:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765243492; cv=none; b=W67w57DyOWyX3/P+aXhfDVm9j6Qb39FNsqGqh4VaTkzTf/ue9gU2vd3RRj7bs6IftyB38+2edxVrRWvPMjDLu2+qcxdYq8GRrTnPGm6sV4B0i41dAFoH/s9VUSTr08RyRVhNG8C77Cofzy+BTym1NIQJl3vQWJcJgu2dnbRdiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765243492; c=relaxed/simple;
	bh=TgE5UcLzP0h0Cq5g8mY40FY1HHFqEuK9iZ0SAX5lb+4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuYZ4MVWkNdfamIQ2hotagqa3sFj6JIFPPXdDYG/IiT1TNKhTV+p8yDYQ24il0JOI8RWRLiyj/VUC7jt+kkq2PdHDu5PezPyNwkJojijDEWov8kd5GDiZL+UN7NXcSpWYQYLHE1Q3s7BjqADymih4HxrWtTzwwzCIPU+qYYjYPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=JOBTs1wK; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+85qu9oEnwpQbG8npTSBnWjUFRyFRQEeOOWH+z73dTo=;
	b=JOBTs1wKPQflmWC0WNzIJ9kG7bcQRzqL1iYHMdvSGKrGJUpf+BTYUZpsY6YwtXpDvkL1oTCAh
	x01niIovkDxjkSVyGyrqyya9s+qtHEbzJjclOccaisxeIfDLFwHBjyLlX7NQXfz+18VMNXgyS3G
	UTA5xHYrRszyqNXhBso3Si8=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dQLgQ57QyznTVd;
	Tue,  9 Dec 2025 09:22:26 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id F00A21402CA;
	Tue,  9 Dec 2025 09:24:44 +0800 (CST)
Received: from kwepemn100013.china.huawei.com (7.202.194.116) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Dec 2025 09:24:35 +0800
Received: from localhost (10.50.85.155) by kwepemn100013.china.huawei.com
 (7.202.194.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 9 Dec
 2025 09:24:35 +0800
Date: Tue, 9 Dec 2025 09:21:37 +0800
From: Long Li <leo.lilong@huawei.com>
To: Bernd Schubert <bernd@bsbernd.com>, <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <bschubert@ddn.com>,
	<yangerkun@huawei.com>, <lonuxli.64@gmail.com>
Subject: Re: [PATCH v2] fuse: limit debug log output during ring teardown
Message-ID: <aTd5oXkKL8oP1CEw@localhost.localdomain>
References: <20251204023219.1249542-1-leo.lilong@huawei.com>
 <c486d34f-8b41-4a5e-84eb-dd37b0a63703@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <c486d34f-8b41-4a5e-84eb-dd37b0a63703@bsbernd.com>
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100013.china.huawei.com (7.202.194.116)

On Mon, Dec 08, 2025 at 11:50:11PM +0100, Bernd Schubert wrote:
> 
> 
> On 12/4/25 03:32, Long Li wrote:
> > Currently, if there are pending entries in the queue after the teardown
> > timeout, the system keeps printing entry state information at very short
> > intervals (FUSE_URING_TEARDOWN_INTERVAL). This can flood the system logs.
> > Additionally, ring->stop_debug_log is set but not used.
> > 
> > Clean up unused ring->stop_debug_log, update teardown time after each
> > log entry state, and change the log entry state interval to
> > FUSE_URING_TEARDOWN_TIMEOUT.
> > 
> > Signed-off-by: Long Li <leo.lilong@huawei.com>
> > ---
> > v1->v2: Update teardown time to limit entry state output interval
> >  fs/fuse/dev_uring.c   | 7 ++++---
> >  fs/fuse/dev_uring_i.h | 5 -----
> >  2 files changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 5ceb217ced1b..68d2fbdc3a7c 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -426,7 +426,6 @@ static void fuse_uring_log_ent_state(struct fuse_ring *ring)
> >  		}
> >  		spin_unlock(&queue->lock);
> >  	}
> > -	ring->stop_debug_log = 1;
> >  }
> >  
> >  static void fuse_uring_async_stop_queues(struct work_struct *work)
> > @@ -453,9 +452,11 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
> >  	 * If there are still queue references left
> >  	 */
> >  	if (atomic_read(&ring->queue_refs) > 0) {
> > -		if (time_after(jiffies,
> > -			       ring->teardown_time + FUSE_URING_TEARDOWN_TIMEOUT))
> > +		if (time_after(jiffies, ring->teardown_time +
> > +					FUSE_URING_TEARDOWN_TIMEOUT)) {
> >  			fuse_uring_log_ent_state(ring);
> > +			ring->teardown_time = jiffies;
> > +		}
> >  
> >  		schedule_delayed_work(&ring->async_teardown_work,
> >  				      FUSE_URING_TEARDOWN_INTERVAL);
> > diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> > index 51a563922ce1..4cd3cbd51c7a 100644
> > --- a/fs/fuse/dev_uring_i.h
> > +++ b/fs/fuse/dev_uring_i.h
> > @@ -117,11 +117,6 @@ struct fuse_ring {
> >  
> >  	struct fuse_ring_queue **queues;
> >  
> > -	/*
> > -	 * Log ring entry states on stop when entries cannot be released
> > -	 */
> > -	unsigned int stop_debug_log : 1;
> > -
> >  	wait_queue_head_t stop_waitq;
> >  
> >  	/* async tear down */
> 
> 
> Thank you! I'm still interested in, if you get repeated warning messages.
> 

I've been testing the fuse over uring functionality recently, but I haven't
encountered many repeated warning messages in actual testing, so there's no
need to worry. :)

Thanks,
Long Li

