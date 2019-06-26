Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C7257027
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 20:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfFZSAQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 14:00:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52284 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfFZSAQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:00:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QHxBYo079956;
        Wed, 26 Jun 2019 18:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=u+lFwXN1JXQ2RqZ5wF0PBpHbBtlD8joPa4FoF3QdQGk=;
 b=BCdD8rT6LZW2fttSTfCEwm4/BMFOziuewtxIgu0aSDzlU8M64M6sv7dTcxh/ukT+wshd
 EPPPowWB3v0pWmzEXgFhZFhzrq2ou/yMQjorZz2eu7dyhfd4W4rRpmiAt+nzjPAGMCR8
 9rgIRHJLToe9gUckNUGefN5fCazliGJJPYvSPJ3vf2eBzrnZMUU5BX5chZMZ3n1yVgf9
 cinGgSJqs85Ok1N0wa1ToQ/x710O0msWAy7y9qYNrBtQOrt/5Ael8Uuo3+PgZhY8AOTy
 paJCDeb6oEtuf7ZPTDjs4sw7WklsT4JkAfY5mBKDv9DCvZ1vu//3XXgyOgEA9foNTJBs lA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t9brtbxkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 18:00:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QHxRAG079901;
        Wed, 26 Jun 2019 18:00:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tat7cy9nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 18:00:07 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5QI06xR022943;
        Wed, 26 Jun 2019 18:00:06 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 11:00:06 -0700
Date:   Wed, 26 Jun 2019 11:00:05 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com
Subject: Re: [PATCH 1/6] iomap: Use a IOMAP_COW/srcmap for a
 read-modify-write I/O
Message-ID: <20190626180005.GB5164@magnolia>
References: <20190621192828.28900-1-rgoldwyn@suse.de>
 <20190621192828.28900-2-rgoldwyn@suse.de>
 <20190624070734.GB3675@lst.de>
 <20190625191442.m27cwx5o6jtu2qch@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625191442.m27cwx5o6jtu2qch@fiona>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260210
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260210
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 02:14:42PM -0500, Goldwyn Rodrigues wrote:
> On  9:07 24/06, Christoph Hellwig wrote:
> > xfs will need to be updated to fill in the additional iomap for the
> > COW case.  Has this series been tested on xfs?
> > 
> 
> No, I have not tested this, or make xfs set IOMAP_COW. I will try to do
> it in the next iteration.

AFAICT even if you did absolutely nothing XFS would continue to work
properly because iomap_write_begin doesn't actually care if it's going
to be a COW write because the only IO it does from the mapping is to
read in the non-uptodate parts of the page if the write offset/len
aren't page-aligned.

> > I can't say I'm a huge fan of this two iomaps in one method call
> > approach.  I always though two separate iomap iterations would be nicer,
> > but compared to that even the older hack with just the additional
> > src_addr seems a little better.
> 
> I am just expanding on your idea of using multiple iterations for the Cow case
> in the hope we can come out of a good design:
> 
> 1. iomap_file_buffered_write calls iomap_apply with IOMAP_WRITE flag.
>    which calls iomap_begin() for the respective filesystem.
> 2. btrfs_iomap_begin() sets up iomap->type as IOMAP_COW and fills iomap
>    struct with read addr information.
> 3. iomap_apply() conditionally for IOMAP_COW calls do_cow(new function)
>    and calls ops->iomap_begin() with flag IOMAP_COW_READ_DONE(new flag).

Unless I'm misreading this, you don't need a do_cow() or
IOMAP_COW_READ_DONE because the page state tracks that for you:

iomap_write_begin calls ->iomap_begin to learn from where it should read
data if the write is not aligned to a page and the page isn't uptodate.
If it's IOMAP_COW then we learn from *srcmap instead of *iomap.

(The write actor then dirties the page)

fsync() or whatever

The mm calls ->writepage.  The filesystem grabs the new COW mapping,
constructs a bio with the new mapping and dirty pages, and submits the
bio.  pagesize >= blocksize so we're always writing full blocks.

The writeback bio completes and calls ->bio_endio, which is the
filesystem's trigger to make the mapping changes permanent, update
ondisk file size, etc.

For direct writes that are not block-aligned, we just bounce the write
to the page cache...

...so it's only dax_iomap_rw where we're going to have to do the COW
ourselves.  That's simple -- map both addresses, copy the regions before
offset and after offset+len, then proceed with writing whatever
userspace sent us.  No need for the iomap code itself to get involved.

> 4. btrfs_iomap_begin() fills up iomap structure with write information.
> 
> Step 3 seems out of place because iomap_apply should be iomap.type agnostic.
> Right?
> Should we be adding another flag IOMAP_COW_DONE, just to figure out that
> this is the "real" write for iomap_begin to fill iomap?
> 
> If this is not how you imagined, could you elaborate on the dual iteration
> sequence?

--D

> 
> 
> -- 
> Goldwyn
