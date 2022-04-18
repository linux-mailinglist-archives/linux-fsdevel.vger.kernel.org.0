Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA2B504C30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 07:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiDRFRn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 01:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiDRFRl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 01:17:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B8438AB;
        Sun, 17 Apr 2022 22:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=05bZopyuY2vKFmqnP3FA43TKOlvN0o/huqGPlzbxCOA=; b=1WAbili0haVJfedFeVXuHME/Yx
        JAzOOShmc9CNBO+MVWYoIkJCSGQIEitVTTTQEKSJV6MDMEpgSdytDkq592jPAFG5Y+zNgld6Fu318
        Yq/YCGGokVE+yD41LhzWuMSKPHR/zrYIkHd7PoqjrQ/QxU6Cg8XJzkYb9N5mUrizyaTC6fWP+sPAn
        xbo8V4u9ZTndhm4BXL2FVwQqk4tMCJJn+/zJCD+yi/nM7rBqqdfnJufA/vUAtX8vIMlSLtsRI0h5V
        YPwLOBEtq6Uj9h4z+GyEz7DjCkGrq/OT+DOytfjFnJGQXUzAFIY+KHMK1kCk0CBgjZ2pHtqH9LuBM
        NwdRO5MA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngJiz-00Fdw6-SN; Mon, 18 Apr 2022 05:14:57 +0000
Date:   Sun, 17 Apr 2022 22:14:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] block: add filemap_invalidate_lock_killable()
Message-ID: <Ylzz0bbN1y3OFABI@infradead.org>
References: <ff8f59e5-7699-0ccd-4da3-a34aa934a16b@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff8f59e5-7699-0ccd-4da3-a34aa934a16b@I-love.SAKURA.ne.jp>
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

I'm starting to sound like a broken record as I'm stating it the third
time now, but: 

no, this does not in any way fix the problem of holding the invalidate
lock over long running I/O.  It just does ease the symptoms in the least
important but apparently visible to you caller.

What we need to do is to get the zeroing I/O out from under the
invalidate lock, just like how we don't do direct I/O under it.
