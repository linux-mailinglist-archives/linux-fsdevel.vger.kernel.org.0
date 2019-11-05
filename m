Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32A6F07D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 22:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfKEVLK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 16:11:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40644 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKEVLJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 16:11:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id r4so16837582pfl.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Nov 2019 13:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BdIEF8K53YWXxsclPzxQcvlGt89ec6BCfGDQwCysi6M=;
        b=Cf35WTH0kvIkkKNntFZTDAVSl+gDolMkqXbvBaDVXymCbDxuCbql06STsRiJ+ounfQ
         Ju9S0HokQCF3ouOkyRn9w7CfKKiKbYo5yoZLZgzqR52GDErVINWUpKCI4B/Eun5bD3rA
         WroEqbWD20BpC5fznAKstWb8Y1oqIQgR1CwbspFDOWRXJUji153GlVa9YfY5VTN1OcfK
         kM5z3koEpfUl2cveS0uEX+ekeayg8iKyryPiPqkagd8cGMmBATmnmxIyhjaK+zZ9WIQu
         GvHt0Odl8H2TKwVYqfMLrV9zqAcCdSOUSufYr2JV2vCB0leh86rCl8oCy8eYRncBRnlu
         QVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BdIEF8K53YWXxsclPzxQcvlGt89ec6BCfGDQwCysi6M=;
        b=ggFRRdxrMjV8bKW7Pa1of+bRnKEIBK1Lbj5X79q5rbrLWU8pV9Dvo3xwIQOfUtzvkM
         sr+h4BRK1t5q4yI7Lv6Pcqasg6pJ3bhaHm/CrEPbJXnlhAHRPmGWwksl3OwMdXv0Xswx
         IYIlKJ/o4w5ftwzXQLgPnlix+UxAF1Tq9Iki417WrjqHZMg4vTARl6JQL13eFrNqRprA
         chJAFt6G13oYdtP/wQQUq+vdZw7QWDO+G9+lK7TKGDPo1qTJ1P8lOvjULhD7yL1q7kPb
         GZJgoUSgQTKcCb/UbK1nohBneUAlepdZ6lR0Mu9XrzayMc1yo4CaVOfwO1qaymerIkd+
         UsSQ==
X-Gm-Message-State: APjAAAV/aeqZs3kqHZQUmCyKTP/FZn2eVB24AJHuk5ZWrLMR1BvSEmJ9
        nyuTVWIchlMfi/UeKycE0y1p
X-Google-Smtp-Source: APXvYqwC6OvB1VmycMnaGfR7F4uavyr51d/1VLIcps5IKGn8aRQARfP7Ldc6kuT/25HvbNRfzPi1Kw==
X-Received: by 2002:a63:541e:: with SMTP id i30mr38656865pgb.130.1572988266553;
        Tue, 05 Nov 2019 13:11:06 -0800 (PST)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id s18sm5173866pfs.20.2019.11.05.13.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 13:11:05 -0800 (PST)
Date:   Wed, 6 Nov 2019 08:10:59 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: Re: [PATCH v7 08/11] ext4: move inode extension/truncate code out
 from ->iomap_end() callback
Message-ID: <20191105211058.GD1739@bobrowski>
References: <cover.1572949325.git.mbobrowski@mbobrowski.org>
 <d41ffa26e20b15b12895812c3cad7c91a6a59bc6.1572949325.git.mbobrowski@mbobrowski.org>
 <20191105154950.GC15203@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105154950.GC15203@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 05, 2019 at 07:49:50AM -0800, Darrick J. Wong wrote:
> On Tue, Nov 05, 2019 at 11:01:51PM +1100, Matthew Bobrowski wrote:
> > In preparation for implementing the iomap direct I/O modifications,
> > the inode extension/truncate code needs to be moved out from the
> > ext4_iomap_end() callback. For direct I/O, if the current code
> > remained, it would behave incorrrectly. Updating the inode size prior
> > to converting unwritten extents would potentially allow a racing
> > direct I/O read to find unwritten extents before being converted
> > correctly.
> > 
> > The inode extension/truncate code now resides within a new helper
> > ext4_handle_inode_extension(). This function has been designed so that
> > it can accommodate for both DAX and direct I/O extension/truncate
> > operations.
> > 
> > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> >  fs/ext4/file.c  | 89 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >  fs/ext4/inode.c | 48 +-------------------------
> >  2 files changed, 89 insertions(+), 48 deletions(-)
> > 
> > diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> > index 440f4c6ba4ee..ec54fec96a81 100644
> > --- a/fs/ext4/file.c
> > +++ b/fs/ext4/file.c
> > @@ -33,6 +33,7 @@
> >  #include "ext4_jbd2.h"
> >  #include "xattr.h"
> >  #include "acl.h"
> > +#include "truncate.h"
> >  
> >  static bool ext4_dio_supported(struct inode *inode)
> >  {
> > @@ -234,12 +235,95 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
> >  	return iov_iter_count(from);
> >  }
> >  
> > +static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> > +					   ssize_t written, size_t count)
> > +{
> > +	handle_t *handle;
> > +	bool truncate = false;
> > +	u8 blkbits = inode->i_blkbits;
> > +	ext4_lblk_t written_blk, end_blk;
> > +
> > +	/*
> > +	 * Note that EXT4_I(inode)->i_disksize can get extended up to
> > +	 * inode->i_size while the I/O was running due to writeback of delalloc
> > +	 * blocks. But, the code in ext4_iomap_alloc() is careful to use
> > +	 * zeroed/unwritten extents if this is possible; thus we won't leave
> > +	 * uninitialized blocks in a file even if we didn't succeed in writing
> > +	 * as much as we intended.
> > +	 */
> > +	WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize);
> > +	if (offset + count <= EXT4_I(inode)->i_disksize) {
> > +		/*
> > +		 * We need to ensure that the inode is removed from the orphan
> > +		 * list if it has been added prematurely, due to writeback of
> > +		 * delalloc blocks.
> > +		 */
> > +		if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
> > +			handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> > +
> > +			if (IS_ERR(handle)) {
> > +				ext4_orphan_del(NULL, inode);
> > +				return PTR_ERR(handle);
> > +			}
> > +
> > +			ext4_orphan_del(handle, inode);
> > +			ext4_journal_stop(handle);
> 
> I keep seeing this chunk (and the ext4_orphan_add chunk) bouncing around
> through this patchset, which causes me to wonder -- would it be useful
> to refactor these into small helpers?  Or is it really just the same two
> orphan_add/del chunks bouncing around multiple places?

No, you're right. This and the other pattern is sprayed throughout the
patchset, but also possibly throughout some of the other chunks of
EXT4 code (I think), which I haven't touched here. So, my thought
process was to actually introduce a small separate cleanup patchset
that does exactly that i.e. moves out these duplicate chunks
orphan_add/orphan_del into small helpers.

/M
