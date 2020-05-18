Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C381D8868
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 21:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgERTod (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 15:44:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbgERTod (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 15:44:33 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95188207F5;
        Mon, 18 May 2020 19:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589831073;
        bh=oy9YnKVQd9UwRnc0AtIyh15UtZegjDULjfw6/wLKXW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SblDj+20WmoadkylWzDlhSuXFLQFYLblQPumAF+SNiOzE+jUzPscJBuBMJbnCE8mD
         lGz3g4eitY2LWDyGlkH81wxuPMztTxhLxKfRPqPfCUT3Le8PYk0rY8UCnkpOyKDRU0
         scWVGb1emwQ9G2B0TUrFPeoK822n+eyzHxCy3Qvg=
Date:   Mon, 18 May 2020 12:44:31 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] fs/ext4: Disallow encryption if inode is DAX
Message-ID: <20200518194431.GB121709@gmail.com>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
 <20200513054324.2138483-4-ira.weiny@intel.com>
 <20200516020253.GG1009@sol.localdomain>
 <20200518050315.GA3025231@iweiny-DESK2.sc.intel.com>
 <20200518162447.GA954@sol.localdomain>
 <20200518192357.GE3025231@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518192357.GE3025231@iweiny-DESK2.sc.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 12:23:57PM -0700, Ira Weiny wrote:
> > 
> > The other question is what should happen when a file is created in an encrypted
> > directory when the filesystem is mounted with -o dax.  Actually, I think I
> > missed something there.  Currently (based on reading the code) the DAX flag will
> > get set first, and then ext4_set_context()
> 
> See this is where I am confused.  Above you said that ext4_set_context() is only
> called on a directory.  And I agree with you now having seen the check in
> fscrypt_ioctl_set_policy().  So what is the call path you are speaking of here?

Here's what I actually said:

	ext4_set_context() is only called when FS_IOC_SET_ENCRYPTION_POLICY sets
	an encryption policy on an empty directory, *or* when a new inode
	(regular, dir, or symlink) is created in an encrypted directory (thus
	inheriting encryption from its parent).

Just find the places where ->set_context() is called and follow them backwards.

- Eric
