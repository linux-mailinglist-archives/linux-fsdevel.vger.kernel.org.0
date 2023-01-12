Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679B6666BA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 08:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbjALHdw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 02:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbjALHdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:33:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6E8FEC;
        Wed, 11 Jan 2023 23:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=npk4twvt/nyxYb9+XqMeG2aG/rkeJ5k7hRSljU/tAPY=; b=mtGpkiv5ilgLs4fOmqdxnDPVXS
        tTCPUeQI5+eVazcZazs0mL3NJM5pcvAEye/NPA2XkjWQDgo6C/ZC8HdUWnxpZyDddeI2U8rv2fUup
        yurg7Y0/PXJSj2n5MyuBP+QEZydw1taCNo0cPAJnpDkM6crwv7cexi+/t2wcVNBC8D3u2oNimA7F7
        Kr7+o51jZ5txYIZdoCC9P51XzdomLedDHopPnsvD9vG+eFsJSj6V9vfAW1+CEu/xI5r+6HvDKSfbR
        xP1L4aNzIDVT8dMp4jV7pWkkliAyomcoNSmGGwLE5dR4mGeecvGNcSWjfi+ekDckqcNW3VLpe0vq3
        2FUNheyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFs5o-00E1Ar-VK; Thu, 12 Jan 2023 07:33:44 +0000
Date:   Wed, 11 Jan 2023 23:33:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 9/9] bio: Fix bio_flagged() so that it can be combined
Message-ID: <Y7+32CLLte7elbNi@infradead.org>
References: <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
 <167344732239.2425628.14636562879255014501.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167344732239.2425628.14636562879255014501.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I find the subject a little weird.  What you're doing is to clean up
the C version, which also tends to micro-optimize the x86 assembly
generation for a specifi compiler.  Which is good on two counts, so I'm
all for the patch, but I don't really think it's "combining", which
really made me think of testing two flags in one call.
