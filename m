Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0A4B3FD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 19:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388895AbfIPR6F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 13:58:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45316 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfIPR6F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 13:58:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GHre1o044366;
        Mon, 16 Sep 2019 17:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=VYcrldfczYSMZnzYbMMKsvm4OdJy/6xpzL8UCNC+S5A=;
 b=Ayms4hzRehlRi66lZ5m6P16vZN0RDituqSklxr01VECC7aPKXxWooKdVytwVr5q3DBUL
 AXpDq45A7mjzUczhODAmyARjb8dCHzHr67wZBq1eAyLcjhMFTupxrPuyPmbDYhVHiEkF
 F9YCBEUSpwzgDd7hS7MlhMeBT4oCT/M6bUz0zY9AnJaw8ho3VhAUSCiTRFgDrdO20J+s
 hf8Hj6GCwpp6QI3rpIpHsBSgIhtbugNEFvLh3NnxhRgi7fwXbto3qCL2zZwRg0kzyP4r
 nl5Mjg4a8wphfe6LpnhwUd9kurVKMHWKLOlK2yRAPUGQlYlaeeRZEkOT1vVtS/5CvY6g EA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v0ruqh4ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 17:57:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GHrqH9191938;
        Mon, 16 Sep 2019 17:57:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2v0r1gu3vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 17:57:57 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8GHvtsb013541;
        Mon, 16 Sep 2019 17:57:56 GMT
Received: from localhost (/10.159.225.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 10:57:55 -0700
Date:   Mon, 16 Sep 2019 10:57:54 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "hch@lst.de" <hch@lst.de>
Cc:     Goldwyn Rodrigues <RGoldwyn@suse.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 07/19] iomap: use a srcmap for a read-modify-write I/O
Message-ID: <20190916175754.GE2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-8-hch@lst.de>
 <1568119693.12944.16.camel@suse.com>
 <20190910143959.GB6794@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910143959.GB6794@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909160176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909160176
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 10, 2019 at 04:39:59PM +0200, hch@lst.de wrote:
> On Tue, Sep 10, 2019 at 12:48:14PM +0000, Goldwyn Rodrigues wrote:
> > > +	if (srcmap.type)
> > > +		end = min(end, srcmap.offset + srcmap.length);
> > > +	if (pos + length > end)
> > > +		length = end - pos;
> > >  
> > 
> > 
> > Yes, that looks more correct. However, can we be smart and not bother
> > setting the minimum of end and srcmap.offset + srcmap.length if it is
> > not required? ie in situations where end coincides with block boundary.
> >  Or if srcmap.length falls short, until the last block boundary of
> > iomap? 
> > 
> > I did think about this scenario. This case is specific to CoW and
> > thought this is best handled by filesystem's iomap_begin(). If this
> > goes in, the filesystems would have to "falsify" srcmap length
> > information to maximize the amount of I/O that goes in one iteration.
> 
> The problem is really that we can easily run over the srcmap (that's
> what happened to me with XFS..)  One thing you've done in btrfs that
> I haven't done yet in XFS is to simply not bother with filling out
> the srcmap if we don't need to (that is if the iteration is fully
> page aligned in your patch set - the unshare op in this series will
> complicate things a little).  With that optimization the only case
> where the shortening of the iteration that matters is if the start
> is unaligned and needs a read-modify-write cycle, but the end is
> aligned and beyond the end of the srcmap.  Is that such an important
> case?

<shrug> You might as well, since it's still going to be a few weeks
until I carve off a iomap work branch for 5.5... :)

(He says stumbling in from vacation with half a brain)

--D

> > 
> > -- 
> > Goldwyn---end quoted text---
