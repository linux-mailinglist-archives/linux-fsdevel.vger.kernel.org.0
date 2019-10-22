Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8093DFD1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 07:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfJVF1T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 01:27:19 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:39196 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727978AbfJVF1S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 01:27:18 -0400
Received: from dread.disaster.area (pa49-180-40-48.pa.nsw.optusnet.com.au [49.180.40.48])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 95C8A43ED8B;
        Tue, 22 Oct 2019 16:27:14 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iMmhM-0000ft-TN; Tue, 22 Oct 2019 16:27:12 +1100
Date:   Tue, 22 Oct 2019 16:27:12 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3] fscrypt: add support for inline-encryption-optimized
 policies
Message-ID: <20191022052712.GA2083@dread.disaster.area>
References: <20191021230355.23136-1-ebiggers@kernel.org>
 <20191021230355.23136-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021230355.23136-2-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=y881pOMu+B+mZdf5UrsJdA==:117 a=y881pOMu+B+mZdf5UrsJdA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=1XWaLZrsAAAA:8 a=7-415B0cAAAA:8 a=u2WIiwEpneD56I5pijMA:9
        a=5WK52ldy0EvilltI:21 a=YrdWnVge8_36jD4u:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 04:03:53PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Some inline encryption hardware has only a small number of keyslots,
> which would make it inefficient to use the traditional fscrypt per-file
> keys.  The existing DIRECT_KEY encryption policy flag doesn't solve this
> because it assumes that file contents and names are encrypted by the
> same algorithm and that IVs are at least 24 bytes.
> 
> Therefore, add a new encryption policy flag INLINE_CRYPT_OPTIMIZED which
> causes the encryption to modified as follows:
> 
> - The key for file contents encryption is derived from the values
>   (master_key, mode_num, filesystem_uuid).  The per-file nonce is not
>   included, so many files may share the same contents encryption key.
> 
> - The IV for encrypting each block of file contents is built as
>   (inode_number << 32) | file_logical_block_num.
> 
> Including the inode number in the IVs ensures that data in different
> files is encrypted differently, despite per-file keys not being used.
> Limiting the inode and block numbers to 32 bits and putting the block
> number in the low bits is needed to be compatible with inline encryption
> hardware which only supports specifying a 64-bit data unit number which
> is auto-incremented; this is what the UFS and EMMC standards support.

These 32 bit size limits seem arbitrary and rules out implementing
this on larger filesystems. Why not just hash the 64 bit inode, file
offset and block numbers into a single 64 bit value? It is still
unique enough for the stated use (i.e. unique IV for each file
block) but it doesn't limit what filesystem configurations can
actually make use of this functionality....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
