Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD9D72ED69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 22:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjFMU4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 16:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjFMU4R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:56:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9A410F4;
        Tue, 13 Jun 2023 13:56:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 68E9E22431;
        Tue, 13 Jun 2023 20:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686689775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7sCeSsVRIBOYfYz0gtOw4EStwSHCdECdpehVah90ILY=;
        b=rpFugcuiTgrioK9FPs73dOLv0Lo+HWubcKAxeoa+9mUnv9xUT/5JqQYsBThZu4yU+14jHe
        u891JZxaL1WPbbww59nWnYX630tX7QfvfctT4qImqOkBuN82XaUKbAC6+nkwLM5iZnczuC
        jNe9h/29OJoGJxwAKHRRoguEiwSfzR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686689775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7sCeSsVRIBOYfYz0gtOw4EStwSHCdECdpehVah90ILY=;
        b=dI7yy1jUiRIa4nFqhW6P8TUTMa2/kjzABoM8YehBwUcSvegbOzu8DpdLThCZRO6ZeQW75o
        GCNLzsZkybaXeNDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A1BC13345;
        Tue, 13 Jun 2023 20:56:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Nzf+Fe/XiGTxLQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 13 Jun 2023 20:56:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E3887A0755; Tue, 13 Jun 2023 22:56:14 +0200 (CEST)
Date:   Tue, 13 Jun 2023 22:56:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ted Tso <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <20230613205614.atlrwst55bpqjzxf@quack3>
References: <20230612161614.10302-1-jack@suse.cz>
 <ZIf6RrbeyZVXBRhm@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIf6RrbeyZVXBRhm@infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 12-06-23 22:10:30, Christoph Hellwig wrote:
> > +config BLK_DEV_WRITE_HARDENING
> > +	bool "Do not allow writing to mounted devices"
> > +	help
> > +	When a block device is mounted, writing to its buffer cache very likely
> > +	going to cause filesystem corruption. It is also rather easy to crash
> > +	the kernel in this way since the filesystem has no practical way of
> > +	detecting these writes to buffer cache and verifying its metadata
> > +	integrity. Select this option to disallow writing to mounted devices.
> > +	This should be mostly fine but some filesystems (e.g. ext4) rely on
> > +	the ability of filesystem tools to write to mounted filesystems to
> > +	set e.g. UUID or run fsck on the root filesystem in some setups.
> 
> I'm not sure a config option is really the right thing.
> 
> I'd much prefer a BLK_OPEN_ flag to prohibit any other writer.
> Except for etN and maybe fat all file systems can set that
> unconditionally.  And for those file systems that have historically
> allowed writes to mounted file systems they can find a local way
> to decide on when and when not to set it.

Well, as I've mentioned in the changelog there are old setups (without
initrd) that run fsck on root filesystem mounted read-only and fsck
programs tend to open the device with O_RDWR. These would be broken by this
change (for the filesystems that would use BLK_OPEN_ flag). Similarly some
boot loaders can write to first sectors of the root partition while the
filesystem is mounted. So I don't think controlling the behavior by the
in-kernel user that is having the bdev exclusively open really works. It
seems to be more a property of the system setup than a property of the
in-kernel bdev user. Am I mistaken?

So I think kconfig option or sysfs tunable (maybe a per-device one?) will
be more appropriate choice? With default behavior configurable by kernel
parameter? And once set to write-protect on mount, do we allow flipping it
back? Both have advantages and disadvantages so the tunable might be
tri-state in the end (no protection, write-protect but can be turned off,
write-protect that cannot be turned off)? But maybe I'm overcomplicating
this so please share your thoughts :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
