Return-Path: <linux-fsdevel+bounces-5421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE93180B6E8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 23:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91285280DA0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 22:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8561D69D;
	Sat,  9 Dec 2023 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="itxjBt8I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB48B115;
	Sat,  9 Dec 2023 14:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702161901; x=1733697901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PUPg235lKtwtMQjC1znmIosxy5LysPaaOzMOPKkRd4Y=;
  b=itxjBt8I5i6v7OQsP2n6RVdraq8lkgL6hHeDbtUQuwV8a5cc5l+PmIa5
   69MPG3pPdWJsn7SKQGErUYSctg4oBTWhBik999HjRZ/R1zvfMZXGf6IHS
   I/hA0HhT1gZJy7XP5xBOtRiwEr8Df4UjJPQ++/spzicLEt+OmoI/7RDAy
   Y=;
X-IronPort-AV: E=Sophos;i="6.04,264,1695686400"; 
   d="scan'208";a="49636343"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 22:45:01 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id E5B8080685;
	Sat,  9 Dec 2023 22:45:00 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:16546]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.170:2525] with esmtp (Farcaster)
 id 48bc01f5-e469-4f1c-ad62-3eca72d8a0db; Sat, 9 Dec 2023 22:45:00 +0000 (UTC)
X-Farcaster-Flow-ID: 48bc01f5-e469-4f1c-ad62-3eca72d8a0db
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 9 Dec 2023 22:45:00 +0000
Received: from u0acfa43c8cad58.ant.amazon.com (10.187.170.30) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 9 Dec 2023 22:44:59 +0000
From: Munehisa Kamata <kamatam@amazon.com>
To: <casey@schaufler-ca.com>
CC: <adobriyan@gmail.com>, <akpm@linux-foundation.org>, <kamatam@amazon.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<paul@paul-moore.com>
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security attribute
Date: Sat, 9 Dec 2023 14:44:29 -0800
Message-ID: <20231209224429.277628-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5b61d1a4-89a0-4ec3-9832-9cb84552fba7@schaufler-ca.com>
References: <5b61d1a4-89a0-4ec3-9832-9cb84552fba7@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)

On Sat, 2023-12-09 10:35:01 -0800, Casey Schaufler wrote:
>
> On 12/9/2023 10:08 AM, Paul Moore wrote:
> > On Fri, Dec 8, 2023 at 7:24 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 12/8/2023 3:32 PM, Paul Moore wrote:
> >>> On Fri, Dec 8, 2023 at 6:21 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>> On 12/8/2023 2:43 PM, Paul Moore wrote:
> >>>>> On Thu, Dec 7, 2023 at 9:14 PM Munehisa Kamata <kamatam@amazon.com> wrote:
> >>>>>> On Tue, 2023-12-05 14:21:51 -0800, Paul Moore wrote:
> >>>>> ..
> >>>>>
> >>>>>>> I think my thoughts are neatly summarized by Andrew's "yuk!" comment
> >>>>>>> at the top.  However, before we go too much further on this, can we
> >>>>>>> get clarification that Casey was able to reproduce this on a stock
> >>>>>>> upstream kernel?  Last I read in the other thread Casey wasn't seeing
> >>>>>>> this problem on Linux v6.5.
> >>>>>>>
> >>>>>>> However, for the moment I'm going to assume this is a real problem, is
> >>>>>>> there some reason why the existing pid_revalidate() code is not being
> >>>>>>> called in the bind mount case?  From what I can see in the original
> >>>>>>> problem report, the path walk seems to work okay when the file is
> >>>>>>> accessed directly from /proc, but fails when done on the bind mount.
> >>>>>>> Is there some problem with revalidating dentrys on bind mounts?
> >>>>>> Hi Paul,
> >>>>>>
> >>>>>> https://lkml.kernel.org/linux-fsdevel/20090608201745.GO8633@ZenIV.linux.org.uk/
> >>>>>>
> >>>>>> After reading this thread, I have doubt about solving this in VFS.
> >>>>>> Honestly, however, I'm not sure if it's entirely relevant today.
> >>>>> Have you tried simply mounting proc a second time instead of using a bind mount?
> >>>>>
> >>>>>  % mount -t proc non /new/location/for/proc
> >>>>>
> >>>>> I ask because from your description it appears that proc does the
> >>>>> right thing with respect to revalidation, it only becomes an issue
> >>>>> when accessing proc through a bind mount.  Or did I misunderstand the
> >>>>> problem?
> >>>> It's not hard to make the problem go away by performing some simple
> >>>> action. I was unable to reproduce the problem initially because I
> >>>> checked the Smack label on the bind mounted proc entry before doing
> >>>> the cat of it. The problem shows up if nothing happens to update the
> >>>> inode.
> >>> A good point.
> >>>
> >>> I'm kinda thinking we just leave things as-is, especially since the
> >>> proposed fix isn't something anyone is really excited about.
> >> "We have to compromise the performance of our sandboxing tool because of
> >> a kernel bug that's known and for which a fix is available."
> >>
> >> If this were just a curiosity that wasn't affecting real development I
> >> might agree. But we've got a real world problem, and I don't see ignoring
> >> it as a good approach. I can't see maintainers of other LSMs thinking so
> >> if this were interfering with their users.
> > While the reproducer may be written for Smack, there are plenty of
> > indications that this applies to all LSMs and my comments have taken
> > that into account.
> >
> > If you're really that upset, try channeling that outrage into your
> > editor and draft a patch for this that isn't awful.
> 
> We could "just" wait for the lsm_set_self_attr() syscall to land, and
> suggest that it be used instead of the buggy /proc interfaces.
> 
> I would love to propose a patch that's less sucky, but have not come
> up with one. My understanding of VFS internals isn't up to the task,
> I fear.

As an another option, perhaps adding an even stricter hidepid mode in
procfs (and avoid bind mount) could be reasonable?

