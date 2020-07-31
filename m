Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D1F23421A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 11:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbgGaJMZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 05:12:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23622 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731996AbgGaJMY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596186742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=6bhSR+BAUMbcG04K3ykGLY28I4XLjMXKCr7yKjPcSyI=;
        b=LTWK7/q1/0OQKKncdqgYL2Je1EA6uYWzYu8NKCVGcCZmU8ne/wyKN8xwDy7vyM/4lLQj25
        jtXNIafUVRMFPpUMXtop7YVXm6D863jnq8TXkfXFlt5aiEcwb5GAVmpX+jmS4xUVun6w6t
        5K9b55D9z/bK/7w3SVncvkyta/x3gaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-aUsgmxYyOfS6mkJo17tMDQ-1; Fri, 31 Jul 2020 05:12:18 -0400
X-MC-Unique: aUsgmxYyOfS6mkJo17tMDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD2D6107ACCA;
        Fri, 31 Jul 2020 09:12:14 +0000 (UTC)
Received: from localhost (ovpn-114-6.ams2.redhat.com [10.36.114.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 308CB25278;
        Fri, 31 Jul 2020 09:12:02 +0000 (UTC)
Date:   Fri, 31 Jul 2020 10:12:01 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        gerg@linux-m68k.org, ktkhai@virtuozzo.com, peterz@infradead.org,
        esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com,
        Andrea Arcangeli <aarcange@redhat.com>, jasowang@redhat.com,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexander Graf <graf@amazon.com>, vgoyal@redhat.com
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <20200731091201.GA173964@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200730152705.ol42jppnl4xfhl32@wittgenstein>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
Sileby looks interesting! I had just written up the following idea which
seems similar but includes a mechanism for revoking mappings.

Alexander Graf recently brought up an idea that solves the following
problem:

When process A passes shared memory file descriptors to process B there
is no way for process A to revoke access or change page protection bits
after passing the fd.

I'll describe the idea (not sure if it's exactly what Alexander had in
mind).

Memory view driver
------------------
The memory view driver allows process A to control the page table
entries of an mmap in process B. It is a character device driver that
process A opens like this:

  int fd = open("/dev/memory-view", O_RDWR);

This returns a file descriptor to a new memory view.

Next process A sets the size of the memory view:

  ftruncate(fd, 16 * GiB);

The size determines how large the memory view will be. The size is a
virtual memory concept and does not consume resources (there is no
physical memory backing this).

Process A populates the memory view with ranges from file descriptors it
wishes to share. The file descriptor can be a shared memory file
descriptor:

  int memfd = memfd_create("guest-ram, 0);
  ftruncate(memfd, 32 * GiB);

  /* Map [8GB, 10GB) at 8GB into the memory view */
  struct memview_map_fd_info = {
      .fd = memfd,
      .fd_offset = 8 * GiB,
      .size = 2 * GiB,
      .mem_offset = 8 * GiB,
      .flags = MEMVIEW_MAP_READ | MEMVIEW_MAP_WRITE,
  };
  ioctl(fd, MEMVIEW_MAP_FD, &map_fd_info);

It is also possible to populate the memory view from the page cache:

  int filefd = open("big-file.iso", O_RDONLY);

  /* Map [4GB, 12GB) at 0B into the memory view */
  struct memview_map_fd_info = {
      .fd = filefd,
      .fd_offset = 4 * GiB,
      .size = 8 * GiB,
      .mem_offset = 0,
      .flags = MEMVIEW_MAP_READ,
  };
  ioctl(fd, MEMVIEW_MAP_FD, &map_fd_info);

The memory view has now been populated like this:

Range (GiB)   Fd               Permissions
0-8           big-file.iso     read
8-10          guest-ram        read+write
10-16         <none>           <none>

Now process A gets the "view" file descriptor for this memory view. The
view file descriptor does not allow ioctls. It can be safely passed to
process B in the knowledge that process B can only mmap or close it:

  int viewfd = ioctl(fd, MEMVIEW_GET_VIEWFD);

  ...pass viewfd to process B...

Process B receives viewfd and mmaps it:

  void *ptr = mmap(NULL, 16 * GiB, PROT_READ | PROT_WRITE, MAP_SHARED,
                   viewfd, 0);

When process B accesses a page in the mmap region the memory view
driver resolves the page fault by checking if the page is mapped to an
fd and what its permissions are.

For example, accessing the page at 4GB from the start of the memory view
is an access at 8GB into big-file.iso. That's because 8GB of
big-file.iso was mapped at 0 with fd_offset 4GB.

To summarize, there is one vma in process B and the memory view driver
maps pages from the file descriptors added with ioctl(MEMVIEW_MAP_FD) by
process A.

Page protection bits are the AND of the mmap
PROT_READ/PROT_WRITE/PROT_EXEC flags with the memory view driver's
MEMVIEW_MAP_READ/MEMVIEW_MAP_WRITE/MEMVIEW_MAP_EXEC flags for the
mapping in question.

Does vmf_insert_mixed_prot() or a similar Linux API allow this?

Can the memory view driver map pages from fds without pinning the pages?

Process A can make further ioctl(MEMVIEW_MAP_FD) calls and also
ioctl(MEMVIEW_UNMAP_FD) calls to change the mappings. This requires
zapping affected process B ptes. When process B accesses those pages
again the fault handler will handle the page fault based on the latest
memory view layout.

If process B accesses a page with incorrect permissions or that has not
been configured by process A ioctl calls, a SIGSEGV/SIGBUS signal is
raised.

When process B uses mprotect(2) and other virtual memory syscalls it
is unable to increase page permissions. Instead it can only reduce them
because the pte protection bits are the AND of the mmap flags and the
memory view driver's MEMVIEW_MAP_READ/MEMVIEW_MAP_WRITE/MEMVIEW_MAP_EXEC
flags.

Use cases
---------
How to use the memory view driver for vhost-user
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vhost-user and other out-of-process device emulation interfaces need a
way for the VMM to enforce the IOMMU mappings on the device emulation
process.

Today the VMM passes all guest RAM fds to the device emulation process
and has no way of restricting access or revoking it later. With the
memory view driver the VMM will pass one or more memory view fds instead
of the actual guest RAM fds. This allows the VMM to invoke
ioctl(MEMVIEW_MAP_FD/MEMVIEW_UNMAP_FD) to enforce permissions or revoke
access.

How to use the memory view driver for virtio-fs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The virtiofsd vhost-user process creates a memory view for the device's
DAX Window and passes it to QEMU. QEMU installs it as a kvm.ko memory
region so that the guest directly accesses the memory view.

Now virtiofsd can map portions of files into the DAX Window without
coordinating with the QEMU process. This simplifies the virtio-fs code
and should also improve DAX map/unmap performance.

Stefan

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8j4GEACgkQnKSrs4Gr
c8ifDQgAjLeYf5nD/LJSs1tJ4vMLKsebK4OIkz7iOIJDeklVxePFIDc6dDZGMQLk
u//b8qLfr/0dZ5Q+KCT0GI96oHPK4Eod/PkB73XBm5lXj4wn3/MIKpITgfIN3oQX
Eb53sfAcDgXtceGB51vjemSDFD0KomE+j/Qj/yASxW1XpB3c1jT4N2XlaUNTYycG
8whaLYHvfhqkMX7HMbQVc1HGriYcAMgZkMMrn7RYbt4o58hirgauhD87x4kYDMk9
8Ph1wIeCzUnoxUkL8gjLC5/6qN1OMJ4NjMilYI4QqsUYfnCJYvwsPvrnVjdNs/Cm
qih0ktK8TMKEBLhHNOVQEJLp24DBdQ==
=szmz
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

