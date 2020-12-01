Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC812CA9C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 18:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391941AbgLARdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 12:33:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59282 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387716AbgLARdC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:33:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1HStdS174056;
        Tue, 1 Dec 2020 17:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=OrLZ2TcxMTzpayNZHbMFnpbSSUbuHHfyBH7rVwjavA8=;
 b=J+y8I92pWhV92YXtBuMCCHALqBR6koiFyuB/M/ui+E9bAweH0vn1phIlbT/Ffyv4REge
 +Gh0Hy/L1Jla9Jn3DxGQImGACLVOCA2aA7ZPpbD4xYfBOViC7XFzT+osNc0lm801FNim
 yq+I0QWENLrApN+SgCbFgzpBkkcT3lNRA6KrKKeuDwG3oOTYBpw/i5uoJyCtopvJ3kHP
 3QV5a2pk1G06oAenVELhPimGqHSm5iXdFNyy/ntT7/5AKWNkHH2H/gKo+SsbMafw3FVf
 C46uLWlopqN1smpxui9Kv+1PXPwYUrbmDfOBv+RKVvwNPUoAl7IPUY+JEZWUqARxzm4U 3A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 353egkktqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Dec 2020 17:32:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1HQOVq175124;
        Tue, 1 Dec 2020 17:32:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 35404n5n2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Dec 2020 17:32:16 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B1HWF4n007040;
        Tue, 1 Dec 2020 17:32:15 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Dec 2020 09:32:14 -0800
Date:   Tue, 1 Dec 2020 09:32:13 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH 1/2] uapi: fix statx attribute value overlap for DAX &
 MOUNT_ROOT
Message-ID: <20201201173213.GH143045@magnolia>
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <7027520f-7c79-087e-1d00-743bdefa1a1e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7027520f-7c79-087e-1d00-743bdefa1a1e@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010107
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:57:11AM -0600, Eric Sandeen wrote:
> STATX_ATTR_MOUNT_ROOT and STATX_ATTR_DAX got merged with the same value,
> so one of them needs fixing. Move STATX_ATTR_DAX.
> 
> While we're in here, clarify the value-matching scheme for some of the
> attributes, and explain why the value for DAX does not match.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
>  include/uapi/linux/stat.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 82cc58fe9368..9ad19eb9bbbf 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -171,9 +171,10 @@ struct statx {
>   * be of use to ordinary userspace programs such as GUIs or ls rather than
>   * specialised tools.
>   *
> - * Note that the flags marked [I] correspond to generic FS_IOC_FLAGS
> + * Note that the flags marked [I] correspond to the FS_IOC_SETFLAGS flags
>   * semantically.  Where possible, the numerical value is picked to correspond
> - * also.
> + * also. Note that the DAX attribute indicates that the inode is currently
> + * DAX-enabled, not simply that the per-inode flag has been set.

I don't really like using "DAX-enabled" to define "DAX attribute".  How
about cribbing from the statx manpage?

"Note that the DAX attribute indicates that the file is in the CPU
direct access state.  It does not correspond to the per-inode flag that
some filesystems support."

>   */
>  #define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File is compressed by the fs */
>  #define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File is marked immutable */
> @@ -183,7 +184,7 @@ struct statx {
>  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
>  #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
>  #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
> -#define STATX_ATTR_DAX			0x00002000 /* [I] File is DAX */
> +#define STATX_ATTR_DAX			0x00400000 /* File is currently DAX-enabled */

Why not use the next bit in the series (0x200000)?  Did someone already
claim it in for-next?

--D

>  
>  
>  #endif /* _UAPI_LINUX_STAT_H */
> -- 
> 2.17.0
> 
