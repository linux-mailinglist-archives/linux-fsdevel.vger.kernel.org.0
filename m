Return-Path: <linux-fsdevel+bounces-14271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC5C87A42C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 09:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9091F21FFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 08:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6AD1A731;
	Wed, 13 Mar 2024 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qK5AAVmH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E471387;
	Wed, 13 Mar 2024 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710319305; cv=none; b=p2dF8urDTNbMJ+a2uFKjbDm2wgoUVnFCQqTO9hTQYH7gSPy/xU6jCuWJyQZIqy5rO+2DSQ4K0nJ/ldJ2wOi20r6ria86ltnNDyfD8kbl9h7sM8P+ErrSwuqu7y4+tffOg4dbTWXfBxkyhGBt83bCAE1Kwzov8iH0JjGDppG1ygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710319305; c=relaxed/simple;
	bh=MsMasDdN6r+3X0Wz41qXNgAS24bINb5kwJtcRvRsOzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzAbmKJTChTSaCn7LcKPwGPnsQ6M6A9vOig6V+U6kfPvp6aU/fZvOIvFRK5XQ8QnR9jN9CHL2dFPn5rRYJIDkHCMtIOhUpR5kJCVspiKa322WDkOZXJvOcn2+on4PmWOOLMp2VLeMpWwO9MZIw/KRUnrrnKYkqM4r1ZABp3Cw8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qK5AAVmH; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=splz9LqGAeewyrIB5UcXZJcELJXLMp1ha+ZaXYwZxgc=; b=qK5AAVmHGHDC8K+tZUIMJdP3Ko
	KLA8qiPqLOUd1Vh2/PNVQVhbG6hEOpYDy4JN87XkYtPfpsKbsvt+lpyzMgpbDJe70tEUR+cwO/tCi
	uQO2v0d05AUZvw8+qb5rGc6x0a55UywGqK5FebcuiNCm47WA8yCYMi7pUHgjykQinbQjOSUhGRRx+
	e3ei4eXtcDPS/HB5+L8B8pmNHYM9fIQFxsbhJt7MS8pQRfMTPFGfC4D7XayYk97fRMrdNWvi23GF+
	UrXCqAt5C2UCa6Oct/+x9zuP1TCjxuO4X7EMXEd7F/bJOyslG4G/aLZkCVWGzCKTu5ba663LwQSRE
	FE7vnL3Q==;
Received: from [179.93.183.242] (helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rkKB7-009lzb-QX; Wed, 13 Mar 2024 09:41:38 +0100
Date: Wed, 13 Mar 2024 05:41:32 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
Message-ID: <ZfFmvGRlNR4ZiMMC@quatroqueijos.cascardo.eti.br>
References: <ZdhsYAUCe9GVMnYE@quatroqueijos.cascardo.eti.br>
 <87v86fnz2o.fsf@mail.parknet.co.jp>
 <Zd6PdxOC8Gs+rX+j@quatroqueijos.cascardo.eti.br>
 <87le75s1fg.fsf@mail.parknet.co.jp>
 <Zd74fjlVJZic8UxI@quatroqueijos.cascardo.eti.br>
 <87h6hek50l.fsf@mail.parknet.co.jp>
 <Ze2IAnSX7lr1fZML@quatroqueijos.cascardo.eti.br>
 <87cys2jfop.fsf@mail.parknet.co.jp>
 <ZfFcpWRWdnWmtebd@quatroqueijos.cascardo.eti.br>
 <878r2mk14a.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r2mk14a.fsf@mail.parknet.co.jp>

On Wed, Mar 13, 2024 at 05:05:41PM +0900, OGAWA Hirofumi wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:
> 
> >> You are forgetting to count about normal dirs other than "." and ".."?
> >> 
> >
> > Yes, I was not counting those. The patch simply ignores ".." when counting dirs
> > (which is used only for determining the number of links), and always adds one
> > link. Then, when validating the inode, it also only requires that at least one
> > link exists instead of two.
> 
> So you break the mkdir/rmdir link counting, isn't it?
> 

It is off by one on those images with directories without ".." subdir.
Otherwise, everything else works fine. mkdir/rmdir inside such directories work
without any issues as rmdir that same directory.

If, on the other hand, we left everything as is and only skipped the
validation, such directories would be created with a link count of 0. Then,
doing a mkdir inside them would crash the kernel with a BUG as we cannot
increment the link count of an inode with 0 links.

So the idea of the fix here is that, independently of the existence of "..",
the link count will always be at least 1.

Cascardo.

> Thanks.
> 
> > There is only one other instance of fat_subdirs being called and that's when
> > the root dir link count is determined. I left that one unchanged, as usually
> > "." and ".." does not exist there and we always add two links there.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

