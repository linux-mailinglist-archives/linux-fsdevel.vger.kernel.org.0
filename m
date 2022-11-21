Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E65632D6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 20:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiKUTya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 14:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiKUTxn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:53:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14773DAD0D;
        Mon, 21 Nov 2022 11:53:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5C0B5CE1796;
        Mon, 21 Nov 2022 19:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B19FC433D6;
        Mon, 21 Nov 2022 19:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669060400;
        bh=3dlSKEhAYmmduNklStCZmmskfXVee144acr5/2TLiuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rqJPBshdW+noo4YH9I311IFgmabxU2tzeI3nVxV9nSRACSqc5mYCG3aAvYaUeBO3X
         ASF5j1SiRQLP8ooF6Zz7Je4aR/nsXelKewhTeKQ2vpKdqzHgSC7VAwFThnSaCYTspl
         HlEulRBtTNXBTFXXZUpIDVWJnD9GM6tjpW84Kxsnt/nac5IY6b4ai/HJ4OV9daN9Ek
         JQmiTh/rN3nxBfFfVb1WeNrL5V8YGaEbtlQG/gpKNL/s3NLkQSbON3Q6MF0Jk33by+
         FJQyFQazAeKmBzu60bzWx4xV77wmzlSlCUQG4sOtqnjPDqSGR4aJ0Jrjko2fjqvHOP
         Ssczx/D/sBtVQ==
Date:   Mon, 21 Nov 2022 19:53:19 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/5] fs: f2fs: initialize fsdata in pagecache_write()
Message-ID: <Y3vXL3Lw+DnVkQYC@gmail.com>
References: <20221121112134.407362-1-glider@google.com>
 <20221121112134.407362-3-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121112134.407362-3-glider@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 12:21:32PM +0100, Alexander Potapenko wrote:
> When aops->write_begin() does not initialize fsdata, KMSAN may report
> an error passing the latter to aops->write_end().
> 
> Fix this by unconditionally initializing fsdata.
> 
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Fixes: 95ae251fe828 ("f2fs: add fs-verity support")
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  fs/f2fs/verity.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
> index c352fff88a5e6..3f4f3295f1c66 100644
> --- a/fs/f2fs/verity.c
> +++ b/fs/f2fs/verity.c
> @@ -81,7 +81,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
>  		size_t n = min_t(size_t, count,
>  				 PAGE_SIZE - offset_in_page(pos));
>  		struct page *page;
> -		void *fsdata;
> +		void *fsdata = NULL;
>  		int res;
>  
>  		res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
