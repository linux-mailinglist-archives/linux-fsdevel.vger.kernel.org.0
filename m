Return-Path: <linux-fsdevel+bounces-45558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 684C1A796DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 22:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808903B2403
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 20:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188FC1F2B8E;
	Wed,  2 Apr 2025 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AynC7A59"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819C7193436;
	Wed,  2 Apr 2025 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627057; cv=none; b=pljA/rsdEnBi4ctiDT7uNAcnsjBW03mVWZRY1kxZqD57Z2RfNTkK1pJBu4osw4Ji1ofkxz2xUkMUd3uERcxHBQIIYJ+CTLO64bCRNdzCKgp/FEWfi9wx+Vrwkh7mqjCUgMqfzEW//F/Twr3KceMxblRvzydVd8E1H/7tu33QO4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627057; c=relaxed/simple;
	bh=0djtFdo5h3fDieUNKNXazTKddt+w5retjfkch5CCArs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=je8v2Hj5DWTxkJdlNR4ztHA8nvsxZ806jQeyE0CiYSJKUgbEyV0e9R/W5nQGZ/ozR693eVIwrkY01E8Rm0CzXo0CalQwaRDXRwDA02MAIWjgjcLs7DM8zrXAwFmGADbA3RNbl9Y3/sb4G1g2F1NCBSGNsyN13zi9G81oD+eIT0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AynC7A59; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743627056; x=1775163056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PZgBsjQbBUgfbfilglLiHgWwr6bb2rCEcoxzjvzGR6M=;
  b=AynC7A59OJeewNtH7GpGr6OMCNGJl5Dk5Q8OUgl65rLu+qBqiFBQ1Li0
   w9gS4nulRNMxFTx9VvR52st/HmcfrXCh1q3UC41iQrGghISVbv2J86H4y
   yYtyYIo66IsY75br+jH9XvzHPBt8msYQMwZE9Qfpg0JItA07rwXtwjsFq
   M=;
X-IronPort-AV: E=Sophos;i="6.15,183,1739836800"; 
   d="scan'208";a="285094299"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 20:50:52 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:63875]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.231:2525] with esmtp (Farcaster)
 id 58bbd771-3e95-48f9-9ba9-001f711cdfcd; Wed, 2 Apr 2025 20:50:51 +0000 (UTC)
X-Farcaster-Flow-ID: 58bbd771-3e95-48f9-9ba9-001f711cdfcd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 20:50:51 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 20:50:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <cve@kernel.org>, <edumazet@google.com>, <ematsumiya@suse.de>,
	<kuniyu@amazon.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
	<sfrench@samba.org>, <smfrench@gmail.com>, <wangzhaolong1@huawei.com>,
	<zhangchangzhong@huawei.com>
Subject: Re: Fwd: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
Date: Wed, 2 Apr 2025 13:50:05 -0700
Message-ID: <20250402205039.9933-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025040256-spindle-cornea-60ec@gregkh>
References: <2025040256-spindle-cornea-60ec@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 2 Apr 2025 21:28:51 +0100
> On Wed, Apr 02, 2025 at 01:22:11PM -0700, Kuniyuki Iwashima wrote:
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Date: Wed, 2 Apr 2025 21:15:58 +0100
> > > On Wed, Apr 02, 2025 at 01:09:19PM -0700, Kuniyuki Iwashima wrote:
> > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Date: Wed, 2 Apr 2025 16:18:37 +0100
> > > > > On Wed, Apr 02, 2025 at 05:15:44PM +0800, Wang Zhaolong wrote:
> > > > > > > On Wed, Apr 02, 2025 at 12:49:50PM +0800, Wang Zhaolong wrote:
> > > > > > > > Yes, it seems the previous description might not have been entirely clear.
> > > > > > > > I need to clearly point out that this patch, intended as the fix for CVE-2024-54680,
> > > > > > > > does not actually address any real issues. It also fails to resolve the null pointer
> > > > > > > > dereference problem within lockdep. On top of that, it has caused a series of
> > > > > > > > subsequent leakage issues.
> > > > > > > 
> > > > > > > If this cve does not actually fix anything, then we can easily reject
> > > > > > > it, please just let us know if that needs to happen here.
> > > > > > > 
> > > > > > > thanks,
> > > > > > > 
> > > > > > > greg k-h
> > > > > > Hi Greg,
> > > > > > 
> > > > > > Yes, I can confirm that the patch for CVE-2024-54680 (commit e9f2517a3e18)
> > > > > > should be rejected. Our analysis shows:
> > > > > > 
> > > > > > 1. It fails to address the actual null pointer dereference in lockdep
> > > > > > 
> > > > > > 2. It introduces multiple serious issues:
> > > > > >    1. A socket leak vulnerability as documented in bugzilla #219972
> > > > > >    2. Network namespace refcount imbalance issues as described in
> > > > > >      bugzilla #219792 (which required the follow-up mainline fix
> > > > > >      4e7f1644f2ac "smb: client: Fix netns refcount imbalance
> > > > > >      causing leaks and use-after-free")
> > > > > > 
> > > > > > The next thing we should probably do is:
> > > > > >    - Reverting e9f2517a3e18
> > > > > >    - Reverting the follow-up fix 4e7f1644f2ac, as it's trying to fix
> > > > > >      problems introduced by the problematic CVE patch
> > > > > 
> > > > > Great, can you please send patches now for both of these so we can
> > > > > backport them to the stable kernels properly?
> > > > 
> > > > Sent to CIFS tree:
> > > > https://lore.kernel.org/linux-cifs/20250402200319.2834-1-kuniyu@amazon.com/
> > > 
> > > You forgot to add a Cc: stable@ on the patches to ensure that they get
> > > picked up properly for all stable trees :(
> > 
> > Ah sorry, I did the same with netdev.  netdev patches usually do
> > not have the tag but are backported fine, maybe netdev local rule ?
> 
> Nope, that's the "old" way of dealing with netdev patches, the
> documentation was changed years ago, please always put a cc: stable on
> it.  Otherwise you are just at the whim of our "hey, I'm board, let's
> look for Fixes: only tags!" script to catch them, which will also never
> notify you of failures.

Good to know that, thanks!

My concern was that I could spam the list if I respin the patches,
and incomplete patch could be backported.

From stable-kernel-rules.rst, such an accident can be prevented if
someone points out a problem within 48 hours ?

For example, if v1 is posted with Cc:stable, and a week later
v2 is posted, then the not-yet-upstreamed v1 could be backported ?

