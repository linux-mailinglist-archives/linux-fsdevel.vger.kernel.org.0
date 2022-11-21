Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DF3632D3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 20:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiKUTsp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 14:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiKUTso (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:48:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3032092B78;
        Mon, 21 Nov 2022 11:48:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4A2BB815D7;
        Mon, 21 Nov 2022 19:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35382C433C1;
        Mon, 21 Nov 2022 19:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669060121;
        bh=uPYHTP2Ipj1sjrcHIm6CYiJh1FA0Hkn6zRTUosyzZhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TrV/2DjxF1rutFbntPYYC9ONN0Uda6FFTBfJlApXphenB+VGOZ5iLxlUIkzmv7s7E
         lZr0pL2iT2j274d6+x2nxXaHGy3/wnUtCl/KUrmLKCxa2ewYEAXooKMndVypDUcvl2
         63Fx/Kosh/hLvBUeAm4T/PKzCJLBd/aiTg8bd+CI=
Date:   Mon, 21 Nov 2022 11:48:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/5] fs: ext4: initialize fsdata in pagecache_write()
Message-Id: <20221121114840.c407626c13706ff993efabe3@linux-foundation.org>
In-Reply-To: <20221121112134.407362-1-glider@google.com>
References: <20221121112134.407362-1-glider@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 21 Nov 2022 12:21:30 +0100 Alexander Potapenko <glider@google.com> wrote:

> When aops->write_begin() does not initialize fsdata, KMSAN reports
> an error passing the latter to aops->write_end().
> 
> Fix this by unconditionally initializing fsdata.
> 
> ...
>

I'm assuming that this is not-a-bug, and that these changes are purely
workarounds for a KMSAN shortcoming?

If true, this important info should be included in each changelog,
please.

If false, please provide a full description of the end-user visible
effects of the bug.

Also, it would be helpful to describe why it is not considered
practical to teach KMSAN to handle this?

> --- a/fs/ext4/verity.c
> +++ b/fs/ext4/verity.c
> @@ -79,7 +79,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
>  		size_t n = min_t(size_t, count,
>  				 PAGE_SIZE - offset_in_page(pos));
>  		struct page *page;
> -		void *fsdata;
> +		void *fsdata = NULL;
>  		int res;
>  
>  		res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);

