Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9371057BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 18:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKURAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 12:00:25 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46400 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfKURAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:00:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xALGx9vL089530;
        Thu, 21 Nov 2019 17:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=LSm5t97xI8pxVFKuFXAClzX7Acv7GyLS5PB175+zqaM=;
 b=TzJBXjPM6iCYH6QW71JPpaqfMBcPLrRDpqsIqv/x7RKueK0ksT38QycDPuZoCciO+nM7
 2Y4BlsDnkcyAZXbAu2TqGlsujo+vyU5ybHawPiXpg19y2rU2ytmi/Vy/ho5Cwg3Furdg
 37llLppvpyx9nitBC1Zu/m7Em1NtZLeYy1oqaJiWNZBfdr+xqfjwmsBLuvAvbqahnDLl
 NkyOeSlbHclaI+36dtOEUmGnJPGXEPZlf8CppeKg5FXMXiNT5JSY4leL8iJwTVMCzqxp
 Damc2UjpAwMw7laKV8V7AHzvWtXHSGbq1mp5VNlRy56CMKrftjAhZeK01X+NZJ3IJ9zM 1A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wa9rqwj2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Nov 2019 17:00:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xALGwFQx191385;
        Thu, 21 Nov 2019 17:00:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2wda06bbrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Nov 2019 17:00:17 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xALH0EKD019699;
        Thu, 21 Nov 2019 17:00:15 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 09:00:14 -0800
Date:   Thu, 21 Nov 2019 09:00:13 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>, ebiggers@kernel.org
Subject: Re: [PATCH v4] splice: only read in as much information as there is
 pipe buffer space
Message-ID: <20191121170013.GL6211@magnolia>
References: <20191019161138.GA6726@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191019161138.GA6726@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911210148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911210148
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping?  Can /someone/ please review this?

--D

On Sat, Oct 19, 2019 at 09:11:38AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Andreas Grünbacher reports that on the two filesystems that support
> iomap directio, it's possible for splice() to return -EAGAIN (instead of
> a short splice) if the pipe being written to has less space available in
> its pipe buffers than the length supplied by the calling process.
> 
> Months ago we fixed splice_direct_to_actor to clamp the length of the
> read request to the size of the splice pipe.  Do the same to do_splice.
> 
> Fixes: 17614445576b6 ("splice: don't read more than available pipe space")
> Reported-by: Andreas Grünbacher <andreas.gruenbacher@gmail.com>
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
> v4: use size_t for pipe_pages
> ---
>  fs/splice.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/splice.c b/fs/splice.c
> index 98412721f056..9b9b22d2215a 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -945,12 +945,13 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
>  	WARN_ON_ONCE(pipe->nrbufs != 0);
>  
>  	while (len) {
> +		size_t pipe_pages;
>  		size_t read_len;
>  		loff_t pos = sd->pos, prev_pos = pos;
>  
>  		/* Don't try to read more the pipe has space for. */
> -		read_len = min_t(size_t, len,
> -				 (pipe->buffers - pipe->nrbufs) << PAGE_SHIFT);
> +		pipe_pages = pipe->buffers - pipe->nrbufs;
> +		read_len = min(len, pipe_pages << PAGE_SHIFT);
>  		ret = do_splice_to(in, &pos, pipe, read_len, flags);
>  		if (unlikely(ret <= 0))
>  			goto out_release;
> @@ -1180,8 +1181,15 @@ static long do_splice(struct file *in, loff_t __user *off_in,
>  
>  		pipe_lock(opipe);
>  		ret = wait_for_space(opipe, flags);
> -		if (!ret)
> +		if (!ret) {
> +			size_t pipe_pages;
> +
> +			/* Don't try to read more the pipe has space for. */
> +			pipe_pages = opipe->buffers - opipe->nrbufs;
> +			len = min(len, pipe_pages << PAGE_SHIFT);
> +
>  			ret = do_splice_to(in, &offset, opipe, len, flags);
> +		}
>  		pipe_unlock(opipe);
>  		if (ret > 0)
>  			wakeup_pipe_readers(opipe);
