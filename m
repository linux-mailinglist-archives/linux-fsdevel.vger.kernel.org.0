Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CF26C8AF8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Mar 2023 05:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjCYErA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Mar 2023 00:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCYEq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Mar 2023 00:46:59 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655A417CCF
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 21:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GC3tbnAx6ReVEby5qoE/CTx6lWG5azTZaGFyKg8jz04=; b=c7hT/+Q3hK6ubvtOU54Ohvbm27
        Q29gn9pVKKf2CUocm7nYUjBXY907Mgm2dBiOxoT2rK7zeS9i+P+auXehNRg/hnQuKOedCa3cOcgzl
        CNuj6xOaiYTYriN/R4R4uOgIYq3q/NyWr7qyfUYxpoBLKa/S1+qI0w/Xm4rsX+uQroCvpBHHOFQ9W
        3c0rLlXWhk/zHoP7YaFENQlpsY7rEtayAPytpddfC2iMotrYSpzxuTlprvOuTYcls71fj6OHTDjrN
        wHgf72lIfcPrdB1RB/x6DTXsqEgSL63a7KXUK1dFULLmzrKCqLNFLkOHMu6ec19lQP6OROe7O4asj
        7fCph6Rw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfvnq-001l36-2z;
        Sat, 25 Mar 2023 04:46:55 +0000
Date:   Sat, 25 Mar 2023 04:46:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org
Subject: Re: [PATCHSET 0/2] Turn single segment imports into ITER_UBUF
Message-ID: <20230325044654.GC3390869@ZenIV>
References: <20230324204443.45950-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324204443.45950-1-axboe@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 02:44:41PM -0600, Jens Axboe wrote:
> Hi,
> 
> We've been doing a few conversions of ITER_IOVEC to ITER_UBUF in select
> spots, as the latter is cheaper to iterate and hence saves some cycles.
> I recently experimented [1] with io_uring converting single segment READV
> and WRITEV into non-vectored variants, as we can save some cycles through
> that as well.
> 
> But there's really no reason why we can't just do this further down,
> enabling it for everyone. It's quite common to use vectored reads or
> writes even with a single segment, unfortunately, even for cases where
> there's no specific reason to do so. From a bit of non-scientific
> testing on a vm on my laptop, I see about 60% of the import_iovec()
> calls being for a single segment.
> 
> I initially was worried that we'd have callers assuming an ITER_IOVEC
> iter after a call import_iovec() or import_single_range(), but an audit
> of the kernel code actually looks sane in that regard. Of the ones that
> do call it, I ran the ltp test cases and they all still pass.

Which tree was that audit on?  Mainline?  Some branch in block.git?
