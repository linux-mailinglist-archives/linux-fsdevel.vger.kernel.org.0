Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C2F7E5EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 00:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389996AbfHAWn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 18:43:58 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36027 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389970AbfHAWn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:43:58 -0400
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x71MhiQQ009996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Aug 2019 18:43:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C0B7E4202F5; Thu,  1 Aug 2019 18:43:44 -0400 (EDT)
Date:   Thu, 1 Aug 2019 18:43:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 09/20] ext4: Initialize timestamps limits
Message-ID: <20190801224344.GC17372@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
 <20190730014924.2193-10-deepa.kernel@gmail.com>
 <20190731152609.GB7077@magnolia>
 <CABeXuvpiom9eQi0y7PAwAypUP1ezKKRfbh-Yqr8+Sbio=QtUJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABeXuvpiom9eQi0y7PAwAypUP1ezKKRfbh-Yqr8+Sbio=QtUJQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:18:28PM -0700, Deepa Dinamani wrote:
> > Say you have a filesystem with s_inode_size > 128 where not all of the
> > ondisk inodes have been upgraded to i_extra_isize > 0 and therefore
> > don't support nanoseconds or times beyond 2038.  I think this happens on
> > ext3 filesystems that reserved extra space for inode attrs that are
> > subsequently converted to ext4?
> 
> I'm confused about ext3 being converted to ext4. If the converted
> inodes have extra space, then ext4_iget() will start using the extra
> space when it modifies the on disk inode, won't it?i

It is possible that you can have an ext3 file system with (for
example) 256 byte inodes, and all of the extra space was used for
extended attributes, then ext4 won't have the extra space available.
This is going toh be on an inode-by-inode basis, and if an extended
attribute is motdified or deleted, the space would become available,t
and then inode would start getting a higher resolution timestamp.

I really don't think it's worth worrying about that, though.  It's
highly unlikely ext3 file systems will be still be in service by the
time it's needed in 2038.  And if so, it's highly unlikely they would
be converted to ext4.

						- Ted
