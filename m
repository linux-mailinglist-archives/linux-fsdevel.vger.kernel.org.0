Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F2F5358DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 07:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243509AbiE0FqZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 01:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiE0FqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 01:46:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71C9322
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 22:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VDmChBWljedoEkok5R0TCyduHzHyVq8JxgfKEHTfMDU=; b=Ba72R98mKRQz3+YlxvTHsh9Gd9
        OgbsEJiZ3v+xWXfPrBc3S0v/CgbZsMdn/HkK49qZmODsi1xIPmQPyZd7b6noR+T5lNkQIzPUgTQN3
        RbeQGSXCj365K+RWZzcjqO6k7DA5z01Mi5nipbD1WCfFplsnIl0GCiuP7CmMNt73/9jWflBdCLiFG
        8u8jBscvrDlxTrDBTJGWHO2qZZxpL1I5oj57C8Q023xxT581nt6wbBO7f2Yd+kjIR+vQYL0ycO5NJ
        KpIb+HqRGw7AVBo4uXoOX6BmgIfCGMfJQ9d0V3HspUBSld6Wxo+2kj8pMN0Ofb5M/f8D5RTy1N2i3
        QZu3NfQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuSnj-00GhRg-Ro; Fri, 27 May 2022 05:46:19 +0000
Date:   Thu, 26 May 2022 22:46:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [RFC PATCH 8/9] jfs: Write quota through the page cache
Message-ID: <YpBlq+Tvp9dFuK5d@infradead.org>
References: <20220526192910.357055-1-willy@infradead.org>
 <20220526192910.357055-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526192910.357055-9-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 26, 2022 at 08:29:09PM +0100, Matthew Wilcox (Oracle) wrote:
> +			folio = __filemap_get_folio(mapping, index,
> +					FGP_CREAT|FGP_WRITE, GFP_KERNEL);

missing spaces.

> +		folio_lock(folio);
> +		dst = kmap_local_folio(folio, offset_in_folio(folio, pos));
> +		memcpy(dst, data, tocopy);

mecpy_to_folio would be nice here.

And gain the helper seems generic, but unlike the read side modern
file system often want some kind of journaling.  Not sure if it is worth
sharing it just for ext2 and jfs.
