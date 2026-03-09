Return-Path: <linux-fsdevel+bounces-79748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCoFAi2PrmnVGAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 10:13:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE483235F7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 10:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3B423006502
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000DE376BE1;
	Mon,  9 Mar 2026 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="kV9+mhSd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5E1374E46
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773047593; cv=none; b=SdWJojWsT4oDvGscS0xdUIFNYPea4oQK3Ve86f8HjG+eAl416lvVs9NFKNAxr/Z9FwWia+jTGyRGkOkylycyAb8H43/Fqd7DS+pokEpHYEzmrbWQt+oxwQCbC4NpvIu0JI2t4IGS3oImooak6Crd6VhAVNRaRLCmtFb6MBrZBgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773047593; c=relaxed/simple;
	bh=h/eb4DT9NZpFHlxVtnNNi2YHNmYx++7KEBrpFGzUt2s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTn2gIE04v3A/7UpEbw+F+BlGKMxEruuH7T1CbuCP2bCtEMDXmGsB2cTLLIYYzHYQT1P/waBFktikcCp2uP/+e+wz287MZY0jmNC1NR5JSlPUjngNisv+NbKIoFP6oyrA2AVrqZiIijy4wG7UGNSf6A6LJ84layubqhdRwM+9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=kV9+mhSd; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ruKuGzrjmMzvhXmXrHXohoguDZvm7Lce15B1v71VoDI=;
	b=kV9+mhSdn6ek9xF5X6/iW0Z53wwgFjI21oriDjKcqW92NzkbGLyx01Hl/asncl0DYY8HGwVRi
	m4yPqdjfHMBd9/WvmTDgPS5fvt6pqHFX+uymJa+sodXOXN5hPk8ya+OPEAPEDXaelV7p7SPtkD7
	D9SzS0nsDId6Q7burOBC4+w=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fTrl16ZVzzpSty;
	Mon,  9 Mar 2026 17:07:57 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 07C7740569;
	Mon,  9 Mar 2026 17:13:06 +0800 (CST)
Received: from kwepemn100013.china.huawei.com (7.202.194.116) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Mar 2026 17:13:05 +0800
Received: from localhost (10.50.85.155) by kwepemn100013.china.huawei.com
 (7.202.194.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 9 Mar
 2026 17:13:05 +0800
Date: Mon, 9 Mar 2026 17:09:20 +0800
From: Long Li <leo.lilong@huawei.com>
To: <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <bschubert@ddn.com>,
	<yangerkun@huawei.com>, <lonuxli.64@gmail.com>
Subject: Re: [PATCH v2] fuse: limit debug log output during ring teardown
Message-ID: <aa6OQLN_XwkZzijW@localhost.localdomain>
References: <20251204023219.1249542-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20251204023219.1249542-1-leo.lilong@huawei.com>
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100013.china.huawei.com (7.202.194.116)
X-Rspamd-Queue-Id: BE483235F7A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ddn.com,huawei.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-79748-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,localhost.localdomain:mid,h-partners.com:dkim,huawei.com:email];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[h-partners.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leo.lilong@huawei.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Thu, Dec 04, 2025 at 10:32:19AM +0800, Long Li wrote:
> Currently, if there are pending entries in the queue after the teardown
> timeout, the system keeps printing entry state information at very short
> intervals (FUSE_URING_TEARDOWN_INTERVAL). This can flood the system logs.
> Additionally, ring->stop_debug_log is set but not used.
> 
> Clean up unused ring->stop_debug_log, update teardown time after each
> log entry state, and change the log entry state interval to
> FUSE_URING_TEARDOWN_TIMEOUT.
> 
> Signed-off-by: Long Li <leo.lilong@huawei.com>
> ---
> v1->v2: Update teardown time to limit entry state output interval
>  fs/fuse/dev_uring.c   | 7 ++++---
>  fs/fuse/dev_uring_i.h | 5 -----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 5ceb217ced1b..68d2fbdc3a7c 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -426,7 +426,6 @@ static void fuse_uring_log_ent_state(struct fuse_ring *ring)
>  		}
>  		spin_unlock(&queue->lock);
>  	}
> -	ring->stop_debug_log = 1;
>  }
>  
>  static void fuse_uring_async_stop_queues(struct work_struct *work)
> @@ -453,9 +452,11 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
>  	 * If there are still queue references left
>  	 */
>  	if (atomic_read(&ring->queue_refs) > 0) {
> -		if (time_after(jiffies,
> -			       ring->teardown_time + FUSE_URING_TEARDOWN_TIMEOUT))
> +		if (time_after(jiffies, ring->teardown_time +
> +					FUSE_URING_TEARDOWN_TIMEOUT)) {
>  			fuse_uring_log_ent_state(ring);
> +			ring->teardown_time = jiffies;
> +		}
>  
>  		schedule_delayed_work(&ring->async_teardown_work,
>  				      FUSE_URING_TEARDOWN_INTERVAL);
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 51a563922ce1..4cd3cbd51c7a 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -117,11 +117,6 @@ struct fuse_ring {
>  
>  	struct fuse_ring_queue **queues;
>  
> -	/*
> -	 * Log ring entry states on stop when entries cannot be released
> -	 */
> -	unsigned int stop_debug_log : 1;
> -
>  	wait_queue_head_t stop_waitq;
>  
>  	/* async tear down */
> -- 
> 2.39.2
> 

Friendly ping ...

This patch has been reviewed but not picked up, and may have been forgotten.

Best regards,
Long Li

