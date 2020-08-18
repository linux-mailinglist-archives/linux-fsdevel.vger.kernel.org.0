Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BBB2482C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 12:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgHRKSE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 06:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgHRKSB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:18:01 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A07C061343
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 03:17:59 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w9so14676050qts.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 03:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m1d0Rse+qIi8qOmerhrf+MBXKELTuAtcs3p/xFrqf9w=;
        b=s4u3GuRFjGb61CKAXSbV1lMqnOMke9WVYpJMh0BBQqdPfrVKbnnOMGI9JvyBbgPm6e
         x6rVvOlI1ANNxy8+m3bcc1IECDj2KsJGcWVy2WR+CvANx/bwNtWdEoEKDgNVzfp3pHop
         hA9rOJBnJ6hFK8QUbuzjs02965lEQZmkx0qyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m1d0Rse+qIi8qOmerhrf+MBXKELTuAtcs3p/xFrqf9w=;
        b=r6OaIJGDbjbnESxOnfMkSsu8A/1QXB2DLq/RVMTJmhJ4pj66zh13D5kuImEqEwrj/C
         X+4PMlF/8nBxFCY4bRXwlZvb7LIuc+zncW/hmhqRTOmIOb703RJzZNvj8tnURoqLOJQt
         4YtmFNQ7F5z6dvEsLTHjOt6YCFUgKEdz1oHDFR3P2V87c7kBWRcP/Fx4bykdBmqDuhKf
         u0q8V6cvs5Igv5pGRX7QIs4OARdjM8gDdzFxIYttZWd535rvwBuqkYWRrpDTjkGGZ6eh
         OHEG82fyLgRO/PWwKDM7xILYY3iYOyo7rpHkgoyUnveGHoDHbLG/F59O0OASgQK+1AGV
         eQ4g==
X-Gm-Message-State: AOAM531DzqN3ML8qIzjNfUk8fuquNgC6RP3UdMJ4b+8bxHc604gUXLPR
        rSv35LJmNiLT5iVyNPVnUDj22w==
X-Google-Smtp-Source: ABdhPJwu2U26qaTDnNyVaIc78vhIlLEidrEGudHY3cyjqUjwF2jv5oW0015yCO0u1NOmZFEU8PeD0g==
X-Received: by 2002:ac8:65c2:: with SMTP id t2mr16990912qto.370.1597745878056;
        Tue, 18 Aug 2020 03:17:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:179c])
        by smtp.gmail.com with ESMTPSA id w1sm20614419qkj.90.2020.08.18.03.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 03:17:57 -0700 (PDT)
Date:   Tue, 18 Aug 2020 11:17:56 +0100
From:   Chris Down <chris@chrisdown.name>
To:     peterz@infradead.org
Cc:     Michal Hocko <mhocko@suse.com>, Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/8] memcg: Enable fine-grained per process memory
 control
Message-ID: <20200818101756.GA155582@chrisdown.name>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092617.GN28270@dhcp22.suse.cz>
 <20200818095910.GM2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200818095910.GM2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

peterz@infradead.org writes:
>But then how can it run-away like Waiman suggested?

Probably because he's not running with that commit at all. We and others use 
this to prevent runaway allocation on a huge range of production and desktop 
use cases and it works just fine.

>/me goes look... and finds MEMCG_MAX_HIGH_DELAY_JIFFIES.
>
>That's a fail... :-(

I'd ask that you understand a bit more about the tradeoffs and intentions of 
the patch before rushing in to declare its failure, considering it works just 
fine :-)

Clamping the maximal time allows the application to take some action to 
remediate the situation, while still being slowed down significantly. 2 seconds 
per allocation batch is still absolutely plenty for any use case I've come 
across. If you have evidence it isn't, then present that instead of vague 
notions of "wrongness".
