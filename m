Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C74070B274
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 02:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjEVAVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 20:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjEVAVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 20:21:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC78DB;
        Sun, 21 May 2023 17:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0025C61027;
        Mon, 22 May 2023 00:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EDBC433EF;
        Mon, 22 May 2023 00:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684714862;
        bh=mxFY5Ys3GsQsIss7C7Uz0yTTtJAH+VljEJbbEGeCG9A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AOSxZ5qfdalhJdXdqKVodV1oVuts2OqvnSzs7CTgxOnTnxICRLF1NjMt0rmrBCifR
         FnRkh25eQpaY3arFCHzeVWQYhArz18DlwxhSxTKNFTaKsTOc33VlWLcTMHN7SrA9K2
         Pb/N/mgjzTqIbnnqBSkGmlHWaFqlGoPh6nNSwg/6eWqnl0A87XlA30iI8m6OjlVUfR
         E72Ao23rJ7IPJ4Lr+0yXY3HSz2wEG+iKkXIZKu7UsZEkxBT1DOtA2rwaXY8rwyEKMu
         U9RBxJviCJziKLvv/U6tQZEHqEusoH4w8cssD3GHKeKYOR80V0NqT/J5czvUfZgHIt
         H1ox3tSLA8Rbg==
Message-ID: <46f0818c-a04e-466a-3037-7cad41290512@kernel.org>
Date:   Mon, 22 May 2023 09:20:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 13/13] fuse: use direct_write_fallback
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
        cluster-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
References: <20230519093521.133226-1-hch@lst.de>
 <20230519093521.133226-14-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230519093521.133226-14-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
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

On 5/19/23 18:35, Christoph Hellwig wrote:
> Use the generic direct_write_fallback helper instead of duplicating the
> logic.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

