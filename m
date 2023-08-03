Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943F576EAC9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 15:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjHCNin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 09:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjHCNhg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:37:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E60149D7;
        Thu,  3 Aug 2023 06:33:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0427421905;
        Thu,  3 Aug 2023 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691069611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=du0Z70X155ISlaXGxW4wp6Y48mig4odO4voIGMDl2xk=;
        b=WSThLGh5TEJlC2zqxUr829BXGh9BB964D/DpAf80OivGVyDFjKi8qi3yL2jZmX2XVxeHql
        0TKeSDcOHnYIT4J24RhGZYydOnwkzEiWP2/UykyXLONZlsOKV3dQWpzTpXbJZJZ88qyNor
        7GCVNVcrD3BsRADBFqYCtXRYyEu/TnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691069611;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=du0Z70X155ISlaXGxW4wp6Y48mig4odO4voIGMDl2xk=;
        b=bFFXY2fQpz4y83Dou+dieZJmMgc/fDw9xHqvionrKHFPePEk3QgCOGG9fcv6pv8LVaYKVs
        6FTlW6XPrhE8WQAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E52E2134B0;
        Thu,  3 Aug 2023 13:33:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lOHrN6qsy2QWcwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 13:33:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 80941A076B; Thu,  3 Aug 2023 15:33:30 +0200 (CEST)
Date:   Thu, 3 Aug 2023 15:33:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 06/12] fs: use the super_block as holder when mounting
 file systems
Message-ID: <20230803133330.dstks7aogjogqdd5@quack3>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-7-hch@lst.de>
 <20230803115131.w6hbhjvvkqnv4qbq@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803115131.w6hbhjvvkqnv4qbq@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-08-23 13:51:31, Jan Kara wrote:
> On Wed 02-08-23 17:41:25, Christoph Hellwig wrote:
> > The file system type is not a very useful holder as it doesn't allow us
> > to go back to the actual file system instance.  Pass the super_block instead
> > which is useful when passed back to the file system driver.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Nice, this is what I also wanted to eventually do :). Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

As a side note, after this patch we can also remove bdev->bd_super and
transition the two real users (mark_buffer_write_io_error() and two places
in ocfs2) to use bd_holder. Ext4 also uses bd_super but there it is really
pointless as we have the superblock directly available in that function
anyway.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
