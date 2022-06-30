Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8797D561995
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 13:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiF3Ls4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 07:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiF3Lsy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:48:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02CCB41623
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 04:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656589732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PuYKS2jgPzieTAQHjEiRWkzk1xJEb/FrbHOJrQZTZMA=;
        b=h9Q+mJtW5voCiocL+NFF71bKgsQQEshmzA+HAvYN5S5FOtsRbxhmTUsd6wwEZ76H2h8ILN
        AYlWCnQ0wM8MJtj7939LF6ThtRT4opdrhQjHWGkegVrAYdNiHMPG2SL2thEuCI6RbFjLrv
        4Jb2nEqcbB8tT3ZWkn9m26eRFaCYItk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-FX_Lm_EdPRaUPG1CLj6Stg-1; Thu, 30 Jun 2022 07:48:51 -0400
X-MC-Unique: FX_Lm_EdPRaUPG1CLj6Stg-1
Received: by mail-qk1-f198.google.com with SMTP id 194-20020a3704cb000000b006af069d1e0aso17848104qke.15
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 04:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PuYKS2jgPzieTAQHjEiRWkzk1xJEb/FrbHOJrQZTZMA=;
        b=qtS4PxDD4PArS9UGqm6jOLau+dBBE/i8QlUtOL7hEg9Dyj2TBcNpvri4wS1z13yaDi
         pPhXtynbv7pJC0BUKoSRF5Xdm6RdYMVLQdA8gDtkI6RJ/mQbtD5t9VJ2nTIXbLqsp6W8
         eeZZNs75c7ECugZlJUnWZhhfC3WY0fo/YG1BlvnOJYco0JzgNMH7HQJcj/mahx84Qd+P
         ayWbKTp/IXtWvFPbL8ROIcBClnSNZdlb17LisX1b5+a4ciwHBwijRB+YeaulOqTkKYlT
         vGuzvMacwQUe6pplk8RKI7gvIuLn+INjMCaURxNMFYGPRUB5lVIyN9ywDr9zjuGUrhPd
         eTyw==
X-Gm-Message-State: AJIora+LIK0wo/lXdlRSyFQhdOIGe3dL0nIaICmWjaPdBq/C1+0ddvUt
        rbcUU6KRL5yhhfL7PPVEoYmOq+ChadJFkqE7UuZs4MO2AgToZPabthuft1e7yNIQh4B/5c/fsqG
        OaWjTYkWk1NQl64SmLTNmr5nXWQ==
X-Received: by 2002:a05:622a:109:b0:31d:23fe:7b4c with SMTP id u9-20020a05622a010900b0031d23fe7b4cmr6581292qtw.312.1656589730508;
        Thu, 30 Jun 2022 04:48:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uRz44w+O3VbQzatODmiPcnbDn785yVVNQoG4sSqp1OaDj0ogmo2bhAXqTAqLnNxIU5BCVTqw==
X-Received: by 2002:a05:622a:109:b0:31d:23fe:7b4c with SMTP id u9-20020a05622a010900b0031d23fe7b4cmr6581266qtw.312.1656589730128;
        Thu, 30 Jun 2022 04:48:50 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id l12-20020a37f90c000000b006b14fb1ba18sm2588043qkj.35.2022.06.30.04.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 04:48:49 -0700 (PDT)
Date:   Thu, 30 Jun 2022 07:48:46 -0400
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
Message-ID: <Yr2NngYE2qX8WzPV@bfoster>
References: <20220623220613.3014268-1-kaleshsingh@google.com>
 <20220623220613.3014268-2-kaleshsingh@google.com>
 <Yrrrz7MxMu8OoEPU@bfoster>
 <CAC_TJvejs5gbggC1hekyjUNctC_8+3FmVn0B7zAZox2+MkEjaA@mail.gmail.com>
 <YrxEUbDkYLE6XF6x@bfoster>
 <CAC_TJvcRd7=9xGXP5-t8v3g5iFWtYANpGA-nTqaGZBVTwa=07w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_TJvcRd7=9xGXP5-t8v3g5iFWtYANpGA-nTqaGZBVTwa=07w@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 01:43:11PM -0700, Kalesh Singh wrote:
> On Wed, Jun 29, 2022 at 5:23 AM Brian Foster <bfoster@redhat.com> wrote:
> >
> > On Tue, Jun 28, 2022 at 03:38:02PM -0700, Kalesh Singh wrote:
> > > On Tue, Jun 28, 2022 at 4:54 AM Brian Foster <bfoster@redhat.com> wrote:
> > > >
> > > > On Thu, Jun 23, 2022 at 03:06:06PM -0700, Kalesh Singh wrote:
> > > > > To be able to account the amount of memory a process is keeping pinned
> > > > > by open file descriptors add a 'size' field to fdinfo output.
> > > > >
> > > > > dmabufs fds already expose a 'size' field for this reason, remove this
> > > > > and make it a common field for all fds. This allows tracking of
> > > > > other types of memory (e.g. memfd and ashmem in Android).
> > > > >
> > > > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > > > Reviewed-by: Christian König <christian.koenig@amd.com>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > >   - Add Christian's Reviewed-by
> > > > >
> > > > > Changes from rfc:
> > > > >   - Split adding 'size' and 'path' into a separate patches, per Christian
> > > > >   - Split fdinfo seq_printf into separate lines, per Christian
> > > > >   - Fix indentation (use tabs) in documentaion, per Randy
> > > > >
> > > > >  Documentation/filesystems/proc.rst | 12 ++++++++++--
> > > > >  drivers/dma-buf/dma-buf.c          |  1 -
> > > > >  fs/proc/fd.c                       |  9 +++++----
> > > > >  3 files changed, 15 insertions(+), 7 deletions(-)
> > > > >
> > ...
> > > >
> > > > Also not sure if it matters that much for your use case, but something
> > > > worth noting at least with shmem is that one can do something like:
> > > >
> > > > # cat /proc/meminfo | grep Shmem:
> > > > Shmem:               764 kB
> > > > # xfs_io -fc "falloc -k 0 10m" ./file
> > > > # ls -alh file
> > > > -rw-------. 1 root root 0 Jun 28 07:22 file
> > > > # stat file
> > > >   File: file
> > > >   Size: 0               Blocks: 20480      IO Block: 4096   regular empty file
> > > > # cat /proc/meminfo | grep Shmem:
> > > > Shmem:             11004 kB
> > > >
> > > > ... where the resulting memory usage isn't reflected in i_size (but is
> > > > is in i_blocks/bytes).
> > >
> > > I tried a similar experiment a few times, but I don't see the same
> > > results. In my case, there is not any change in shmem. IIUC the
> > > fallocate is allocating the disk space not shared memory.
> > >
> >
> > Sorry, it was implied in my previous test was that I was running against
> > tmpfs. So regardless of fs, the fallocate keep_size semantics shown in
> > both cases is as expected: the underlying blocks are allocated and the
> > inode size is unchanged.
> >
> > What wasn't totally clear to me when I read this patch was 1. whether
> > tmpfs refers to Shmem and 2. whether tmpfs allowed this sort of
> > operation. The test above seems to confirm both, however, right? E.g., a
> > more detailed example:
> >
> > # mount | grep /tmp
> > tmpfs on /tmp type tmpfs (rw,nosuid,nodev,seclabel,nr_inodes=1048576,inode64)
> > # cat /proc/meminfo | grep Shmem:
> > Shmem:              5300 kB
> > # xfs_io -fc "falloc -k 0 1g" /tmp/file
> > # stat /tmp/file
> >   File: /tmp/file
> >   Size: 0               Blocks: 2097152    IO Block: 4096   regular empty file
> > Device: 22h/34d Inode: 45          Links: 1
> > Access: (0600/-rw-------)  Uid: (    0/    root)   Gid: (    0/    root)
> > Context: unconfined_u:object_r:user_tmp_t:s0
> > Access: 2022-06-29 08:04:01.301307154 -0400
> > Modify: 2022-06-29 08:04:01.301307154 -0400
> > Change: 2022-06-29 08:04:01.451312834 -0400
> >  Birth: 2022-06-29 08:04:01.301307154 -0400
> > # cat /proc/meminfo | grep Shmem:
> > Shmem:           1053876 kB
> > # rm -f /tmp/file
> > # cat /proc/meminfo | grep Shmem:
> > Shmem:              5300 kB
> >
> > So clearly this impacts Shmem.. was your test run against tmpfs or some
> > other (disk based) fs?
> 
> Hi Brian,
> 
> Thanks for clarifying. My issue was tmpfs not mounted at /tmp in my system:
> 
> ==> meminfo.start <==
> Shmem:               572 kB
> ==> meminfo.stop <==
> Shmem:             51688 kB
> 

Ok, makes sense.

> >
> > FWIW, I don't have any objection to exposing inode size if it's commonly
> > useful information. My feedback was more just an fyi that i_size doesn't
> > necessarily reflect underlying space consumption (whether it's memory or
> > disk space) in more generic cases, because it sounds like that is really
> > what you're after here. The opposite example to the above would be
> > something like an 'xfs_io -fc "truncate 1t" /tmp/file', which shows a
> > 1TB inode size with zero additional shmem usage.
> 
> From these cases, it seems the more generic way to do this is by
> calculating the actual size consumed using the blocks. (i_blocks *
> 512). So in the latter example  'xfs_io -fc "truncate 1t" /tmp/file'
> the size consumed would be zero. Let me know if it sounds ok to you
> and I can repost the updated version.
> 

That sounds a bit more useful to me if you're interested in space usage,
or at least I don't have a better idea for you. ;)

One thing to note is that I'm not sure whether all fs' use i_blocks
reliably. E.g., XFS populates stat->blocks via a separate block counter
in the XFS specific inode structure (see xfs_vn_getattr()). A bunch of
other fs' seem to touch it so perhaps that is just an outlier. You could
consider fixing that up, perhaps make a ->getattr() call to avoid it, or
just use the field directly if it's useful enough as is and there are no
other objections. Something to think about anyways..

Brian

> Thanks,
> Kalesh
> 
> >
> > Brian
> >
> > > cat /proc/meminfo > meminfo.start
> > > xfs_io -fc "falloc -k 0 50m" ./xfs_file
> > > cat /proc/meminfo > meminfo.stop
> > > tail -n +1 meminfo.st* | grep -i '==\|Shmem:'
> > >
> > > ==> meminfo.start <==
> > > Shmem:               484 kB
> > > ==> meminfo.stop <==
> > > Shmem:               484 kB
> > >
> > > ls -lh xfs_file
> > > -rw------- 1 root root 0 Jun 28 15:12 xfs_file
> > >
> > > stat xfs_file
> > >   File: xfs_file
> > >   Size: 0               Blocks: 102400     IO Block: 4096   regular empty file
> > >
> > > Thanks,
> > > Kalesh
> > >
> > > >
> > > > Brian
> > > >
> > > > >
> > > > >       /* show_fd_locks() never deferences files so a stale value is safe */
> > > > >       show_fd_locks(m, file, files);
> > > > > --
> > > > > 2.37.0.rc0.161.g10f37bed90-goog
> > > > >
> > > >
> > >
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
> 

