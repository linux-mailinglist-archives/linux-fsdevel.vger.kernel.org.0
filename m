Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7953129A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 18:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfEaQlw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 12:41:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43915 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726531AbfEaQlv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 12:41:51 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4VGfbdW014324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 May 2019 12:41:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0FB29420481; Fri, 31 May 2019 12:41:37 -0400 (EDT)
Date:   Fri, 31 May 2019 12:41:36 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, Chris Mason <clm@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC][PATCH] link.2: AT_ATOMIC_DATA and AT_ATOMIC_METADATA
Message-ID: <20190531164136.GA3066@mit.edu>
References: <20190527172655.9287-1-amir73il@gmail.com>
 <20190528202659.GA12412@mit.edu>
 <CAOQ4uxgo5jmwQbLAKQre9=7pLQw=CwMgDaWPaJxi-5NGnPEVPQ@mail.gmail.com>
 <CAOQ4uxgj94WR82iHE4PDGSD0UDxG5sCtr+Sv+t1sOHHmnXFYzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgj94WR82iHE4PDGSD0UDxG5sCtr+Sv+t1sOHHmnXFYzQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 31, 2019 at 06:21:45PM +0300, Amir Goldstein wrote:
> What do you think of:
> 
> "AT_ATOMIC_DATA (since Linux 5.x)
> A filesystem which accepts this flag will guarantee that if the linked file
> name exists after a system crash, then all of the data written to the file
> and all of the file's metadata at the time of the linkat(2) call will be
> visible.

".... will be visible after the the file system is remounted".  (Never
hurts to be explicit.)

> The way to achieve this guarantee on old kernels is to call fsync (2)
> before linking the file, but doing so will also results in flushing of
> volatile disk caches.
>
> A filesystem which accepts this flag does NOT
> guarantee that any of the file hardlinks will exist after a system crash,
> nor that the last observed value of st_nlink (see stat (2)) will persist."
> 

This is I think more precise:

    This guarantee can be achieved by calling fsync(2) before linking
    the file, but there may be more performant ways to provide these
    semantics.  In particular, note that the use of the AT_ATOMIC_DATA
    flag does *not* guarantee that the new link created by linkat(2)
    will be persisted after a crash.

We should also document that a file system which does not implement
this flag MUST return EINVAL if it is passed this flag to linkat(2).

     	       	      	     	      - Ted
