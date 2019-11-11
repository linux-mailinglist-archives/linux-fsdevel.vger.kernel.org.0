Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93573F8138
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfKKU2O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:28:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfKKU2O (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:28:14 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2B84206A3;
        Mon, 11 Nov 2019 20:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573504094;
        bh=Lu1K4hEFffFmujStmzKqcSWqDK91+nLfOMJq7cD0eW0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=sW4RP7ZNpXAzaHbxsy+dMlmibHKiUFAofLNR/2Q9956XNaxJ9iJ9xDjPj6mZC0Cqq
         BEeVWWq+luN4KafsrJGbOqM/VCDkinX1MRkz98KeNsM2YZiGq+Lazn8TVL1wJL1hyY
         erA11VS49GBS0Mzv0TfuvvvaQ+mBZaRu18i87VZA=
Date:   Mon, 11 Nov 2019 12:28:12 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chandan Rajendra <chandan@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] ext4: support encryption with blocksize !=
 PAGE_SIZE
Message-ID: <20191111202811.GE56300@gmail.com>
Mail-Followup-To: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chandan Rajendra <chandan@linux.ibm.com>
References: <20191023033312.361355-1-ebiggers@kernel.org>
 <20191106215439.GC139580@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106215439.GC139580@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 06, 2019 at 01:54:40PM -0800, Eric Biggers wrote:
> On Tue, Oct 22, 2019 at 08:33:10PM -0700, Eric Biggers wrote:
> > Hello,
> > 
> > This patchset makes ext4 support encryption on filesystems where the
> > filesystem block size is not equal to PAGE_SIZE.  This allows e.g.
> > PowerPC systems to use ext4 encryption.
> > 
> > Most of the work for this was already done in prior kernel releases; now
> > the only part missing is decryption support in block_read_full_page().
> > Chandan Rajendra has proposed a patchset "Consolidate FS read I/O
> > callbacks code" [1] to address this and do various other things like
> > make ext4 use mpage_readpages() again, and make ext4 and f2fs share more
> > code.  But it doesn't seem to be going anywhere.
> > 
> > Therefore, I propose we simply add decryption support to
> > block_read_full_page() for now.  This is a fairly small change, and it
> > gets ext4 encryption with subpage-sized blocks working.
> > 
> > Note: to keep things simple I'm just allocating the work object from the
> > bi_end_io function with GFP_ATOMIC.  But if people think it's necessary,
> > it could be changed to use preallocation like the page-based read path.
> > 
> > Tested with 'gce-xfstests -c ext4/encrypt_1k -g auto', using the new
> > "encrypt_1k" config I created.  All tests pass except for those that
> > already fail or are excluded with the encrypt or 1k configs, and 2 tests
> > that try to create 1023-byte symlinks which fails since encrypted
> > symlinks are limited to blocksize-3 bytes.  Also ran the dedicated
> > encryption tests using 'kvm-xfstests -c ext4/1k -g encrypt'; all pass,
> > including the on-disk ciphertext verification tests.
> > 
> > [1] https://lkml.kernel.org/linux-fsdevel/20190910155115.28550-1-chandan@linux.ibm.com/T/#u
> > 
> > Changed v1 => v2:
> >   - Added check for S_ISREG() which technically should be there, though
> >     it happens not to matter currently.
> > 
> > Chandan Rajendra (1):
> >   ext4: Enable encryption for subpage-sized blocks
> > 
> > Eric Biggers (1):
> >   fs/buffer.c: support fscrypt in block_read_full_page()
> > 
> >  Documentation/filesystems/fscrypt.rst |  4 +--
> >  fs/buffer.c                           | 48 ++++++++++++++++++++++++---
> >  fs/ext4/super.c                       |  7 ----
> >  3 files changed, 45 insertions(+), 14 deletions(-)
> > 
> 
> Any more comments on this?
> 
> Ted, are you interested in taking this through the ext4 tree for 5.5?
> 

Ping.
