Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFC6B80726
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2019 18:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbfHCQDR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Aug 2019 12:03:17 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50491 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387464AbfHCQDR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Aug 2019 12:03:17 -0400
Received: from callcc.thunk.org ([199.116.115.135])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x73G2wIF010152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Aug 2019 12:03:00 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DE3914202F5; Sat,  3 Aug 2019 12:02:57 -0400 (EDT)
Date:   Sat, 3 Aug 2019 12:02:57 -0400
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
Message-ID: <20190803160257.GG4308@mit.edu>
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
 <20190802154341.GB4308@mit.edu>
 <CAK8P3a1Z+nuvBA92K2ORpdjQ+i7KrjOXCFud7fFg4n73Fqx_8Q@mail.gmail.com>
 <20190802213944.GE4308@mit.edu>
 <CAK8P3a2z+ZpyONnC+KE1eDbtQ7m2m3xifDhfWe6JTCPPRB0S=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2z+ZpyONnC+KE1eDbtQ7m2m3xifDhfWe6JTCPPRB0S=g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 03, 2019 at 11:30:22AM +0200, Arnd Bergmann wrote:
> 
> I see in the ext4 code that we always try to expand i_extra_size
> to s_want_extra_isize in ext4_mark_inode_dirty(), and that
> s_want_extra_isize is always at least  s_min_extra_isize, so
> we constantly try to expand the inode to fit.

Yes, we *try*.  But we may not succeed.  There may actually be a
problem here if the cause is due to there simply is no space in the
external xattr block, so we might try and try every time we try to
modify that inode, and it would be a performance mess.  If it's due to
there being no room in the current transaction, then it's highly
likely it will succeed the next time.

> Did older versions of ext4 or ext3 ignore s_min_extra_isize
> when creating inodes despite
> EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE,
> or is there another possibility I'm missing?

s_min_extra_isize could get changed in order to make room for some new
file system feature --- such as extended timestamps.  That's how we
might take an old ext3 file system with an inode size > 128, and try
to evacuate space for extended timestamps, on a best efforts basis.
And since it's best efforts is why Red Hat refuses to support that
case.  It'll work 99.9% of the time, but they don't want to deal with
the 0.01% cases showing up at their help desk.

If you want to pretend that file systems never get upgraded, then life
is much simpler.  The general approach is that for less-sophisticated
customers (e.g., most people running enterprise distros) file system
upgrades are not a thing.  But for sophisticated users, we do try to
make thing work for people who are aware of the risks / caveats /
rough edges.  Google won't have been able to upgrade thousands and
thousands of servers in data centers all over the world if we limited
ourselves to Red Hat's support restrictions.  Backup / reformat /
restore really isn't a practical rollout strategy for many exabytes of
file systems.

It sounds like your safety checks / warnings are mostly targeted at
low-information customers, no?

					- Ted
