Return-Path: <linux-fsdevel+bounces-5393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A753F80B14B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 02:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79AD1C20CBC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 01:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5F1EA1;
	Sat,  9 Dec 2023 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="I2VUz/Sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6291723;
	Fri,  8 Dec 2023 17:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702084264; x=1733620264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=68RgYT2Q6oe2CyzNj6cVl218qzpdZJW9YHDhZxnIURQ=;
  b=I2VUz/SwAWzvz5T3g5rYhC9pZ5sDvq9oqq05q7JFJydNTncKjwmuMorU
   1RI3yR4BKBsVPATaf7gSX/NbwscAdF0u/7+oPsVqLlv+EeGmdYTZ9J3Ag
   YbpSLZkhj08q1KHxAZbCOBSPlWon6ZToTMRtzvf/viwBBplAcQ7sRCSJr
   8=;
X-IronPort-AV: E=Sophos;i="6.04,262,1695686400"; 
   d="scan'208";a="381761548"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 01:11:03 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com (Postfix) with ESMTPS id 675188068A;
	Sat,  9 Dec 2023 01:11:00 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:52528]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.107:2525] with esmtp (Farcaster)
 id 8b02ef78-1627-4a11-b65e-f3abc98ba89e; Sat, 9 Dec 2023 01:10:59 +0000 (UTC)
X-Farcaster-Flow-ID: 8b02ef78-1627-4a11-b65e-f3abc98ba89e
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 9 Dec 2023 01:10:53 +0000
Received: from dev-dsk-kamatam-2b-b66a5860.us-west-2.amazon.com (10.169.6.191)
 by EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 9 Dec 2023 01:10:53 +0000
From: Munehisa Kamata <kamatam@amazon.com>
To: <casey@schaufler-ca.com>, <paul@paul-moore.com>
CC: <adobriyan@gmail.com>, <akpm@linux-foundation.org>, <kamatam@amazon.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security attribute
Date: Sat, 9 Dec 2023 01:10:42 +0000
Message-ID: <20231209011042.29059-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7ba17c0d-49c6-4322-b196-3ecb7a371c62@schaufler-ca.com>
References: <7ba17c0d-49c6-4322-b196-3ecb7a371c62@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)

On Sat, 2023-12-09 00:24:42 +0000, Casey Schaufler wrote:
>
> On 12/8/2023 3:32 PM, Paul Moore wrote:
> > On Fri, Dec 8, 2023 at 6:21 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 12/8/2023 2:43 PM, Paul Moore wrote:
> >>> On Thu, Dec 7, 2023 at 9:14 PM Munehisa Kamata <kamatam@amazon.com> wrote:
> >>>> On Tue, 2023-12-05 14:21:51 -0800, Paul Moore wrote:
> >>> ..
> >>>
> >>>>> I think my thoughts are neatly summarized by Andrew's "yuk!" comment
> >>>>> at the top.  However, before we go too much further on this, can we
> >>>>> get clarification that Casey was able to reproduce this on a stock
> >>>>> upstream kernel?  Last I read in the other thread Casey wasn't seeing
> >>>>> this problem on Linux v6.5.
> >>>>>
> >>>>> However, for the moment I'm going to assume this is a real problem, is
> >>>>> there some reason why the existing pid_revalidate() code is not being
> >>>>> called in the bind mount case?  From what I can see in the original
> >>>>> problem report, the path walk seems to work okay when the file is
> >>>>> accessed directly from /proc, but fails when done on the bind mount.
> >>>>> Is there some problem with revalidating dentrys on bind mounts?
> >>>> Hi Paul,
> >>>>
> >>>> https://lkml.kernel.org/linux-fsdevel/20090608201745.GO8633@ZenIV.linux.org.uk/
> >>>>
> >>>> After reading this thread, I have doubt about solving this in VFS.
> >>>> Honestly, however, I'm not sure if it's entirely relevant today.
> >>> Have you tried simply mounting proc a second time instead of using a bind mount?
> >>>
> >>>  % mount -t proc non /new/location/for/proc
> >>>
> >>> I ask because from your description it appears that proc does the
> >>> right thing with respect to revalidation, it only becomes an issue
> >>> when accessing proc through a bind mount.  Or did I misunderstand the
> >>> problem?
> >> It's not hard to make the problem go away by performing some simple
> >> action. I was unable to reproduce the problem initially because I
> >> checked the Smack label on the bind mounted proc entry before doing
> >> the cat of it. The problem shows up if nothing happens to update the
> >> inode.
> > A good point.
> >
> > I'm kinda thinking we just leave things as-is, especially since the
> > proposed fix isn't something anyone is really excited about.
> 
> "We have to compromise the performance of our sandboxing tool because of
> a kernel bug that's known and for which a fix is available."
> 
> If this were just a curiosity that wasn't affecting real development I
> might agree. But we've got a real world problem, and I don't see ignoring
> it as a good approach. I can't see maintainers of other LSMs thinking so
> if this were interfering with their users.
 
We do bind mount to make information exposed to the sandboxed task as little
as possible. We also create a separate PID namespace for each sandbox, but
still want to bind mount even with it to hide system-wide and pid 1
information from the task. 

So, yeah, I see this as a real problem for our use case and want to seek an
opinion about a possibly better fix.


Thanks,
Munehisa 

