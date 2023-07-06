Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04AD74A1E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 18:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjGFQNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 12:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjGFQM7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:12:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A1D129;
        Thu,  6 Jul 2023 09:12:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 833AC1FD65;
        Thu,  6 Jul 2023 16:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688659976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kkP64sgMrfrhA1tfb7qMsAHAGSE05izKmTBN7rmLByk=;
        b=fCD6ydYf6QoGMqkDlqZNXCiC8RdrTxxrUdQhDHxAe8Hwk1nWjeWbbz9NHlnWgJ9kUFuAxS
        XVcaZ57JvGHkLAGhIQ+HvyIGBCrojAAAg3wZbXOU8q/tdrE8D10sMSELJxBgkgNg3S2nMx
        88NzP5RLIcUNWSWlIIvMo0rVD4QD834=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688659976;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kkP64sgMrfrhA1tfb7qMsAHAGSE05izKmTBN7rmLByk=;
        b=ckzOkwN0+Z23fZsb0eDgni1yAMFxcMFMVSo91Ncx7Wp1FPbhuT+JWommM1loM9KlVOclXS
        1lONBya/9oYegiDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CA35138EE;
        Thu,  6 Jul 2023 16:12:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s7oGGgjopmQGKwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 16:12:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E6003A0707; Thu,  6 Jul 2023 18:12:55 +0200 (CEST)
Date:   Thu, 6 Jul 2023 18:12:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 6/6] fs: Make bind mounts work with
 bdev_allow_write_mounted=n
Message-ID: <20230706161255.t33v2yb3qrg4swcm@quack3>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-6-jack@suse.cz>
 <ZKbj5v4VKroW7cFp@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKbj5v4VKroW7cFp@infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 06-07-23 08:55:18, Christoph Hellwig wrote:
> On Tue, Jul 04, 2023 at 02:56:54PM +0200, Jan Kara wrote:
> > When we don't allow opening of mounted block devices for writing, bind
> > mounting is broken because the bind mount tries to open the block device
> > before finding the superblock for it already exists. Reorganize the
> > mounting code to first look whether the superblock for a particular
> > device is already mounted and open the block device only if it is not.
> 
> Warning: this might be a rathole.
> 
> I really hate how mount_bdev / get_tree_bdev try to deal with multiple
> mounts.
> 
> The idea to just open the device and work from there just feels very
> bogus.
> 
> There is really no good reason to have the bdev to find a superblock,
> the dev_t does just fine (and in fact I have a patch to remove
> the bdev based get_super and just use the dev_t based one all the
> time).  So I'd really like to actually turn this around and only
> open when we need to allocate a new super block.  That probably
> means tearning sget_fc apart a bit, so it will turn into a fair
> amount of work, but I think it's the right thing to do.

Well, this is exactly what this patch does - we use dev_t to lookup the
superblock in sget_fc() and we open the block device only if we cannot find
matching superblock and need to create a new one...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
