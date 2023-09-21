Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDE57A9D4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 21:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjIUTay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 15:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjIUTaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:30:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59FCAC3F5;
        Thu, 21 Sep 2023 11:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vErG3G/K3AqAB4znqP4ThVB4iAxIOfZKaXeg0HfCYKg=; b=wuVbmqedMJbd0yLDqcdC0AmSKG
        lepZZHUbfAjO84sVW+3B9JnTZG/RGkQDpI9X7Tk1EkjgAJYUKSIKJKNot2xWoLHxWb9/jyFi5xwQn
        ja3dZdcLBLYLAfgzKrNr2mZUntKwWCARqSHAxOi7GWGqtwRFAgbJCjckKv78SdI4htm9wSmJYfHpx
        B3SvAUsFfEKnTztU/HgpJc+hAbWTo1qXRni69z3L+P0yT8Uxz4U08ggFl50MRmQPuGFKRgN70Euku
        77VOZlCkmonvI7O1xTKZrjyfYPWcL4ZCrH+txjVby8hKwZOFA/jFziPQYu41kY9RNG0Ip/gTqi4M6
        s2MxesMQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qjBlF-0056ZC-03;
        Thu, 21 Sep 2023 04:57:57 +0000
Date:   Wed, 20 Sep 2023 21:57:56 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Pankaj Raghav <kernel@pankajraghav.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        da.gomez@samsung.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        gost.dev@samsung.com, riteshh@linux.ibm.com
Subject: Re: [RFC 00/23] Enable block size > page size in XFS
Message-ID: <ZQvNVAfZMjE3hgmN@bombadil.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <ZQd4IPeVI+o6M38W@dread.disaster.area>
 <ZQewKIfRYcApEYXt@bombadil.infradead.org>
 <CGME20230918050749eucas1p13c219481b4b08c1d58e90ea70ff7b9c8@eucas1p1.samsung.com>
 <ZQfbHloBUpDh+zCg@dread.disaster.area>
 <806df723-78cf-c7eb-66a6-1442c02126b3@samsung.com>
 <ZQuxvAd2lxWppyqO@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQuxvAd2lxWppyqO@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 08:00:12PM -0700, Luis Chamberlain wrote:
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=large-block-linus
> 
> I haven't tested yet the second branch I pushed though but it applied without any changes
> so it should be good (usual famous last words).

I have run some preliminary tests on that branch as well above using fsx
with larger LBA formats running them all on the *same* system at the
same time. Kernel is happy.

root@linus ~ # uname -r
6.6.0-rc2-large-block-linus+

root@linus ~ # mount | grep mnt
/dev/nvme17n1 on /mnt-16k type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/nvme13n1 on /mnt-32k-16ks type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/nvme11n1 on /mnt-64k-16ks type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=64k,noquota)
/dev/nvme18n1 on /mnt-32k type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/nvme14n1 on /mnt-64k-32ks type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=64k,noquota)
/dev/nvme7n1 on /mnt-64k-512b type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/nvme4n1 on /mnt-32k-512 type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/nvme3n1 on /mnt-16k-512b type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/nvme9n1 on /mnt-64k-4ks type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=64k,noquota)
/dev/nvme8n1 on /mnt-32k-4ks type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/nvme6n1 on /mnt-16k-4ks type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/nvme5n1 on /mnt-4k type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/nvme1n1 on /mnt-512 type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)

root@linus ~ # ps -ef| grep fsx
root       45601   45172 44 04:02 pts/3    00:20:26 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-16k/foo
root       46207   45658 39 04:04 pts/5    00:17:18 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-32k-16ks/foo
root       46792   46289 35 04:06 pts/7    00:14:36 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-64k-16ks/foo
root       47293   46899 39 04:08 pts/9    00:15:30 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-32k/foo
root       47921   47338 34 04:10 pts/11   00:12:56 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-64k-32ks/foo
root       48898   48484 32 04:14 pts/13   00:10:56 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-64k-512b/foo
root       49313   48939 35 04:15 pts/15   00:11:38 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-32k-512/foo
root       49729   49429 40 04:17 pts/17   00:12:27 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-16k-512b/foo
root       50085   49794 33 04:18 pts/19   00:09:56 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-64k-4ks/foo
root       50449   50130 36 04:19 pts/21   00:10:28 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-32k-4ks/foo
root       50844   50517 41 04:20 pts/23   00:11:22 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-16k-4ks/foo
root       51135   50893 52 04:21 pts/25   00:13:57 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-4k/foo
root       52061   51193 49 04:25 pts/27   00:11:21 /var/lib/xfstests/ltp/fsx -q -S 0 -p 1000000 /mnt-512/foo
root       57668   52131  0 04:48 pts/29   00:00:00 grep fsx


root@linuslbs ~ # grep XFS /boot/config-6.6.0-rc2-large-block-linus-nobdev+ 
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
# CONFIG_XFS_SUPPORT_ASCII_CI is not set
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_DRAIN_INTENTS=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_SCRUB_STATS=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_VXFS_FS is not set

root@linuslbs ~ # grep DEBUG_VM /boot/config-6.6.0-rc2-large-block-linus-nobdev+ 
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
# CONFIG_DEBUG_VM_PGTABLE is not set

And the status gets updated then:

https://docs.google.com/spreadsheets/d/e/2PACX-1vSA6z8C3u0WsiU2EtJNM7O_1n1-_4DYz66s53DbSuNTDDboi70EsR0hSmeogCCjqieBqALmRJ2AIKBW/pubhtml

We will run fstests for all profiles as well, but figured I'd at
least mention a quick test on the linus branch which also adds
the coex stuff.

  Luis
