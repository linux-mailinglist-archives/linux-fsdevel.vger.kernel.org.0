Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9C82F3380
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 16:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfKGPhp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 10:37:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38018 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKGPhp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:37:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7FYpns089366;
        Thu, 7 Nov 2019 15:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=eD0TyM1J09eTx+P52DELNdh3g9/rOsokVCFlGTbPGfA=;
 b=hj0+0wkL4yOhk2NHr1wqOtxYlHMgiuKIP+rn7Z/QrsUhpuR3wJ2qNLmJzLXHe/oQovv4
 7tvxOliEi6LNMyNNGfVU65AQPHhFgPSJlvJRladQLRcu1qhHkxBLvOwcLkAz5bBbRjok
 3jruYc7vHe2imCpp3k1DQISyWC9FR0orLNSqIsKmMeQNOnZRD5kSIK2yk/ECQgBu/2FQ
 XIC2BdXfYQU3USMwnIDk2ON5qpNaxyHpWLhcc+zF/W3Z+5ceVDnTzmIpRuXT1YzUg8al
 7Owx2GrYlo0hbUB6XCa8rqyMGuANdvoAjww3fYOfL6WE5CPIFfD6v/QBu3u6h6biHXmM HQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w41w0y118-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 15:37:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7FYidX040753;
        Thu, 7 Nov 2019 15:37:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2w41wf6str-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 15:37:34 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA7FbYko012926;
        Thu, 7 Nov 2019 15:37:34 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Nov 2019 07:37:34 -0800
Date:   Thu, 7 Nov 2019 07:37:32 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] iomap: Fix overflow in iomap_page_mkwrite
Message-ID: <20191107153732.GA6211@magnolia>
References: <20191106190400.20969-1-agruenba@redhat.com>
 <20191106191656.GC15212@magnolia>
 <CAHc6FU4BXZ7fiLa_tVhZWZmqoXNCJWQwUvb7UPzGrWt_ZBBvxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU4BXZ7fiLa_tVhZWZmqoXNCJWQwUvb7UPzGrWt_ZBBvxQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070148
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 06, 2019 at 08:34:26PM +0100, Andreas Gruenbacher wrote:
> On Wed, Nov 6, 2019 at 8:17 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > On Wed, Nov 06, 2019 at 08:04:00PM +0100, Andreas Gruenbacher wrote:
> > > On architectures where ssize_t is wider than pgoff_t, the expression
> >
> > ssize_t?  But you're changing @offset, which is loff_t.   I'm confused.
> 
> Oops, should have been loff_t instead of ssize_t.

I'll fix it on commit.

> > Also, which architectures are you talking about here?
> 
> From the kernel headers:
> 
> #define pgoff_t unsigned long
> typedef long long __kernel_loff_t;
> typedef __kernel_loff_t loff_t;
> 
> So for example, sizeof(loff_t) > sizeof(pgoff_t) on x86.

Ok, that's what I thought.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> Thanks,
> Andreas
> 
