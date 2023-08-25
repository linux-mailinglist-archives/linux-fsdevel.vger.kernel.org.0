Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7DD7888AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 15:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245139AbjHYNdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 09:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245082AbjHYNdC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:33:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3FB1FF0;
        Fri, 25 Aug 2023 06:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D58567A14;
        Fri, 25 Aug 2023 13:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70AEC433C8;
        Fri, 25 Aug 2023 13:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692970379;
        bh=T3WCgKJR+2I3SNciRzSe5NGE9AO6KZcdR6qXwGAgd9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BOzM2QQ1MZDAriB3IMOamPdHV+2S3m2FC6tyT1pwI/9DF+WhlbPxDXE6fFDwe1gQn
         nTHB+ewwdyxJVq1cwfq3lRDi07qJcCHvh+nPPtQwtyRFhMG1ktBk1+a5CxpNbFHlMo
         Es+8l14bPK+nfmT+9Vs7IvZUfkPWFzk8wOkU0sT7FJdKR3BT4c1FwZN9woHNBuu5tc
         jHLMCNsuGW/YHncoWpwLVgQ93zfRJ93+ghRIza8tLelTozCObl43Fv+mmuqvzrkB+C
         SdJZ6/x4IFa4j6NBHHUKQ0uLY4RqtzEgYesuRGMfUi0q6xmwPRpi/3TpKuwt6YF2IT
         8BYUF/YAoocgw==
Date:   Fri, 25 Aug 2023 15:32:47 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Alasdair Kergon <agk@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anna Schumaker <anna@kernel.org>, Chao Yu <chao@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, Gao Xiang <xiang@kernel.org>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Joern Engel <joern@lazybastard.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Minchan Kim <minchan@kernel.org>, ocfs2-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Song Liu <song@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        target-devel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 0/29] block: Make blkdev_get_by_*() return handle
Message-ID: <20230825-hubraum-gedreht-8c5c4db9330a@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:11PM +0200, Jan Kara wrote:
> Hello,
> 
> this is a v3 of the patch series which implements the idea of blkdev_get_by_*()
> calls returning bdev_handle which is then passed to blkdev_put() [1]. This
> makes the get and put calls for bdevs more obviously matching and allows us to
> propagate context from get to put without having to modify all the users
> (again!). In particular I need to propagate used open flags to blkdev_put() to
> be able count writeable opens and add support for blocking writes to mounted
> block devices. I'll send that series separately.
> 
> The series is based on Christian's vfs tree as of today as there is quite
> some overlap. Patches have passed some reasonable testing - I've tested block
> changes, md, dm, bcache, xfs, btrfs, ext4, swap. More testing or review is
> always welcome. Thanks! I've pushed out the full branch to:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git bdev_handle
> 
> to ease review / testing. Since there were not many comments for v2 and
> Christoph has acked the series I think we should start discussing how to merge
> the series. Most collisions with this series seem to happen in the filesystems
> area so VFS tree would seem as the least painful way to merge this. Jens,

I really do like this series especially struct bdev_handle and moving
the mode bits in there. I'll happily take this. So far there have only
been minor things that can easily be fixed.
