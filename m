Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1764BAFE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 03:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiBRCzJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 21:55:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiBRCzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:55:09 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D05580F9;
        Thu, 17 Feb 2022 18:54:52 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 21I2sUcx031678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 21:54:31 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8A76415C34C8; Thu, 17 Feb 2022 21:54:30 -0500 (EST)
Date:   Thu, 17 Feb 2022 21:54:30 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [REPORT] kernel BUG at fs/ext4/inode.c:2620 - page_buffers()
Message-ID: <Yg8KZvDVFJgTXm4C@mit.edu>
References: <Yg0m6IjcNmfaSokM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg0m6IjcNmfaSokM@google.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 16, 2022 at 04:31:36PM +0000, Lee Jones wrote:
> 
> After recently receiving a bug report from Syzbot [0] which was raised
> specifically against the Android v5.10 kernel, I spent some time
> trying to get to the crux.  Firstly I reproduced the issue on the
> reported kernel, then did the same using the latest release kernel
> v5.16.
> 
> The full kernel trace can be seen below at [1].
> 

Lee, thanks for your work in trimming down the syzkaller reproducer.
The moral equivalent of what it is doing (except each system call is
done in a separate thread, with synchronization so each gets executed
in order, but perhaps on a different CPU) is:

        int dest_fd, src_fd, truncate_fd, mmap_fd;
        pid_t tid;
        struct iovec local_iov, remote_iov;

        dest_fd = open("./bus", O_RDWR|O_CREAT|O_NONBLOCK|O_SYNC|
                       O_DIRECT|O_LARGEFILE|O_NOATIME, 0);
        src_fd = openat(AT_FDCWD, "/bin/bash", O_RDONLY);
        truncate_fd = syscall(__NR_open, "./bus", O_RDWR|O_CREAT|O_SYNC|O_NOATIME|O_ASYNC);
        ftruncate(truncate_fd, 0x2008002ul);
        mmap((void *) 0x20000000ul /* addr */, 0x600000ul /* length */,
             PROT_WRITE|PROT_EXEC|PROT_SEM||0x7ffff0, MAP_FIXED|MAP_SHARED, mmap_fd, 0);
        sendfile(dest_fd, src_fd, 0 /* offset */, 0x80000005ul /* count */);
        local_iov.iov_base = (void *) 0x2034afa4;
        local_iov.iov_len = 0x1f80;
        remote_iov.iov_base = (void *) 0x20000080;
        remote_iov.iov_len = 0x2034afa5;
        process_vm_writev(gettid(), &local_iov, 1, &remote_iov, 1, 0);
        sendfile(dest_fd, src_fd, 0 /* offset */, 0x1f000005ul /* count */);

Which is then executed repeataedly over and over again.  (With the
file descriptors closed at each loop, so the file is reopened each time.)

So basically, we have a scratch file which is initialized using an
sendfile using O_DIRECT.  The scratch file is also mmap'ed into the
process's address space, and we then *modify* that an mmap'ed reagion
using process_vm_writev() --- and this is where the problem starts.

process_vm_writev() uses [un]pin_user_pages_remote() which is the same
interface uses for RDMA.  But it's not clear this is ever supposed to
work for memory which is mmap'ed region backed by a file.
pin_user_pages_remote() appears to assume that it is an anonymous
region, since the get_user_pages functions in mm/gup.c don't call
read_page() to read data into any pages that might not be mmaped in.

They also don't follow the mm / file system protocol of calling the
file system's write_begin() or page_mkwrite() before modifying a page,
and so when when process_vm_writev() calls unpin_user_pages_remote(),
this tries to dirty the page, but since page_mkwrite() or
write_begin() hasn't been called, buffers haven't been attached to the
page, and so that triggers the following ext4 WARN_ON:

[ 1451.095939] WARNING: CPU: 1 PID: 449 at fs/ext4/inode.c:3565 ext4_set_page_dirty+0x48/0x50
  ...
[ 1451.139877] Call Trace:
[ 1451.140833]  <TASK>
[ 1451.141889]  folio_mark_dirty+0x2f/0x60
[ 1451.143408]  set_page_dirty_lock+0x3e/0x60
[ 1451.145130]  unpin_user_pages_dirty_lock+0x108/0x130
[ 1451.147405]  process_vm_rw_single_vec.constprop.0+0x1b9/0x260
[ 1451.150135]  process_vm_rw_core.constprop.0+0x156/0x280
[ 1451.159576]  process_vm_rw+0xc4/0x110


Then when ext4_writepages() gets called, we trigger the BUG because
buffers haven't been attached to the page.  We can certainly avoid the
BUG by checking to see if buffers are attached first, and if not, skip
writing the page trigger a WARN_ON, and then forcibly clear the page
dirty flag so don't permanently leak memory and allow the file system
to be unmounted.  (Note: we can't fix the problem by attaching the
buffers in set_page_dirty(), since is occasionally called under
spinlocks and without the page being locked, so we can't do any kind
of allocation, so ix-nay on calling create_empty_buffers() which calls
alloc_buffer_head().)

BUT, that is really papering over the problem, since it's not clear
it's valid to try to use get_user_pages() and friends (including
[un]pin_user_pages_remote() on file-backed memory.

And if it is supposed to be valid, then mm/gup.c needs to first call
readpage() if the page is not present, so that if process_vm_writev()
is only modifying a few bytes in the mmap'ed region, we need to fault
in the page first, and then mm/gup.c needs to inform the file system
to make sure that if pinned memory region is not yet allocated, than
whatever needs to happen to allocate space, via page_mkwrite() has
taken place.  (And by the way, that means that pin_user_pages_remote()
may need to return ENOSPC if there is not free space in the file
system, and hence ENOSPC may need to reflected all the way back to
process_vm_writev().

Alternatively, if we don't expect process_vm_writev() to work on
file-backed memory, perhaps it and pin_user_pages_remote() should
return some kind of error?

	    	      	     	    	      - Ted
