Return-Path: <linux-fsdevel+bounces-25810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B80950B11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 19:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A29284D0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 17:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA619770E9;
	Tue, 13 Aug 2024 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="sHxqH/+Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="af931bQD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56C1F959
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568661; cv=none; b=acmYa/jggbzONaqcA7GPeLX/7XdiEL02Fjsp1j/riwckEvNNpa6pq3p5ZwzsdZRWZVrIz+aqxVjA8yydqVfN4CmCUHfHOyp+AP/KA/pXGAQO5CkOLaqZ4ougZvFMdZNaShIC9yY3UXfn2jOXeH3raZglgJWeH0P5VBCl+cQcXSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568661; c=relaxed/simple;
	bh=mh9cq+BTHxtwHvOvNp55c52I37CAWSacDJnzXMdKMBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HqHWmiB3iNQGdLqvleKngpZUYIfQMJNwrw/hMWti1eNO7iOQHdPMPEMoWu9mEc26bmT+qALhdZkyLYLR9/hFMPajDmJdshVWT7jXjmxcnJ/YXPUldKClcMZysLv2NbGeyTnLeWBBKCObkP4NHQB390TYV1RnDJsfOFzPeN9K0KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=sHxqH/+Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=af931bQD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0F90F1148181;
	Tue, 13 Aug 2024 13:04:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Aug 2024 13:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723568658;
	 x=1723655058; bh=RyqfcHw+cLHjYtX1wcvyhLGMYAjknbe4eVvrQUYiGa8=; b=
	sHxqH/+Y9mTxyWUUOOpI/ml0hPe0iEWK050v1juMlG9iGclLmozHA8pvU9Q4HeTd
	2TRxcltyGME7/mx81+YtxAn/Zy8eelRSyMAqpCkpBk0cocHpxr1/mOl/bIZr6xr/
	RxUpPsapaWIRdYFaM/Em/Paqnfa85aTVpj4caqHWMBfXTf/6u3YYK5x/BTzZWstR
	i+hrMMMqgs0TYuYtten3S6cIo7lRJ597pW0XxHbZ3zk/7lJ4qNm1+9IQJ2/eKstn
	ofOLB3Fwa3X5fuMJH8gc3Yi9UmgoraYUdBvaW73LaBtyUwLEN7BD6UFZ5GixiuVl
	gGl3Wwg13XXTvvelH3ckmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723568658; x=
	1723655058; bh=RyqfcHw+cLHjYtX1wcvyhLGMYAjknbe4eVvrQUYiGa8=; b=a
	f931bQD/R1eGJm8fPlwB8LSU95MQ7kveTKWxnbZrrIIn9ZjVW7/4OgqL0oZ/vqFW
	JSwAtPTRfpS6OXp59rp3Pai3aszc44rsLanS2dpdVxVYDsA3M+o6pqxBm22s4Uio
	cLQ6w4SoQHemOvKGLGlcdvObBNj4jPxrDlETSctOqxGMwuZj2wQzfrt6xERdz/XP
	pJg+obTcps3gAf6ut8C3j7ReB6ync+mUObTXcQ32k5T/c9e0y+qHTLSa8OVjM8ae
	Z3QriDJt7zYQ4nFuzXMUBRq5cx7KWhJTatFbH/eAnV6lGNRZLUBgq1ZIoWPNu7VX
	DL4OUBIRnFoEKbtFSa6UQ==
X-ME-Sender: <xms:EZK7ZnWYtsCBy1EcTtB5jE2q5hvGsQ_uTqIcvUBu12ekMlsdHLpqWA>
    <xme:EZK7ZvkjimRZ-WFXdvR77IXoUjye_LyfW-_EphQP21Alb4aXaPnorQ1cx4TjxYFKv
    brQW-8iKDSDMwNi>
X-ME-Received: <xmr:EZK7ZjZfD_o6pZMpr_8fatrsXdD__yFFPQ9ARKs5M1_sdF7x5y5HMacs-xVw06GhO3wx4fXok6NhMRbMEDZtHfS12RMuT_ieGax6w4rtvya2jviT9y2tXh7L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhho
    shgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtohepjhgvfhhflhgvgihuse
    hlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoheplhgrohgrrhdrshhhrgho
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrd
    gtohhm
X-ME-Proxy: <xmx:EZK7ZiV6wSZpC1kJT9vtDDZQvLcefgzOl6nnRM2sE2AzxKSQ0ZzSOw>
    <xmx:EZK7ZhkEfkDCXBgfw6Lv4jkaPZ-KvOwd9f3Bc3QPcONd4nLLq0JHnw>
    <xmx:EZK7ZvfQSKNBRLhMy_Fkj2msgYobUGuYhTb0IFluHBiRqVKE4wwxIw>
    <xmx:EZK7ZrF0EDrmxnndAHGnPzhOocQ21VWqzJx22Rok8twtBfUxcczR3w>
    <xmx:EpK7ZnWemDp5Rk666DJE6MeSdwrl02LJT3NolRmAvjMAOt487EnmOCZo>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 13:04:15 -0400 (EDT)
Message-ID: <3754bc57-a887-4ac1-86cd-7858bacdb595@fastmail.fm>
Date: Tue, 13 Aug 2024 19:04:14 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] fuse: add optional kernel-enforced timeout for
 requests
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, jefflexu@linux.alibaba.com, laoar.shao@gmail.com,
 kernel-team@meta.com
References: <20240808190110.3188039-1-joannelkoong@gmail.com>
 <20240808190110.3188039-2-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, fr, ru
In-Reply-To: <20240808190110.3188039-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/8/24 21:01, Joanne Koong wrote:

> @@ -1951,9 +2115,10 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
>  		goto copy_finish;
>  	}
>  
> +	__fuse_get_request(req);
> +
>  	/* Is it an interrupt reply ID? */
>  	if (oh.unique & FUSE_INT_REQ_BIT) {
> -		__fuse_get_request(req);
>  		spin_unlock(&fpq->lock);
>  
>  		err = 0;
> @@ -1969,6 +2134,13 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
>  		goto copy_finish;
>  	}
>  
> +	if (test_and_set_bit(FR_FINISHING, &req->flags)) {
> +		/* timeout handler is already finishing the request */
> +		spin_unlock(&fpq->lock);
> +		fuse_put_request(req);
> +		goto copy_finish;
> +	}
> +

It should be safe already with the FR_FINISHING flag and
timer_delete_sync, but maybe we could unset req->fpq here to make that
easier to read and to be double sure?

>  	clear_bit(FR_SENT, &req->flags);
>  	list_move(&req->list, &fpq->io);
>  	req->out.h = oh;
> @@ -1995,6 +2167,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
>  	spin_unlock(&fpq->lock);
>  
>  	fuse_request_end(req);
> +	fuse_put_request(req);
>  out:
>  	return err ? err : nbytes;
>  
> @@ -2260,13 +2433,21 @@ int fuse_dev_release(struct inode *inode, struct file *file)
>  	if (fud) {
>  		struct fuse_conn *fc = fud->fc;
>  		struct fuse_pqueue *fpq = &fud->pq;
> +		struct fuse_req *req;
>  		LIST_HEAD(to_end);
>  		unsigned int i;
>  
>  		spin_lock(&fpq->lock);
>  		WARN_ON(!list_empty(&fpq->io));
> -		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
> +		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
> +			/*
> +			 * Set the req error here so that the timeout
> +			 * handler knows it's being released
> +			 */
> +			list_for_each_entry(req, &fpq->processing[i], list)
> +				req->out.h.error = -ECONNABORTED;
>  			list_splice_init(&fpq->processing[i], &to_end);
> +		}
>  		spin_unlock(&fpq->lock);
>  
>  		end_requests(&to_end);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index f23919610313..2b616c5977b4 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -375,6 +375,8 @@ struct fuse_io_priv {
>   * FR_FINISHED:		request is finished
>   * FR_PRIVATE:		request is on private list
>   * FR_ASYNC:		request is asynchronous
> + * FR_FINISHING:	request is being finished, by either the timeout handler
> + *			or the reply handler
>   */
>  enum fuse_req_flag {
>  	FR_ISREPLY,
> @@ -389,6 +391,7 @@ enum fuse_req_flag {
>  	FR_FINISHED,
>  	FR_PRIVATE,
>  	FR_ASYNC,
> +	FR_FINISHING,
>  };
>  
>  /**
> @@ -435,6 +438,12 @@ struct fuse_req {
>  
>  	/** fuse_mount this request belongs to */
>  	struct fuse_mount *fm;
> +
> +	/** page queue this request has been added to */
> +	struct fuse_pqueue *fpq;

Processing queue?


Thanks,
Bernd

