Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F8D5A1CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 19:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfF1RGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 13:06:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58020 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfF1RGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:06:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SH3lx5047944;
        Fri, 28 Jun 2019 17:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=HEjdwZKqVQma8fh5oao0QSscD5FfLA0nLP9K+BfJpg4=;
 b=mIrIqkTs40/bwqFmaxBr5QdrxKMoRA+JMaCC+TLxArywIFYnd8inWeBXgRYr2qO1rQAT
 LWYk3/o2uqI/HfOxU2M2Ig15ds4LzN+T6dKAfY/W7RRW8lGQ6pOM94V4jj6thavSm1SJ
 JXaTAtH8C4Cotmn5b1j2PuOB1iouJbYEe7UkfUJJ99MNJWkZubamjzsndxxGqA59RM2s
 sbjpaV+KCZZr9Fw/eBt6QlV1RxjX0DN7pNgo3uBP732wI3AjNRC8Bf8i660zOy71xp5A
 4ip9FFxLpgBaZrs4a7p9Y11j4wX5fZFN/XR1SYEzDn3dtRjfENX3L/A/hinK1JMKmUOU Sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t9cyqxn1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 17:06:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SH4qrn143990;
        Fri, 28 Jun 2019 17:06:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t9p6w0wvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 17:06:03 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5SH5whd012396;
        Fri, 28 Jun 2019 17:05:59 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Jun 2019 10:05:58 -0700
Date:   Fri, 28 Jun 2019 10:05:57 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] xfs: allow merging ioends over append boundaries
Message-ID: <20190628170557.GB1404256@magnolia>
References: <20190627104836.25446-1-hch@lst.de>
 <20190627104836.25446-8-hch@lst.de>
 <20190627182309.GP5171@magnolia>
 <20190628055143.GB27187@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628055143.GB27187@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280195
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280195
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 28, 2019 at 07:51:43AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 27, 2019 at 11:23:09AM -0700, Darrick J. Wong wrote:
> > On Thu, Jun 27, 2019 at 12:48:30PM +0200, Christoph Hellwig wrote:
> > > There is no real problem merging ioends that go beyond i_size into an
> > > ioend that doesn't.  We just need to move the append transaction to the
> > > base ioend.  Also use the opportunity to use a real error code instead
> > > of the magic 1 to cancel the transactions, and write a comment
> > > explaining the scheme.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Reading through this patch, I have a feeling it fixes the crash that
> > Zorro has been seeing occasionally with generic/475...
> 
> So you think for some reason the disk i_size changes underneath and thus
> the xfs_ioend_is_append misfired vs the actual transaction allocations?
> I didn't even think of that, but using the different checks sure sounds
> dangerous.  So yes, we'd either need to backport my patch, or at least
> replace the checks in xfs_ioend_can_merge with direct checks of
> io_append_trans.

That's my working theory, yes.

1. Dirty pages 0 and 2 of an empty file.

2. Writeback gets scheduled for pages 0 and 2, creating ioends A and C.
Both ioends describe writes past the on-disk isize so we allocate
transactions.

3. ioend C completes immediately, sets the ondisk isize to (3 * PAGESIZE).

4. Dirty page 1 of the file and immediately schedule writeback for it,
creating ioend B.  ioend B describes a write within the on-disk isize so
we do not allocate setfilesize transaction.

5. ioend A and B complete and are sorted into the per-inode ioend
completion list.  xfs_ioend_try_merge looks at ioend A, sees that ioend
can be merged with ioend B (same type, same cow status, same current
setfilesize status (which does not reflect the setfilesize status when A
was created)) and therefore decides to merge them.

6. A has a setfilesize transaction so _try_merge calls
xfs_setfilesize_ioend(ioend B, -1) to cancel ioend B's transaction, but
as we saw in (4), ioend B has no transaction and crashes.

--D
