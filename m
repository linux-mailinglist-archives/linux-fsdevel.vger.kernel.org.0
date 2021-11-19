Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8318457950
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Nov 2021 00:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbhKSXLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 18:11:13 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:46712 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234515AbhKSXLN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 18:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1637363290;
        bh=laxDKxmG+P97wO7dtGHj+3jiOfUeKS0Sn2sT1b7ShXc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=v/KNMjzPZToYdSq6Qudjqu60hXcUBlQdtSCE59nfxb4a+uLsT+IwwytrBV9fDwBnl
         oO5fQi29ydnMW8B08V6QiHGifiU1A27fSMBFDLIHVbchf8yG2SHhPcdqSdF4/GHzly
         JLViMwja6ECLOnB1BEoS3hZ19aD0BgdHuryzTgGg=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A63261280D24;
        Fri, 19 Nov 2021 18:08:10 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3c7umqUnNlQ9; Fri, 19 Nov 2021 18:08:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1637363290;
        bh=laxDKxmG+P97wO7dtGHj+3jiOfUeKS0Sn2sT1b7ShXc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=v/KNMjzPZToYdSq6Qudjqu60hXcUBlQdtSCE59nfxb4a+uLsT+IwwytrBV9fDwBnl
         oO5fQi29ydnMW8B08V6QiHGifiU1A27fSMBFDLIHVbchf8yG2SHhPcdqSdF4/GHzly
         JLViMwja6ECLOnB1BEoS3hZ19aD0BgdHuryzTgGg=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4B1151280D14;
        Fri, 19 Nov 2021 18:08:09 -0500 (EST)
Message-ID: <cc6783315193be5acb0e2e478e2827d1ad76ba2a.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, akpm@linux-foundation.org, vvs@virtuozzo.com,
        shakeelb@google.com, christian.brauner@ubuntu.com,
        mkoutny@suse.com, Linux Containers <containers@lists.linux.dev>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri, 19 Nov 2021 18:08:08 -0500
In-Reply-To: <20211119114910.177c80d6@gandalf.local.home>
References: <20211118181210.281359-1-y.karadz@gmail.com>
         <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
         <20211118142440.31da20b3@gandalf.local.home>
         <1349346e1d5daca991724603d1495ec311cac058.camel@HansenPartnership.com>
         <20211119092758.1012073e@gandalf.local.home>
         <f6ca1f5bdb3b516688f291d9685a6a59f49f1393.camel@HansenPartnership.com>
         <20211119114736.5d9dcf6c@gandalf.local.home>
         <20211119114910.177c80d6@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[trying to reconstruct cc list, since the cc: field is bust again]
> On Fri, 19 Nov 2021 11:47:36 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > Can we back up and ask what problem you're trying to solve before
> > > we start introducing new objects like namespace name?
> 
> TL;DR; verison:
> 
> We want to be able to install a container on a machine that will let
> us view all namespaces currently defined on that machine and which
> tasks are associated with them.
> 
> That's basically it.

So you mentioned kubernetes.  Have you tried

kubectl get pods --all-namespaces

?

The point is that orchestration systems usually have interfaces to get
this information, even if the kernel doesn't.  In fact, userspace is
almost certainly the best place to construct this from.

To look at this another way, what if you were simply proposing the
exact same thing but for the process tree.  The push back would be that
we can get that all in userspace and there's even a nice tool (pstree)
to do it which simply walks the /proc interface.  Why, then, do we have
to do nstree in the kernel when we can get all the information in
exactly the same way (walking the process tree)?

James



