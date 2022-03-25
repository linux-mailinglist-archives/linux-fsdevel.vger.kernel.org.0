Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6D44E7380
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 13:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350213AbiCYMdU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 08:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359166AbiCYMdG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33ED9D080C
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 05:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648211491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yPjA/sNpnOcC3OZqw/MwHjQE8KDwlLZ97r+qgQx76dw=;
        b=XagkBYa0BJ2I1a/1oVWAo1EYltV/5Ibg85FoVrB97ZzIk/uWt2yUI1aggwUie+L3gijIqE
        xaPmZHWc/GyUF1YnDNJtQxREkUsgXwz6c8YDiYanr7aSNIVPbil8gNr5+HOIfM6+R5uzG/
        hrrj7gxyz7blRDOskZPFbvQ79v6LkQs=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-qIyR_3NQPRqq0eF_yPzEiw-1; Fri, 25 Mar 2022 08:31:29 -0400
X-MC-Unique: qIyR_3NQPRqq0eF_yPzEiw-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-2d2d45c0df7so59539337b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 05:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPjA/sNpnOcC3OZqw/MwHjQE8KDwlLZ97r+qgQx76dw=;
        b=bOZZblkZFbhH/gAcSKMY17klnCXRmxpNJgMUGLPe0T7mH7BFtrfa5GgCFdKgDRNYXz
         N8/NMbExLuzp33L77EpvoLZk3ykI6Z/1mrRxDBARglo2p/IU9s6NraWzAZfk6ju1bb5X
         V6Pa+mw99TC1wsB5FQEuC6id8p7AtK66wgX+PHoSz3LUJbZRbvPBWuqBfhcDNqMY4jhj
         U0zOtgAAwI3KkIMlN2fX5f0q95xOeGpXzeGqUAeAJ9RP8aBo8oPQxvHOvlQwSQh13g6J
         +WK+R4BFY1R2VQqS5WJ/MEAd+OymdjUI2FHfVdU2yZ8yyPzJerqWavj9FwZOA+klOlHX
         qh4Q==
X-Gm-Message-State: AOAM5322rkftegoig1UBKNGAozzekrZY8g8AEY5IEMLi/9DbHgggQ64B
        kheuYbfej5iGtRGcxJZFPJMe3EUwGPokTPuij5CnU5/VP35J57c0YoychiPTGZWMCF3+GtBWyMf
        liVLfc/ArqX1yb3UBbHW/0sqLfYBnsENjSvi7L7G20w==
X-Received: by 2002:a25:22d6:0:b0:633:90f5:a3d with SMTP id i205-20020a2522d6000000b0063390f50a3dmr9732500ybi.402.1648211488034;
        Fri, 25 Mar 2022 05:31:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLbkMySWcVby1qkRC7ubGRx41+P5/WfhnoVCsR7ijV5nDvgjZqE3XiUpuJVnnCKjaklKxotiIsqs4q8DkvuU8=
X-Received: by 2002:a25:22d6:0:b0:633:90f5:a3d with SMTP id
 i205-20020a2522d6000000b0063390f50a3dmr9732460ybi.402.1648211487785; Fri, 25
 Mar 2022 05:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220323201841.4166549-1-tbecker@redhat.com> <YjuR3h6yDYLoEeum@casper.infradead.org>
In-Reply-To: <YjuR3h6yDYLoEeum@casper.infradead.org>
From:   Thiago Becker <tbecker@redhat.com>
Date:   Fri, 25 Mar 2022 09:31:16 -0300
Message-ID: <CAD_rW4U8XA6UTmh85V+VcLhfsfSHUXBA7XBovqXEkBsxwdW=qA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/6] Intruduce nfsrahead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-nfs@vger.kernel.org, Steved <steved@redhat.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        Olga Kornievskaia <kolga@netapp.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Wed, Mar 23, 2022 at 6:32 PM Matthew Wilcox <willy@infradead.org> wrote:
> Which recent changes?  Something in NFS or something in the VFS/MM?
> Did you even think about asking a wider audience than the NFS mailing
> list?  I only happened to notice this while I was looking for something
> else, otherwise I would never have seen it.  The responses from other
> people to your patches were right; you're trying to do this all wrong.
>
> Let's start out with a bug report instead of a solution.  What changed
> and when?
>

As Trond stated, c128e575514c ("NFS: Optimise the default readahead
size") changed the way readahead is calculated for NFS mounts. This
caused some read workloads to underperform, compared to the
performance from previous revisions. To recall, the current policy
is to adopt the system default readahead of 128kiB, and mounts
with sec=krb5p take a performance hit of 50-75% when readahead
is 128. I haven't performed an exhaustive search for other workloads
that might also be affected, but I noticed the meaningful drop in
performance in sec=sys mounts, notes at the end.

The previous policy was to calculate the readahead as a
multiple of rsize, so we prescribed increasing the value to the
complaining part, and this fixed the issue. We are now trying to find a
solution that we can incorporate into the system.

thiago.

----- Tests
===== RAWHIDE (35% performance hit) =====
# uname -r
5.16.0-0.rc0.20211112git5833291ab6de.12.fc36.x86_64

# grep nfs /proc/self/mountinfo
601 60 0:55 / /mnt rw,relatime shared:332 - nfs4
192.168.122.225:/exports
rw,vers=4.2,rsize=262144,wsize=262144,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.122.83,local_lock=none,addr=192.168.122.225

# cat /sys/class/bdi/0\:55/read_ahead_kb
128

# for i in {0..3} ; do dd if=/mnt/testfile.bin of=/dev/null bs=1M 2>&1
| grep copied ; echo 3 > /proc/sys/vm/drop_caches ; done
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 16.5025 s, 260 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 16.4474 s, 261 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 18.0181 s, 238 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 18.2323 s, 236 MB/s

# echo 15360 > /sys/class/bdi/0\:55/read_ahead_kb

# for i in {0..3} ; do dd if=/mnt/testfile.bin of=/dev/null bs=1M 2>&1
| grep copied ; echo 3 > /proc/sys/vm/drop_caches ; done
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 11.2601 s, 381 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 11.1885 s, 384 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 11.5877 s, 371 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 10.9475 s, 392 MB/s

===== UPSTREAM (30% performance hit) =====
# uname -r
5.17.0+

# grep nfs /proc/self/mountinfo
583 60 0:55 / /mnt rw,relatime shared:302 - nfs4
192.168.122.225:/exports
rw,vers=4.2,rsize=262144,wsize=262144,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.122.83,local_lock=none,addr=192.168.122.225

# cat /sys/class/bdi/0\:55/read_ahead_kb
128

# for i in {0..3} ; do dd if=/mnt/testfile.bin of=/dev/null bs=1M 2>&1
| grep copied ; echo 3 > /proc/sys/vm/drop_caches ; done
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 17.056 s, 252 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 17.1258 s, 251 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 16.5981 s, 259 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 16.5487 s, 260 MB/s

# echo 15360 > /sys/class/bdi/0\:55/read_ahead_kb

# for i in {0..3} ; do dd if=/mnt/testfile.bin of=/dev/null bs=1M 2>&1
| grep copied ; echo 3 > /proc/sys/vm/drop_caches ; done
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 12.3855 s, 347 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 11.2528 s, 382 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 11.9849 s, 358 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 11.2953 s, 380 MB/s

