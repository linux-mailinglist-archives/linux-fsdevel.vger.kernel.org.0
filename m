Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE471C5B9E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 17:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgEEPik (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 11:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729276AbgEEPij (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 11:38:39 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36230C061A0F;
        Tue,  5 May 2020 08:38:39 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id fb4so1198841qvb.7;
        Tue, 05 May 2020 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BXdArichtJxJSpMdJATI60C/n/3lvsy1fL/KOG1aR0o=;
        b=Qgxse7dVakSkufrx/Jt+udb+ymexH65VUMnEUWLtLKEfqRpwkmZlz5vI4O25vYATuy
         VVaC5aOnEDpNMe0z4vb1MBK8RuTdKfE1z+9MXMsUa8Z7ppPI9jeLSH+Y8Hs6hSeLIt7Z
         XdQeFLLxaDYlVJjnLRQT2fRAPqAx2+GxrlAFS5lYDNwWv5TZOo8aje30hyhqww7q5VgE
         hFxkjqHOBiRON9nOAlxbQxTz+54tsN16QGn69GNDWSv9wEK3DmoNTZSaJqVrx9A7Mk8y
         00VmVkyFxFDtx76koAUjHf4CeJ1KqeHm5lGGRIjrmR90TSFZ8z6JZKNkLs+fowxAlB76
         0AAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BXdArichtJxJSpMdJATI60C/n/3lvsy1fL/KOG1aR0o=;
        b=uB/V30Cj7YoQf1AEnOguVgXUGjpsszGm5LVJ3F7+IN8zbdibi2WVeP9e9444Rd2pH0
         ro8VB/suqlKhXvsR1ykUuDSWDP0HjJFLStniprmmBcsyY0IYtOA2ehnq5/snr775W7bY
         J6nvr2WhH42k/3ka3LwPlYm4a1q52M7oycaRAcU+mSYghClHun5d8KVDwmMOkDraWdlB
         ka/PwO6y9bAFJhMFC5PcFfIWvN6F74Z5DrevXJcu0MrR+lrFJMAZ2X5WY1n15kcVaz5x
         8qXGAr4gqIf1xlv0UqeJQxdDtd+NwL5picZPxzNp8WV8MVBDK96APRkVX6gO+aNcyoYx
         n74g==
X-Gm-Message-State: AGi0PuayvpkTS0FEa5hpe3eIl1x6rKOnVnDNZkejbr9lvYYSBOf9tu7Y
        BkpN1Zf5Yu5bXPiFPiApBDs=
X-Google-Smtp-Source: APiQypIPmFzcysooPjiBb3SJnZHAzyV6pGruCekUBQbAVqyGjNBnCjfYXl4LmSQBc0QeZ7N4HNPQQA==
X-Received: by 2002:ad4:434a:: with SMTP id q10mr3378243qvs.81.1588693118118;
        Tue, 05 May 2020 08:38:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:5ece])
        by smtp.gmail.com with ESMTPSA id q62sm2071319qke.22.2020.05.05.08.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 08:38:37 -0700 (PDT)
Date:   Tue, 5 May 2020 11:38:34 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Dan Schatzberg <schatzberg.dan@gmail.com>,
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
Message-ID: <20200505153834.GA12217@mtj.thefacebook.com>
References: <20200428161355.6377-1-schatzberg.dan@gmail.com>
 <20200428214653.GD2005@dread.disaster.area>
 <20200429102540.GA12716@quack2.suse.cz>
 <20200505064114.GI2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505064114.GI2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Dave.

On Tue, May 05, 2020 at 04:41:14PM +1000, Dave Chinner wrote:
> > OTOH I don't have a great idea how the generic infrastructure should look
> > like...
> 
> I haven't given it any thought - it's not something I have any
> bandwidth to spend time on.  I'll happily review a unified
> generic cgroup-aware kthread-based IO dispatch mechanism, but I
> don't have the time to design and implement that myself....
> 
> OTOH, I will make time to stop people screwing up filesystems and
> block devices with questionable complexity and unique, storage
> device dependent userspace visible error behaviour. This sort of
> change is objectively worse for users than not supporting the
> functionality in the first place.

That probably is too strong a position to hold without spending at least
some thoughts on a subject, whatever the subject may be, and it doesn't seem
like your understanding of userspace implications is accurate.

I don't necessarily disagree that it'd be nice to have a common
infrastructure and there may be some part which can actually be factored
out. However, there isn't gonna be a magic bullet which magically makes
every IO thing in the kernel cgroup aware automatically. Please consider the
followings.

* Avoding IO priority inversions requires splitting IO channels according to
  cgroups and working around (e.g. with backcharging) when they can't be.
  It's a substantial feature which may require substantial changes. Each IO
  subsystem has different constraints and existing structures and many of
  them would require their own solutions. It's not different from different
  filesystems needing their own solutions for similar problems.

* Because different filesystems and IO stacking layers already have their
  own internal infrastructure, the right way to add cgroup support is
  adapting to and modifying the existing infrastructure rather than trying
  to restructure them to use the same cgroup mechanism, which I don't think
  would be possible in many cases.

* Among the three IO stacking / redirecting mechanisms - md/dm, loop and
  fuse - the requirements and what's possible vary quite a bit. md/dm
  definitely need to support full-on IO channel splitting cgroup support.
  loop can go either way, but given existing uses, full splitting makes a
  sense. fuse, as it currently stands, can't support that because the
  priority inversions extend all the way to userspace and the kernel API
  isn't built for that. If it wants to support cgroup containment, each
  instance would have to be assigned to a cgroup.

Between dm/md and loop, it's maybe possible that some of the sub-threading
code can be reused, but I don't see a point in blocking loop updates given
that it clearly fixes userspace visible malfunctions, is not that much code
and how the shared code should look is unclear yet. We'll be able to answer
the sharing question when we actually get to dm/md conversion.

Thanks.

-- 
tejun
