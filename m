Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 903242CC3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 18:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfE1Qjd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 12:39:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49688 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfE1Qjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 12:39:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SGYtBE171898;
        Tue, 28 May 2019 16:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=qsNqiTxTjHWC9UYKJ2H7Vx/bDfTKWMkUr8SIkDxm9oY=;
 b=D77UjDBdpj4/eLkXI9XQLAWQ1c2jsa/OGsCVpRyMyizUDro1etdTkWJ2x2n6rYL81OrL
 WmsJ1x7wza2G4ab5YikQxqb7O44MTTXbQeQh5weuF2ogBSmLXXXv3s264vCH+j2CcdE+
 /CUUFqcOHcJly/gDLM6x46ui67WasOGUJzeOSmfQ4g4c0E8F6Rto2LInBpdcZSQ4Pfoo
 w6sxmmgQfuYLh1xLR48q36SYy/NXxSimhg/HCyVDsm/KdruU12KU4XZSWtzDjuanb44G
 QeKiQSQ7eU8M3/AunN3z8p94fK7kRvKL9ozYcBJ7njGtb5Daztp4eDq3tHesT1MRA5bV ZA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2spw4tcgf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 16:39:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SGZwBq173077;
        Tue, 28 May 2019 16:37:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2sr31us1rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 16:37:21 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4SGbKNf014893;
        Tue, 28 May 2019 16:37:20 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 09:37:20 -0700
Date:   Tue, 28 May 2019 09:37:18 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 8/8] vfs: remove redundant checks from
 generic_remap_checks()
Message-ID: <20190528163718.GI5221@magnolia>
References: <20190526061100.21761-1-amir73il@gmail.com>
 <20190526061100.21761-9-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526061100.21761-9-amir73il@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280106
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 09:10:59AM +0300, Amir Goldstein wrote:
> The access limit checks on input file range in generic_remap_checks()
> are redundant because the input file size is guarantied to be within

                                    guaranteed ^^^^^^^^^^

> limits and pos+len are already checked to be within input file size.
> 
> Beyond the fact that the check cannot fail, if it would have failed,
> it could return -EFBIG for input file range error. There is no precedent
> for that. -EFBIG is returned in syscalls that would change file length.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  mm/filemap.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 1852fbf08eeb..7e1aa36d57a2 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3000,10 +3000,6 @@ int generic_remap_checks(struct file *file_in, loff_t pos_in,
>  		return -EINVAL;
>  	count = min(count, size_in - (uint64_t)pos_in);
>  
> -	ret = generic_access_check_limits(file_in, pos_in, &count);

I suspect you could fold generic_access_check_limits into its only
caller, then...

--D

> -	if (ret)
> -		return ret;
> -
>  	ret = generic_write_check_limits(file_out, pos_out, &count);
>  	if (ret)
>  		return ret;
> -- 
> 2.17.1
> 
