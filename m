Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 158F0D7E45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 19:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbfJOR6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 13:58:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55096 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfJOR6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:58:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FHmmvD085863;
        Tue, 15 Oct 2019 17:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=rxO3+TSJthRdBjXKYyxxhRfBoXlZQHmgoZIaCkSiVAA=;
 b=XcPRNImi3V8QDFfz89S1AfxevDrRkADAPKapkuLhpoO/FKJPIi8nKVPy8hDIcsNTv7SR
 3EPZ2n/UwPZMyV0v3obdKOL8ulMiXv+7iyqv5GHvsUfb1SrVzMrVInyZsqDPvJ1P/rzW
 9F7l0jCnM2/nXvU1oRHuPggt6Cn62KDtJ/kH9pkGXCA8TJ9wzEfjU5c/BWEpmTRhr3Qq
 RR94FF7oBIR1SJuVIk2UKlTeRfNbg+6E4ZCqQOiHPKA5+mzXIs7YF7FYTwQW8R++i3AT
 iA68gdka54mmnHl/J+bts7IywVjaPv+fyJvNbLL7A4r4DkvxOXRLkYkAjyok0/YWVmwJ yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vk7fr9nfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 17:57:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FHlwVp088199;
        Tue, 15 Oct 2019 17:57:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vn8enn0jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 17:57:47 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9FHvjjA010409;
        Tue, 15 Oct 2019 17:57:45 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 10:57:40 -0700
Date:   Tue, 15 Oct 2019 10:57:36 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] iomap: cleanup iomap_ioend_compare
Message-ID: <20191015175736.GO13108@magnolia>
References: <20191015154345.13052-1-hch@lst.de>
 <20191015154345.13052-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015154345.13052-13-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150153
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 05:43:45PM +0200, Christoph Hellwig wrote:
> Move the initialization of ia and ib to the declaration line and remove
> a superflous else.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index c57acc3d3120..0c7f185c8c52 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1226,13 +1226,12 @@ EXPORT_SYMBOL_GPL(iomap_ioend_try_merge);
>  static int
>  iomap_ioend_compare(void *priv, struct list_head *a, struct list_head *b)
>  {
> -	struct iomap_ioend *ia, *ib;
> +	struct iomap_ioend *ia = container_of(a, struct iomap_ioend, io_list);
> +	struct iomap_ioend *ib = container_of(b, struct iomap_ioend, io_list);
>  
> -	ia = container_of(a, struct iomap_ioend, io_list);
> -	ib = container_of(b, struct iomap_ioend, io_list);
>  	if (ia->io_offset < ib->io_offset)
>  		return -1;
> -	else if (ia->io_offset > ib->io_offset)
> +	if (ia->io_offset > ib->io_offset)
>  		return 1;
>  	return 0;
>  }
> -- 
> 2.20.1
> 
