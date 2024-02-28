Return-Path: <linux-fsdevel+bounces-13035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B5286A616
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 02:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1BE28BAED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 01:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3EB1DFCB;
	Wed, 28 Feb 2024 01:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kzRYekOS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267F1D53C;
	Wed, 28 Feb 2024 01:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709084556; cv=none; b=cnH44BMV6R2DH2uMv2Gxe0dJL34x97EqyuqHNIBAMe99ICYNU8+Q72F/FlqW4pO9T7R0GhkuYjOYWDxRMf0V3g8p4YEf4NIaw6OjjdTzJDKXP0uKoLg+mdgW56c2TWtUsjMBrUP1mEgQd7qH6r6xLG96knBzf5USHuij7MqKGnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709084556; c=relaxed/simple;
	bh=UG1mSWXXsmvRBtW+jWhlxw6CUZyIxQkORIvdZhnZ1qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ot+AND9lwrEufIxHP+Ged80QeGnsF1/vHiCXH8WjwBLLkc+niX3obNJKGfleC5shWO21UIHABGsY3b8FqCB4PYDNgshkBmRLvEijRrfLdI1VNnXt0/LLv/eJR/vC94WeEL1LteqLvs4U5ZmG50d67BrUaSPPQCK1+IJ52DDhgvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kzRYekOS; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oDQT1MuOQr0MialEbQYNMHgPmaiScAneNkAYisXVH8I=; b=kzRYekOSrOdZsQ407V1OClstI/
	MVO+DYisqmMrwsSHU/XtCq/AMXcrep9n8JffxNGeH0bzue9+8thl73VPhF5JrWT3l5rVmSOjwjuqk
	+PYhSLOxwyKJp0HGPlHDbceoTXrnvUrGQ34WJnZbe5UTU2Qu9BEGCDatyaq6PQInYDPIr3O8Xs9b9
	zIsfCZ4DW9Syg/PbSJu0LOl4C8lrRd8rkpddY24Ckfo99xWUyIwTvVN7fyeHF4ikGn79VCzzx1q48
	hhCpntaBnuuyqPse8pV8dfqU/+rfzKEVg7fmProrskVsdclvZg/wOaL6A5W+FTiZ6Zgpk8YrWDam8
	AAVQnoDQ==;
Received: from [179.93.184.120] (helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rf8xl-0046ZY-IH; Wed, 28 Feb 2024 02:42:25 +0100
Date: Tue, 27 Feb 2024 22:42:15 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
Message-ID: <Zd6PdxOC8Gs+rX+j@quatroqueijos.cascardo.eti.br>
References: <20240222203013.2649457-1-cascardo@igalia.com>
 <87bk88oskz.fsf@mail.parknet.co.jp>
 <Zdf8qPN5h74MzCQh@quatroqueijos.cascardo.eti.br>
 <874jdzpov7.fsf@mail.parknet.co.jp>
 <87zfvroa1c.fsf@mail.parknet.co.jp>
 <ZdhsYAUCe9GVMnYE@quatroqueijos.cascardo.eti.br>
 <87v86fnz2o.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v86fnz2o.fsf@mail.parknet.co.jp>

On Fri, Feb 23, 2024 at 09:29:35PM +0900, OGAWA Hirofumi wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:
> 
> > So far, I have only seen expected correct behavior here: mkdir/rmdir inside the
> > "bogus" directory works. rmdir of the "bogus" directory works.
> >
> > The only idiosyncrasies I can think of is that if neither "." or ".." are
> > present, the directory will have a link of 1, instead of 2. And when listing
> > the directory, those entries will not show up.
> >
> > Do you expect any of these to be corrected? It will require a more convoluted
> > change.
> >
> > Right now, I think accepting the idiosyncratic behavior for the bogus
> > filesystems is fine, as long as the correct filesystems continue to behave as
> > before. Which seems to be the case here as far as my testing has shown.
> 
> There are many corrupted images, and attacks. Allowing too wide is
> danger for fs.
> 
> BTW, this image works and pass fsck on windows? When I quickly tested
> ev3fs.zip (https://github.com/microsoft/pxt-ev3/issues/980) on windows
> on qemu, it didn't seem recognized as FAT. I can wrongly tested though.
> 
> Thanks.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

The test image I managed to create mounts just fine on Windows. New
subdirectories can be created there just as well.

Regards.
Cascardo.

