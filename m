Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1AF70DD92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 15:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbjEWNhY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 09:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjEWNhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 09:37:23 -0400
X-Greylist: delayed 180 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 06:37:17 PDT
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42D2118
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kw4TxwgeOi/rgp7Fv4+clTuRK+8n6ArCGyls+zA2GjQ=; b=HN7yEl2WJmTwshKzFofUhypEzx
        upP9zsmNiDzNoxT7vRn+3LsT4nR+6BQDei6If4c2ybkmfAiBuTrCApsiQxSd0XCmDFjRGD/X9Z8PK
        p76yKGDZNlh2j28FxLDSCiJWmgNyWS1Bme3zTF2qmqJZ6h+4LtLvEa9ZIGjs8WFy50+z/tdjT1xTM
        S+PWq92h9y8DPIjZn13jNHOKHKi6NpoxBlNDyCVwGMCtTmZLK00oOEtB+hwRGDH5oUUm2Esf48Ly0
        QsVpBR4lLjFzWi764Qp3xYK4wGVDZMYewvveWhoFppuwJfC1KGU/Zt2ZGlFVcygsNM+i8hLmKGFs3
        khj2rAGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q1SCQ-00AG4x-QM; Tue, 23 May 2023 13:37:14 +0000
Date:   Tue, 23 May 2023 14:37:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com,
        Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 5/6] gfs2: Support ludicrously large folios in
 gfs2_trans_add_databufs()
Message-ID: <ZGzBikVAWeXOmGQd@casper.infradead.org>
References: <20230517032442.1135379-1-willy@infradead.org>
 <20230517032442.1135379-6-willy@infradead.org>
 <CAHc6FU6GowpTfX-MgRiqqwZZJ0r-85C9exc2pNkBkySCGUT0FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU6GowpTfX-MgRiqqwZZJ0r-85C9exc2pNkBkySCGUT0FA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 02:46:07PM +0200, Andreas Gruenbacher wrote:
> >  void gfs2_trans_add_databufs(struct gfs2_inode *ip, struct folio *folio,
> > -                            unsigned int from, unsigned int len)
> > +                            size_t from, size_t len)
> >  {
> >         struct buffer_head *head = folio_buffers(folio);
> >         unsigned int bsize = head->b_size;
> 
> This only makes sense if the to, start, and end variables in
> gfs2_trans_add_databufs() are changed from unsigned int to size_t as
> well.

The history of this patch is that I started doing conversions from page
-> folio in gfs2, then you came out with a very similar series.  This
patch is the remainder after rebasing my patches on yours.  So we can
either drop this patch or just apply it.  I wasn't making a concerted
effort to make gfs2 support 4GB+ sized folios, it's just part of the
conversion that I do.

> >  extern void gfs2_trans_add_databufs(struct gfs2_inode *ip, struct folio *folio,
> > -                                   unsigned int from, unsigned int len);
> > +                                   size_t from, size_t len);
