Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E18778F61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 14:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbjHKMZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 08:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjHKMZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:25:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36084E60;
        Fri, 11 Aug 2023 05:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZdpGMx15iEhFHyxAaLQGCMEReHjpKqxyCfGbZvBZ8zY=; b=xxO6iOuxC/bhrooBVnGMmVFc18
        GBUD6P/gqWqDC+K+G8j8LKUOTvWKrJnspks/IhE5VIdCpqGo5Xwlxml9yCyMvDYr35VTBq5y8lbHq
        T8JUvarXObAJUxWRQcApJQDZdzjWiDbK+dCJiMvrE9qiCa5IWWFhO36gFHLbIkgLf8Y83SRlceKQC
        OONpBgZeRVWXfbtaZQ+tBOcDPTvTH3B5nFulZKgHQTyehMrUkjR4y61dvDdnU0hcz0/SXa6xgEQmP
        3ZEDmU07ezF2fzANeUvqgBEF4gNN4yORFrCb6WHwqqVgOt/qJ/TdIKlPcGLeJxr8ILb7pePlcgVCq
        BS/7DBQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qURD3-00Abm5-0H;
        Fri, 11 Aug 2023 12:25:41 +0000
Date:   Fri, 11 Aug 2023 05:25:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/29] block: Use bdev_open_by_dev() in blkdev_open()
Message-ID: <ZNYoxVjZu8dy6B2U@infradead.org>
References: <20230810171429.31759-1-jack@suse.cz>
 <20230811110504.27514-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811110504.27514-2-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 01:04:33PM +0200, Jan Kara wrote:
> +	blk_mode_t open_mode = ((struct bdev_handle *)file->private_data)->mode;

Nit: but I find it much more readable to just have a local bdev_handle
variable vs these deep references including casts.  This also appears
in a few others places.

