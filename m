Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE3C718C572
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 03:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCTCrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 22:47:05 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49369 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725884AbgCTCrE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 22:47:04 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02K2kepw014400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 22:46:40 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CDE30420EBA; Thu, 19 Mar 2020 22:46:39 -0400 (EDT)
Date:   Thu, 19 Mar 2020 22:46:39 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Linux Filesystem Development List 
        <linux-fsdevel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] writeback: avoid double-writing the inode on a lazytime
 expiration
Message-ID: <20200320024639.GH1067245@mit.edu>
References: <20200306004555.GB225345@gmail.com>
 <20200307020043.60118-1-tytso@mit.edu>
 <20200311032009.GC46757@gmail.com>
 <20200311125749.GA7159@mit.edu>
 <20200312000716.GY10737@dread.disaster.area>
 <20200312143445.GA19160@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312143445.GA19160@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 07:34:45AM -0700, Christoph Hellwig wrote:
> I haven't seen the original mail this replies to, but if we could
> get the lazytime expirty by some other means (e.g. an explicit
> callback), XFS could opt out of all the VFS inode tracking again,
> which would simplify a few things.

Part of my thinking of calling 

       inode->i_sb->s_op->dirty_inode(inode, I_DIRTY_TIME_EXPIRED);

So that it would be an explicit callback to XFS.  So why don't I break
this as two patches --- one which uses I_DIRTY_SYNC, as before, and a
second one which changes calls dirty_inode() with
I_DIRTY_TIME_EXPIRED, and with a change to XFS so that it recognizes
I_DIRTY_TIME_EXPIRED as if it were I_DIRTY_SYNC.  If this would then
allow XFS to simplify how it handles VFS tracking, you could do that
in a separate patch.

Does that work?  I'll send out the two patches, and if you can
review/ack the second patch, that would be great.

	       	      	     	  	- Ted
