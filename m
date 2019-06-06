Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E249D37246
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 12:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfFFK66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 06:58:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:32798 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727324AbfFFK66 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:58:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F9F6AF21;
        Thu,  6 Jun 2019 10:58:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ED0EC1E3F51; Thu,  6 Jun 2019 12:58:55 +0200 (CEST)
Date:   Thu, 6 Jun 2019 12:58:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 07/10] fs/ext4: Fail truncate if pages are GUP pinned
Message-ID: <20190606105855.GG7433@quack2.suse.cz>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606014544.8339-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606014544.8339-8-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-06-19 18:45:40, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> If pages are actively gup pinned fail the truncate operation.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  fs/ext4/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 75f543f384e4..1ded83ec08c0 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4250,6 +4250,9 @@ int ext4_break_layouts(struct inode *inode, loff_t offset, loff_t len)
>  		if (!page)
>  			return 0;
>  
> +		if (page_gup_pinned(page))
> +			return -ETXTBSY;
> +
>  		error = ___wait_var_event(&page->_refcount,
>  				atomic_read(&page->_refcount) == 1,
>  				TASK_INTERRUPTIBLE, 0, 0,

This caught my eye. Does this mean that now truncate for a file which has
temporary gup users (such buffers for DIO) can fail with ETXTBUSY? That
doesn't look desirable. If we would mandate layout lease while pages are
pinned as I suggested, this could be dealt with by checking for leases with
pins (breaking such lease would return error and not break it) and if
breaking leases succeeds (i.e., there are no long-term pinned pages), we'd
just wait for the remaining references as we do now.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
