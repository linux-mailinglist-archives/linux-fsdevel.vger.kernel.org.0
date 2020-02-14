Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4739D15F8AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 22:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbgBNVX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 16:23:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49542 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729434AbgBNVX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581715408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wVVyuecHVtlhk7EhdI8+dEdFCvdA4cReUnIw+jCKbOs=;
        b=QqBAHjXwg1wOs/PalqpW02f3f4Yq9u3FcCKuYulq9g2r3RDpN6OPlAmh5KTRjhQmQ1BMNF
        KsbuUyWSGRB4/S2CdqnOelsQPCD0eCbKn6vO6eg86CgkdkiR7f0tjMasAUMOU2psct0dua
        IxRZUrxgpQs5mNra9N+bbqmbjRNfIUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-RfyJzzHnPOCFAEI2Hcc5Hw-1; Fri, 14 Feb 2020 16:23:24 -0500
X-MC-Unique: RfyJzzHnPOCFAEI2Hcc5Hw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04F728017CC;
        Fri, 14 Feb 2020 21:23:22 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32C5C1001B0B;
        Fri, 14 Feb 2020 21:23:20 +0000 (UTC)
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
References: <20200208193445.27421-1-ira.weiny@intel.com>
        <x49imke1nj0.fsf@segfault.boston.devel.redhat.com>
        <20200211201718.GF12866@iweiny-DESK2.sc.intel.com>
        <x49sgjf1t7n.fsf@segfault.boston.devel.redhat.com>
        <20200213190156.GA22854@iweiny-DESK2.sc.intel.com>
        <20200213190513.GB22854@iweiny-DESK2.sc.intel.com>
        <20200213195839.GG6870@magnolia>
        <20200213232923.GC22854@iweiny-DESK2.sc.intel.com>
        <CAPcyv4hkWoC+xCqicH1DWzmU2DcpY0at_A6HaBsrdLbZ6qzWow@mail.gmail.com>
        <20200214200607.GA18593@iweiny-DESK2.sc.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 14 Feb 2020 16:23:19 -0500
In-Reply-To: <20200214200607.GA18593@iweiny-DESK2.sc.intel.com> (Ira Weiny's
        message of "Fri, 14 Feb 2020 12:06:07 -0800")
Message-ID: <x4936bcdfso.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ira Weiny <ira.weiny@intel.com> writes:

> [disclaimer: the following assumes the underlying 'device' (superblock)
> supports DAX]
>
> ... which results in S_DAX == false when the file is opened without the mount
> option.  The key would be that all directories/files created under a root with
> XFS_DIFLAG2_DAX == true would inherit their flag and be XFS_DIFLAG2_DAX == true
> all the way down the tree.  Any file not wanting DAX would need to set
> XFS_DIFLAG2_DAX == false.  And setting false could be used on a directory to
> allow a user or group to not use dax on files in that sub-tree.
>
> Then without '-o dax' (XFS_MOUNT_DAX == false) all files when opened set S_DAX
> equal to XFS_DIFLAG2_DAX value.  (Directories, as of V4, never get S_DAX set.)
>
> If '-o dax' (XFS_MOUNT_DAX == true) then S_DAX is set on all files.

One more clarifying question.  Let's say I set XFS_DIFLAG2_DAX on an
inode.  I then open the file, and perform mmap/load/store/etc.  I close
the file, and I unset XFS_DIFLAG2_DAX.  Will the next open treat the
file as S_DAX or not?  My guess is the inode won't be evicted, and so
S_DAX will remain set.

The reason I ask is I've had requests from application developers to do
just this.  They want to be able to switch back and forth between dax
modes.

Thanks,
Jeff

> [1] I'm beginning to think that if I type dax one more time I'm going to go
> crazy...  :-P

dax dax dax!

