Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED864E6EF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 08:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353758AbiCYHfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 03:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353729AbiCYHff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:35:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54E553A76;
        Fri, 25 Mar 2022 00:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H0bqlbvIZKd227ofShv60vd0H6y8s70vQbLVJWzndPY=; b=K8iuhi/yPFxDiWgNishL3y0S7Y
        d91mVWgtABLzVBE1pBL7kxcF/N3yrNbv5+R0IhLpHnt+5Xjrtjua0W4CYRsNSXf7vfanfLy6kfOlN
        YMqJxtjxnbNHmlnmJ9qcdyHNnU/+pSlsFPM8BSqTBR/lalMmK1SeyvQ0845srjU1UI8eLqyRzYo9x
        dKp8/OXd1Fn8Wc/3D2XGW53+pjMFXk8Qg5lVb0rOjqpAsXrg4nxD5dYTZd+p49+W76iRVKmesuNvH
        76d3iOGxJ0MrIJzJP3QkZeCzQHGv21FGMuamNW59EL14wH7IVfNle3LmSxadc7TeuvGhE+AVHdsDR
        7nkyScZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXeSM-001LpF-5C; Fri, 25 Mar 2022 07:33:58 +0000
Date:   Fri, 25 Mar 2022 00:33:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: Re: [PATCH] exfat: reduce block requests when zeroing a cluster
Message-ID: <Yj1wZtQId8QVtBop@infradead.org>
References: <HK2PR04MB38915D9ABDC81F7D5463C4E4811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <Yj1Xmr/3GTd41p/e@infradead.org>
 <HK2PR04MB38918AE14149045AE90A6400811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR04MB38918AE14149045AE90A6400811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 25, 2022 at 07:22:54AM +0000, Yuezhang.Mo@sony.com wrote:
> Hi Christoph Hellwig,
> 
> Thank you for your comment.
> 
> > On Fri, Mar 25, 2022 at 03:00:55AM +0000, Yuezhang.Mo@sony.com wrote:
> > > +#include <linux/blk_types.h>
> > 
> > blk_types.h is not a header for public use.  What do you want it for?
> 
> +	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
> 
> The type of 'sb->s_bdev' is 'struct block_device'.
> I want to include the definition of 'struct block_device'('struct block_device' is defined in <linux/blk_types.h>).

Oh, I missed that.  We really should not derefrence bd_inode in file
systems.  So maybe we need to add a sync_blockdev_range abstraction if
we want to support this use case.
