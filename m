Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCFB1F8118
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 07:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFMFcg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 01:32:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33104 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgFMFcg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 01:32:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05D5Qukh042565;
        Sat, 13 Jun 2020 05:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=plALFDZZcmaS0uCQ6YZRLDke2NoBOzFfSft5jKfN/2g=;
 b=K/4wtvDgn+INUFWBTV9JNULbQaVRJuY31EVWPB2O8AotR3c2Pn40qukXJWY2aSCVRSKt
 flb8zduguROE4A7Hgft5v9lTBUqC/EiFdmS27feiABOdnHjsV13SC4Bg0H8VhPDNEUAv
 jUSH3wCYxIsyHdAa9GqQUNxjJJiOhXYV2RNCXH2rfooh+gNeXyQXOaYxpdXFmOuD8Bfz
 QkUPdNhsEq2FGzCFd2ZOM8rDjjJTlfztWYWgOEqiVeWrDZWx3vc4MWnCDlcjw5iUWkcm
 FzrwkrBM68zCM3OHCLA0ZdlrFfz2KRA4ukGQYqVLUR2JrTEUJSdNMyyTO1A2U3NKw4Kp eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31mqemr3y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 Jun 2020 05:32:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05D5T9qB049268;
        Sat, 13 Jun 2020 05:32:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31mkwq8hak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Jun 2020 05:32:22 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05D5WHdg014240;
        Sat, 13 Jun 2020 05:32:17 GMT
Received: from localhost (/10.159.130.238)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 13 Jun 2020 05:32:17 +0000
Date:   Fri, 12 Jun 2020 22:32:15 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, ira.weiny@intel.com
Subject: Re: [GIT PULL] vfs: improve DAX behavior for 5.8, part 3
Message-ID: <20200613053215.GI11245@magnolia>
References: <20200611024248.GG11245@magnolia>
 <CAHk-=wgTMxCAHVgtKkbSJt=1pBm+86bz=RbZiZE-2sszwmcKvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgTMxCAHVgtKkbSJt=1pBm+86bz=RbZiZE-2sszwmcKvQ@mail.gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9650 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006130045
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9650 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=1
 priorityscore=1501 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 spamscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006130045
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 11, 2020 at 11:00:43AM -0700, Linus Torvalds wrote:
> On Wed, Jun 10, 2020 at 7:43 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > I did a test merge of this branch against upstream this evening and
> > there weren't any conflicts.  The first five patches in the series were
> > already in the xfs merge, so it's only the last one that should change
> > anything.  Please let us know if you have any complaints about pulling
> > this, since I can rework the branch.
> 
> I've taken this, but I hate how the patches apparently got duplicated.
> It feels like they should have been a cleanly separated branch that
> was just pulled into whoever needed them when they were ready, rather
> than applied in two different places.
> 
> So this is just a note for future work - duplicating the patches like
> this can cause annoyances down the line. No merge issues this time
> (they often happen when duplicate patches then have other work done on
> top of them), but things like "git bisect" now don't have quite as
> black-and-white a situation etc etc.,
> 
> ("git bisect" will still find _one_ of the duplicate commits if it
> introduced a problem, so it's usually not a huge deal, but it can
> cause the bug to be then repeated if people revert that one, but
> nobody ever notices that the other commit that did the same thing is
> still around and it gets back-ported to stable or whatever..)
> 
> So part of this is just in general about confusing duplicate history,
> and part of it is that the duplication can then cause later confusion.

Urgh, sorry.  I /was/ careful to make sure the patches matched, but I'll
be more careful the next time this (hopefully never) happens again. :/

--D


>                 Linus
