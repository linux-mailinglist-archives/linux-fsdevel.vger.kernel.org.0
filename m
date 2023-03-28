Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4946CBF64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 14:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjC1Mk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 08:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjC1Mkz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:40:55 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719BDAD1D;
        Tue, 28 Mar 2023 05:40:39 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s20so12399691ljp.1;
        Tue, 28 Mar 2023 05:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680007236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JQvGHzQ+Wj6h0GZci6E4OJ3p7YN4IspLtSyoRGDx948=;
        b=XeB/xdjfocDtQOXVJOQ1qYz1GTmks1YyJw2oeNFVZaprZvJZ5r9OiTyw/3OmU4+l8J
         SvgKkL7/42lZhZYAV2j6Kex/+LbwuslmmYVT1bGzXMf5VT0v8EV4PKppYvpxThTssrfG
         0LDZjkhq88y0yIzdHqkTzgJbWVXxKZrGxpqN/w9Swr5+R9dpT1OVrjAPNOD5ri4bz9cZ
         qtE6BEIJl7G3BgHWQN6TXJLVidQWU+JdS6hMpTkuAGMdXCQACO0KZiLphDYfBp5+FUCi
         kqRwDbBE+LD9KWN/6Q0hOwByp2P25HUAo1GotTfS/mOK44zK3dfYxYGfpJ4nCP1P4Hjy
         poZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680007236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQvGHzQ+Wj6h0GZci6E4OJ3p7YN4IspLtSyoRGDx948=;
        b=srwh9fuoxezixLNF5XAAjDICrd0X2ZxeuXMdsiVVQYE/r22axZ/WPPJgq5I7KaSbHl
         /CpCcvYs+JrmhxMrOcv+5X3NvDc4+hcYLuUGaY2qD0vKgdsSd6AyfVLbxTdp7o+6oPb9
         zv7b+ZV8Pdw5aT9bolxqPNbC5W85GVoWT4cYnGSZILBa9kAuHRXLOrM41qcZ+pgFrPJ8
         TZhWZcr+8CXOZwTvi+YTcTfn7i7IqJrTAjqFAnG8vKX/C3/MYRK5KS4JyiMQvkJ8cUlX
         2sk0Vq8nlgLG5CpNJwp4Ik+Sas6QU+MmHZTWf18EM78eaH8x32HoN0GCYSXFNEUudUvV
         C7CQ==
X-Gm-Message-State: AAQBX9exU8rfftzVJbZLCLeVaoUAencfI8YhQgKVlRiEj06GyNWNDri0
        kRr+QyFFJPQSuL+q75bxUGFYYfMaEPpKYg==
X-Google-Smtp-Source: AKy350Z1a8irWZjaLN9fUZq6p+NEYF5IRs+Vqh6pkF+dTZfIO4NprtYcjMWtQw3iKObYVa37gX6fJA==
X-Received: by 2002:a2e:9455:0:b0:29c:8a05:1a38 with SMTP id o21-20020a2e9455000000b0029c8a051a38mr4539691ljh.30.1680007236070;
        Tue, 28 Mar 2023 05:40:36 -0700 (PDT)
Received: from pc636 (host-90-233-209-50.mobileonline.telia.com. [90.233.209.50])
        by smtp.gmail.com with ESMTPSA id r9-20020a2e80c9000000b0029573844d03sm4896655ljg.109.2023.03.28.05.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 05:40:35 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 28 Mar 2023 14:40:33 +0200
To:     Dave Chinner <david@fromorbit.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <ZCLgQXpIi7A7hYrT@pc636>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <ZBkDuLKLhsOHNUeG@destitution>
 <ZBsAG5cpOFhFZZG6@pc636>
 <ZB00U2S4g+VqzDPL@destitution>
 <ZCHQ5Pdr203+2LMI@pc636>
 <20230328025327.GB3222767@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328025327.GB3222767@dread.disaster.area>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 01:53:27PM +1100, Dave Chinner wrote:
> On Mon, Mar 27, 2023 at 07:22:44PM +0200, Uladzislau Rezki wrote:
> > >     So, this patch open codes the kvmalloc() in the commit path to have
> > >     the above described behaviour. The result is we more than halve the
> > >     CPU time spend doing kvmalloc() in this path and transaction commits
> > >     with 64kB objects in them more than doubles. i.e. we get ~5x
> > >     reduction in CPU usage per costly-sized kvmalloc() invocation and
> > >     the profile looks like this:
> > >     
> > >       - 37.60% xlog_cil_commit
> > >             16.01% memcpy_erms
> > >           - 8.45% __kmalloc
> > >              - 8.04% kmalloc_order_trace
> > >                 - 8.03% kmalloc_order
> > >                    - 7.93% alloc_pages
> > >                       - 7.90% __alloc_pages
> > >                          - 4.05% __alloc_pages_slowpath.constprop.0
> > >                             - 2.18% get_page_from_freelist
> > >                             - 1.77% wake_all_kswapds
> > >     ....
> > >                                         - __wake_up_common_lock
> > >                                            - 0.94% _raw_spin_lock_irqsave
> > >                          - 3.72% get_page_from_freelist
> > >                             - 2.43% _raw_spin_lock_irqsave
> > >           - 5.72% vmalloc
> > >              - 5.72% __vmalloc_node_range
> > >                 - 4.81% __get_vm_area_node.constprop.0
> > >                    - 3.26% alloc_vmap_area
> > >                       - 2.52% _raw_spin_lock
> > >                    - 1.46% _raw_spin_lock
> > >                   0.56% __alloc_pages_bulk
> > >           - 4.66% kvfree
> > >              - 3.25% vfree
> > OK, i see. I tried to use the fs_mark in different configurations. For
> > example:
> > 
> > <snip>
> > time fs_mark -D 10000 -S0 -n 100000 -s 0 -L 32 -d ./scratch/0 -d ./scratch/1 -d ./scratch/2  \
> > -d ./scratch/3 -d ./scratch/4 -d ./scratch/5 -d ./scratch/6 -d ./scratch/7 -d ./scratch/8 \
> > -d ./scratch/9 -d ./scratch/10 -d ./scratch/11 -d ./scratch/12 -d ./scratch/13 \
> > -d ./scratch/14 -d ./scratch/15 -t 64 -F
> > <snip>
> > 
> > But i did not manage to trigger xlog_cil_commit() to fallback to vmalloc
> > code. I think i should reduce an amount of memory on my kvm-pc and
> > repeat the tests!
> 
> Simple way of doing is to use directory blocks that are larger than
> page size:
> 
> mkfs.xfs -n size=64k ....
> 
> We can hit that path in other ways - large attributes will hit it in
> the attr buffer allocation path, enabling the new attribute
> intent-based logging mode will hit it in the xlog_cil_commit path as
> well. IIRC, the above profile comes from the latter case, creating
> lots of zero length files with 64kB xattrs attached via fsmark.
> 
Good. Thank you that is useful.

--
Uladzislau Rezki
