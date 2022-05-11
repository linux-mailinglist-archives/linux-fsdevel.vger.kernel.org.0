Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA438523CFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 21:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346513AbiEKTBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 15:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345744AbiEKTBk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 15:01:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF9A443D2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 12:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49BD2B8260B
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 19:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BF7C340EE;
        Wed, 11 May 2022 19:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652295696;
        bh=yFAu4NtfyG/gBAE+EMMRtmsQvCPj7mkWnx/0WKtfGN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FVEMR5yZnQEYf5f604+3xYnL8nhJW5pg0lYzw/YXrvGc9dmSxjHsI5rbeGG1Cw8Df
         0XLp/ufoQhcZbpZQLlyaXSXQUDAj2F6yE9QzUkqMKK1RD3gaJY8BGvQysH3vfpMfv7
         c+ssVkMduCkU8CXNTfOl0rG7cgP8xNmp8CdushYV/3rmC3pRwlMyU7zy5oubWA16EQ
         IH93SLfhs2alOssWM7kpiaBjZ/Suas/0O1KJquFaNV3AXBtmxSDETlYCNlgcXYHBfS
         3JndpOfs8X10qBxPlFzOw8FA4soiwKSSYD/v/xwWN21idlp+fSrm2ULvelGgBWinol
         PCOqKou/g+qIw==
Date:   Wed, 11 May 2022 19:01:34 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chengguang Xu <cgxu519@mykernel.net>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: move fdput() to right place in
 ksys_sync_file_range()
Message-ID: <YnwIDpkIBem+MeeC@gmail.com>
References: <20220511154503.28365-1-cgxu519@mykernel.net>
 <YnvbhmRUxPxWU2S3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnvbhmRUxPxWU2S3@casper.infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 04:51:34PM +0100, Matthew Wilcox wrote:
> On Wed, May 11, 2022 at 11:45:03AM -0400, Chengguang Xu wrote:
> > Move fdput() to right place in ksys_sync_file_range() to
> > avoid fdput() after failed fdget().
> 
> Why?  fdput() is already conditional on FDPUT_FPUT so you're ...
> optimising the failure case?

"fdput() after failed fdget()" has confused people before, so IMO it's worth
cleaning this up.  But the commit message should make clear that it's a cleanup,
not a bug fix.  Also I recommend using an early return:

	f = fdget(fd);
	if (!f.file)
		return -EBADF;
	ret = sync_file_range(f.file, offset, nbytes, flags);
	fdput(f);
	return ret;
