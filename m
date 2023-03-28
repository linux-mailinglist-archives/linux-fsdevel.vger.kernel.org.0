Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F696CB45D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 04:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjC1Cxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 22:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjC1Cxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:53:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B74A1FF3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 19:53:31 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id r7-20020a17090b050700b002404be7920aso9762264pjz.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 19:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1679972011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lWYTBx2VZ6h71XcB6iH3aK5E1JWkHx/k2gKbXvik2bo=;
        b=N0B1misASakytjT3U6HWfwjK7TnGyvBOU1hSRBFekqJBvXuuYgEgZr3oywZehRUqSY
         r6xJkpQnhBXpoiIERUOnR17ot0i6ekYp7QKoU5b+ny//OXTf/u3IjjLcc3AVUM6IiHnu
         yGpo+pIqcyIV84FL57vU3VmbM4zWQEA93ts7zeVf7tNsIx9g+w8uVmRrcsOUL3BWHO0T
         C3IDOlZ5YYsUx6RRBRbF8qpZ0suvkx+r13FGHA9FHG7SU/Hzil4SxmqAgg/6Hxcudyqw
         awqnfY4yXMNAnzDVermXFJyWwEhGy2bh3B5WNUaKSHGo/nL/va41TlAWwL09K70fwBME
         t1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679972011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWYTBx2VZ6h71XcB6iH3aK5E1JWkHx/k2gKbXvik2bo=;
        b=tX+sAex8hvQIj2rLH4438gpRx/5U8ChkXSDCRO2iIuWQX5DDF+/NLqBCcOf2cagnAz
         teQJYZxy1TZ5chBvzEuPsJxJk20CQnFHbosqVfhOWTvnEvEFP2IyRou1VfNyGPSqsaPH
         +Iv7/7v0xCWr1JsjIKTDXt4utW2cZQwCrfgkVPNs0YwSIX6OHFNXypeKywoWWwdbzdwg
         I5AqQ1oGOo9OYMl8DdUErvuDrbfH6XyPEaXjRmz5D7c6Bisu8+wal5HMSl+4blmMdpaM
         uUQVANt8Mh3K3R560HI7Vc7jwD0P9tdLVWTcumsORsYefrvtzOdNXbjzs+hK/yyYyq9N
         fMsQ==
X-Gm-Message-State: AAQBX9fApgtk0KysSbe49H4/hsqAob69IrsEbqTPWyDfxTZ0NYZBtqWj
        cCygX3DYjx1BTHtIUuqkOoYc7Q==
X-Google-Smtp-Source: AKy350byEc3xPciw99yzx3LG7BZcgX8rx3fuloOHYBrG7cPj7FynObI6wypzA54S/DK4tOoVGIQszA==
X-Received: by 2002:a17:90b:1d11:b0:23d:1bf6:5c74 with SMTP id on17-20020a17090b1d1100b0023d1bf65c74mr15002378pjb.41.1679972010979;
        Mon, 27 Mar 2023 19:53:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id s19-20020a170902989300b00186cf82717fsm19877007plp.165.2023.03.27.19.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 19:53:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pgzSh-00E0io-6O; Tue, 28 Mar 2023 13:53:27 +1100
Date:   Tue, 28 Mar 2023 13:53:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <20230328025327.GB3222767@dread.disaster.area>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <ZBkDuLKLhsOHNUeG@destitution>
 <ZBsAG5cpOFhFZZG6@pc636>
 <ZB00U2S4g+VqzDPL@destitution>
 <ZCHQ5Pdr203+2LMI@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCHQ5Pdr203+2LMI@pc636>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 07:22:44PM +0200, Uladzislau Rezki wrote:
> >     So, this patch open codes the kvmalloc() in the commit path to have
> >     the above described behaviour. The result is we more than halve the
> >     CPU time spend doing kvmalloc() in this path and transaction commits
> >     with 64kB objects in them more than doubles. i.e. we get ~5x
> >     reduction in CPU usage per costly-sized kvmalloc() invocation and
> >     the profile looks like this:
> >     
> >       - 37.60% xlog_cil_commit
> >             16.01% memcpy_erms
> >           - 8.45% __kmalloc
> >              - 8.04% kmalloc_order_trace
> >                 - 8.03% kmalloc_order
> >                    - 7.93% alloc_pages
> >                       - 7.90% __alloc_pages
> >                          - 4.05% __alloc_pages_slowpath.constprop.0
> >                             - 2.18% get_page_from_freelist
> >                             - 1.77% wake_all_kswapds
> >     ....
> >                                         - __wake_up_common_lock
> >                                            - 0.94% _raw_spin_lock_irqsave
> >                          - 3.72% get_page_from_freelist
> >                             - 2.43% _raw_spin_lock_irqsave
> >           - 5.72% vmalloc
> >              - 5.72% __vmalloc_node_range
> >                 - 4.81% __get_vm_area_node.constprop.0
> >                    - 3.26% alloc_vmap_area
> >                       - 2.52% _raw_spin_lock
> >                    - 1.46% _raw_spin_lock
> >                   0.56% __alloc_pages_bulk
> >           - 4.66% kvfree
> >              - 3.25% vfree
> OK, i see. I tried to use the fs_mark in different configurations. For
> example:
> 
> <snip>
> time fs_mark -D 10000 -S0 -n 100000 -s 0 -L 32 -d ./scratch/0 -d ./scratch/1 -d ./scratch/2  \
> -d ./scratch/3 -d ./scratch/4 -d ./scratch/5 -d ./scratch/6 -d ./scratch/7 -d ./scratch/8 \
> -d ./scratch/9 -d ./scratch/10 -d ./scratch/11 -d ./scratch/12 -d ./scratch/13 \
> -d ./scratch/14 -d ./scratch/15 -t 64 -F
> <snip>
> 
> But i did not manage to trigger xlog_cil_commit() to fallback to vmalloc
> code. I think i should reduce an amount of memory on my kvm-pc and
> repeat the tests!

Simple way of doing is to use directory blocks that are larger than
page size:

mkfs.xfs -n size=64k ....

We can hit that path in other ways - large attributes will hit it in
the attr buffer allocation path, enabling the new attribute
intent-based logging mode will hit it in the xlog_cil_commit path as
well. IIRC, the above profile comes from the latter case, creating
lots of zero length files with 64kB xattrs attached via fsmark.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
