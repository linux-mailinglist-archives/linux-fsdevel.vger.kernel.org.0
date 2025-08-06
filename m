Return-Path: <linux-fsdevel+bounces-56914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5A6B1CE1A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8113F3A6A65
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FFD1FDA7B;
	Wed,  6 Aug 2025 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="nFa0vurz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JIcUNrAT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC31C5D72;
	Wed,  6 Aug 2025 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754513722; cv=none; b=jkMMv/M4imC6E7JlXMXeQG48ebOe//L0VgLcEyNbp6SB+aM4ruvmtw88dZYxSbGWbQG0v7atbpjbyBz7lb1szb7fWzo6aRVEWPHWrmK0BJa/xiNi9hpyHsTCMcRsSvZhnhFFiIzXzKoRBEzHab35FsUK2ARHCu80aIRJ0Nu5aDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754513722; c=relaxed/simple;
	bh=54xUB62CplasX1mx7fisyZ9P9WgcorjVVjt8KXvW9l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnR4O8+weyYLArYBjYTZmtbU/25hvli7lTIpQcDOQqRSi0csyLa0J0sW8Eouvb9VnC9+Fb3BsD/nn950on6DDQoQ1qgOClVKoxm8aiSB8leDUedj7iSRqgs4oTMVQWRisZlC5a5+vrPTI6CgRloyIQksNktSl1dcZ3yZq2CFeNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=nFa0vurz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JIcUNrAT; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 896791D000A4;
	Wed,  6 Aug 2025 16:55:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 06 Aug 2025 16:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754513716;
	 x=1754600116; bh=b3EiBgD+zq+pGmznr4aVpdajsWWFZnlVn4Kp2x4xaTI=; b=
	nFa0vurzXxGtrfXFFJS7wr5ObjcLdQ8p+zOcIjKRtphgMqRNYXn+1dQXSF8HnhQK
	UnIoNV1VYIUFjg+RlVw1MXPYeet++mfmLn/f9cH0tR85TN1Lasn1QTpcDlQF7OSq
	JpU5/AgWVp+NK1/4oIG3NYw0cyjoz7mjGBYyTtMXQQh29BnuhWXA9R8euI1bLT6w
	4+lE/QWwgLaPON8oyCPHkbCMkvhRRgshoIVEMuCixre1fa+OEo5kjRDhtxXAnZbG
	wwCbZOVlmMxglWe3Vzo4ZEcAWNPo9wf0ltW71z6qeAjO9RP/kvCMBaO3/9hBUPtC
	eRmkD4aVF5uk44kX4o8M5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754513716; x=
	1754600116; bh=b3EiBgD+zq+pGmznr4aVpdajsWWFZnlVn4Kp2x4xaTI=; b=J
	IcUNrATng/QXGa9rYqrlP7octHStvo0rhv5DA/2UUD2KJgpHz5e9oQcQIcIBrvZz
	I7I5ExKXGlBZ0XRhd9hTskywIx9IbtMpquNgq8eKElsNz0O1y1FKWQfWjpJPKl2r
	oz5y2B8VEenL1YFyGgg6sQ+KDUxgh846XXCV9t5p/9rnjptxF0cVyzjNt9Oxjc5W
	oBdVrP8Utkudr8SITSqc0BnP3+YL2A2M/vLSLYafcZ5tu2+Pv930EuMafOsZn3As
	p6LF9HNAh2y4muDs2CHgRJouvsiSKY1ATERHxKvnudloFPfBsF138ivtNSAjwXlh
	9pFQSKR5VZBOQtPxwrwFA==
X-ME-Sender: <xms:M8GTaL5x_TPdKKcqVfeJ1_xTgIJ0HjjSLp4lRffEtn1pefyDlNpQzg>
    <xme:M8GTaKVXgyMiWMyWpLPIfZ6xBxXaRpbNzv9s_YFJqvecsrz5LCosTJ-vNmKuvbj1m
    UNVMcqTnv4_AMjE>
X-ME-Received: <xmr:M8GTaCDdXFBNC-0yqNKUQexiVGSIlc0OlJFpwfoXpZt6GKS08CEwTahUWjq0O4rlNpt92eZAFRauELi69ktE1ENpgIB7GWcuAec4Wr_bIpuhuMWyM_blVhEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeltdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehluhhotghhuhhnshhhvghnghesuhhsthgtrdgvug
    hupdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehl
    ihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:M8GTaB76n8d-_wcV7mVcK8ji80SXo8kK8ZTVxe1heUup78XJXAgvUQ>
    <xmx:M8GTaFxZqWwSEkbMXRl4N3OmZ052TIJW5H5nR3TD7YE9FC-wK-JOUw>
    <xmx:M8GTaAxHRjbtViUtFdWJiuLqaFMIlkT7y8kTGdGV-1oL887SriHDrg>
    <xmx:M8GTaFwycqzadVPdXF_PZTLv665N-xxZP5resnWlpo4Q6H2GQ_ShQw>
    <xmx:NMGTaF6I06UBQ5DGcU8YXD7MPLPb6GX7QnEcKouZsPNSkTDvB3lIQlRg>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 16:55:13 -0400 (EDT)
Message-ID: <7b8d5689-1024-4c36-80c9-1cbffcc43dc0@bsbernd.com>
Date: Wed, 6 Aug 2025 22:55:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Move same-superblock check to fuse_copy_file_range
To: Chunsheng Luo <luochunsheng@ustc.edu>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250806135254.352-1-luochunsheng@ustc.edu>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250806135254.352-1-luochunsheng@ustc.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/6/25 15:52, Chunsheng Luo wrote:
> The copy_file_range COPY_FILE_SPLICE capability allows filesystems to
> handle cross-superblock copy. However, in the current fuse implementation,
> __fuse_copy_file_range accesses src_file->private_data under the assumption
> that it points to a fuse_file structure. When the source file belongs to a
> non-FUSE filesystem, it will leads to kernel panics.
> 
> To resolve this, move the same-superblock check from __fuse_copy_file_range
> to fuse_copy_file_range to ensure both files belong to the same fuse
> superblock before accessing private_data.
> 
> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
> ---
>  fs/fuse/file.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 95275a1e2f54..a29f1b84f11b 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2984,9 +2984,6 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
>  	if (fc->no_copy_file_range)
>  		return -EOPNOTSUPP;
>  
> -	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> -		return -EXDEV;
> -
>  	inode_lock(inode_in);
>  	err = fuse_writeback_range(inode_in, pos_in, pos_in + len - 1);
>  	inode_unlock(inode_in);
> @@ -3066,9 +3063,12 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
>  {
>  	ssize_t ret;
>  
> +	if (file_inode(src_file)->i_sb != file_inode(dst_file)->i_sb)
> +		return splice_copy_file_range(src_file, src_off, dst_file,
> +					     dst_off, len);
> +
>  	ret = __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
>  				     len, flags);
> -
>  	if (ret == -EOPNOTSUPP || ret == -EXDEV)
>  		ret = splice_copy_file_range(src_file, src_off, dst_file,
>  					     dst_off, len);

I guess you can remove the check EXDEV here?


