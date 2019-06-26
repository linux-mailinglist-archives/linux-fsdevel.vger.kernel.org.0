Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A51956117
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 06:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbfFZECx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 00:02:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44324 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfFZECx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 00:02:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hfz8F-000086-0E; Wed, 26 Jun 2019 04:02:03 +0000
Date:   Wed, 26 Jun 2019 05:02:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        shaggy@kernel.org, ard.biesheuvel@linaro.org, josef@toxicpanda.com,
        hch@infradead.org, clm@fb.com, adilger.kernel@dilger.ca,
        jk@ozlabs.org, jack@suse.com, dsterba@suse.com, jaegeuk@kernel.org,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-efi@vger.kernel.org, Jan Kara <jack@suse.cz>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/5] vfs: create a generic checking and prep function for
 FS_IOC_SETFLAGS
Message-ID: <20190626040202.GA32272@ZenIV.linux.org.uk>
References: <156151632209.2283456.3592379873620132456.stgit@magnolia>
 <156151633004.2283456.4175543089138173586.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156151633004.2283456.4175543089138173586.stgit@magnolia>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 07:32:10PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Create a generic function to check incoming FS_IOC_SETFLAGS flag values
> and later prepare the inode for updates so that we can standardize the
> implementations that follow ext4's flag values.

Change in efivarfs behaviour deserves a note.  I'm not saying it's wrong,
but behaviour is changed there - no-op FS_IOC_SETFLAGS used to fail
without CAP_LINUX_IMMUTABLE...
