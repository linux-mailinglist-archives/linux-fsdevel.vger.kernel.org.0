Return-Path: <linux-fsdevel+bounces-45552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4FBA79646
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 22:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8AA37A5016
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 20:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D60A1F09A7;
	Wed,  2 Apr 2025 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cbIJZk4n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E89919CCEC;
	Wed,  2 Apr 2025 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743624589; cv=none; b=beQWdBzUowMXAKGrcSQTz/yqqtKCgz4ZDPLdcvCtPhd6uONn9IENvdn1XLWTPcJhupLBPffXdEeJ5Yh0vQgW1EOZsxUgmoKz9RmvPeC5ZOZTp8ggR5KDDJOV2RsNyvMk4LTCvb5AnGXS+DqBY8dITO38nohtdw6fHt+7itPYXqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743624589; c=relaxed/simple;
	bh=ivLCqn6fTGToftoyRExLPUaf+cLv2vyeXoLLN8P3lqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXfxYvlL0PIOSmMlZE9VNbSIC+tW6Gm3dfsHCvBlD+yLY31aSQl9hSyK8Hy0pfPdgxGXlZS4belPbco3uKfxR+glheOmMr5BSy6NB3eDmDEUsPLP0WYW2iJLFrv2koCcJreg73650kuXhBB5k5s3STxxQKPnNRvYkjYkiNqxjSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cbIJZk4n; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743624587; x=1775160587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G95KGNCXOqN2ZdoOM6HrRr/31MrkehfIMvurjTouN0k=;
  b=cbIJZk4ntUbS5oIQ7G1eJUxWlYUj0wu8aTZC7QonEz14xqNJey5SJDMx
   jwWK4bUJWOgr6L6mkTI236UlcnTAnTF6DQsSzQVpCwmuE5C5MdwK8ZWwK
   9WoCdAHCC4NkogaBIERgZGOgSkYHvAKp8RCSPP3n1zp1xXmm9GMEcBCNf
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,183,1739836800"; 
   d="scan'208";a="812782096"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 20:09:41 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:2205]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.224:2525] with esmtp (Farcaster)
 id 614af337-dd4a-4850-9165-dd168ccf4a23; Wed, 2 Apr 2025 20:09:40 +0000 (UTC)
X-Farcaster-Flow-ID: 614af337-dd4a-4850-9165-dd168ccf4a23
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 20:09:40 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 20:09:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <cve@kernel.org>, <edumazet@google.com>, <ematsumiya@suse.de>,
	<kuniyu@amazon.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
	<sfrench@samba.org>, <smfrench@gmail.com>, <wangzhaolong1@huawei.com>,
	<zhangchangzhong@huawei.com>
Subject: Re: Fwd: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
Date: Wed, 2 Apr 2025 13:09:19 -0700
Message-ID: <20250402200928.4320-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025040248-tummy-smilingly-4240@gregkh>
References: <2025040248-tummy-smilingly-4240@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 2 Apr 2025 16:18:37 +0100
> On Wed, Apr 02, 2025 at 05:15:44PM +0800, Wang Zhaolong wrote:
> > > On Wed, Apr 02, 2025 at 12:49:50PM +0800, Wang Zhaolong wrote:
> > > > Yes, it seems the previous description might not have been entirely clear.
> > > > I need to clearly point out that this patch, intended as the fix for CVE-2024-54680,
> > > > does not actually address any real issues. It also fails to resolve the null pointer
> > > > dereference problem within lockdep. On top of that, it has caused a series of
> > > > subsequent leakage issues.
> > > 
> > > If this cve does not actually fix anything, then we can easily reject
> > > it, please just let us know if that needs to happen here.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > Hi Greg,
> > 
> > Yes, I can confirm that the patch for CVE-2024-54680 (commit e9f2517a3e18)
> > should be rejected. Our analysis shows:
> > 
> > 1. It fails to address the actual null pointer dereference in lockdep
> > 
> > 2. It introduces multiple serious issues:
> >    1. A socket leak vulnerability as documented in bugzilla #219972
> >    2. Network namespace refcount imbalance issues as described in
> >      bugzilla #219792 (which required the follow-up mainline fix
> >      4e7f1644f2ac "smb: client: Fix netns refcount imbalance
> >      causing leaks and use-after-free")
> > 
> > The next thing we should probably do is:
> >    - Reverting e9f2517a3e18
> >    - Reverting the follow-up fix 4e7f1644f2ac, as it's trying to fix
> >      problems introduced by the problematic CVE patch
> 
> Great, can you please send patches now for both of these so we can
> backport them to the stable kernels properly?

Sent to CIFS tree:
https://lore.kernel.org/linux-cifs/20250402200319.2834-1-kuniyu@amazon.com/

Thanks!

