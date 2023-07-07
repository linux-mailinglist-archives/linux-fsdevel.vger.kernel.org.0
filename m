Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC01D74AFD3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 13:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjGGLa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 07:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGGLaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:30:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0F71FF9;
        Fri,  7 Jul 2023 04:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UZlj2Ou+FC8/RTVVHCLVA+4rI3cHaPQJB4OBx15VFGk=; b=dLyytecDHZE34VhkPmaGM30fCu
        JHb3BFJX7iPZL57mVZW8u5y5+a4tMnxGgKhzSW9fjHaNyrJmxAZHvnJSzuEnT5w2ICznYUFyfWQWZ
        0RgxpxIsvMqup4hGMnwzTpe02oTkUd73MOWifiv5pqcivv4PBU6qSJnO3bbDMR0wFUn9QLMggZGPn
        EtE8tgzDjJGuoiT0AAt231mL0+NVvxjikg7sEl3YNL54Fd5/+Gs3ZQpJREUbCph2jBFfRHt53avcZ
        ks/3BTKt6H1x/9zNvZPdXCFRYq1+4Gm42G9QPO6mgFuNM0PCrz6NyuW9/5p6UP5tY9MgPLadWn+MQ
        hzk92zsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHjfJ-004W9r-0n;
        Fri, 07 Jul 2023 11:30:21 +0000
Date:   Fri, 7 Jul 2023 04:30:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 6/6] fs: Make bind mounts work with
 bdev_allow_write_mounted=n
Message-ID: <ZKf3TccOhDhyNRK1@infradead.org>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-6-jack@suse.cz>
 <ZKbj5v4VKroW7cFp@infradead.org>
 <20230706161255.t33v2yb3qrg4swcm@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706161255.t33v2yb3qrg4swcm@quack3>
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

On Thu, Jul 06, 2023 at 06:12:55PM +0200, Jan Kara wrote:
> Well, this is exactly what this patch does - we use dev_t to lookup the
> superblock in sget_fc() and we open the block device only if we cannot find
> matching superblock and need to create a new one...

Hah, that's what you get for writing one last mail before getting on
an airplane without reading the patch.  This just sounded like a
workaround especially being at the end of the series.
