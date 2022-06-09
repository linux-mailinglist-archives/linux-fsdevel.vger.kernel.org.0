Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3DB544235
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 05:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbiFIDzJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 23:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiFIDzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:55:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0879204;
        Wed,  8 Jun 2022 20:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0YPt1S1jhSTaWf/8ZoCL0bFChcDXSklVsTmgZM2rLiI=; b=Dl8JGvKpB6vphg8GJGusCTANit
        1GxyGnn679NvRWS0MV6dl/ia8FXbFkazmnr+IDjn5zzr3og7XZfjMLZjWL06OF3evRoMrBFjxFrsx
        Htg+vfwV+x7T9mmYPRX8P6cJKrK8y0bBndusBU0lXk/KdOK8xByq3REx/zxGsoZUuF/x5DHkNPje8
        NDEHhrWuv4dfciQdbKDCDBmbUI7HxHBS2K/veQeFd3r7wooBpR0eTx87J+TG8yrH1ANVnPBJkU+b9
        h1sAP8J3H9vbFRWHN3eOBnx3OSPTyjl+SZp0lSY+nu4GUzBF+V4Qw/fg17+wG32FZfTnYTo9p6g96
        gaHUWy6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nz9GE-00G0Iz-DU; Thu, 09 Jun 2022 03:55:06 +0000
Date:   Wed, 8 Jun 2022 20:55:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 03/10] ext4: Convert mpage_release_unused_pages() to use
 filemap_get_folios()
Message-ID: <YqFvGgKTyGPxStkx@infradead.org>
References: <20220605193854.2371230-1-willy@infradead.org>
 <20220605193854.2371230-4-willy@infradead.org>
 <YqBXjjkRZsP8K8fO@infradead.org>
 <YqDIIH2d7iu1o7D0@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqDIIH2d7iu1o7D0@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 08, 2022 at 05:02:40PM +0100, Matthew Wilcox wrote:
> On Wed, Jun 08, 2022 at 01:02:22AM -0700, Christoph Hellwig wrote:
> > On Sun, Jun 05, 2022 at 08:38:47PM +0100, Matthew Wilcox (Oracle) wrote:
> > > If the folio is large, it may overlap the beginning or end of the
> > > unused range.  If it does, we need to avoid invalidating it.
> > 
> > It's never going to be larger for ext4, is it?  But either way,
> > those precautions looks fine.
> 
> I don't want to say "never".  Today, it's not, but if ext4 ever does
> gain support for large folios, then this is a precaution it will need
> to take.  I'm trying not to leave traps when I do conversions.

FYI, this wasn't an objection to the patch, just a hint that the commit
log could spell this out a bit better.

