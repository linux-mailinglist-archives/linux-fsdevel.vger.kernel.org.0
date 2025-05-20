Return-Path: <linux-fsdevel+bounces-49535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D812ABE121
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 18:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE404164C3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 16:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AC427A13A;
	Tue, 20 May 2025 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mB4Gqio8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FFF26FA7D
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759748; cv=none; b=RUEpEA8DlWJ1wCW3EFUaTaFW2LfI6d4gurpBmxzmAYaFI6zAYUoeLn6Wb7C0XgzZYj4O3Knzx9mAaruplREcqFrwEsvIFAPbu29qrgxIEg7dkepEE2PHcxM+DVjTL5STLNfclxirjQGvYCwwd1ufUkzrBEqn2f7kKpAzyM+GWmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759748; c=relaxed/simple;
	bh=TwWBWHtLJiGnl+ba1IbyUNOwdU5qwSPWkEpJGmeH988=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcEdRR9/HxtVDJb5ALDMawK2VaMP+2VB1KGkiNvysVnykwC4li07t7P/SRPh1TPtfyjzL5jbEo0Wer7pDLu1zj0zwLQ+Hj5KXl8WjwORnrCGXAFnEqLVilvZmnQjCtkvqT6hRTLm02XRCU9+Sw9mUBYlBzOcYN/dGuzTpkZzslA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mB4Gqio8; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 May 2025 12:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747759744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aa/ZOXEJzVJQIkfNq8IATu9TqYY/TOwRVU2kZmkq7Y8=;
	b=mB4Gqio8hBnmpGMR9w7uC18TCXyHHrMnpmStB/SYYwxPrPJWklZbUmfH9q5Rrc9GCiimq2
	ghn22JflydMSmIV6KT/P5Y0oDrvoFDSi75puuZECo+/QY0bJadg8haPxMghlzoRX4VOz2W
	WGsftI1qokDQrcLkwWp5ejqAjUoxm7U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
Message-ID: <6lveeao4ensfyaj4zzvyxaqhzybzbnzlk3fhae5sb2ejtzzquw@2cy3fuliwh5l>
References: <osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
 <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
 <gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
 <CAOQ4uxg9sKC_8PLARkN6aB3E_U62_S3kfnBuRbAvho9BNzGAsQ@mail.gmail.com>
 <rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
 <CAOQ4uxgOM83u1SOd4zxpDmWFsGvrgqErKRwea=85_drpF6WESA@mail.gmail.com>
 <7sa3ouxmocenlbh3r3asraedbbr6svljroyml3dpcoerhamwmy@gb32bhm4jqvh>
 <CAOQ4uxjHiorTwddK98mb60VOY8zNqnyWvW=+Uz-Sn6-Sm3PUfQ@mail.gmail.com>
 <ztuodbbng5rgwft2wtmrbugwo3v5zgrseykhlv5w4aqysgnd6b@ef56vn7iwamn>
 <CAJfpegs1AVJuh1U97cpTx14KcnQeO2XmtvrOwbyoZ8wvqfgqPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs1AVJuh1U97cpTx14KcnQeO2XmtvrOwbyoZ8wvqfgqPA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 20, 2025 at 06:40:35PM +0200, Miklos Szeredi wrote:
> On Tue, 20 May 2025 at 17:21, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > Docker mounts the image, but then everything explodes when you try to
> > use it with what look to the user like impenetrable IO errors.
> >
> > That's a bad day for someone, or more likely a lot of someones.
> 
> Wouldn't it be docker's responsibility to know that that won't work
> with overlayfs?

Why would it be?

> Any error, whether at startup or during operation is not something the
> user will like.
> 
> What am I missing?

A _mount_ error due to misconfiguration is expected operation, and we've
built mechanisms for reporting those errors in a way that users can
understand what's going on.

That's not true for normal file accesses post mount.

