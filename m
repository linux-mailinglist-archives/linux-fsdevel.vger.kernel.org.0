Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B766E24BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjDNNwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 09:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjDNNwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:52:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B225EA249;
        Fri, 14 Apr 2023 06:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H6yVqe3+TZhy1SSy1fKm7kd3A50sGl37oZqxB01zGlU=; b=QncjLKTKiy0uzEpGNicbWTEO2r
        XWMiZJgDerXO7NYny0kfXUwV1YDKgjyK7BCCmiJitTWFelmEcfLN7dQqrHQ8QCvctnbfoUd9XuGVC
        hY9AmZBK4rpVuv+4a+o3C0mwWu8Fwcggyl8Gvoz6snXv9SnUCt+kLMHXXln3NybhOgfQhxXJNWIlZ
        XB9U9Kbib+hqF2UnDc03Y9NMR8GFsodUuAupozc0+EJod/g9S/0xh2/pHyp/KmYc4o053PKdZuopM
        jz0AFQRcZ2Q3ortfwFg0SlL8MHMApzalM08RbAR9KkuoewS3uRCRVAE3+zaSxyg+Vu4hpMkw+BFry
        thWVFksQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnJpw-008nNL-E8; Fri, 14 Apr 2023 13:51:36 +0000
Date:   Fri, 14 Apr 2023 14:51:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Message-ID: <ZDlaaJxjXFbh+xSI@casper.infradead.org>
References: <CGME20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d@eucas1p1.samsung.com>
 <20230414110821.21548-1-p.raghav@samsung.com>
 <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 03:47:13PM +0200, Hannes Reinecke wrote:
> BTW; I've got another patch replacing 'writepage' with 'write_folio'
> (and the corresponding argument update). Is that a direction you want to go?

No; ->writepage is being deleted.  It's already gone from ext4 and xfs.
