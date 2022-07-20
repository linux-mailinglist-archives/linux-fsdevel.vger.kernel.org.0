Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9BD57BB10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiGTQGi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 12:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGTQGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:06:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AC92BB23;
        Wed, 20 Jul 2022 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=om8igKivCP5XVZgyhEUjQhwHvFBHsWpIEztRwfONss0=; b=m2RAMuJBVok9ymb+Hr0TEhVomd
        3d7j694mo09M1D98WK7G1jTc9QtndojVCN7TJeF1ZRpXJN/u9vKAYYhp0S1uS6HM3udhEvor37pnT
        qexCrQ5tAt588EDQ6loC1JrL4vfYDpLgmn6xG/Nwp54uaGfn70+UL4xd4otIVBF6Nz5ZWyxJUj6oq
        XiQfro6SVkB/5kyqpm6Lq1f4vmNFbyukwXnh4fru1IKpBU4CroZk+EYlrKZEvVRb9AYoSG6K1Qn21
        p3GN+4ZDmXOTE+3xie0yifv97Y/ogaVrykgatzQKP8zD1s9Tcoq/lD80cA1S49qjUNnceJcktjO5H
        PHED46jQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oECDO-007xT4-0U; Wed, 20 Jul 2022 16:06:22 +0000
Date:   Wed, 20 Jul 2022 09:06:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Lukas Czerner <lczerner@redhat.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: should we make "-o iversion" the default on ext4 ?
Message-ID: <Ytgn/eB1w14kPji8@infradead.org>
References: <69ac1d3ef0f63b309204a570ef4922d2684ed7f9.camel@kernel.org>
 <20220720141546.46l2d7bxwukjhtl7@fedora>
 <ad7218a41fa8ac26911a9ccb79c87609d4279fea.camel@kernel.org>
 <BAFC8295-B629-49DB-A381-DD592182055D@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAFC8295-B629-49DB-A381-DD592182055D@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 11:56:12AM -0400, Benjamin Coddington wrote:
> > Another idea would be to introduce new mount options for this, but
> > that's kind of nasty from a UI standpoint.
> 
> Is it safe to set SB_I_VERSION at export time?  If so, export_operations
> could grow an ->enable_iversion().

No, it's not.  Think of unexporting, modifying thing and re-exporting
and now the client will see the same change counter for a modified
file.
