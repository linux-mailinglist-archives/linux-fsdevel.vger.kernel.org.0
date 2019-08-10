Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC0D88765
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 02:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfHJAun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 20:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfHJAun (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 20:50:43 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEF692166E;
        Sat, 10 Aug 2019 00:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565398242;
        bh=mo8l3bRyt5Jd9FuRpPpKKTBlHJxHoNCfncJoOVYbEl8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=foIoCvWXokicjWhGUJmARbIpBNIHfDheFNTdlaBILMaFLU3QJiDGRt4HrHLGxceiv
         orwO9AZSaXDHRtl6OHkyRiVe8yA22NJEI1fN0Jz8LPfht05y2x4DVDmuiQntua+amJ
         bRduBOqQrzayZ7MprbS4/wp//0ccFFvKripLmFxw=
Date:   Fri, 9 Aug 2019 17:50:40 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gao Xiang <hsiangkao@aol.com>,
        Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <RGoldwyn@suse.com>,
        "hch@lst.de" <hch@lst.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ruansy.fnst@cn.fujitsu.com" <ruansy.fnst@cn.fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Message-ID: <20190810005038.GG100971@gmail.com>
Mail-Followup-To: Gao Xiang <hsiangkao@aol.com>,
        Matthew Wilcox <willy@infradead.org>,
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
 <20190809234554.GA25734@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190810003135.GF100971@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810003135.GF100971@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 09, 2019 at 05:31:35PM -0700, Eric Biggers wrote:
> On Sat, Aug 10, 2019 at 07:45:59AM +0800, Gao Xiang wrote:
> > Hi Willy,
> > 
> > On Fri, Aug 09, 2019 at 01:45:17PM -0700, Matthew Wilcox wrote:
> > > On Wed, Aug 07, 2019 at 10:49:36PM -0700, Eric Biggers wrote:
> > > > On Thu, Aug 08, 2019 at 12:26:42PM +0800, Gao Xiang wrote:
> > > > >     1. decrypt->verity->decompress
> > > > > 
> > > > >     2. verity->decompress->decrypt
> > > > > 
> > > > >     3. decompress->decrypt->verity
> > > > > 
> > > > >    1. and 2. could cause less computation since it processes
> > > > >    compressed data, and the security is good enough since
> > > > >    the behavior of decompression algorithm is deterministic.
> > > > >    3 could cause more computation.
> > > > > 
> > > > > All I want to say is the post process is so complicated since we have
> > > > > many selection if encryption, decompression, verification are all involved.
> > > > > 
> > > > > Maybe introduce a core subset to IOMAP is better for long-term
> > > > > maintainment and better performance. And we should consider it
> > > > > more carefully.
> > > > > 
> > > > 
> > > > FWIW, the only order that actually makes sense is decrypt->decompress->verity.
> > > 
> > > That used to be true, but a paper in 2004 suggested it's not true.
> > > Further work in this space in 2009 based on block ciphers:
> > > https://arxiv.org/pdf/1009.1759
> > > 
> > > It looks like it'd be computationally expensive to do, but feasible.
> > 
> > Yes, maybe someone cares where encrypt is at due to their system design.
> > 
> > and I thought over these days, I have to repeat my thought of verity
> > again :( the meaningful order ought to be "decrypt->verity->decompress"
> > rather than "decrypt->decompress->verity" if compression is involved.
> > 
> > since most (de)compress algorithms are complex enough (allocate memory and
> > do a lot of unsafe stuffes such as wildcopy) and even maybe unsafe by its
> > design, we cannot do verity in the end for security consideration thus
> > the whole system can be vulnerable by this order from malformed on-disk
> > data. In other words, we need to verify on compressed data.
> > 
> > Fsverity is fine for me since most decrypt algorithms is stable and reliable
> > and no compression by its design, but if some decrypt software algorithms is
> > complicated enough, I'd suggest "verity->decrypt" as well to some extent.
> > 
> > Considering transformation "A->B->C->D->....->verity", if any of "A->B->C
> > ->D->..." is attacked by the malformed on-disk data... It would crash or
> > even root the whole operating system.
> > 
> > All in all, we have to verify data earlier in order to get trusted data
> > for later complex transformation chains.
> > 
> > The performance benefit I described in my previous email, it seems no need
> > to say again... please take them into consideration and I think it's no
> > easy to get a unique generic post-read order for all real systems.
> > 
> 
> While it would be nice to protect against filesystem bugs, it's not the point of
> fs-verity.  fs-verity is about authenticating the contents the *user* sees, so
> that e.g. a file can be distributed to many computers and it can be
> authenticated regardless of exactly what other filesystem features were used
> when it was stored on disk.  Different computers may use:
> 
> - Different filesystems
> - Different compression algorithms (or no compression)
> - Different compression strengths, even with same algorithm
> - Different divisions of the file into compression units
> - Different encryption algorithms (or no encryption)
> - Different encryption keys, even with same algorithm
> - Different encryption nonces, even with same key
> 
> All those change the on-disk data; only the user-visible data stays the same.
> 
> Bugs in filesystems may also be exploited regardless of fs-verity, as the
> attacker (able to manipulate on-disk image) can create a malicious file without
> fs-verity enabled, somewhere else on the filesystem.
> 
> If you actually want to authenticate the full filesystem image, you need to use
> dm-verity, which is designed for that.
> 

Also keep in mind that ideally the encryption layer would do authenticated
encryption, so that during decrypt->decompress->verity the blocks only get past
the decrypt step if they're authentically from someone with the encryption key.
That's currently missing from fscrypt for practical reasons (read/write
per-block metadata is really hard on most filesystems), but in an ideal world it
would be there.  The fs-verity step is conceptually different, but it seems it's
being conflated with this missing step.

- Eric
