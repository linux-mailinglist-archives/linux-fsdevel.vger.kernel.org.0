Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9349D7FDC4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 17:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfHBPnz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 11:43:55 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46835 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726150AbfHBPnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:43:55 -0400
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x72FhgP0003779
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Aug 2019 11:43:43 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F12A34202F5; Fri,  2 Aug 2019 11:43:41 -0400 (EDT)
Date:   Fri, 2 Aug 2019 11:43:41 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 09/20] ext4: Initialize timestamps limits
Message-ID: <20190802154341.GB4308@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
 <20190730014924.2193-10-deepa.kernel@gmail.com>
 <20190731152609.GB7077@magnolia>
 <CABeXuvpiom9eQi0y7PAwAypUP1ezKKRfbh-Yqr8+Sbio=QtUJQ@mail.gmail.com>
 <20190801224344.GC17372@mit.edu>
 <CAK8P3a3nqmWBXBiFL1kGmJ7yQ_=5S4Kok0YVB3VMFVBuYjFGOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3nqmWBXBiFL1kGmJ7yQ_=5S4Kok0YVB3VMFVBuYjFGOQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 12:39:41PM +0200, Arnd Bergmann wrote:
> Is it correct to assume that this kind of file would have to be
> created using the ext3.ko file system implementation that was
> removed in linux-4.3, but not usiing ext2.ko or ext4.ko (which
> would always set the extended timestamps even in "-t ext2" or
> "-t ext3" mode)?

Correct.  Some of the enterprise distro's were using ext4 to support
"mount -t ext3" even before 4.3.  There's a CONFIG option to enable
using ext4 for ext2 or ext3 if they aren't enabled.

> If we check for s_min_extra_isize instead of s_inode_size
> to determine s_time_gran/s_time_max, we would warn
> at mount time as well as and consistently truncate all
> timestamps to full 32-bit seconds, regardless of whether
> there is actually space or not.
> 
> Alternatively, we could warn if s_min_extra_isize is
> too small, but use i_inode_size to determine
> s_time_gran/s_time_max anyway.

Even with ext4, s_min_extra_isize doesn't guarantee that will be able
to expand the inode.  This can fail if (a) we aren't able to expand
existing the transaction handle because there isn't enough space in
the journal, or (b) there is already an external xattr block which is
also full, so there is no space to evacuate an extended attribute out
of the inode's extra space.

We could be more aggressive by trying to expand make room in the inode
in ext4_iget (when we're reading in the inode, assuming the file
system isn't mounted read/only), instead of in the middle of
mark_inode_dirty().  That will eliminate failure mode (a) --- which is
statistically rare --- but it won't eliminate failure mode (b).

Ultimately, the question is which is worse: having a timestamp be
wrong, or randomly dropping an xattr from the inode to make room for
the extended timestamp.  We've come down on it being less harmful to
have the timestamp be wrong.

But again, this is a pretty rare case.  I'm not convinced it's worth
stressing about, since it's going to require multiple things to go
wrong before a timestamp will be bad.

					- Ted
