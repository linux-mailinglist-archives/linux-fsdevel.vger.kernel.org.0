Return-Path: <linux-fsdevel+bounces-44118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE710A62DD1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 15:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F393A7AC75D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 14:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E40A200100;
	Sat, 15 Mar 2025 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="e2Tb8FXm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB20C8E0;
	Sat, 15 Mar 2025 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742047483; cv=none; b=h4fJ8C+DhWLnZihcBDSp5tZxbI01o3Wmr19S9L2Cg/xLnj5FXUBM3lRhMSa8cgo5uAE2cVvjsoOilq/36dL6r9yHdI1sRjk1jag0+Xb6l1s377ucpCv8eP57KPj0hygQEslxN9BmzXXntUyCVeOZP/8IOtJbWSsKHE8ThTcDau8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742047483; c=relaxed/simple;
	bh=T/Mp1wYNOOCsbaYkPHiUEYeEX8T3lHhVOcyMD7fwR6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcqS7YCfw35PASfOPvbGFNBcTdBxR7ffF4+1DntN02WT+/Ff7A+OddQmeX668rvI+CkCyIaoxRW77K/UT/cqFXSQIkr8XfkQi9TeK/vNBynkrFM0B9F3QEo9Dbyr+7AmofgkTSNuGVy2K9P2GicHp+MElWcJKnS1pg07GLoDonQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=e2Tb8FXm; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZFNK0115vz9sWc;
	Sat, 15 Mar 2025 15:04:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742047476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QHg0buBba8+POh0Hm3WvsZrxeJW3iMfjygpEEvcYPdA=;
	b=e2Tb8FXmcu5vjvPHQZtpK8LK9EYyxeEQcPRvcQHKDsi44mjaCF6RfwWBD9T7zVnxwctn9/
	/rG/qMYogasSWSQ09YTOGKeQXEC/zWBwEE5ZV2NHLfSq4h05Kv46jQSWQ6MdWEONZM7Skc
	quOoIefXYRteg1neVqtHyTE+BT/6Ks0NM/WpT/FwWgg+FzdiXlEtoEJvPEHIQdWvTwoBN8
	82Nl0xbKWf2snHNvtySNoQrunkge+kmw4u8oYf31exlZ80wWfrRiZSBqzRI281laZ8V3bn
	ZgxvEBn96NIxeDI82rkm2OteRxkp/1Jb4zvUgQQCEuymsi5KtUGvnGv117pntw==
Date: Sat, 15 Mar 2025 10:04:32 -0400
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: tytso@mit.edu, ernesto.mnd.fernandez@gmail.com, 
	dan.carpenter@linaro.org, sven@svenpeter.dev, ernesto@corellium.com, gargaditya08@live.com, 
	willy@infradead.org, asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 0/8] staging: apfs: init APFS module
Message-ID: <fbixdumfvf52w3yglipgmgjopzqarpxbkd4h64unuodl6kekvj@wwbbvtr7tbce>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
 <2025031529-greedless-jingle-1f3b@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031529-greedless-jingle-1f3b@gregkh>
X-Rspamd-Queue-Id: 4ZFNK0115vz9sWc

On 25/03/15 08:00AM, Greg Kroah-Hartman wrote:
> On Fri, Mar 14, 2025 at 05:57:46PM -0400, Ethan Carter Edwards wrote:
> > Hello everyone,
> > 
> > This is a follow up patchset to the driver I sent an email about a few
> > weeks ago [0]. I understand this patchset will probably get rejected, 
> > but I wanted to report on what I have done thus far. I have got the 
> > upstream module imported and building, and it passes some basic tests 
> > so far (I have not tried getting XFS/FStests running yet). 
> > 
> > Like mentioned earlier, some of the files have been moved to folios, but
> > a large majority of them still use bufferheads. I would like to have
> > them completely removed before moved from staging/ into fs/.
> > 
> > I have split everything up into separate commits as best as I could.
> > Most of the C files rely in functions from other C files, so I included
> > them all in one patch/commit.
> > 
> > I am curious to hear everyone's thoughts on this and to start getting
> > the ball rolling for the code-review process. Please feel free to
> > include/CC anyone who may be interested in this driver/the review
> > process. I have included a few people, but have certainly missed others.
> > 
> > [0]: https://lore.kernel.org/lkml/20250307165054.GA9774@eaf/
> > 
> > Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> 
> I don't mind adding this to staging from this series, thanks for
> breaking it up!
> 
> But I'll wait for an ACK from the filesystem developers before doing it
> as having filesystem code in drivers/staging/ feels odd, and they kind
> of need to know what's going on here for when they change api stuff.

No problem. That makes sense. I used the process that erofs used as a
reference for how the fs development lifecycle should look. They started
in staging/ and ended in fs/ after. 

Thanks,
Ethan

> 
> thanks,
> 
> greg k-h

