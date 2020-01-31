Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC9F14E865
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 06:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgAaF1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 00:27:18 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58002 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgAaF1S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 00:27:18 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V5NoAd016127;
        Fri, 31 Jan 2020 05:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=25xGYxRP3HUTkpA8AmoeUZ7DieRvXxJfhCUinwzJAWk=;
 b=TSHstV4oidRJpXmY6fpK1S4bQMBHmiMkO3nYVyI8GufyiMH2TER4s+sHRKBDC/J4nnuH
 AVyUoHcSo2QPF4L5Eqwi99Fq3XyiYkR6ferNxjtjX/3ujL7vcrXFPljWmTCeGWFbocHF
 SNZghg2IHOFzwNAqEkbYHshqgNIadeVTYXIl1irv9zYJEjB4nRLSYK0WooIWvjN4N9wm
 exvlkR4/bn1tCKI7cxB7AouSlJne3BOVaxf0e+sHVaSzUoKqRmwHKcq07wReYNIcxf9t
 UZGeWb76TkNNf2OdrcISra7KLiXWbmUwOxnOfnDekQJvF83ywVUNckMTeZolzsrWZCpC oQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xrd3ur64y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 05:27:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V5OR5E136702;
        Fri, 31 Jan 2020 05:25:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xuheukdjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 05:25:02 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00V5OuhE027910;
        Fri, 31 Jan 2020 05:24:56 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jan 2020 21:24:56 -0800
Date:   Thu, 30 Jan 2020 21:24:54 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200131052454.GA6868@magnolia>
References: <20200118004738.GQ8904@ZenIV.linux.org.uk>
 <20200118011734.GD295250@vader>
 <20200118022032.GR8904@ZenIV.linux.org.uk>
 <20200121230521.GA394361@vader>
 <CAOQ4uxgsoGMsNxhmtzZPqb+NshpJ3_P8vDiKpJFO5ZK25jZr0w@mail.gmail.com>
 <20200122221003.GB394361@vader>
 <20200123034745.GI23230@ZenIV.linux.org.uk>
 <20200123071639.GA7216@dread.disaster.area>
 <CAOQ4uxhm3tqgqQPYpkeb635zRLR1CJFDUrwGuCZv1ntv+FszdA@mail.gmail.com>
 <20200124212546.GC7216@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124212546.GC7216@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001310047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001310047
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 25, 2020 at 08:25:46AM +1100, Dave Chinner wrote:
> On Thu, Jan 23, 2020 at 09:47:30AM +0200, Amir Goldstein wrote:
> > On Thu, Jan 23, 2020 at 9:16 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Thu, Jan 23, 2020 at 03:47:45AM +0000, Al Viro wrote:
> > > > On Wed, Jan 22, 2020 at 02:10:03PM -0800, Omar Sandoval wrote:
> > > >
> > > > > > Sorry for not reading all the thread again, some API questions:
> > > > > > - We intend to allow AT_REPLACE only with O_TMPFILE src. Right?
> > > > >
> > > > > I wasn't planning on having that restriction. It's not too much effort
> > > > > for filesystems to support it for normal files, so I wouldn't want to
> > > > > place an artificial restriction on a useful primitive.
> > > >
> > 
> > I have too many gray hairs each one for implementing a "useful primitive"
> > that nobody asked for and bare the consequences.
> > Your introduction to AT_REPLACE uses O_TMPFILE.
> > I see no other sane use of the interface.
> > 
> > > > I'm not sure; that's how we ended up with the unspeakable APIs like
> > > > rename(2), after all...
> > >
> > > Yet it is just rename(2) with the serial numbers filed off -
> > > complete with all the same data vs metadata ordering problems that
> > > rename(2) comes along with. i.e. it needs fsync to guarantee data
> > > integrity of the source file before the linkat() call is made.
> > >
> > > If we can forsee that users are going to complain that
> > > linkat(AT_REPLACE) using O_TMPFILE files is not atomic because it
> > > leaves zero length files behind after a crash just like rename()
> > > does, then we haven't really improved anything at all...
> > >
> > > And, really, I don't think anyone wants another API that requires
> > > multiple fsync calls to use correctly for crash-safe file
> > > replacement, let alone try to teach people who still cant rename a
> > > file safely how to use it....
> > >
> > 
> > Are you suggesting that AT_LINK_REPLACE should have some of
> > the semantics I posted in this RFC  for AT_ATOMIC_xxx:
> > https://lore.kernel.org/linux-fsdevel/20190527172655.9287-1-amir73il@gmail.com/
> 
> Not directly.
> 
> All I'm pointing out is that data integrity guarantees of
> AT_LINK_REPLACE are yet another aspect of this new feature that
> has not yet been specified or documented at all.
> 
> And in pointing this out, I'm making an observation that the
> rename(2) behaviour which everyone seems to be assuming this
> function will replicate is a terrible model to copy/reinvent.
> 
> Addressing this problem is something for the people pushing for
> AT_LINK_REPLACE to solve, not me....

Or the grumpy maintainer who will have to digest all of this.

Can we update the documentation to admit that many people will probably
want to use this (and rename) as atomic swap operations?

"The filesystem will commit the data and metadata of all files and
directories involved in the link operation to stable storage before the
call returns."

And finally add a flag:

"AT_LINK_EATMYDATA: If specified, the filesystem may opt out of
committing anything to disk."

(Or a prctl(PR_EATMYDATA) to make it process wide, idk.)

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
