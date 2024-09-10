Return-Path: <linux-fsdevel+bounces-29061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C97974508
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 23:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B116C286444
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 21:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4A81AB51E;
	Tue, 10 Sep 2024 21:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="pDpEEeIe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A2ngOLz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFE416C854
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726005091; cv=none; b=p1zPGHgo1srq1BeTKWRX7Fx93IwnV6ffwb0NJCc9wpSJDAK79glop4EfuKQyjne2VbphmT5R6vzKRfxT3uk6P/y8OdZOLeyK8k1tae+v1BB/2d/OEGav7x1tGxJzWVAM5Xe31yiUqpF8Wt7Ynb0hDm9njf2kS8317wYEsKOqrV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726005091; c=relaxed/simple;
	bh=W4XA1syrc5YNy2bO+0ziFVmsRrNqB7CuPwW/jNYvaNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UUAR6OV9ob5PoaZqC8vsjLUHpE5paRPKp/AcgmutQuh0Pbnma9uyQem1sABzkf+a4V/zqv4s4guBwEohpWQISk3GgxMy6C1dUw36NbwajbBq3xGp3QiJ66YovatVjHExKNid+trH9nJnkLjLN62+R93wKnZanVnd0MIDFjOjlpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=pDpEEeIe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A2ngOLz+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E56461140132;
	Tue, 10 Sep 2024 17:51:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 10 Sep 2024 17:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726005087;
	 x=1726091487; bh=BXwJQrJNZb70C/HEjxXHmZzNjVc5lSzrqbpsXgG1Ii8=; b=
	pDpEEeIeNReXIL/A1prjhRFOWKgOfbdZDQrkaHaq42Un0L3/nCBtUHmQkbKdKnS5
	Qvhmxdh98JTqvTOZIZl1ZsqGMgfPQznPitZ8tgu76ncErX2Ixj/nh4oWjdmF4qJm
	8+1+gB3YzzvrPmZeJvSgdPEhWu4BVFEAdgJz/W+WFl31tAZOLZWu2HjMulyf0DdH
	m52sUbdyTnad/+xjA40D3OCwcbWXI2FlDUzBfAgCVPRpuDaetOdvQL4/iDku/lA8
	c9fgwajc4SIPu/Jdti5NCun+SztqxOulZzm9cfUS5SQxeFC9YgnJvyT0uQ9NyGGw
	GzOp1rNk8QLWoGykM4C6Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726005087; x=
	1726091487; bh=BXwJQrJNZb70C/HEjxXHmZzNjVc5lSzrqbpsXgG1Ii8=; b=A
	2ngOLz+v0l1cygkbMg3tFI1hTVmYBCivx4pblcG3cRKhalqyTCP+jo2kRge4r9su
	3d1Pc8FbWIuBqIxmBIwKepHNt+UKBpImuGOMkB3T+7wIFGmGYEytEohvTC/iQRKW
	4mehdirx6sVMrc6pXYlv2AayuTEWhbJJxRsPh7EejqKd9djSdAsu+PVTXrQhCb/a
	ih5k3pAB4+OLuCw7ETTSsMVFE8sXzS5M9kbUiL936lOjEekmZzLnxldMgvPFFnlJ
	D+5AIJRkKUI+VJDk++3iFGMPmcI8N4DTNQbNkzzgmnowZhUX4LWb0zMpCfzhC7x0
	Z+DB4eBVoy5LL1cxNiPNA==
X-ME-Sender: <xms:X7_gZnytdgvBw9sFJ1UWuw4EmQI05H-3MNSpiT6AhbuXmM7xjefBnQ>
    <xme:X7_gZvRhqz9KMgJgkcJa17_PD-ZbVMgJf7twjcmZah9cubuvL-6W59AVLZ56yJOzg
    uYeJFiz7AQu1b3d>
X-ME-Received: <xmr:X7_gZhVFSvJpNFvXhDkYmIFEV-AoA4eisdYSfSdXgiEXZFYkbBRlq7mlihKhe4BMiQ7TFScR9Ej9ayGxvj04YDxgPAVaBhPQx-quENoYoUKwTbgm3Hqb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejtddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttddvjeen
    ucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrh
    htsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpedvvdeugfeivefgfeej
    teefieetgfefhefhueejjeeivdfgueehvedtheeggffgtdenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsggprh
    gtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhsvghfseht
    ohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtph
    htthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopegs
    shgthhhusggvrhhtseguughnrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrg
    guvggrugdrohhrgh
X-ME-Proxy: <xmx:X7_gZhi07w2oBGcJNW4Cct092wfcpRAIt6FkN1yVNNK2alQR2CJuVQ>
    <xmx:X7_gZpACQV1WZ-G0Q8SVQPtsfWvgVLa5rfEJWlJcBlaSfg7fduBZpQ>
    <xmx:X7_gZqITotpF1A6_k_pyFsSO-b_aW9qXgtxyaPn8DYTRswh20R5l0w>
    <xmx:X7_gZoB5m7y6q-DpCmMDMYVEOeHUUTkxw6ciFSwgSlMmyiRxyCzijA>
    <xmx:X7_gZjBRQVYE8mnMajOSbJQcDA5B7509N2uxcz7I7hV-ocUwlQUuOPbM>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 17:51:26 -0400 (EDT)
Message-ID: <4fe879e3-8a41-4ed2-88c3-bf704dd51945@fastmail.fm>
Date: Tue, 10 Sep 2024 23:51:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] fuse: use kiocb_modified in buffered write path
To: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
 amir73il@gmail.com, miklos@szeredi.hu, joannelkoong@gmail.com,
 bschubert@ddn.com, willy@infradead.org
References: <cover.1724879414.git.josef@toxicpanda.com>
 <f1b45bf6d5950678d1815a5ce70a650b483335ec.1724879414.git.josef@toxicpanda.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <f1b45bf6d5950678d1815a5ce70a650b483335ec.1724879414.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/28/24 23:13, Josef Bacik wrote:
> This combines the file_remove_privs() and file_update_time() call into
> one call.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/fuse/file.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 830c09b024ae..ab531a4694b3 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1454,11 +1454,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  
>  	task_io_account_write(count);
>  
> -	err = file_remove_privs(file);
> -	if (err)
> -		goto out;
> -
> -	err = file_update_time(file);
> +	err = kiocb_modified(iocb);
>  	if (err)
>  		goto out;
>  

Hmm, I need to discuss with Miklos if there is any interest to merge my
DIO consolidation branch - it needs to be heavily updated and my main
motivation to have the shared inode lock for for O_DIRECT writes is not
possible. But it merges fuse_direct_write_iter (FOPEN_DIRECT_IO) and
fuse_cache_write_iter into one call path (and actually fixes some
FOPEN_DIRECT_IO xfstests failures). For that branch I need to have
file_remove_privs separated.

https://lore.kernel.org/all/20230918150313.3845114-6-bschubert@ddn.com/

As I said, it need discussion if there is interest for that branch.

For current code, looks good to me.

Reviewed-by: Bernd Schubert <bschubert@ddn.com>

