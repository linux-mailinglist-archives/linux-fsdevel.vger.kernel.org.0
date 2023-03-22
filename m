Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D006C4B7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 14:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjCVNSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 09:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCVNSa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:18:30 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC9731E01;
        Wed, 22 Mar 2023 06:18:24 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id t14so18910899ljd.5;
        Wed, 22 Mar 2023 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679491102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=flvUuqT7GguHLAZYu3Nm/bRmU352FoDCbqfDGEpJXGs=;
        b=cBYo1FbI7Jag2GTpMY+3zGMEfp45hgTlC6Wy8rucio3I5YvnyKBnBE6H3GbnDMg9bI
         G5y/UcjXalkfDSQ7S/VJOWIkg5vejUTJZtYMAxK6hRJ7Tm0xIT8YPn82BKgiLrafALxV
         p9z5qzN9P0cZFx2AQiOLa7GydS0kWotuv/9+bhFlF0z7gZwBb3qm2ARB2izXlu59lUES
         H/5Sbarbhda4Qi/J2LdyGU7uNG5TfV4EEOfbaxjCwv/2GL+OfL1szUnosY6EBNVXLYEt
         nxuD94i9BYsoX9ZcLQ5kImlgmSzkvDrGgTQ+FgQmRLUoiTjNgXotONBi56kwRHC8OnE+
         2rLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679491102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flvUuqT7GguHLAZYu3Nm/bRmU352FoDCbqfDGEpJXGs=;
        b=yKtrW+tlFY8efVTzDOgUVJW7/dDkFQExfxj7T/s/nbEL6jGIMduW1fDBr0NqF5kP6z
         XMtn/YaE/HTi3avEXJv9Qss2RkkUTZscG5zPd7z4FiGJ4/OvUO8OBrA0PKDox72XcNnR
         9F3on/cVf0qF3BjjHX7Y7z4BkSk7AWqe6pTz9QzzVVnSCqqdmgLBndF6Oz18w/y9nB3F
         1lshTuNYSeMrODZ2YBbXAK7J1QK+MYNkleX70+AoO5ynQ1S+NxHAQ08kcOHBAjzJeB2T
         CpOn7XEAa/g5drSv9+0SGd0LdYOJPLljiW1Wgx7pEo3kP7xHk08vu4EtSKNvvuw0iUUZ
         0lbQ==
X-Gm-Message-State: AO0yUKXlBCbMgIh6bVzIEjXug3CAJBg5prL2/rKA/6iS7ljxWNkZPXxP
        TyGT0Qw48B/a/MwooJ9s99HlhQ5w6npq8A==
X-Google-Smtp-Source: AK7set9RwGqwYhj9ISqc56aQk5wwiN4IHmCG8ijpaEJoHXQH05SRdgCq9r4OaAFTXDVw7yolslvkuA==
X-Received: by 2002:a2e:7309:0:b0:29b:d471:c817 with SMTP id o9-20020a2e7309000000b0029bd471c817mr2157580ljc.12.1679491102542;
        Wed, 22 Mar 2023 06:18:22 -0700 (PDT)
Received: from pc636 (host-90-233-209-15.mobileonline.telia.com. [90.233.209.15])
        by smtp.gmail.com with ESMTPSA id y2-20020a05651c020200b00295a33eda65sm2601091ljn.137.2023.03.22.06.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:18:22 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 22 Mar 2023 14:18:19 +0100
To:     Dave Chinner <david@fromorbit.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <ZBsAG5cpOFhFZZG6@pc636>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <ZBkDuLKLhsOHNUeG@destitution>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBkDuLKLhsOHNUeG@destitution>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Dave.

> 
> I'm travelling right now, but give me a few days and I'll test this
> against the XFS workloads that hammer the global vmalloc spin lock
> really, really badly. XFS can use vm_map_ram and vmalloc really
> heavily for metadata buffers and hit the global spin lock from every
> CPU in the system at the same time (i.e. highly concurrent
> workloads). vmalloc is also heavily used in the hottest path
> throught the journal where we process and calculate delta changes to
> several million items every second, again spread across every CPU in
> the system at the same time.
> 
> We really need the global spinlock to go away completely, but in the
> mean time a shared read lock should help a little bit....
> 
Could you please share some steps how to run your workloads in order to
touch vmalloc() code. I would like to have a look at it in more detail
just for understanding the workloads.

Meanwhile my grep agains xfs shows:

<snip>
urezki@pc638:~/data/raid0/coding/linux-rcu.git/fs/xfs$ grep -rn vmalloc ./
./xfs_log_priv.h:675: * Log vector and shadow buffers can be large, so we need to use kvmalloc() here
./xfs_log_priv.h:676: * to ensure success. Unfortunately, kvmalloc() only allows GFP_KERNEL contexts
./xfs_log_priv.h:677: * to fall back to vmalloc, so we can't actually do anything useful with gfp
./xfs_log_priv.h:678: * flags to control the kmalloc() behaviour within kvmalloc(). Hence kmalloc()
./xfs_log_priv.h:681: * vmalloc if it can't get somethign straight away from the free lists or
./xfs_log_priv.h:682: * buddy allocator. Hence we have to open code kvmalloc outselves here.
./xfs_log_priv.h:686: * allocations. This is actually the only way to make vmalloc() do GFP_NOFS
./xfs_log_priv.h:691:xlog_kvmalloc(
./xfs_log_priv.h:702:                   p = vmalloc(buf_size);
./xfs_bio_io.c:21:      unsigned int            is_vmalloc = is_vmalloc_addr(data);
./xfs_bio_io.c:26:      if (is_vmalloc && op == REQ_OP_WRITE)
./xfs_bio_io.c:56:      if (is_vmalloc && op == REQ_OP_READ)
./xfs_log.c:1976:       if (is_vmalloc_addr(iclog->ic_data))
./xfs_log_cil.c:338:                    lv = xlog_kvmalloc(buf_size);
./libxfs/xfs_attr_leaf.c:522:           args->value = kvmalloc(valuelen, GFP_KERNEL | __GFP_NOLOCKDEP);
./kmem.h:12:#include <linux/vmalloc.h>
./kmem.h:78:    if (is_vmalloc_addr(addr))
./kmem.h:79:            return vmalloc_to_page(addr);
./xfs_attr_item.c:84:    * This could be over 64kB in length, so we have to use kvmalloc() for
./xfs_attr_item.c:85:    * this. But kvmalloc() utterly sucks, so we use our own version.
./xfs_attr_item.c:87:   nv = xlog_kvmalloc(sizeof(struct xfs_attri_log_nameval) +
./scrub/attr.c:60:      ab = kvmalloc(sizeof(*ab) + sz, flags);
urezki@pc638:~/data/raid0/coding/linux-rcu.git/fs/xfs$
<snip>

Thanks!

--
Uladzislau Rezki
