Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16324633CFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 13:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiKVM7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 07:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKVM7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:59:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A19661B9F
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 04:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i57W19x5PXh8Z3pxQkjTS0ujZiYLHbcoZpQUee7crUs=; b=prla3oClXlJySOqAiMwQyq6HbW
        ri297PC3xL/8GS4SFeW6Y+6QZILiqmuexwlK01g5n021bKE9edQRIFm3R+N/oSAoxnrCRT/DZQYHH
        tXOUnfXKZrGNcRib0T6J75PIUtSX9RATZK+mTw7mcGNiAp0MSkEcJXgMboLX8BSZe+kkzxqi3qmm/
        yl2FD5b7y9SwQCBcn8u5VCabEhSkRorvgZ0wuZ4EuC1M/nsUpmcHC2u9dH4N96JYyjymjcQuFMffq
        mWTEGvJ86gxPDkhr4bzx+Lga2YxMYaDsR+IO/AuI11bzbDKDnnSfe+JuvhtlyRPEQgzcNPoxwiJ8W
        ajFxHl7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxSrn-009Scv-M7; Tue, 22 Nov 2022 12:59:11 +0000
Date:   Tue, 22 Nov 2022 04:59:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Lukas Czerner <lczerner@redhat.com>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.com>,
        Eric Sandeen <sandeen@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] quota: add quota in-memory format support
Message-ID: <Y3zHn4egPhwMRcDE@infradead.org>
References: <20221121142854.91109-1-lczerner@redhat.com>
 <20221121142854.91109-2-lczerner@redhat.com>
 <Y3u54l2CVapQmK/w@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3u54l2CVapQmK/w@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 09:48:18AM -0800, Darrick J. Wong wrote:
> Would it be wise to "persist" dquot contents to a (private) tmpfs file
> to facilitate incore dquot reclaim?  The tmpfs file data can be paged
> out, or even punched if all the dquot records in that page go back to
> default settings.

That seems like a good idea for memory usage, but I think this might
also make the code much simpler, as that just requires fairly trivial
quota_read and quota_write methods in the shmem code instead of new
support for an in-memory quota file.
