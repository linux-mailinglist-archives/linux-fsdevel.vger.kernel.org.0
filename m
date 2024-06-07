Return-Path: <linux-fsdevel+bounces-21267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A65900A15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 18:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB2A1C23465
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F189F199EBB;
	Fri,  7 Jun 2024 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vmp9Fc4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73631154444
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776719; cv=none; b=CTs+hsLu9cyiyhPOiPMk3jthCRp5PlwN1lvDeudlbdMPpnHRX4pQEhZBLUScVbeDROI7HD0GqAs+cPaayGPbbGgl64PK6vt7nYlcQa+TroMWqaUUA2C2V8hv7FAwmdYNoUcILAuC1zOwxnjq8YYCVYkh62Lf1EQx09ffGFCJ11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776719; c=relaxed/simple;
	bh=X74wcSZZ5WfRyVvSEjGr6mAME7TB6/HrroYayAdyzQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJFjMdpXitE+nNTv9nPUdMYu5fcrpiCddggkTViOydyEhnRD+/61CZhMxdVVZb4lWrlRjr000+7qDA/fei34Dxim7jyAboBh2wu5G+EEyBKCVRi8QryukhUOTFbv+MwRs9DJiOmfMZu2yYny5cVzfQi5+OPIa4GvR1REK2kdMtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vmp9Fc4K; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TaYG+hR0EWVvXLsa7R8mCOkKJinfW0sNnPfPY6b5jdg=; b=vmp9Fc4KPDSpgrLKzw1wEVMmfT
	pWEm0zAQLjWEb1Bj+y3mVdikO/ITXTTsjf0VjuCVMqgsfAdSe7n7TnHPJ4JZcresanzLMwzhsE2mV
	Ys7x4cxay27oFRXfmolQYdUw+CJv1/4LIhxp8QmR3+nzMEHp3cItiU0zeyQLv51Uwka1jiRr9ZPFc
	uQjjliEAmjTfJyU15ZVrQiOPyQZsno49k8AP9yxpKhTB63tSQ2oZs/W/ZCJ65hzznMslds0LJlGQu
	kohg55ipPZldcIO1jEsFM4qexTZj8ual1Ec1bsO4Vw7P4aEHZ2ahOuAX5wHPnFb6p2O2iRMlEkN5O
	ZgWtgcow==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFcC3-00DAd1-2u;
	Fri, 07 Jun 2024 16:11:56 +0000
Date: Fri, 7 Jun 2024 17:11:55 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 11/19] switch simple users of fdget() to CLASS(fd, ...)
Message-ID: <20240607161155.GA1629371@ZenIV>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
 <20240607015957.2372428-11-viro@zeniv.linux.org.uk>
 <20240607-gelacht-enkel-06a7c9b31d4e@brauner>
 <20240607161043.GZ1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607161043.GZ1629371@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 07, 2024 at 05:10:43PM +0100, Al Viro wrote:
> On Fri, Jun 07, 2024 at 05:26:53PM +0200, Christian Brauner wrote:
> > On Fri, Jun 07, 2024 at 02:59:49AM +0100, Al Viro wrote:
> > > low-hanging fruit; that's another likely source of conflicts
> > > over the cycle and it might make a lot of sense to split;
> > > fortunately, it can be split pretty much on per-function
> > > basis - chunks are independent from each other.
> > > 
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > 
> > I can pick conversions from you for files where I already have changes
> > in the tree anyway or already have done conversion as part of other
> > patches.
> 
> Some notes:
> 
> 	This kind of conversions depends upon fdput(empty) being not just
> a no-op, but a no-op visible to compiler.  Representation change arranges
> for that.
> 
> 	CLASS(...) has some misfeatures or nearly C++ level of tastelessness;
					of, sorry.

