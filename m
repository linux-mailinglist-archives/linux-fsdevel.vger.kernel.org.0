Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A60B38BCF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 05:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbhEUD3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 23:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238893AbhEUD3i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 23:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621567696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=yxYbURZnuPc0zodV6Lb+qv8VGn2mQcxc80yfYxXtL3M=;
        b=a2d9WJMvlwE1lDBpENB6dlxIPQ/i7CJdNQJA6yNTIBI+COzzATvO6F3yN2hpVUYwSc1rui
        y/HQU1jZRDkyzKU5TrWWazcZnNDmqbnpDQ9FdocMT4ITZQ/X+NSxrT4RQHmh1ojsjhsXIx
        SUQrHQtvl5tPn90aBDEE1/rUyFA182A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-YrK4L1j6MOeYOhkca2n2Sw-1; Thu, 20 May 2021 23:28:14 -0400
X-MC-Unique: YrK4L1j6MOeYOhkca2n2Sw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 099B58015DB;
        Fri, 21 May 2021 03:28:13 +0000 (UTC)
Received: from T590 (ovpn-12-75.pek2.redhat.com [10.72.12.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DADF5C5FD;
        Fri, 21 May 2021 03:27:58 +0000 (UTC)
Date:   Fri, 21 May 2021 11:27:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: iomap: writeback ioend/bio allocation deadlock risk 
Message-ID: <YKcouuVR/y/L4T58@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Guys,

I found there may be two deadlock risk under memory pressure wrt.
ioend/bio allocation in iomap writeback code wrt. bio_alloc_bioset():

        if %__gfp_direct_reclaim is set then bio_alloc will always be able to
        allocate a bio.  this is due to the mempool guarantees.  to make this work,
        callers must never allocate more than 1 bio at a time from the general pool.
        callers that need to allocate more than 1 bio must always submit the
        previously allocated bio for io before attempting to allocate a new one.
        failure to do so can cause deadlocks under memory pressure.

1) more than one ioends can be allocated from 'iomap_ioend_bioset'
before submitting them all, so mempoll guarantee can't be made, which can
be observed frequently in writeback over ext4

2) more than one chained bio(allocated from fs_bio_set) via iomap_chain_bio,
which is easy observed when writing big files on XFS:

- the old bio is submitted _after_ the new allocation
- submission on old chained bio can't make forward progress because all chained
bios can only be freed after the whole ioend is completed, see iomap_finish_ioend()

Both looks not hard to fix, just want to make sure they are real issues?


Thanks,
Ming

