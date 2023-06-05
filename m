Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343B5721F3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 09:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjFEHNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 03:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjFEHNl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:13:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757AEE78;
        Mon,  5 Jun 2023 00:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=24NtoYhKvZ49mRzAxCPfQuGcFIxKUXmj4oYlBfA1+No=; b=HmTaFC7HfXqOAdPtQr2UennWQN
        wwqjqQyMVixk17VL+BUOwDd6w6dwkss7xDDAMuG/mx8cZY7xDZu3F7REOnh+VJiviA7vUZQf0WAKO
        N4lZHeg6BVOqRX/a8HGOP/o23sZu29LYTG07bvJ+IYmzPyJQIyHBKW+R8tioNdiRnVHkna/n1CUOx
        Py15OAhy3VRhqqCqI8gTG/rg1eWiwtsYG7Zci7/nC0+X85jmwZpKPtuPQcepYdByPva7tsEAZbTJl
        TtF/UVopNdpvsIQjbqj/cfODEjvwdH/XJltP9Gm1UFv3qaSzUoxDOh7+4zRgR7wlAa89jjze1vvvz
        jOKA60xQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q64P0-00EVwR-0p;
        Mon, 05 Jun 2023 07:13:18 +0000
Date:   Mon, 5 Jun 2023 00:13:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 3/7] iomap: Remove unnecessary test from
 iomap_release_folio()
Message-ID: <ZH2LDjrBjajOSDB+@infradead.org>
References: <20230602222445.2284892-1-willy@infradead.org>
 <20230602222445.2284892-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602222445.2284892-4-willy@infradead.org>
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

> -	 * dirty folios to ->release_folio() via shrink_active_list();
> -	 * skip those here.
> +	 * If the folio is dirty, we refuse to release our metadata because
> +	 * it may be partially dirty (FIXME, add a test for that).

I'd prefer not to add this FIXME as we're fine without the per-block
dirty tracking.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
