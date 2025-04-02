Return-Path: <linux-fsdevel+bounces-45556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEFBA7966C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 22:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2A93B425A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 20:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E3A1EFFA9;
	Wed,  2 Apr 2025 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sT2tP2dF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757F71917E7;
	Wed,  2 Apr 2025 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743625400; cv=none; b=AYBsGiTsw6fSPNFJTI6d8NmdiDIEkCFM/siE9jKfm6PIDrHHZJQH55I+9SfjY2vBHGcyzdMQo4rdxAgYgE9Mm6H/grDf/C15NA+5IdVqIDgdR0lPgm55BrPUTEoHtPC21U5HKT1KUsnvayEmTQQM92p8oA+1qa7s9V55FLN2VIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743625400; c=relaxed/simple;
	bh=B+O36yg5A5XPoTzoaWJvC8inENWYX8yWdPtFHWC748k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SzcVgw6YAVlXFS1XvFvDM/0FLYKnC1/8L37+ySyWDzs90IiwyjhUlyROTcIJZcPn4EudCyluPJdsdl79a+/DHq0hYvICOwceQn+ZtryQSCAHeEK5vX7hrctWGLvezNPwhBGph3UsQEHLzBb7dpkp01fpf6LsXK4DoKEODVtg5SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sT2tP2dF; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743625399; x=1775161399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ctb6POoyh404vH+KjFkWC9B4g7iEU94Mtl3qduoJtog=;
  b=sT2tP2dF+FbexGa4gIx8owprD4407tD/KG9I07kvSg97uVwynTDnA91T
   K+0XJ89IFhRQjhaOEroLDpAmGpBVDnQrkyRrSpLonePuhPgImb3wMK5o9
   u5DAQDemhtrrLtzLDTpDpLFHiiG4Olal6A/kIue+/pcgwZCmhw3hfmHHZ
   w=;
X-IronPort-AV: E=Sophos;i="6.15,183,1739836800"; 
   d="scan'208";a="476947229"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 20:23:14 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:34346]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.98:2525] with esmtp (Farcaster)
 id 4fa530bb-68b7-4087-a078-61c6eba0c003; Wed, 2 Apr 2025 20:23:14 +0000 (UTC)
X-Farcaster-Flow-ID: 4fa530bb-68b7-4087-a078-61c6eba0c003
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 20:23:08 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 20:23:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <cve@kernel.org>, <edumazet@google.com>, <ematsumiya@suse.de>,
	<kuniyu@amazon.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
	<sfrench@samba.org>, <smfrench@gmail.com>, <wangzhaolong1@huawei.com>,
	<zhangchangzhong@huawei.com>
Subject: Re: Fwd: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
Date: Wed, 2 Apr 2025 13:22:11 -0700
Message-ID: <20250402202257.5845-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025040233-tuesday-regroup-5c66@gregkh>
References: <2025040233-tuesday-regroup-5c66@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 2 Apr 2025 21:15:58 +0100
> On Wed, Apr 02, 2025 at 01:09:19PM -0700, Kuniyuki Iwashima wrote:
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Date: Wed, 2 Apr 2025 16:18:37 +0100
> > > On Wed, Apr 02, 2025 at 05:15:44PM +0800, Wang Zhaolong wrote:
> > > > > On Wed, Apr 02, 2025 at 12:49:50PM +0800, Wang Zhaolong wrote:
> > > > > > Yes, it seems the previous description might not have been entirely clear.
> > > > > > I need to clearly point out that this patch, intended as the fix for CVE-2024-54680,
> > > > > > does not actually address any real issues. It also fails to resolve the null pointer
> > > > > > dereference problem within lockdep. On top of that, it has caused a series of
> > > > > > subsequent leakage issues.
> > > > > 
> > > > > If this cve does not actually fix anything, then we can easily reject
> > > > > it, please just let us know if that needs to happen here.
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > Hi Greg,
> > > > 
> > > > Yes, I can confirm that the patch for CVE-2024-54680 (commit e9f2517a3e18)
> > > > should be rejected. Our analysis shows:
> > > > 
> > > > 1. It fails to address the actual null pointer dereference in lockdep
> > > > 
> > > > 2. It introduces multiple serious issues:
> > > >    1. A socket leak vulnerability as documented in bugzilla #219972
> > > >    2. Network namespace refcount imbalance issues as described in
> > > >      bugzilla #219792 (which required the follow-up mainline fix
> > > >      4e7f1644f2ac "smb: client: Fix netns refcount imbalance
> > > >      causing leaks and use-after-free")
> > > > 
> > > > The next thing we should probably do is:
> > > >    - Reverting e9f2517a3e18
> > > >    - Reverting the follow-up fix 4e7f1644f2ac, as it's trying to fix
> > > >      problems introduced by the problematic CVE patch
> > > 
> > > Great, can you please send patches now for both of these so we can
> > > backport them to the stable kernels properly?
> > 
> > Sent to CIFS tree:
> > https://lore.kernel.org/linux-cifs/20250402200319.2834-1-kuniyu@amazon.com/
> 
> You forgot to add a Cc: stable@ on the patches to ensure that they get
> picked up properly for all stable trees :(

Ah sorry, I did the same with netdev.  netdev patches usually do
not have the tag but are backported fine, maybe netdev local rule ?


> 
> Can you redo them?

Sure, will resend.

Thanks!

