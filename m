Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4337B6FD53A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 06:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbjEJEqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 00:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbjEJEqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 00:46:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3200422A
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 21:46:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-643b7b8f8ceso3093690b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 May 2023 21:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683693962; x=1686285962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ofB28UJkMdjbKgicTFJuyXfhP+N1OadXwaIb6BnaMTc=;
        b=c8IYXtdt/nvXPx3aeJJh+iQIuvYlBMqHn28lPL8dwwKzPPUree4mbogv16cwKHCZA/
         2KlwhwtNtJ/sOAj9NMMk4nrRtBS+Gj2xlpZYMsGP2F7hUHnyP7Wl/ODFFnjG3C7YtbMU
         mGCaclhyso80BrQZ3ChT4C2IhfUK4reiuD8T6r1xdMgWCOonQtRHVBWNFTfmxd/nkAyx
         9pYROnnyFfFqpXKEvFChx9kW6Mv3xGhI78p9oT0Dz/KBN2f/syi2V0pNZNHywY4hlOoT
         yXYhwYnZuTq/CGlG6+zY6qoV9PuZa2eEmNARbqRIwsfJQjYbQxW/3GXfBm4dbKFMorZz
         5Uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683693962; x=1686285962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofB28UJkMdjbKgicTFJuyXfhP+N1OadXwaIb6BnaMTc=;
        b=kXzj2H28sXcz0y/+wjaKPFZp42GWmgNXpK2QGitAembvDTywiQ6BuitMSmTJGoGvXc
         pBuuJgWxZBYma7gbKtQ2Lve/WalBWJ5mS/3LtAcbSEGfGM72xHQZZ5MA1e2IrUBgzLBK
         bFVnDkh3rb2hf5PEQzXwOle9sZlqXCRWFrtfpEdeAY0gIsgbgz88LT016n7OQYC1Uw2K
         ZkxelHvlTry7lLrIqsHOre7FxPxPU1JZXGFjPhixVspTFzdujruXlE2KsCMn+ujwrVNZ
         xCxkrpy2qPy1I26SlQWzuuzx/+q+ie50NTkrPEY9CfZPtOC2r4vNngAvj+TW+LtG3QaO
         yitA==
X-Gm-Message-State: AC+VfDyHebzStTmifMjWtsiobq0LwbCpPDAGTa4SKZs4cJA6hLZzptdi
        rifYIahg5Y/LuVIj9v5z/q88Uw==
X-Google-Smtp-Source: ACHHUZ5thq7haMb94Aftq6by7PVgqXFot+62KXDs1YkuFqVoYOSeojgqeUskjGrAVEZlOo3/EAZ7ew==
X-Received: by 2002:a05:6a21:6d8a:b0:101:282c:2b with SMTP id wl10-20020a056a216d8a00b00101282c002bmr6552938pzb.32.1683693961867;
        Tue, 09 May 2023 21:46:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id e5-20020aa78c45000000b00640defda6d2sm2555461pfd.207.2023.05.09.21.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:46:01 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pwbi9-00DUH0-Sc; Wed, 10 May 2023 14:45:57 +1000
Date:   Wed, 10 May 2023 14:45:57 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 22/32] vfs: inode cache conversion to hash-bl
Message-ID: <20230510044557.GF2651828@dread.disaster.area>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-23-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509165657.1735798-23-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 12:56:47PM -0400, Kent Overstreet wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Because scalability of the global inode_hash_lock really, really
> sucks.
> 
> 32-way concurrent create on a couple of different filesystems
> before:
> 
> -   52.13%     0.04%  [kernel]            [k] ext4_create
>    - 52.09% ext4_create
>       - 41.03% __ext4_new_inode
>          - 29.92% insert_inode_locked
>             - 25.35% _raw_spin_lock
>                - do_raw_spin_lock
>                   - 24.97% __pv_queued_spin_lock_slowpath
> 
> -   72.33%     0.02%  [kernel]            [k] do_filp_open
>    - 72.31% do_filp_open
>       - 72.28% path_openat
>          - 57.03% bch2_create
>             - 56.46% __bch2_create
>                - 40.43% inode_insert5
>                   - 36.07% _raw_spin_lock
>                      - do_raw_spin_lock
>                           35.86% __pv_queued_spin_lock_slowpath
>                     4.02% find_inode
> 
> Convert the inode hash table to a RCU-aware hash-bl table just like
> the dentry cache. Note that we need to store a pointer to the
> hlist_bl_head the inode has been added to in the inode so that when
> it comes to unhash the inode we know what list to lock. We need to
> do this because the hash value that is used to hash the inode is
> generated from the inode itself - filesystems can provide this
> themselves so we have to either store the hash or the head pointer
> in the inode to be able to find the right list head for removal...
> 
> Same workload after:
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

I have been maintaining this patchset uptodate in my own local trees
and the code in this patch looks the same. The commit message above,
however, has been mangled. The full commit message should be:

vfs: inode cache conversion to hash-bl

Because scalability of the global inode_hash_lock really, really
sucks and prevents me from doing scalability characterisation and
analysis of bcachefs algorithms.

Profiles of a 32-way concurrent create of 51.2m inodes with fsmark
on a couple of different filesystems on a 5.10 kernel:

-   52.13%     0.04%  [kernel]            [k] ext4_create
   - 52.09% ext4_create
      - 41.03% __ext4_new_inode
         - 29.92% insert_inode_locked
            - 25.35% _raw_spin_lock
               - do_raw_spin_lock
                  - 24.97% __pv_queued_spin_lock_slowpath


-   72.33%     0.02%  [kernel]            [k] do_filp_open
   - 72.31% do_filp_open
      - 72.28% path_openat
         - 57.03% bch2_create
            - 56.46% __bch2_create
               - 40.43% inode_insert5
                  - 36.07% _raw_spin_lock
                     - do_raw_spin_lock
                          35.86% __pv_queued_spin_lock_slowpath
                    4.02% find_inode

btrfs was tested but it is limited by internal lock contention at
>=2 threads on this workload, so never hammers the inode cache lock
hard enough for this change to matter to it's performance.

However, both bcachefs and ext4 demonstrate poor scaling at >=8
threads on concurrent lookup or create workloads.

Hence convert the inode hash table to a RCU-aware hash-bl table just
like the dentry cache. Note that we need to store a pointer to the
hlist_bl_head the inode has been added to in the inode so that when
it comes to unhash the inode we know what list to lock. We need to
do this because, unlike the dentry cache, the hash value that is
used to hash the inode is not generated from the inode itself. i.e.
filesystems can provide this themselves so we have to either store
the hashval or the hlist head pointer in the inode to be able to
find the right list head for removal...

Concurrent create with variying thread count (files/s):

                ext4                    bcachefs
threads         vanilla  patched        vanilla patched
2               117k     112k            80k     85k
4               185k     190k           133k    145k
8               303k     346k           185k    255k
16              389k     465k           190k    420k
32              360k     437k           142k    481k

CPU usage for both bcachefs and ext4 at 16 and 32 threads has been
halved on the patched kernel, while performance has increased
marginally on ext4 and massively on bcachefs. Internal filesystem
algorithms now limit performance on these workloads, not the global
inode_hash_lock.

Profile of the workloads on the patched kernels:

-   35.94%     0.07%  [kernel]                  [k] ext4_create
   - 35.87% ext4_create
      - 20.45% __ext4_new_inode
...
           3.36% insert_inode_locked

   - 78.43% do_filp_open
      - 78.36% path_openat
         - 53.95% bch2_create
            - 47.99% __bch2_create
....
              - 7.57% inode_insert5
                    6.94% find_inode

Spinlock contention is largely gone from the inode hash operations
and the filesystems are limited by contention in their internal
algorithms.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---

Other than that, the diffstat is the same and I don't see any obvious
differences in the code comapred to what I've been running locally.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
