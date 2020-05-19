Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176671D9A47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 16:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgESOpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 10:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728647AbgESOpE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 10:45:04 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB3C920825;
        Tue, 19 May 2020 14:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589899503;
        bh=IaVjtUjZRfD5n9+imvde6GZIZTX/UXJ/zi0G9EtqwY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJzQ71AZohKqnmu/hIb1vJojWlq7pnCYd6ePvm+HoHwhRH6gnFUNWLJbDW6vXlxy+
         Sjjoqco6E4dO0ac3gZYa7/CYDGb5rG1spEg7Ug7kjnlZETQtiS4HugobFC8VDghAls
         srvR1sb43gH1vlDywH6XqoHrdvbMx4qhRYGcQXCE=
Date:   Tue, 19 May 2020 07:45:01 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-mmc@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Paul Crowley <paulcrowley@google.com>
Subject: Re: [PATCH] fscrypt: add support for IV_INO_LBLK_32 policies
Message-ID: <20200519144501.GA857@sol.localdomain>
References: <20200515204141.251098-1-ebiggers@kernel.org>
 <20200519111321.GE2396055@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519111321.GE2396055@mit.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 07:13:21AM -0400, Theodore Y. Ts'o wrote:
> On Fri, May 15, 2020 at 01:41:41PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > The eMMC inline crypto standard will only specify 32 DUN bits (a.k.a. IV
> > bits), unlike UFS's 64.  IV_INO_LBLK_64 is therefore not applicable, but
> > an encryption format which uses one key per policy and permits the
> > moving of encrypted file contents (as f2fs's garbage collector requires)
> > is still desirable.
> > 
> > To support such hardware, add a new encryption format IV_INO_LBLK_32
> > that makes the best use of the 32 bits: the IV is set to
> > 'SipHash-2-4(inode_number) + file_logical_block_number mod 2^32', where
> > the SipHash key is derived from the fscrypt master key.  We hash only
> > the inode number and not also the block number, because we need to
> > maintain contiguity of DUNs to merge bios.
> > 
> > Unlike with IV_INO_LBLK_64, with this format IV reuse is possible; this
> > is unavoidable given the size of the DUN.  This means this format should
> > only be used where the requirements of the first paragraph apply.
> > However, the hash spreads out the IVs in the whole usable range, and the
> > use of a keyed hash makes it difficult for an attacker to determine
> > which files use which IVs.
> > 
> > Besides the above differences, this flag works like IV_INO_LBLK_64 in
> > that on ext4 it is only allowed if the stable_inodes feature has been
> > enabled to prevent inode numbers and the filesystem UUID from changing.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> 
> I kind of wish we had Kunit tests with test vectors, but that's for
> another commit I think.
> 

We do have ciphertext verification tests in xfstests for all the existing
fscrypt options.  Actually, I had hacked one together for IV_INO_LBLK_32 before
sending this patch
(https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/xfstests-dev.git/commit/?id=55153ceee2948269c0359bd97fc0d58a26139c87).
I'll be sending it for review after I've looked over it again.

Similarly, since earlier this year, we now also have ciphertext verification
tests in Android's VTS (Vendor Test Suite)
(https://android.googlesource.com/platform/test/vts-testcase/kernel/+/refs/heads/master/encryption/).
I'll be adding one for this new flag.

These ciphertext verification tests test the round-trip from the key added by
userspace to the data on-disk -- even if the data is encrypted by inline crypto
hardware rather than the kernel itself.  So they're better than Kunit tests.

The thing I'm struggling with a bit is actually that when inline crypto is used,
IV_INO_LBLK_32 introduces a case where the DUN can wrap from 0xffffffff to 0,
and that case is new/special in that blocks can't be merged over that boundary
even if they are both logically and physically contiguous.  So, we could also
use a test that tests doing I/O around this boundary where the DUN wraps around.

- Eric
