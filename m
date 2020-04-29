Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4A61BE005
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 16:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgD2OEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 10:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728132AbgD2OED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:04:03 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1BDC03C1AD;
        Wed, 29 Apr 2020 07:04:02 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z90so1859466qtd.10;
        Wed, 29 Apr 2020 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OPeUScr2vL9/Zkz5n3yjWKmeXq3NwFtTvKkYOvdwcJg=;
        b=LTCggxC9MXNyozRB6RCYBO8Lbp0lLeLTySbNpJQhtIFbSYraYm25VdWaDJlMpN3BN2
         CqzhR0a16L40HQr0KYxb4JN+MGOqhjvgX63E5A4tba8gwwlnFCg1squLu7pJJkT81JWG
         qy65myRgm6O+M918NRgjLhXBFp1/UCw1HGPZkkr3KG+mo3ph1CaD3QlOXne8wjvvQ/9k
         puyVBe991Mmpaa/0UmjaPTufO8PNOhVyp9hX8hEcwcLb8O//uXvqVh5LSgNgfYdLViA1
         c8eWv1keMyVgk8dLGVIKDN4EvyeFnOZ+2lsrAMpgrO4Pq6AVuf7TOPbrfaPrSXJyPgOw
         gkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OPeUScr2vL9/Zkz5n3yjWKmeXq3NwFtTvKkYOvdwcJg=;
        b=c2P+TnGRaZfTY3z5Xo6CmrkT3YOsvedsw7uITekQLbxP9VobPZpee6YKsl5pRobp4L
         atNDw3LoFps5ekXUHIDUIVyo4pvykoPyLKgCr/4NUN37kVxyZW64zfK0hhIcby+S8HAJ
         FlpArlYqWAod7kPf3rB0vP1nrO8QDtm5Z6WCkojmhh1KlBjUDv1bYfkepL5j2UauwSvP
         boN22AHY/JmWG6ve3jrh8vEjh+orbo5XbOem028fnnPpNVtjPb6A2NOOzg2sG0kPQ7XB
         f2h5OEk4Q1js4TPBI8Z9YmXfbjpog5PYpjysJViZUj0sd1lz0KkS7iJFPwbVIilRBRVg
         wluQ==
X-Gm-Message-State: AGi0PuapLFDzyUqh9KJ12wh4764oqwdUOTi/yDntnDHZdeqbK5PYQPr/
        Tbv/VQQjsaw2YUSY47bfTd0=
X-Google-Smtp-Source: APiQypJyqJaXIDnsm/YAulJYEip+0qmiilCCcy1yOWUQP+L+XgAtkDC94qJjHwuYbiR6+7ZAJ/BCwg==
X-Received: by 2002:ac8:71d8:: with SMTP id i24mr34585392qtp.223.1588169041381;
        Wed, 29 Apr 2020 07:04:01 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN ([2620:10d:c091:480::1:14f1])
        by smtp.gmail.com with ESMTPSA id b10sm12609955qkl.19.2020.04.29.07.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:04:00 -0700 (PDT)
Date:   Wed, 29 Apr 2020 10:03:57 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
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
Message-ID: <20200429140357.GB18499@dschatzberg-fedora-PC0Y6AEN>
References: <20200428161355.6377-1-schatzberg.dan@gmail.com>
 <20200428214653.GD2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428214653.GD2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 07:47:34AM +1000, Dave Chinner wrote:
> On Tue, Apr 28, 2020 at 12:13:46PM -0400, Dan Schatzberg wrote:
> > The loop device runs all i/o to the backing file on a separate kworker
> > thread which results in all i/o being charged to the root cgroup. This
> > allows a loop device to be used to trivially bypass resource limits
> > and other policy. This patch series fixes this gap in accounting.
> 
> How is this specific to the loop device? Isn't every block device
> that offloads work to a kthread or single worker thread susceptible
> to the same "exploit"?

I believe this is fairly loop device specific. The issue is that the
loop driver issues I/O by re-entering the VFS layer (resulting in
tmpfs like in my example or entering the block layer). Normally, I/O
through the VFS layer is accounted for and controlled (e.g. you can
OOM if writing to tmpfs, or get throttled by the I/O controller) but
the loop device completely side-steps the accounting.

> 
> Or is the problem simply that the loop worker thread is simply not
> taking the IO's associated cgroup and submitting the IO with that
> cgroup associated with it? That seems kinda simple to fix....
> 
> > Naively charging cgroups could result in priority inversions through
> > the single kworker thread in the case where multiple cgroups are
> > reading/writing to the same loop device.
> 
> And that's where all the complexity and serialisation comes from,
> right?
> 
> So, again: how is this unique to the loop device? Other block
> devices also offload IO to kthreads to do blocking work and IO
> submission to lower layers. Hence this seems to me like a generic
> "block device does IO submission from different task" issue that
> should be handled by generic infrastructure and not need to be
> reimplemented multiple times in every block device driver that
> offloads work to other threads...

I'm not familiar with other block device drivers that behave like
this. Could you point me at a few?

> 
> > This patch series does some
> > minor modification to the loop driver so that each cgroup can make
> > forward progress independently to avoid this inversion.
> > 
> > With this patch series applied, the above script triggers OOM kills
> > when writing through the loop device as expected.
> 
> NACK!
> 
> The IO that is disallowed should fail with ENOMEM or some similar
> error, not trigger an OOM kill that shoots some innocent bystander
> in the head. That's worse than using BUG() to report errors...

The OOM behavior is due to cgroup limit. It mirrors the behavior one
sees when writing to a too-large tmpfs.
