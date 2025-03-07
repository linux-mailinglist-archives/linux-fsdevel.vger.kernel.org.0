Return-Path: <linux-fsdevel+bounces-43395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51285A55C85
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 02:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B747177786
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 01:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428571A0BF3;
	Fri,  7 Mar 2025 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="UI9YsCAE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C6319EED7;
	Fri,  7 Mar 2025 00:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309128; cv=none; b=X3ap+VY5WU72BJBzNUk+SH63s0HCXjaAmn1XSZ03wA/7aCAnvdzcnDVLf57KzHmMktJmMA3YUh47jfJV6z6EJSf5JFJ6hbYLccfFzM6NNklrHxK9QtBbK/6AQptrzbWJWCV59QE5snaq2gQWUBoJEgMtc94+8CFxZwLeO1fKMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309128; c=relaxed/simple;
	bh=HPgmTWKCFE9d4A+1uphM7bWka3x16UXXzEmul5rvJTI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rJBuMO1j/HRjSaVQ7eYaZ//r7ZD+YLNLS2adEzmp11mXaH5aVkxPlEJx2uTSK1RLlndtW6cGAzCrk7NCx7sw4T3LWMvkQLEtXXKscwhTuqhFiW5h+fEJE0euy6OjQxkRrxZEzEutZXt1POZI9xGTVEruZU6kWrXy6o0srbl0mNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=UI9YsCAE; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1741309126; x=1772845126;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vUnosHPz47fWK45st0LZ5YJp1oss1R9eNp+qhCVevDg=;
  b=UI9YsCAEfu7hrGGxL06ezF5UeKGB93ZT5EWar8hU553lqC+dgjGBy+gP
   pZ6U8KJTtAYJygom2t/4A8ZEMtLyRv/9E9yE3q5pWtyi95inMqEYVgoeU
   XtL4LtLAS9y6N6kLKtXdBrzS6GFHYyl5rOGdxGGgzZ2nNOf8WUaSEdRKM
   w=;
X-IronPort-AV: E=Sophos;i="6.14,227,1736812800"; 
   d="scan'208";a="468696731"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 00:58:34 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:51103]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.40:2525] with esmtp (Farcaster)
 id 7db8d410-3306-4a9b-a196-6db5e20f1018; Fri, 7 Mar 2025 00:58:34 +0000 (UTC)
X-Farcaster-Flow-ID: 7db8d410-3306-4a9b-a196-6db5e20f1018
Received: from EX19D020UWC002.ant.amazon.com (10.13.138.147) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:58:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19D020UWC002.ant.amazon.com (10.13.138.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:58:33 +0000
Received: from email-imr-corp-prod-pdx-all-2b-5ec155c2.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 00:58:33 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-pdx-all-2b-5ec155c2.us-west-2.amazon.com (Postfix) with ESMTP id 68D5D4024E;
	Fri,  7 Mar 2025 00:58:33 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id F0F9B4FBC; Fri,  7 Mar 2025 00:58:32 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: <linux-kernel@vger.kernel.org>
CC: Pratyush Yadav <ptyadav@amazon.de>, Jonathan Corbet <corbet@lwn.net>,
	"Eric Biederman" <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Hugh Dickins <hughd@google.com>, Alexander Graf
	<graf@amazon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David
 Woodhouse" <dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, "Mike
 Rapoport" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Pasha
 Tatashin" <tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, "Wei
 Yang" <richard.weiyang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <kexec@lists.infradead.org>
Subject: [RFC PATCH 0/5] Introduce FDBox, and preserve memfd with shmem over KHO
Date: Fri, 7 Mar 2025 00:57:34 +0000
Message-ID: <20250307005830.65293-1-ptyadav@amazon.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series introduces the File Descriptor Box (FDBox), along with
support in memfd and shmem for persisting memfds over KHO using FDBox.

FDBox is a mechanism for userspace to name file descriptors and give
them over to the kernel to hold. They can later be retrieved by passing
in the same name. The primary purpose of it is to be used with Kexec
Handover (KHO) [0]. See Documentation/kho/fdbox.rst for more details.

The original idea for FDBox came from Alex Graf. The main problem it
attempts to solve is to give a name to anonymous file descriptors like
memfd, guest_memfd, iommufd, etc. so they can be retrieved after KHO.
Alex wrote some initial code [1] which this series is based upon, though
that code is quite hacky and proof-of-concept, and has been
significantly refactored and polished with this series. Alex's code
mainly played around with KVM, but since I am more familiar with memfd
and shmem, I have picked those as the first users.

That is not to say this series is in a top notch state already. There is
still a lot of room for improvement, both in FDBox and in memfd and
shmem. The aim of the patches is to present the idea to get early
feedback, and to demonstrate KHO in action, potentially having a
consumer of KHO ready by the time those patches are ready for prime
time.

I have written a simple userspace tool to interact with FDBox and memfd.
It can be found here [2]. It is quite simple currently. When given the
create command, it creates a box, and a memfd, and fills the memfd with data
from a file called "data". It then adds the memfd to the box and seals
it. Then one can do KHO. After KHO, the restore command gets the FD out
of the box and writes the output to a file called "out". The original
and new file can be compared to ensure data consistency.

I have tested using the tool and a 1 GiB file, and the memfd came back
over KHO with the same contents. The performance was fast enough to not
be noticeable to the naked eye, though I have not done much more
performance analysis than that.

The whole process can be seen in action in this Asciinema [4].

Sample instructions to use the tool:

       $ make
       $ dd if=/dev/urandom of=data bs=1G count=1
       $ ./fdbox create
       $ echo 1 > /sys/kernel/kho/active
       $ kexec -s -l [...]
       $ kexec -e

After the kexec is done,

      $ ./fdbox restore
      $ cmp data out
      $ echo $?

The full tree with the patches can be found at [3]. It contains a couple
of my patches on top of Mike's KHO patches [0] to fix some small bugs.

[0] https://lore.kernel.org/lkml/20250206132754.2596694-1-rppt@kernel.org/
[1] https://github.com/agraf/linux-2.6/blob/kvm-kho-gmem-test/drivers/misc/fdbox.c
[2] https://github.com/prati0100/fdbox-utils/blob/main/fdbox.c
[3] https://web.git.kernel.org/pub/scm/linux/kernel/git/pratyush/linux.git/log/?h=kho
[4] https://asciinema.org/a/mnyVpy1w67mueIkKZzqHI0oAN

Pratyush Yadav (5):
  misc: introduce FDBox
  misc: add documentation for FDBox
  mm: shmem: allow callers to specify operations to shmem_undo_range
  mm: shmem: allow preserving file over FDBOX + KHO
  mm/memfd: allow preserving FD over FDBOX + KHO

 Documentation/filesystems/locking.rst |  21 +
 Documentation/kho/fdbox.rst           | 224 ++++++++
 Documentation/kho/index.rst           |   3 +
 MAINTAINERS                           |   9 +
 drivers/misc/Kconfig                  |   7 +
 drivers/misc/Makefile                 |   1 +
 drivers/misc/fdbox.c                  | 758 ++++++++++++++++++++++++++
 include/linux/fdbox.h                 | 119 ++++
 include/linux/fs.h                    |   7 +
 include/linux/miscdevice.h            |   1 +
 include/linux/shmem_fs.h              |   6 +
 include/uapi/linux/fdbox.h            |  61 +++
 mm/memfd.c                            | 128 ++++-
 mm/shmem.c                            | 498 +++++++++++++++--
 14 files changed, 1800 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/kho/fdbox.rst
 create mode 100644 drivers/misc/fdbox.c
 create mode 100644 include/linux/fdbox.h
 create mode 100644 include/uapi/linux/fdbox.h

-- 
2.47.1


