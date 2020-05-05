Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81E41C6113
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 21:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgEETcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 15:32:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52902 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgEETcx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 15:32:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 045JRb2S006709;
        Tue, 5 May 2020 19:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=rdSjQKXVW7MXP14DwcrzMCIHpaKkz+doTPGKhqIYdSg=;
 b=S1GF9zsQZ4q/DOd6+Q7rikZynXEhh7DUNn8A4UZ0FvE7gRH9Ad6M4wJ9yNKxyReQgce1
 KM+QExzlDsEBC8XuJIdlMx4Sj+4O61fafbZ2cjhDfR61uIGlqQRlMB3OJLFFXg2MziLV
 6o7AJadghBrXkO2uRvp9kMisfAIEeTzyd08Cc0C0H3YD5WS6806/7cmU1j785zaKOdkT
 oH77/zNBdi0k9x0BKGniApNl/Qzi3gYDGup3Rhy53PeNxNukaI7lVYQelDSuNKnTweiK
 FRs4I4RkKgkOAMbdT9hnaQub3l+ZJmYIzGgN25GacVYjyMlfqqUfmMVpn54JyhVmFSuF IA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30s09r6rb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 May 2020 19:32:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 045JRiv2128615;
        Tue, 5 May 2020 19:30:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30t1r5sr6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 May 2020 19:30:51 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 045JUoYk019554;
        Tue, 5 May 2020 19:30:50 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 May 2020 12:30:50 -0700
Date:   Tue, 5 May 2020 12:30:49 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yuxuan Shui <yshuiv7@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: iomap_bmap should accept unwritten maps
Message-ID: <20200505193049.GC5694@magnolia>
References: <20200505183608.10280-1-yshuiv7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505183608.10280-1-yshuiv7@gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=1
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005050148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011 suspectscore=1
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050148
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 07:36:08PM +0100, Yuxuan Shui wrote:
> commit ac58e4fb03f9d111d733a4ad379d06eef3a24705 moved ext4_bmap from
> generic_block_bmap to iomap_bmap, this introduced a regression which
> prevents some user from using previously working swapfiles. The kernel
> will complain about holes while there is none.
> 
> What is happening here is that the swapfile has unwritten mappings,
> which is rejected by iomap_bmap, but was accepted by ext4_get_block.

...which is why ext4 ought to use iomap_swapfile_activate.

--D

> This commit makes sure iomap_bmap would accept unwritten mappings as
> well.
> 
> Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
> ---
>  fs/iomap/fiemap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index d55e8f491a5e..fb488dcfa8c7 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -115,7 +115,7 @@ iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
>  {
>  	sector_t *bno = data, addr;
>  
> -	if (iomap->type == IOMAP_MAPPED) {
> +	if (iomap->type == IOMAP_MAPPED || iomap->type == IOMAP_UNWRITTEN) {
>  		addr = (pos - iomap->offset + iomap->addr) >> inode->i_blkbits;
>  		*bno = addr;
>  	}
> -- 
> 2.26.2
> 
