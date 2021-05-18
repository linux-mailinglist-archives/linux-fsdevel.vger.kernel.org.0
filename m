Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4EC386E10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 02:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344797AbhERAI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 20:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241878AbhERAI0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 20:08:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 567E761185;
        Tue, 18 May 2021 00:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621296429;
        bh=ScWD93vhmvE7/+az5cdwWZNoMFRvnv5xxJIi25HVOy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hdc9f/UOXdv+qfglkWePf0sL5MOVzNA3ZHmgmEyP7w2ctS/o/cFc0cfZQDYOgPKLd
         wlTYkfn/VyMpUGIWomuP/vw4/Ei4opEB9rpMWlZgvAuxV0imtnNJ54QZWHFuEkQIZW
         gs1lWxnWA+2a6CxylE0hBoL2pu8P4wwFl4DunojZOU5irUOIe/tPWMzLVSTV3dB9iQ
         Og9KGU50jWOhITsWIJtcrEbAoeiW9bSiDvkgJrgH03HUZIT9HTcEAd+jTfGmSaM8cN
         mKNFmHX8NwxUBXl9KGQ1RjXjEtUdTSq3Sz6THLiMf4yjCrD83VaXqX3ufERUMp1mpS
         ZIV2FDjYZSmHw==
Date:   Mon, 17 May 2021 17:07:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RERESEND v9 0/9] fs: interface for directly
 reading/writing compressed data
Message-ID: <YKMFK3GtcWaRz4DA@gmail.com>
References: <cover.1621276134.git.osandov@fb.com>
 <CAHk-=wh74eFxL0f_HSLUEsD1OQfFNH9ccYVgCXNoV1098VCV6Q@mail.gmail.com>
 <YKLt5GyznttizBjd@relinquished.localdomain>
 <YKLyvnb19QmayJaJ@gmail.com>
 <YKL7W7QO7Wis2n8a@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKL7W7QO7Wis2n8a@relinquished.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 17, 2021 at 04:25:15PM -0700, Omar Sandoval wrote:
> 
> Okay, I think we're in agreement: RWF_ENCODED for the data and separate
> ioctls for the encryption context. Since the fscrypt policy struct
> includes all of the relevant information, RWF_ENCODED can probably just
> have a single ENCODED_IOV_ENCRYPTION_FSCRYPT encryption type.
> RWF_ENCODED can express data which is both compressed and encrypted, so
> that should be fine as well.
> 
> The only other missing piece that I see (other than filesystem support)
> is an FS_IOC_SET_ENCRYPTION_NONCE ioctl. Would such an interface be
> reasonable?

In theory, it will be possible to add FS_IOC_SET_ENCRYPTION_NONCE.  The
implementation might be tricky.  It would have to take the inode lock, verify
that the file is empty, replace the encryption xattr, and re-derive and replace
the file's encryption key.  Replacing the key should be safe because the file is
empty, but it's hard to be sure -- and what about directories?  Another concern
is that userspace could misuse this ioctl and somehow end up reusing nonces,
which would be bad; probably this should be a CAP_SYS_ADMIN thing only.

A larger question is whether the goal is to support users backing up and
restoring encrypted files without their encryption key being available -- in
which case things would become *much* harder.  First because of the filenames
encryption, and second because we currently don't allow opening files without
their encryption key.

- Eric
