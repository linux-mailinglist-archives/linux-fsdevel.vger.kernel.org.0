Return-Path: <linux-fsdevel+bounces-54349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6BEAFE6C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 13:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13364E63B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 11:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85BB291C3E;
	Wed,  9 Jul 2025 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="q+YZPgF+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TDePdx1f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDEC291880
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058813; cv=none; b=Gcly8r95rObrOZwx7ZSz7OUMfK3GQhv20zXLaujJelZqOqYHOqjZ/V0iwzlX0bNvktW+0C8Yy4ZKUj7gSrnj/QmdU+HAyEU6kbIb/WloNNSnQvPnNZfATHIZVb1KcUBxymRFCMni8okSeHWxI8cWJ37iCL0XLOEZL+hBJbGKrwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058813; c=relaxed/simple;
	bh=1MbgczqxFcybwo8axOfIe4o7u3N/LuuSFNWDKcG4t64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESym6GgdgwMIznZKejum3lFoPGgmRqy/i2Uj/DcRSRzzJDTyEJU4qFkM4LV89NdxOmm/ulKbtXet5x1JD06UIF9LqBhRLBARtwz50t6MwAYzjzkvsxcSCCAMoOnKwlyNTZSSOYMHK+wdsUHK4mMuuz1YIPZXQkfMNlYAeToHfo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=q+YZPgF+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TDePdx1f; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 42DCA7A021B;
	Wed,  9 Jul 2025 07:00:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 09 Jul 2025 07:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752058809;
	 x=1752145209; bh=wnOsV0LWr37RiU0eXapkgUL3M+9Kez0984NfI+PIRXU=; b=
	q+YZPgF+0wbmuMMx1Dx2V95aqwYLAzs+xwSZxjRkOg2BNfhyBT4FGrcrmht8fFHm
	EGGi+CB2xQ9V0XHsGsF/70wzrnFJSgSulh/A//juw9HfR39M2UajRel1kSHdTJWX
	3JWTyLAJG78phVmFlKzBv6rNmRNErlxPoGEQkjglCQY7JXuzRJAlRryaCavvUD/i
	QXd1rYAVDtacIVu2wdR5nW3OSXN3iWOYKTJaMRZNwT13wCctZs7SJtlY1u/qlnCa
	v2gqyPcIjhBxVW0PbR90UQzm/MJuskiCaJcZvBYncWwTdDMKi6hSmNqAzRRbwDiC
	ZILRHJviFX2KPFgAwfHjzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752058809; x=
	1752145209; bh=wnOsV0LWr37RiU0eXapkgUL3M+9Kez0984NfI+PIRXU=; b=T
	DePdx1fZSBTH1OlYecFDKm4LFcKEX5Eglk8Hap03WavwqLp/ri925SwbLyO84Fip
	gJtzSlx0uwkFaLKFx6pgwO3jN8olScyvlnzX+g/1V4TXEUcTGOHtNXDywV0WfaW+
	WPhULvvGC6KRXw3TuCRGmyngmbBIme0226dU/5IlP5aluscpNl9jHEOyZ4ix5g1h
	XLyZrpHfEUIrvrXnyMz/S8FhMr/YJi38sDrmeicvWlB+h19VoKalBpPYHKwzk/cI
	CFFj7V+qbtQhtxsCfyYs9VoSzsBLakos6NfxRnoctpMvl73VOF5T+DL2zGOv2bq9
	oi+B0hann373Of4sBa8cw==
X-ME-Sender: <xms:uEtuaIwkbqB6YQruqiAwM7-jOX9leNUMV1fQsYKIS7VUrV0Z3ERMiA>
    <xme:uEtuaJ0zD0jLry4KvKGcS32K8oEtpWyChyX7pF4vu97aNu-aCUACv3AKx0tKkZfVd
    MIETonNpLrGn91n>
X-ME-Received: <xmr:uEtuaAx2Q6BGApBSd2s6dosnUrPhu-BU6XVFFpz2BhcI172_sYgfrReybVybcsL-YbYIK21wBGqjgRqs09nYjw8MVUP_M8V_zjqlFEW3Ce6kRufv5NZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertd
    dtvdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgs
    vghrnhgurdgtohhmqeenucggtffrrghtthgvrhhnpeehhfejueejleehtdehteefvdfgtd
    elffeuudejhfehgedufedvhfehueevudeugeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsg
    gprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlvghordhl
    ihhlohhngheshhhurgifvghitghlohhuugdrtghomhdprhgtphhtthhopehmihhklhhosh
    esshiivghrvgguihdrhhhupdhrtghpthhtoheplhgvohdrlhhilhhonhhgsehhuhgrfigv
    ihdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohephihirdiihhgrnhhgsehhuhgrfigvihdrtghomhdp
    rhgtphhtthhopeihrghnghgvrhhkuhhnsehhuhgrfigvihdrtghomhdprhgtphhtthhope
    hlohhnuhiglhhirdeigeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:uEtuaIHfjFvqXH-IC0JyQTIijN5wQREgjsVYqjtfZHNZ0l0JlnIyNA>
    <xmx:uEtuaLZvAsdl0_GPeqJ4PDVRL0ZAGdMg25CKsPd4Y0JKE1HVE4cCVw>
    <xmx:uEtuaCBwCTAp8h-imYwDduvYO-8lYcqiFjb37Qf3KYlGwLSYg-Btkw>
    <xmx:uEtuaLl4qppVHAqoCWFVHbVeUWpWxKUlvyD7qmbUELi5Jjedz9fR1w>
    <xmx:uUtuaNYl7VYybA2ideYKWeFoYiGvD1U5jZHfS6uFWQLOWM-g25ud3Dso>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 07:00:06 -0400 (EDT)
Message-ID: <b33a4493-1b77-42b5-aac9-b0af0833a131@bsbernd.com>
Date: Wed, 9 Jul 2025 13:00:05 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: show io_uring mount option in /proc/mounts
To: leo.lilong@huaweicloud.com, miklos@szeredi.hu
Cc: leo.lilong@huawei.com, linux-fsdevel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, lonuxli.64@gmail.com
References: <20250709020229.1425257-1-leo.lilong@huaweicloud.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250709020229.1425257-1-leo.lilong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/25 04:02, leo.lilong@huaweicloud.com wrote:
> From: Long Li <leo.lilong@huawei.com>
> 
> When mounting a FUSE filesystem with io_uring option and using io_uring
> for communication, this option was not shown in /proc/mounts or mount
> command output. This made it difficult for users to verify whether
> io_uring was being used for communication in their FUSE mounts.
> 
> Add io_uring to the list of mount options displayed in fuse_show_options()
> when the fuse-over-io_uring feature is enabled and being used.
> 
> Signed-off-by: Long Li <leo.lilong@huawei.com>
> ---
>  fs/fuse/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index ecb869e895ab..a6a8cd84fdde 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -913,6 +913,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
>  			seq_puts(m, ",default_permissions");
>  		if (fc->allow_other)
>  			seq_puts(m, ",allow_other");
> +		if (fc->io_uring)
> +			seq_puts(m, ",io_uring");
>  		if (fc->max_read != ~0)
>  			seq_printf(m, ",max_read=%u", fc->max_read);
>  		if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)

I agree with you that is impossible to see, but issue is that io_uring
is not a mount option. Maybe we should add a sysfs file?

Thanks,
Bernd

