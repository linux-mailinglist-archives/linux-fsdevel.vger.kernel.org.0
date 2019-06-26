Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B81656888
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 14:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfFZMVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 08:21:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZMVP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:21:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DBE3308792C;
        Wed, 26 Jun 2019 12:20:52 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DAEC5D9C6;
        Wed, 26 Jun 2019 12:20:49 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 26F8E1806B0E;
        Wed, 26 Jun 2019 12:20:43 +0000 (UTC)
Date:   Wed, 26 Jun 2019 08:20:42 -0400 (EDT)
From:   Bob Peterson <rpeterso@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     matthew garrett <matthew.garrett@nebula.com>, yuchao0@huawei.com,
        tytso@mit.edu, shaggy@kernel.org,
        ard biesheuvel <ard.biesheuvel@linaro.org>,
        josef@toxicpanda.com, hch@infradead.org, clm@fb.com,
        adilger kernel <adilger.kernel@dilger.ca>, jk@ozlabs.org,
        jack@suse.com, dsterba@suse.com, jaegeuk@kernel.org,
        viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-efi@vger.kernel.org,
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>, ocfs2-devel@oss.oracle.com
Message-ID: <868182386.37358699.1561551642881.JavaMail.zimbra@redhat.com>
In-Reply-To: <156151633004.2283456.4175543089138173586.stgit@magnolia>
References: <156151632209.2283456.3592379873620132456.stgit@magnolia> <156151633004.2283456.4175543089138173586.stgit@magnolia>
Subject: Re: [Cluster-devel] [PATCH 1/5] vfs: create a generic checking and
 prep function for FS_IOC_SETFLAGS
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.201, 10.4.195.9]
Thread-Topic: create a generic checking and prep function for FS_IOC_SETFLAGS
Thread-Index: 5u1cuSAsKRaw36dS1F+PjLFgFqc7sA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 26 Jun 2019 12:21:15 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Original Message -----
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Create a generic function to check incoming FS_IOC_SETFLAGS flag values
> and later prepare the inode for updates so that we can standardize the
> implementations that follow ext4's flag values.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/ioctl.c    |   13 +++++--------
>  fs/efivarfs/file.c  |   26 +++++++++++++++++---------
>  fs/ext2/ioctl.c     |   16 ++++------------
>  fs/ext4/ioctl.c     |   13 +++----------
>  fs/f2fs/file.c      |    7 ++++---
>  fs/gfs2/file.c      |   42 +++++++++++++++++++++++++++++-------------
>  fs/hfsplus/ioctl.c  |   21 ++++++++++++---------
>  fs/inode.c          |   24 ++++++++++++++++++++++++
>  fs/jfs/ioctl.c      |   22 +++++++---------------
>  fs/nilfs2/ioctl.c   |    9 ++-------
>  fs/ocfs2/ioctl.c    |   13 +++----------
>  fs/orangefs/file.c  |   35 ++++++++++++++++++++++++++---------
>  fs/reiserfs/ioctl.c |   10 ++++------
>  fs/ubifs/ioctl.c    |   13 +++----------
>  include/linux/fs.h  |    3 +++
>  15 files changed, 146 insertions(+), 121 deletions(-)

The gfs2 portion looks correct.

Reviewed-by: Bob Peterson <rpeterso@redhat.com>

Regards,

Bob Peterson
