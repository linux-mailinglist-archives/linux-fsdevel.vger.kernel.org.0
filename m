Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16649705B14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 01:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjEPXPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 19:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjEPXPl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 19:15:41 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC0F4EF9
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 16:15:39 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64ab2a37812so9104178b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 16:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684278939; x=1686870939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ComBD5cVSZXxb8CF1oU6ofe5UBMPl0+rt3cWiD9Tacg=;
        b=nQDi6NYrzWKrK0bA4GjAg3dfl3oHSpMlCxu4FLE1nnFNWHCjuRLMFhBS9Nqwu8kjjn
         1Cl5BHAOoCd5zi7pqEenAcLKhi8pm72XFABs6sCcMumuOF52ZsWEZ8gjFp/qcKgkHe/t
         OuWN2+FkrNqC1e+TUc0aTRu4ojycowYVSnRuMA0XNS3ZbgOnKaE2SjNZJx3J/D/8NBgU
         arE7TsWhDx5uCTWpuNMzDwYmSGQXfjQ/5y2YrYDo9TzLOk5QoIjGoezXygUQiRKNlinI
         sRBGrWIzZmfKupV+Ufgs9EskGsOUt5Ti6pfL3Jl4Wsc3n8rUbs9HvypBXUOFyzfux9Li
         ooDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684278939; x=1686870939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ComBD5cVSZXxb8CF1oU6ofe5UBMPl0+rt3cWiD9Tacg=;
        b=IrAkcyCAltEI73L9NdjYDYws0aKwfy2X3Dip1ZaMsu3meHdK++18Rw58BFZstjoGjw
         v6/Rz3yR9wBByxndX/HmJiCLkAsVDe27zTYls9lJprHbwxPKbQAyOBHLcPXJp0NkCG0I
         WxEvx0UvOMwDE6P13mF8+ouo7Ui0/PGAOPFZVg0a0r/3gHoKEuT4kmULLHPut7AodKLP
         F8dqZT2tF7C3m8cJ4qectaJuMtIQvRh4uVu+wx2U7VcTyFRGqkvO6Rxob4soY4JBGvX7
         F003hiJnQJozAypE67KUvD1EuPGce5u8ChZsqsP/oXlip2umliPh+6VlXun+5yGpqalN
         jGUw==
X-Gm-Message-State: AC+VfDzWAk6KyteW37K6D8cvNF+FBD8ckHYfu/8CKf+iYCfoqQL4Fos6
        kLC2loGeswpQqC+FqKjquvT+qycvA9EDJGq4abI=
X-Google-Smtp-Source: ACHHUZ4gosaB6ODsKvk2XDn1AJsJpl9jEWJVUpQm58NAxF/3RNS7MtlM6w4/fMxX3zUVwJKoPCNW6A==
X-Received: by 2002:a05:6a00:238c:b0:64b:e8:24ff with SMTP id f12-20020a056a00238c00b0064b00e824ffmr367750pfc.17.1684278939473;
        Tue, 16 May 2023 16:15:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b0063799398eaesm13840532pfi.51.2023.05.16.16.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 16:15:38 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1pz3tG-000KiC-28;
        Wed, 17 May 2023 09:15:34 +1000
Date:   Wed, 17 May 2023 09:15:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 22/32] vfs: inode cache conversion to hash-bl
Message-ID: <ZGQOlrcvLplTfZmf@dread.disaster.area>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-23-kent.overstreet@linux.dev>
 <20230510044557.GF2651828@dread.disaster.area>
 <20230516-brand-hocken-a7b5b07e406c@brauner>
 <ZGOsgI7a68mWYVQH@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGOsgI7a68mWYVQH@moria.home.lan>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 12:17:04PM -0400, Kent Overstreet wrote:
> On Tue, May 16, 2023 at 05:45:19PM +0200, Christian Brauner wrote:
> > On Wed, May 10, 2023 at 02:45:57PM +1000, Dave Chinner wrote:
> > There's a bit of a backlog before I get around to looking at this but
> > it'd be great if we'd have a few reviewers for this change.
> 
> It is well tested - it's been in the bcachefs tree for ages with zero
> issues. I'm pulling it out of the bcachefs-prerequisites series though
> since Dave's still got it in his tree, he's got a newer version with
> better commit messages.
> 
> It's a significant performance boost on metadata heavy workloads for any
> non-XFS filesystem, we should definitely get it in.

I've got an up to date vfs-scale tree here (6.4-rc1) but I have not
been able to test it effectively right now because my local
performance test server is broken. I'll do what I can on the old
small machine that I have to validate it when I get time, but that
might be a few weeks away....

git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs.git vfs-scale

As it is, the inode hash-bl changes have zero impact on XFS because
it has it's own highly scalable lockless, sharded inode cache. So
unless I'm explicitly testing ext4 or btrfs scalability (rare) it's
not getting a lot of scalability exercise. It is being used by the
root filesytsems on all those test VMs, but that's about it...

That said, my vfs-scale tree also has Waiman Long's old dlist code
(per cpu linked list) which converts the sb inode list and removes
the global lock there. This does make a huge impact for XFS - the
current code limits inode cache cycling to about 600,000 inodes/sec
on >=16p machines. With dlists, however:

| 5.17.0 on a XFS filesystem with 50 million inodes in it on a 32p
| machine with a 1.6MIOPS/6.5GB/s block device.
| 
| Fully concurrent full filesystem bulkstat:
| 
| 		wall time	sys time	IOPS	BW	rate
| unpatched:	1m56.035s	56m12.234s	 8k     200MB/s	0.4M/s
| patched:	0m15.710s	 3m45.164s	70k	1.9GB/s 3.4M/s
| 
| Unpatched flat kernel profile:
| 
|   81.97%  [kernel]  [k] __pv_queued_spin_lock_slowpath
|    1.84%  [kernel]  [k] do_raw_spin_lock
|    1.33%  [kernel]  [k] __raw_callee_save___pv_queued_spin_unlock
|    0.50%  [kernel]  [k] memset_erms
|    0.42%  [kernel]  [k] do_raw_spin_unlock
|    0.42%  [kernel]  [k] xfs_perag_get
|    0.40%  [kernel]  [k] xfs_buf_find
|    0.39%  [kernel]  [k] __raw_spin_lock_init
| 
| Patched flat kernel profile:
| 
|   10.90%  [kernel]  [k] do_raw_spin_lock
|    7.21%  [kernel]  [k] __raw_callee_save___pv_queued_spin_unlock
|    3.16%  [kernel]  [k] xfs_buf_find
|    3.06%  [kernel]  [k] rcu_segcblist_enqueue
|    2.73%  [kernel]  [k] memset_erms
|    2.31%  [kernel]  [k] __pv_queued_spin_lock_slowpath
|    2.15%  [kernel]  [k] __raw_spin_lock_init
|    2.15%  [kernel]  [k] do_raw_spin_unlock
|    2.12%  [kernel]  [k] xfs_perag_get
|    1.93%  [kernel]  [k] xfs_btree_lookup

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
