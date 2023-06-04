Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10164721A67
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jun 2023 23:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjFDVsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 17:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjFDVsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 17:48:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A497BA6;
        Sun,  4 Jun 2023 14:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=gILJMJ7zAX5FszlXmfmXwAcEe3qX1qwR2lF0jBMnNmU=; b=H+cunD92N3eO7OaGb20Kd9Y3U1
        2ZKayg3bWpHtA1Df1gMo3Zml5lDSsUl8I+gCJbiTbCQ6jlRukxCohnk4FMoXBOTX09K6Rvcov+nc0
        aHUgpfp/QpWw5GpxuXt8ocCPCtdEFiEu8ZoahhON2VSmneov7n2mSHSg75ZFNyOD26v7BNsBdIrOC
        YDxrespc413EPtmgNgqot+PZzdAxYI7eHHurvYGeW7UMCs1yOfkaEiMPyWRjH3G1Hp/vTgunApY1D
        onN5BgTrpDMXMZU3y3XN4iY4NlauEdbWAkAra36AacZsK+Y/5Ic0LRaV7Iir1kYNLpZ+jB5IuBwhe
        4UXu5/DA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q5vah-00BNeK-4Z; Sun, 04 Jun 2023 21:48:47 +0000
Date:   Sun, 4 Jun 2023 22:48:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 5/7] filemap: Allow __filemap_get_folio to allocate
 large folios
Message-ID: <ZH0GvxAdw1RO2Shr@casper.infradead.org>
References: <20230602222445.2284892-1-willy@infradead.org>
 <20230602222445.2284892-6-willy@infradead.org>
 <20230604180925.GF72241@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230604180925.GF72241@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 04, 2023 at 11:09:25AM -0700, Darrick J. Wong wrote:
> On Fri, Jun 02, 2023 at 11:24:42PM +0100, Matthew Wilcox (Oracle) wrote:
> > +		do {
> > +			err = -ENOMEM;
> > +			if (order == 1)
> > +				order = 0;
> 
> Doesn't this interrupt the scale-down progression 2M -> 1M -> 512K ->
> 256K -> 128K -> 64K -> 32K -> 16K -> 4k?  What if I want 8k folios?

You can't have order-1 file/anon folios.  We have deferred_list in the
third page, so we have to have at least three pages in every large folio.
I forget exactly what it's used for; maybe there's a way to do without
it, but for now that's the rule.
