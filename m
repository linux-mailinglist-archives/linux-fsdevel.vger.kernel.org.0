Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79A1F8F489
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 21:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbfHOT3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 15:29:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45764 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfHOT3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:29:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FJNdsN148804;
        Thu, 15 Aug 2019 19:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ZT5a+8dUwW0M4VLS2r56lOj+0JmBlziHNtV1s3yEJP0=;
 b=IK17GYF/plFP2TzPawGlzDk9h9rTV3nmfBkoYmfOKapDBv+RuPZ/3vMT4kzayRRqCFHb
 3c5hXWTzQ+bUcizALwiWwWhKLaxLYdfR+oM0u7ZF8TwIgnvotpkbfw5jUUsWU8l1rGZo
 ExccHw/l9TDXa3GMchdA+FZaKFAeCfOBVqcrIihk6bezKRr7yRbZ2d0ldHanvLarCwBK
 cUT+ltGR3cYN6VQ5W1w6gctc3FSkk56IzSkWApGGkNKf9oHlUgH2Km/o5s2TCEgCMWXf
 ZNbbNz9MP7RxwZp8VoPkBHnDoICfg5GE46q0ezjpU5fEcKezh4Lg0mrzM0hUL3lSYxbw PQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2u9nbtvqwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 19:28:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FJMoSm088307;
        Thu, 15 Aug 2019 19:28:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ucmwk2gcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 19:28:32 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7FJSTFd014811;
        Thu, 15 Aug 2019 19:28:29 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Aug 2019 12:28:29 -0700
Date:   Thu, 15 Aug 2019 12:28:27 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        Nick Bowler <nbowler@draconx.ca>,
        Eric Sandeen <sandeen@sandeen.net>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v5 01/18] xfs: compat_ioctl: use compat_ptr()
Message-ID: <20190815192827.GE15186@magnolia>
References: <20190814204259.120942-1-arnd@arndb.de>
 <20190814204259.120942-2-arnd@arndb.de>
 <20190814213753.GP6129@dread.disaster.area>
 <20190815071314.GA6960@infradead.org>
 <CAK8P3a2Hjfd49XY18cDr04ZpvC5ZBGudzxqpCesbSsDf1ydmSA@mail.gmail.com>
 <20190815080211.GA17055@infradead.org>
 <20190815102649.GA10821@infradead.org>
 <20190815121511.GR6129@dread.disaster.area>
 <20190815140355.GA11012@infradead.org>
 <CAK8P3a1iNu7m=gy-NauXVBky+cBk8TPWwfWXO4gSw1mRPJefJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1iNu7m=gy-NauXVBky+cBk8TPWwfWXO4gSw1mRPJefJA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=809
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150184
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=855 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150184
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 09:20:32PM +0200, Arnd Bergmann wrote:
> On Thu, Aug 15, 2019 at 4:04 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Aug 15, 2019 at 10:15:12PM +1000, Dave Chinner wrote:
> > > > http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/xfs-ioctl-table
> > >
> > > Lots to like in that handful of patches. :)
> > >
> > > It can easily go before or after Arnd's patch, and the merge
> > > conflict either way would be minor, so I'm not really fussed either
> > > way this gets sorted out...
> >
> > The other thing we could do is to just pick the two important ones:
> >
> > http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/xfs-ioctl-table-5.3
> >
> > and throw that into Arnds series, or even 5.3, and then defer the
> > table thing until later.
> 
> If we can have your "xfs: fall back to native ioctls for unhandled compat
> ones" in 5.3, that would be ideal from my side, then I can just drop the
> corresponding patch from my series and have the rest merged for 5.4.
> 
> The compat_ptr addition is independent of my series, I just added it
> because I noticed it was missing, so we can merged that through
> the xfs tree along with your other changes, either for 5.3 or 5.4.

Er... do the two patches in the -5.3 branch actually fix something
that's broken?  I sense s390 is missing a pointer sanitization check or
something...?

--D

>      Arnd
