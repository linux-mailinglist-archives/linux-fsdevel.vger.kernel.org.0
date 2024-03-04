Return-Path: <linux-fsdevel+bounces-13563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDDD87111A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 00:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536B628325D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 23:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29997CF33;
	Mon,  4 Mar 2024 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JdRGt6z8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611B61E4A2;
	Mon,  4 Mar 2024 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595455; cv=none; b=N2hhXzTp+LZyxAwctwB5eqqsf8wlYrZYVA3kfFRJUU4uhKyxOcvaC0P1dw5eW2qNveenNJfTEt+ygz7KvHAOi1Irp2CgKxbkYMRLgr+JEzERF9Z4bU3iH6dGtw/JqzfAUrFx4hsFEHmnlpFQzgmP363sHfs1DmRNjEx7aMwJRmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595455; c=relaxed/simple;
	bh=+rEQ1y9VkSnTHwSogsWbOYliPcdNnsQLMPnehdv2m7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIbO1yyehgMO1j4DfL2uRg5JzLofJYVAAk5QqNM1g2B9zTnHCUm0oH97C0GHS2Wz3EUQ1SK35vyAcyICcIK2LW4E4cGy/uzhew6i/tyy1mncEi+ztBB9g+gRcSn6HRauJ4jf63OYL97+FDN9iEsrWppuFfTGcQxV5ctZ6hdg8uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JdRGt6z8; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7DsSMFlL5qg2azIH7l+MCgrvgUctaUBWbPa4DPjIV08=; b=JdRGt6z8KhZlxvQ8lBZ0Ci6gbA
	DWSuQ5Zf0s+tchkJ6LPQkEUSWzGAQ58CBGFK4+ZWB2tP2B53MzSca/cEuV14E5gV9NFtvhHAmR5Yf
	gWgSq931e4lJcZlyzmTE+sSbm7/wwzVjcJzPPZiUAc0duUZLhWUUhDziAaCzYUvyw94f9HO8GTGP9
	kCn3YSbnxqzCh6+puXV3nbm3JWwxYH5WHAVRNCbP1Kr/UFjyO6JRI6tK0gn5+XB5smSuh4wfU0NDe
	iCEXKgcP+cKkfnVdkuyAOqKSDQudycXGYehBTQndjshnYKcUieoig7+dL553ygWXjF6VBtj/c5Iwj
	46gMeFGA==;
Received: from [179.93.184.120] (helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rhHs6-0062J8-Nw; Tue, 05 Mar 2024 00:37:27 +0100
Date: Mon, 4 Mar 2024 20:37:21 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
Message-ID: <ZeZbMVenoDNOFVik@quatroqueijos.cascardo.eti.br>
References: <20240222203013.2649457-1-cascardo@igalia.com>
 <87bk88oskz.fsf@mail.parknet.co.jp>
 <Zdf8qPN5h74MzCQh@quatroqueijos.cascardo.eti.br>
 <874jdzpov7.fsf@mail.parknet.co.jp>
 <87zfvroa1c.fsf@mail.parknet.co.jp>
 <ZdhsYAUCe9GVMnYE@quatroqueijos.cascardo.eti.br>
 <87v86fnz2o.fsf@mail.parknet.co.jp>
 <Zd6PdxOC8Gs+rX+j@quatroqueijos.cascardo.eti.br>
 <87le75s1fg.fsf@mail.parknet.co.jp>
 <Zd74fjlVJZic8UxI@quatroqueijos.cascardo.eti.br>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd74fjlVJZic8UxI@quatroqueijos.cascardo.eti.br>

On Wed, Feb 28, 2024 at 06:10:29AM -0300, Thadeu Lima de Souza Cascardo wrote:
> On Wed, Feb 28, 2024 at 12:38:43PM +0900, OGAWA Hirofumi wrote:
> > Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:
> > 
> > >> There are many corrupted images, and attacks. Allowing too wide is
> > >> danger for fs.
> > >> 
> > >> BTW, this image works and pass fsck on windows? When I quickly tested
> > >> ev3fs.zip (https://github.com/microsoft/pxt-ev3/issues/980) on windows
> > >> on qemu, it didn't seem recognized as FAT. I can wrongly tested though.
> > >> 
> > >> Thanks.
> > >> -- 
> > >> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> > >
> > > The test image I managed to create mounts just fine on Windows. New
> > > subdirectories can be created there just as well.
> > 
> > Can you share the image somehow? And fsck (chkdsk, etc.) works without
> > any complain?
> > 
> > Thanks.
> > -- 
> > OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> 
> Checking the filesystem on Windows runs without any complains, but it turns the
> directory into an useless lump of data. Without checking the filesystem,
> creating and reading files from that directory works just fine.
> 
> I tried to use gzip or xz to compress the very sparse filesystem image that I
> got, but they made it larger on disk than it really was. So here is a script
> and pieces of the filesystem that will create a sparse 8GB image.
> 
> Thank you for looking into this.
> Cascardo.

Hi, OGAWA Hirofumi.

What are your thoughts here? Should we make it possible to read such
filesystems? Is the proposed approach acceptable?

Thanks.
Cascardo.

