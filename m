Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AD425236D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 00:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgHYWO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 18:14:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43344 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgHYWO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:14:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PM9nN5171494;
        Tue, 25 Aug 2020 22:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=n+SDM3E28nCnOj/ZIdYxllNKqwlO0WVL977/aXzCToM=;
 b=lYVNsW7bRgguHLyVdZRvbHXMwu8efoU7zXQ4RCyySuj1uHi21FUYr8brkWIgSRe2dwqe
 o6Vfz6U006JdqRAiS/8CySQBaXR+rM3xiNwOVnIZk7KZOkHEy9j+NUjb7W8Ua7nMK8k6
 X/mkGh8cK7lVJ9GoMCemSwGdwzolgXDMN8Tk43iyJpL1kIvgEhvhU8Wt2y4D9UvKytN+
 kGifzHOwQ+TifMMygaqqkgReDs6cA1gJj5A0nwivtp4AsPllQAC/HTCe2O3UL/5rKliz
 wFORPcFoC3kFuvwY4dTqf6CjE1CyJGDOsg0geDjvc6Qh4iDFrXB12eJ0qJ7IzKd7nnnr Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 333dbrw6y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 22:14:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PMAbwF110146;
        Tue, 25 Aug 2020 22:14:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 333rtyccw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 22:14:21 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07PMEHkx010818;
        Tue, 25 Aug 2020 22:14:17 GMT
Received: from localhost (/10.159.234.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Aug 2020 15:14:17 -0700
Date:   Tue, 25 Aug 2020 15:14:16 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] iomap: Convert read_count to byte count
Message-ID: <20200825221416.GK6096@magnolia>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-7-willy@infradead.org>
 <20200825000902.GG12131@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825000902.GG12131@dread.disaster.area>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250166
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250166
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:09:02AM +1000, Dave Chinner wrote:
> On Mon, Aug 24, 2020 at 03:55:07PM +0100, Matthew Wilcox (Oracle) wrote:
> > Instead of counting bio segments, count the number of bytes submitted.
> > This insulates us from the block layer's definition of what a 'same page'
> > is, which is not necessarily clear once THPs are involved.
> 
> I'd like to see a comment on the definition of struct iomap_page to
> indicate that read_count (and write count) reflect the byte count of
> IO currently in flight on the page, not an IO count, because THP
> makes tracking this via bio state hard. Otherwise it is not at all
> obvious why it is done and why it is intentional...

Agreed. :)

--D

> Otherwise the code looks OK.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
