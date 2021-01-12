Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7512F3D1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438123AbhALVh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 16:37:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56190 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437141AbhALVRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:17:48 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CLDwxf169332;
        Tue, 12 Jan 2021 21:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=bR1zl62x1crSRLRZaw4N0mjRNUkzoJkEbrwHjcd/Sig=;
 b=W07FZK1ysQcddYInZReTNoPBDnq9Voc+vPtNoQ5utzKwJHik6NAhjj2ev9QZxboUiCZI
 9DyMdd/oh41Etv4D2DAjq7Q9X6iCr8h1xW9zA8a00RbJ4QDZZutxFq/2IV/2VWoF2WwI
 DiHYufs18UUo8BHpTfaRawegmtorKZYsS4B3wVc06XHVdAapCddXWYOVnUGgD1lxrzIP
 rJa+JwhcqgK8/MQPr3ridgoga604sbChyKrTXYm7Yv21Agexj1+zf3SXXI7Thlz99I4j
 2SBsj1N0eqb6zzn/TBJ9vBuptdQdQLT3EZ3c0HI7xqvi+Ura5p7EwzVTamLMvoAbZrW+ /g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 360kcyrhny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 21:16:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CL65Ce072883;
        Tue, 12 Jan 2021 21:14:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 360keye5qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 21:14:53 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CLElAE013096;
        Tue, 12 Jan 2021 21:14:47 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 13:14:47 -0800
Date:   Tue, 12 Jan 2021 13:14:45 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Avi Kivity <avi@scylladb.com>,
        Andres Freund <andres@anarazel.de>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: fallocate(FALLOC_FL_ZERO_RANGE_BUT_REALLY) to avoid unwritten
 extents?
Message-ID: <20210112211445.GC1164248@magnolia>
References: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
 <20210104181958.GE6908@magnolia>
 <20210104191058.sryksqjnjjnn5raa@alap3.anarazel.de>
 <f6f75f11-5d5b-ae63-d584-4b6f09ff401e@scylladb.com>
 <20210112181600.GA1228497@infradead.org>
 <C8811877-48A9-4199-9F28-20F5B071AE36@dilger.ca>
 <20210112184339.GA1238746@infradead.org>
 <1C33DEE4-8BE9-4BF3-A589-E11532382B36@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1C33DEE4-8BE9-4BF3-A589-E11532382B36@dilger.ca>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120127
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:51:07AM -0700, Andreas Dilger wrote:
> On Jan 12, 2021, at 11:43 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > On Tue, Jan 12, 2021 at 11:39:58AM -0700, Andreas Dilger wrote:
> >>> XFS already has a XFS_IOC_ALLOCSP64 that is defined to actually
> >>> allocate written extents.  It does not currently use
> >>> blkdev_issue_zeroout, but could be changed pretty trivially to do so.
> >>> 
> >>>> But note it will need to be plumbed down to md and dm to be generally
> >>>> useful.
> >>> 
> >>> DM and MD already support mddev_check_write_zeroes, at least for the
> >>> usual targets.
> >> 
> >> Similarly, ext4 also has EXT4_GET_BLOCKS_CREATE_ZERO that can allocate zero
> >> filled extents rather than unwritten extents (without clobbering existing
> >> data like FALLOC_FL_ZERO_RANGE does), and just needs a flag from fallocate()
> >> to trigger it.  This is plumbed down to blkdev_issue_zeroout() as well.
> > 
> > XFS_IOC_ALLOCSP64 actually is an ioctl that has been around since 1995
> > on IRIX (as an fcntl).
> 
> I'm not against adding XFS_IOC_ALLOCSP64 to ext4, if applications are actually
> using that.

<shudder> Some of them are, but--

ALLOCSP64 can only allocate pre-zeroed blocks as part of extending EOF,
whereas a new FZERO flag means that we can pre-zero an arbitrary range
of bytes in a file.  I don't know if Avi or Andres' usecases demand that
kind of flexibilty but I know I'd rather go for the more powerful
interface.

--D

> It also makes sense to me that there also be an fallocate() mode for allocating
> zeroed blocks (which was the original request), since fallocate() is already
> doing very similar things and is the central interface for managing block
> allocation instead of having a filesystem-specific ioctl() to do this.
> 
> Cheers, Andreas
> 
> 
> 
> 
> 


