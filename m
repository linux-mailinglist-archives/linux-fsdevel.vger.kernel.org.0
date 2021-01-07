Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF932ED079
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 14:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbhAGNRP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 08:17:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727753AbhAGNRP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 08:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610025349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=WcMTwxKBmFx0TTx3051cBL+gyEZFsErFP3TOaLoFIRY=;
        b=gRUxBBj+3QKi/NOiPtM0k1GcAF428e5+a2C4+YsO26c0dIx6cVYsHy5Jy8hM36UYGomR+v
        Z3cVo3vE6srn2feskIlren4SKImvdouUJ14AQxqiNta0FWNVzvaFC8max7JePX6Or2CiJT
        sLpVRJRex0RYSGJWzmgGLnvoaTR5f4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-7Tu4ndmSM82TvyuEKUjd5g-1; Thu, 07 Jan 2021 08:15:45 -0500
X-MC-Unique: 7Tu4ndmSM82TvyuEKUjd5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51628196632C;
        Thu,  7 Jan 2021 13:15:43 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00A695B6AF;
        Thu,  7 Jan 2021 13:15:42 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 107DFgOT026586;
        Thu, 7 Jan 2021 08:15:42 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 107DFfsK026582;
        Thu, 7 Jan 2021 08:15:41 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 7 Jan 2021 08:15:41 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>
cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: [RFC v2] nvfs: a filesystem for persistent memory
Message-ID: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi

I announce a new version of NVFS - a filesystem for persistent memory.
	http://people.redhat.com/~mpatocka/nvfs/
	git://leontynka.twibright.com/nvfs.git

Changes since the last release:

* I added a microjournal to the filesystem, it can hold up to 16 entries. 
  Each CPU has it's own journal, so that there is no lock contention. The 
  journal is used to provide atomicity of reaname() and extended attribute 
  replace.
  (note that file creation or deletion doesn't use the journal, because 
  these operations can be deterministically cleaned up by fsck)

* I created a framework that can be used to verify the filesystem driver. 
  It logs all writes and memory barriers to a file, the entries in the 
  file are randomly reordered (to simulate reordering in the CPU 
  write-combining buffers), the sequence is cut at a random point (to 
  simulate a system crash) and the result is replayed on a filesystem 
  image.
  With this framework, we can for example check that if a crash happens 
  during rename(), either old file or new file will be present in a 
  directory.
  This framework helped to find a few bugs in sequencing the writes.

* If we map an executable image, we turn off the DAX flag on the inode 
  (because executables run 4% slower from persistent memory). There is 
  also a switch that can turn DAX always off or always on.




I'd like to ask about this piece of code in __kernel_read:
	if (unlikely(!file->f_op->read_iter || file->f_op->read))
		return warn_unsupported...
and __kernel_write:
	if (unlikely(!file->f_op->write_iter || file->f_op->write))
		return warn_unsupported...

- It exits with an error if both read_iter and read or write_iter and 
write are present.

I found out that on NVFS, reading a file with the read method has 10% 
better performance than the read_iter method. The benchmark just reads the 
same 4k page over and over again - and the cost of creating and parsing 
the kiocb and iov_iter structures is just that high.

So, I'd like to have both read and read_iter methods. Could the above 
conditions be changed, so that they don't fail with an error if the "read" 
or "write" method is present?

Mikulas

