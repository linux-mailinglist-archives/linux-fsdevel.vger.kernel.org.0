Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 957B18872C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 02:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfHJAR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 20:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbfHJAR6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 20:17:58 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A29C20C01;
        Sat, 10 Aug 2019 00:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565396276;
        bh=CKBfsVqLRfFm/qdjhfOernVT1kvfIVKDH/wMItcw5eU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wFSQvWVK6+L1NUjtWhbAnB3f6/ohHqyiyDN3SXLYGo+0ecSdpBQV604+ZQBwhwNZf
         pbf81Q7l3LzTTrbHgHCXDg38dCgG5Zw2Jg9fqcr99+0ZCp/gw1dyT+MxiWNtj0/Q+H
         RRdRAL3zWatpwNKd61DYcjOzIJlsTzCmCfQeJvzE=
Date:   Fri, 9 Aug 2019 17:17:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <RGoldwyn@suse.com>,
        "hch@lst.de" <hch@lst.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ruansy.fnst@cn.fujitsu.com" <ruansy.fnst@cn.fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Message-ID: <20190810001753.GE100971@gmail.com>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <gaoxiang25@huawei.com>,
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
 <20190808054936.GA5319@sol.localdomain>
 <20190809204517.GR5482@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809204517.GR5482@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 09, 2019 at 01:45:17PM -0700, Matthew Wilcox wrote:
> On Wed, Aug 07, 2019 at 10:49:36PM -0700, Eric Biggers wrote:
> > On Thu, Aug 08, 2019 at 12:26:42PM +0800, Gao Xiang wrote:
> > >     1. decrypt->verity->decompress
> > > 
> > >     2. verity->decompress->decrypt
> > > 
> > >     3. decompress->decrypt->verity
> > > 
> > >    1. and 2. could cause less computation since it processes
> > >    compressed data, and the security is good enough since
> > >    the behavior of decompression algorithm is deterministic.
> > >    3 could cause more computation.
> > > 
> > > All I want to say is the post process is so complicated since we have
> > > many selection if encryption, decompression, verification are all involved.
> > > 
> > > Maybe introduce a core subset to IOMAP is better for long-term
> > > maintainment and better performance. And we should consider it
> > > more carefully.
> > > 
> > 
> > FWIW, the only order that actually makes sense is decrypt->decompress->verity.
> 
> That used to be true, but a paper in 2004 suggested it's not true.
> Further work in this space in 2009 based on block ciphers:
> https://arxiv.org/pdf/1009.1759
> 
> It looks like it'd be computationally expensive to do, but feasible.
> 
> > Decrypt before decompress, i.e. encrypt after compress, because only the
> > plaintext can be compressible; the ciphertext isn't.

It's an interesting paper, but even assuming that "compress after encrypt" could
provide some actual benefit over the usual order (I can't think of any in this
context), it doesn't sound practical.  From what I understand from that paper:

- It assumes the compressor just *knows* a priori some pattern in the plaintext,
  i.e. it can't be arbitrary data.  E.g. the compressor for CBC encrypted data
  assumes that each 128 bits of plaintext is drawn from a distibution much
  smaller than the 2^128 possible values, e.g. at most a certain number of bits
  are set.  If any other data is encrypted+compressed, then the compressor will
  corrupt it, and it's impossible for it to detect that it did so.

  That alone makes it unusable for any use case we're talking about here.

- It only works for some specific encryption modes, and even then each
  encryption mode needs a custom compression algorithm designed just for it.
  I don't see how it could work for XTS, let alone a wide-block mode.

- The decompressor needs access to the encryption key.  [If that's allowed, why
  can't the compressor have access to it too?]

- It's almost certainly *much* slower and won't compress as well as conventional
  compression algorithms (gzip, LZ4, ZSTD, ...) that operate on the plaintext.

Eric
