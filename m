Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3214C94983
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 18:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfHSQKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 12:10:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50584 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfHSQKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:10:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7JFs3J0043290;
        Mon, 19 Aug 2019 16:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=wZAw030seHNsiobo5U0y5hdAg32jPbFeE4iuKMm+0QA=;
 b=LKdfuDcj/W4wMETP7J1Y0rdWcZ5osdEFr0SvyPcUshlsUTVJQMSgLyh4PDuMebe8b/hb
 Rz/Sye9S+zl/CO5MB8uhwvDxea4YMTQIr9wOjLRQR7wy2zxlHleInHSMKUIpLgQKFd/5
 q/Rk99foX298mLY4Ey5leO34nL24flZEpHiiOuldre5KwYPCkkPAWEFKzaJCfpFE3qHu
 nQJcy8AYVhC2MNQvAfLafpFSWxeYVYkG2L/zK7ed/axNl7lqlnuPU8yPTSVPmSIwA7na
 SNyD1qnXIY91LOf6sp3zHjpxO65iAQwzOOfVEVGmf2h7RcF/zuoKZWDtm5miZhbFBh6Q Qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2uea7qgehj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 16:09:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7JFs5GQ147353;
        Mon, 19 Aug 2019 16:09:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2uejxeaxqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 16:09:38 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7JG9PHY013098;
        Mon, 19 Aug 2019 16:09:25 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Aug 2019 09:09:25 -0700
Date:   Mon, 19 Aug 2019 09:09:23 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>, Chao Yu <yuchao0@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
        devel <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Pavel Machek <pavel@denx.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190819160923.GG15198@magnolia>
References: <20190818090949.GA30276@kroah.com>
 <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
 <20190818151154.GA32157@mit.edu>
 <20190818155812.GB13230@infradead.org>
 <20190818161638.GE1118@sol.localdomain>
 <20190818162201.GA16269@infradead.org>
 <20190818172938.GA14413@sol.localdomain>
 <20190818174702.GA17633@infradead.org>
 <20190818181654.GA1617@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190818201405.GA27398@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818201405.GA27398@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9354 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908190172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9354 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908190172
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:14:11AM +0800, Gao Xiang wrote:
> Hi all,
> 
> On Mon, Aug 19, 2019 at 02:16:55AM +0800, Gao Xiang wrote:
> > Hi Hch,
> > 
> > On Sun, Aug 18, 2019 at 10:47:02AM -0700, Christoph Hellwig wrote:
> > > On Sun, Aug 18, 2019 at 10:29:38AM -0700, Eric Biggers wrote:
> > > > Not sure what you're even disagreeing with, as I *do* expect new filesystems to
> > > > be held to a high standard, and to be written with the assumption that the
> > > > on-disk data may be corrupted or malicious.  We just can't expect the bar to be
> > > > so high (e.g. no bugs) that it's never been attained by *any* filesystem even
> > > > after years/decades of active development.  If the developers were careful, the
> > > > code generally looks robust, and they are willing to address such bugs as they
> > > > are found, realistically that's as good as we can expect to get...
> > >
> > > Well, the impression I got from Richards quick look and the reply to it is
> > > that there is very little attempt to validate the ondisk data structure
> > > and there is absolutely no priority to do so.  Which is very different
> > > from there is a bug or two here and there.
> > 
> > As my second reply to Richard, I didn't fuzz all the on-disk fields for EROFS.
> > and as my reply to Richard / Greg, current EROFS is used on the top of dm-verity.
> > 
> > I cannot say how well EROFS will be performed on malformed images (and you can
> > also find the bug richard pointed out is a miswritten break->continue by myself).
> > 
> > I posted the upstream EROFS post on July 4, 2019 and a month and a half later,
> > no one can tell me (yes, thanks for kind people reply me about their suggestion)
> > what we should do next (you can see these emails, I sent many times) to meet
> > the minimal upstream requirements and rare people can even dip into my code.
> > 
> > That is all I want to say. I will work on autofuzz these days, and I want to
> > know how to meet your requirements on this (you can tell us your standard,
> > how well should we do).
> > 
> > OK, you don't reply to my post once, I have no idea how to get your first reply.
> 
> I have made a simple fuzzer to inject messy in inode metadata,
> dir data, compressed indexes and super block,
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=experimental-fuzzer
> 
> I am testing with some given dirs and the following script.
> Does it look reasonable?
> 
> # !/bin/bash
> 
> mkdir -p mntdir
> 
> for ((i=0; i<1000; ++i)); do
> 	mkfs/mkfs.erofs -F$i testdir_fsl.fuzz.img testdir_fsl > /dev/null 2>&1

mkfs fuzzes the image? Er....

Over in XFS land we have an xfs debugging tool (xfs_db) that knows how
to dump (and write!) most every field of every metadata type.  This
makes it fairly easy to write systematic level 0 fuzzing tests that
check how well the filesystem reacts to garbage data (zeroing,
randomizing, oneing, adding and subtracting small integers) in a field.
(It also knows how to trash entire blocks.)

You might want to write such a debugging tool for erofs so that you can
take apart crashed images to get a better idea of what went wrong, and
to write easy fuzzing tests.

--D

> 	umount mntdir
> 	mount -t erofs -o loop testdir_fsl.fuzz.img mntdir
> 	for j in `find mntdir -type f`; do
> 		md5sum $j > /dev/null
> 	done
> done
> 
> Thanks,
> Gao Xiang
> 
> > 
> > Thanks,
> > Gao Xiang
> > 
