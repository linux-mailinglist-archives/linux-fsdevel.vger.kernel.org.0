Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933F31E0803
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 09:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbgEYH2r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 03:28:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:58302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388948AbgEYH2r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 03:28:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 56897B083;
        Mon, 25 May 2020 07:28:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EF42C1E1270; Mon, 25 May 2020 09:28:44 +0200 (CEST)
Date:   Mon, 25 May 2020 09:28:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 7/8] fs/ext4: Introduce DAX inode flag
Message-ID: <20200525072844.GH14199@quack2.suse.cz>
References: <20200521191313.261929-1-ira.weiny@intel.com>
 <20200521191313.261929-8-ira.weiny@intel.com>
 <20200522114848.GC14199@quack2.suse.cz>
 <20200525043910.GA319107@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525043910.GA319107@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 24-05-20 21:39:10, Ira Weiny wrote:
> On Fri, May 22, 2020 at 01:48:48PM +0200, Jan Kara wrote:
> > And then we should check conflicts with the journal flag as well, as I
> > mentioned in reply to the first patch. There it is more complicated by the
> > fact that we should disallow setting of both EXT4_INODE_DAX_FL and
> > EXT4_JOURNAL_DATA_FL at the same time so the checks will be somewhat more
> > complicated.
> 
> I'm confused by jflag.  Why is EXT4_JOURNAL_DATA_FL stored in jflag?

It isn't just EXT4_JOURNAL_DATA_FL. It is:

	jflag = flags & EXT4_JOURNAL_DATA_FL;

so it is EXT4_JOURNAL_DATA_FL if it should be set by the current ioctl and 0
otherwise. But I agree that since we mostly do

	(jflag ^ oldflags) & EXT4_JOURNAL_DATA_FL

jflags is mostly useless as we could do just

	(flags ^ oldflags) & EXT4_JOURNAL_DATA_FL

I guess it's mostly a relict from the past...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
