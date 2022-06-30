Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743865619CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 14:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiF3MD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 08:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiF3MDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEAA074798
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 05:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656590632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DjTtG+0RqCMHzX5eN04DCnK0F3ZDM8TYHV+E49O0lmQ=;
        b=LS0EYls6K5EBVVuTfy/b5axXzE6gm8NgtyRsrwPeMxHP99xBEv5bFaB/LFIfvN68pwRAFv
        dWqVER3IK0c/JF5n33iRo85WV4Ls9lNBPZQK/LY1VcWs+K5mwKauA2222PrVtxHMOmQoeS
        bF8vVFv1pNGrK0cDUqZJWYaQiurE0EU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-VGZHRRQkM-GrbdncSpoehg-1; Thu, 30 Jun 2022 08:03:51 -0400
X-MC-Unique: VGZHRRQkM-GrbdncSpoehg-1
Received: by mail-qk1-f198.google.com with SMTP id g194-20020a379dcb000000b006aef700d954so19057119qke.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 05:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DjTtG+0RqCMHzX5eN04DCnK0F3ZDM8TYHV+E49O0lmQ=;
        b=j0zpFJWFtglzpmuDevXVbXnm+lisonkNJhQ+skyUdX4+7kB1d7zLm6sIbirIJMaFnV
         3uzNAxGf+xVyqJ8X00rBBtflZyhQJuCYLx84sxBToofz4/TIKu2Ifm2bbhyMvXacAJKg
         0PbPVTdHlxqIlFP1lGPzlnC2dMCcS15YtbCc7MuQQU2J/9lJ0mezpXowxgsxm2heDoIN
         OzCNgPjXexrRZkdNrPJoi8bB3gWWmPMHUS45393iS2nreWdWUsL6+zCEuGkowkcjMLTL
         afDHmEyYWCarYeufG/PFqDut+3hdXD4Ae3JAuIrYsLbPgVQwE+XCcWpsWyqdscHrZlQV
         EwjA==
X-Gm-Message-State: AJIora+R7eO9Y1AIrszc3UpTr3YIiu4QsnJiwoOqPO1+u7nEEGHbMf/I
        tJFy68y/rYBdDEyfifdwOJruTJt03Pi7+RO+wnNu3eQp+5Bc9qM93tTtjQY3fxl2kSSTP8UkRld
        Kf+xinHThK2WnOARBT2TeZ4QY6Q==
X-Received: by 2002:ae9:c203:0:b0:6b1:17a5:a56d with SMTP id j3-20020ae9c203000000b006b117a5a56dmr5905579qkg.705.1656590631296;
        Thu, 30 Jun 2022 05:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v/N7n/XGyXmbJYFqomZ9zL/F0CDIeQsBh9Np3+S6wqPRl66MueeztNc8Po6I4gTfRI19vlIg==
X-Received: by 2002:ae9:c203:0:b0:6b1:17a5:a56d with SMTP id j3-20020ae9c203000000b006b117a5a56dmr5905529qkg.705.1656590630960;
        Thu, 30 Jun 2022 05:03:50 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id h18-20020ac87772000000b002f905347586sm12662055qtu.14.2022.06.30.05.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 05:03:50 -0700 (PDT)
Date:   Thu, 30 Jun 2022 08:03:47 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        David.Laight@aculab.com, Ioannis Ilkos <ilkos@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Mike Rapoport <rppt@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH v2 1/2] procfs: Add 'size' to /proc/<pid>/fdinfo/
Message-ID: <Yr2RI3dJ0B4TALE5@bfoster>
References: <20220623220613.3014268-1-kaleshsingh@google.com>
 <20220623220613.3014268-2-kaleshsingh@google.com>
 <Yrrrz7MxMu8OoEPU@bfoster>
 <CAC_TJvejs5gbggC1hekyjUNctC_8+3FmVn0B7zAZox2+MkEjaA@mail.gmail.com>
 <YrxEUbDkYLE6XF6x@bfoster>
 <CAC_TJvcRd7=9xGXP5-t8v3g5iFWtYANpGA-nTqaGZBVTwa=07w@mail.gmail.com>
 <Yr2NngYE2qX8WzPV@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yr2NngYE2qX8WzPV@bfoster>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 30, 2022 at 07:48:46AM -0400, Brian Foster wrote:
> On Wed, Jun 29, 2022 at 01:43:11PM -0700, Kalesh Singh wrote:
> > On Wed, Jun 29, 2022 at 5:23 AM Brian Foster <bfoster@redhat.com> wrote:
> > >
> > > On Tue, Jun 28, 2022 at 03:38:02PM -0700, Kalesh Singh wrote:
> > > > On Tue, Jun 28, 2022 at 4:54 AM Brian Foster <bfoster@redhat.com> wrote:
> > > > >
> > > > > On Thu, Jun 23, 2022 at 03:06:06PM -0700, Kalesh Singh wrote:
> > > > > > To be able to account the amount of memory a process is keeping pinned
> > > > > > by open file descriptors add a 'size' field to fdinfo output.
> > > > > >
> > > > > > dmabufs fds already expose a 'size' field for this reason, remove this
> > > > > > and make it a common field for all fds. This allows tracking of
> > > > > > other types of memory (e.g. memfd and ashmem in Android).
> > > > > >
> > > > > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > > > > Reviewed-by: Christian König <christian.koenig@amd.com>
> > > > > > ---
> > > > > >
> > > > > > Changes in v2:
> > > > > >   - Add Christian's Reviewed-by
> > > > > >
> > > > > > Changes from rfc:
> > > > > >   - Split adding 'size' and 'path' into a separate patches, per Christian
> > > > > >   - Split fdinfo seq_printf into separate lines, per Christian
> > > > > >   - Fix indentation (use tabs) in documentaion, per Randy
> > > > > >
> > > > > >  Documentation/filesystems/proc.rst | 12 ++++++++++--
> > > > > >  drivers/dma-buf/dma-buf.c          |  1 -
> > > > > >  fs/proc/fd.c                       |  9 +++++----
> > > > > >  3 files changed, 15 insertions(+), 7 deletions(-)
> > > > > >
> > > ...
> > > > >
> > > > > Also not sure if it matters that much for your use case, but something
> > > > > worth noting at least with shmem is that one can do something like:
> > > > >
> > > > > # cat /proc/meminfo | grep Shmem:
> > > > > Shmem:               764 kB
> > > > > # xfs_io -fc "falloc -k 0 10m" ./file
> > > > > # ls -alh file
> > > > > -rw-------. 1 root root 0 Jun 28 07:22 file
> > > > > # stat file
> > > > >   File: file
> > > > >   Size: 0               Blocks: 20480      IO Block: 4096   regular empty file
> > > > > # cat /proc/meminfo | grep Shmem:
> > > > > Shmem:             11004 kB
> > > > >
> > > > > ... where the resulting memory usage isn't reflected in i_size (but is
> > > > > is in i_blocks/bytes).
> > > >
> > > > I tried a similar experiment a few times, but I don't see the same
> > > > results. In my case, there is not any change in shmem. IIUC the
> > > > fallocate is allocating the disk space not shared memory.
> > > >
> > >
> > > Sorry, it was implied in my previous test was that I was running against
> > > tmpfs. So regardless of fs, the fallocate keep_size semantics shown in
> > > both cases is as expected: the underlying blocks are allocated and the
> > > inode size is unchanged.
> > >
> > > What wasn't totally clear to me when I read this patch was 1. whether
> > > tmpfs refers to Shmem and 2. whether tmpfs allowed this sort of
> > > operation. The test above seems to confirm both, however, right? E.g., a
> > > more detailed example:
> > >
> > > # mount | grep /tmp
> > > tmpfs on /tmp type tmpfs (rw,nosuid,nodev,seclabel,nr_inodes=1048576,inode64)
> > > # cat /proc/meminfo | grep Shmem:
> > > Shmem:              5300 kB
> > > # xfs_io -fc "falloc -k 0 1g" /tmp/file
> > > # stat /tmp/file
> > >   File: /tmp/file
> > >   Size: 0               Blocks: 2097152    IO Block: 4096   regular empty file
> > > Device: 22h/34d Inode: 45          Links: 1
> > > Access: (0600/-rw-------)  Uid: (    0/    root)   Gid: (    0/    root)
> > > Context: unconfined_u:object_r:user_tmp_t:s0
> > > Access: 2022-06-29 08:04:01.301307154 -0400
> > > Modify: 2022-06-29 08:04:01.301307154 -0400
> > > Change: 2022-06-29 08:04:01.451312834 -0400
> > >  Birth: 2022-06-29 08:04:01.301307154 -0400
> > > # cat /proc/meminfo | grep Shmem:
> > > Shmem:           1053876 kB
> > > # rm -f /tmp/file
> > > # cat /proc/meminfo | grep Shmem:
> > > Shmem:              5300 kB
> > >
> > > So clearly this impacts Shmem.. was your test run against tmpfs or some
> > > other (disk based) fs?
> > 
> > Hi Brian,
> > 
> > Thanks for clarifying. My issue was tmpfs not mounted at /tmp in my system:
> > 
> > ==> meminfo.start <==
> > Shmem:               572 kB
> > ==> meminfo.stop <==
> > Shmem:             51688 kB
> > 
> 
> Ok, makes sense.
> 
> > >
> > > FWIW, I don't have any objection to exposing inode size if it's commonly
> > > useful information. My feedback was more just an fyi that i_size doesn't
> > > necessarily reflect underlying space consumption (whether it's memory or
> > > disk space) in more generic cases, because it sounds like that is really
> > > what you're after here. The opposite example to the above would be
> > > something like an 'xfs_io -fc "truncate 1t" /tmp/file', which shows a
> > > 1TB inode size with zero additional shmem usage.
> > 
> > From these cases, it seems the more generic way to do this is by
> > calculating the actual size consumed using the blocks. (i_blocks *
> > 512). So in the latter example  'xfs_io -fc "truncate 1t" /tmp/file'
> > the size consumed would be zero. Let me know if it sounds ok to you
> > and I can repost the updated version.
> > 
> 
> That sounds a bit more useful to me if you're interested in space usage,
> or at least I don't have a better idea for you. ;)
> 
> One thing to note is that I'm not sure whether all fs' use i_blocks
> reliably. E.g., XFS populates stat->blocks via a separate block counter
> in the XFS specific inode structure (see xfs_vn_getattr()). A bunch of
> other fs' seem to touch it so perhaps that is just an outlier. You could
> consider fixing that up, perhaps make a ->getattr() call to avoid it, or
> just use the field directly if it's useful enough as is and there are no
> other objections. Something to think about anyways..
> 

Oh, I wonder if you're looking for similar "file rss" information this
series wants to collect/expose..?

https://lore.kernel.org/linux-fsdevel/20220624080444.7619-1-christian.koenig@amd.com/#r

Brian

> Brian
> 
> > Thanks,
> > Kalesh
> > 
> > >
> > > Brian
> > >
> > > > cat /proc/meminfo > meminfo.start
> > > > xfs_io -fc "falloc -k 0 50m" ./xfs_file
> > > > cat /proc/meminfo > meminfo.stop
> > > > tail -n +1 meminfo.st* | grep -i '==\|Shmem:'
> > > >
> > > > ==> meminfo.start <==
> > > > Shmem:               484 kB
> > > > ==> meminfo.stop <==
> > > > Shmem:               484 kB
> > > >
> > > > ls -lh xfs_file
> > > > -rw------- 1 root root 0 Jun 28 15:12 xfs_file
> > > >
> > > > stat xfs_file
> > > >   File: xfs_file
> > > >   Size: 0               Blocks: 102400     IO Block: 4096   regular empty file
> > > >
> > > > Thanks,
> > > > Kalesh
> > > >
> > > > >
> > > > > Brian
> > > > >
> > > > > >
> > > > > >       /* show_fd_locks() never deferences files so a stale value is safe */
> > > > > >       show_fd_locks(m, file, files);
> > > > > > --
> > > > > > 2.37.0.rc0.161.g10f37bed90-goog
> > > > > >
> > > > >
> > > >
> > >
> > > --
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> > >
> > 

