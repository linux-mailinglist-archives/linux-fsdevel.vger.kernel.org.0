Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6239D3AE43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 06:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbfFJElw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 00:41:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50236 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfFJElv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 00:41:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5A4djbq014902;
        Mon, 10 Jun 2019 04:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=1rlW4CBK4tGHrpGFthm0IXowDU3XrX/m9jqFgg1EvJs=;
 b=DdQQTu+/oZ8BF78Vl3tSsb9U84OK1y8XCqxtjn2i+ZxuHFIycqvptntC3PB3NuSjZ7tQ
 QKmjw7cLnnSLS55U/ubPkdBlIc5x+/YSrW0qZh5QMmB56/r1MWZ5KQXRl0QeVPuYri5+
 b8xUGpNJqaYNFoP8RM//vtQyCZBGgR0d2Z9NXKJp7dR9DBm8mX2EQ2sonm6F0yVTHxWd
 cL3ROZ6dfNfUUnA0SIOR+IO8zjh7UvQvrjV9SpTbsHGg/5gzVOr879aAAOa+1TNbjIZx
 DLlT37EHBXjkErOWeO8NXIvDjq5iKIJ8nShcQcyxc6zsh4mYgLzzqu28s6IQ9mMDnUfe 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t04etcn0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 04:41:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5A4en2r188090;
        Mon, 10 Jun 2019 04:41:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2t04hxkmcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 04:41:47 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5A4fk0T009554;
        Mon, 10 Jun 2019 04:41:46 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 Jun 2019 21:41:45 -0700
Date:   Sun, 9 Jun 2019 21:41:44 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/8] mm/fs: don't allow writes to immutable files
Message-ID: <20190610044144.GA1872750@magnolia>
References: <155552786671.20411.6442426840435740050.stgit@magnolia>
 <155552787330.20411.11893581890744963309.stgit@magnolia>
 <20190610015145.GB3266@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610015145.GB3266@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9283 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=748
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906100031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9283 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=793 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906100032
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 09, 2019 at 09:51:45PM -0400, Theodore Ts'o wrote:
> On Wed, Apr 17, 2019 at 12:04:33PM -0700, Darrick J. Wong wrote:
> > diff --git a/mm/memory.c b/mm/memory.c
> > index ab650c21bccd..dfd5eba278d6 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -2149,6 +2149,9 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
> >  
> >  	vmf->flags = FAULT_FLAG_WRITE|FAULT_FLAG_MKWRITE;
> >  
> > +	if (vmf->vma->vm_file && IS_IMMUTABLE(file_inode(vmf->vma->vm_file)))
> > +		return VM_FAULT_SIGBUS;
> > +
> >  	ret = vmf->vma->vm_ops->page_mkwrite(vmf);
> >  	/* Restore original flags so that caller is not surprised */
> >  	vmf->flags = old_flags;
> 
> Shouldn't this check be moved before the modification of vmf->flags?
> It looks like do_page_mkwrite() isn't supposed to be returning with
> vmf->flags modified, lest "the caller gets surprised".

Yeah, I think that was a merge error during a rebase... :(

Er ... if you're still planning to take this patch through your tree,
can you move it to above the "vmf->flags = FAULT_FLAG_WRITE..." ?

--D

> 	   	     	       	      	   - Ted
