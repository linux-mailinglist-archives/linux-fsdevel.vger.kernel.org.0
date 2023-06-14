Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F2772F608
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 09:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243162AbjFNHVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 03:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243194AbjFNHVS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:21:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42FD1FE3;
        Wed, 14 Jun 2023 00:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t5bVnubaysqgmFfqxZyypHKwktxU/caiSeNdZmNnYCg=; b=TKdDsBmQIr7BxQTCdY4CK7f1x1
        Wm+GV80GLt7cXrSZjDBfLn3W/jIMufPnEuU8vV2kIOZV6Z+NOMtYiBCBewZL6Yz6P2A71Gp08aaEl
        34teZijT2GRtJ1U5N6loEalm8qmlHTH3KGGEpUf+RAbb352oY8dJBgHfIU/DasZG6FMqBLoJVhyLM
        ackTFjJ5+sSdOqgzkRsoMh7mnblAd12jPaMY6GUvt8cmbcl6NfUflSGTra+OuIipqkQqhqjr/tl+v
        OnPldA3VMvjPMsr+QtBPrDbdKZwQtmbENvqumvGWZ+7/43k9ErN5S6UaMs7iERB4WaYbAd79yyceY
        gVzlVF4Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9Knc-00Adlr-0T;
        Wed, 14 Jun 2023 07:20:12 +0000
Date:   Wed, 14 Jun 2023 00:20:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, Ted Tso <tytso@mit.edu>,
        yebin <yebin@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <ZIlqLJ6dFs1P4aj7@infradead.org>
References: <20230612161614.10302-1-jack@suse.cz>
 <ZIf6RrbeyZVXBRhm@infradead.org>
 <20230613205614.atlrwst55bpqjzxf@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613205614.atlrwst55bpqjzxf@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:56:14PM +0200, Jan Kara wrote:
> Well, as I've mentioned in the changelog there are old setups (without
> initrd) that run fsck on root filesystem mounted read-only and fsck
> programs tend to open the device with O_RDWR. These would be broken by this
> change (for the filesystems that would use BLK_OPEN_ flag).

But that's also a really broken setup that will corrupt data in many
cases.  So yes, maybe we need a way to allow it, but it probably would
have to be per-file system.

> Similarly some
> boot loaders can write to first sectors of the root partition while the
> filesystem is mounted. So I don't think controlling the behavior by the
> in-kernel user that is having the bdev exclusively open really works. It
> seems to be more a property of the system setup than a property of the
> in-kernel bdev user. Am I mistaken?

For many file systems this would already be completely broken (e.g.
XFS).  So allowing this is needed for legacy use cases, but again should
be limited to just file systems where this even makes sense.  And
strictly limited to legacy setups, we do need proper kernel APIs for
all of that in the future so that modern distros don't have to allow
sideband writes at all.
