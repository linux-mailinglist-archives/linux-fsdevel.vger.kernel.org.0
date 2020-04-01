Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 638A519B2FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 18:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbgDAQsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 12:48:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55866 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732467AbgDAQsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:48:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031GfPNT184842;
        Wed, 1 Apr 2020 16:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=PneeGvCs3vz/vuCcZ32qMDiqmsybwl8BakfFICTf/z8=;
 b=CYvojCMx9h3Ob8S31J7u6F2Q10H0eXcVs+hEvQrI5it4B/77Zgg2HFX+A1hQHdSFEz/7
 FB/LocMTes3hFUgBiyGvz87EVumBeaKMV7ozqhyGHOkW7E3LzTWRBlG1jMrFi/qiHYnA
 HAlkiPXDbTWuOvJuaA6DkTQxliCuq+8WDyVx68GnRs5tF14UQH+s6NCI7f4FLe5bfW5J
 hilkXm8DnGips9SzC31minjhrE6B2igX+41KnwvvRRdxwP1lQUA8UbxMKaKh1W2sshSo
 BBwCTHuAILhLmuK5pi4L5BlJNKClDNxmu8xc6fRfdlX9Y/BenJqpFtMuGN6hIZYmHpCc kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 303aqhq345-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 16:48:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031Gl629022331;
        Wed, 1 Apr 2020 16:48:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 304sjktncr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 16:48:27 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 031GmQiL013432;
        Wed, 1 Apr 2020 16:48:26 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Apr 2020 09:48:26 -0700
Date:   Wed, 1 Apr 2020 09:48:25 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Handle memory allocation failure in readahead
Message-ID: <20200401164825.GC80283@magnolia>
References: <20200401030421.17195-1-willy@infradead.org>
 <20200401043125.GD56958@magnolia>
 <20200401112321.GF21484@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401112321.GF21484@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010144
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 01, 2020 at 04:23:21AM -0700, Matthew Wilcox wrote:
> On Tue, Mar 31, 2020 at 09:31:25PM -0700, Darrick J. Wong wrote:
> > On Tue, Mar 31, 2020 at 08:04:21PM -0700, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > bio_alloc() can fail when we use GFP_NORETRY.  If it does, allocate
> > > a bio large enough for a single page like mpage_readpages() does.
> > 
> > Why does mpage_readpages() do that?
> > 
> > Is this a means to guarantee some kind of forward (readahead?) progress?
> > Forgive my ignorance, but if memory is so tight we can't allocate a bio
> > for readahead then why not exit having accomplished nothing?
> 
> As far as I can tell, it's just a general fallback in mpage_readpages().
> 
>  * If anything unusual happens, such as:
>  *
>  * - encountering a page which has buffers
>  * - encountering a page which has a non-hole after a hole
>  * - encountering a page with non-contiguous blocks
>  *
>  * then this code just gives up and calls the buffer_head-based read function.
> 
> The actual code for that is:
> 
>                 args->bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
>                                         min_t(int, args->nr_pages,
>                                               BIO_MAX_PAGES),
>                                         gfp);
>                 if (args->bio == NULL)
>                         goto confused;
> ...
> confused:
>         if (args->bio)
>                 args->bio = mpage_bio_submit(REQ_OP_READ, op_flags, args->bio);
>         if (!PageUptodate(page))
>                 block_read_full_page(page, args->get_block);
>         else
>                 unlock_page(page);
> 
> As the comment implies, there are a lot of 'goto confused' cases in
> do_mpage_readpage().
> 
> Ideally, yes, we'd just give up on reading this page because it's
> only readahead, and we shouldn't stall actual work in order to reclaim
> memory so we can finish doing readahead.  However, handling a partial
> page read is painful.  Allocating a bio big enough for a single page is
> much easier on the mm than allocating a larger bio (for a start, it's a
> single allocation, not a pair of allocations), so this is a reasonable
> compromise between simplicity of code and quality of implementation.

Hmm, ok.  I'll add a comment about that:

		/*
		 * If the bio_alloc fails, try it again for a single page to
		 * avoid having to deal with partial page reads.  This emulates
		 * what do_mpage_readpage does.
		 */
		if (!ctx->bio)
			ctx->bio = bio_alloc(orig_gfp, 1);

...in the hopes that if anyone ever makes partial page reads less
painful, they'll hopefully find this breadcrumb and clean up iomap too.

If that's ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D
