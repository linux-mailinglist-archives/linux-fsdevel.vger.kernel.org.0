Return-Path: <linux-fsdevel+bounces-70528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FEAC9D812
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 02:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0AAB434AD10
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 01:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A13C221265;
	Wed,  3 Dec 2025 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="e1kkBpM0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384422116F4
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764725672; cv=none; b=iECjIbO5s72zWVF5FNc75ATMkgljC8Z30CiVjT+3I5up/nbFywuRuBQBDJzxctFlvk90cOWwgWsdpJXcW+4RWbxW6kPkjtfC0x6S2VzEMJ+CXuBQ58RHrAv6lzXntylFYhTwwYAgSnrDg7TrIOu7Bfu0IqdcsEp09cVL363nZ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764725672; c=relaxed/simple;
	bh=4l4HRrZv/pHNFBVBY/w7Hka3R8B+2aGGj/MUOdFhS8M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSaMP5Aw6WsvY3H0oPw7zeXMm62xsz1DeGxuBmLbhGytxwRNpZGrFGQML20jI66ou8HJ30j69jHm6jgFLZaaz7aCRem9celCjVotIYYpk2JhN5w5g+NnV8mc93KqL5pEcTJhRmcNoRpo9cy2vC7w+KdokcTho520EUG79IqTtTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=e1kkBpM0; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1aGyEnui9o3Fstmdwdvy6jnUj0Lc6/D9At/KYnsCRZM=;
	b=e1kkBpM082lalfxP1NPJkmuNCrrd6P4W6VLYNsuYjNxyE7LnO493by+L5B9+yrhpoAgBNt5ei
	5reWfX/jZxeeRPN5Og4T4Yr52eXIPN6xs3rPv/Z1rdZji22YNiX+MlBnahi7/hbyWDG0SFaBRD9
	HDyGWGd97x0sSFlq4BeXYUo=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dLg9J51vqznTVP;
	Wed,  3 Dec 2025 09:32:04 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 660DF1A016C;
	Wed,  3 Dec 2025 09:34:26 +0800 (CST)
Received: from kwepemn100013.china.huawei.com (7.202.194.116) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Dec 2025 09:34:26 +0800
Received: from localhost (10.50.85.155) by kwepemn100013.china.huawei.com
 (7.202.194.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 3 Dec
 2025 09:34:25 +0800
Date: Wed, 3 Dec 2025 09:31:48 +0800
From: Long Li <leo.lilong@huawei.com>
To: Bernd Schubert <bernd@bsbernd.com>, <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <bschubert@ddn.com>,
	<yangerkun@huawei.com>, <lonuxli.64@gmail.com>
Subject: Re: [PATCH] fuse: limit debug log output during ring teardown
Message-ID: <aS-SpUnw4AVCLrSS@localhost.localdomain>
References: <20251129110653.1881984-1-leo.lilong@huawei.com>
 <71e2ccaa-325b-4dd4-b5b7-fd470924c104@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <71e2ccaa-325b-4dd4-b5b7-fd470924c104@bsbernd.com>
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100013.china.huawei.com (7.202.194.116)

On Tue, Dec 02, 2025 at 06:40:10PM +0100, Bernd Schubert wrote:
> Hi Long,
> 
> On 11/29/25 12:06, Long Li wrote:
> > Currently, if there are pending entries in the queue after the teardown
> > timeout, the system keeps printing entry state information at very short
> > intervals (FUSE_URING_TEARDOWN_INTERVAL). This can flood the system logs.
> > Additionally, ring->stop_debug_log is set but not used.
> > 
> > Use ring->stop_debug_log as a control flag to only print entry state
> > information once after teardown timeout, preventing excessive debug
> > output. Also add a final message when all queues have stopped.
> > 
> > Signed-off-by: Long Li <leo.lilong@huawei.com>
> > ---
> >  fs/fuse/dev_uring.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 5ceb217ced1b..d71ccdf78887 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -453,13 +453,15 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
> >  	 * If there are still queue references left
> >  	 */
> >  	if (atomic_read(&ring->queue_refs) > 0) {
> > -		if (time_after(jiffies,
> > +		if (!ring->stop_debug_log && time_after(jiffies,
> >  			       ring->teardown_time + FUSE_URING_TEARDOWN_TIMEOUT))
> >  			fuse_uring_log_ent_state(ring);
> >  
> >  		schedule_delayed_work(&ring->async_teardown_work,
> >  				      FUSE_URING_TEARDOWN_INTERVAL);
> >  	} else {
> > +		if (ring->stop_debug_log)
> > +			pr_info("All queues in the ring=%p have stopped\n", ring);
> >  		wake_up_all(&ring->stop_waitq);
> >  	}
> >  }
> 
> 
> how about like this?
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index f6b12aebb8bb..a527e58b404a 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -452,9 +452,11 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
>          * If there are still queue references left
>          */
>         if (atomic_read(&ring->queue_refs) > 0) {
> -               if (time_after(jiffies,
> -                              ring->teardown_time + FUSE_URING_TEARDOWN_TIMEOUT))
> +               if (time_after(jiffies, ring->teardown_time +
> +                                       FUSE_URING_TEARDOWN_TIMEOUT)) {
>                         fuse_uring_log_ent_state(ring);
> +                       ring->teardown_time = jiffies;
> +               }
>  
>                 schedule_delayed_work(&ring->async_teardown_work,
>                                       FUSE_URING_TEARDOWN_INTERVAL);
> 
> Most of it is formatting, it just updates  "ring->teardown_time = jiffies",
> idea is that is logs the remaining entries. If you run into it there is
> probably a bug - io-uring will also start to spill warnings.
> 
> 
> Thanks,
> Bernd
> 

Hi, Bernd

Thanks for your reply, if we want to continuously log entries that have
not been stopped, the change to update teardown_time looks good to me,
and ring->stop_debug_log can be deleted if it is not used.

Long Li
Thanks


