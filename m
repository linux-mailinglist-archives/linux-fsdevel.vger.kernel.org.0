Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD0172382F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 08:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbjFFGvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 02:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjFFGvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:51:45 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD49018E
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 23:51:43 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso5243542a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jun 2023 23:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686034303; x=1688626303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzrUn3TJn9oHZTuuml4d9wxIwzfuVemXzrEhOgGgfqc=;
        b=Mol2lFfO3T5qt9ASa5cDKUGoDR391wKygoARbFbUOt06c38QAlReGPGuhhdywFHin+
         ye9WDTddzUqRpVTLEinDAx6UNqTHEaIrT8SLnNxGYiXkp/CBNYxMV0z/PDMX+1j5U3Jd
         WxwFYOsx8ce70hx4WC8WefuW6A5LqsRrlsQ9PPVWMe5ODehqdXe2Jj5Ef2gipg/Ob5P2
         v26JxTIdLG1DyfdXner2agtMonw6uWNulLZaEtr+b7yOG72BhrDD8wBjWcym0KhriKiG
         sp98K5E8yYiUS3P2h5aBHr3+yVz/l/cQzyDhbHJYzbnxsdc94+6W1CHdGy3yrVdEV+ba
         qpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686034303; x=1688626303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzrUn3TJn9oHZTuuml4d9wxIwzfuVemXzrEhOgGgfqc=;
        b=lVfMlstYVgSCW8PeO1PFVfsC3JeRraCZmkfmsaORkHt7qkzmA5DNqsOn9XpwykZTHJ
         CUi6L5q6DhltaZcwdhFWy/72lM0Pr6IS/Peg0ZF66o8e5fsn3y9WLx16OcizVy/2+BTB
         5bP+7Iuf2NfQHEV7vY0WouwZ8zXE/ITvLl49sy568jdmCcL/Gw9weLHlmafWPUtyXCgP
         +sOQqjFzrnEOF1efrqkK98eazXR04AH4iiNmfj/soq64sU3wm284ZPyiTRH6Sk5vZQ8f
         k2H4EbbIp+t+Sr3s732R/b3tSlHRWA10VzuRZTisS4R7QL0l2ov87xZm+aN+sk1HaPRp
         NKCg==
X-Gm-Message-State: AC+VfDxgnVJey0N8wfzLePu9Pyv5ZmVsbHd9za8yFB2Qs9gut3KhuaWB
        aLEsxjBwywD4BeJXRObQkzvEhA==
X-Google-Smtp-Source: ACHHUZ7x3NSPqUc0MTztC3yNbXyqO3LPo4HDdDohroIB2GxY1bF8kqh0D++Jt31Y34GGHHc8wE6CTg==
X-Received: by 2002:a05:6a21:9986:b0:10f:7e62:3806 with SMTP id ve6-20020a056a21998600b0010f7e623806mr2043000pzb.22.1686034303169;
        Mon, 05 Jun 2023 23:51:43 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id 19-20020a630e53000000b00513973a7014sm6543861pgo.12.2023.06.05.23.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 23:51:42 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q6QXc-008OVH-0F;
        Tue, 06 Jun 2023 16:51:40 +1000
Date:   Tue, 6 Jun 2023 16:51:40 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Kirill Tkhai <tkhai@ya.ru>, akpm@linux-foundation.org,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v2 3/3] fs: Use delayed shrinker unregistration
Message-ID: <ZH7XfD/pBcWzhHcc@dread.disaster.area>
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
 <168599180526.70911.14606767590861123431.stgit@pro.pro>
 <ZH6AA72wOd4HKTKE@P9FQF9L96D>
 <ZH6K0McWBeCjaf16@dread.disaster.area>
 <ZH6ge3yiGAotYRR9@P9FQF9L96D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH6ge3yiGAotYRR9@P9FQF9L96D>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 07:56:59PM -0700, Roman Gushchin wrote:
> On Tue, Jun 06, 2023 at 11:24:32AM +1000, Dave Chinner wrote:
> > On Mon, Jun 05, 2023 at 05:38:27PM -0700, Roman Gushchin wrote:
> > > Isn't it possible to hide it from a user and call the second part from a work
> > > context automatically?
> > 
> > Nope, because it has to be done before the struct shrinker is freed.
> > Those are embedded into other structures rather than being
> > dynamically allocated objects.
> 
> This part we might consider to revisit, if it helps to solve other problems.
> Having an extra memory allocation (or two) per mount-point doesn't look
> that expensive. Again, iff it helps with more important problems.

Ah, I guess if you're concerned about memory allocation overhead
during register_shrinker() calls then you really aren't familiar
with what register_shrinker() does on memcg and numa aware
shrinkers? 

Let's ignore the fact that we could roll the shrinker structure
allocation into the existing shrinker->nr_deferred array allocation
(so it's effectively a zero cost modification), and just look at
what a memcg enabled shrinker must initialise if it expands the
shrinker info array because the index returned from idr_alloc()
is larger than the current array:

	for each memcg {
		for_each_node {
			info = kvmalloc_node();
			rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
		}
	}

Hmmmm?

So, there really isn't any additional cost, it completely decouples
the shrinker infrastructure from the subsystem shrinker
implementations, it enables the shrinker to control infrastructure
teardown independently of the subsystem that registered the
shrinker, and it still gives guarantees that the shrinker is never
run after unregister_shrinker() completes. What's not to like?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
