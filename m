Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D912724231
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 14:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjFFMct (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 08:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjFFMcs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:32:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E34E62
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 05:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=C7m4d9Qn99Rb7YO8T2udnXvOV6EByBtoiD76wfpbXFw=; b=RWzIu63wtcZwg5DWtIjKGKiNaY
        4kxG1H7pZ/xMq07nC7n6B8AQhjr0wTQa+uEN0GjOQAaAic8TXHOBxjHisJSCjNfbkD2iPVo1NegMi
        W43WDZe+pTkFPMeSKVLLsAMQebseUI0eyG/hfcRBqXB+CnxWJqLs00QCtASkeOQEfslgcQnp/yM++
        NL11d4TO0GtM46eOWH4p+LscJMHsn4TK591Egt+CkbJ6bfLeER00MHmP8jSGnYcIlo+cXrcZnBmab
        rnihlMN5tBto6p0ifXc+9trms8ItKlyO12423vO+JXjm14Ngslb2jOlqAyhGq7j8rtjaxyIoKQgU7
        beJ4zT+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6Vrf-00D8au-BI; Tue, 06 Jun 2023 12:32:43 +0000
Date:   Tue, 6 Jun 2023 13:32:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/4] ubifs: Convert do_writepage() to take a folio
Message-ID: <ZH8na21G0W8kmY5r@casper.infradead.org>
References: <20230605165029.2908304-1-willy@infradead.org>
 <20230605165029.2908304-5-willy@infradead.org>
 <2059298337.3685966.1686001020185.JavaMail.zimbra@nod.at>
 <ZH6mixCMHce1S+vK@casper.infradead.org>
 <406990820.3686390.1686032035024.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <406990820.3686390.1686032035024.JavaMail.zimbra@nod.at>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:13:55AM +0200, Richard Weinberger wrote:
> Matthew,
> 
> ----- Ursprüngliche Mail -----
> > Von: "Matthew Wilcox" <willy@infradead.org>
> > len is folio_size(), which is not 0.
> > 
> >        len = offset_in_folio(folio, i_size);
> 
> offset_in_folio(folio, i_size) can give 0.

Oh!  There is a bug, because it shouldn't get here!

        /* Is the folio fully inside i_size? */
        if (folio_pos(folio) + len < i_size) {

should be:

        /* Is the folio fully inside i_size? */
        if (folio_pos(folio) + len <= i_size) {

right?  Consider a file with i_size 4096.  its single-page folio will
have a pos of 0 and a length of 4096.  so it should be written back by
the first call to do_writepage(), not the case where the folio straddles
i_size.

