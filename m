Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D57270B232
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 01:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjEUXv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 19:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUXvY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 19:51:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91A0D2;
        Sun, 21 May 2023 16:51:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3510E61157;
        Sun, 21 May 2023 23:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA5CC433EF;
        Sun, 21 May 2023 23:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684713082;
        bh=JM6EWN6Vr8l/+vfMGEdDax1iehXzHzlib3UykqPWjDY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I3n4f+Hx+d/WbG91pczWPX1rPbl9NSSVWcZeLoP+225RgrU5EtFZOKgl6tAyY4DVo
         aPfkrcA8CiQWpyBNZJhoQBGEKYp4qyJQA293j2LDG669aqyRqyFMpO5Ni1n8ppuk8L
         qP4BKn8FC2G5Ua5wwvgn1/CyNxLIxcI77BUnRg+VFjzhIFGjO9l8tslODaNCtGZ9cd
         y0OqRTQKWUgxwxjjIHSyR/3Vf6balNbjHGP+Q5ha+yM3o4ds9Rq+7fjzhwsL9k6Xef
         LAF/r3RF0hhQHKY4QzSnfOdpLZ2JRFc8MEBKawObeVUv4MYsci5zhB+3Muoo0cD9We
         8lqdVgwXyYPNA==
Message-ID: <c3ae725f-66b4-8f6a-94fd-40e0432bd7f4@kernel.org>
Date:   Mon, 22 May 2023 08:51:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 05/13] filemap: add a kiocb_invalidate_pages helper
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
 <20230519093521.133226-6-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230519093521.133226-6-hch@lst.de>
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
> Factor out a helper that calls filemap_write_and_wait_range and
> invalidate_inode_pages2_rangefor a the range covered by a write kiocb or

invalidate_inode_pages2_rangefor a the range
->
invalidate_inode_pages2_range for the range

> returns -EAGAIN if the kiocb is marked as nowait and there would be pages
> to write or invalidate.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

