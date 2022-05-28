Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B833536B02
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 08:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbiE1GAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 02:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiE1GA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 02:00:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910DB2A7
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 23:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dNey4vA+3fR/UAM+M+UFSsVzwmKTtoszlzMQg3hwkYE=; b=qqEpBeY5gZpjtbLey2DsvJIXg1
        X6lD0JBn1tW8k7Z11sdHQwtEdGJjlijBpQ+Gcq8wkJgD1ZI9weW4vxdBG09OEWsIYN9pXThplYXRe
        VTxWLq/Ri+Qo0tc8c/iil55zCGCxzvXN7zR4eggEcxrT8rpZ3SoEqUo9VdKn6BSWGqOSdajwY2gGR
        XWZxHuU3DQRUCDSOOU7uReDagcxWT1xULJ+EXqtLeHhIC4Dn2xbM4wfYZm15hdEW+ZlShJjeQgJO/
        Lcq1H+Ds5VhzwvgRj3GjwNSuXtSgE/TwowotDcQT3PNqzbeB8+rj9KOA1pW9Tcro1CKlwV7EiBC6R
        93PAXolw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupUx-001Wj4-7g; Sat, 28 May 2022 06:00:27 +0000
Date:   Fri, 27 May 2022 23:00:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 16/24] iomap: Remove test for folio error
Message-ID: <YpG6e8bj24DZDJ8i@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-17-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:28PM +0100, Matthew Wilcox (Oracle) wrote:
> Just because there has been a read error doesn't mean we should avoid
> marking this part of the folio as uptodate.  Indeed, it may overwrite
> the error part of the folio and let us mark the entire folio uptodate.

This does look sensible, but I'm a little worried about this area.

Did this survive an xfstests run with a sub-pagesize blocksize file
system?
