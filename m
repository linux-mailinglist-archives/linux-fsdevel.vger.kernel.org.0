Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA6170EBA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 05:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbjEXDBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 23:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjEXDBS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 23:01:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A89139;
        Tue, 23 May 2023 20:01:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 271D16381E;
        Wed, 24 May 2023 03:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A927DC433EF;
        Wed, 24 May 2023 03:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684897275;
        bh=sp/Ume+GBHLoTEpuvlf0XK+PE025ykhly6ak9SBq7zc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nTS9dwJzGsrZhhAO/qQVIjlko93ei9TBykrirrxG88FPV5qcJx4rbo4agbRfIJWQU
         7gziVN323mxBE/6wANpWwBJTvUYdkQMmZpX/MNLxrjv1cuPNsUuVE+XykJx4Vx9u8T
         WPT/iPluDmiYsc7s4Ah2Q1NyN8k9pgO6irD5s8mDw4xp9kt/KyVxS5cnhcQy5lZgyP
         nfvuJHUO4BiZ9crJD1uIQHmS/ICJ46kxXsjLRHrg8dnGGR6KJKHsKyXJtSU1OANj+0
         UJYHjSqK8T6cxs8pAAqhC2DPanxRex3cVZxsbYVR/1Mx61NbW/7v3bp9uGO9e/SLnH
         8iFk5/cu49fAg==
Message-ID: <bccac3a3-cc5d-9be7-cfc2-f00fc4af5c62@kernel.org>
Date:   Wed, 24 May 2023 11:01:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v22 19/31] f2fs: Provide a splice-read wrapper
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230522135018.2742245-1-dhowells@redhat.com>
 <20230522135018.2742245-20-dhowells@redhat.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230522135018.2742245-20-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/5/22 21:50, David Howells wrote:
> Provide a splice_read wrapper for f2fs.  This does some checks and tracing
> before calling filemap_splice_read() and will update the iostats
> afterwards.  Direct I/O is handled by the caller.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Jaegeuk Kim <jaegeuk@kernel.org>
> cc: Chao Yu <chao@kernel.org>
> cc: linux-f2fs-devel@lists.sourceforge.net
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-mm@kvack.org

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
