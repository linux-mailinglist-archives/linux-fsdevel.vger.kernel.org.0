Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3806274A1A0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 17:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjGFPzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 11:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjGFPzV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:55:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C384F1997;
        Thu,  6 Jul 2023 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r4kQVq5rA1fBgXtd+RKdFohRbdCbTqFPjegRZEO1tgw=; b=a9uIr26x7MCbSIgtIbkDiLWiyc
        aMuiKezIVCuqVU7hrBx107eMaoFv60vSfYSfevkNJBaEnM03DEtsAETNENFMEqN6PdwOsqogUqTz0
        9P/ZXAscLMf04k1bFl/AxrN2YN216YHUoibwz+kHHHYkQV4DTppB3zdWWnr3QAwiZB51hZhJHuVC+
        naPXeprIar9uBTmhhMcvNavG6aRbSpWbI8fDoEWybWbhqBOShD6NN6RbkYkz0gXoiOdpfB4P1G0Cx
        YOYjjqlML7DVeMpzwRa9erQn+xc77jdPUWmLfpSNsynHodTPZh9jHRqI3IA9LqGT1gfq1b9BAfPgt
        hK7NQLOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHRKA-0025Rd-37;
        Thu, 06 Jul 2023 15:55:18 +0000
Date:   Thu, 6 Jul 2023 08:55:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 6/6] fs: Make bind mounts work with
 bdev_allow_write_mounted=n
Message-ID: <ZKbj5v4VKroW7cFp@infradead.org>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-6-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704125702.23180-6-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 04, 2023 at 02:56:54PM +0200, Jan Kara wrote:
> When we don't allow opening of mounted block devices for writing, bind
> mounting is broken because the bind mount tries to open the block device
> before finding the superblock for it already exists. Reorganize the
> mounting code to first look whether the superblock for a particular
> device is already mounted and open the block device only if it is not.

Warning: this might be a rathole.

I really hate how mount_bdev / get_tree_bdev try to deal with multiple
mounts.

The idea to just open the device and work from there just feels very
bogus.

There is really no good reason to have the bdev to find a superblock,
the dev_t does just fine (and in fact I have a patch to remove
the bdev based get_super and just use the dev_t based one all the
time).  So I'd really like to actually turn this around and only
open when we need to allocate a new super block.  That probably
means tearning sget_fc apart a bit, so it will turn into a fair
amount of work, but I think it's the right thing to do.
