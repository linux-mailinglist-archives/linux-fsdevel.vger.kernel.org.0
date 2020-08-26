Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8C02525CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 05:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgHZDcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 23:32:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40926 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgHZDcR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 23:32:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07Q3PJVC052820;
        Wed, 26 Aug 2020 03:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=okvAgslA9s05bet9RqzgtLjPhzBIyWiPkt2b3bP/bYE=;
 b=vSHPff2Yifsj0zi3bmrYfVGUepFiWCce0CYR5xvlgbAumROeM1EOejvnHiuIsCiCWJRQ
 8HgTlK5Z7iQNg3QDFgDDnGjOIxtOaZUpXE7Wwi0yakmhiBp466lVn8kcnnk/S3VhD/rF
 KhTCBvobMwE7DShABebEgbXrPj12M95ewXYzRGjWaWlCOgvFDO6bMYS149krW3h0/qto
 FJCuRzblMk9DvaSnn3Fx//0EUH4ngQdkwLPrQKJ1KGX/dKYydn1OkazzCdn6JbVLtLr/
 HA3GtnnBXroAuVjzqL1t47SyF8aqchwJNB8gkXf3FrnKOXRH06OgtrHaEU/rU8yx6/yx Iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 333w6tvhmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 03:32:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07Q3VLwM011072;
        Wed, 26 Aug 2020 03:32:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 333r9kbj1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 03:32:10 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07Q3W9af008012;
        Wed, 26 Aug 2020 03:32:09 GMT
Received: from localhost (/10.159.139.182)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Aug 2020 20:32:09 -0700
Date:   Tue, 25 Aug 2020 20:32:08 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] iomap: Support arbitrarily many blocks per page
Message-ID: <20200826033208.GS6107@magnolia>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-6-willy@infradead.org>
 <20200825210203.GJ6096@magnolia>
 <20200826022623.GQ17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826022623.GQ17456@casper.infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=1 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=1 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008260024
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 26, 2020 at 03:26:23AM +0100, Matthew Wilcox wrote:
> On Tue, Aug 25, 2020 at 02:02:03PM -0700, Darrick J. Wong wrote:
> > >  /*
> > > - * Structure allocated for each page when block size < PAGE_SIZE to track
> > > + * Structure allocated for each page when block size < page size to track
> > >   * sub-page uptodate status and I/O completions.
> > 
> > "for each regular page or head page of a huge page"?  Or whatever we're
> > calling them nowadays?
> 
> Well, that's what I'm calling a "page" ;-)
> 
> How about "for each page or THP"?  The fact that it's stored in the
> head page is incidental -- it's allocated for the THP.

Ok.

--D
