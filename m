Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CD31ABDF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 12:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505056AbgDPKc6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 06:32:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:56282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505042AbgDPKc3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:32:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0F955AA55;
        Thu, 16 Apr 2020 10:32:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E39E41E1250; Thu, 16 Apr 2020 12:32:26 +0200 (CEST)
Date:   Thu, 16 Apr 2020 12:32:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 4/8] fs/ext4: Introduce DAX inode flag
Message-ID: <20200416103226.GE23739@quack2.suse.cz>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-5-ira.weiny@intel.com>
 <20200415120846.GG6126@quack2.suse.cz>
 <20200415203924.GD2309605@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415203924.GD2309605@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-04-20 13:39:25, Ira Weiny wrote:
> > > @@ -813,6 +818,17 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
> > >  	return error;
> > >  }
> > >  
> > > +static void ext4_dax_dontcache(struct inode *inode, unsigned int flags)
> > > +{
> > > +	struct ext4_inode_info *ei = EXT4_I(inode);
> > > +
> > > +	if (S_ISDIR(inode->i_mode))
> > > +		return;
> > > +
> > > +	if ((ei->i_flags ^ flags) == EXT4_DAX_FL)
> > > +		inode->i_state |= I_DONTCACHE;
> > > +}
> > > +
> > 
> > You probably want to use the function you've introduced in the XFS series
> > here...
> 
> you mean:
> 
> flag_inode_dontcache()
> ???

Yeah, that's what I meant.

> Yes that is done.  I sent this prior to v8 (where that was added) of the other
> series...

Yep, I thought that was the case but I wanted to mention it as a reminder.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
