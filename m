Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF51377909B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 15:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbjHKNSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 09:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbjHKNR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:17:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B6430EB;
        Fri, 11 Aug 2023 06:17:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 41B8321875;
        Fri, 11 Aug 2023 13:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691759877;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jxg4TxS/cWMUXDhX+Q9gfid5V2x8SK/7YZ4qzrUQGPw=;
        b=E4Sjzuw1+s9z57yqR8TqHdrTIAIfqlF0aO3xt916+YEZQoGQ8xf0cposTBZQU0wFD+mUPK
        N357zPJOSNrXTqUErUFX/4FCpghua6XQu5bD0bbJKzRFGyqM91yug32oJPZ4/ewNu8pmeX
        cwevnrFG+Ao1hj3ojRyKVt1OpDwiI6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691759877;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jxg4TxS/cWMUXDhX+Q9gfid5V2x8SK/7YZ4qzrUQGPw=;
        b=M+ZAVaWnqAM/Oi3IQFevlgwEaHXiAZnzmggT07Dkg7x9FI9GNAMFZc9doUlUu+4+yr8DFg
        d0l3iNDFg1Z2lXAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D88E813592;
        Fri, 11 Aug 2023 13:17:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TMEFNAQ11mRafgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Aug 2023 13:17:56 +0000
Date:   Fri, 11 Aug 2023 15:11:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/17] btrfs: open block devices after superblock creation
Message-ID: <20230811131131.GN2420@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230811100828.1897174-1-hch@lst.de>
 <20230811100828.1897174-6-hch@lst.de>
 <20230811-wildpark-bronzen-5e30a56de1a1@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811-wildpark-bronzen-5e30a56de1a1@brauner>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 02:44:50PM +0200, Christian Brauner wrote:
> On Fri, Aug 11, 2023 at 12:08:16PM +0200, Christoph Hellwig wrote:
> > Currently btrfs_mount_root opens the block devices before committing to
> > allocating a super block. That creates problems for restricting the
> > number of writers to a device, and also leads to a unusual and not very
> > helpful holder (the fs_type).
> > 
> > Reorganize the code to first check whether the superblock for a
> > particular fsid does already exist and open the block devices only if it
> > doesn't, mirroring the recent changes to the VFS mount helpers.  To do
> > this the increment of the in_use counter moves out of btrfs_open_devices
> > and into the only caller in btrfs_mount_root so that it happens before
> > dropping uuid_mutex around the call to sget.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> 
> Looks good to me,
> Acked-by: Christian Brauner <brauner@kernel.org>
> 
> And ofc, would be great to get btrfs reviews.

I'll take a look but there are some performance regressions to deal with
and pre-merge window freeze so it won't be soon.
