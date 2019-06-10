Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 269F13B909
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 18:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391468AbfFJQJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 12:09:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36720 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389392AbfFJQJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:09:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AG8dYb186787;
        Mon, 10 Jun 2019 16:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=q/XqjsUkDq6xevue9zs57YIabmhhkQKl2VGDHiV5jq4=;
 b=z113WwHcxX3n/yhODGaHV37Y8Y2xpZmcyhxxxXzJA/k/rxOYXjF2MjD/1uhcbfhftRYf
 5pqMjh5K3CtHPhzszPk3sJvtarblaJBFXn+SMzznHbGaB/24N8rQCO6FIzIJiYWF5Jmy
 0Ctn3AGwZpPxskUF74cndxv7urz5f3+PcDqCnsdci1pwvBGZZ6ksWHEShe2xXI4W3GG/
 zsFwGRTeohmYJJragnO65tWk+/TgIVgAHp17i7Qzmiy9ZuC84qzcwRNBXZbhGeO1dq1K
 Yw1OMGx7ZEqHS/69RztKNiTCeLKDWlHFChndJrLK17c0MsRVkQQFuAzKKwCH+BVYyVom Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t04etfvt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 16:09:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AG9TMe154450;
        Mon, 10 Jun 2019 16:09:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t024twpwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 16:09:37 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5AG9aDJ022183;
        Mon, 10 Jun 2019 16:09:36 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Jun 2019 09:09:36 -0700
Date:   Mon, 10 Jun 2019 09:09:34 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/8] mm/fs: don't allow writes to immutable files
Message-ID: <20190610160934.GH1871505@magnolia>
References: <155552786671.20411.6442426840435740050.stgit@magnolia>
 <155552787330.20411.11893581890744963309.stgit@magnolia>
 <20190610015145.GB3266@mit.edu>
 <20190610044144.GA1872750@magnolia>
 <20190610131417.GD15963@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610131417.GD15963@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906100110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906100110
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 09:14:17AM -0400, Theodore Ts'o wrote:
> On Sun, Jun 09, 2019 at 09:41:44PM -0700, Darrick J. Wong wrote:
> > On Sun, Jun 09, 2019 at 09:51:45PM -0400, Theodore Ts'o wrote:
> > > On Wed, Apr 17, 2019 at 12:04:33PM -0700, Darrick J. Wong wrote:
> >
> > > Shouldn't this check be moved before the modification of vmf->flags?
> > > It looks like do_page_mkwrite() isn't supposed to be returning with
> > > vmf->flags modified, lest "the caller gets surprised".
> > 
> > Yeah, I think that was a merge error during a rebase... :(
> > 
> > Er ... if you're still planning to take this patch through your tree,
> > can you move it to above the "vmf->flags = FAULT_FLAG_WRITE..." ?
> 
> I was planning on only taking 8/8 through the ext4 tree.  I also added
> a patch which filtered writes, truncates, and page_mkwrites (but not
> mmap) for immutable files at the ext4 level.

*Oh*.  I saw your reply attached to the 1/8 patch and thought that was
the one you were taking.  I was sort of surprised, tbh. :)

> I *could* take this patch through the mm/fs tree, but I wasn't sure
> what your plans were for the rest of the patch series, and it seemed
> like it hadn't gotten much review/attention from other fs or mm folks
> (well, I guess Brian Foster weighed in).

> What do you think?

Not sure.  The comments attached to the LWN story were sort of nasty,
and now that a couple of people said "Oh, well, Debian documented the
inconsistent behavior so just let it be" I haven't felt like
resurrecting the series for 5.3.

I do want to clean up the parameter validation for the VFS SETFLAGS and
FSSETXATTR ioctls though... eh, maybe I'll just send out the series as
it stands now.  I'm still maintaining it, so all that work might as well
go somewhere.

--D

> 
> 						- Ted
> 
> 
> 
