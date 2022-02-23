Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F3A4C0CFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 08:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbiBWHFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 02:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiBWHFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:05:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF666E572
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 23:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cDUaIno7jBJKeu7mS2+SwFUHeC3QWUkMUDTqJA3HOIo=; b=A2qq2upN49N63i8kOk8wlETT4+
        ALqSIiN15v1U7GdbJTTNwty/TcZvW73UmtGAHod8F4UbR1YRRqzzBUPPzJDRdifeh2oWBR5cMKogL
        ++b8vpGuFPzgexzdPvBWq3R49EEG3zobUF6DMrAjoBWKJMZN/Vz+VsRR6Tu9JEyDTB5TMr0jm5fuI
        kyE7S1fiVVysDBY3+fuhxpPMcDM7rlwjFKJws/pq1SdMQjFjgSwVhu/Mhz1UL1O9/qy4izOh4AaD7
        QNk18QpPWJQSVJlA7RKfXHd8Dzsf2vOvuKyG/m4WbRIPG/IZFBIvbQhl2Mc6tsL2hA8l+3p5isbz2
        VXb74yLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMli1-00D4Oh-Tv; Wed, 23 Feb 2022 07:05:09 +0000
Date:   Tue, 22 Feb 2022 23:05:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/22] affs: Use pagecache_write_begin() &
 pagecache_write_end()
Message-ID: <YhXcpUdSiWAGHvYz@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-20-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-20-willy@infradead.org>
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

On Tue, Feb 22, 2022 at 07:48:17PM +0000, Matthew Wilcox (Oracle) wrote:
> Use the convenience wrappers instead of invoking ->write_begin and
> ->write_end directly.

I'd much rather call the actual implementation used by affs directly.
Same for the following patch.
