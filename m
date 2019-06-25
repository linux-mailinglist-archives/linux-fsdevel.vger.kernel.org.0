Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5240552379
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 08:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfFYGXg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 02:23:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729109AbfFYGXf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:23:35 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P6I2if040475
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2019 02:23:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tbagtqjdh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2019 02:23:33 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Tue, 25 Jun 2019 07:23:31 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 07:23:27 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5P6NHCq39584030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 06:23:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF179AE056;
        Tue, 25 Jun 2019 06:23:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39BFAAE055;
        Tue, 25 Jun 2019 06:23:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.58])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 06:23:25 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V3 2/7] Integrate read callbacks into Ext4 and F2FS
Date:   Tue, 25 Jun 2019 11:35:06 +0530
Organization: IBM
In-Reply-To: <20190621210800.GB167064@gmail.com>
References: <20190616160813.24464-1-chandan@linux.ibm.com> <20190616160813.24464-3-chandan@linux.ibm.com> <20190621210800.GB167064@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19062506-0008-0000-0000-000002F6BFC0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062506-0009-0000-0000-00002263EE8F
Message-Id: <4046659.6pHPRur4YB@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250050
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Saturday, June 22, 2019 2:38:01 AM IST Eric Biggers wrote:
> Hi Chandan,
> 
> On Sun, Jun 16, 2019 at 09:38:08PM +0530, Chandan Rajendra wrote:
> > This commit gets Ext4 and F2FS to make use of read callbacks API to
> > perform decryption of file data read from the disk.
> > ---
> >  fs/crypto/bio.c             |  30 +--------
> >  fs/crypto/crypto.c          |   1 +
> >  fs/crypto/fscrypt_private.h |   3 +
> >  fs/ext4/readpage.c          |  29 +++------
> >  fs/f2fs/data.c              | 124 +++++++-----------------------------
> >  fs/f2fs/super.c             |   9 +--
> >  fs/read_callbacks.c         |   1 -
> >  include/linux/fscrypt.h     |  18 ------
> >  8 files changed, 40 insertions(+), 175 deletions(-)
> > 
> 
> This patch changes many different components.  It would be much easier to
> review, and might get more attention from the other ext4 and f2fs developers, if
> it were split into 3 patches:
> 
> a. Convert ext4 to use read_callbacks.
> b. Convert f2fs to use read_callbacks.
> c. Remove the functions from fs/crypto/ that became unused as a result of
>    patches (a) and (b).  (Actually, this part probably should be merged with the
>    patch that removes the fscrypt_ctx, and the patch renamed to something like
>    "fscrypt: remove decryption I/O path helpers")
> 
> Any reason why this wouldn't work?  AFAICS, you couldn't do it only because you
> made this patch change fscrypt_enqueue_decrypt_work() to be responsible for
> initializing the work function.  But as per my comments on patch 1, I don't
> think we should do that, since it would make much more sense to put the work
> function in read_callbacks.c.

Yes, you are right about that. I will make the changes suggested by you.

> 
> However, since you're converting ext4 to use mpage_readpages() anyway, I don't
> think we should bother with the intermediate change to ext4_mpage_readpages().
> It's useless, and that intermediate state of the ext4 code inevitably won't get
> tested very well.  So perhaps order the whole series as:
> 
> - fs: introduce read_callbacks
> - fs/mpage.c: add decryption support via read_callbacks
> - fs/buffer.c: add decryption support via read_callbacks
> - f2fs: convert to use read_callbacks
> - ext4: convert to use mpage_readpages[s]
> - ext4: support encryption with subpage-sized blocks
> - fscrypt: remove decryption I/O path helpers
> 
> That order would also give the flexibility to possibly apply the fs/ changes
> first, without having to update both ext4 and f2fs simultaneously with them.
> 
> > @@ -557,8 +511,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
> >  {
> >  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >  	struct bio *bio;
> > -	struct bio_post_read_ctx *ctx;
> > -	unsigned int post_read_steps = 0;
> > +	int ret;
> 
> Nit: 'err' rather than 'ret', since this is 0 or a -errno value.
> 
> > -int __init f2fs_init_post_read_processing(void)
> > -{
> > -	bio_post_read_ctx_cache = KMEM_CACHE(bio_post_read_ctx, 0);
> > -	if (!bio_post_read_ctx_cache)
> > -		goto fail;
> > -	bio_post_read_ctx_pool =
> > -		mempool_create_slab_pool(NUM_PREALLOC_POST_READ_CTXS,
> > -					 bio_post_read_ctx_cache);
> > -	if (!bio_post_read_ctx_pool)
> > -		goto fail_free_cache;
> > -	return 0;
> > -
> > -fail_free_cache:
> > -	kmem_cache_destroy(bio_post_read_ctx_cache);
> > -fail:
> > -	return -ENOMEM;
> > -}
> > -
> > -void __exit f2fs_destroy_post_read_processing(void)
> > -{
> > -	mempool_destroy(bio_post_read_ctx_pool);
> > -	kmem_cache_destroy(bio_post_read_ctx_cache);
> > -}
> 
> Need to remove the declarations of these functions from fs/f2fs/f2fs.h to.
> 
> > diff --git a/fs/read_callbacks.c b/fs/read_callbacks.c
> > index a4196e3de05f..4b7fc2a349cd 100644
> > --- a/fs/read_callbacks.c
> > +++ b/fs/read_callbacks.c
> > @@ -76,7 +76,6 @@ void read_callbacks(struct read_callbacks_ctx *ctx)
> >  	switch (++ctx->cur_step) {
> >  	case STEP_DECRYPT:
> >  		if (ctx->enabled_steps & (1 << STEP_DECRYPT)) {
> > -			INIT_WORK(&ctx->work, fscrypt_decrypt_work);
> >  			fscrypt_enqueue_decrypt_work(&ctx->work);
> >  			return;
> >  		}
> 
> Again, I think the work initialization should remain here as:
> 
> 	INIT_WORK(&ctx->work, decrypt_work);
> 
> rather than moving it to fs/crypto/.
> 
> Thanks!
> 
> - Eric
> 


-- 
chandan



