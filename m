Return-Path: <linux-fsdevel+bounces-55457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0224B0AA08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 20:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC15D17BC13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062CF2E7F06;
	Fri, 18 Jul 2025 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="wAem9llr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j9JeDdF5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E11915D1
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752862425; cv=none; b=uSbeVUCPQv3a2QZ/RT6EseIX3Y3J/Jr7SY3ZyV3W65T0OS//xE8uRUzEDkwmQR+XWolgvzxlB70xLIGdtgrAOLsFX3fojyDsMpi4ABFy4MCfeMufNy3HfDqJXAaoeo9srJMnST7YV5yy58NFzc3NFskSYXu5ab1C3nO7ZHRCC6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752862425; c=relaxed/simple;
	bh=agHDwEgrnEbftTSeCux74paEeYRoG+BBWPgtOE2Xn2w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=b00ByH1/O4WlCjeOqorCOSZvFFcO5EP+lYlHBiBpzob+1yhZssKockGpXNubq8WwBa/pIToe5UgzUjRXBNsjNUKaB6Ad90GxSskZ6NNfgx44P4yt9pN+OtHsdNyKRNVFhoOJJNuOwFlTjkPY/8H9K+A2LPLJjHA+9s4bL15LEVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=wAem9llr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j9JeDdF5; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5935914000B0;
	Fri, 18 Jul 2025 14:13:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 18 Jul 2025 14:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752862421;
	 x=1752948821; bh=7NGqIFOzA4jdfN4xsUz+72qPeK4J2og0DGu/R/0V8Ck=; b=
	wAem9llrOx2kCI3Sm59UXWKsf2rKuDEmNXKoIFlddNYFEZLnAW3uwgP9th5LHnHb
	s7kwgPePtkKQPgzG8GuFXfTfQKOTeZUKKEIbKNCuLxBtMeTStI4K6LNADQXZiBDA
	+xQu1ttnZxqKsNFI3TwIkL4/f8KdSy81STIhx+MDfs/JCyeu3T7ei203mb0tsaHz
	kL1lHMd2ygFkVAHZ0S7KCTwEb53+4X6KNoBNiw5yHITHtxKQknZgpRXFQrd58svn
	EwpQ4sj85pOVcUeFYJtJFjhMXua7vUndhC4/w++1uJaIxFTSPdWJ0V6ZoZVpGtxw
	+Eb8d7N+YEdvRwvzurueuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752862421; x=
	1752948821; bh=7NGqIFOzA4jdfN4xsUz+72qPeK4J2og0DGu/R/0V8Ck=; b=j
	9JeDdF55+8dROwGy0Y/sfsbnGn7a7hHdpjcv0nmY0dVRul9MP/hwHJAOLBB1NFB7
	CHqVlUd92Rkw6SuUnOqaNge3DvkucLzB6TNcaAIEnfB2Ba5vEEXVNaTI7t7d2ZoX
	c1vmTQOTGDLKf75snMN2GyuVMHJgvIrO9uxMoGiymJBjPGfdTg/xqbkmNWjSKOSW
	JcoD+OzDPafKnNXlCUhkqhRy3ONaBK269HJiVSgmI3mXnBg9PBGZ24iGMXB+NLU8
	gYfnmCpVydV8q4zIikvoWj0Ow5fGJ29Rq3jXrU1w/60gUsd6kz/knB98aUcsmb43
	zYZnqWAROou++9Qf4yqVA==
X-ME-Sender: <xms:1Y56aHVDN4K5X3_0ESenVA_b8_VqMPgF97n9R1LjgQQuwZIoAa5L2w>
    <xme:1Y56aNKyQqnQMOVCAu-QkoGmOiYF-CDupDYZgYGTx_PovYpikS-0aaIUMqjSsYSU2
    5SlkYio_NdWR_cz>
X-ME-Received: <xmr:1Y56aJ09VoIFM-68wVgSOBaN3Bd3W0z1Z_mfnO5KExswa23fHbMZ177rl_CrkNLQilCYqtZidcNFin46r7UvvbD9OevgD63V8zonV-aqL_M4j_hmX8Fv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigeduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuhffvvehfjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepleelgeduudeuffduvdetgeffheduueeiffeltdduheekheffgeetgeefheev
    tdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepjhhohhhnsehgrh
    hovhgvshdrnhgvthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhr
    tghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    ephhgsihhrthhhvghlmhgvrhesuggunhdrtghomh
X-ME-Proxy: <xmx:1Y56aD4ehDT2YFexbL7cOQkQI-ickjtuXI6SU0jmxbUmDU1cvbuTfw>
    <xmx:1Y56aC_04Qa0FYjtS3CYLWhqfmeSeYJDOg70jBJp25gMBheAEWKm3A>
    <xmx:1Y56aKWNxUDcvFkDbJWOv5BAtB7W6G2YF3xjylGChMNSG88NoUns5w>
    <xmx:1Y56aFqI5EnslPtInHFyTdO9jxFsTEXh35-h92Y0mzKR1fs7vRokVw>
    <xmx:1Y56aKs0Ms5EwIxaX8th0hMWozOOVL0BHhXdLfWZDO6hd84MdXn483Z_>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 14:13:40 -0400 (EDT)
Message-ID: <40110b4b-f317-4a36-b00b-798c023a4014@bsbernd.com>
Date: Fri, 18 Jul 2025 20:13:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
From: Bernd Schubert <bernd@bsbernd.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, joannelkoong@gmail.com,
 Horst Birthelmer <hbirthelmer@ddn.com>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
 <286e65f0-a54c-46f0-86b7-e997d8bbca21@bsbernd.com>
 <71f7e629-13ed-4320-a9c1-da2a16b2e26d@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <71f7e629-13ed-4320-a9c1-da2a16b2e26d@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/18/25 20:07, Bernd Schubert wrote:
> 
>>
>> Please see the two attached patches, which are needed for fuse-io-uring.
>> I can also send them separately, if you prefer.
> 
> We (actually Horst) is just testing it as Horst sees failing xfs tests in
> our branch with tmp page removal
> 
> Patch 2 needs this addition (might be more, as I didn't test). 
> I had it in first, but then split the patch and missed that.
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index eca457d1005e..acf11eadbf3b 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -123,6 +123,9 @@ void fuse_uring_flush_bg(struct fuse_conn *fc)
>         struct fuse_ring_queue *queue;
>         struct fuse_ring *ring = fc->ring;
>  
> +       if (!ring)
> +               return;
> +
>         for (qid = 0; qid < ring->nr_queues; qid++) {
>                 queue = READ_ONCE(ring->queues[qid]);
>                 if (!queue)


More changes needed, we don't want to iterate over all queues in
fuse_request_end, dev_uring.c already handles the queue that ends
a request.

