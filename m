Return-Path: <linux-fsdevel+bounces-45573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2311A797E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 23:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 708B87A5090
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053401F4CA9;
	Wed,  2 Apr 2025 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bBbnKpj4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46EA1F4625;
	Wed,  2 Apr 2025 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743631155; cv=none; b=oblt9dVY6bpGXsNLXcJ4SP3axhRGQt5jPb4zpIhBAeKXxAHbDK8uWCI9DLnPBytLMO90IrXpnGZVp/Md9NpoqgRHDSczN1uNe+7HfiP0TqxxepafzKCP6/gF9AQF9bAIpai1DfaaYAHepLBnCyF9I7kx2vlqilEU6VpW8pT6jLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743631155; c=relaxed/simple;
	bh=gZR/lUCfu7BfhLrh0H0NV5UuBc0uNwuknUip/HsM9TU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mn616sMqekvrFQW0h+sYgaApsYrT5Sicsnw8YQDzURRAEiTvhlL2clGCDpPkJNuFMg5cdHoNwiFIVaArnld+M/rvtVUZJwpWZxNfZeJU1mQWY7P3w7ebrCnWs1ccywK8dGSXhB8pCUX9aMxuQA9Db7w1OFA+XJbZsiOprkUqS2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bBbnKpj4; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743631153; x=1775167153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qbseHlUeh+wI3W4Lnm3HLIl0X8Puvw62VR4kgEDnHcU=;
  b=bBbnKpj4ZCvqGPcLTUOivixmVgL7hVVmCKVYwlSsZpkKUEMvorYoMcTg
   VdP975AWYD/9Zi/IZzRUW+SQfo8x4NNLO1Kv+XGlXk6f+3yYN12rJdKwK
   WKUDwpAF0JAkPlY6dJ/j36UCyN2yNFcrYuJRgi3wq9SZfu+AlTsWmATYP
   c=;
X-IronPort-AV: E=Sophos;i="6.15,183,1739836800"; 
   d="scan'208";a="184340993"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 21:59:11 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:52418]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.18:2525] with esmtp (Farcaster)
 id 4a897196-90c0-4ea2-919a-6cf1e06e4c38; Wed, 2 Apr 2025 21:59:10 +0000 (UTC)
X-Farcaster-Flow-ID: 4a897196-90c0-4ea2-919a-6cf1e06e4c38
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 21:59:07 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 21:59:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <cve@kernel.org>, <edumazet@google.com>, <ematsumiya@suse.de>,
	<kuniyu@amazon.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
	<sfrench@samba.org>, <smfrench@gmail.com>, <wangzhaolong1@huawei.com>,
	<zhangchangzhong@huawei.com>
Subject: Re: Fwd: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
Date: Wed, 2 Apr 2025 14:58:49 -0700
Message-ID: <20250402215855.18968-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025040207-yippee-unlearned-4b1c@gregkh>
References: <2025040207-yippee-unlearned-4b1c@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 2 Apr 2025 22:32:58 +0100
> On Wed, Apr 02, 2025 at 01:50:05PM -0700, Kuniyuki Iwashima wrote:
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Date: Wed, 2 Apr 2025 21:28:51 +0100
> > > On Wed, Apr 02, 2025 at 01:22:11PM -0700, Kuniyuki Iwashima wrote:
> > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > Date: Wed, 2 Apr 2025 21:15:58 +0100
> > > > > On Wed, Apr 02, 2025 at 01:09:19PM -0700, Kuniyuki Iwashima wrote:
> > > > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Date: Wed, 2 Apr 2025 16:18:37 +0100
> > > > > > > On Wed, Apr 02, 2025 at 05:15:44PM +0800, Wang Zhaolong wrote:
> > > > > > > > > On Wed, Apr 02, 2025 at 12:49:50PM +0800, Wang Zhaolong wrote:
> > > > > > > > > > Yes, it seems the previous description might not have been entirely clear.
> > > > > > > > > > I need to clearly point out that this patch, intended as the fix for CVE-2024-54680,
> > > > > > > > > > does not actually address any real issues. It also fails to resolve the null pointer
> > > > > > > > > > dereference problem within lockdep. On top of that, it has caused a series of
> > > > > > > > > > subsequent leakage issues.
> > > > > > > > > 
> > > > > > > > > If this cve does not actually fix anything, then we can easily reject
> > > > > > > > > it, please just let us know if that needs to happen here.
> > > > > > > > > 
> > > > > > > > > thanks,
> > > > > > > > > 
> > > > > > > > > greg k-h
> > > > > > > > Hi Greg,
> > > > > > > > 
> > > > > > > > Yes, I can confirm that the patch for CVE-2024-54680 (commit e9f2517a3e18)
> > > > > > > > should be rejected. Our analysis shows:
> > > > > > > > 
> > > > > > > > 1. It fails to address the actual null pointer dereference in lockdep
> > > > > > > > 
> > > > > > > > 2. It introduces multiple serious issues:
> > > > > > > >    1. A socket leak vulnerability as documented in bugzilla #219972
> > > > > > > >    2. Network namespace refcount imbalance issues as described in
> > > > > > > >      bugzilla #219792 (which required the follow-up mainline fix
> > > > > > > >      4e7f1644f2ac "smb: client: Fix netns refcount imbalance
> > > > > > > >      causing leaks and use-after-free")
> > > > > > > > 
> > > > > > > > The next thing we should probably do is:
> > > > > > > >    - Reverting e9f2517a3e18
> > > > > > > >    - Reverting the follow-up fix 4e7f1644f2ac, as it's trying to fix
> > > > > > > >      problems introduced by the problematic CVE patch
> > > > > > > 
> > > > > > > Great, can you please send patches now for both of these so we can
> > > > > > > backport them to the stable kernels properly?
> > > > > > 
> > > > > > Sent to CIFS tree:
> > > > > > https://lore.kernel.org/linux-cifs/20250402200319.2834-1-kuniyu@amazon.com/
> > > > > 
> > > > > You forgot to add a Cc: stable@ on the patches to ensure that they get
> > > > > picked up properly for all stable trees :(
> > > > 
> > > > Ah sorry, I did the same with netdev.  netdev patches usually do
> > > > not have the tag but are backported fine, maybe netdev local rule ?
> > > 
> > > Nope, that's the "old" way of dealing with netdev patches, the
> > > documentation was changed years ago, please always put a cc: stable on
> > > it.  Otherwise you are just at the whim of our "hey, I'm board, let's
> > > look for Fixes: only tags!" script to catch them, which will also never
> > > notify you of failures.
> > 
> > Good to know that, thanks!
> > 
> > My concern was that I could spam the list if I respin the patches,
> > and incomplete patch could be backported.
> > 
> > >From stable-kernel-rules.rst, such an accident can be prevented if
> > someone points out a problem within 48 hours ?
> > 
> > For example, if v1 is posted with Cc:stable, and a week later
> > v2 is posted, then the not-yet-upstreamed v1 could be backported ?
> > 
> 
> Anything can be asked to be applied to stable once it is in Linus's
> tree, but if you add the cc: stable stuff to the original patch, it will
> be done automatically for you.

Now I understood.  The process is triggered only after the patch
is merged to Linus' tree.  I assumed the workflow is triggered by
the patch email itself.

Thanks for explaining!

