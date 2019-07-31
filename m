Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A91C07CF46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 23:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfGaVDP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 17:03:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43070 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfGaVDP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 17:03:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VF8aRM052343;
        Wed, 31 Jul 2019 15:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=jPTHj5nlpLsKluMqdbevCd+OddfGtT5PcS8BjhKitxA=;
 b=Q7pb1MenHgobHEYolnpA41Hm695nIn5z23xKGClgnYsueqa+3czNiM10IfkXiMORkqGk
 xIpVtctk+nR7MBou0HV+tM5Ao876lq+KRR54zpeOZJiQrCt1DJU5ngh9syDTI58oz/bp
 Q+KEB7wm6oq94FiBJNONRPzRFL7oVMywoh61OJJgGQA3/y+slFLDpGgXPmYV2eEwjCjM
 sjOitpGMNdh26D7OmrPbzeBmZIR/NCzaZpZ2p3JErVaOT4q9rB/tE8T9eZ6hK61PLuXs
 9JymdwLmHuCB/WFwONSLZqEvTEBGnjX7VIig3SX5tsK6VCFhbOVlZupfLXSK/gEU1r9x Pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u0ejpnwrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 15:14:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VFD17Y008814;
        Wed, 31 Jul 2019 15:14:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2u2jp56vdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 15:14:57 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6VFErpV021960;
        Wed, 31 Jul 2019 15:14:53 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Jul 2019 08:14:53 -0700
Date:   Wed, 31 Jul 2019 08:14:52 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org
Subject: Re: [PATCH 05/20] utimes: Clamp the timestamps before update
Message-ID: <20190731151452.GA7077@magnolia>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
 <20190730014924.2193-6-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730014924.2193-6-deepa.kernel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907310156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907310156
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 29, 2019 at 06:49:09PM -0700, Deepa Dinamani wrote:
> POSIX is ambiguous on the behavior of timestamps for
> futimens, utimensat and utimes. Whether to return an
> error or silently clamp a timestamp beyond the range
> supported by the underlying filesystems is not clear.
> 
> POSIX.1 section for futimens, utimensat and utimes says:
> (http://pubs.opengroup.org/onlinepubs/9699919799/functions/futimens.html)
> 
> The file's relevant timestamp shall be set to the greatest
> value supported by the file system that is not greater
> than the specified time.
> 
> If the tv_nsec field of a timespec structure has the special
> value UTIME_NOW, the file's relevant timestamp shall be set
> to the greatest value supported by the file system that is
> not greater than the current time.
> 
> [EINVAL]
>     A new file timestamp would be a value whose tv_sec
>     component is not a value supported by the file system.
> 
> The patch chooses to clamp the timestamps according to the
> filesystem timestamp ranges and does not return an error.
> This is in line with the behavior of utime syscall also
> since the POSIX page(http://pubs.opengroup.org/onlinepubs/009695399/functions/utime.html)
> for utime does not mention returning an error or clamping like above.
> 
> Same for utimes http://pubs.opengroup.org/onlinepubs/009695399/functions/utimes.html
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
>  fs/utimes.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/utimes.c b/fs/utimes.c
> index 350c9c16ace1..4c1a2ce90bbc 100644
> --- a/fs/utimes.c
> +++ b/fs/utimes.c
> @@ -21,6 +21,7 @@ static int utimes_common(const struct path *path, struct timespec64 *times)
>  	int error;
>  	struct iattr newattrs;
>  	struct inode *inode = path->dentry->d_inode;
> +	struct super_block *sb = inode->i_sb;
>  	struct inode *delegated_inode = NULL;
>  
>  	error = mnt_want_write(path->mnt);
> @@ -36,16 +37,24 @@ static int utimes_common(const struct path *path, struct timespec64 *times)
>  		if (times[0].tv_nsec == UTIME_OMIT)
>  			newattrs.ia_valid &= ~ATTR_ATIME;
>  		else if (times[0].tv_nsec != UTIME_NOW) {
> -			newattrs.ia_atime.tv_sec = times[0].tv_sec;
> -			newattrs.ia_atime.tv_nsec = times[0].tv_nsec;
> +			newattrs.ia_atime.tv_sec =
> +				clamp(times[0].tv_sec, sb->s_time_min, sb->s_time_max);
> +			if (times[0].tv_sec == sb->s_time_max || times[0].tv_sec == sb->s_time_min)
> +				newattrs.ia_atime.tv_nsec = 0;
> +			else
> +				newattrs.ia_atime.tv_nsec = times[0].tv_nsec;
>  			newattrs.ia_valid |= ATTR_ATIME_SET;
>  		}
>  
>  		if (times[1].tv_nsec == UTIME_OMIT)
>  			newattrs.ia_valid &= ~ATTR_MTIME;
>  		else if (times[1].tv_nsec != UTIME_NOW) {
> -			newattrs.ia_mtime.tv_sec = times[1].tv_sec;
> -			newattrs.ia_mtime.tv_nsec = times[1].tv_nsec;
> +			newattrs.ia_mtime.tv_sec =
> +				clamp(times[1].tv_sec, sb->s_time_min, sb->s_time_max);
> +			if (times[1].tv_sec >= sb->s_time_max || times[1].tv_sec == sb->s_time_min)

Line length.

Also, didn't you just introduce a function to clamp tv_sec and fix
granularity?  Why not just use it here?  I think this is the third time
I've seen this open-coded logic.

--D

> +				newattrs.ia_mtime.tv_nsec = 0;
> +			else
> +				newattrs.ia_mtime.tv_nsec = times[1].tv_nsec;
>  			newattrs.ia_valid |= ATTR_MTIME_SET;
>  		}
>  		/*
> -- 
> 2.17.1
> 
