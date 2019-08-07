Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D18C84EF8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 16:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfHGOmb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 10:42:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36126 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfHGOmb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:42:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x77EcRXY128789;
        Wed, 7 Aug 2019 14:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Ew2vSnJLVpgu6DdAm65LHh1hBST2dMBdNyXhpwmMp8c=;
 b=anizsztAaeQeJN8jTbM9oZQDeM4/SvVB/xB0WJw5kACWGzaHSo4dyC0tvsO8sGheAvKv
 oJe6kHN5ZrOG4ajrYntp7UwtZp2XFBkfcseGCTXfh7tImDISEqq7kfRxX5fygwX8YtGR
 M4pfodDTi1Kmv6seXfuqOxkwe1Z1BPfzgiBYEieyGQ2DR/Qt+GRrM/cP8pvQ7SlJWaSt
 bdnNHuGxN5IAtpFvciz71tX7HdK9A4iaGb0Emg/b+rV/M1JN1DLLEngNjO2l06r2FX51
 PxobAzEu3F10TmF5pC/5MhpezfJEkHv65dDFiwC8K9s8gDbAwv2Svh2T43N4Q53zQzN3 8Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u52wrcs76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 14:42:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x77Ec3Hk102276;
        Wed, 7 Aug 2019 14:42:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2u75bwgg06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 14:42:18 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x77EgG4x031547;
        Wed, 7 Aug 2019 14:42:17 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 07:42:16 -0700
Date:   Wed, 7 Aug 2019 07:42:16 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/9] fibmap: Use bmap instead of ->bmap method in
 ioctl_fibmap
Message-ID: <20190807144215.GB7157@magnolia>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-5-cmaiolino@redhat.com>
 <20190731231217.GV1561054@magnolia>
 <20190802091937.kwutqtwt64q5hzkz@pegasus.maiolino.io>
 <20190802151400.GG7138@magnolia>
 <20190805102729.ooda6sg65j65ojd4@pegasus.maiolino.io>
 <20190805151258.GD7129@magnolia>
 <20190806224138.GW30113@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806224138.GW30113@42.do-not-panic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908070157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908070157
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 10:41:38PM +0000, Luis Chamberlain wrote:
> On Mon, Aug 05, 2019 at 08:12:58AM -0700, Darrick J. Wong wrote:
> > On Mon, Aug 05, 2019 at 12:27:30PM +0200, Carlos Maiolino wrote:
> > > On Fri, Aug 02, 2019 at 08:14:00AM -0700, Darrick J. Wong wrote:
> > > > On Fri, Aug 02, 2019 at 11:19:39AM +0200, Carlos Maiolino wrote:
> > > > > Hi Darrick.
> > > > > 
> > > > > > > +		return error;
> > > > > > > +
> > > > > > > +	block = ur_block;
> > > > > > > +	error = bmap(inode, &block);
> > > > > > > +
> > > > > > > +	if (error)
> > > > > > > +		ur_block = 0;
> > > > > > > +	else
> > > > > > > +		ur_block = block;
> > > > > > 
> > > > > > What happens if ur_block > INT_MAX?  Shouldn't we return zero (i.e.
> > > > > > error) instead of truncating the value?  Maybe the code does this
> > > > > > somewhere else?  Here seemed like the obvious place for an overflow
> > > > > > check as we go from sector_t to int.
> > > > > > 
> > > > > 
> > > > > The behavior should still be the same. It will get truncated, unfortunately. I
> > > > > don't think we can actually change this behavior and return zero instead of
> > > > > truncating it.
> > > > 
> > > > But that's even worse, because the programs that rely on FIBMAP will now
> > > > receive *incorrect* results that may point at a different file and
> > > > definitely do not point at the correct file block.
> > > 
> > > How is this worse? This is exactly what happens today, on the original FIBMAP
> > > implementation.
> > 
> > Ok, I wasn't being 110% careful with my words.  Delete "will now" from
> > the sentence above.
> > 
> > > Maybe I am not seeing something or having a different thinking you have, but
> > > this is the behavior we have now, without my patches. And we can't really change
> > > it; the user view of this implementation.
> > > That's why I didn't try to change the result, so the truncation still happens.
> > 
> > I understand that we're not generally supposed to change existing
> > userspace interfaces, but the fact remains that allowing truncated
> > responses causes *filesystem corruption*.
> > 
> > We know that the most well known FIBMAP callers are bootloaders, and we
> > know what they do with the information they get -- they use it to record
> > the block map of boot files.  So if the IPL/grub/whatever installer
> > queries the boot file and the boot file is at block 12345678901 (a
> > 34-bit number), this interface truncates that to 3755744309 (a 32-bit
> > number) and that's where the bootloader will think its boot files are.
> > The installation succeeds, the user reboots and *kaboom* the system no
> > longer boots because the contents of block 3755744309 is not a bootloader.
> > 
> > Worse yet, grub1 used FIBMAP data to record the location of the grub
> > environment file and installed itself between the MBR and the start of
> > partition 1.  If the environment file is at offset 1234578901, grub will
> > write status data to its environment file (which it thinks is at
> > 3755744309) and *KABOOM* we've just destroyed whatever was in that
> > block.
> > 
> > Far better for the bootloader installation script to hit an error and
> > force the admin to deal with the situation than for the system to become
> > unbootable.  That's *why* the (newer) iomap bmap implementation does not
> > return truncated mappings, even though the classic implementation does.
> > 
> > The classic code returning truncated results is a broken behavior.
> 
> How long as it been broken for?

Probably since the beginning (ext2).

> And if we do fix it, I'd just like for
> a nice commit lot describing potential risks of not applying it. *If*
> the issue exists as-is today, the above contains a lot of information
> for addressing potential issues, even if theoretical.

I think a lot of the filesystems avoid the problem either by not
supporting > INT_MAX blocks in the first place or by detecting the
truncation in the fs-specific ->bmap method, so that might be why we
haven't been deluged by corruption reports.

--D

>   Luis
