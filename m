Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2D967D5BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 20:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjAZTy7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 14:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAZTy6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:54:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F28D6B9A2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 11:54:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF7346187E
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 19:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29370C433D2;
        Thu, 26 Jan 2023 19:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674762896;
        bh=oPTZwEZrU6jWex90OmxXpLu3hWTN35N0kVKpfMsMsQE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HkEKiXxAHH+F44g4k5EM7zH7qvHlHeBE6M+8X8X0dvYUjUDtUE99141znjplYLuRO
         qhm/RIy9ng+StyiZZr4xQvuFUsy1FOSqfhhEI2InHM5ILVbBOl8Dz3c17UWp/axPkH
         P7KHY7srCYhKIra6WDHC1KqdOya80h+DFTnSAmM4=
Date:   Thu, 26 Jan 2023 11:54:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fs: gracefully handle ->get_block not mapping bh in
 __mpage_writepage
Message-Id: <20230126115455.296681b67273410e729309b0@linux-foundation.org>
In-Reply-To: <20230126085155.26395-1-jack@suse.cz>
References: <20230126085155.26395-1-jack@suse.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 26 Jan 2023 09:51:55 +0100 Jan Kara <jack@suse.cz> wrote:

> When filesystem's ->get_block function does not map the buffer head when
> called from __mpage_writepage(), the function will happily go and pass

"the function" being __mpage_writepage(), not ->get_block()...

> bogus bdev and block number to bio allocation routines which leads to
> crashes sooner or later.

Crashes are unwelcome.  How is this bug triggered?  Should we backport
the fix?  I assume this is a longstanding thing and that any Fixes:
target would be ancient?  If ancient, why did it take so long to
discover?

> E.g. UDF can do this because it doesn't want to
> allocate blocks from ->writepages callbacks. It allocates blocks on
> write or page fault but writeback can still spot dirty buffers without
> underlying blocks allocated e.g. if blocksize < pagesize, the tail page
> is dirtied (which means all its buffers are dirtied), and truncate
> extends the file so that some buffer starts to be within i_size.
>
> ...
