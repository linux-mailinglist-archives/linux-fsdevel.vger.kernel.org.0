Return-Path: <linux-fsdevel+bounces-78338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOXRGGBrnmnnVAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 04:24:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F081912E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 04:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D4723019810
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 03:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6323829D269;
	Wed, 25 Feb 2026 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="Ka5Zl0mJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frYPuyTI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDAF2AE68;
	Wed, 25 Feb 2026 03:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771989850; cv=none; b=MwrjIChz6Jt3UY0ictB2gdBIDYxpf6k7X2BbF0mLg4ozgHQS4Gio4bU+ZpDLlFF29AKloGL76ujXRBMv8i+pr2VX9ehY7zHCv37NIOlrbPfFL1FNwVn9pLx4CESDEN/fP10jTqilV+YS4I//b9QVucinpk1TYw1LlJAquFjcUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771989850; c=relaxed/simple;
	bh=WGaEFzfXZuOpGzkXsU1Y4omQOe0M8Hno62+cyTlPuLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THqDHuQ05rKaWBLgf6xvcOeZT8Yqc/A9n/mhVjV9m8PHbaHPDKrBNfW+mGDvqoUjQD43KPAffHex9nIP7H9an2QdCgoKu19EM7ZlWEhRAn0Piv1mCfyiHDJMxMRZaQ/rf0KDzDairicyFzaGUvGzRw4Ww1fTMlxqNzh+8sJdSI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=Ka5Zl0mJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frYPuyTI; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 1983A1300BEA;
	Tue, 24 Feb 2026 22:24:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 22:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771989847;
	 x=1771997047; bh=HCzwN4xs7OxChb68c/BARx4usYTME8XX+k7qfzYYpHA=; b=
	Ka5Zl0mJOY9Set8jfOIOnU2PYjTpuKTUWHUdo6gvj+np831Y3R6PNyZNX1gZ+TfT
	CwT9bRJuOB/CJXkc9tvhTLhcerQrp0ejOT8zlE6BT5HPGr5MocJA1hlL1DnpiIsS
	UsJ3jVc4lg+jswktfiqZVJL6Xht81VJ1VJnTqcLgQfgBx+zSgboOwv44lD0KQF7/
	YtxKKMjp8jAoe+Tb7+UUJtthAHSuO+Zfko7kRzbyqpvqx8wfOss51+CvuRbUjKw4
	v7GOnNMw/0DtDtIP8a6tHHAezmFLfUPtZHSWDsc5q5gg1poG5CDIal6RrJ1CRHEi
	92YIv6SvWcqp/Ypiw/YgGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771989847; x=
	1771997047; bh=HCzwN4xs7OxChb68c/BARx4usYTME8XX+k7qfzYYpHA=; b=f
	rYPuyTI+tcmhlK/72w9WY5d/eVMZt9ihX2+UgoePWPLnvGCOFHqCCi8oaCeqIeWz
	vnDmDsCUCUxkW2eujsaio+CSYyewydpXR0tyypM7CKGIgYvPSdUaD+yXa4PNVEWY
	KwGHssOoVgMBbiJJruxISg4QBWAtyj3Pfi497W6TLvNQx/A65gOe1paB/aItHcSx
	Ssqt8TKnBtiDNA9vYa7TjpMjaT5uti4YXh2PAF6GI3QMpsOOWR8QRdhm4tG/Yb5A
	QRVmGw7qCTm8x7jWfG3FRTUzECvW3vJToe9RsTjEEpXD8sCR/1I7eXqr5mZpW7Xm
	E7DRYRt3ypT09dVpZA/Qw==
X-ME-Sender: <xms:V2ueaQYzamqVBNdEINL-ejCJIx3-5JL34T2QBcBZ3ahVlme_f0zh4w>
    <xme:V2ueac5HOHwPZr0m593BeVqi4NGbyxj43Vjt9FAi4SnDG5Y74JmmwzPf0ZJ79oyMF
    bJjejlg-_0muvrfwbipSMyyKvXoZQSZwxNuM-xVeji5DM5fTDDN>
X-ME-Received: <xmr:V2ueabBjd39WyQu7SgSZrXPum4bHVHnzltyLrogRPkz7MLvQbakTD1-m5hGMWx-G32A->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeduleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeihthhohhhnuhhkihesrghmrgiiohhnrdgtohhmpd
    hrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopegsshgt
    hhhusggvrhhtseguughnrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:V2ueaafroROgkaMok0emXdqYJJneWx4tmNVc5ddbPR21LJxzLKBXLA>
    <xmx:V2ueaSKo1jskzaN0eeio-ARnIK_hwCJiet8OtcXa-42n0l1ejhr9QA>
    <xmx:V2uead1jPchkRv2YXBIYOznHcLfJmTlLlBJ_4DYoO4FQl966cQdaxg>
    <xmx:V2ueachtW2j09XGsJabM5ZzRT0Uf2eT0KEeRCp3DCFpGAcXCdbOyEQ>
    <xmx:V2ueaQXLxgHKOi9jLCwCJon2UKTBbUk4NXuwRdiAWJtepkkmBXzz_BB3>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 22:24:05 -0500 (EST)
Message-ID: <deb6002f-2784-46e6-8bac-15dbd9d2dc67@bsbernd.com>
Date: Wed, 25 Feb 2026 04:24:01 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: refactor duplicate queue teardown operation
To: Yuto Ohnuki <ytohnuki@amazon.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260223140332.36618-2-ytohnuki@amazon.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260223140332.36618-2-ytohnuki@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-78338-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,bsbernd.com:mid,bsbernd.com:dkim,bsbernd.com:email]
X-Rspamd-Queue-Id: 06F081912E3
X-Rspamd-Action: no action



On 2/23/26 15:03, Yuto Ohnuki wrote:
> Extract common queue iteration and teardown logic into
> fuse_uring_teardown_all_queues() helper function to eliminate code
> duplication between fuse_uring_async_stop_queues() and
> fuse_uring_stop_queues().
> 
> This is a pure refactoring with no functional changes, intended to
> improve maintainability.
> 
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
> ---
>  fs/fuse/dev_uring.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 3a38b61aac26..7b9822e8837b 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -397,6 +397,20 @@ static void fuse_uring_teardown_entries(struct fuse_ring_queue *queue)
>  				     FRRS_AVAILABLE);
>  }
>  
> +static void fuse_uring_teardown_all_queues(struct fuse_ring *ring)
> +{
> +	int qid;
> +
> +	for (qid = 0; qid < ring->nr_queues; qid++) {
> +		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
> +
> +		if (!queue)
> +			continue;
> +
> +		fuse_uring_teardown_entries(queue);
> +	}
> +}
> +
>  /*
>   * Log state debug info
>   */
> @@ -431,19 +445,10 @@ static void fuse_uring_log_ent_state(struct fuse_ring *ring)
>  
>  static void fuse_uring_async_stop_queues(struct work_struct *work)
>  {
> -	int qid;
>  	struct fuse_ring *ring =
>  		container_of(work, struct fuse_ring, async_teardown_work.work);
>  
> -	/* XXX code dup */
> -	for (qid = 0; qid < ring->nr_queues; qid++) {
> -		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
> -
> -		if (!queue)
> -			continue;
> -
> -		fuse_uring_teardown_entries(queue);
> -	}
> +	fuse_uring_teardown_all_queues(ring);
>  
>  	/*
>  	 * Some ring entries might be in the middle of IO operations,
> @@ -469,16 +474,7 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
>   */
>  void fuse_uring_stop_queues(struct fuse_ring *ring)
>  {
> -	int qid;
> -
> -	for (qid = 0; qid < ring->nr_queues; qid++) {
> -		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
> -
> -		if (!queue)
> -			continue;
> -
> -		fuse_uring_teardown_entries(queue);
> -	}
> +	fuse_uring_teardown_all_queues(ring);
>  
>  	if (atomic_read(&ring->queue_refs) > 0) {
>  		ring->teardown_time = jiffies;

Thank you! Looks good to me.

Reviewed-by: Bernd Schubert <bernd@bsbernd.com>

