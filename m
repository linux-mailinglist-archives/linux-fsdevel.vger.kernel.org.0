Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC7C12CBFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 18:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfE1Qa7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 12:30:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41272 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfE1Qa7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 12:30:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SGSqLD165919;
        Tue, 28 May 2019 16:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=HQqsHP2Dch/+MMnMHvEsTt40LqVZM8h2XtzGgJE1mMA=;
 b=Ehem25LI9rEryKwf4rBZ011znJfXqOsPCd2LiprEaJA+kEiOk4XMCvuYfvQhBzaO7/9T
 4tH487f8vtr57f98UXIJMxargkVycTv8TCPi3OSWIqRr5W8s9BHGh5HSq1ALGSupM5vs
 ieq6ERpMWF7aPhJUGlrvjsRYnpNJS0WJtS+Mh/o0NzhmWZeUZCf+IiD55cPgbs7Pgnq3
 ls9JREHlwRYa1G7IzlwD0m1lEIIw/15eyY8WKQH2RhHzyX4T5d911w9rXHYFawY1f/zd
 29HaqLP3qiPCynGZs1Zb4LV/BstnmV3wvMlNBFizxqnixMs3U9iKtFqnVvT1RjRond/i HA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2spw4tcev7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 16:30:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SGULxg170997;
        Tue, 28 May 2019 16:30:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2sqh7378da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 16:30:22 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4SGUMGw009191;
        Tue, 28 May 2019 16:30:22 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 09:30:22 -0700
Date:   Tue, 28 May 2019 09:30:20 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-api@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v2 6/8] vfs: copy_file_range should update file timestamps
Message-ID: <20190528163020.GF5221@magnolia>
References: <20190526061100.21761-1-amir73il@gmail.com>
 <20190526061100.21761-7-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526061100.21761-7-amir73il@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280105
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 09:10:57AM +0300, Amir Goldstein wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Timestamps are not updated right now, so programs looking for
> timestamp updates for file modifications (like rsync) will not
> detect that files have changed. We are also accessing the source
> data when doing a copy (but not when cloning) so we need to update
> atime on the source file as well.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/read_write.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index e16bcafc0da2..4b23a86aacd9 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1576,6 +1576,16 @@ int generic_copy_file_range_prep(struct file *file_in, struct file *file_out)
>  
>  	WARN_ON_ONCE(!inode_is_locked(file_inode(file_out)));
>  
> +	/* Update source timestamps, because we are accessing file data */
> +	file_accessed(file_in);
> +
> +	/* Update destination timestamps, since we can alter file contents. */
> +	if (!(file_out->f_mode & FMODE_NOCMTIME)) {
> +		ret = file_update_time(file_out);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/*
>  	 * Clear the security bits if the process is not being run by root.
>  	 * This keeps people from modifying setuid and setgid binaries.

Should the file_update_time and file_remove_privs calls be factored into
a separate small function to be called by generic_{copy,remap}_range_prep?

Looks ok otherwise,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> -- 
> 2.17.1
> 
