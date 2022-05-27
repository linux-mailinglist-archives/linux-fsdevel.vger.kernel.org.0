Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C105358C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 07:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbiE0FfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 01:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiE0FfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 01:35:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507B41139
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 22:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IhpncNkSVwNW8djKD1CtCOTMAlu1Jlslv5PWKDVJ7BI=; b=Iu+5xSdnHdFtNCcbjSscGyPTk1
        5RQBLAm3XnpIf86YaLwLEgzWD/TiACu/tqudFkEagTJLA0JSuyRLva7dQpM5eQno88iXlQBUTdCU6
        LQcWVhfTgTPI7zVKWnGKa7z5+zcxiL1k8d0Oh9MezzkONY9DI5vLlo48pkn+EiyL9b1RnhsyoBPQ2
        rA4b7uWeeIeeivJvVxIqeCS/co7zlxuFwuYFUPc6UKyyPtbUgub8pEdzmrDfnDfF8MbrNG+cfJYa/
        dYyXwS/peNYUjIquKpd2pu/DSSg43RzLemJGskAplu7eshfWMw3UOzTwgL/4b3g1J7YaHXNasuuoM
        ZRHZiHRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuScx-00GgJo-6n; Fri, 27 May 2022 05:35:11 +0000
Date:   Thu, 26 May 2022 22:35:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [RFC PATCH 1/9] IOMAP_DIO_NOSYNC
Message-ID: <YpBjD4Y7su+GVSkX@infradead.org>
References: <20220526192910.357055-1-willy@infradead.org>
 <20220526192910.357055-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526192910.357055-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 26, 2022 at 08:29:02PM +0100, Matthew Wilcox (Oracle) wrote:
> Al's patch.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Hmm, that is a bit of a weird changelog..

>  		/* for data sync or sync, we need sync completion processing */
> -		if (iocb->ki_flags & IOCB_DSYNC)
> +		if (iocb->ki_flags & IOCB_DSYNC &&
> +		    !(dio_flags & IOMAP_DIO_NOSYNC))
>  			dio->flags |= IOMAP_DIO_NEED_SYNC;
>  
>  		/*

I think we also need to skip the setting of IOMAP_DIO_WRITE_FUA below
(or find a way to communicate back to the that FUA was used, which
seems way more complicated)
