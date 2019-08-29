Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE5FA0FD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 05:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfH2DMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 23:12:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44068 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfH2DMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 23:12:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7T34MnA125004;
        Thu, 29 Aug 2019 03:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=IQaZ36+vxcvWv0TBA6kYGf1So8gSKZviXUcYpVtYvko=;
 b=BP92QdFNBVg5+FTlgWVw2UxFp6sUjaWDC28/mNHm6+DV76vouDd46UFTuRqXQWuxLH8o
 Zaptf+CvIhqvxsV3FG9ZlH3svaEbSzyueYZkVlxUUlK6AYSA1+77aFxjuv/CymVrg2az
 IuLaiIeTti1invRuB5GcLTAGOlS5ncxeVij6v+ptOMs9hEbw43dOJ4GE1D1wx8Cg79iq
 pZgh0QDSk+9jGpq/MsMOw7QX7PIL6VdJt1t0/5RjntOMvLnRaCEW0S223Pe1do08wlDn
 RStil+npcHEQycT5thql/Q95BNpvBHmaKGQVw8qhlQghLTH5Tnl7/EE3b8OrEBoA/aPW VA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2up69702k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 03:12:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7T34LtQ013256;
        Thu, 29 Aug 2019 03:12:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2unteu9kke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 03:12:23 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7T3CITo028285;
        Thu, 29 Aug 2019 03:12:18 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 20:12:18 -0700
Date:   Wed, 28 Aug 2019 20:12:16 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>, jencce.kernel@gmail.com,
        linux-xfs <linux-xfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>
Subject: Re: [PATCH v2 2/2] iomap: partially revert 4721a601099 (simulated
 directio short read on EFAULT)
Message-ID: <20190829031216.GW1037422@magnolia>
References: <20181202180832.GR8125@magnolia>
 <20181202181045.GS8125@magnolia>
 <CAHpGcM+WQYFHOOC8SzKq+=DuHVZ4fw4RHLTMUDN-o6GX3YtGvQ@mail.gmail.com>
 <20190828142332.GT1037422@magnolia>
 <CAHpGcMLGWVssWAC1PqBJevr1+1rE_hj4QN27D26j7-Fp_Kzpsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMLGWVssWAC1PqBJevr1+1rE_hj4QN27D26j7-Fp_Kzpsg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908290033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908290033
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 28, 2019 at 04:37:59PM +0200, Andreas Grünbacher wrote:
> Am Mi., 28. Aug. 2019 um 16:23 Uhr schrieb Darrick J. Wong
> <darrick.wong@oracle.com>:
> > On Wed, Aug 21, 2019 at 10:23:49PM +0200, Andreas Grünbacher wrote:
> > > Hi Darrick,
> > >
> > > Am So., 2. Dez. 2018 um 19:13 Uhr schrieb Darrick J. Wong
> > > <darrick.wong@oracle.com>:
> > > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > > >
> > > > In commit 4721a601099, we tried to fix a problem wherein directio reads
> > > > into a splice pipe will bounce EFAULT/EAGAIN all the way out to
> > > > userspace by simulating a zero-byte short read.  This happens because
> > > > some directio read implementations (xfs) will call
> > > > bio_iov_iter_get_pages to grab pipe buffer pages and issue asynchronous
> > > > reads, but as soon as we run out of pipe buffers that _get_pages call
> > > > returns EFAULT, which the splice code translates to EAGAIN and bounces
> > > > out to userspace.
> > > >
> > > > In that commit, the iomap code catches the EFAULT and simulates a
> > > > zero-byte read, but that causes assertion errors on regular splice reads
> > > > because xfs doesn't allow short directio reads.  This causes infinite
> > > > splice() loops and assertion failures on generic/095 on overlayfs
> > > > because xfs only permit total success or total failure of a directio
> > > > operation.  The underlying issue in the pipe splice code has now been
> > > > fixed by changing the pipe splice loop to avoid avoid reading more data
> > > > than there is space in the pipe.
> > > >
> > > > Therefore, it's no longer necessary to simulate the short directio, so
> > > > remove the hack from iomap.
> > > >
> > > > Fixes: 4721a601099 ("iomap: dio data corruption and spurious errors when pipes fill")
> > > > Reported-by: Amir Goldstein <amir73il@gmail.com>
> > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > > ---
> > > > v2: split into two patches per hch request
> > > > ---
> > > >  fs/iomap.c |    9 ---------
> > > >  1 file changed, 9 deletions(-)
> > > >
> > > > diff --git a/fs/iomap.c b/fs/iomap.c
> > > > index 3ffb776fbebe..d6bc98ae8d35 100644
> > > > --- a/fs/iomap.c
> > > > +++ b/fs/iomap.c
> > > > @@ -1877,15 +1877,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> > > >                                 dio->wait_for_completion = true;
> > > >                                 ret = 0;
> > > >                         }
> > > > -
> > > > -                       /*
> > > > -                        * Splicing to pipes can fail on a full pipe. We have to
> > > > -                        * swallow this to make it look like a short IO
> > > > -                        * otherwise the higher splice layers will completely
> > > > -                        * mishandle the error and stop moving data.
> > > > -                        */
> > > > -                       if (ret == -EFAULT)
> > > > -                               ret = 0;
> > > >                         break;
> > > >                 }
> > > >                 pos += ret;
> > >
> > > I'm afraid this breaks the following test case on xfs and gfs2, the
> > > two current users of iomap_dio_rw.
> >
> > Hmm, I had kinda wondered if regular pipes still needed this help.
> > Evidently we don't have a lot of splice tests in fstests. :(
> 
> So what do you suggest as a fix?

(See below)

> > > Here, the splice system call fails with errno = EAGAIN when trying to
> > > "move data" from a file opened with O_DIRECT into a pipe.
> > >
> > > The test case can be run with option -d to not use O_DIRECT, which
> > > makes the test succeed.
> > >
> > > The -r option switches from reading from the pipe sequentially to
> > > reading concurrently with the splice, which doesn't change the
> > > behavior.
> > >
> > > Any thoughts?
> >
> > This would be great as an xfstest! :)
> 
> Or perhaps something generalized from it.
> 
> > Do you have one ready to go, or should I just make one from the source
> > code?
> 
> The bug originally triggered in our internal cluster test system and
> I've recreated the test case I've included from the strace. That's all
> I have for now; feel free to take it, of course.
> 
> It could be that the same condition can be triggered with one of the
> existing utilities (fio/fsstress/...).

Hm, so I made an xfstest out of the program you sent me, and indeed
reverting that chunk makes the failure go away, but that got me
wondering -- that iomap kludge was a workaround for the splice code
telling iomap to try to stuff XXXX bytes into a pipe that only has X
bytes of free buffer space.  We fixed splice_direct_to_actor to clamp
the length parameter to the available pipe space, but we never did the
same to do_splice:

	/* Don't try to read more the pipe has space for. */
	read_len = min_t(size_t, len,
			 (pipe->buffers - pipe->nrbufs) << PAGE_SHIFT);
	ret = do_splice_to(in, &pos, pipe, read_len, flags);

Applying similar logic to the two (opipe != NULL) cases of do_splice()
seem to make the EAGAIN problem go away too.  So why don't we teach
do_splice to only ask for as many bytes as the pipe has space here too?

Does the following patch fix it for you?

--D

From: Darrick J. Wong <darrick.wong@oracle.com>
Subject: [PATCH] splice: only read in as much information as there is pipe buffer space

Andreas Gruenbacher reports that on the two filesystems that support
iomap directio, it's possible for splice() to return -EAGAIN (instead of
a short splice) if the pipe being written to has less space available in
its pipe buffers than the length supplied by the calling process.

Months ago we fixed splice_direct_to_actor to clamp the length of the
read request to the size of the splice pipe.  Do the same to do_splice.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/splice.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 98412721f056..50335515d7c1 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1101,6 +1101,7 @@ static long do_splice(struct file *in, loff_t __user *off_in,
 	struct pipe_inode_info *ipipe;
 	struct pipe_inode_info *opipe;
 	loff_t offset;
+	unsigned int pipe_pages;
 	long ret;
 
 	ipipe = get_pipe_info(in);
@@ -1123,6 +1124,10 @@ static long do_splice(struct file *in, loff_t __user *off_in,
 		if ((in->f_flags | out->f_flags) & O_NONBLOCK)
 			flags |= SPLICE_F_NONBLOCK;
 
+		/* Don't try to read more the pipe has space for. */
+		pipe_pages = opipe->buffers - opipe->nrbufs;
+		len = min_t(size_t, len, pipe_pages << PAGE_SHIFT);
+
 		return splice_pipe_to_pipe(ipipe, opipe, len, flags);
 	}
 
@@ -1180,8 +1185,13 @@ static long do_splice(struct file *in, loff_t __user *off_in,
 
 		pipe_lock(opipe);
 		ret = wait_for_space(opipe, flags);
-		if (!ret)
+		if (!ret) {
+			/* Don't try to read more the pipe has space for. */
+			pipe_pages = opipe->buffers - opipe->nrbufs;
+			len = min_t(size_t, len, pipe_pages << PAGE_SHIFT);
+
 			ret = do_splice_to(in, &offset, opipe, len, flags);
+		}
 		pipe_unlock(opipe);
 		if (ret > 0)
 			wakeup_pipe_readers(opipe);
