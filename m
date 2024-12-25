Return-Path: <linux-fsdevel+bounces-38122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912819FC5FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 17:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16259162DE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EE7175562;
	Wed, 25 Dec 2024 16:01:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F38EC133;
	Wed, 25 Dec 2024 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735142459; cv=none; b=d9jEdCHqrIwK0OupqcaREJNJa71L3sk8hOHjWS44KrGi22SfpaIKJiHOhDTKtTMgfUGtoB2O1XcSCaWymPuB2nAOyAKK8+/0FUgL3KDpO7C3JbBOOMUp7LK4kRddQ5g22DD0uw7NoadoMfJuBdAuoZ5kMI3V9wg1dJShcDlc45I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735142459; c=relaxed/simple;
	bh=YH+d84w6omnV3SObakYZzy3dA28iigNm1C3G7NAauGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcIRa++Rb6YOMNM54Rwa+VLchaxWtatX5HjW7OI4D/xooA/dG1vrySVc/zdfYZHAGkDBZR5R5o9lJaqpF12sQmcBuxsGAPRqh5NvFF8GWt9SX2TBOUlnj6pUaIgvNxyxQWK39v1kHCpJAfI0oiJ8qo4OJVLg5byZj9OVBbBhpWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 4BPG0HSC010396;
	Wed, 25 Dec 2024 17:00:17 +0100
Date: Wed, 25 Dec 2024 17:00:17 +0100
From: Willy Tarreau <w@1wt.eu>
To: WangYuli <wangyuli@uniontech.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Overstreet <kent.overstreet@linux.dev>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <20241225160017.GA10283@1wt.eu>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <Z2wI3dmmrhMRT-48@smile.fi.intel.com>
 <D7FF3455CE14824B+a3218eef-f2b6-4a9b-8daf-1d54c533da50@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7FF3455CE14824B+a3218eef-f2b6-4a9b-8daf-1d54c533da50@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Dec 25, 2024 at 11:42:29PM +0800, WangYuli wrote:
> On 2024/12/25 21:30, Andy Shevchenko wrote:
> 
> > Don't you think the Cc list is a bit overloaded?
> 
> Hi,
> 
> I apologize for any inconvenience this may cause.
> 
> I understand that under normal circumstances, one would simply pass the
> modified code path as an argument to the kernel's scripts/get_maintainer.pl
> script to determine the appropriate recipients.
> 
> However, given the vast and complex nature of the Linux kernel community,
> with tens of thousands of developers worldwide, and considering the varying
> "customs" of different subsystems, as well as time zone differences and
> individual work habits, it's not uncommon for patches to be sent to mailing
> lists and subsequently ignored or left pending.
(...)

Sorry, but by CCing 191 random addresses like this, that's the best way
to be added to .procmailrc and be completely ignored by everyone. At some
point one should wonder whether that's a common practice or if such
behaviors will be considered offensive by the majority. get_maintainer.pl
only lists the 2 lists and 3 addresses I left in CC (after Kent and Andy
whom I left since they replied to you).

> This patch, for example, has been submitted multiple times without receiving
> any response, unfortunately.

It can happen, but sending to the right people and possibly resending if
it gets lost is usually sufficient to attract attention. Sending to that
many people make you look like someone feeling so important they need to
shout in a loudspeaker to send orders to everyone. Please refrain from
doing this in the future.

Thanks,
Willy

