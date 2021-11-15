Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D694450046
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 09:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhKOIwy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 03:52:54 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4093 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhKOIwj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:52:39 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ht2pc5G6Tz67qYR;
        Mon, 15 Nov 2021 16:46:00 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 09:49:41 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2308.020;
 Mon, 15 Nov 2021 09:49:41 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "tytso@mit.edu" <tytso@mit.edu>, "corbet@lwn.net" <corbet@lwn.net>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH 5/5] shmem: Add fsverity support
Thread-Topic: [RFC][PATCH 5/5] shmem: Add fsverity support
Thread-Index: AQHX18M/qVU4RXchik23Vn+neZuDEKwAMhaAgAQN/bA=
Date:   Mon, 15 Nov 2021 08:49:41 +0000
Message-ID: <6adb6da30b734213942f976745c456f6@huawei.com>
References: <20211112124411.1948809-1-roberto.sassu@huawei.com>
 <20211112124411.1948809-6-roberto.sassu@huawei.com>
 <YY68iXKPWN8+rd+0@gmail.com>
In-Reply-To: <YY68iXKPWN8+rd+0@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.204.63.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> From: Eric Biggers [mailto:ebiggers@kernel.org]
> Sent: Friday, November 12, 2021 8:12 PM
> On Fri, Nov 12, 2021 at 01:44:11PM +0100, Roberto Sassu wrote:
> > Make the necessary modifications to support fsverity in tmpfs.
> >
> > First, implement the fsverity operations (in a similar way of f2fs). These
> > operations make use of shmem_read_mapping_page() instead of
> > read_mapping_page() to handle the case where the page has been swapped
> out.
> > The fsverity descriptor is placed at the end of the file and its location
> > is stored in an xattr.
> >
> > Second, implement the ioctl operations to enable, measure and read fsverity
> > metadata.
> >
> > Lastly, add calls to fsverity functions, to ensure that fsverity-relevant
> > operations are checked and handled by fsverity (file open, attr set, inode
> > evict).
> >
> > Fsverity support can be enabled through the kernel configuration and
> > remains enabled by default for every tmpfs filesystem instantiated (there
> > should be no overhead, unless fsverity is enabled for a file).
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> I don't see how this makes sense at all.  The point of fs-verity is to avoid
> having to hash the whole file when verifying it.  However, obviously the whole
> file still has to be hashed to build the Merkle tree in the first place.  That
> makes sense for a persistent filesystem where a file can be written once and
> verified many times.  I don't see how it makes sense for tmpfs, where files have
> to be re-created on every boot.  You might as well just hash the whole file.

The point of adding fsverity support for tmpfs was to being able to do
integrity enforcement with just one mechanism, given that I was
planning to do integrity verification with reference values loaded
to the kernel with DIGLIM [1].

With an LSM such as IPE [2], integrity verification would consist in
querying the fsverity digest with DIGLIM and allowing the operation
if the digest was found. With fsverity support in tmpfs, this can be
done from the very beginning of the boot process.

Using regular file digests would be also possible but this requires
loading with DIGLIM both fsverity and non-fsverity reference values.
It would also require two separate mechanisms for calculating
the file digest depending on the filesystem. It could be done, but
I thought it was easier to add support for fsverity in tmpfs.

> Also, you didn't implement actually verifying the data (by calling
> fsverity_verify_page()), so this patch doesn't really do anything anyway.

Yes, at the end I didn't add it. Probably the only place where
calling fsverity_verify_page() would make sense is when a page
is swapped in (assuming that the swap device is untrusted).

I tried to add a call in shmem_swapin_page() but fsverity complained
due to the fact that the page was already up to date, and also
rejected the page. I will check it better.

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Zhong Ronghua

[1] https://lore.kernel.org/linux-integrity/20210914163401.864635-1-roberto.sassu@huawei.com/
[2] https://lore.kernel.org/linux-security-module/1634151995-16266-1-git-send-email-deven.desai@linux.microsoft.com/
