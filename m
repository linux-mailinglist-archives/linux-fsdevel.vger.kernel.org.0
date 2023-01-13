Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BE9668B67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 06:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjAMFdp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 00:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjAMFdI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:33:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ECC61455;
        Thu, 12 Jan 2023 21:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ysUCfBrwMEP/gKZvWSb1F9GpsO921UxR4IBhrY7rzmA=; b=eltYYegCYuaDF2OLOCNenA+MS/
        CJY5LRGNK7trbl5wIFc0/jpq68bC42ljrQTOspX75Hp68CeUs1QkBOGhmXiibOwzcjfwLKcbRCE3n
        ZrzmSarQSHrbj2S386A5nT0taBrT0f/aLoevjW2ry1LTgYwZoLG9UoBOTzmdbM44wm1BOxrBlEZKq
        NcJUVUPWW+PMc4rV5dFTjppnd7Q7yYiYqKVPJhT1xLiw9FYUsUzQuEBAJ77Vt4Fqvwz9/qQ1X7tPI
        tQl9Y1rrZ8Pb611cAL01E3KI95x43t8T1Ev+cjwDGx/z/Ex3fTnZbqSnlIqoVhTQesqt9AhOrWZXE
        Gd0RVsYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGCgW-000VVZ-C9; Fri, 13 Jan 2023 05:33:00 +0000
Date:   Thu, 12 Jan 2023 21:33:00 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/9] iov_iter: Use IOCB/IOMAP_WRITE if available
 rather than iterator direction
Message-ID: <Y8DtDDZSWcrfLmy/@infradead.org>
References: <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
 <167344727810.2425628.4715663653893036683.stgit@warthog.procyon.org.uk>
 <Y8CCCQLrm9vshGw0@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8CCCQLrm9vshGw0@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 12, 2023 at 09:56:25PM +0000, Al Viro wrote:
> Incidentally, I'd suggest iocb_is_write(iocb) - just look at the amount of
> places where you end up with clumsy parentheses...

Agreed, a little helper won't hurt.
