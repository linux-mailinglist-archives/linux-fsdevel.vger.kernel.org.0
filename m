Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD2895D7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 13:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfHTLfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 07:35:25 -0400
Received: from mail.alarsen.net ([144.76.18.233]:41056 "EHLO mail.alarsen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbfHTLfZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:35:25 -0400
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2019 07:35:24 EDT
Received: from oscar.alarsen.net (unknown [IPv6:2001:470:1f0b:246:3924:9405:bfa9:9e67])
        by joe.alarsen.net (Postfix) with ESMTPS id E9D242B80E32;
        Tue, 20 Aug 2019 13:28:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
        t=1566300504; bh=mDk8OlCGIB6EhD5weVd+fJ6RnWW2vsYjn5UPSJ49uVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SEh2P2AZ2TnUVaY61ToGPfeBiJ9MSzdTp97WuG6X/ffbN9fYq6MysDpCQT3EX4Yf0
         xicb80NRjLi5IbI5SarXz2OYSswAH8TKM+qJCIeP+idML96WA5znjZZVoEOG5kB8O2
         qXeM0uhYorlnqqauep/RqWer5HjmA4IP1WCerrMs=
Received: from oscar.localnet (localhost [IPv6:::1])
        by oscar.alarsen.net (Postfix) with ESMTP id 4117F27C0945;
        Tue, 20 Aug 2019 13:28:23 +0200 (CEST)
From:   Anders Larsen <al@alarsen.net>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de, aivazian.tigran@gmail.com, coda@cs.cmu.edu,
        darrick.wong@oracle.com, dushistov@mail.ru, dwmw2@infradead.org,
        hch@infradead.org, jack@suse.com, jaharkes@cs.cmu.edu,
        luisbg@kernel.org, nico@fluxnic.net, phillip@squashfs.org.uk,
        richard@nod.at, salah.triki@gmail.com, shaggy@kernel.org,
        linux-xfs@vger.kernel.org, codalist@coda.cs.cmu.edu,
        linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org,
        jfs-discussion@lists.sourceforge.net,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH v8 06/20] fs: Fill in max and min timestamps in superblock
Date:   Tue, 20 Aug 2019 13:28:23 +0200
Message-ID: <10056508.664JITJLOY@alarsen.net>
In-Reply-To: <20190818165817.32634-7-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com> <20190818165817.32634-7-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sunday, 2019-08-18 18:58 Deepa Dinamani wrote:
> Fill in the appropriate limits to avoid inconsistencies
> in the vfs cached inode times when timestamps are
> outside the permitted range.
> 
> Even though some filesystems are read-only, fill in the
> timestamps to reflect the on-disk representation.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: aivazian.tigran@gmail.com
> Cc: al@alarsen.net
> Cc: coda@cs.cmu.edu
> Cc: darrick.wong@oracle.com
> Cc: dushistov@mail.ru
> Cc: dwmw2@infradead.org
> Cc: hch@infradead.org
> Cc: jack@suse.com
> Cc: jaharkes@cs.cmu.edu
> Cc: luisbg@kernel.org
> Cc: nico@fluxnic.net
> Cc: phillip@squashfs.org.uk
> Cc: richard@nod.at
> Cc: salah.triki@gmail.com
> Cc: shaggy@kernel.org
> Cc: linux-xfs@vger.kernel.org
> Cc: codalist@coda.cs.cmu.edu
> Cc: linux-ext4@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org
> Cc: jfs-discussion@lists.sourceforge.net
> Cc: reiserfs-devel@vger.kernel.org
> ---
>  fs/befs/linuxvfs.c       | 2 ++
>  fs/bfs/inode.c           | 2 ++
>  fs/coda/inode.c          | 3 +++
>  fs/cramfs/inode.c        | 2 ++
>  fs/efs/super.c           | 2 ++
>  fs/ext2/super.c          | 2 ++
>  fs/freevxfs/vxfs_super.c | 2 ++
>  fs/jffs2/fs.c            | 3 +++
>  fs/jfs/super.c           | 2 ++
>  fs/minix/inode.c         | 2 ++
>  fs/qnx4/inode.c          | 2 ++

wrt qnx4, feel free to add
Acked-by: Anders Larsen <al@alarsen.net>



