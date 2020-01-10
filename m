Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C01013770C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 20:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgAJT34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 14:29:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:21738 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgAJT34 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:29:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:29:55 -0800
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="247130740"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:29:55 -0800
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH V2 00/12] Enable per-file/directory DAX operations V2
Date:   Fri, 10 Jan 2020 11:29:30 -0800
Message-Id: <20200110192942.25021-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

At LSF/MM'19 [1] [2] we discussed applications that overestimate memory
consumption due to their inability to detect whether the kernel will
instantiate page cache for a file, and cases where a global dax enable via a
mount option is too coarse.

The following patch series enables selecting the use of DAX on individual files
and/or directories on xfs, and lays some groundwork to do so in ext4.  In this
scheme the dax mount option can be omitted to allow the per-file property to
take effect.

The insight at LSF/MM was to separate the per-mount or per-file "physical"
capability switch from an "effective" attribute for the file.

At LSF/MM we discussed the difficulties of switching the mode of a file with
active mappings / page cache.  It was thought the races could be avoided by
limiting mode flips to 0-length files.

However, this turns out to not be true.[3] This is because address space
operations (a_ops) may be in use at any time the inode is referenced and users
have expressed a desire to be able to change the mode on a file with data in
it.  For those reasons this patch set allows changing the mode flag on a file
as long as it is not current mapped.

Furthermore, DAX is a property of the inode and as such, many operations other
than address space operations need to be protected during a mode change.

Therefore callbacks are placed within the inode operations and used to lock the
inode as appropriate.

As in V1, Users are able to query the effective and physical flags separately
at any time.  Specifically the addition of the statx attribute bit allows them
to ensure the file is operating in the mode they intend.  This 'effective flag'
and physical flags could differ when the filesystem is mounted with the dax
flag for example.

It should be noted that the physical DAX flag inheritance is not shown in this
patch set as it was maintained from previous work on XFS.  The physical DAX flag
and it's inheritance will need to be added to other file systems for user
control. 

Finally, extensive testing was performed which resulted in a couple of bug fix
and clean up patches.  Specifically:

	fs: remove unneeded IS_DAX() check
	fs/xfs: Fix truncate up

'Fix truncate up' deserves specific attention because I'm not 100% sure it is
the correct fix.  Without that patch fsx testing failed within a few minutes
with this error.

	Mapped Write: non-zero data past EOF (0x3b0da) page offset 0xdb is 0x3711

With 'Fix truncate up' running fsx while changing modes can run for hours but I
have seen 2 other errors in the same genre after many hours of continuous
testing.

They are:

	READ BAD DATA: offset = 0x22dc, size = 0xcc7e, fname = /mnt/pmem/dax-file

	Mapped Read: non-zero data past EOF (0x3309e) page offset 0x9f is 0x6ab4

After seeing the patches to fix stale data exposure problems[4] I'm more
confident now that all 3 of these errors are a latent bug rather than a bug in
this series itself.

However, because of these failures I'm only submitting this set RFC.


[1] https://lwn.net/Articles/787973/
[2] https://lwn.net/Articles/787233/
[3] https://lkml.org/lkml/2019/10/20/96
[4] https://patchwork.kernel.org/patch/11310511/


To: linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org

