Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB533F8612
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 02:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKLB1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 20:27:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34686 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfKLB1M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:27:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAC1JP6v192241;
        Tue, 12 Nov 2019 01:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=d0CIgE6VLDN1RdkD6BFHTIX2iR/MvwCtQwIJyh0r6ew=;
 b=PRH6mn6sdO8AC5G+CRAbO66J4Xs6LTMyrOafcYKY4crw65aCjlZH5B2banUCQbGVdfxF
 HyAx3Wv7XuFLMZurpskQT3koewW9AkfKY9p1KPlBQK8CEjD9eBaMzGHKbKhDYL6VBwYy
 ibIfqbvkz7v5s4D7lu74h19viirCXarOui2l8IppRaJqOavZ/86uP6MR35DkJEsASu3g
 YGmv004JLWeihhYrcAKWRVFrA0J/YSN3+iXQ5TXvYbtLuElWPTGKm+LQEmCJ4uy+qZMN
 qHNCuU3XJa0yBca0ah3Gv8AfYZzLW7v7ftQ3fmlpH2UHY6TngS/BY7vv0Sfsak2cIsCs MA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2w5ndq1kfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 01:26:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAC1INd7113586;
        Tue, 12 Nov 2019 01:24:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2w66wmxxmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 01:24:32 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAC1OLRj011934;
        Tue, 12 Nov 2019 01:24:21 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Nov 2019 01:24:21 +0000
Date:   Mon, 11 Nov 2019 17:24:19 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     naresh.kamboju@linaro.org, hch@infradead.org, ltp@lists.linux.it,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        chrubis@suse.cz, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, broonie@kernel.org, arnd@arndb.de,
        lkft-triage@lists.linaro.org, linux-ext4@vger.kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH] iomap: fix return value of iomap_dio_bio_actor on 32bit
 systems
Message-ID: <20191112012419.GE6211@magnolia>
References: <20191111083815.GA29540@infradead.org>
 <b757ff64ddf68519fc3d55b66fcd8a1d4b436395.1573467154.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b757ff64ddf68519fc3d55b66fcd8a1d4b436395.1573467154.git.jstancek@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9438 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911120009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9438 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911120009
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 11, 2019 at 11:28:10AM +0100, Jan Stancek wrote:
> Naresh reported LTP diotest4 failing for 32bit x86 and arm -next
> kernels on ext4. Same problem exists in 5.4-rc7 on xfs.
> 
> The failure comes down to:
>   openat(AT_FDCWD, "testdata-4.5918", O_RDWR|O_DIRECT) = 4
>   mmap2(NULL, 4096, PROT_READ, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f7b000
>   read(4, 0xb7f7b000, 4096)              = 0 // expects -EFAULT
> 
> Problem is conversion at iomap_dio_bio_actor() return. Ternary
> operator has a return type and an attempt is made to convert each
> of operands to the type of the other. In this case "ret" (int)
> is converted to type of "copied" (unsigned long). Both have size
> of 4 bytes:
>     size_t copied = 0;
>     int ret = -14;
>     long long actor_ret = copied ? copied : ret;
> 
>     On x86_64: actor_ret == -14;
>     On x86   : actor_ret == 4294967282
> 
> Replace ternary operator with 2 return statements to avoid this
> unwanted conversion.
> 
> Fixes: 4721a6010990 ("iomap: dio data corruption and spurious errors when pipes fill")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Thansk for the full explanation & patch, will test...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/direct-io.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 1fc28c2da279..7c58f51d7da7 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -318,7 +318,9 @@ static void iomap_dio_bio_end_io(struct bio *bio)
>  		if (pad)
>  			iomap_dio_zero(dio, iomap, pos, fs_block_size - pad);
>  	}
> -	return copied ? copied : ret;
> +	if (copied)
> +		return copied;
> +	return ret;
>  }
>  
>  static loff_t
> -- 
> 1.8.3.1
> 
