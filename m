Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C6AA760C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 23:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfICVR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 17:17:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41590 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726375AbfICVR5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:17:57 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-96.corp.google.com [104.133.0.96] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x83LHmaX031393
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Sep 2019 17:17:49 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E453442049E; Tue,  3 Sep 2019 17:17:47 -0400 (EDT)
Date:   Tue, 3 Sep 2019 17:17:47 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Qian Cai <cai@lca.pw>, Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: "beyond 2038" warnings from loopback mount is noisy
Message-ID: <20190903211747.GD2899@mit.edu>
References: <1567523922.5576.57.camel@lca.pw>
 <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 09:18:44AM -0700, Deepa Dinamani wrote:
> 
> This prints a warning for each inode that doesn't extend limits beyond
> 2038. It is rate limited by the ext4_warning_inode().
> Looks like your filesystem has inodes that cannot be extended.
> We could use a different rate limit or ignore this corner case. Do the
> maintainers have a preference?

We need to drop this commit (ext4: Initialize timestamps limits), or
at least the portion which adds the call to the EXT4_INODE_SET_XTIME
macro in ext4.h.  

I know of a truly vast number of servers in production all over the
world which are using 128 byte inodes, and spamming the inodes at the
maximum rate limit is a really bad idea.  This includes at some major
cloud data centers where the life of individual servers in their data
centers is well understood (they're not going to last until 2038) and
nothing stored on the local Linux file systems are long-lived ---
that's all stored in the cluster file systems.  The choice of 128 byte
inode was deliberately chosen to maximize storage TCO, and so spamming
a warning at high rates is going to be extremely unfriendly.

In cases where the inode size is such that there is no chance at all
to support timestamps beyond 2038, a single warning at mount time, or
maybe a warning at mkfs time might be acceptable.  But there's no
point printing a warning time each time we set a timestamp on such a
file system.  It's not going to change, and past a certain point, we
need to trust that people who are using 128 byte inodes did so knowing
what the tradeoffs might be.  After all, it is *not* the default.

     	 	   	      	    	 - Ted
