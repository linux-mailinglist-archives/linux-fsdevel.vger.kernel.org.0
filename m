Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E706CD42F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 10:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjC2IPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 04:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjC2IOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:14:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A1449D3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 01:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=if1Hi/Sps7b6+QdgC4Nxbvy8tS+IM4P01ucXO7CleDo=; b=Aowup5PGvf8g2n2WD8zyFU9IzC
        Kyby3DVwUTZzgTvDHy4thA0JGHHNm6hmc9UIE5zlQvyZ4Ri+iIORH3rYuVoXmH8v3h8Fx8l2jpyz4
        PrN896+WaAyWRQj1MCBrWK5veTO00U/XaCCqd8swSW4s9jcXlDm7CfhCyVn/VK/bLaESh7Knp1uv+
        OoaxE+hM5NqsUmYN64APpnio5mecBBfoeAhc/mhOuJtRepe/dnKlLVKVybKgBCxuNaCq7k79oqYON
        ezJE++M4QOHdQKume6EKFBrwOy5BClu8NNsDNMjNY+lPjrN42LHExrgli7SDLpqsMkoebXJiOavXy
        vL37RwVQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phQx3-00H2uU-04;
        Wed, 29 Mar 2023 08:14:37 +0000
Date:   Wed, 29 Mar 2023 01:14:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hans Holmberg <hans.holmberg@wdc.com>
Subject: Re: [PATCH] zonefs: Always invalidate last cache page on append write
Message-ID: <ZCPzbFzjFyiOVDdl@infradead.org>
References: <20230329055823.1677193-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329055823.1677193-1-damien.lemoal@opensource.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 29, 2023 at 02:58:23PM +0900, Damien Le Moal wrote:
> +	/*
> +	 * If the inode block size (sector size) is smaller than the
> +	 * page size, we may be appending data belonging to an already
> +	 * cached last page of the inode. So make sure to invalidate that
> +	 * last cached page. This will always be a no-op for the case where
> +	 * the block size is equal to the page size.
> +	 */
> +	ret = invalidate_inode_pages2_range(inode->i_mapping,
> +					    iocb->ki_pos >> PAGE_SHIFT, -1);
> +	if (ret)
> +		return ret;

The missing truncate here obviously is a bug and needs fixing.

But why does this not follow the logic in __iomap_dio_rw to to return
-ENOTBLK for any error so that the write falls back to buffered I/O.
Also as far as I can tell from reading the code, -1 is not a valid
end special case for invalidate_inode_pages2_range, so you'll actually
have to pass a valid end here.
