Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38F76CB2BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 02:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjC1AIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 20:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjC1AIO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 20:08:14 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C07F1BD1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 17:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cutoGWHlNcRfPTOfIG93tZSo2fyH+r1942VrGNBGUsA=; b=vmVkb8lj+9q6j4NPdensYk1D8o
        o1/adiumeQiNuJKNWbGzzoNsdleOC+QOkbCLBTOEW0n0srqj/mjs82Rf9oW8PqRwGRKlnPprY3zGt
        TkHFCkD9mZpPKUCuvLPJFxUP6u30HazY6Sh222J0yGkKWhzGzUdCic9sUaX48c4pq+vjDCmqUtnYf
        bACkd0yep0ys1nDy/jc8lqdZR2RY/7FPKROmZgyYnlR7PkTlnR6MtLV4EIl9x52tV0Qnp484K70UL
        YnfuQxvMHo6y/37RhkPZIA4QhzY8M7YAXvHMWFY8jMOS1tsff2lx9+ceB3jWlpx5RvqC75pSDEBX0
        JZpiEelQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgwsl-002YgQ-0Y;
        Tue, 28 Mar 2023 00:08:11 +0000
Date:   Tue, 28 Mar 2023 01:08:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org
Subject: Re: [PATCH 3/3] iov_iter: import single vector iovecs as ITER_UBUF
Message-ID: <20230328000811.GJ3390869@ZenIV>
References: <20230327232713.313974-1-axboe@kernel.dk>
 <20230327232713.313974-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327232713.313974-4-axboe@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 05:27:13PM -0600, Jens Axboe wrote:
> Add a special case to __import_iovec(), which imports a single segment
> iovec as an ITER_UBUF rather than an ITER_IOVEC. ITER_UBUF is cheaper
> to iterate than ITER_IOVEC, and for a single segment iovec, there's no
> point in using a segmented iterator.

Won't that enforce the "single-segment readv() is always identical to
read()"?  We'd been through that before - some of infinibarf drvivers
have two different command sets, one reached via read(), another - via
readv().  It's a userland ABI.  Misdesigned one, but that's infinibarf
for you.

Does anyone really need this particular microoptimization?
