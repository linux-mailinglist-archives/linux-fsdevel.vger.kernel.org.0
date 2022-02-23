Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BD04C0CCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 07:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbiBWGxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 01:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbiBWGxu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:53:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EE66E4D0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 22:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bqrsO+1BfmJt/M7GbxkxlyKXg+KMnI/851kxWleNmSA=; b=mqWuw8g3pN8WJSoblGKAUvlFGF
        GOD1meLEy+79F3la+r5p5MHKrz7IN9B/3m2KfGo7N9MTTDdQos+mr/a1+MJhbvitinWd5FFpW265j
        UIv0Sc5VuW72v7PUlDylRhQ/rD8LYaZ3KQ/s86AtQwedr2UT+0f9ENbkaDgoOpJtb5uFQcFWcp2Dx
        uLwjJXDyFtRZI8pobOto+LirRNWgMrfgs3T7ZUz3M5CEU3DxH0JrMw1tk5QKSpy8VMA3XJ6bcBEfy
        L+Qz2X+Mv8cC1OU9+/l2tPFCFDfmAhpfPltdpFafw2+p5GghC6jdRxPLyUH5FxaI0VeOrox099OVM
        X4Ouy5ww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMlWd-00D2zz-IN; Wed, 23 Feb 2022 06:53:23 +0000
Date:   Tue, 22 Feb 2022 22:53:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/22] fs: Move pagecache_write_begin() and
 pagecache_write_end()
Message-ID: <YhXZ41GJwCvKg5GI@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-3-willy@infradead.org>
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

On Tue, Feb 22, 2022 at 07:48:00PM +0000, Matthew Wilcox (Oracle) wrote:
> These functions are now simple enough to be static inlines.  They
> should also be in pagemap.h instead of fs.h because they're
> pagecache functions.

I wonder if we should keep them at all.  For the core fs code calling
the methods directly seems perfectly fine.  And the calles in the file
systems should just call the implementations and avoid the indirection.

And the callers in i915 look very suspicious.
