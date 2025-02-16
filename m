Return-Path: <linux-fsdevel+bounces-41786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E55A37476
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 14:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5328188DED6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 13:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25016190051;
	Sun, 16 Feb 2025 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rx526Q21"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF40281E
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Feb 2025 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739711459; cv=none; b=c0UgVGcyDDKeamxHKy9pTzbYy0Qz4L6k8TK8uVmHcVEtB9v5TrIdzxU6pZ+tem7xtN+32200KXbO7nUTgUT5Gq9RW9b9v9Hg7bxbLf5z4x/Ra+2P7TEO7eyeOaWD/6z/iQmnbEOfWXDK0ZLNPDaiPUO+RXtk1VY13mTaZ4o2GDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739711459; c=relaxed/simple;
	bh=GmfPFDVEc0kxnQnQ0nJKLSKOGPBoUCx1o2oX9eP6LmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ki7JYWFEw0YGMxwlWlk74CY2JPN4ncqyN3FhLh/uNGujgabs45ZeMFuiPRkK2TK1vsXJrkcz9PBI24LngUt5MoIPpfw+zhz8JIfpuiR80WebtQ73iMsM7I48bBjird0le04x6oI75Gicos6+LyMVHtDMkrpnR2yX0Xytw3Vcyn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rx526Q21; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=eDfE4l6faWXAs9C5evkP8AGRUwokzBd0P+HIdgeiIRI=; b=rx526Q21wtoN85sd6tm43Rnc7f
	OjPe8IjwRcKvAzcXgHhATtLq5i1T0/lbvEdtyvVncq/kABtijaB0TRMDl6TWtDf2Yd0QkEXw2WAZN
	gPp+hO3Q1YnoWc8zI8pAqhMuvzcChqf+rth2z7pdC2ZRf9/K0/3AM5xRUxBZq1n1FxH2L2fu0NmGR
	beMecn5Zx3C8ScBh0+xV/FKnIwrhKME0iEWGdxAiPYeuvmM1Z+8DdxD5vtMiSxcfwMphAEAnIpb/x
	aw2RD4fPCrqcRDvr9LvScw6oP0TS/48ef+UXqjAnVvQpYcc/P6s92P0RjGoNaHun6BOOkjz6c21C/
	NMWEuv+w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tjeQA-0000000FmO0-1Ago;
	Sun, 16 Feb 2025 13:10:54 +0000
Date: Sun, 16 Feb 2025 13:10:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Malte =?iso-8859-1?Q?Schr=F6der?= <malte.schroeder@tnxip.de>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Random desktop freezes since 6.14-rc. Seems VFS related
Message-ID: <Z7Hj3pzwylskq4Fd@casper.infradead.org>
References: <39cc7426-3967-45de-b1a1-526c803b9a84@tnxip.de>
 <Z7DKs3dSPdDLRRmF@casper.infradead.org>
 <87e7e4e9-b87b-4333-9a2a-fcf590271744@tnxip.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87e7e4e9-b87b-4333-9a2a-fcf590271744@tnxip.de>

On Sun, Feb 16, 2025 at 12:26:06AM +0100, Malte Schröder wrote:
> On 15/02/2025 18:11, Matthew Wilcox wrote:
> > On Sat, Feb 15, 2025 at 01:34:33PM +0100, Malte Schröder wrote:
> >> Hi,
> >> I am getting stuff freezing randomly since 6.14-rc. I do not have a clear way to 
> > When you say "since 6.14-rc", what exactly do you mean?  6.13 is fine
> > and 6.14-rc2 is broken?  Or some other version?
> 6.13 and 6.13 + bcachefs-master was fine. Issue started with 6.14-rc1.

That's interesting.

> > This seems very similar to all of these syzbot reports:
> > https://lore.kernel.org/linux-bcachefs/Z6-o5A4Y-rf7Hq8j@casper.infradead.org/
> >
> > Fortunately, syzbot thinks it's bisected one of them:
> > https://lore.kernel.org/linux-bcachefs/67b0bf29.050a0220.6f0b7.0010.GAE@google.com/
> >
> > Can you confirm?
> 
> >From my limited understanding of how bcachefs works I do not think this
> commit is the root cause of this issue. That commit just changes the
> autofix flags, so it might just uncover some other issue in fsck code.
> Also I've been running that code before the 6.14 merge without issues.

If you have time to investigate this, seeing if you can reproduce this on
commit 141526548052 and then (if it does reproduce) bisecting between that
and v6.13-rc3 might lead us to the real commit that's causing the problem.


