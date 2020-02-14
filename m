Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7FA15F93A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 23:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgBNWGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 17:06:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22916 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgBNWGW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581717980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ED47G1L+n80TagZ7/QhjmhFUqcbeULxGEF5xm1xsbo0=;
        b=eG+BWXD1rTBrMNxX0aXPFhH0Bcr1Zb6Aakw9OWKmgo7QXfaujMrnKLdYCtu5jONF33yvtg
        eoR3Z/AXqvgTaALhHrGAu501NKf4bCYkjQ0Lagx9g9QT2H5UZaF6m9aFNn+AWok1h1DO4E
        PAvBDhUkwEJX/vWPFtfQtJjPYecw3rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-zchCvi3dOTeu5iY-2b37nw-1; Fri, 14 Feb 2020 17:06:16 -0500
X-MC-Unique: zchCvi3dOTeu5iY-2b37nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01CC41B2C981;
        Fri, 14 Feb 2020 22:06:14 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 409971001DC2;
        Fri, 14 Feb 2020 22:06:12 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] Enable per-file/directory DAX operations V3
References: <x49imke1nj0.fsf@segfault.boston.devel.redhat.com>
        <20200211201718.GF12866@iweiny-DESK2.sc.intel.com>
        <x49sgjf1t7n.fsf@segfault.boston.devel.redhat.com>
        <20200213190156.GA22854@iweiny-DESK2.sc.intel.com>
        <20200213190513.GB22854@iweiny-DESK2.sc.intel.com>
        <20200213195839.GG6870@magnolia>
        <20200213232923.GC22854@iweiny-DESK2.sc.intel.com>
        <CAPcyv4hkWoC+xCqicH1DWzmU2DcpY0at_A6HaBsrdLbZ6qzWow@mail.gmail.com>
        <20200214200607.GA18593@iweiny-DESK2.sc.intel.com>
        <x4936bcdfso.fsf@segfault.boston.devel.redhat.com>
        <20200214215759.GA20548@iweiny-DESK2.sc.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 14 Feb 2020 17:06:10 -0500
In-Reply-To: <20200214215759.GA20548@iweiny-DESK2.sc.intel.com> (Ira Weiny's
        message of "Fri, 14 Feb 2020 13:58:00 -0800")
Message-ID: <x49y2t4bz8t.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ira Weiny <ira.weiny@intel.com> writes:

> On Fri, Feb 14, 2020 at 04:23:19PM -0500, Jeff Moyer wrote:
>> Ira Weiny <ira.weiny@intel.com> writes:
>> 
>> > [disclaimer: the following assumes the underlying 'device' (superblock)
>> > supports DAX]
>> >
>> > ... which results in S_DAX == false when the file is opened without the mount
>> > option.  The key would be that all directories/files created under a root with
>> > XFS_DIFLAG2_DAX == true would inherit their flag and be XFS_DIFLAG2_DAX == true
>> > all the way down the tree.  Any file not wanting DAX would need to set
>> > XFS_DIFLAG2_DAX == false.  And setting false could be used on a directory to
>> > allow a user or group to not use dax on files in that sub-tree.
>> >
>> > Then without '-o dax' (XFS_MOUNT_DAX == false) all files when opened set S_DAX
>> > equal to XFS_DIFLAG2_DAX value.  (Directories, as of V4, never get S_DAX set.)
>> >
>> > If '-o dax' (XFS_MOUNT_DAX == true) then S_DAX is set on all files.
>> 
>> One more clarifying question.  Let's say I set XFS_DIFLAG2_DAX on an
>> inode.  I then open the file, and perform mmap/load/store/etc.  I close
>> the file, and I unset XFS_DIFLAG2_DAX.  Will the next open treat the
>> file as S_DAX or not?  My guess is the inode won't be evicted, and so
>> S_DAX will remain set.
>
> The inode will not be evicted, or even it happens to be xfs_io will reload it
> to unset the XFS_DIFLAG2_DAX flag.  And the S_DAX flag changes _with_ the
> XFS_DIFLAG2_DAX change when it can (when the underlying storage supports
> S_DAX).

OK, so it will be possible to change the effective mode.

I'll try to get some testing in on this series, now.

Thanks!
Jeff

