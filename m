Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D42C49D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 22:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbgKYVZb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 16:25:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35242 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730091AbgKYVZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 16:25:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0APLMOwB134988;
        Wed, 25 Nov 2020 21:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=N5SWeimeKvHLwMlAaFrBpTdoRlriFhKwuNWBy0QY/rI=;
 b=nagq060cGNJIUnA1OOPE8xfZdEsDxtwlcW2R0RV2KOSuzKMSC1dh24mZT8zMd0gBJGEe
 zTqTd7zDI1jADqALgdIvT5e8QfmA/9vPh0HQR27McDYWacnDTs5Rc6zerLz5W9DFfHJG
 cvdrU6WpNZexjJRuhewgc18qTGNHTKTbB1DQu/Oc93tZuRVXnBAhNN7Kc/sKKDrfSzU8
 1vS0TypTPHcKqJh/BWaZJiIvqwma0hMjlx9cmRGwzEgX5ny3ISTp4hA5RC3EnHOyG7Ln
 uY9KIo5gR4+8ytWiOr+tyiK8ym4cdAlITcsUcHP4Kjji7PTSBoYw3z9BfGFdls1Cl/KJ UA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 351kwhkfxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Nov 2020 21:25:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0APLB2eX028360;
        Wed, 25 Nov 2020 21:25:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 351kwex1tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Nov 2020 21:25:26 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0APLPOL4019461;
        Wed, 25 Nov 2020 21:25:24 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Nov 2020 13:25:24 -0800
Date:   Wed, 25 Nov 2020 13:25:23 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: Clarification of statx->attributes_mask meaning?
Message-ID: <20201125212523.GB14534@magnolia>
References: <33d38621-b65c-b825-b053-eda8870281d1@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33d38621-b65c-b825-b053-eda8870281d1@sandeen.net>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9816 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 suspectscore=1 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=1
 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250131
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 01:19:48PM -0600, Eric Sandeen wrote:
> The way attributes_mask is used in various filesystems seems a bit
> inconsistent.
> 
> Most filesystems set only the bits for features that are possible to enable
> on that filesystem, i.e. XFS:
> 
>         if (ip->i_d.di_flags & XFS_DIFLAG_IMMUTABLE)
>                 stat->attributes |= STATX_ATTR_IMMUTABLE;
>         if (ip->i_d.di_flags & XFS_DIFLAG_APPEND)
>                 stat->attributes |= STATX_ATTR_APPEND;
>         if (ip->i_d.di_flags & XFS_DIFLAG_NODUMP)
>                 stat->attributes |= STATX_ATTR_NODUMP;
> 
>         stat->attributes_mask |= (STATX_ATTR_IMMUTABLE |
>                                   STATX_ATTR_APPEND |
>                                   STATX_ATTR_NODUMP);
> 
> btrfs, cifs, erofs, ext4, f2fs, hfsplus, orangefs and ubifs are similar.
> 
> But others seem to set the mask to everything it can definitively answer,
> i.e. "Encryption and compression are off, and we really mean it" even though
> it will never be set to one in ->attributes, i.e. on gfs2:
> 
>         if (gfsflags & GFS2_DIF_APPENDONLY)
>                 stat->attributes |= STATX_ATTR_APPEND;
>         if (gfsflags & GFS2_DIF_IMMUTABLE)
>                 stat->attributes |= STATX_ATTR_IMMUTABLE;
> 
>         stat->attributes_mask |= (STATX_ATTR_APPEND |
>                                   STATX_ATTR_COMPRESSED |
>                                   STATX_ATTR_ENCRYPTED |
>                                   STATX_ATTR_IMMUTABLE |
>                                   STATX_ATTR_NODUMP);
> 
> ext2 is similar (it adds STATX_ATTR_ENCRYPTED to the mask but will never set
> it in attributes)
> 
> The commit 3209f68b3ca4 which added attributes_mask says:
> 
> "Include a mask in struct stat to indicate which bits of stx_attributes the
> filesystem actually supports."
> 
> The manpage says:
> 
> "A mask indicating which bits in stx_attributes are supported by the VFS and
> the filesystem."
> 
> -and-
> 
> "Note that any attribute that is not indicated as supported by stx_attributes_mask
> has no usable value here."
> 
> So is this intended to indicate which bits of statx->attributes are valid, whether
> they are 1 or 0, or which bits could possibly be set to 1 by the filesystem?
> 
> If the former, then we should move attributes_mask into the VFS to set all flags
> known by the kernel, but David's original commit did not do that so I'm left
> wondering...

Personally I thought that attributes_mask tells you which bits actually
make any sense for the given filesystem, which means:

mask=1 bit=0: "attribute not set on this file"
mask=1 bit=1: "attribute is set on this file"
mask=0 bit=0: "attribute doesn't fit into the design of this fs"
mask=0 bit=1: "filesystem is lying snake"

It's up to the fs driver and not the vfs to set attributes_mask, and
therefore (as I keep pointing out to XiaoLi Feng) xfs_vn_getattr should
be setting the mask.

--D

> 
> Thanks,
> -Eric
