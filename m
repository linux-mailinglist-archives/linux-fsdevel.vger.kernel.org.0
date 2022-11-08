Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC473620A5C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 08:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbiKHHh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 02:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiKHHhU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:37:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2D518E18;
        Mon,  7 Nov 2022 23:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5/nYtjluDMIKkEIdaeAgklUrPJKhrNBI5rnPWNIBsL0=; b=rwDtwUfG964npUGiqYEI1q7+5r
        HQfIw39VitlFcgNC9xtONs63FFmdr4MtNerkfsjEO3wgHWDL/pvbCpDLW8jdOI6RJetisfhFpVm29
        nWHFLh/24Tdrav5q4/xLuV34Yl+4YXbB+2AigfgMvCxnVxVD/yiFu7L90pzNMzEuGdoFR0h4y5zfc
        H7QmQsstIL6VFiCa/5TLAjr6JaObvUuKM/NNjnTM+W+GtMwsSl+KgF/PXLKRaxQSR+iFk7g2uiR96
        /XB5TuPLZRRMTi5KkhDsXNqHoEEEfH1ZPpsiLRA3NDHS1sXVZITdMDZXhSR08PsSrdQjEKeYjHzKD
        mHgHE24w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osJAZ-003S4u-E5; Tue, 08 Nov 2022 07:37:15 +0000
Date:   Mon, 7 Nov 2022 23:37:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Max Kellermann <mk@cm4all.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH] fs/splice: don't block splice_direct_to_actor() after
 data was read
Message-ID: <Y2oHK3/MgHQzuepE@infradead.org>
References: <20221105090421.21237-1-mk@cm4all.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105090421.21237-1-mk@cm4all.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 05, 2022 at 10:04:21AM +0100, Max Kellermann wrote:
> Since there are no other parameters, I suggest adding the
> SPLICE_F_NOWAIT flag, which is similar to SPLICE_F_NONBLOCK, but
> affects the "non-pipe" file descriptor passed to sendfile() or
> splice().  It translates to IOCB_NOWAIT for regular files.

This looks reasonable to me and matches the read/write side.

>
> For now, I
> have documented the flag to be kernel-internal with a high bit, like
> io_uring does with SPLICE_F_FD_IN_FIXED, but making this part of the
> system call ABI may be a good idea as well.

Yeah, my only comment here is that I see no reason to make this
purely kernel internal.

And while looking at that: does anyone remember why the (public)
SPLICE_F_* aren't in a uapi header?
