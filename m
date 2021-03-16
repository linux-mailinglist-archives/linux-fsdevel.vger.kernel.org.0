Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAEE33DD25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbhCPTIS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240309AbhCPTIF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:08:05 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D47C061756
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:08:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so11881pjb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8AoKzKPSw2tvyexd5NcXY+l1zYIQb/v5kLzQvhcVl08=;
        b=hp0QAMcH2/+hAfF/v1msV9oc8S1hs4aD8wPtqsPN7CylkDbiC2m1t4yKCOjfkK0mT1
         FH1k7n42emJvCQMg1E9+DdPPp7Jr8+UmkHBy5HPI7dHQP0de8TCmIAmALPbozA+obtPG
         GNhpP5Hyv66XRv0RRDMyxY15UjtX3yzT9CtmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8AoKzKPSw2tvyexd5NcXY+l1zYIQb/v5kLzQvhcVl08=;
        b=SZuVFfp/hYg5krOdIoa371RAM/WTepf6ri1NxHe67+E1yhY6IErU3NWevAvPwbInkZ
         eisu0v5mmL3YctcCBuK1eY26GOIcXRh8rRkXAQ/ganR6f3ch0Cd05+yvP5mX1zJ5MpgJ
         DRO5aT0SIt/i/aPpTwzq/fpigElVQ0lcm8IgmLqHNpAPXTYRqvSXq044hojbYyERWWxN
         mqdeTK4cN4azPUWPuK4ALZ6tEMdYnwjuzsObwwJijQ64maR4aqaMWwftzynt3gO7Z9i6
         xYbHJa2FHEWYkDH7dfw4pgit0BfE6vphejGgnT675v2Kbl6rKUBqB0HVzwMpvaBQ8Y1F
         AI2A==
X-Gm-Message-State: AOAM533FFMMGxrxUow7z8mqXDhQN50Z2jQO5upLt7UYPMQwZ2t6zRD+7
        MR4RdsgXO2Qv4nbDhJG9IJInSQ==
X-Google-Smtp-Source: ABdhPJwgNNfhDgUxxbbcJYMpgOpJMkOQakG4DPMXgYCnO/0AdsbjMLkkKC7Uuv2O2Z+6Y5Z6LdNrsw==
X-Received: by 2002:a17:902:c382:b029:e4:7015:b646 with SMTP id g2-20020a170902c382b02900e47015b646mr922259plg.83.1615921684270;
        Tue, 16 Mar 2021 12:08:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v126sm17079279pfv.163.2021.03.16.12.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:08:03 -0700 (PDT)
Date:   Tue, 16 Mar 2021 12:08:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <202103161205.B2181BDE38@keescook>
References: <20210315174851.622228-1-keescook@chromium.org>
 <YFBs202BqG9uqify@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFBs202BqG9uqify@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 09:31:23AM +0100, Michal Hocko wrote:
> On Mon 15-03-21 10:48:51, Kees Cook wrote:
> > The sysfs interface to seq_file continues to be rather fragile, as seen
> > with some recent exploits[1]. Move the seq_file buffer to the vmap area
> > (while retaining the accounting flag), since it has guard pages that
> > will catch and stop linear overflows. This seems justified given that
> > seq_file already uses kvmalloc(), is almost always using a PAGE_SIZE or
> > larger allocation, has allocations are normally short lived, and is not
> > normally on a performance critical path.
> 
> I have already objected without having my concerns really addressed.

Sorry, I didn't mean to ignore your comments!

> Your observation that most of buffers are PAGE_SIZE in the vast majority
> cases matches my experience and kmalloc should perform better than
> vmalloc. You should check the most common /proc readers at least.

Yeah, I'm going to build a quick test rig to see some before/after
timings, etc.

> Also this cannot really be done for configurations with a very limited
> vmalloc space (32b for example). Those systems are more and more rare
> but you shouldn't really allow userspace to deplete the vmalloc space.

This sounds like two objections:
- 32b has a small vmalloc space
- userspace shouldn't allow depletion of vmalloc space

I'd be happy to make this 64b only. For the latter, I would imagine
there are other vmalloc-exposed-to-userspace cases, but yes, this would
be much more direct. Is that a problem in practice?

> I would be also curious to see how vmalloc scales with huge number of
> single page allocations which would be easy to trigger with this patch.

Right -- what the best way to measure this (and what would be "too
much")?

-- 
Kees Cook
