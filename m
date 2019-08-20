Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51A3695CDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 13:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbfHTLFS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 07:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729553AbfHTLFS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:05:18 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFF55205C9;
        Tue, 20 Aug 2019 11:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566299116;
        bh=T0rmHh8w3H3bwdXLru7KFY2A/8hjJcNt2eMc9MdFvoU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OWYdJNUzSee+UuIh6LQ3YFru0x6seE2TTCifysIDGNOjR8O4ScYkdj2Vrw5S/JeTB
         qmDzLYeDaoNBfNwX5IDihFikAWZqI1dzLhII85Qm3JJy6zIH2yIFue45EEMtXZPwcN
         fgzdH+WlULgP+SUhyw7NDBScX/I9XuZMIU+ITkEg=
Message-ID: <27d1943a0027cb4f658334fad8dc880df133c22d.camel@kernel.org>
Subject: Re: [PATCH v8 00/20] vfs: Add support for timestamp limits
From:   Jeff Layton <jlayton@kernel.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de, adilger.kernel@dilger.ca, adrian.hunter@intel.com,
        aivazian.tigran@gmail.com, al@alarsen.net,
        anna.schumaker@netapp.com, anton@enomsg.org,
        asmadeus@codewreck.org, ccross@android.com,
        ceph-devel@vger.kernel.org, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, darrick.wong@oracle.com,
        dedekind1@gmail.com, devel@lists.orangefs.org, dsterba@suse.com,
        dushistov@mail.ru, dwmw2@infradead.org, ericvh@gmail.com,
        gregkh@linuxfoundation.org, hch@infradead.org, hch@lst.de,
        hirofumi@mail.parknet.co.jp, hubcap@omnibond.com,
        idryomov@gmail.com, jack@suse.com, jaegeuk@kernel.org,
        jaharkes@cs.cmu.edu, jfs-discussion@lists.sourceforge.net,
        jlbec@evilplan.org, keescook@chromium.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        lucho@ionkov.net, luisbg@kernel.org, martin@omnibond.com,
        me@bobcopeland.com, mikulas@artax.karlin.mff.cuni.cz,
        nico@fluxnic.net, phillip@squashfs.org.uk,
        reiserfs-devel@vger.kernel.org, richard@nod.at, sage@redhat.com,
        salah.triki@gmail.com, sfrench@samba.org, shaggy@kernel.org,
        tj@kernel.org, tony.luck@intel.com,
        trond.myklebust@hammerspace.com, tytso@mit.edu,
        v9fs-developer@lists.sourceforge.net, yuchao0@huawei.com,
        zyan@redhat.com
Date:   Tue, 20 Aug 2019 07:05:10 -0400
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2019-08-18 at 09:57 -0700, Deepa Dinamani wrote:
> The series is an update and a more complete version of the
> previously posted series at
> https://lore.kernel.org/linux-fsdevel/20180122020426.2988-1-deepa.kernel@gmail.com/
> 
> Thanks to Arnd Bergmann for doing a few preliminary reviews.
> They helped me fix a few issues I had overlooked.
> 
> The limits (sometimes granularity also) for the filesystems updated here are according to the
> following table:
> 
> File system   Time type                      Start year Expiration year Granularity
> cramfs        fixed                          0          0
> romfs         fixed                          0          0
> pstore        ascii seconds (27 digit ascii) S64_MIN    S64_MAX         1
> coda          INT64                          S64_MIN    S64_MAX         1
> omfs          64-bit milliseconds            0          U64_MAX/ 1000   NSEC_PER_MSEC
> befs          unsigned 48-bit seconds        0          0xffffffffffff  alloc_super
> bfs           unsigned 32-bit seconds        0          U32_MAX         alloc_super
> efs           unsigned 32-bit seconds        0          U32_MAX         alloc_super
> ext2          signed 32-bit seconds          S32_MIN    S32_MAX         alloc_super
> ext3          signed 32-bit seconds          S32_MIN    S32_MAX         alloc_super
> ext4 (old)    signed 32-bit seconds          S32_MIN    S32_MAX         alloc_super
> ext4 (extra)  34-bit seconds, 30-bit ns      S32_MIN    0x37fffffff	1
> freevxfs      u32 secs/usecs                 0          U32_MAX         alloc_super
> jffs2         unsigned 32-bit seconds        0          U32_MAX         alloc_super
> jfs           unsigned 32-bit seconds/ns     0          U32_MAX         1
> minix         unsigned 32-bit seconds        0          U32_MAX         alloc_super
> orangefs      u64 seconds                    0          U64_MAX         alloc_super
> qnx4          unsigned 32-bit seconds        0          U32_MAX         alloc_super
> qnx6          unsigned 32-bit seconds        0          U32_MAX         alloc_super
> reiserfs      unsigned 32-bit seconds        0          U32_MAX         alloc_super
> squashfs      unsigned 32-bit seconds        0          U32_MAX         alloc_super
> ufs1          signed 32-bit seconds          S32_MIN    S32_MAX         NSEC_PER_SEC
> ufs2          signed 64-bit seconds/u32 ns   S64_MIN    S64_MAX         1
> xfs           signed 32-bit seconds/ns       S32_MIN    S32_MAX         1
> ceph          unsigned 32-bit second/ns      0          U32_MAX         1000

Looks reasonable, overall.

Note that the granularity changed recently for cephfs. See commit
0f7cf80ae96c2a (ceph: initialize superblock s_time_gran to 1).

In any case, you can add my Acked-by

-- 
Jeff Layton <jlayton@kernel.org>

