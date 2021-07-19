Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EF03CEB97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 22:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355716AbhGSRVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 13:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378034AbhGSRRU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:17:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7C1761006;
        Mon, 19 Jul 2021 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626717476;
        bh=x8x0pqYFmuT5qMTKwlfFNeYH6hS0owwPMc2CIru3JzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YCqMLshCd5VlFt6qY7ow+EPyAxC3nLUM+r5tRv+eN2i1qoVRrynw50Zyvq5YnPyhj
         Rp/iZj6ZzLGbNcw8ftnZA/xC97yDiPTbdHkI2nBxhYyxLaOQOA3Z5tPN73ax9WEfdF
         LkyKvxGu95M9mi1/Tp7zOOBw27ndzwluDyrRZ+p0NHS4M+HpEX4aSUik78mg6wHS2n
         QbeVKL6uOmJjyF0NX/8u32Qi9NXQjQXFzMT/mYryuRft7dA1wuoTqZnzQBD/X5DYzS
         bK9HN4kZHKdLNxWd1nBU7w4rnf1PVkdgpfUKp3w7ZcdUHpyIXnJmeKU8phfNbRrntH
         tfZyI3LdWvKAA==
Date:   Mon, 19 Jul 2021 10:57:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: RFC: switch iomap to an iterator model
Message-ID: <20210719175756.GM22357@magnolia>
References: <20210719103520.495450-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719103520.495450-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:34:53PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series replies the existing callback-based iomap_apply to an iter based
> model.  The prime aim here is to simply the DAX reflink support, which
> requires iterating through two inodes, something that is rather painful
> with the apply model.  It also helps to kill an indirect call per segment
> as-is.  Compared to the earlier patchset from Matthew Wilcox that this
> series is based upon it does not eliminate all indirect calls, but as the
> upside it does not change the file systems at all (except for the btrfs
> and gfs2 hooks which have slight prototype changes).

FWIW patches 9-20 look ok to me, modulo the discussion I started in
patch 8 about defining a distinct type for iomap byte lengths instead of
the combination of int/ssize_t/u64 that we use now.

> This passes basic testing on XFS for block based file systems.  The DAX
> changes are entirely untested as I haven't managed to get pmem work in
> recent qemu.

This gets increasingly difficult as time goes by.

Right now I have the following bits of libvirt xml in the vm
definitions:

  <maxMemory slots='32' unit='KiB'>1073741824</maxMemory>
  <devices>
    <memory model='nvdimm' access='shared'>
      <source>
        <path>/run/g.mem</path>
      </source>
      <target>
        <size unit='KiB'>10487808</size>
        <node>0</node>
      </target>
      <address type='dimm' slot='0'/>
    </memory>
  </devices>

Which seems to translate to:

-machine pc-q35-4.2,accel=kvm,usb=off,vmport=off,dump-guest-core=off,nvdimm=on
-object memory-backend-file,id=memnvdimm0,prealloc=no,mem-path=/run/g.mem,share=yes,size=10739515392,align=128M
-device nvdimm,memdev=memnvdimm0,id=nvdimm0,slot=0,label-size=2M

Evidently something was added to the pmem code(?) that makes it fussy if
the memory region doesn't align to a 128M boundary or the label isn't
big enough for ... whatever gets written into them.

The file /run/g.mem is intended to provide 10GB of pmem to the VM, with
an additional 2M allocated for the label.

--D

> Diffstat:
>  b/fs/btrfs/inode.c       |    5 
>  b/fs/buffer.c            |    4 
>  b/fs/dax.c               |  578 ++++++++++++++++++++++-------------------------
>  b/fs/gfs2/bmap.c         |    5 
>  b/fs/internal.h          |    4 
>  b/fs/iomap/Makefile      |    2 
>  b/fs/iomap/buffered-io.c |  344 +++++++++++++--------------
>  b/fs/iomap/direct-io.c   |  162 ++++++-------
>  b/fs/iomap/fiemap.c      |  101 +++-----
>  b/fs/iomap/iter.c        |   74 ++++++
>  b/fs/iomap/seek.c        |   88 +++----
>  b/fs/iomap/swapfile.c    |   38 +--
>  b/fs/iomap/trace.h       |   35 +-
>  b/include/linux/iomap.h  |   73 ++++-
>  fs/iomap/apply.c         |   99 --------
>  15 files changed, 777 insertions(+), 835 deletions(-)
