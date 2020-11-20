Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC512B9FA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 02:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgKTBUT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 20:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKTBUT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:20:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF11C0613CF;
        Thu, 19 Nov 2020 17:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uIhwjMF8P8Wim+68g+Wg+Y0WkmC51lm2aFjKZAFLUHw=; b=CDPtdmi2TwIsopN4OrHcC5a+Ol
        xwDv/KAULowchwLaDmA0FuPTQi1p6n1E6rkBhYF65NGb//BicvmFLdABvs/LqsszMa4yjTJ7UifjZ
        fl81nGEvMFhF9rYgA7G3KAB9hEa+zWojt5uGKY/t0xXVDPbQTgIOWeduZmIrJXuMJC5jY0Xwdo+Gw
        ixavW9jmYBMOocsqciTAPLfrXevPJpUr9G/uFT0v0O7GwQCdMpb1IJAJT9JvEZhBHGD+poDS3lnxw
        rUadSTuON+Ps44svtP0CaiZumid7G0smKNbfGJJE5/nKttwiNOx2qhPVdAkfoKRhj6fhSLAoHbfgw
        MHLhzSCg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfv61-0005D5-3O; Fri, 20 Nov 2020 01:20:17 +0000
Date:   Fri, 20 Nov 2020 01:20:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iov_iter: optimise iov_iter_npages for bvec
Message-ID: <20201120012017.GJ29991@casper.infradead.org>
References: <cover.1605827965.git.asml.silence@gmail.com>
 <ab04202d0f8c1424da47251085657c436d762785.1605827965.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab04202d0f8c1424da47251085657c436d762785.1605827965.git.asml.silence@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 19, 2020 at 11:24:38PM +0000, Pavel Begunkov wrote:
> The block layer spends quite a while in iov_iter_npages(), but for the
> bvec case the number of pages is already known and stored in
> iter->nr_segs, so it can be returned immediately as an optimisation

Er ... no, it doesn't.  nr_segs is the number of bvecs.  Each bvec can
store up to 4GB of contiguous physical memory.

