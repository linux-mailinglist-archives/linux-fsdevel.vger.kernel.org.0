Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99503152301
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 00:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgBDXY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 18:24:28 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58816 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgBDXY2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 18:24:28 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014NOHer053148;
        Tue, 4 Feb 2020 23:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=qt4ezHX8pCFsu0aJka+2xOJeOvz1X7xZLjw4ti/Tm1Q=;
 b=Ma9gSfR5OLtnHJ/IRPATq3AaBrQ/+MzHOCoyZZE7WiIAd54tNdDU9l55X1b4G7cpbmx0
 nv6teP6sWa4v/k71IfUiAYgKGhOfPkKICRW+MKmP7xhZ6NJF+BT3lMyFp1Lj3IbDAUcB
 9Ff1JIonJ70xh18RSAYzkqwH+8WKEU8taE1cllQWZ86eoLbWsjnfTROtYjittfTMoGGI
 GfgZgrih3INbnN589yuDse6d6lsgddNUoKyQEVVsmp52Xt5uMBeXjxknLXW3jM/lI8XK
 t80dCDLiDiU9H+GKaEhElHDuoIBZX/tx1PthQobo8nzcC0FoJWOOVOnBOVRkQNff+hy2 PA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xyhkfg4r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 23:24:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014NOEA5187113;
        Tue, 4 Feb 2020 23:24:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xyhmet495-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 23:24:16 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 014NNKv0004192;
        Tue, 4 Feb 2020 23:23:20 GMT
Received: from localhost (/10.159.250.52)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Feb 2020 15:23:19 -0800
Date:   Tue, 4 Feb 2020 15:23:18 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [RFC] dax,pmem: Provide a dax operation to zero range of memory
Message-ID: <20200204232318.GF6874@magnolia>
References: <20200123165249.GA7664@redhat.com>
 <20200123190103.GB8236@magnolia>
 <CAPcyv4jT3py4gtdJo84i8gPnJo5MO4uGaaO=+fuuAjXQ0gQsHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jT3py4gtdJo84i8gPnJo5MO4uGaaO=+fuuAjXQ0gQsHA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-2001150001 definitions=main-2002040159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-2001150001
 definitions=main-2002040159
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 03:31:58PM -0800, Dan Williams wrote:
> On Thu, Jan 23, 2020 at 11:07 AM Darrick J. Wong
> <darrick.wong@oracle.com> wrote:
> >
> > On Thu, Jan 23, 2020 at 11:52:49AM -0500, Vivek Goyal wrote:
> > > Hi,
> > >
> > > This is an RFC patch to provide a dax operation to zero a range of memory.
> > > It will also clear poison in the process. This is primarily compile tested
> > > patch. I don't have real hardware to test the poison logic. I am posting
> > > this to figure out if this is the right direction or not.
> > >
> > > Motivation from this patch comes from Christoph's feedback that he will
> > > rather prefer a dax way to zero a range instead of relying on having to
> > > call blkdev_issue_zeroout() in __dax_zero_page_range().
> > >
> > > https://lkml.org/lkml/2019/8/26/361
> > >
> > > My motivation for this change is virtiofs DAX support. There we use DAX
> > > but we don't have a block device. So any dax code which has the assumption
> > > that there is always a block device associated is a problem. So this
> > > is more of a cleanup of one of the places where dax has this dependency
> > > on block device and if we add a dax operation for zeroing a range, it
> > > can help with not having to call blkdev_issue_zeroout() in dax path.
> > >
> > > I have yet to take care of stacked block drivers (dm/md).
> > >
> > > Current poison clearing logic is primarily written with assumption that
> > > I/O is sector aligned. With this new method, this assumption is broken
> > > and one can pass any range of memory to zero. I have fixed few places
> > > in existing logic to be able to handle an arbitrary start/end. I am
> > > not sure are there other dependencies which might need fixing or
> > > prohibit us from providing this method.
> > >
> > > Any feedback or comment is welcome.
> >
> > So who gest to use this? :)
> >
> > Should we (XFS) make fallocate(ZERO_RANGE) detect when it's operating on
> > a written extent in a DAX file and call this instead of what it does now
> > (punch range and reallocate unwritten)?
> 
> If it eliminates more block assumptions, then yes. In general I think
> there are opportunities to use "native" direct_access instead of
> block-i/o for other areas too, like metadata i/o.
> 
> > Is this the kind of thing XFS should just do on its own when DAX us that
> > some range of pmem has gone bad and now we need to (a) race with the
> > userland programs to write /something/ to the range to prevent a machine
> > check (b) whack all the programs that think they have a mapping to
> > their data, (c) see if we have a DRAM copy and just write that back, (d)
> > set wb_err so fsyncs fail, and/or (e) regenerate metadata as necessary?
> 
> (a), (b) duplicate what memory error handling already does. So yes,
> could be done but it only helps if machine check handling is broken or
> missing.

<nod> 

> (c) what DRAM copy in the DAX case?

Sorry, I was talking about the fs metadata that we cache in DRAM.

> (d) dax fsync is just cache flush, so it can't fail, or are you
> talking about errors in metadata?

I'm talking about an S_DAX file that someone is doing regular write()s
to:

1. Open file O_RDWR
2. Write something to the file
3. Some time later, something decides the pmem is bad.
4. Program calls fsync(); does it return EIO?

(I shouldn't have mixed the metadata/file data cases, sorry...)

> (e) I thought our solution for dax metadata redundancy is to use a
> realtime data device and raid mirror for the metadata device.

In the end it was set aside on the grounds that reserving space for
a separate metadata device was too costly and too complex for now.
We might get back to it later when the <cough> economics improve.

> > <cough> Will XFS ever get that "your storage went bad" hook that was
> > promised ages ago?
> 
> pmem developers don't scale?

Ah, sorry. :/

> > Though I guess it only does this a single page at a time, which won't be
> > awesome if we're trying to zero (say) 100GB of pmem.  I was expecting to
> > see one big memset() call to zero the entire range followed by
> > pmem_clear_poison() on the entire range, but I guess you did tag this
> > RFC. :)
> 
> Until movdir64b is available the only way to clear poison is by making
> a call to the BIOS. The BIOS may not be efficient at bulk clearing.

Well then let's port XFS to SMM mode. <duck>

(No, please don't...)

--D
