Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51ADC1DC0A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 22:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgETUzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 16:55:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56626 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgETUzq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 16:55:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KKtPDF010579;
        Wed, 20 May 2020 20:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=g+ZM0FtRsu6uuGyXTtuswARYr2m8xjEaULC0CTSnixc=;
 b=CH3r+ZBc9wEToesDs3teA5VJNinDiofMQnf+k8EQPygFIP0mKwIJsTnIZajdlG9mcQZG
 FClrSX5G41NPf2Hf+5IwLyIt9gYAuN+St5R3RVyY3MvceUagf4382PRiFa29DWnFBF5J
 iNcAGuF558K6wVTTymBQ98p/cJ0S+SXe9vw8dgK2F+Bd/CEIzmn0It62l82sEaQU1F8u
 ZZu9xgMlH0gL16iMCSM3rNaUTPfmYfJ42BeYqgv+YxXOTni8TpfKxMakntpf+14xqpvn
 bGOcyF719QPS9fMh6lz58J4cB5YkEppS9DxROBLVeQrRWouTH1fPImff54O/gUd6oYTy GQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31284m5bxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 20:55:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KKsT4h115013;
        Wed, 20 May 2020 20:55:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 314gm7stq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 20:55:19 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04KKtD3w007090;
        Wed, 20 May 2020 20:55:13 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 13:55:12 -0700
Date:   Wed, 20 May 2020 13:55:09 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Xi <lixi@ddn.com>
Subject: Re: [PATCH V3 7/8] fs/ext4: Introduce DAX inode flag
Message-ID: <20200520205509.GA17615@magnolia>
References: <20200520055753.3733520-1-ira.weiny@intel.com>
 <20200520055753.3733520-8-ira.weiny@intel.com>
 <34ECB1DE-9F2F-4365-BBBC-DFACF703E7D4@dilger.ca>
 <20200520200242.GG3660833@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520200242.GG3660833@iweiny-DESK2.sc.intel.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=1
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200166
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005200166
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 20, 2020 at 01:02:42PM -0700, Ira Weiny wrote:
> On Wed, May 20, 2020 at 01:26:44PM -0600, Andreas Dilger wrote:
> > On May 19, 2020, at 11:57 PM, ira.weiny@intel.com wrote:
> > > 
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.
> > > 
> > > Set the flag to be user visible and changeable.  Set the flag to be
> > > inherited.  Allow applications to change the flag at any time with the
> > > exception of if VERITY or ENCRYPT is set.
> > > 
> > > Disallow setting VERITY or ENCRYPT if DAX is set.
> > > 
> > > Finally, on regular files, flag the inode to not be cached to facilitate
> > > changing S_DAX on the next creation of the inode.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > ---
> > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > index 6235440e4c39..467c30a789b6 100644
> > > --- a/fs/ext4/ext4.h
> > > +++ b/fs/ext4/ext4.h
> > > @@ -415,13 +415,16 @@ struct flex_groups {
> > > #define EXT4_VERITY_FL			0x00100000 /* Verity protected inode */
> > > #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
> > > /* 0x00400000 was formerly EXT4_EOFBLOCKS_FL */
> > > +
> > > +#define EXT4_DAX_FL			0x01000000 /* Inode is DAX */
> > > +
> > > #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
> > > #define EXT4_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
> > > #define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded file */
> > > #define EXT4_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
> > 
> > Hi Ira,
> > This flag value conflicts with the reserved flag in e2fsprogs for snapshots:
> > 
> > #define EXT4_SNAPFILE_FL                0x01000000  /* Inode is a snapshot */
> 
> Sure NP but is that new?  I'm building off of 5.7-rc4.
> 
> Just curious if I completely missed something.

Yeah, you missed that ... for some reason the kernel ext4 driver is
missing flags that are in e2fsprogs.  (huh??)

I would say you could probably just take over the flag because the 2010s
called and they don't want next3 back.  I guess that leaves 0x02000000
as the sole unclaimed bit, but this seriously needs some cleaning.

--D

> > 
> > Please change EXT4_DAX_FL and FS_DAX_FL to use 0x02000000, which is not used
> > for anything in either case.
> 
> NP, thanks!
> Ira
> 
> > 
> > Cheers, Andreas
> > 
> > 
> > > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > > index 379a612f8f1d..7c5f6eb51e2d 100644
> > > --- a/include/uapi/linux/fs.h
> > > +++ b/include/uapi/linux/fs.h
> > > @@ -262,6 +262,7 @@ struct fsxattr {
> > > #define FS_EA_INODE_FL			0x00200000 /* Inode used for large EA */
> > > #define FS_EOFBLOCKS_FL			0x00400000 /* Reserved for ext4 */
> > > #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
> > > +#define FS_DAX_FL			0x01000000 /* Inode is DAX */
> > > #define FS_INLINE_DATA_FL		0x10000000 /* Reserved for ext4 */
> > > #define FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
> > > #define FS_CASEFOLD_FL			0x40000000 /* Folder is case insensitive */
> > > --
> > > 2.25.1
> > > 
> > 
> > 
> > Cheers, Andreas
> > 
> > 
> > 
> > 
> > 
> 
> 
