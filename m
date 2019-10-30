Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 871C3E99C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 11:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfJ3KNW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 06:13:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726096AbfJ3KNV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:13:21 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9UA9Lxo005370
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2019 06:13:20 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vy6njm72v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2019 06:13:19 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 30 Oct 2019 10:13:17 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 30 Oct 2019 10:13:15 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9UADEog53411954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 10:13:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 032ECA404D;
        Wed, 30 Oct 2019 10:13:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2175EA4055;
        Wed, 30 Oct 2019 10:13:11 +0000 (GMT)
Received: from [9.199.158.87] (unknown [9.199.158.87])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 30 Oct 2019 10:13:10 +0000 (GMT)
Subject: Re: [PATCH] ext4: bio_alloc never fails
To:     Gao Xiang <gaoxiang25@huawei.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191030042618.124220-1-gaoxiang25@huawei.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 30 Oct 2019 15:43:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191030042618.124220-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19103010-0016-0000-0000-000002BF14B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19103010-0017-0000-0000-000033207124
Message-Id: <20191030101311.2175EA4055@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-30_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910300100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/30/19 9:56 AM, Gao Xiang wrote:
> Similar to [1] [2], it seems a trivial cleanup since
> bio_alloc can handle memory allocation as mentioned in
> fs/direct-io.c (also see fs/block_dev.c, fs/buffer.c, ..)
> 

AFAIU, the reason is that, bio_alloc with __GFP_DIRECT_RECLAIM
flags guarantees bio allocation under some given restrictions,
as stated in fs/direct-io.c
So here it is ok to not check for NULL value from bio_alloc.

I think we can update above info too in your commit msg.

> [1] https://lore.kernel.org/r/20191030035518.65477-1-gaoxiang25@huawei.com
> [2] https://lore.kernel.org/r/20190830162812.GA10694@infradead.org
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>   fs/ext4/page-io.c  | 11 +++--------
>   fs/ext4/readpage.c |  2 --
>   2 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 12ceadef32c5..f1f7b6601780 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -358,14 +358,12 @@ void ext4_io_submit_init(struct ext4_io_submit *io,
>   	io->io_end = NULL;
>   }
> 
> -static int io_submit_init_bio(struct ext4_io_submit *io,
> -			      struct buffer_head *bh)
> +static void io_submit_init_bio(struct ext4_io_submit *io,
> +			       struct buffer_head *bh)
>   {
>   	struct bio *bio;
> 
>   	bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
> -	if (!bio)
> -		return -ENOMEM;
>   	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
>   	bio_set_dev(bio, bh->b_bdev);
>   	bio->bi_end_io = ext4_end_bio;
> @@ -373,7 +371,6 @@ static int io_submit_init_bio(struct ext4_io_submit *io,
>   	io->io_bio = bio;
>   	io->io_next_block = bh->b_blocknr;
>   	wbc_init_bio(io->io_wbc, bio);
> -	return 0;
>   }
> 
>   static int io_submit_add_bh(struct ext4_io_submit *io,
> @@ -388,9 +385,7 @@ static int io_submit_add_bh(struct ext4_io_submit *io,
>   		ext4_io_submit(io);
>   	}
>   	if (io->io_bio == NULL) {
> -		ret = io_submit_init_bio(io, bh);
> -		if (ret)
> -			return ret;
> +		io_submit_init_bio(io, bh);
>   		io->io_bio->bi_write_hint = inode->i_write_hint;
>   	}
>   	ret = bio_add_page(io->io_bio, page, bh->b_size, bh_offset(bh));


Also we can further simplify it like below. Please check.

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index f1f7b6601780..a3a2edeb3bbf 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -373,7 +373,7 @@ static void io_submit_init_bio(struct ext4_io_submit 
*io,
  	wbc_init_bio(io->io_wbc, bio);
  }

-static int io_submit_add_bh(struct ext4_io_submit *io,
+static void io_submit_add_bh(struct ext4_io_submit *io,
  			    struct inode *inode,
  			    struct page *page,
  			    struct buffer_head *bh)
@@ -393,7 +393,6 @@ static int io_submit_add_bh(struct ext4_io_submit *io,
  		goto submit_and_retry;
  	wbc_account_cgroup_owner(io->io_wbc, page, bh->b_size);
  	io->io_next_block++;
-	return 0;
  }

  int ext4_bio_write_page(struct ext4_io_submit *io,
@@ -495,30 +494,23 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
  	do {
  		if (!buffer_async_write(bh))
  			continue;
-		ret = io_submit_add_bh(io, inode, bounce_page ?: page, bh);
-		if (ret) {
-			/*
-			 * We only get here on ENOMEM.  Not much else
-			 * we can do but mark the page as dirty, and
-			 * better luck next time.
-			 */
-			break;
-		}
+		io_submit_add_bh(io, inode, bounce_page ?: page, bh);
  		nr_submitted++;
  		clear_buffer_dirty(bh);
  	} while ((bh = bh->b_this_page) != head);

-	/* Error stopped previous loop? Clean up buffers... */
-	if (ret) {
-	out:
-		fscrypt_free_bounce_page(bounce_page);
-		printk_ratelimited(KERN_ERR "%s: ret = %d\n", __func__, ret);
-		redirty_page_for_writepage(wbc, page);
-		do {
-			clear_buffer_async_write(bh);
-			bh = bh->b_this_page;
-		} while (bh != head);
-	}
+	goto unlock;
+
+out:
+	fscrypt_free_bounce_page(bounce_page);
+	printk_ratelimited(KERN_ERR "%s: ret = %d\n", __func__, ret);
+	redirty_page_for_writepage(wbc, page);
+	do {
+		clear_buffer_async_write(bh);
+		bh = bh->b_this_page;
+	} while (bh != head);
+
+unlock:
  	unlock_page(page);
  	/* Nothing submitted - we have to end page writeback */
  	if (!nr_submitted)


-ritesh

