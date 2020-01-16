Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C91E213F425
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 19:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392106AbgAPSri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 13:47:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:63927 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391802AbgAPSrh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:47:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 10:47:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="218640226"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga008.jf.intel.com with ESMTP; 16 Jan 2020 10:47:34 -0800
Date:   Thu, 16 Jan 2020 10:47:34 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH V2 05/12] fs: remove unneeded IS_DAX() check
Message-ID: <20200116184733.GD24522@iweiny-DESK2.sc.intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-6-ira.weiny@intel.com>
 <20200116093807.GB8446@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116093807.GB8446@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 16, 2020 at 10:38:07AM +0100, Jan Kara wrote:
> On Fri 10-01-20 11:29:35, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The IS_DAX() check in io_is_direct() causes a race between changing the
> > DAX mode and creating the iocb flags.
> > 
> > Remove the check because DAX now emulates the page cache API and
> > therefore it does not matter if the file mode is DAX or not when the
> > iocb flags are created.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks,
Ira

> 
> 								Honza
> 
> > ---
> >  include/linux/fs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index d7584bcef5d3..e11989502eac 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -3365,7 +3365,7 @@ extern int file_update_time(struct file *file);
> >  
> >  static inline bool io_is_direct(struct file *filp)
> >  {
> > -	return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host);
> > +	return (filp->f_flags & O_DIRECT);
> >  }
> >  
> >  static inline bool vma_is_dax(struct vm_area_struct *vma)
> > -- 
> > 2.21.0
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
