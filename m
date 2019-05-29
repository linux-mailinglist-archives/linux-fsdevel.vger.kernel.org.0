Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F1F2E485
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 20:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfE2Sc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 14:32:29 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50020 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2Sc2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 14:32:28 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TIO2UG061523;
        Wed, 29 May 2019 18:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=bWB/yFgqPDFoiXEHekhyTt0zqFRq5hIDOUbmULMQZYw=;
 b=NqUTaEwI7I2C+87P85APoSgdQhrocZfNaJLjgHKIVcqnL/sJh7UVsVdWQ7SqG0c8pXG4
 wecRSjjk9gXdzzC2EtXpArrWLyMz/xgVCCflqhD/NehtNjqk2gdJmAydxNxTr8Xenj2h
 UBkBJjWedTy8lkIo6m3hOXntptn1VdZYA82rgvk3Ndhknrv3FlVJFIlloJgs/PehSN3h
 v2TctJvVOPMTPT9sPtgKzo8a4Gl7QVi2Ts5PrwhxkK2k37wbiBi43jCefgjepzj7SzPF
 F6Rhf4TKwWS6gfNidQ2wIj1wsOjoTS4GYDn/HaNVQsrMN4MFjIh7md+mNAodLUH82e6T Wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2spu7dm0g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:31:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TIUNus033756;
        Wed, 29 May 2019 18:31:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2sqh73vgqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:31:52 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4TIVoEW031873;
        Wed, 29 May 2019 18:31:51 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 11:31:50 -0700
Date:   Wed, 29 May 2019 11:31:49 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH v3 07/13] xfs: use file_modified() helper
Message-ID: <20190529183149.GG5231@magnolia>
References: <20190529174318.22424-1-amir73il@gmail.com>
 <20190529174318.22424-8-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529174318.22424-8-amir73il@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=761
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905290119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=800 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290119
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 08:43:11PM +0300, Amir Goldstein wrote:
> Note that by using the helper, the order of calling file_remove_privs()
> after file_update_mtime() in xfs_file_aio_write_checks() has changed.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/xfs/xfs_file.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 76748255f843..916a35cae5e9 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -367,20 +367,7 @@ xfs_file_aio_write_checks(
>  	 * lock above.  Eventually we should look into a way to avoid
>  	 * the pointless lock roundtrip.
>  	 */
> -	if (likely(!(file->f_mode & FMODE_NOCMTIME))) {

...especially since here we think NOCMTIME is likely /not/ to be set.

> -		error = file_update_time(file);
> -		if (error)
> -			return error;
> -	}
> -
> -	/*
> -	 * If we're writing the file then make sure to clear the setuid and
> -	 * setgid bits if the process is not being run by root.  This keeps
> -	 * people from modifying setuid and setgid binaries.
> -	 */
> -	if (!IS_NOSEC(inode))
> -		return file_remove_privs(file);

Hm, file_modified doesn't have the !IS_NOSEC check guarding
file_remove_privs, are you sure it's ok to remove the suid bits
unconditionally?  Even if SB_NOSEC (and therefore S_NOSEC) are set?

--D

> -	return 0;
> +	return file_modified(file);
>  }
>  
>  static int
> -- 
> 2.17.1
> 
