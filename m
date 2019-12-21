Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD5A128AB8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2019 19:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfLUSFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Dec 2019 13:05:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36316 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfLUSFq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Dec 2019 13:05:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBLHxZVS053757;
        Sat, 21 Dec 2019 18:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=bSsms4JZc7GSfb/7ZqlmxUOjxKulnt8yMY4oSOeBWms=;
 b=Pa4Kbdhv5i5rwSyMOYPq225nL+ikXs3EOtDxKOKKyPAnfk5PS1wLaMEdx8BvzxMbfd6A
 +PQR/IpOAqpjocdsmDKFeFZhEfc/20RQ18Jq0nyjYO+kbNZ2YNIB4a2hpWQwXiNfOjAL
 tMKeRyU2rzwvn4SQCjrjBggVkmlPajY+32lcHCJ7LlYZ4dTxwQN2/agOjd4cvxvf5XTu
 0Vl8sVHasSCLpgqsvmTQJqgXCQbahYzz4gZGLBEDRH7Jr/6bbSCrl4caNXUnjztoNf+u
 K/Y0FgFTHBnOszzs3lQhOPA7YoJmy8r9dyePRmIsMHjJLweAOb4BHvn0sG8trrGEXvGW hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2x1bbphgb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Dec 2019 18:05:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBLI3en2122288;
        Sat, 21 Dec 2019 18:05:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2x1ar3hc3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Dec 2019 18:05:36 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBLI5XPX024764;
        Sat, 21 Dec 2019 18:05:33 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 21 Dec 2019 10:05:32 -0800
Date:   Sat, 21 Dec 2019 10:05:30 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Chris Down <chris@chrisdown.name>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
Message-ID: <20191221180530.GJ7497@magnolia>
References: <20191220024936.GA380394@chrisdown.name>
 <20191220213052.GB7476@magnolia>
 <CAOQ4uxgoDHLnVb9=R2LpNqEFtjx=f5K8QXQnfiziBQ+jURLh=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgoDHLnVb9=R2LpNqEFtjx=f5K8QXQnfiziBQ+jURLh=A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9478 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912210158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9478 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912210158
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 21, 2019 at 10:43:05AM +0200, Amir Goldstein wrote:
> On Fri, Dec 20, 2019 at 11:33 PM Darrick J. Wong
> <darrick.wong@oracle.com> wrote:
> >
> > On Fri, Dec 20, 2019 at 02:49:36AM +0000, Chris Down wrote:
> > > In Facebook production we are seeing heavy inode number wraparounds on
> > > tmpfs. On affected tiers, in excess of 10% of hosts show multiple files
> > > with different content and the same inode number, with some servers even
> > > having as many as 150 duplicated inode numbers with differing file
> > > content.
> > >
> > > This causes actual, tangible problems in production. For example, we
> > > have complaints from those working on remote caches that their
> > > application is reporting cache corruptions because it uses (device,
> > > inodenum) to establish the identity of a particular cache object, but
> >
> > ...but you cannot delete the (dev, inum) tuple from the cache index when
> > you remove a cache object??
> >
> > > because it's not unique any more, the application refuses to continue
> > > and reports cache corruption. Even worse, sometimes applications may not
> > > even detect the corruption but may continue anyway, causing phantom and
> > > hard to debug behaviour.
> > >
> > > In general, userspace applications expect that (device, inodenum) should
> > > be enough to be uniquely point to one inode, which seems fair enough.
> >
> > Except that it's not.  (dev, inum, generation) uniquely points to an
> > instance of an inode from creation to the last unlink.
> >
> 
> Yes, but also:
> There should not exist two live inodes on the system with the same (dev, inum)
> The problem is that ino 1 may still be alive when wraparound happens
> and then two different inodes with ino 1 exist on same dev.

*OH* that's different then.  Most sane filesystems <cough>btrfs<cough>
should never have the same inode numbers for different files.  Sorry for
the noise, I misunderstood what the issue was. :)

> Take the 'diff' utility for example, it will report that those files
> are identical
> if they have the same dev,ino,size,mtime. I suspect that 'mv' will not
> let you move one over the other, assuming they are hardlinks.
> generation is not even exposed to legacy application using stat(2).

Yeah, I was surprised to see it's not even in statx. :/

--D

> Thanks,
> Amir.
