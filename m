Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4604A379E3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 06:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhEKEVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 00:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhEKEVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 00:21:15 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571A5C06175F
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 21:20:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p4so15182070pfo.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 21:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=NMrDcvVUEo+HujvVPjWV2EcDsSyNyhVfg9VVJSr3No0=;
        b=jGli3YI5umWvQIidY2apKrgMwCP9TIKRPT3NUKfKFDHsMsWOn88wH6+BghaFg4XkOh
         1wAzUhOJ7r6MXd8XqtFa57xv4Z9KOXsGk7lO3AKZAYvp/579zilnCAbx/oofVMuJwK0a
         gbHE65vk8kJl8ntboSexC0ljylEtPPWFGXR8ZZApldp9AboPO4wa8+gUOoFHE1SBdJSk
         f1DpX9BLmk/qVLANC3Ej1drceXT9rra6vy8yO8kJHLCvS07Tof5F6Hq1XeSvOvj0xzXs
         nyQa5DUpWbgaI3aJuEECLfrcLQ6pl6np3YElRyb3kmkj9hKYWM1DTDZfoBCQz6S3ZPZy
         4pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=NMrDcvVUEo+HujvVPjWV2EcDsSyNyhVfg9VVJSr3No0=;
        b=NXS7nO5tSNlsraNnx7VzkHWkW8cBiBuTkwJHvVv+FGvIsqE8nl9qOiOE1ekYAg0e2B
         S8DK8R4c1uTzpcDnd+87HAomuWnvWyY80r5BA8lFx+w/TDlfnWQ6AmZg9esVOt4A0j+8
         pbH4XXk+pfukHA2fDB6//xfH2gFO9rR3UAaFilKWvL6VzByV6LEqEmH7GHEWPtW/UXKj
         4LvljogW0QPCPwulsAw0/WxWxCBGirCeB7GrwFG07hKQNvH0eFFAIIHaAB9ktRmi14EQ
         IHkSce92zA+STj5x7HH0Y83giHyrp0pBk4XJp1TtVgA7HmX/I2dkFbJNECczqzEO0nHF
         lZiQ==
X-Gm-Message-State: AOAM532deN77cKFj1yl/5ooo6OedCAoP699/q32qu5WikYAUh5+KGPfl
        d4Xty4c4ttyCItm5rGSAf3bQ0w==
X-Google-Smtp-Source: ABdhPJzr2ZvBFl7f7NYeLHZPOcYFlD9ARgxPRHHb8kRKfPBmaiTjRuf/5YfYFGwJ8b/ClPjXG1KZiw==
X-Received: by 2002:a62:1b97:0:b029:24e:44e9:a8c1 with SMTP id b145-20020a621b970000b029024e44e9a8c1mr29201702pfb.19.1620706809625;
        Mon, 10 May 2021 21:20:09 -0700 (PDT)
Received: from [2620:15c:17:3:2a0a:b96a:de1c:f12c] ([2620:15c:17:3:2a0a:b96a:de1c:f12c])
        by smtp.gmail.com with ESMTPSA id v123sm12302620pfb.80.2021.05.10.21.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 21:20:08 -0700 (PDT)
Date:   Mon, 10 May 2021 21:20:08 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     chukaiping <chukaiping@baidu.com>, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, vbabka@suse.cz,
        nigupta@nvidia.com, bhe@redhat.com, khalid.aziz@oracle.com,
        iamjoonsoo.kim@lge.com, mateusznosek0@gmail.com, sh_def@163.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v4] mm/compaction: let proactive compaction order
 configurable
In-Reply-To: <20210509171748.8dbc70ceccc5cc1ae61fe41c@linux-foundation.org>
Message-ID: <bedd6e68-bb9b-2f3b-7aaf-a0877e025a7@google.com>
References: <1619576901-9531-1-git-send-email-chukaiping@baidu.com> <20210509171748.8dbc70ceccc5cc1ae61fe41c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 9 May 2021, Andrew Morton wrote:

> > Currently the proactive compaction order is fixed to
> > COMPACTION_HPAGE_ORDER(9), it's OK in most machines with lots of
> > normal 4KB memory, but it's too high for the machines with small
> > normal memory, for example the machines with most memory configured
> > as 1GB hugetlbfs huge pages. In these machines the max order of
> > free pages is often below 9, and it's always below 9 even with hard
> > compaction. This will lead to proactive compaction be triggered very
> > frequently. In these machines we only care about order of 3 or 4.
> > This patch export the oder to proc and let it configurable
> > by user, and the default value is still COMPACTION_HPAGE_ORDER.
> 
> It would be great to do this automatically?  It's quite simple to see
> when memory is being handed out to hugetlbfs - so can we tune
> proactive_compaction_order in response to this?  That would be far
> better than adding a manual tunable.
> 
> But from having read Khalid's comments, that does sound quite involved.
> Is there some partial solution that we can come up with that will get
> most people out of trouble?
> 
> That being said, this patch is super-super-simple so perhaps we should
> just merge it just to get one person (and hopefully a few more) out of
> trouble.  But on the other hand, once we add a /proc tunable we must
> maintain that tunable for ever (or at least a very long time) even if
> the internal implementations change a lot.
> 

As mentioned in v3 of the patch, I'm not sure why this belongs in the 
kernel at all.

I understand that the system is largely consumed by 1GB gigantic pages and 
that a small percentage of memory is left for native pages.  Thus, 
fragmentation readily occurs and can affect large order allocations even 
at the levels of order-3 or order-4.

So it seems like the ideal solution would be to monitor the fragmentation 
index at the order you care about (the same order you would use for this 
new tunable) and root userspace would manually trigger compaction when 
necessary.  When this was brought up, it was commented that explicitly 
triggered compaction is too expensive to do all in one iteration.  That's 
fair enough, but shouldn't that be an improvement on explicitly triggered 
compaction through sysfs to provide a shorter term (or weaker form) of 
compaction rather than build additional policy decisions into the kernel?

If done this way, there would be a clear separation between mechanism and 
policy and the kernel would not need to carry these sysctls to tune very 
niche areas.
