Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD55770B24C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 02:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjEVAFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 20:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEVAFG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 20:05:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C40F9D;
        Sun, 21 May 2023 17:05:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A46CB612A5;
        Mon, 22 May 2023 00:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750D7C433EF;
        Mon, 22 May 2023 00:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684713904;
        bh=E9HylG/tcZ9ypOKQIb0ALyQo4ZdadXJ2F5MM9xsQvIo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tg9VRhD3pU5E6h82uRSebiA2CoUfSFazrPXhAdkuMdw/YHz7TizGQVPxH7sf1bybJ
         9pVjxyd9RD6Esi/udTHpfhazC7ni+xDnJ4tp7E6eb55JCV0Ys8k/lLJ4eUDSxRqvq9
         LJERPMDd3prQur8f5Edsobj6QFKiaT4Fgpq94NE2coTNbZwqY1W+WFhGHfAI4sp6Z8
         DlkD0MMz0RQOpRdIUO3g4Qdn9cn0kk3tJJQwapFPHbh7Lv+sp54Q+MR5U2VlJ16StD
         Hgj+jgofNL7e7t3WCATjtmEpaHL/w1gXK0aWokjb1cSD/3mfQKZv5EhJQmXTLNRAyQ
         ZG2tBsVHf7xCA==
Message-ID: <88fe9652-3cf5-c601-08f1-64b75e367ca5@kernel.org>
Date:   Mon, 22 May 2023 09:05:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 08/13] iomap: assign current->backing_dev_info in
 iomap_file_buffered_write
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
 <20230519093521.133226-9-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230519093521.133226-9-hch@lst.de>
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
> Move the assignment to current->backing_dev_info from the callers into
> iomap_file_buffered_write to reduce boiler plate code and reduce the
> scope to just around the page dirtying loop.
> 
> Note that zonefs was missing this assignment before.

Hu... Shouldn't this be fixed as a separate patch with a Fixes tag for this cycle ?
I have never noticed any issues with this missing though. Not sure how an issue
can be triggered with this assignment missing.

Apart from that, this patch look good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

