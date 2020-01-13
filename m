Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5484139BFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 22:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgAMV6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 16:58:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgAMV6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 16:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vIM78U2tiWS9Y/ZT/+KZFKq5Yv/4AD1q7UnORAYypVA=; b=QhjG5sZ73yT68+nsT+PJK7boT
        5hGKSj9h0MWjy4zOpkZ99sx5F6bMnW4oeh/BVRiYN7rRSA5+LDcu4UCW4ylznEE2T+LXn6e7l0h3v
        Wk/kRBrV2qeyieT7kIa2lL9X5D/SVPWk8lvc1U6nfVa8mcU0kp19XDbP/87FSMlP7A+H445fZlN8l
        5uPAOyAkMVsLHkA2Wbswv6mGE1BGhr0mjdBHjwmSWONgFNHiDjm9hUy8ne2zu+8AfRc6SOpDyFXFv
        vPFy5BBfjcF4YapnTJ3IUrvylWDHRrrdixB/pAlaPyYUgfzCNGdwD5g+fI0AfTp9fabFTNFVZFiD6
        LH5vvu3jA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir7it-0001Om-5J; Mon, 13 Jan 2020 21:58:11 +0000
Date:   Mon, 13 Jan 2020 13:58:11 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Mason <clm@fb.com>
Cc:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC 0/8] Replacing the readpages a_op
Message-ID: <20200113215811.GA18216@bombadil.infradead.org>
References: <20200113153746.26654-1-willy@infradead.org>
 <6CA4CD96-0812-4261-8FF9-CD28AA2EC38A@fb.com>
 <20200113174008.GB332@bombadil.infradead.org>
 <15C84CC9-3196-441D-94DE-F3FD7AC364F0@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15C84CC9-3196-441D-94DE-F3FD7AC364F0@fb.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 06:00:52PM +0000, Chris Mason wrote:
> This is true, I didn't explain that part well ;)  Depending on 
> compression etc we might end up poking the xarray inside the actual IO 
> functions, but the main difference is that btrfs is building a single 
> bio.  You're moving the plug so you'll merge into single bio, but I'd 
> rather build 2MB bios than merge them.

Why don't we store a bio pointer inside the plug?  You're opencoding that,
iomap is opencoding that, and I bet there's a dozen other places where
we pass a bio around.  Then blk_finish_plug can submit the bio.
