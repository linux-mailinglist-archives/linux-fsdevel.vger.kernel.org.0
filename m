Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD7FA10C244
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 03:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfK1C22 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 21:28:28 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47089 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727432AbfK1C22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 21:28:28 -0500
Received: from callcc.thunk.org (97-71-153.205.biz.bhn.net [97.71.153.205] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAS2SHsO003384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 21:28:18 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1C4934202FD; Wed, 27 Nov 2019 21:28:17 -0500 (EST)
Date:   Wed, 27 Nov 2019 21:28:17 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Daniel Phillips <daniel@phunq.net>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
Message-ID: <20191128022817.GE22921@mit.edu>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
 <c3636a43-6ae9-25d4-9483-34770b6929d0@phunq.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3636a43-6ae9-25d4-9483-34770b6929d0@phunq.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 27, 2019 at 02:27:27PM -0800, Daniel Phillips wrote:
> > (2) It's implemented as userspace code (e.g., it uses open(2),
> > mmap(2), et. al) and using C++, so it would need to be reimplemented
> > from scratch for use in the kernel.
> 
> Right. Some of these details, like open, are obviously trivial, others
> less so. Reimplementing from scratch is an overstatement because the
> actual intrusions of user space code are just a small portion of the code
> and nearly all abstracted behind APIs that can be implemented as needed
> for userspace or kernel in out of line helpers, so that the main source
> is strictly unaware of the difference.

The use of C++ with templates is presumably one of the "less so"
parts, and it was that which I had in mind when I said,
"reimplementing from scratch".

> Also, most of this work is already being done for Tux3,

Great, when that work is done, we can take a look at the code and
see....

> > (5) The claim is made that readdir() accesses files sequentially; but
> > there is also mention in Shardmap of compressing shards (e.g.,
> > rewriting them) to squeeze out deleted and tombstone entries.  This
> > pretty much guarantees that it will not be possible to satisfy POSIX
> > requirements of telldir(2)/seekdir(3) (using a 32-bit or 64-bitt
> > cookie), NFS (which also requires use of a 32-bit or 64-bit cookie
> > while doing readdir scan), or readdir() semantics in the face of
> > directory entries getting inserted or removed from the directory.
> 
> No problem, the data blocks are completely separate from the index so
> readdir just walks through them in linear order a la classic UFS/Ext2.
> What could possibly be simpler, faster or more POSIX compliant?

OK, so what you're saying then is for every single directory entry
addition or removal, there must be (at least) two blocks which must be
modified, an (at least one) index block, and a data block, no?  That
makes it worse than htree, where most of the time we only need to
modify a single leaf node.  We only have to touch an index block when
a leaf node gets full and it needs to be split.

Anyway, let's wait and see how you and Hirofumi-san work out those
details for Tux3, and we can look at that and consider next steps at
that time.

Cheers,

						- Ted
