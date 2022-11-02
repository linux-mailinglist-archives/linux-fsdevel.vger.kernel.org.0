Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8D0615CE8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 08:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKBHYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 03:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKBHYn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:24:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4511B786;
        Wed,  2 Nov 2022 00:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Yz6pvyqbPpbsrQ0RUrlruDe92Wxq+xuAovpeb4Bn9c=; b=zoMP6UiryjOxZVC7p0952HtF1K
        kFATm++ELCKq5oaxBPjQT4d9HvwZdti4oibBXKwFW78yRRFIFDf0DJfxjVZ0evbH+L844jKD6/lro
        IMcm6JU7Z8CREhmgGfhZl6q4dNciCZS9xwPA2qxL/b5qWS+bGc8IuxNa3OBn7U3Q3r3fq5vh8PFTH
        GD7PuaktHQWxuZhesup3WQnsF6GXBgSKT9JYT2gQ99oDj8IziBAM+CtdR0Diz7lSfSppg5CsEOX55
        ONieOZRjJccaoZ4M8csOg243t9yq5/iRk2/X6bpC/MUGJJx++fByBl1vMsT6lX61MFcsAnye4C0i1
        EmBGiZTQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oq878-008cMR-66; Wed, 02 Nov 2022 07:24:42 +0000
Date:   Wed, 2 Nov 2022 00:24:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/7] xfs: buffered write failure should not truncate the
 page cache
Message-ID: <Y2IbOl9hI7knhcDT@infradead.org>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-5-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101003412.3842572-5-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just a little dumb question while I'm wrapping my head around the change
here - why do we even punch the pagecache to start with?  As long as the
regions that we failed to write to aren't marked uptdate (at the page
or block level for sub-block writes), who cares if they remain in the
page cache for now?
