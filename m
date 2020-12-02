Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351A72CB3DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 05:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgLBEVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 23:21:43 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44762 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbgLBEVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 23:21:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B24Ixi9098441;
        Wed, 2 Dec 2020 04:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=IoUSY1Rx9GPU+8n33gzJjRRryGMyGmmSb9uVbdF0/h0=;
 b=LTdz4/2y11iBoFXIscjVNSPNWI2eoj5PBRJP+3t/+zz6KQ/8bCbNtiSBIxRFGqs0IhtV
 wv657qRaudQBbjRyqE6zg4WZ5bZbHKYW9kVVj8Sqinvlv9oJ67xdXgtskNleOR3LiJPm
 2n0tvhBgG5nC3XSdzSx00JFxW5hiVnwnoIVF4jf47TveTZ1Mnv5bSE50iKx8uqR4GtOX
 irvJsASt9F8zKGmfJoVRTTWl8DTiJM4CmiOqQtpnm4+KCk/5tf5NDB80Tf6wS9Dg/IHC
 gXEozTkGNDyucFnou6G7fdtTpbxcuwrBXVGSu68tHmDbS6O/otBArMnvr4mFC5YgSVYI +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 353egkp0xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Dec 2020 04:20:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B24AP4Y072940;
        Wed, 2 Dec 2020 04:18:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 35404nrh7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Dec 2020 04:18:55 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B24IrjE018314;
        Wed, 2 Dec 2020 04:18:53 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Dec 2020 04:18:53 +0000
Date:   Tue, 1 Dec 2020 20:18:52 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH V2] uapi: fix statx attribute value overlap for DAX &
 MOUNT_ROOT
Message-ID: <20201202041852.GA106272@magnolia>
References: <3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012020025
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 05:21:40PM -0600, Eric Sandeen wrote:
> [*] Note: This needs to be merged as soon as possible as it's introducing an incompatible UAPI change...
> 
> STATX_ATTR_MOUNT_ROOT and STATX_ATTR_DAX got merged with the same value,
> so one of them needs fixing. Move STATX_ATTR_DAX.
> 
> While we're in here, clarify the value-matching scheme for some of the
> attributes, and explain why the value for DAX does not match.
> 
> Fixes: 80340fe3605c ("statx: add mount_root")
> Fixes: 712b2698e4c0 ("fs/stat: Define DAX statx attribute")
> Reported-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> Reviewed-by: David Howells <dhowells@redhat.com>

Looks fine to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> V2: Change flag value per Darrick Wong
>     Tweak comment per Darrick Wong
>     Add Fixes: tags & reported-by & RVB per dhowells
> 
>  include/uapi/linux/stat.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 82cc58fe9368..1500a0f58041 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -171,9 +171,12 @@ struct statx {
>   * be of use to ordinary userspace programs such as GUIs or ls rather than
>   * specialised tools.
>   *
> - * Note that the flags marked [I] correspond to generic FS_IOC_FLAGS
> + * Note that the flags marked [I] correspond to the FS_IOC_SETFLAGS flags
>   * semantically.  Where possible, the numerical value is picked to correspond
> - * also.
> + * also.  Note that the DAX attribute indicates that the file is in the CPU
> + * direct access state.  It does not correspond to the per-inode flag that
> + * some filesystems support.
> + *
>   */
>  #define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File is compressed by the fs */
>  #define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File is marked immutable */
> @@ -183,7 +186,7 @@ struct statx {
>  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
>  #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
>  #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
> -#define STATX_ATTR_DAX			0x00002000 /* [I] File is DAX */
> +#define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
>  
>  
>  #endif /* _UAPI_LINUX_STAT_H */
> -- 
> 2.17.0
> 
