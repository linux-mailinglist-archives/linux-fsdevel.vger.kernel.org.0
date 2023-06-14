Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EDF730206
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 16:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245632AbjFNObx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 10:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245624AbjFNObw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:31:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCF926BE;
        Wed, 14 Jun 2023 07:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Dp/dkBGe6huxwiDvc3Iwhr4vC3Fbj+wsKHF1NgYARg=; b=3XEDS1LNaydvAHOpsRefpgycX0
        N6omlVnRVoaB07iZgR+boPt0KR07GnGAtkRk4HpE+clHzc9mfu1nFzCCVmKAX+4AhAD2hxl73a2T8
        Fm5U3ukagK7dkB96hDvS8jklMaeBWg76Q3mE2SoNc9cIM889Vlb2OwhAjRhjsR0fRtLbVhrZD2amI
        bmIoLIYgRuzyDFLVxZvrNVdUSysveRF3P9sCPI9Ch+Mwrqr7yfCAtl5nhTz+FVjFvh5LWmRqUwTzl
        NmuCf3UBTP1y4VwwgYp7SYv0TpY6b1E5iTlnDDycdSRdeihtUC7byaOcdxsa0YkD0Hf7vX5uqjCZv
        CRT5dDjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9RWr-00Buzx-2s;
        Wed, 14 Jun 2023 14:31:21 +0000
Date:   Wed, 14 Jun 2023 07:31:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <ZInPOR+1jN8VN0mA@infradead.org>
References: <20230612161614.10302-1-jack@suse.cz>
 <ZIf6RrbeyZVXBRhm@infradead.org>
 <CACT4Y+ZsN3wemvGLVyNWj9zjykGwcHoy581w7GuAHGpAj1YLxg@mail.gmail.com>
 <ZIlphqM9cpruwU6m@infradead.org>
 <20230614-anstalt-gepfercht-affd490e6544@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614-anstalt-gepfercht-affd490e6544@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:18:16AM +0200, Christian Brauner wrote:
> > I'm fine with a config option enforcing write blocking for any
> > BLK_OPEN_EXCL open.  Maybe the way to it is to:
> > 
> >  a) have an option to prevent any writes to exclusive openers, including
> >     a run-time version to enable it
> 
> I really would wish we don't make this runtime configurable. Build time
> and boot time yes but toggling it at runtime makes this already a lot
> less interesting.

With run time I really mean not compile time aka boot time.  Sorry for
not being precise.
