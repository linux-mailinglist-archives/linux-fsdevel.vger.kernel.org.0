Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583566E460F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 13:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjDQLKK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 07:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjDQLKI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:10:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB707A94;
        Mon, 17 Apr 2023 04:09:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 49BA51FDC8;
        Mon, 17 Apr 2023 11:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681729642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1b4eVfUfM/pJDL5zKv6ghGKqKzTuxwqB/gGhplYj7JQ=;
        b=DlbfAtUQ1ihCadx1GVXlkar7cnvlhWlMPI7cUuwjralUFZVULWXDfVx425oYSolVNoqRk0
        XfHvpu11IZBfhGmfYlOVYYktRyJbYRmYbmmbrv4wGNEg+vMgJpky5DE7lEByKBmu1tXZWR
        333b4KEF9i24WHHnZfsFWslln/ZsvSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681729642;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1b4eVfUfM/pJDL5zKv6ghGKqKzTuxwqB/gGhplYj7JQ=;
        b=FH5U9ys8HveETOsSHVjuCgFKfo7MhJTf09EU5756I3mdWyREXgq+9tI8cjP1q3+wRxKYiL
        EXTB0aYMuaXxcPDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3110513319;
        Mon, 17 Apr 2023 11:07:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5Gb3C2ooPWRPHAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 17 Apr 2023 11:07:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 801C9A0744; Mon, 17 Apr 2023 13:07:21 +0200 (CEST)
Date:   Mon, 17 Apr 2023 13:07:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv5 2/9] fs/buffer.c: Add generic_buffer_fsync
 implementation
Message-ID: <20230417110721.2c6ya5v3hz6grruc@quack3>
References: <cover.1681639164.git.ritesh.list@gmail.com>
 <7a7c48bf0a91d00f1114db2dc6b1269c25f7513b.1681639164.git.ritesh.list@gmail.com>
 <20230417110149.mhrksh4owqkfw5pa@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417110149.mhrksh4owqkfw5pa@quack3>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 17-04-23 13:01:49, Jan Kara wrote:
> On Sun 16-04-23 15:38:37, Ritesh Harjani (IBM) wrote:
> > Some of the higher layers like iomap takes inode_lock() when calling
> > generic_write_sync().
> > Also writeback already happens from other paths without inode lock,
> > so it's difficult to say that we really need sync_mapping_buffers() to
> > take any inode locking here. Having said that, let's add
> > generic_buffer_fsync() implementation in buffer.c with no
> > inode_lock/unlock() for now so that filesystems like ext2 and
> > ext4's nojournal mode can use it.
> > 
> > Ext4 when got converted to iomap for direct-io already copied it's own
> > variant of __generic_file_fsync() without lock. Hence let's add a helper
> > API and use it both in ext2 and ext4.
> > 
> > Later we can review other filesystems as well to see if we can make
> > generic_buffer_fsync() which does not take any inode_lock() as the
> > default path.
> > 
> > Tested-by: Disha Goel <disgoel@linux.ibm.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> There is a problem with generic_buffer_fsync() that it does not call
> blkdev_issue_flush() so the caller is responsible for doing that. That's
> necessary for ext2 & ext4 so fine for now.

Actually a slight correction: ext2 could use a variant of
generic_buffer_fsync() that flushes disk caches.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
