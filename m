Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA40485A4F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 08:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbfHHGMF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 02:12:05 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3526 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726475AbfHHGMF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:12:05 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id BF7863E8F6D1250A705C;
        Thu,  8 Aug 2019 14:12:00 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 8 Aug 2019 14:11:14 +0800
Received: from 138 (10.175.124.28) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 8
 Aug 2019 14:11:13 +0800
Date:   Thu, 8 Aug 2019 14:28:26 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <RGoldwyn@suse.com>,
        "hch@lst.de" <hch@lst.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ruansy.fnst@cn.fujitsu.com" <ruansy.fnst@cn.fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <miaoxie@huawei.com>
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Message-ID: <20190808062825.GC28630@138>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-11-rgoldwyn@suse.de>
 <20190804234321.GC7689@dread.disaster.area>
 <1565021323.13240.14.camel@suse.com>
 <20190805215458.GH7689@dread.disaster.area>
 <20190808042640.GA28630@138>
 <20190808054936.GA5319@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190808054936.GA5319@sol.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Eric,

On Wed, Aug 07, 2019 at 10:49:36PM -0700, Eric Biggers wrote:
> On Thu, Aug 08, 2019 at 12:26:42PM +0800, Gao Xiang wrote:
> > > 
> > > > > That's why I don't like this hook - I think hiding data operations
> > > > > and/or custom bio manipulations in opaque filesystem callouts is
> > > > > completely the wrong approach to be taking. We need to do these
> > > > > things in a generic manner so that all filesystems (and block
> > > > > devices!) that use the iomap infrastructure can take advantage of
> > > > > them, not just one of them.
> > > > > 
> > > > > Quite frankly, I don't care if it takes more time and work up front,
> > > > > I'm tired of expedient hacks to merge code quickly repeatedly biting
> > > > > us on the arse and wasting far more time sorting out than we would
> > > > > have spent getting it right in the first place.
> > > > 
> > > > Sure. I am open to ideas. What are you proposing?
> > > 
> > > That you think about how to normalise the btrfs IO path to fit into
> > > the standard iomap/blockdev model, rather than adding special hacks
> > > to iomap to allow an opaque, custom, IO model to be shoe-horned into
> > > the generic code.
> > > 
> > > For example, post-read validation requires end-io processing,
> > > whether it be encryption, decompression, CRC/T10 validation, etc. The
> > > iomap end-io completion has all the information needed to run these
> > > things, whether it be a callout to the filesystem for custom
> > > processing checking, or a generic "decrypt into supplied data page"
> > > sort of thing. These all need to be done in the same place, so we
> > > should have common support for this. And I suspect the iomap should
> > > also state in a flag that something like this is necessary (e.g.
> > > IOMAP_FL_ENCRYPTED indicates post-IO decryption needs to be run).
> > 
> > Add some word to this topic, I think introducing a generic full approach
> > to IOMAP for encryption, decompression, verification is hard to meet all
> > filesystems, and seems unnecessary, especially data compression is involved.
> > 
> > Since the data decompression will expand the data, therefore the logical
> > data size is not same as the physical data size:
> > 
> > 1) IO submission should be applied to all physical data, but data
> >    decompression will be eventually applied to logical mapping.
> >    As for EROFS, it submits all physical pages with page->private
> >    points to management structure which maintain all logical pages
> >    as well for further decompression. And time-sharing approach is
> >    used to save the L2P mapping array in these allocated pages itself.
> > 
> >    In addition, IOMAP also needs to consider fixed-sized output/input
> >    difference which is filesystem specific and I have no idea whether
> >    involveing too many code for each requirement is really good for IOMAP;
> > 
> > 2) The post-read processing order is another negotiable stuff.
> >    Although there is no benefit to select verity->decrypt rather than
> >    decrypt->verity; but when compression is involved, the different
> >    orders could be selected by different filesystem users:
> > 
> >     1. decrypt->verity->decompress
> > 
> >     2. verity->decompress->decrypt
> > 
> >     3. decompress->decrypt->verity
> > 
> >    1. and 2. could cause less computation since it processes
> >    compressed data, and the security is good enough since
> >    the behavior of decompression algorithm is deterministic.
> >    3 could cause more computation.
> > 
> > All I want to say is the post process is so complicated since we have
> > many selection if encryption, decompression, verification are all involved.
> > 
> > Maybe introduce a core subset to IOMAP is better for long-term
> > maintainment and better performance. And we should consider it
> > more carefully.
> > 
> 
> FWIW, the only order that actually makes sense is decrypt->decompress->verity.

I am not just talking about fsverity as you mentioned below.

> 
> Decrypt before decompress, i.e. encrypt after compress, because only the
> plaintext can be compressible; the ciphertext isn't.

There could be some potential users need partially decrypt/decompress,
but that is minor. I don't want to talk about this detail in this topic.

> 
> Verity last, on the original data, because otherwise the file hash that
> fs-verity reports would be specific to that particular inode on-disk and
> therefore would be useless for authenticating the file's user-visible contents.
> 
> [By "verity" I mean specifically fs-verity.  Integrity-only block checksums are
> a different case; those can be done at any point, but doing them on the
> compressed data would make sense as then there would be less to checksum.
> 
> And yes, compression+encryption leaks information about the original data, so
> may not be advisable.  My point is just that if the two are nevertheless
> combined, it only makes sense to compress the plaintext.]

I cannot fully agree with your point. (I was not talking of fs-verity, it's
a generic approach of verity approach.)

Considering we introduce a block-based verity solution for all on-disk data
to EROFS later. It means all data/compressed data and metadata are already
from a trusted source at least (like dm-verity).

Either verity->decompress or decompress->verity is safe since either
decompression algotithms or verity algorithms are _deterministic_ and
should be considered _bugfree_ therefore it should have one result.

And if you say decompression algorithm is untrusted because of bug or
somewhat, I think verity algorithm as well. In other words, if we consider
software/hardware bugs, we cannot trust any combination of results.

A advantage of verity->decompress over decompress->verity is that
the verity data is smaller than decompress->verity, so
  1) we can have less I/O for most I/O patterns;
and
  2) we can consume less CPUs.

Take a step back, there are many compression algorithm in the
user-space like apk or what ever, so the plaintext is in a
relatively speaking. We cannot consider the data to end-user is
absolutely right.

Thanks,
Gao Xiang


> 
> - Eric
