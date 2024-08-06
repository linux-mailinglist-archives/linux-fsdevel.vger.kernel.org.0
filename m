Return-Path: <linux-fsdevel+bounces-25179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6532C949901
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 22:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965BE1C215C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FB415AAD7;
	Tue,  6 Aug 2024 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mzr30dZ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B553440875
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976031; cv=none; b=FfRVUx110s5vFTutlvDZbRYBe2mp4Q2zsUJ7mBJ/RIukJHmYXVV2EmsPGC4Yg4wCtaOj8A1Iw2uaaLiRTzBT6zibOQOWNzDdOTsskTOJ2YB9rQSQ/zBJhO2xWV/WXSrDUdBU2CNTPjNzWIcccmi0p7CdKnvBbotaYqQ21W66IiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976031; c=relaxed/simple;
	bh=btUfqlgIPsW5xmoTNva6xF0qhko+vUw4cMAgKjEZ1Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faeSQILoww8yhUWNaO5ekAcvv+V1agBzZtRTJaLnZtNlgjrCpsfi/lh5p2RjVaKb/xUUSIJIFytmnSACHqp3II8yKXRu028B0I6p1oWyaliIDs6TL/lWCDEH6kDG9icPrqlzlO+xpprMZL9Rf+I1AAYGDyEhAJU0CYJIQLDxEW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mzr30dZ+; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 6 Aug 2024 16:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722976028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjlADmA1+ph94gpKdf2QjHWMGzUXadMDhnq/CMyNQUo=;
	b=mzr30dZ+1RFTovgPsdrFQtpIPDRNovN9Lv0lrRb87ZG9sURHkfj+dsFOjHA8ttBbek7dAM
	EsKMlFj2yfjWJx4D9LbPVSgkAcON60SmiH5T/bhjFWxGHQ2uNK00C58/chKklU0sRcxCpZ
	8IK85TzJun/0ECHnbE2+PjkdHJ7zL00=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jonathan Carter <jcc@debian.org>
Cc: linux-bcache@vger.kernel.org, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, Viacheslav Dubeyko <slava@dubeyko.com>, slava@dubeiko.com
Subject: Re: bcachefs mount issue
Message-ID: <qxaz6togfw4w6bd5viau5wrvlieff5lyt3ijuj3fukutatdyem@zhn6hoqmkqlv>
References: <0D2287C8-F086-43B1-85FA-B672BFF908F5@dubeyko.com>
 <6l34ceq4gzigfv7dzrs7t4eo3tops7e5ryasdzv4fo5steponz@d5uqypjctrem>
 <21872462-7c7c-4320-9c46-7b34195b92de@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21872462-7c7c-4320-9c46-7b34195b92de@debian.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 06, 2024 at 05:21:04PM GMT, Jonathan Carter wrote:
> Hi Kent
> 
> On 2024/08/06 09:50, Kent Overstreet wrote:
> > Debian hasn't been getting tools updates, you can't get anything modern
> > because of, I believe, a libsodium transition (?), and modern 1.9.x
> > versions aren't getting pushed out either.
> > 
> > I'll have to refer you to them - Jonathan, what's going on?
> 
> 1.9.1 is in unstable. 1.9.4 would be good to go if it wasn't for a build
> failure I haven't had time to figure out, although I e-mailed you about it
> on the 26th (Message-ID: <2250a9ef-39e0-4afc-8d0d-2d26fbddbdaa@debian.org>)
> but haven't received any reply yet.

I get no hits searching for that?

