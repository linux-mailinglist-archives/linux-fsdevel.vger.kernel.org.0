Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33384778751
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 08:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjHKGQ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 02:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjHKGQZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:16:25 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE122D4F
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 23:16:24 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-44781abd5a8so694714137.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 23:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691734584; x=1692339384;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k63lmr8I7sqJPk2JhZZQWH3JdgVkDU1otw9D0h7AzuA=;
        b=E2x0gdiZ/pVqLIYLGDDCsoEUQDDNoRjtt/iz1R4NSiJbFmar3d8Hlx15JCkUvScQcI
         9ShucdHVB0T9WfJex6c/wKRuJ8RgOs4dVHKsG8poxSCu9vn/Hx8hijITVVhvfSyKcCeM
         lKGgZQlmO4qUZ7jtmJs/1QXeru4VG46rfhrsf+mTagfiekkU4mrrlW0GCFgjEvGdkYMW
         mPrYc/hTApWZMhZs07bbywG9yZEZL99xflTrQXruEkM6bI1xaaBlMOj22kbfEoNDaGRu
         4Ihw2fthsxGpUFQQVnWuwg+/BNfseTasvt4/GkWRvFCtyHnxZSu3P+9oeha1WPGZ6kvB
         JmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691734584; x=1692339384;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k63lmr8I7sqJPk2JhZZQWH3JdgVkDU1otw9D0h7AzuA=;
        b=VfXu+YFgiJjydtXLV7taflACOv92CGMxcXgvjQZU2oTcFFcekF6/xl+SrrGPJFaLdl
         mHlPJ49e8eTvyOBBBq5bVi8X2FT2Z4LgtMDvF1Pqo1g+uLM2WQWW5JiyD/kYyH3WzyLz
         Vno9Et2QmDq1v6NNdL4HjMVh6kk3SvBf+dJ1QCHLeKNSn4CyzcknH6+zUQvmsgFmhgqz
         XsnU7SL8CSh+e2RCkQvVQ4ahK5/Y/Nd9+RdJF0Yj5cz5Idb+GYasDIQFwxZbUZbP8k/y
         wLAUWc64GM5Q4aFW0ui1Yutc8J7r/wag/1Q1JRPliwHaBQDivtFCR1xSCIE9HnAveAgJ
         afig==
X-Gm-Message-State: AOJu0YzlaCXwzd4SWgd8n6gVE4Rh8hKFMrlvdfvke7ZZALgXekqmp7Nq
        2DElV9YLlcUxkYinj66/YUfI2A==
X-Google-Smtp-Source: AGHT+IGKZO8zd/JD5KljLPxbp3udF/OyhU30sxa+eu8czKTLWgnV1zl64yRaOhp2KRRBQ4LGpsIRfg==
X-Received: by 2002:a67:ffd1:0:b0:443:6afe:e842 with SMTP id w17-20020a67ffd1000000b004436afee842mr592456vsq.35.1691734583817;
        Thu, 10 Aug 2023 23:16:23 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o124-20020a254182000000b00d1f0204c1b6sm770452yba.27.2023.08.10.23.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 23:16:23 -0700 (PDT)
Date:   Thu, 10 Aug 2023 23:16:20 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Darrick J. Wong" <djwong@kernel.org>
cc:     Christoph Hellwig <hch@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs 4/5] tmpfs: trivial support for direct IO
In-Reply-To: <20230810234124.GH11336@frogsfrogsfrogs>
Message-ID: <5d913a4-a118-1218-25f2-32709b3e618@google.com>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com> <7c12819-9b94-d56-ff88-35623aa34180@google.com> <ZNOXfanlsgTrAsny@infradead.org> <20230810234124.GH11336@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 10 Aug 2023, Darrick J. Wong wrote:
> On Wed, Aug 09, 2023 at 06:41:17AM -0700, Christoph Hellwig wrote:
> > Please do not add a new ->direct_IO method.  I'm currently working hard
> > on removing it, just set FMODE_CAN_ODIRECT and handle the fallback in
> > your read_iter/write_iter methods.
> > 
> > But if we just start claiming direct I/O support for file systems that
> > don't actually support it, I'm starting to seriously wonder why we
> > bother with the flag at all and don't just allow O_DIRECT opens
> > to always succeed..
> 
> I see it differently -- you can do byte-aligned directio to S_DAX files
> on persistent memory, so I don't see why you can't do that for tmpfs
> files too.

Helpful support, thanks.  But I didn't read Christoph as unhappy with
the granularity issue: just giving me directIOn to FMODE_CAN_ODIRECT,
and rightly wondering why we ever fail O_DIRECTs.

Hugh

> 
> (I'm not advocating for letting *disk* based filesystems allow O_DIRECT
> even if read and writes are always going to go through the page cache
> and get flushed to disk.  If programs wanted that, they'd use O_SYNC.)
> 
> /mnt is a pmem filesystem, /mnt/on/file has S_DAX set, and /mnt/off/file
> does not:
> 
> # xfs_io -c statx /mnt/{on,off}/file
> fd.path = "/mnt/on/file"
> fd.flags = non-sync,non-direct,read-write
> stat.ino = 132
> stat.type = regular file
> stat.size = 1048576
> stat.blocks = 2048
> fsxattr.xflags = 0x8002 [-p------------x--]
> fsxattr.projid = 0
> fsxattr.extsize = 0
> fsxattr.cowextsize = 0
> fsxattr.nextents = 1
> fsxattr.naextents = 0
> dioattr.mem = 0x200
> dioattr.miniosz = 512
> dioattr.maxiosz = 2147483136
> fd.path = "/mnt/off/file"
> fd.flags = non-sync,non-direct,read-write
> stat.ino = 8388737
> stat.type = regular file
> stat.size = 1048576
> stat.blocks = 2048
> fsxattr.xflags = 0x2 [-p---------------]
> fsxattr.projid = 0
> fsxattr.extsize = 0
> fsxattr.cowextsize = 0
> fsxattr.nextents = 1
> fsxattr.naextents = 0
> dioattr.mem = 0x200
> dioattr.miniosz = 512
> dioattr.maxiosz = 2147483136
> 
> And now we try a byte-aligned direct write:
> 
> # xfs_io -d -c 'pwrite -S 0x58 47 1' /mnt/off/file
> pwrite: Invalid argument
> # xfs_io -d -c 'pwrite -S 0x58 47 1' /mnt/on/file
> wrote 1/1 bytes at offset 47
> 1.000000 bytes, 1 ops; 0.0001 sec (5.194 KiB/sec and 5319.1489 ops/sec)
> 
> --D
