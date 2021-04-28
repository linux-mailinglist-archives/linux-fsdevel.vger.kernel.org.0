Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C4736D954
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 16:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbhD1OO1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 10:14:27 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36931 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229807AbhD1OO0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 10:14:26 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13SECx3x023455
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 10:13:00 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A932815C3C3D; Wed, 28 Apr 2021 10:12:59 -0400 (EDT)
Date:   Wed, 28 Apr 2021 10:12:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        Christoph Hellwig <hch@infradead.org>,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
        ebiggers@google.com, drosen@google.com, ebiggers@kernel.org,
        yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v8 4/4] fs: unicode: Add utf8 module and a unicode layer
Message-ID: <YIlta1Saw7dEBpfs@mit.edu>
References: <20210423205136.1015456-1-shreeya.patel@collabora.com>
 <20210423205136.1015456-5-shreeya.patel@collabora.com>
 <20210427062907.GA1564326@infradead.org>
 <61d85255-d23e-7016-7fb5-7ab0a6b4b39f@collabora.com>
 <YIgkvjdrJPjeoJH7@mit.edu>
 <87bl9z937q.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl9z937q.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 11:06:33AM -0400, Gabriel Krisman Bertazi wrote:
> > I think the better argument to make is just one of simplicity;
> > separating the Unicode data table from the kernel adds complexity.  It
> > also reduces flexibility, since for use cases where it's actually
> > _preferable_ to have Unicode functionality permanently built-in the
> > kernel, we now force the use of some kind of initial ramdisk to load a
> > module before the root file system (which might require Unicode
> > support) could even be mounted.
> 
> FWIW, embedding FW images to the kernel is also well supported.  Making
> the data trie a firmware doesn't make a ramdisk more of a requirement
> than the module solution, I think.

I don't think we support building firmware directly into the kernel
any more.  We used to, but IIRC, there was the feeling that 99.99% of
the time, firmware modules were not GPL compliant, and so we ripped
out that support.

So my point was with the module support, it's *optional* that it be
compiled as a module, which is convenient for those use cases, such as
for example a mobile handset --- where there is no need for modules
since the hardware doesn't change, and so modules and an initrd is
just unnecessary complexity --- and firmware, which would make an
initial ramdisk mandatory if you wanted to use the casefold feature.

Put another way, the only reason why putting the unicode tables in a
module is to make life easier for desktop distros.  For mobile
handsets, modules are an anti-feature, which is why there was no call
for supporting this initially, given the initial use case for the
casefold feature.

Cheers,

					- Ted
