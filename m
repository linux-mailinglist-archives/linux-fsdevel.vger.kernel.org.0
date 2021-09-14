Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE47740ACAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 13:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhINLr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 07:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhINLr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:47:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02488C061574;
        Tue, 14 Sep 2021 04:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uzhBfondxfBGtuI3LygrN3vuHuB3wvkg/TeMLODJ0wY=; b=C1rG6AaPuDMXGAqNsCuVsPTyRa
        huaJs1/AX27R0/mALFdUg4TtGIFar2KEeR9vyHbORinJ8afxMHfkSK1d4y0PnhIO2Lr0NLdhASmAu
        /xftc4aFN93KUmihSCWnYYf6+fUSY8Ds2Lg5EDWShlMwbqnZLqTixJTsRZrtPTqC3x/0KTFzOkc9t
        TJA0nOljNRPiLbNVzBGc+HhUGET1W3iXPag36hIvixUtIjGBKF1HEmDMuc8nKpGKYd01fi4Y1/jPc
        91Pj9BFDSMk9jlt5Fh06nvDDjJpw/YzT7tX2nAENqkFqr9pTo+L8fHn9G/s9l61zgoIjfF3Sr2q6/
        HMGG1a/w==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQ6sO-00EcLs-Gk; Tue, 14 Sep 2021 11:45:40 +0000
Date:   Tue, 14 Sep 2021 12:45:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     linux-kernel@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] aio: convert active_reqs into a hashtable
Message-ID: <YUCLVAJLtseHuYsW@infradead.org>
References: <20210914094625.171211-1-someguy@effective-light.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914094625.171211-1-someguy@effective-light.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 05:46:25AM -0400, Hamza Mahfooz wrote:
> Commit 833f4154ed56 ("aio: fold lookup_kiocb() into its sole caller")
> suggests that, the fact that active_reqs is a linked-list means aio_kiocb
> lookups in io_cancel() are inefficient. So, to get faster lookups (on
> average) while maintaining similar insertion and deletion characteristics,
> turn active_reqs into a hashtable.

What workload cares about AIO cancellation performance?
