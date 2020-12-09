Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4369F2D3ED9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 10:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgLIJcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 04:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbgLIJcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:32:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2F8C0613D6;
        Wed,  9 Dec 2020 01:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=on6fWUDWvuIOpDUaJRGB5sXHl5/1MPX7m37kwe66ocY=; b=qAay+FXaeDFlYurY/OQcxrIudw
        gpcq22NEvLat3ot9srRP48FOc7s/MKGz+MeueAU50AI0jsg3XPV/IuQFe7zMlQWf1Y+tm5Bm7kdUx
        wo1tq2UGgpCo16Z7p0D6QVXYcsaMvZ22uN3F0COB+lPZXXBYfQa1/XAZXHeBb333YqUxC6iMiHbzk
        BKsSMqUJWtQx4o+Eu1ppaQvBUP7Rm6W7391FpvWRhu956DXLAsY5s7FsXGHFg0gv8UtwgM7IfpOuP
        N4m9S5pPiin4bE7YHdp4OJRLvetFd7Ve3gxO9//e5BStDJpQNnR/+E21KeD5K55FeJ7fRvJuPrEGq
        bAaLgzOA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmvow-0001Ht-A4; Wed, 09 Dec 2020 09:31:38 +0000
Date:   Wed, 9 Dec 2020 09:31:38 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Message-ID: <20201209093138.GA3970@infradead.org>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Btw, another thing I noticed:

when using io_uring to submit a write to btrfs that ends up using Zone
Append we'll hit the

	if (WARN_ON_ONCE(is_bvec))
		return -EINVAL;

case in bio_iov_iter_get_pages with the changes in this series.
