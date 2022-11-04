Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CAF61926C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 09:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiKDIIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 04:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKDIIw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:08:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0587D21266;
        Fri,  4 Nov 2022 01:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=46Ik6G0VoKjFsZ1DIURmPBR4Lt12DjYtPmtlTMvjO0k=; b=ryJ8UNWLmryixPzqIVeWxtn4PO
        BAP9FHhoLyOR16K+X4HzbrmZcTIGLIXKVwqGGjy+X9Dd0oFw65VLvxr70zhBv/CzlJYAeYxlRkvqO
        v8OJxfd4Gd0NOR7dF+QL2nwecUFmhzM2uZj6/XGdt8xgKqmuwV3sxXyeFHw+lEdIcdBLnzHr+d5Yt
        Uy5jwwZadaKwBb7IzHsS2h/WeWTs8D9CXDW1fFSfSmQ+IkupGb804jDRstnfmVrGf8JWxAL/lP6k/
        KpQ1Y53f0gGR2ngoKB4zHllxnFlhfbyUTMNFhWF7Y29/bbQIJlfjrNXReOzQ8kYD9L45vXX9sBEnS
        rBIvrREQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqrkw-002tLy-LG; Fri, 04 Nov 2022 08:08:50 +0000
Date:   Fri, 4 Nov 2022 01:08:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/7] xfs: buffered write failure should not truncate the
 page cache
Message-ID: <Y2TIkvGMyjlXz7jp@infradead.org>
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

So, the whole scan for delalloc logic seems pretty generic, I think
it can an should be lifted to iomap, with
xfs_buffered_write_delalloc_punch provided as a callback.

As for the reuse of the seek hole / data helpers, and I'm not sure
this actually helps all that much, and certainly is not super
efficient.  I don't want you to directly talk into rewriting this
once again, but a simple

	while ((folio = find_get_entry(&xas, max, XA_PRESENT))) {
		if (xa_is_value(folio) || folio_test_uptodate(folio) ||
		    ops->is_partially_uptodate) {
			xas_pause(xas);
			rcu_read_unlock();
			folio_lock(folio);
			if (likely(folio->mapping == mapping) &&
			    folio_test_dirty(folio)) {
				// crop folio start / end by total range
				if (ops->is_partially_uptodate) {
					// find partial range
				}
				// add to or start new range
			}
			
		} else {
			// pause rcu unlock and submit previous range if
			// needed
		}

		// move to next folio with size magic etc
	}

	// submit pending range if it exists

