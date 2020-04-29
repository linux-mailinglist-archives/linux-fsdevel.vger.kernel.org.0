Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDC81BE0BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 16:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgD2OWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 10:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726815AbgD2OWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:22:34 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5722CC03C1AD;
        Wed, 29 Apr 2020 07:22:34 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 71so1903053qtc.12;
        Wed, 29 Apr 2020 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U7CYd6LIahwn6A9pI4DbAiS85+k2nqU8qqxir3NJPME=;
        b=PeLTcvnmSUGReSfTmkROy81aqLORMcNPoEzmktkHawEeaPG9HbIpOgkxRx5xsqTpQN
         9WOnAOZe+xH0FileYYcNrelmGXfu6azM0W+0j00Gqz4DY4IH06QvwINlT5pc+HSxL/pK
         tL9rAA6decLe+wa6vxDWO8g3zqtmubZwuiwPEoUptoWJA3+7KoA+MkgAtnVVhQJUM9DY
         wpTIQHbFB4U9kPA+rHftrWb7uGODB+OAnl59MfqEMDVGQdAPHEeoDvi1SxtdIuuy/avM
         iKMnjfgO8zhSUvKYO2UoRaNkEWLAgHOzWvKrcLOGJ2S3I72q5M8zGXeI3EwZ/vf7SFyv
         ke6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=U7CYd6LIahwn6A9pI4DbAiS85+k2nqU8qqxir3NJPME=;
        b=pz8c+ueXzkm0kVVWlQ3FrKOwLpdjn9fUlqCCCr0Gkwcp+KlUDrvW4RmmIGe6P/M8UQ
         tuyP2gLeomVovOhMhPnCm/cYUavKUyqV4cWrsWJomlOQWF6qvtLeSdAW6USv0olxjYHY
         g1HUHBclr4Ki2n3KjarTD68JQ/+2hIL8ipbyXy0sWwE92FUaH3p2m99ReVI08CHWPPxW
         m0g8WhEhNPrt65Rf1MMCZHhBQBigmiFhj3D8J+Ig+TkgnxzxZEppfOvB/ZbHBRiwHCVl
         TzXUHUzXrQLFVmayR10jrAcCq6URFkr9Oif0YNHsnqBPQSVwlRW9lAKHUYpPw3oNZvpX
         Ft6g==
X-Gm-Message-State: AGi0PuYUNd8l2xqutaCGfe/jkQfSEsMPrRtMoGdEoIPAg3+vXamDlemB
        leoMgliPe7OsEWqXUk5ngVA=
X-Google-Smtp-Source: APiQypJMW/FRQ0KNbQV06MDhEGIzJ6AnlD4J81Wkyk6TKWOsnJQLVg0yLyYny/w1ZGbIKtk1MV4xIA==
X-Received: by 2002:aed:3ac8:: with SMTP id o66mr34282726qte.110.1588170153191;
        Wed, 29 Apr 2020 07:22:33 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id n13sm16521816qtf.15.2020.04.29.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:22:32 -0700 (PDT)
Date:   Wed, 29 Apr 2020 10:22:30 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v5 0/4] Charge loop device i/o to issuing cgroup
Message-ID: <20200429142230.GE5462@mtj.thefacebook.com>
References: <20200428161355.6377-1-schatzberg.dan@gmail.com>
 <20200428214653.GD2005@dread.disaster.area>
 <20200429102540.GA12716@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429102540.GA12716@quack2.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Wed, Apr 29, 2020 at 12:25:40PM +0200, Jan Kara wrote:
> Yeah, I was thinking about the same when reading the patch series
> description. We already have some cgroup workarounds for btrfs kthreads if
> I remember correctly, we have cgroup handling for flush workers, now we are
> adding cgroup handling for loopback device workers, and soon I'd expect
> someone comes with a need for DM/MD worker processes and IMHO it's getting
> out of hands because the complexity spreads through the kernel with every
> subsystem comming with slightly different solution to the problem and also
> the number of kthreads gets multiplied by the number of cgroups. So I
> agree some generic solution how to approach IO throttling of kthreads /
> workers would be desirable.
> 
> OTOH I don't have a great idea how the generic infrastructure should look
> like...

I don't really see a way around that. The only generic solution would be
letting all IOs through as root and handle everything through backcharging,
which we already can do as backcharging is already in use to handle metadata
updates which can't be controlled directly. However, doing that for all IOs
would make the control quality a lot worse as all control would be based on
first incurring deficit and then try to punish the issuer after the fact.

The infrastructure work done to make IO control work for btrfs is generic
and the changes needed on btrfs side was pretty small. Most of the work was
identifying non-regular IO pathways (bouncing through different kthreads and
whatnot) and making sure they're annotating IO ownership and the needed
mechanism correctly. The biggest challenge probably is ensuring that the
filesystem doesn't add ordering dependency between separate data IOs, which
is a nice property to have with or without cgroup support.

That leaves the nesting drivers, loop and md/dm. Given that they sit in the
middle of IO stack and proxy a lot of its roles, they'll have to be updated
to be transparent in terms of cgroup ownership if IO control is gonna work
through them. Maybe we can have a common infra shared between loop, dm and
md but they aren't many and may also be sufficiently different. idk

Thanks.

-- 
tejun
