Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF54451DCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 01:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345668AbhKPAeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 19:34:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344826AbhKOTZe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:25:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D4FF636D2;
        Mon, 15 Nov 2021 19:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637003102;
        bh=OxbA2Dy+guUtV/oxu3huaKUI54o5bkpBbR72qWRaAfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FxEl08qu4dUEMgEsJFpcX25p/KAprHCVG4O2xUjklk6MvshRaaVwAbSWxfPyA3ba3
         G5+kXBoJGUkezo7WNhBgi7qQVqg29NVjmQ/iemHcndYQvpHT/o2OusJ6ufzGCTt+X3
         COwh9q9xxmf2+gdOCzIjNRJdYEmTDEEmGYON1C6E7fpxnhNw1Y4p/lUjcPsdYh267J
         C3X3PW3x+ePAkJZQrUJ7enxU3FrOy4YKGrdwtzow9e996b4sFxvokIygVh8H3+jh5G
         +nw98sTQbGfTlWDj+RTeADtMTm/qxJwgZO1jIRN9zBcTRtzn63a8XeyX6Ju7SZR0oI
         WB07kdDfXRzhA==
Date:   Mon, 15 Nov 2021 11:05:00 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     "tytso@mit.edu" <tytso@mit.edu>, "corbet@lwn.net" <corbet@lwn.net>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 5/5] shmem: Add fsverity support
Message-ID: <YZKvXK+vX/we4GCD@gmail.com>
References: <20211112124411.1948809-1-roberto.sassu@huawei.com>
 <20211112124411.1948809-6-roberto.sassu@huawei.com>
 <YY68iXKPWN8+rd+0@gmail.com>
 <6adb6da30b734213942f976745c456f6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6adb6da30b734213942f976745c456f6@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 15, 2021 at 08:49:41AM +0000, Roberto Sassu wrote:
> > From: Eric Biggers [mailto:ebiggers@kernel.org]
> > Sent: Friday, November 12, 2021 8:12 PM
> > On Fri, Nov 12, 2021 at 01:44:11PM +0100, Roberto Sassu wrote:
> > > Make the necessary modifications to support fsverity in tmpfs.
> > >
> > > First, implement the fsverity operations (in a similar way of f2fs). These
> > > operations make use of shmem_read_mapping_page() instead of
> > > read_mapping_page() to handle the case where the page has been swapped
> > out.
> > > The fsverity descriptor is placed at the end of the file and its location
> > > is stored in an xattr.
> > >
> > > Second, implement the ioctl operations to enable, measure and read fsverity
> > > metadata.
> > >
> > > Lastly, add calls to fsverity functions, to ensure that fsverity-relevant
> > > operations are checked and handled by fsverity (file open, attr set, inode
> > > evict).
> > >
> > > Fsverity support can be enabled through the kernel configuration and
> > > remains enabled by default for every tmpfs filesystem instantiated (there
> > > should be no overhead, unless fsverity is enabled for a file).
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > I don't see how this makes sense at all.  The point of fs-verity is to avoid
> > having to hash the whole file when verifying it.  However, obviously the whole
> > file still has to be hashed to build the Merkle tree in the first place.  That
> > makes sense for a persistent filesystem where a file can be written once and
> > verified many times.  I don't see how it makes sense for tmpfs, where files have
> > to be re-created on every boot.  You might as well just hash the whole file.
> 
> The point of adding fsverity support for tmpfs was to being able to do
> integrity enforcement with just one mechanism, given that I was
> planning to do integrity verification with reference values loaded
> to the kernel with DIGLIM [1].
> 
> With an LSM such as IPE [2], integrity verification would consist in
> querying the fsverity digest with DIGLIM and allowing the operation
> if the digest was found. With fsverity support in tmpfs, this can be
> done from the very beginning of the boot process.
> 
> Using regular file digests would be also possible but this requires
> loading with DIGLIM both fsverity and non-fsverity reference values.
> It would also require two separate mechanisms for calculating
> the file digest depending on the filesystem. It could be done, but
> I thought it was easier to add support for fsverity in tmpfs.
> 
> > Also, you didn't implement actually verifying the data (by calling
> > fsverity_verify_page()), so this patch doesn't really do anything anyway.
> 
> Yes, at the end I didn't add it. Probably the only place where
> calling fsverity_verify_page() would make sense is when a page
> is swapped in (assuming that the swap device is untrusted).
> 
> I tried to add a call in shmem_swapin_page() but fsverity complained
> due to the fact that the page was already up to date, and also
> rejected the page. I will check it better.
> 

It sounds like you really only care about calculating fs-verity file digests.
That's just an algorithm for hashing a file, so it could just be implemented in
generic code that operates on any file on any filesystem, like how IMA
implemennts full file hashing for any file.  There isn't a need for any special
filesystem support to do this.

- Eric
