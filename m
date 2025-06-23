Return-Path: <linux-fsdevel+bounces-52602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F3EAE4730
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E36E16ED70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666BA261581;
	Mon, 23 Jun 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/c6gj2e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19092609ED
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689420; cv=none; b=U0dWyxK3aIpkUUsV2+O3K3Pu0xCxBc1TgPbklNpttTV53r+xr7Y1ckwQKQs+m292RibFP1bBNLmVej/Zt+rGB+NLZMt9Tw9d+Ob/5aIMkaLaUK5BMrehQo5yU47KHH5ZX/qYS3HnY5EkNJvTiRJkld85qf8EBM5xhAIDatsivh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689420; c=relaxed/simple;
	bh=TT4MoMKaB9MPS3KddIglVsq+u9PxmLhN4vh8jjCffKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxkrfNypDgFxd/pGvlCDRlQQZgt+JrHf3YZyShTf1LZHVH97Y4mMv6SPWYT4knpOqz24Y7dncXU6pxXhSbNOrrUJUjXBWJ+IYpuSgQ+AGOfV7laCnNJuaqQtdyErEjz26D6igm74KcH9zKjnQubYOXqWwS1XklkAxfPb3AM15kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/c6gj2e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750689417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FoUo8AFa374U8mDLmsqMuBlqEBkyH8ANfZ6omhJKFpo=;
	b=F/c6gj2eqDWxfotpp2n8/h4V5cmasvB0Div5VtiXlYWUs/0dToGJnUilk8yLMXyHrbd2/Q
	dxYUZSpEwHRJLgEwtvT/MCMMrWzY3poe/smd91qSdfz1cQHs0EqHy529Xq9gv1ibmuXWZ1
	2sPMx8L5P2LoMr+GQXpMAxkmYgFBq50=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-7UR_P_yuPEaNfeJvmmCHwg-1; Mon,
 23 Jun 2025 10:36:53 -0400
X-MC-Unique: 7UR_P_yuPEaNfeJvmmCHwg-1
X-Mimecast-MFC-AGG-ID: 7UR_P_yuPEaNfeJvmmCHwg_1750689412
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 112A7195608A;
	Mon, 23 Jun 2025 14:36:52 +0000 (UTC)
Received: from localhost (unknown [10.72.112.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B3CC30001A1;
	Mon, 23 Jun 2025 14:36:49 +0000 (UTC)
Date: Mon, 23 Jun 2025 22:36:45 +0800
From: Baoquan He <bhe@redhat.com>
To: Su Hui <suhui@nfschina.com>
Cc: akpm@linux-foundation.org, vgoyal@redhat.com, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/proc/vmcore: a few cleanups for vmcore_add_device_dump
Message-ID: <aFlmfdajTOP5Ik9f@MiWiFi-R3L-srv>
References: <20250623104704.3489471-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623104704.3489471-1-suhui@nfschina.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/23/25 at 06:47pm, Su Hui wrote:
> There are three cleanups for vmcore_add_device_dump(). Adjust data_size's
> type from 'size_t' to 'unsigned int' for the consistency of data->size.

It's unclear to me why size_t is not suggested here. Isn't it assigned
a 'sizeof() + data->size' in which size_t should be used?

The rest two looks good to me, thanks.

> Return -ENOMEM directly rather than goto the label to simplify the code.
> Using scoped_guard() to simplify the lock/unlock code.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  fs/proc/vmcore.c | 33 ++++++++++++++-------------------
>  1 file changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 10d01eb09c43..9ac2863c68d8 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1477,7 +1477,7 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  {
>  	struct vmcoredd_node *dump;
>  	void *buf = NULL;
> -	size_t data_size;
> +	unsigned int data_size;
>  	int ret;
>  
>  	if (vmcoredd_disabled) {
> @@ -1490,10 +1490,8 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  		return -EINVAL;
>  
>  	dump = vzalloc(sizeof(*dump));
> -	if (!dump) {
> -		ret = -ENOMEM;
> -		goto out_err;
> -	}
> +	if (!dump)
> +		return -ENOMEM;
>  
>  	/* Keep size of the buffer page aligned so that it can be mmaped */
>  	data_size = roundup(sizeof(struct vmcoredd_header) + data->size,
> @@ -1519,21 +1517,18 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	dump->size = data_size;
>  
>  	/* Add the dump to driver sysfs list and update the elfcore hdr */
> -	mutex_lock(&vmcore_mutex);
> -	if (vmcore_opened)
> -		pr_warn_once("Unexpected adding of device dump\n");
> -	if (vmcore_open) {
> -		ret = -EBUSY;
> -		goto unlock;
> -	}
> -
> -	list_add_tail(&dump->list, &vmcoredd_list);
> -	vmcoredd_update_size(data_size);
> -	mutex_unlock(&vmcore_mutex);
> -	return 0;
> +	scoped_guard(mutex, &vmcore_mutex) {
> +		if (vmcore_opened)
> +			pr_warn_once("Unexpected adding of device dump\n");
> +		if (vmcore_open) {
> +			ret = -EBUSY;
> +			goto out_err;
> +		}
>  
> -unlock:
> -	mutex_unlock(&vmcore_mutex);
> +		list_add_tail(&dump->list, &vmcoredd_list);
> +		vmcoredd_update_size(data_size);
> +		return 0;
> +	}
>  
>  out_err:
>  	vfree(buf);
> -- 
> 2.30.2
> 


