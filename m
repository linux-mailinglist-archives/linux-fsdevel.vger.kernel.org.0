Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551034ED9AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 14:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiCaMfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 08:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiCaMfr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:35:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C5645538
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Mar 2022 05:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q8dAAlXPAV5MSnMqgqFJVKAtg1CilWhInDgurOi1UcQ=; b=J0dG7w6GfvkhTZQLPKNv5Jv6S7
        /VmBzCB8Pv2AXuJX+r+NawgC6YS1+YkFf3XsQ/6/s9mqsSxoQdwJMBYio5AuC9MTYt8d3stokPG1k
        LnQ/aNMQ3txBCX26srD2ZIsCfkj3K4DXBAZIZWRsJGaiD7IGWbje5HJ9HWfTJGuPemce0H9qihiAq
        49teuuzdbMsvEztxA70Z9HXrch4RwitDqN+Sg1NYe6pW4Br2orUVb1DXO0kqcfL2ZDIg0f4l9yPnR
        1vSbQr9DNqxfDW8XsdEISn3Q0R8R3+gPpss+4SBiYCfW9HbyoD3Iquo7MzL08uza1es40uiuVfxhk
        Pj1Rz06w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZtzx-002FKy-LG; Thu, 31 Mar 2022 12:33:57 +0000
Date:   Thu, 31 Mar 2022 05:33:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/12] iomap: Simplify is_partially_uptodate a little
Message-ID: <YkWftaaQ8m61UghH@infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
 <20220330144930.315951-4-willy@infradead.org>
 <YkRum3GLyIrYdSgX@infradead.org>
 <YkR+lYvqcsFzkC4X@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkR+lYvqcsFzkC4X@casper.infradead.org>
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

On Wed, Mar 30, 2022 at 05:00:21PM +0100, Matthew Wilcox wrote:
> On Wed, Mar 30, 2022 at 07:52:11AM -0700, Christoph Hellwig wrote:
> > On Wed, Mar 30, 2022 at 03:49:21PM +0100, Matthew Wilcox (Oracle) wrote:
> > > Remove the unnecessary variable 'len' and fix a comment to refer to
> > > the folio instead of the page.
> > 
> > I'd rather keep the len name instead of count, but either way this looks
> > ok:
> 
> Heh, that was the way I did it first.  But block_is_partially_uptodate()
> uses 'count', include/linux/fs.h calls it 'count' and one of the two
> callers in mm/filemap.c calls it 'count', so I thought it was probably
> best to not call it len.

As said I'm fine either way, but len seems more descriptiv here.
