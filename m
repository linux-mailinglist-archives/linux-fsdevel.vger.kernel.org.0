Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73EF617B31C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 01:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgCFAp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 19:45:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgCFAp5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:45:57 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD56E2070E;
        Fri,  6 Mar 2020 00:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583455557;
        bh=fGx37LlA+EG4g7xaMt+UAx7ZpIiPij5CT5m8UDigDpE=;
        h=Date:From:To:Cc:Subject:From;
        b=MW4Vk6JvFjyAkqLILduCSVnHoFDTP44wh8BDtkn3mMCcS3QOVTbqORQOYyHbCVBo6
         QB7uLmdz+7k/bhThcepfO6I4noScDXO4lwBfZrbsjO7nJq/F7DXS/DLq9PNlIrm/0Y
         LUoljjpLlpCbARZKFMZ3rRkGhG9eAYDUb82nAOiM=
Date:   Thu, 5 Mar 2020 16:45:55 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: lazytime causing inodes to remain dirty after sync?
Message-ID: <20200306004555.GB225345@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While testing my patch "fscrypt: don't evict dirty inodes after removing key"
(https://lkml.kernel.org/r/20200305084138.653498-1-ebiggers@kernel.org), I've
run into an issue where even after the filesystem is sync'ed and no files are
in-use, inodes can remain dirty if the filesystem is mounted with -o lazytime.
Thus, my patch causes some inodes to not be evicted when they should be.

(lazytime is the default on f2fs, but ext4 supports it too.)

This is caused by the following code in __writeback_single_inode() that
redirties the inode if its access time is dirty:

	if (dirty & I_DIRTY_TIME)
		mark_inode_dirty_sync(inode);
	/* Don't write the inode if only I_DIRTY_PAGES was set */
	if (dirty & ~I_DIRTY_PAGES) {
		int err = write_inode(inode, wbc);
		if (ret == 0)
			ret = err;
	}
	trace_writeback_single_inode(inode, wbc, nr_to_write);
	return ret;

Here's a reproducer in the kvm-xfstests test appliance which demonstrates the
problem using sync(), without fscrypt involved at all:

	sysctl vm.dirty_expire_centisecs=500
	umount /vdc
	mkfs.ext4 -F /dev/vdc
	mount /vdc -o lazytime
	echo contents > /vdc/file
	sync
	ino=$(stat -c %i /vdc/file)
	echo 1 | tee /sys/kernel/debug/tracing/events/writeback/writeback_{single_inode_start,mark_inode_dirty,lazytime}/enable
	echo "ino == $ino" | tee /sys/kernel/debug/tracing/events/writeback/writeback_{single_inode_start,mark_inode_dirty,lazytime}/filter
	echo > /sys/kernel/debug/tracing/trace
	cat /vdc/file > /dev/null
	sync
	cat /sys/kernel/debug/tracing/trace_pipe

The tracing shows that the inode for /vdc/file is written during the sync at
7.28s.  But then, still during the sync, it's immediately re-dirtied.  It then
gets written again later in the background, after the sync.

             cat-286   [001] ...1     7.279433: writeback_mark_inode_dirty: bdi 254:32: ino=12 state= flags=I_DIRTY_TIME
    kworker/u8:0-8     [003] ...1     7.282647: writeback_single_inode_start: bdi 254:32: ino=12 state=I_SYNC|I_DIRTY_TIME|I_DIRTY_TIME_EXPIRED dirtied_when=4294879420 age=0 index=1 to_write=9223372036854775807 wrote=0 cgroup_ino=1
    kworker/u8:0-8     [003] ...2     7.282660: writeback_lazytime: dev 254,32 ino 12 dirtied 4294879420 state I_SYNC|I_DIRTY_TIME|I_DIRTY_TIME_EXPIRED mode 0100644
    kworker/u8:0-8     [003] ...1     7.283204: writeback_mark_inode_dirty: bdi 254:32: ino=12 state=I_SYNC flags=I_DIRTY_SYNC
    kworker/u8:0-8     [003] ...1    12.412079: writeback_single_inode_start: bdi 254:32: ino=12 state=I_DIRTY_SYNC|I_SYNC dirtied_when=4294879421 age=5 index=1 to_write=13312 wrote=0 cgroup_ino=1

Is this behavior intentional at all?  It seems like a bug; it seems the inode
should be written just once, during the sync.  

- Eric
