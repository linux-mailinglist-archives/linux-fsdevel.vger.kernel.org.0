Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39B9354B2F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 05:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhDFDWn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 23:22:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:40992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230364AbhDFDWm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 23:22:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8B77AFF7;
        Tue,  6 Apr 2021 03:22:33 +0000 (UTC)
Date:   Mon, 5 Apr 2021 20:22:26 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     jbaron@akamai.com, rpenyaev@suse.de, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/2] fs/epoll: restore waking from ep_done_scan()
Message-ID: <20210406032226.2fpfzrlyxu2wz2jw@offworld>
References: <20210405231025.33829-1-dave@stgolabs.net>
 <20210405231025.33829-3-dave@stgolabs.net>
 <20210405185018.40d437d392863f743131fcda@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210405185018.40d437d392863f743131fcda@linux-foundation.org>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 05 Apr 2021, Andrew Morton wrote:

>Tricky.  339ddb53d373 was merged in December 2019.  So do we backport
>this fix?  Could any userspace code be depending upon the
>post-339ddb53d373 behavior?

As with previous trouble caused by this commit, I vote for restoring the behavior
backporting the fix, basically the equivalent of adding (which was my intention):

Fixes: 339ddb53d373 ("fs/epoll: remove unnecessary wakeups of nested epoll")

>
>Or do we just leave the post-339ddb53d373 code as-is?  Presumably the
>issue is very rarely encountered, and changeing it back has its own
>risks.

While I also consider this scenario rare (normally new ready events can become
ready and trigger new wakeups), I'm seeing reports in real applications of task
hangs due to this change of semantics. Alternatively, users can update their code
to timeout in such scenarios, but it is ultimately the kernel's fault. Furthermore
it hasn't really been all _that_ long since the commit was merged, so I don't think
it merits a change in behavior.

As for the risks of restoring the behavior, afaict this only fixed a double wakeup
in an obscure nested epoll scenario, so I'm not too worried there sacrificing
performance for functionality. That said, there are fixes, for example 65759097d80
(epoll: call final ep_events_available() check under the lock) that would perhaps
be rendered unnecessary.

Thanks,
Davidlohr
