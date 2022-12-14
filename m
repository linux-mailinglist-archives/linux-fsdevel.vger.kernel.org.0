Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B77264C473
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 08:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbiLNHkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 02:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbiLNHkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 02:40:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8E517A8D;
        Tue, 13 Dec 2022 23:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+nxD7XdSw3U/Ra/8yIJ5YBegpzleiXNCdwiUk3c3++k=; b=OixfO7pZRvWbKad+xSV532iJ9m
        2oaray3qDFZzyIqw/1Tpd6zrvTGtlfFdeZdnwHvKkXpnDPkpytIGx39Amd7a/1UJdx/ArbWK5Lwhk
        VP3fDytHPDDkjwRROlLR98jzZoF39PXcfcKXIajWjNzkYhbY/adtf7WaxR5G0p88GlSsSJAOulagS
        AeYUvdf4a1UfF5BdX18GImq82Xxpg/lF9illYxoKXcfRxJ/m4dAuA/nGwD1ZeKHIdwlsOGw+AzuNh
        eUlBa96bp41vx0pcPPD52wPjQmyl1eOq+hHVVGJetXTtoXgU6ROVJwI2Za1mlVJS6Z0fHXXOp/ujs
        /xNxcRFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5MMw-00E8DI-Im; Wed, 14 Dec 2022 07:39:58 +0000
Date:   Tue, 13 Dec 2022 23:39:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Move page_done callback under the folio lock
Message-ID: <Y5l9zhhyOE+RNVgO@infradead.org>
References: <20221213194833.1636649-1-agruenba@redhat.com>
 <Y5janUs2/29XZRbc@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5janUs2/29XZRbc@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 12:03:41PM -0800, Darrick J. Wong wrote:
> On Tue, Dec 13, 2022 at 08:48:33PM +0100, Andreas Gruenbacher wrote:
> > Hi Darrick,
> > 
> > I'd like to get the following iomap change into this merge window.  This
> > only affects gfs2, so I can push it as part of the gfs2 updates if you
> > don't mind, provided that I'll get your Reviewed-by confirmation.
> > Otherwise, if you'd prefer to pass this through the xfs tree, could you
> > please take it?
> 
> I don't mind you pushing changes to ->page_done through the gfs2 tree,
> but don't you need to move the other callsite at the bottom of
> iomap_write_begin?

Yes.  And if we touch this anyway it really should switch to passing
a folio, which also nicely breaks any in progress code (if there is any)
and makes them notice the change.

That being said, do you mean 6.2 with "this window"?  Unless the gfs2
changes are a critical bug fix, I don't think Linux will take them if
applied after 6.1 was released.
