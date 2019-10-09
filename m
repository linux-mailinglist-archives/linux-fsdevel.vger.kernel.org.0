Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B83F2D1552
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 19:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbfJIRRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 13:17:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33868 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIRRJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:17:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99H4Qat019726;
        Wed, 9 Oct 2019 17:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=e+kWzQrxQf2byJbjBKkRpHqcXy+znI5WFkUC4BF4dKM=;
 b=MFd5gIu5N/dFInw2DBQ7xOBpzZnzFg4bPYJ1bdzcA5P9kbllDuUGHyEolf964rUu98PS
 JipL/IwHqHdcxvxoVRigQxrJrzqCr1McplxIj+qa6ALCVGMeIJo0hnKo9QNNIlcL1g3z
 uaEPXesTMU10bOIMTJtQkdWN11RIQy0xgStHs/TCG9gvtRrqnm/qLm9+xHwRCTxQ4mCO
 YdYlM41tpkH7BvfgferiNGniQbdzcyA3zIBYNY4NtllSWN9fONaQydyL5cafrFtbk1Mg
 OelPehqO7ePXS5v0xVp8wUH96yRr9OEdKozWXEZgYrvN+rCmcmLgVMAz+bMGDaBSbFNF pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vek4qp4nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 17:17:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99H3ABr164231;
        Wed, 9 Oct 2019 17:17:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vgev1vpa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 17:17:01 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x99HGxlW025151;
        Wed, 9 Oct 2019 17:17:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 17:16:58 +0000
Date:   Wed, 9 Oct 2019 10:16:57 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/20] iomap: use a srcmap for a read-modify-write I/O
Message-ID: <20191009171657.GG13108@magnolia>
References: <20191008071527.29304-1-hch@lst.de>
 <20191008071527.29304-9-hch@lst.de>
 <20191008150044.GV13108@magnolia>
 <20191009062824.GA29833@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009062824.GA29833@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910090148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910090148
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 08:28:24AM +0200, Christoph Hellwig wrote:
> On Tue, Oct 08, 2019 at 08:00:44AM -0700, Darrick J. Wong wrote:
> > >  	unsigned long vaddr = vmf->address;
> > >  	loff_t pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
> > >  	struct iomap iomap = { 0 };
> > 
> > Does this definition ^^^^^ need to be converted too?  You convert the
> > one in iomap_apply()...
> 
> Doesn't strictly need to, but it sure would look nicer and fit the theme.
> 
> > 	/*
> > 	 * The @iomap and @srcmap parameters should be set to a hole
> > 	 * prior to calling ->iomap_begin.
> > 	 */
> > 	#define IOMAP_EMPTY_RECORD	{ .type = IOMAP_HOLE }
> > 
> > ...and later...
> > 
> > 	struct iomap srcmap = IOMAP_EMPTY_RECORD;
> > 
> > ..but meh, I'm not sure that adds much.
> 
> I don't really see the point.

Yeah.  Agreed.

> > >  	unsigned flags = IOMAP_FAULT;
> > >  	int error, major = 0;
> > >  	bool write = vmf->flags & FAULT_FLAG_WRITE;
> > > @@ -1292,7 +1293,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
> > >  	 * the file system block size to be equal the page size, which means
> > >  	 * that we never have to deal with more than a single extent here.
> > >  	 */
> > > -	error = ops->iomap_begin(inode, pos, PAGE_SIZE, flags, &iomap);
> > > +	error = ops->iomap_begin(inode, pos, PAGE_SIZE, flags, &iomap, &srcmap);
> > 
> > ->iomap_begin callers are never supposed to touch srcmap, right?
> > Maybe we ought to check that srcmap.io_type == HOLE, at least until
> > someone fixes this code to dax-copy the data from srcmap to iomap?
> 
> What do you mean with touch?  ->iomap_begin fills it out and then the
> caller looks at it, at least for places that can deal with
> read-modify-write operations (DAX currently can't).

Yes, I grok that the DAX code should never get fed a shared mapping, but
maybe we ought to have a WARN_ON_ONCE just in case some filesystem AI
programmer decides to backport a fs patch that results in sending a
non-hole srcmap back to the dax iomap callers.  /We/ know that you
should never do this, but does the AI know? <grumble>

(Yeah, pure paranoia on my part :P)

--D
