Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142DD54CA23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349312AbiFONrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347628AbiFONq4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:46:56 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EC62F64C
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 06:46:52 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id cn20so3821997edb.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yEvIXRPucn+6BeLmS4BVfzZdrrJJq6QW6xPZWAKt890=;
        b=TXvEcZJ6ukZF/jYGwYFRRsN7SSyIAITCDv6vV7w6T62/Sst+VBOlstW+1l9SjzNkee
         iIPsLded/ZzOmM6pzdrksIWaVV3rO5ytVyiD9RnaENYVCROlCY7iuV+k/PfbBIhJm6dM
         JAjCL6lO3TJHOWbm/8qNlZ/kCqjDLCj/MteoPaGcgG5cUZpwEdDDszdlokoPkUNtrX1h
         K7oVdOfABXhFKkieeowcFzgPMjXnaoI1nPuRFJh5vTyHQhdoWlp81L5y2tQhtw32eUaj
         MIgEsi9zxdqBuMsnvAiQ6OhQRtmlCQvzonbRdTwow7+I9auMZB5udDp1vdvRKHwUoQJv
         oukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEvIXRPucn+6BeLmS4BVfzZdrrJJq6QW6xPZWAKt890=;
        b=Fmu+zexu4rNtdLrtK+2fyITBaoUEOomA/UKkN/lzZkxiEOSUG/X0grmjHSBEcso40X
         vryQVMPOGjl1qmNDQBSczT2wnsXNIU/TAfAPoFGan9Zun/Rl3fRbUkB4pWG25IORRa7L
         iFKf8Gy2EqawxwVPb/il7INTtvV0fhjqfjn1NOWYups3HOxfa6Nv9DVUij9/p3AFYGhj
         1IjmW1MXLCV8X1QkSKwLYSeevnONDCeBKhEKHyaG6g6QbXJ4WjA1tHkuBjNRk1QB6su2
         wpC1u4TGYqhPAIs3WJnU3N0nedX3n20dsJZgMlzQPeNp8tr1bqj/Scj0OjymXSOEJMuX
         Y3Jg==
X-Gm-Message-State: AOAM531eRFTDaXdwH6zE0j7Jn5g+x6oHbG9rwBtxDgVBV2u8PYm1MeGc
        3Q4IWpfMtypRi6K6im7USZ9guiMaCN3mquKEHw6yoA==
X-Google-Smtp-Source: AGRyM1s8Cf0Mj8Z/SnwwdeplHCi9y7diCjvcjZeMNKYhT4Tcd2GK0VSRetUi9ShVrGPYME0EWDocAtyOZ3tSiSV9oJE=
X-Received: by 2002:a50:9f88:0:b0:42d:f7d2:1b7b with SMTP id
 c8-20020a509f88000000b0042df7d21b7bmr12938702edf.139.1655300811013; Wed, 15
 Jun 2022 06:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>
In-Reply-To: <165516173293.21248.14587048046993234326.stgit@noble.brown>
From:   Daire Byrne <daire@dneg.com>
Date:   Wed, 15 Jun 2022 14:46:14 +0100
Message-ID: <CAPt2mGNjWXad6e7nSUTu=0ez1qU1wBNegrntgHKm5hOeBs5gQA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] Allow concurrent directory updates.
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Neil,

Firstly, thank you for your work on this. I'm probably the main
beneficiary of this (NFSD) effort atm so I feel extra special and
lucky!

I have done some quick artificial tests similar to before where I am
using a NFS server and client separated by an (extreme) 200ms of
latency (great for testing parallelism). I am only using NFSv3 due to
the NFSD_CACHE_SIZE_SLOTS_PER_SESSION parallelism limitations for
NFSv4.

Firstly, a client direct to server (VFS) with 10 simultaneous create
processes hitting the same directory:

client1 # for x in {1..1000}; do
    echo /srv/server1/data/touch.$x
done | xargs -n1 -P 10 -iX -t touch X 2>&1 | pv -l -a >|/dev/null

Without the patch ( on the client), this reaches a steady state of 2.4
creates/s and increasing the number of parallel create processes does
not change this aggregate performance.

With the patch, the creation rate increases to 15 creates/s and with
100 processes, it further scales up to 121 creates/s.

Now for the re-export case (NFSD) where an intermediary server
re-exports the originating server (200ms away) to clients on it's
local LAN, there is no noticeable improvement for a single (not
patched) client. But we do see an aggregate improvement when we use
multiple clients at once.

# pdsh -Rssh -w 'client[1-10]' 'for x in {1..1000}; do echo
/srv/reexport1/data/$(hostname -s).$x; done | xargs -n1 -P 10 -iX -t
touch X 2>&1' | pv -l -a >|/dev/null

Without the patch applied to the reexport server, the aggregate is
around 2.2 create/s which is similar to doing it directly to the
originating server from a single client (above).

With the patch, the aggregate increases to 15 creates/s for 10 clients
which again matches the results of a single patched client. Not quite
a x10 increase but a healthy improvement nonetheless.

However, it is at this point that I started to experience some
stability issues with the re-export server that are not present with
the vanilla unpatched v5.19-rc2 kernel. In particular the knfsd
threads start to lock up with stack traces like this:

[ 1234.460696] INFO: task nfsd:5514 blocked for more than 123 seconds.
[ 1234.461481]       Tainted: G        W   E     5.19.0-1.dneg.x86_64 #1
[ 1234.462289] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 1234.463227] task:nfsd            state:D stack:    0 pid: 5514
ppid:     2 flags:0x00004000
[ 1234.464212] Call Trace:
[ 1234.464677]  <TASK>
[ 1234.465104]  __schedule+0x2a9/0x8a0
[ 1234.465663]  schedule+0x55/0xc0
[ 1234.466183]  ? nfs_lookup_revalidate_dentry+0x3a0/0x3a0 [nfs]
[ 1234.466995]  __nfs_lookup_revalidate+0xdf/0x120 [nfs]
[ 1234.467732]  ? put_prev_task_stop+0x170/0x170
[ 1234.468374]  nfs_lookup_revalidate+0x15/0x20 [nfs]
[ 1234.469073]  lookup_dcache+0x5a/0x80
[ 1234.469639]  lookup_one_unlocked+0x59/0xa0
[ 1234.470244]  lookup_one_len_unlocked+0x1d/0x20
[ 1234.470951]  nfsd_lookup_dentry+0x190/0x470 [nfsd]
[ 1234.471663]  nfsd_lookup+0x88/0x1b0 [nfsd]
[ 1234.472294]  nfsd3_proc_lookup+0xb4/0x100 [nfsd]
[ 1234.473012]  nfsd_dispatch+0x161/0x290 [nfsd]
[ 1234.473689]  svc_process_common+0x48a/0x620 [sunrpc]
[ 1234.474402]  ? nfsd_svc+0x330/0x330 [nfsd]
[ 1234.475038]  ? nfsd_shutdown_threads+0xa0/0xa0 [nfsd]
[ 1234.475772]  svc_process+0xbc/0xf0 [sunrpc]
[ 1234.476408]  nfsd+0xda/0x190 [nfsd]
[ 1234.477011]  kthread+0xf0/0x120
[ 1234.477522]  ? kthread_complete_and_exit+0x20/0x20
[ 1234.478199]  ret_from_fork+0x22/0x30
[ 1234.478755]  </TASK>

For whatever reason, they seem to affect our Netapp mounts and
re-exports rather than our originating Linux NFS servers (against
which all tests were done). This may be related to the fact that those
Netapps serve our home directories so there could be some unique
locking patterns going on there.

This issue made things a bit too unstable to test at larger scales or
with our production workloads.

So all in all, the performance improvements in the knfsd re-export
case is looking great and we have real world use cases that this helps
with (batch processing workloads with latencies >10ms). If we can
figure out the hanging knfsd threads, then I can test it more heavily.

Many thanks,

Daire

On Tue, 14 Jun 2022 at 00:19, NeilBrown <neilb@suse.de> wrote:
>
> VFS currently holds an exclusive lock on a directory during create,
> unlink, rename.  This imposes serialisation on all filesystems though
> some may not benefit from it, and some may be able to provide finer
> grained locking internally, thus reducing contention.
>
> This series allows the filesystem to request that the inode lock be
> shared rather than exclusive.  In that case an exclusive lock will be
> held on the dentry instead, much as is done for parallel lookup.
>
> The NFS filesystem can easily support concurrent updates (server does
> any needed serialiation) so it is converted.
>
> This series also converts nfsd to use the new interfaces so concurrent
> incoming NFS requests in the one directory can be handled concurrently.
>
> As a net result, if an NFS mounted filesystem is reexported over NFS,
> then multiple clients can create files in a single directory and all
> synchronisation will be handled on the final server.  This helps hid
> latency on link from client to server.
>
> I include a few nfsd patches that aren't strictly needed for this work,
> but seem to be a logical consequence of the changes that I did have to
> make.
>
> I have only tested this lightly.  In particular the rename support is
> quite new and I haven't tried to break it yet.
>
> I post this for general review, and hopefully extra testing...  Daire
> Byrne has expressed interest in the NFS re-export parallelism.
>
> NeilBrown
>
>
> ---
>
> NeilBrown (12):
>       VFS: support parallel updates in the one directory.
>       VFS: move EEXIST and ENOENT tests into lookup_hash_update()
>       VFS: move want_write checks into lookup_hash_update()
>       VFS: move dput() and mnt_drop_write() into done_path_update()
>       VFS: export done_path_update()
>       VFS: support concurrent renames.
>       NFS: support parallel updates in the one directory.
>       nfsd: allow parallel creates from nfsd
>       nfsd: support concurrent renames.
>       nfsd: reduce locking in nfsd_lookup()
>       nfsd: use (un)lock_inode instead of fh_(un)lock
>       nfsd: discard fh_locked flag and fh_lock/fh_unlock
>
>
>  fs/dcache.c            |  59 ++++-
>  fs/namei.c             | 578 ++++++++++++++++++++++++++++++++---------
>  fs/nfs/dir.c           |  29 ++-
>  fs/nfs/inode.c         |   2 +
>  fs/nfs/unlink.c        |   5 +-
>  fs/nfsd/nfs2acl.c      |   6 +-
>  fs/nfsd/nfs3acl.c      |   4 +-
>  fs/nfsd/nfs3proc.c     |  37 +--
>  fs/nfsd/nfs4acl.c      |   7 +-
>  fs/nfsd/nfs4proc.c     |  61 ++---
>  fs/nfsd/nfs4state.c    |   8 +-
>  fs/nfsd/nfsfh.c        |  10 +-
>  fs/nfsd/nfsfh.h        |  58 +----
>  fs/nfsd/nfsproc.c      |  31 +--
>  fs/nfsd/vfs.c          | 243 ++++++++---------
>  fs/nfsd/vfs.h          |   8 +-
>  include/linux/dcache.h |  27 ++
>  include/linux/fs.h     |   1 +
>  include/linux/namei.h  |  30 ++-
>  19 files changed, 791 insertions(+), 413 deletions(-)
>
> --
> Signature
>
