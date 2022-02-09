Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BF34AEB7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 08:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbiBIHxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 02:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiBIHxA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:53:00 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD03C0613CB;
        Tue,  8 Feb 2022 23:53:03 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V3zwdmU_1644393177;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V3zwdmU_1644393177)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 15:52:59 +0800
Date:   Wed, 9 Feb 2022 15:52:55 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/22] erofs: use meta buffers for
 erofs_read_superblock()
Message-ID: <YgNy121L0gYjqj6K@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
 <20220209060108.43051-7-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220209060108.43051-7-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 09, 2022 at 02:00:52PM +0800, Jeffle Xu wrote:
> The only change is that, meta buffers read cache page without __GFP_FS
> flag, which shall not matter.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

(If this patchset left behind anyway, I will submit this cleanup
 independently for the next cycle.)

Thanks,
Gao Xiang

> ---
>  fs/erofs/super.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 915eefe0d7e2..12755217631f 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -281,21 +281,19 @@ static int erofs_init_devices(struct super_block *sb,
>  static int erofs_read_superblock(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi;
> -	struct page *page;
> +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>  	struct erofs_super_block *dsb;
>  	unsigned int blkszbits;
>  	void *data;
>  	int ret;
>  
> -	page = read_mapping_page(sb->s_bdev->bd_inode->i_mapping, 0, NULL);
> -	if (IS_ERR(page)) {
> +	data = erofs_read_metabuf(&buf, sb, 0, EROFS_KMAP);
> +	if (IS_ERR(data)) {
>  		erofs_err(sb, "cannot read erofs superblock");
> -		return PTR_ERR(page);
> +		return PTR_ERR(data);
>  	}
>  
>  	sbi = EROFS_SB(sb);
> -
> -	data = kmap(page);
>  	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
>  
>  	ret = -EINVAL;
> @@ -365,8 +363,7 @@ static int erofs_read_superblock(struct super_block *sb)
>  	if (erofs_sb_has_ztailpacking(sbi))
>  		erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
>  out:
> -	kunmap(page);
> -	put_page(page);
> +	erofs_put_metabuf(&buf);
>  	return ret;
>  }
>  
> -- 
> 2.27.0
