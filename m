Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E102D3D8E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 09:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgLIIeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 03:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgLIIeY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:34:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18FEC0613CF;
        Wed,  9 Dec 2020 00:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZHpvTlBTpdm0r19LXUBLpVmbiYMUimtmZ0MNJaxEeKQ=; b=U5xtIPgYZrzNwWDTuUN0+V3qCV
        FkMjtYCx5W0uZHiEqP9vdSFD16hi5F4ARE5rjxYKTDfrOBaaZD7LNh28IkZI7SkAV0MlyxqrAO/vm
        Qjff04hWWT/Zwr453g20rnXviLTrix964EaZO+mH7f+7ccMrZ5fQD6v/S3t33XPzBKmyDLuHwEv4B
        NyhuGzpne0uBA8cK9go3CgtuRDXQA9MZ1WwhabpeO2hT6v5nLHIySNdIQ4Lxz7OFOvWUhTX2kRUhY
        FOpRx3125tLb+3z70YSEs+XXCPq2Y62k6nFF67+b7vxBg0hTMEgDEh+0Ht03HsGAeO9iEVhTysQxw
        xdmtNW7A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmuur-0005ql-Jn; Wed, 09 Dec 2020 08:33:41 +0000
Date:   Wed, 9 Dec 2020 08:33:41 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iov_iter: optimise bvec iov_iter_advance()
Message-ID: <20201209083341.GA21968@infradead.org>
References: <21b78c2f256e513b9eb3f22c7c1f55fc88992600.1606957658.git.asml.silence@gmail.com>
 <20201203091406.GA6189@infradead.org>
 <eb02fa7f-956e-ce7e-6a56-82318b2c6d2e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb02fa7f-956e-ce7e-6a56-82318b2c6d2e@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 03, 2020 at 11:48:56AM +0000, Pavel Begunkov wrote:
> It's inlined and the on-stack iter is completely optimised out. Frankly,
> I'd rather not open-code bvec_iter_advance(), at least for this chunk to
> be findable from bvec.h, e.g. grep bvec_iter and bvec_for_each. Though,
> I don't like myself that preamble/postamble.

Ok.  I still think we at least want a separate helper instead of
bloating the main iov_iter_advance.
