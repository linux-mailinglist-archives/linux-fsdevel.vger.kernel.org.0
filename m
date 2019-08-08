Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C11085A05
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 07:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfHHFtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 01:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbfHHFtj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 01:49:39 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D142214C6;
        Thu,  8 Aug 2019 05:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565243377;
        bh=yK/HFvksaQrj8GwaFCyuT15Mjv+wfQ/4JtVWU/RSuqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WckH3pdJxuB5qMJYz95SwgB+YRSOgVEYey5Fftk5MGP5Tgx4unBvapT7MHxc8WKzL
         6IH+YPolHVzJT2xF7R+LIAICMmzHHVW2SZyO9qd5WNih8kg1JdG0hxv4s0s63X2T5h
         8lGkyM8QHmMV2P7D2TvwFu1HpMhGc7FWGZjZUEoY=
Date:   Wed, 7 Aug 2019 22:49:36 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <RGoldwyn@suse.com>,
        "hch@lst.de" <hch@lst.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ruansy.fnst@cn.fujitsu.com" <ruansy.fnst@cn.fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Message-ID: <20190808054936.GA5319@sol.localdomain>
Mail-Followup-To: Gao Xiang <gaoxiang25@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <RGoldwyn@suse.com>, "hch@lst.de" <hch@lst.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ruansy.fnst@cn.fujitsu.com" <ruansy.fnst@cn.fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-11-rgoldwyn@suse.de>
 <20190804234321.GC7689@dread.disaster.area>
 <1565021323.13240.14.camel@suse.com>
 <20190805215458.GH7689@dread.disaster.area>
 <20190808042640.GA28630@138>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808042640.GA28630@138>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 08, 2019 at 12:26:42PM +0800, Gao Xiang wrote:
> > 
> > > > That's why I don't like this hook - I think hiding data operations
> > > > and/or custom bio manipulations in opaque filesystem callouts is
> > > > completely the wrong approach to be taking. We need to do these
> > > > things in a generic manner so that all filesystems (and block
> > > > devices!) that use the iomap infrastructure can take advantage of
> > > > them, not just one of them.
> > > > 
> > > > Quite frankly, I don't care if it takes more time and work up front,
> > > > I'm tired of expedient hacks to merge code quickly repeatedly biting
> > > > us on the arse and wasting far more time sorting out than we would
> > > > have spent getting it right in the first place.
> > > 
> > > Sure. I am open to ideas. What are you proposing?
> > 
> > That you think about how to normalise the btrfs IO path to fit into
> > the standard iomap/blockdev model, rather than adding special hacks
> > to iomap to allow an opaque, custom, IO model to be shoe-horned into
> > the generic code.
> > 
> > For example, post-read validation requires end-io processing,
> > whether it be encryption, decompression, CRC/T10 validation, etc. The
> > iomap end-io completion has all the information needed to run these
> > things, whether it be a callout to the filesystem for custom
> > processing checking, or a generic "decrypt into supplied data page"
> > sort of thing. These all need to be done in the same place, so we
> > should have common support for this. And I suspect the iomap should
> > also state in a flag that something like this is necessary (e.g.
> > IOMAP_FL_ENCRYPTED indicates post-IO decryption needs to be run).
> 
> Add some word to this topic, I think introducing a generic full approach
> to IOMAP for encryption, decompression, verification is hard to meet all
> filesystems, and seems unnecessary, especially data compression is involved.
> 
> Since the data decompression will expand the data, therefore the logical
> data size is not same as the physical data size:
> 
> 1) IO submission should be applied to all physical data, but data
>    decompression will be eventually applied to logical mapping.
>    As for EROFS, it submits all physical pages with page->private
>    points to management structure which maintain all logical pages
>    as well for further decompression. And time-sharing approach is
>    used to save the L2P mapping array in these allocated pages itself.
> 
>    In addition, IOMAP also needs to consider fixed-sized output/input
>    difference which is filesystem specific and I have no idea whether
>    involveing too many code for each requirement is really good for IOMAP;
> 
> 2) The post-read processing order is another negotiable stuff.
>    Although there is no benefit to select verity->decrypt rather than
>    decrypt->verity; but when compression is involved, the different
>    orders could be selected by different filesystem users:
> 
>     1. decrypt->verity->decompress
> 
>     2. verity->decompress->decrypt
> 
>     3. decompress->decrypt->verity
> 
>    1. and 2. could cause less computation since it processes
>    compressed data, and the security is good enough since
>    the behavior of decompression algorithm is deterministic.
>    3 could cause more computation.
> 
> All I want to say is the post process is so complicated since we have
> many selection if encryption, decompression, verification are all involved.
> 
> Maybe introduce a core subset to IOMAP is better for long-term
> maintainment and better performance. And we should consider it
> more carefully.
> 

FWIW, the only order that actually makes sense is decrypt->decompress->verity.

Decrypt before decompress, i.e. encrypt after compress, because only the
plaintext can be compressible; the ciphertext isn't.

Verity last, on the original data, because otherwise the file hash that
fs-verity reports would be specific to that particular inode on-disk and
therefore would be useless for authenticating the file's user-visible contents.

[By "verity" I mean specifically fs-verity.  Integrity-only block checksums are
a different case; those can be done at any point, but doing them on the
compressed data would make sense as then there would be less to checksum.

And yes, compression+encryption leaks information about the original data, so
may not be advisable.  My point is just that if the two are nevertheless
combined, it only makes sense to compress the plaintext.]

- Eric
