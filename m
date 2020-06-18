Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DBD1FE009
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 03:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732320AbgFRBou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 21:44:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59408 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731882AbgFRBos (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:44:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05I1hKkH045757;
        Thu, 18 Jun 2020 01:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=5X00ZJpGkm2D/zskn/YigNSmctslOOmCYVArBKtpGog=;
 b=ZQ79Lr/nEr0DFZiACUEMndR3onRqUE0mV9ccvdrF562efk6LtE+ATJwwLAgFzzSCBk9U
 De7pxVwAMYc6yW1gL62gsx3qruyjRZRA7PzxJwMBP9cBOabvFdl2gefCy39qK/SNcykI
 0xJZ1ZaDmwXbmujcpNrcnoY8sEw49s21tfLjSOnJvq1bA4lYU0NiYl2nHfxPPRKsoKXg
 nJi+nvse01mploRKeNCv/XNFeqniB3Zn8BCEmTLRH23A/a2uqXjFbPZ/nNeowVdsYG07
 tySWVAAq1KYffu2fAHb6kP/90iEctV2NVFgPDRlpg7OdmgMFG3oahU/o4PNTlbdlC97y FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31qeckw0wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Jun 2020 01:44:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05I1hhr3085176;
        Thu, 18 Jun 2020 01:44:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31q65yn412-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 01:44:35 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05I1iTNJ013625;
        Thu, 18 Jun 2020 01:44:29 GMT
Received: from localhost (/10.159.233.73)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jun 2020 18:44:29 -0700
Date:   Wed, 17 Jun 2020 18:44:29 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200618014429.GS11245@magnolia>
References: <20200616202123.12656-1-msys.mizuma@gmail.com>
 <20200617080314.GA7147@infradead.org>
 <20200617155836.GD13815@fieldses.org>
 <24692989-2ee0-3dcc-16d8-aa436114f5fb@sandeen.net>
 <20200617172456.GP11245@magnolia>
 <8f0df756-4f71-9d96-7a52-45bf51482556@sandeen.net>
 <20200617181816.GA18315@fieldses.org>
 <4cbb5cbe-feb4-2166-0634-29041a41a8dc@sandeen.net>
 <20200617184507.GB18315@fieldses.org>
 <20200618013026.ewnhvf64nb62k2yx@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618013026.ewnhvf64nb62k2yx@gabell>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180010
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 malwarescore=0
 clxscore=1015 adultscore=0 suspectscore=1 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180010
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 09:30:26PM -0400, Masayoshi Mizuma wrote:
> On Wed, Jun 17, 2020 at 02:45:07PM -0400, J. Bruce Fields wrote:
> > On Wed, Jun 17, 2020 at 01:28:11PM -0500, Eric Sandeen wrote:
> > > but mount(8) has already exposed this interface:
> > > 
> > >        iversion
> > >               Every time the inode is modified, the i_version field will be incremented.
> > > 
> > >        noiversion
> > >               Do not increment the i_version inode field.
> > > 
> > > so now what?
> > 
> > It's not like anyone's actually depending on i_version *not* being
> > incremented.  (Can you even observe it from userspace other than over
> > NFS?)
> > 
> > So, just silently turn on the "iversion" behavior and ignore noiversion,
> > and I doubt you're going to break any real application.
> 
> I suppose it's probably good to remain the options for user compatibility,
> however, it seems that iversion and noiversiont are useful for
> only ext4.
> How about moving iversion and noiversion description on mount(8)
> to ext4 specific option?
> 
> And fixing the remount issue for XFS (maybe btrfs has the same
> issue as well)?
> For XFS like as:
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 379cbff438bc..2ddd634cfb0b 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1748,6 +1748,9 @@ xfs_fc_reconfigure(
>                         return error;
>         }
> 
> +       if (XFS_SB_VERSION_NUM(&mp->m_sb) == XFS_SB_VERSION_5)
> +               mp->m_super->s_flags |= SB_I_VERSION;
> +

I wonder, does this have to be done at the top of this function because
the vfs already removed S_I_VERSION from s_flags?

--D

>         return 0;
>  }
> 
> Thanks,
> Masa
