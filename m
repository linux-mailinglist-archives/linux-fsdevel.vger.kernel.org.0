Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CF7778438
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 01:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHJXl2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 19:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHJXl1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:41:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC2C271E
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 16:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A05B60BBD
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 23:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B3EC433C7;
        Thu, 10 Aug 2023 23:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691710885;
        bh=Y1kWoKWlcA+XrKaXzoE45uKmAhUYXgJ2vtEmvg5+vJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/a4uUP6VEEQElT1YCD2UCVhl8a393t9jHRlhMPMWT4CopjEJdgzv7vUPtgPUrKJh
         coJ/+seP/PnMDWfcE2Zt9DyAedpexKdAsHJ5/fy4s0QYLQA3mqHRWzjFi/js13xvo+
         5SPNq44+wKD1ii/W2FsRmR1mEKBr7OyLgHws6ij4+dOPgwwEFzY87RbBH0UAHbsLZ5
         7Ia1dZFXjcdX3vTblH+N//+mE/d49NWJN5Kik0t1oDKJtupkyjBi3+YLzqR2BJiu/L
         bxQM1mgXx0bjALXg8xa44Ik8B54gOehYFi9Kx20E9rar35AnHwHWMie5XBNrQRZ4uO
         0/1a9bH8+wfIA==
Date:   Thu, 10 Aug 2023 16:41:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
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
Message-ID: <20230810234124.GH11336@frogsfrogsfrogs>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
 <7c12819-9b94-d56-ff88-35623aa34180@google.com>
 <ZNOXfanlsgTrAsny@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNOXfanlsgTrAsny@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 09, 2023 at 06:41:17AM -0700, Christoph Hellwig wrote:
> Please do not add a new ->direct_IO method.  I'm currently working hard
> on removing it, just set FMODE_CAN_ODIRECT and handle the fallback in
> your read_iter/write_iter methods.
> 
> But if we just start claiming direct I/O support for file systems that
> don't actually support it, I'm starting to seriously wonder why we
> bother with the flag at all and don't just allow O_DIRECT opens
> to always succeed..

I see it differently -- you can do byte-aligned directio to S_DAX files
on persistent memory, so I don't see why you can't do that for tmpfs
files too.

(I'm not advocating for letting *disk* based filesystems allow O_DIRECT
even if read and writes are always going to go through the page cache
and get flushed to disk.  If programs wanted that, they'd use O_SYNC.)

/mnt is a pmem filesystem, /mnt/on/file has S_DAX set, and /mnt/off/file
does not:

# xfs_io -c statx /mnt/{on,off}/file
fd.path = "/mnt/on/file"
fd.flags = non-sync,non-direct,read-write
stat.ino = 132
stat.type = regular file
stat.size = 1048576
stat.blocks = 2048
fsxattr.xflags = 0x8002 [-p------------x--]
fsxattr.projid = 0
fsxattr.extsize = 0
fsxattr.cowextsize = 0
fsxattr.nextents = 1
fsxattr.naextents = 0
dioattr.mem = 0x200
dioattr.miniosz = 512
dioattr.maxiosz = 2147483136
fd.path = "/mnt/off/file"
fd.flags = non-sync,non-direct,read-write
stat.ino = 8388737
stat.type = regular file
stat.size = 1048576
stat.blocks = 2048
fsxattr.xflags = 0x2 [-p---------------]
fsxattr.projid = 0
fsxattr.extsize = 0
fsxattr.cowextsize = 0
fsxattr.nextents = 1
fsxattr.naextents = 0
dioattr.mem = 0x200
dioattr.miniosz = 512
dioattr.maxiosz = 2147483136

And now we try a byte-aligned direct write:

# xfs_io -d -c 'pwrite -S 0x58 47 1' /mnt/off/file
pwrite: Invalid argument
# xfs_io -d -c 'pwrite -S 0x58 47 1' /mnt/on/file
wrote 1/1 bytes at offset 47
1.000000 bytes, 1 ops; 0.0001 sec (5.194 KiB/sec and 5319.1489 ops/sec)

--D
