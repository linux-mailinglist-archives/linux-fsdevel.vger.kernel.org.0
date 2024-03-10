Return-Path: <linux-fsdevel+bounces-14078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4E987760B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 11:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42851F21A71
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 10:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5371EB46;
	Sun, 10 Mar 2024 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mmD8ObTy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76F1EA7D;
	Sun, 10 Mar 2024 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710065684; cv=none; b=tQkurPkJlBe+sJ/iyVHEFrVvEGqZVHmPqS8BS3RFGbDVyqS1cJtvHFvk+H7kmuJaX098fInnV3rYlg0F78nXp68Xwi0RbVS7yPvrIK+q2djmPnppnHutcL2i1pqXceWViEFOUPTaJKqWzk4ydTZwskKRFeQrj/145tOY0gpqhCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710065684; c=relaxed/simple;
	bh=umNLI3N00wBqjHZiPRTScScF1B97iqyA11vXQdaU6PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGFUpEZE1KMAxHgg1qV+wt2t4NYpWfuDAvbo979T6MUrfUgn1Xgy8y715WdxQxp0QpARWmpLchLci2STWPMbWfwHwbBconEIL25AFF9uupJyRe9PGX5No5P4dm3+uRMfsr18crn8vMy3TEHZJyL4DhahVNUPg5St5hhdZXI6NRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mmD8ObTy; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9n6Mr0vp6AEBfoJ3O6pzMaPZQWdOBPdvAee8P3mpHbs=; b=mmD8ObTysK4ZHXLDcoVg+hucIp
	WG4Cx5r5DNfTVrttUrRnf7EsGU9v+loejKquJYxpPpwoF1/wjYkvXN58wEbKJ0FBfFeMmhanhVOFb
	gg/HD3idnIFpE6adSq/j2AO00R4PZijd40v/pMK2c00VSPsLUTI3WVkEBi2aeRLcUuQUnokJUmct6
	gNQqgSv26AsZhwz6ArAv5oyhBeyx1sr72Ho3Zk5HejoXdcG2qHHXR63S0Il9BCNwtuBRqeSMNkmy6
	HgwamtBY/AaNDkzh226YASlKz7QjjyPgoiy+MpvX/qc1y5fQ7YEcQe2AzwgsEo010GNhQVZRw72Ot
	O0IAR45A==;
Received: from [179.93.183.242] (helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rjGCO-008TBC-2v; Sun, 10 Mar 2024 11:14:32 +0100
Date: Sun, 10 Mar 2024 07:14:26 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
Message-ID: <Ze2IAnSX7lr1fZML@quatroqueijos.cascardo.eti.br>
References: <87bk88oskz.fsf@mail.parknet.co.jp>
 <Zdf8qPN5h74MzCQh@quatroqueijos.cascardo.eti.br>
 <874jdzpov7.fsf@mail.parknet.co.jp>
 <87zfvroa1c.fsf@mail.parknet.co.jp>
 <ZdhsYAUCe9GVMnYE@quatroqueijos.cascardo.eti.br>
 <87v86fnz2o.fsf@mail.parknet.co.jp>
 <Zd6PdxOC8Gs+rX+j@quatroqueijos.cascardo.eti.br>
 <87le75s1fg.fsf@mail.parknet.co.jp>
 <Zd74fjlVJZic8UxI@quatroqueijos.cascardo.eti.br>
 <87h6hek50l.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6hek50l.fsf@mail.parknet.co.jp>

On Sun, Mar 10, 2024 at 02:52:26PM +0900, OGAWA Hirofumi wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:
> 
> >> Can you share the image somehow? And fsck (chkdsk, etc.) works without
> >> any complain?
> >
> > Checking the filesystem on Windows runs without any complains, but it turns the
> > directory into an useless lump of data. Without checking the filesystem,
> > creating and reading files from that directory works just fine.
> >
> > I tried to use gzip or xz to compress the very sparse filesystem image that I
> > got, but they made it larger on disk than it really was. So here is a script
> > and pieces of the filesystem that will create a sparse 8GB image.
> 
> I tested a your image with some tweaks. Windows's chkdsk complains about
> "BADDIR" directory, and it was fixed by converting it to normal
> file. Probably, chkdsk thought that "BADDIR" got ATTR_DIR bit by
> corruption.  IOW, Windows FATFS driver may accept this image, but
> Windows also think this image as corrupt, like chkdsk says.
> 
> I think the app that make this should be fixed. Windows accepts more
> than linux though, it looks also think as corrupt.
> 
> If we really want to accept this image, we have to change the fat driver
> without affecting good image.  And your patch affects to good image,
> because that patch doesn't count directory correctly, so bad link count.
> 

Well, it does behave the same on a correct image. It ignores the existence of
".." when counting subdirs, but always adds an extra link count.

So, images that have both "." and ".." subdirs, will have the 2 links, both
with the patch and without the patch.

Images with neither dirs will be rejected before the patch and have a link
count of 1 after the patch. Still, creating and removing subdirs will work.
Removing the bad dir itself also works.

Images with only "." or only ".." would have a link count of 1 and be rejected
without the patch.

With the patch, directories with only ".." should behave the same as if they
had neither subdirs. That is, link count of 1. And directories with only "."
will have a link count of 2.

Cascardo.

> Thanks.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

