Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E46E55AACF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiFYOLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 10:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiFYOLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 10:11:44 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B4713F68;
        Sat, 25 Jun 2022 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TlSV5NUlez2H7IMIJSqo9tL3DTMkccXj2o6QuxiCsWY=; b=nq3bfnOieThPFgraHvRTGoUJLc
        q7a0ydHGGwa9+zd3Dx4KhDIrkiWab2nRmnZ0oQgHwYxA0CZslePmguvgMhHMMPqERQ8zFzmuhynrd
        W8cuHe+W6TOM/EwfbRlMPl4OZ/O49vDbbmeA6oQnlC4uTRuiyUVMWhcIQ1DZTz6y2KMlphAK/8jf9
        goXDIop6n8qEOoYKOWnhZGJHCk82/Xd0DGgaQfpRHGCPvgVm08H6VrG7FZrcAuh130ttMQVUCHn8f
        0NGPI5RdgnW0TV9HN6n/Bxq29O0fBK5DC7CKkmZzvvLTLAh+c1sagW1m/gRIvG4fNMks6EP3kOKjZ
        Q5uNrJSw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o56Vg-004LT3-18;
        Sat, 25 Jun 2022 14:11:40 +0000
Date:   Sat, 25 Jun 2022 15:11:39 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] fs: clear or set FMODE_LSEEK based on llseek
 function
Message-ID: <YrcXmwjPeJ77xsY2@ZenIV>
References: <20220625110115.39956-1-Jason@zx2c4.com>
 <20220625110115.39956-4-Jason@zx2c4.com>
 <YrcIoaluGx+2TzfM@infradead.org>
 <YrcNpdJmyFU+Up1n@ZenIV>
 <YrcQKIruM3w2gGho@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrcQKIruM3w2gGho@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 25, 2022 at 06:39:52AM -0700, Christoph Hellwig wrote:
> On Sat, Jun 25, 2022 at 02:29:09PM +0100, Al Viro wrote:
> > I wouldn't bet on that - as it is, an ->open() instance can decide
> > in some cases to clear FMODE_LSEEK, despite having file_operations
> > with non-NULL ->llseek.
> 
> The interesting cases here are nonseekable_open and stream_open,
> and I don't see why we could not fix this up in the file_operations.

What's the point, really?  We can easily enforce "no FMODE_LSEEK ever
observed on files with NULL ->llseek" (this series does that), so we
can use that check alone in e.g. vfs_llseek() or dump_skip().

Sure, we are tight on bits in ->f_mode, but there's a better way to
relieve that problem - split the field into "stuff that needs to
be preserved all the way until __fput()" and the rest; the latter
could sit next to ->f_iocb_flags, with no increase of struct file
size.

So if you are worried about FMODE_... space getting exhausted, that's
better dealt with in a different way, IMO.
