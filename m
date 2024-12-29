Return-Path: <linux-fsdevel+bounces-38245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BDF9FE03D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 19:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D461881D2E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 18:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92251991C9;
	Sun, 29 Dec 2024 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gcdbp0yb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221DB198845;
	Sun, 29 Dec 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735498430; cv=none; b=t8c5bBcE4wO76EQqz+UM2N1KIGZE14VNE/vL3eH00SHm5j+RvMYWvyp9HP5AhiysCJ3riTKRTmf6GHTqVQCuvhxUpfTZhWq4DmUR8ml5U7FuKSqxrRjgvUq15X/+egXPhqEsxOF+Zedij5Klsb1nKgWpmOUgv3XBW9kjZmTg/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735498430; c=relaxed/simple;
	bh=sNrn2XI79whngEDo+mU6+M0TkVCrFed3PGYC7+kGcSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdQimuyTkQGPsp4n5/F8XtxobDnaoQJuyjDOquO+oEd75RG+D+nQxNUsY1NDAEpHwsevuEqUMRzAemhXMeFPFPOYrxYR5R04wfQK0qYoZPLeNUtnZJNj2J+i272bIqPrv3YSb36PKRJr6sw6xi0eGu6bvxNNV2YzYVWnrsD46Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gcdbp0yb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iGe2DxKIrwClb3eIxSSgpn1bL7WeuCbpshqxRAST/oQ=; b=gcdbp0ybk5LuQGKf2VnGB0LoRz
	F4ruCAM4aWP4ezSoGTknSXzUlvBiinNksnaYY80FJunAdry4H6jM4x/47st5rx5wVV36bJCSGrQWl
	g7BzCI3dswwTJUifRStyce/zLiMP0+vAZnD5T2m98kl6M7gOh/iuABkTzRnITtA2Dq6j2JoVz/bWf
	aNuxtMgEq4802nPpZlQzyNidl2SHetIcdB4MmkCSToZ0ag0QW8dwr9pIUNKBSlOCPhH9PBUO4FF0U
	lf1w+88vHZpcRW5MZDpP2UAfZMInunEHQcWyBXUqlw5SMFbY4l09o3v1mZkKbsSB8vu+/v7gCqUvU
	PVZOn3hg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRyQ5-0000000DXy1-1hYi;
	Sun, 29 Dec 2024 18:53:45 +0000
Date: Sun, 29 Dec 2024 18:53:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, linux-fsdevel@vger.kernel.org,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	linux-sound@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [CFT][PATCH] fix descriptor uses in sound/core/compress_offload.c
Message-ID: <20241229185345.GB1977892@ZenIV>
References: <20241226182959.GU1977892@ZenIV>
 <d01e06bf-9cbc-4c0e-bcce-2b10b1d04971@perex.cz>
 <20241226213122.GV1977892@ZenIV>
 <20241226221726.GW1977892@ZenIV>
 <87o70udgzi.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o70udgzi.wl-tiwai@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Dec 29, 2024 at 09:35:13AM +0100, Takashi Iwai wrote:
> On Thu, 26 Dec 2024 23:17:26 +0100,
> Al Viro wrote:
> > 
> > On Thu, Dec 26, 2024 at 09:31:22PM +0000, Al Viro wrote:
> > > On Thu, Dec 26, 2024 at 08:00:18PM +0100, Jaroslav Kysela wrote:
> > > 
> > > >   I already made almost similar patch:
> > > > 
> > > > https://lore.kernel.org/linux-sound/20241217100726.732863-1-perex@perex.cz/
> > > 
> > > Umm...  The only problem with your variant is that dma_buf_get()
> > > is wrong here - it should be get_dma_buf() on actual objects,
> > > and it should be done before fd_install().
> > 
> > Incremental on top of what just got merged into mainline:
> > 
> > Grab the references to dmabuf before moving them into descriptor
> > table - trying to do that by descriptor afterwards might end up getting
> > a different object, with a dangling reference left in task->{input,output}
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Could you resubmit this one as a formal patch to be merged?
> Thanks!

Done (https://lore.kernel.org/all/20241229185232.GA1977892@ZenIV/)

