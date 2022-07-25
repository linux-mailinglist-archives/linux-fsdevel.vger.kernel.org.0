Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10E7580638
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jul 2022 23:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbiGYVOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jul 2022 17:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiGYVOr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:14:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7802251F;
        Mon, 25 Jul 2022 14:14:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5883EB80189;
        Mon, 25 Jul 2022 21:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047CAC341C6;
        Mon, 25 Jul 2022 21:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658783684;
        bh=+wQ2Az6oPzLkVRx28aSMoR3J3b58/GSALTbxCWbip/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=naEymMmXfJJgKJ3ABSMtgg9U/zPhepmDYQpAMN/6Y5UZFnvJAYmQoH+y+4Ejru14U
         MbsSgxfWE5frcgz9yEapDpxx78YOKpgNaSJsCuKp5mNid2wQpkv7dldLbR9beaB5Rl
         xRtxxO+oLI2Fm9abqREZTY2MpUFf2ohf6pewrdGJzruLHNbDBLO3usNxrbFGh52eGw
         nnkWtnTAzVjgmw4sFCoErulwH/XkCiObo81JEsa6JUJG1+YOkdkFvofyqOqKNkQM7x
         b6Fr+0hF8FUgxRmG3xOhg4gLCMu2TCf6XdCPTN+Kv6Dg5999v47zHAQMbhl8R2a/vl
         ck9tcz25eta+Q==
Date:   Mon, 25 Jul 2022 14:14:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Li Jinlin <lijinlin3@huawei.com>
Cc:     viro@zeniv.linux.org.uk, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
Subject: Re: [PATCH] fsdax: Fix infinite loop in dax_iomap_rw()
Message-ID: <Yt8Hw2cXPz1ScQ1y@magnolia>
References: <20220725032050.3873372-1-lijinlin3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725032050.3873372-1-lijinlin3@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 25, 2022 at 11:20:50AM +0800, Li Jinlin wrote:
> I got an infinite loop and a WARNING report when executing a tail command
> in virtiofs.
> 
>   WARNING: CPU: 10 PID: 964 at fs/iomap/iter.c:34 iomap_iter+0x3a2/0x3d0
>   Modules linked in:
>   CPU: 10 PID: 964 Comm: tail Not tainted 5.19.0-rc7
>   Call Trace:
>   <TASK>
>   dax_iomap_rw+0xea/0x620
>   ? __this_cpu_preempt_check+0x13/0x20
>   fuse_dax_read_iter+0x47/0x80
>   fuse_file_read_iter+0xae/0xd0
>   new_sync_read+0xfe/0x180
>   ? 0xffffffff81000000
>   vfs_read+0x14d/0x1a0
>   ksys_read+0x6d/0xf0
>   __x64_sys_read+0x1a/0x20
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> The tail command will call read() with a count of 0. In this case,
> iomap_iter() will report this WARNING, and always return 1 which casuing
> the infinite loop in dax_iomap_rw().
> 
> Fixing by checking count whether is 0 in dax_iomap_rw().
> 
> Fixes: ca289e0b95af ("fsdax: switch dax_iomap_rw to use iomap_iter")
> Signed-off-by: Li Jinlin <lijinlin3@huawei.com>

Huh, I didn't know FUSE supports DAX and iomap now...

> ---
>  fs/dax.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 4155a6107fa1..7ab248ed21aa 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1241,6 +1241,9 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	loff_t done = 0;
>  	int ret;
>  
> +	if (!iomi.len)
> +		return 0;

Hmm, most of the callers of dax_iomap_rw skip the whole call if
iov_iter_count(to)==0, so I wonder if fuse_dax_read_iter should do the
same?

That said, iomap_dio_rw bails early if you pass it iomi.len, so I don't
have any real objections to this.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> +
>  	if (iov_iter_rw(iter) == WRITE) {
>  		lockdep_assert_held_write(&iomi.inode->i_rwsem);
>  		iomi.flags |= IOMAP_WRITE;
> -- 
> 2.30.2
> 
