Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F322110490
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 19:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfLCSzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 13:55:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbfLCSzG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 13:55:06 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EEC72080F;
        Tue,  3 Dec 2019 18:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575399306;
        bh=Yy+NCK8f/msWH1RFOzNPSK4SvFfX6T8hNoJVioxkd3c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=zTM8Uy09UCWKLIdm+QBh2uY/Zil1GYAbFu4QAy527mu/hBkjivKgq5wtEGh2IQh/t
         W54LT0SqvmQxauDw5gmcYPTBRwKq0XdCBGzCD1NNa1xtZmhITV1rDVcBOec51OtIz5
         Y0HpkRcKD2tZI0BQ+epu3UzLOBvZ7I/PTukPtZ/U=
Message-ID: <aef16571cebc9979c73533c98b6b682618fd64a8.camel@kernel.org>
Subject: Re: [PATCH v2 3/6] fs: ceph: Delete timespec64_trunc() usage
From:   Jeff Layton <jlayton@kernel.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 03 Dec 2019 13:55:04 -0500
In-Reply-To: <20191203051945.9440-4-deepa.kernel@gmail.com>
References: <20191203051945.9440-1-deepa.kernel@gmail.com>
         <20191203051945.9440-4-deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-12-02 at 21:19 -0800, Deepa Dinamani wrote:
> Since ceph always uses ns granularity, skip the
> truncation which is a no-op.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: jlayton@kernel.org
> Cc: ceph-devel@vger.kernel.org
> ---
>  fs/ceph/mds_client.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 068b029cf073..88687ed65cff 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2069,7 +2069,6 @@ struct ceph_mds_request *
>  ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
>  {
>  	struct ceph_mds_request *req = kzalloc(sizeof(*req), GFP_NOFS);
> -	struct timespec64 ts;
>  
>  	if (!req)
>  		return ERR_PTR(-ENOMEM);
> @@ -2088,8 +2087,7 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
>  	init_completion(&req->r_safe_completion);
>  	INIT_LIST_HEAD(&req->r_unsafe_item);
>  
> -	ktime_get_coarse_real_ts64(&ts);
> -	req->r_stamp = timespec64_trunc(ts, mdsc->fsc->sb->s_time_gran);
> +	ktime_get_coarse_real_ts64(&req->r_stamp);
>  
>  	req->r_op = op;
>  	req->r_direct_mode = mode;

Thanks Deepa. We'll plan to take this one in via the ceph tree.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

