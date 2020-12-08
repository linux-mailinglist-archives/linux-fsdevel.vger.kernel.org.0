Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2D52D3675
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 23:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgLHWs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 17:48:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33790 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730776AbgLHWs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 17:48:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8Mdugb079151;
        Tue, 8 Dec 2020 22:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=qPLPYejHiYKI/SS/VMuVb/4MJA5j0lvth0OjAoews7k=;
 b=DmLL7ePIWe9zrLaIVSG1mBDrU3FSj8xHx6v+DAaAInug+mcMLNgt9b+Nbuscwu89/PMd
 jQNzab7wOqAPrxMP2z7ZG3Sy2D80ZpKFXTWRC2ZE9k43rk8wOPbOLWOG/hxsgX1BKovK
 ARMEP0Gw/uPu9LzVQ/UkNYCXkdc3RTKPi7snCQo9AGIHnhYSs/Ywm8vWqHZCcmvnXCHf
 H3kX71F54nr+/iEpCElOqIYvm50PlriM5PEfD+u2ykgQU1xWU4S068sfli0N7wNVFvJk
 YpSAtLe5lQEVVUcMks+V5X7ciFOhPpGHNEv4QuahImF/x2eVm/pS8057D/oT2c+do+xh YA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3581mqwbt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 22:47:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8Mfi5J164266;
        Tue, 8 Dec 2020 22:45:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 358m4yjd1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 22:45:59 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B8MjuMt013079;
        Tue, 8 Dec 2020 22:45:57 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 14:45:56 -0800
Date:   Tue, 8 Dec 2020 14:45:55 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] mm/highmem: Lift memcpy_[to|from]_page to core
Message-ID: <20201208224555.GA605321@magnolia>
References: <20201207225703.2033611-1-ira.weiny@intel.com>
 <20201207225703.2033611-3-ira.weiny@intel.com>
 <20201207232649.GD7338@casper.infradead.org>
 <CAPcyv4hkY-9V5Rq5s=BRku2AeWYtgs9DuVXnhdEkara2NiN9Tg@mail.gmail.com>
 <20201207234008.GE7338@casper.infradead.org>
 <CAPcyv4g+NvdFO-Coe36mGqmp5v3ZtRCGziEoxsxLKmj5vPx7kA@mail.gmail.com>
 <20201208213255.GO1563847@iweiny-DESK2.sc.intel.com>
 <20201208215028.GK7338@casper.infradead.org>
 <CAPcyv4irF7YoEjOZ1iOrPPJDsw_-j4kiaqz_6Gf=cz1y3RpdoQ@mail.gmail.com>
 <20201208223234.GL7338@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208223234.GL7338@casper.infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=1
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080142
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 10:32:34PM +0000, Matthew Wilcox wrote:
> On Tue, Dec 08, 2020 at 02:23:10PM -0800, Dan Williams wrote:
> > On Tue, Dec 8, 2020 at 1:51 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Dec 08, 2020 at 01:32:55PM -0800, Ira Weiny wrote:
> > > > On Mon, Dec 07, 2020 at 03:49:55PM -0800, Dan Williams wrote:
> > > > > On Mon, Dec 7, 2020 at 3:40 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > >
> > > > > > On Mon, Dec 07, 2020 at 03:34:44PM -0800, Dan Williams wrote:
> > > > > > > On Mon, Dec 7, 2020 at 3:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Dec 07, 2020 at 02:57:03PM -0800, ira.weiny@intel.com wrote:
> > > > > > > > > +static inline void memcpy_page(struct page *dst_page, size_t dst_off,
> > > > > > > > > +                            struct page *src_page, size_t src_off,
> > > > > > > > > +                            size_t len)
> > > > > > > > > +{
> > > > > > > > > +     char *dst = kmap_local_page(dst_page);
> > > > > > > > > +     char *src = kmap_local_page(src_page);
> > > > > > > >
> > > > > > > > I appreciate you've only moved these, but please add:
> > > > > > > >
> > > > > > > >         BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
> > > > > > >
> > > > > > > I imagine it's not outside the realm of possibility that some driver
> > > > > > > on CONFIG_HIGHMEM=n is violating this assumption and getting away with
> > > > > > > it because kmap_atomic() of contiguous pages "just works (TM)".
> > > > > > > Shouldn't this WARN rather than BUG so that the user can report the
> > > > > > > buggy driver and not have a dead system?
> > > > > >
> > > > > > As opposed to (on a HIGHMEM=y system) silently corrupting data that
> > > > > > is on the next page of memory?
> > > > >
> > > > > Wouldn't it fault in HIGHMEM=y case? I guess not necessarily...
> > > > >
> > > > > > I suppose ideally ...
> > > > > >
> > > > > >         if (WARN_ON(dst_off + len > PAGE_SIZE))
> > > > > >                 len = PAGE_SIZE - dst_off;
> > > > > >         if (WARN_ON(src_off + len > PAGE_SIZE))
> > > > > >                 len = PAGE_SIZE - src_off;
> > > > > >
> > > > > > and then we just truncate the data of the offending caller instead of
> > > > > > corrupting innocent data that happens to be adjacent.  Although that's
> > > > > > not ideal either ... I dunno, what's the least bad poison to drink here?
> > > > >
> > > > > Right, if the driver was relying on "corruption" for correct operation.
> > > > >
> > > > > If corruption actual were happening in practice wouldn't there have
> > > > > been screams by now? Again, not necessarily...
> > > > >
> > > > > At least with just plain WARN the kernel will start screaming on the
> > > > > user's behalf, and if it worked before it will keep working.
> > > >
> > > > So I decided to just sleep on this because I was recently told to not introduce
> > > > new WARN_ON's[1]
> > > >
> > > > I don't think that truncating len is worth the effort.  The conversions being
> > > > done should all 'work'  At least corrupting users data in the same way as it
> > > > used to...  ;-)  I'm ok with adding the WARN_ON's and I have modified the patch
> > > > to do so while I work through the 0-day issues.  (not sure what is going on
> > > > there.)
> > > >
> > > > However, are we ok with adding the WARN_ON's given what Greg KH told me?  This
> > > > is a bit more critical than the PKS API in that it could result in corrupt
> > > > data.
> > >
> > > zero_user_segments contains:
> > >
> > >         BUG_ON(end1 > page_size(page) || end2 > page_size(page));
> > >
> > > These should be consistent.  I think we've demonstrated that there is
> > > no good option here.
> > 
> > True, but these helpers are being deployed to many new locations where
> > they were not used before.
> 
> So what's your preferred poison?
> 
> 1. Corrupt random data in whatever's been mapped into the next page (which
>    is what the helpers currently do)

Please no.

> 2. Copy less data than requested

This sounds like the germination event for a research paper showing that
63% of callers never notice. ;)

> 3. Crash

Useful as a debug tool?

> 4. Something else

Return bytes copied like we do for writes that didn't quite work?

--D
