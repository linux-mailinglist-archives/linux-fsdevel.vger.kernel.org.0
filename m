Return-Path: <linux-fsdevel+bounces-48013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB004AA8914
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 21:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0ADA169BB2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 19:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D012E248193;
	Sun,  4 May 2025 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Ur27fgHt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hkx6SUnu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFAE15575C
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 May 2025 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746385739; cv=none; b=T1L0QgPfOXu2KWKkMuBO8M6o/thinA5xkbunDB8UIFj7ym3RTpk5SG03nu/o8dnpXOzHi5X90OqUFOTcFM/jFGzHDLiJDstkE8ZTkaSoAqmM4327Is6mjqIAmtp5OOC7Iu+VjJc1cGvZ7KUdLTnhzImsDlsQzCra+kuR+hNMBFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746385739; c=relaxed/simple;
	bh=YNgwFhc79jbNHCdKIl18Ju6ohissPX63qpPMWlwrFoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeeTRBBAEetq2DcdnrslHagze4kKn9aZn0iHo4qh1lOBbJMoCFKW3VDcwiWAoPQWhf/8zkPS6CFZPhZ4ljzWhwMBEzQAF8TFN6yhHKzbh8b252QkOtV9kXNCiIFG3ED4YlTyJs8l4ahzQYhqqDhn0yFjEdss0pjn97gOak3kwMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=Ur27fgHt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hkx6SUnu; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2974313801C2;
	Sun,  4 May 2025 15:08:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 04 May 2025 15:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746385736;
	 x=1746472136; bh=K5eUqKjOHerZN5HJP9H7S+U/hxlMlet1aDGOeo/guxo=; b=
	Ur27fgHtft82ZmkAcAWB35CQVHM2OCiTxxg2pai7RnaKfGI49cXEYzfWQK7idwk3
	mjLvPb4FI9kAuferLegY2otBFkhXehsrkirmwT0hIB6iN5jA+xdXWTOLPWmlKFXi
	QmEWnv3ATwFNWOXLmt8BD4m+TJZX09We0+8mPEaiEmbdRMxLNBFIre2y04C1iLLm
	q+qdTJUHT5wS6fBIBSMPS5gTTcTC+Q1qrN/wt0EzNn2LCeelGslz/46d+MeJ1YPV
	5DbYLkkyuWWQYoeboDhrwJrQmN5aJVMC6vOooQ7AR8IIG2aWmns/eJd7AkPXUjHj
	z2iPR/oFoRxAvU8Hova07w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746385736; x=
	1746472136; bh=K5eUqKjOHerZN5HJP9H7S+U/hxlMlet1aDGOeo/guxo=; b=H
	kx6SUnuUfGDG33oGH4Ij7Nirs95VHSOBFDK7k+71hspGhRmbNafKO2M8o+jQXvr4
	lJOKF83tR09fSoprrwG3EiMSD8aos8OE3YqWA03+7siFOfWXSIGJ2BUH5gZEuRQ6
	VCE20jezCBf8CtNTRVMjAMp7TuS6xbLKqNPsIIJODsfRyqZxFDmm3ak6+Q3LBwCD
	tGcfOLWFK5+t7BHoXEYpMUjkrlALIY7YE7CkbieKkWgxcDqWkWDkKQiVIt8bh8Ka
	QRzE1YOlVyUZrrg464dWlOKAqClPP62UCTDO0kCMuQWvhFdX20HmaGL89jSXADH3
	NSniudCXZtfsua8qhNcGA==
X-ME-Sender: <xms:R7sXaOkLh-HelBtJnq1su2oVZsnu9idfnkW8mlsw0kYT3bKcG1fsvQ>
    <xme:R7sXaF2E9auStAlrqvagQAX58L_fEVpQ9mzz1yrNxY9cbYocE99lGYDajDl7K27oi
    z2GGzKnpfBm41jv>
X-ME-Received: <xmr:R7sXaMpBkW_rppBqoc6ulSNvgzvwoEcAhUz9Zv2xu3wEJrmVaoHDRhZCdB5cyCqCFJY4TQK7ztTgJOTUw5H0p5jSsmqgP7Z4XyV9hOCJdfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeeltdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhephedvveegheeh
    jeehfeejtdevffduffevteeiheelgefhhfdtheeljeevtefhtdfgnecuffhomhgrihhnpe
    ifrhhithgvrdhinhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdpnhgspg
    hrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgv
    lhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrh
    gvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhr
    tghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtohepfi
    hilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgv
    rghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:R7sXaCnrDxnFWJNcUvPMA6o06hVUuK7VUGDMc853pVKrcPjCC_398A>
    <xmx:R7sXaM26HY1GrdJdjopSbqWkFOLR1toj29g-ulj0LOlA_6nchFa2sg>
    <xmx:R7sXaJtTX0dUSe_Bk9lYUj6zFNgB57f9toeFJKJkziUE4x1MbOmWtw>
    <xmx:R7sXaIVsNfjygpBR5Q7H71hTfnwU1aBjyhvKORQPuuAV1Ebdxtwm7Q>
    <xmx:SLsXaNZHoEnCjLmaoCmuGUzePVq_gmATOuSdaUnKbGyeWsYtti5U0Y03>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 May 2025 15:08:54 -0400 (EDT)
Message-ID: <21ebe196-fd56-476c-bec4-cda0b9ed3c57@fastmail.fm>
Date: Sun, 4 May 2025 21:08:54 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/11] fuse: support large folios for queued writes
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, willy@infradead.org,
 kernel-team@meta.com
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
 <20250426000828.3216220-9-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250426000828.3216220-9-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/25 02:08, Joanne Koong wrote:
> Add support for folios larger than one page size for queued writes.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Bernd Schubert <bschubert@ddn.com>


> ---
>  fs/fuse/file.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 0ca3b31c59f9..1d38486fae50 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1790,11 +1790,14 @@ __releases(fi->lock)
>  __acquires(fi->lock)
>  {
>  	struct fuse_inode *fi = get_fuse_inode(wpa->inode);
> +	struct fuse_args_pages *ap = &wpa->ia.ap;
>  	struct fuse_write_in *inarg = &wpa->ia.write.in;
> -	struct fuse_args *args = &wpa->ia.ap.args;
> -	/* Currently, all folios in FUSE are one page */
> -	__u64 data_size = wpa->ia.ap.num_folios * PAGE_SIZE;
> -	int err;
> +	struct fuse_args *args = &ap->args;
> +	__u64 data_size = 0;
> +	int err, i;
> +
> +	for (i = 0; i < ap->num_folios; i++)
> +		data_size += ap->descs[i].length;
>  
>  	fi->writectr++;
>  	if (inarg->offset + data_size <= size) {


