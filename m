Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9F374AC14
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 09:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjGGHjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 03:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjGGHjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:39:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B3119B2;
        Fri,  7 Jul 2023 00:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 263EC61652;
        Fri,  7 Jul 2023 07:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2198C433C8;
        Fri,  7 Jul 2023 07:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688715551;
        bh=sCtUlKO6lNaOcSnDm95grpQl1WbLB7f58PF5sz3zFYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iwrEvG5NYkKYotz+ITBfSw22HwN02kUvNG6SXQDjVRmEZfg/IqavlBqaSTBQZCgkv
         oBoEh4pd/IqIW9j4ofoZiDrSPnF/J8lswEHESPtW34tET+O1b9W6pDu5GTfiraJQ0Y
         i6fSTaEDupiqeRfyOK730uVi4V308SfGj2E2BrgXtS7RFLyYuF3jr+buYYu1iKW8dc
         Z/YJv8UBI5v+u+CBGvPgYlg2/W/AmFadUlWxBwiWSly29KI1cC0JRPlWvECsExGHq1
         FcfdTSHc9s9cGOMgW8vRPkpTqk1wUtzjZ8AgHsv8Kx/Vji7BiOd84PxXyToh7w1thT
         /JsBh2uFnugiw==
Date:   Fri, 7 Jul 2023 09:39:05 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 6/6] fs: Make bind mounts work with
 bdev_allow_write_mounted=n
Message-ID: <20230707-mitangeklagt-erdumlaufbahn-688d4f493451@brauner>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-6-jack@suse.cz>
 <ZKbj5v4VKroW7cFp@infradead.org>
 <20230706161255.t33v2yb3qrg4swcm@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230706161255.t33v2yb3qrg4swcm@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 06, 2023 at 06:12:55PM +0200, Jan Kara wrote:
> On Thu 06-07-23 08:55:18, Christoph Hellwig wrote:
> > On Tue, Jul 04, 2023 at 02:56:54PM +0200, Jan Kara wrote:
> > > When we don't allow opening of mounted block devices for writing, bind
> > > mounting is broken because the bind mount tries to open the block device
> > > before finding the superblock for it already exists. Reorganize the
> > > mounting code to first look whether the superblock for a particular
> > > device is already mounted and open the block device only if it is not.
> > 
> > Warning: this might be a rathole.
> > 
> > I really hate how mount_bdev / get_tree_bdev try to deal with multiple
> > mounts.
> > 
> > The idea to just open the device and work from there just feels very
> > bogus.
> > 
> > There is really no good reason to have the bdev to find a superblock,
> > the dev_t does just fine (and in fact I have a patch to remove
> > the bdev based get_super and just use the dev_t based one all the
> > time).  So I'd really like to actually turn this around and only
> > open when we need to allocate a new super block.  That probably
> > means tearning sget_fc apart a bit, so it will turn into a fair
> > amount of work, but I think it's the right thing to do.
> 
> Well, this is exactly what this patch does - we use dev_t to lookup the
> superblock in sget_fc() and we open the block device only if we cannot find
> matching superblock and need to create a new one...

Can you do this rework independent of the bdev_handle work that you're
doing so this series doesn't depend on the other work and we can get
the VFS bits merged for this?
