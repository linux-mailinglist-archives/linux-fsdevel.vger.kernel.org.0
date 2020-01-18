Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0AE1415E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 06:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgARFLf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 00:11:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgARFLf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 00:11:35 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A29920748;
        Sat, 18 Jan 2020 05:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579324294;
        bh=t1vZ8SC75mtY4AmwN7SBHRlYKSnagbFkoaCXwsRkvkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bfOP60cwtWBH/v8P6bKJMNpc8Gkl63UB2y/k5qFX75fnnZYBU3quTl4yD8apowsL/
         7ByOM9cn0DYjc8FS39COLzmK1v0ugkAnRQwk5YG9zWgVJVbJpmspIMpmPonMkzfVw1
         4AM/C7CY1Yz5ho+rFMdKDos1teJ3jUJntffPomMo=
Date:   Fri, 17 Jan 2020 21:11:32 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 2/9] block: Add encryption context to struct bio
Message-ID: <20200118051132.GC3290@sol.localdomain>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-3-satyat@google.com>
 <20191218212116.GA7476@magnolia>
 <yq1y2v9e37b.fsf@oracle.com>
 <20191218222726.GC47399@gmail.com>
 <yq1fthhdttv.fsf@oracle.com>
 <20200108140730.GC2896@infradead.org>
 <20200108172629.GA232722@sol.localdomain>
 <20200117083221.GA324@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117083221.GA324@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 12:32:21AM -0800, Christoph Hellwig wrote:
> 
> File systems don't move data around all that often (saying that with my
> fs developer hat on).  In traditional file systems only defragmentation
> will move data around, with extent refcounting it can also happen for
> dedup, and for file systems that write out of place data gets moved
> when parts of a block are rewritten, but in that case a read modify
> write cycle is perfomed in the Linux code anyway, so it will go through
> the inline encryption engined on the way and the way out.
> 
> So in other words - specifying an IV would be useful for some use cases,
> but I don't think it is a deal blocker. Even without that is is useful
> for block device level encryption, and could have some usefulness for
> file system encryption usage.
> 
> I think that adding an IV would eventually be useful, but fitting that
> into NVMe won't be easy, as you'd need to find a way to specify the IV
> for each submission queue entry, which requires growing it, or finding
> some way to extend it out of band.

Sure, people have even done inline crypto on ext4 before (downstream), using the
LBA for the IV.  But log-structured filesystems like f2fs move data blocks
around *without the encryption key*; and at least for fscrypt, f2fs support is
essential.  In any case it's also awkward having the physical on-disk location
determine the ciphertext on-disk, as then the result isn't fully controlled by
the encryption settings you set, but also based on where your filesystem is
located on-disk (with extra fun occurring if there's any sort of remapping layer
in between).  But sure, it's not *useless* to not be able to specify the IV,
it's just annoying and less useful.

[I was also a bit surprised to see that NVMe won't actually allow specify the
IV, as I thought you had objected to the naming of the INLINE_CRYPT_OPTIMIZED
fscrypt policy flag partly on the grounds that NVMe would support IVs longer
than the 64 bits that UFS is limited to.  Perhaps I misunderstood though.]

> > So let's not over-engineer this kernel patchset to support some broken
> > vaporware, please.
> 
> Not sharing bio fields for integrity and encryption actually keeps
> the patchset simpler (although uses more memory if both options are
> enabled).  So my main point here is to not over engineer it for broken
> premise that won't be true soon.

Well there are 3 options:

(a) Separate fields for bi_crypt_context and bi_integrity
(b) bi_crypt_context and bi_integrity in union
(c) One pointer that can support both features,
    e.g. linked list of tagged structs.

It sounds like you're advocating for (a), but I had misunderstood and thought
you're advocating for (c).  We'd of course be fine with (a) as it's the
simplest, but other people are saying they prefer (b).

Satya, to resolve this I think you should check how hard (b) is to implement --
i.e. is it easy, or is it really tricky to ensure the features are never used
together?  (Considering that it's probably not just a matter of whether any
hardware supports both features, as dm-integrity supports blk-integrity in
software and blk-crypto-fallback supports blk-crypto in software.)

- Eric
