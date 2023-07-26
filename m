Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D28763773
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 15:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjGZNXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 09:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjGZNXH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:23:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E42DE73;
        Wed, 26 Jul 2023 06:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l8DL6FefQRlTO4k+CnDZGvBGUcQeC8CVjDO7YN+sTNE=; b=V8+S35FmfA8iyzobqwijZgpTTU
        jSHsW2HpA2FzPeJw2x8ly4V0kLbrFJ4FyRt+X6XonF2EkETDzpeoMMC4l9eUEzHNoI8XfDqukvqH6
        I6Dj1UeaNqSID+62Yr8zTBqACjQHMUUarl/FHVkEM88ejUO3sioZ9RXgfLW1lG/kltxBdGff8hqBP
        +7vQxbFp0pkzoq5g1JS6K25vtfUKceDUVR1pCuuS9nQXgjQUn7MzW/70E+lmG++Hau6yaiB7lWTKN
        IiI1LDAQ63xQ8JtGdiCD+mgMZbmKKax7aF5RYp+cQ+oehgADkqCEceAsY0dKIHjQnfj7C4QkZ/i9c
        tXLK4Meg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qOeTp-00AWXQ-0K;
        Wed, 26 Jul 2023 13:23:05 +0000
Date:   Wed, 26 Jul 2023 06:23:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 05/20] block: Allow bio_iov_iter_get_pages() with
 bio->bi_bdev unset
Message-ID: <ZMEeOZZcOu2p0SDP@infradead.org>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-6-kent.overstreet@linux.dev>
 <ZL62HKrAJapXfcaR@infradead.org>
 <20230725024312.alq7df33ckede2gb@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725024312.alq7df33ckede2gb@moria.home.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:43:12PM -0400, Kent Overstreet wrote:
> Doing the blk-cgroup association at bio alloc time sounds broken to me,
> because of stacking block devices - why was the association not done at
> generic_make_request() time?

Because blk-cgroup not only works at the lowest level in the stack,
but also for stackable block devices.  It's not a design decision I
particularly agree with, but it's been there forever.

So we need to assign it when creating the bio (we used to do it at
submission time, but the way it was done was horribly ineffcient,
that's why I moved it to allocation time), and then when hitting a
stacked device it get reassinged (which still is horribly inefficient).
