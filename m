Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BAB59BBB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 10:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiHVIdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 04:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbiHVIdc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:33:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48CDA1AF;
        Mon, 22 Aug 2022 01:33:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0BCC41FAE9;
        Mon, 22 Aug 2022 08:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661157208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wNrEwveCSL7WYjQAcGTc/DSIBycLUN2ZDQvXyHz1zWo=;
        b=vWK48HYG4BgRPuC85lafn2WpteGe08QpmeMSY8dZRDbMMi67ySk2ZgxXWyd9iLtOxKnLET
        UcCXci9zlVMEE4hua2htQhBKXvBKBIEIWbm2irSoPYEDrl4ZUPCZ5eCFksDhns5vMcCIk2
        KDlg+W/iitMyVoMyfyLyJ07F+QucSMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661157208;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wNrEwveCSL7WYjQAcGTc/DSIBycLUN2ZDQvXyHz1zWo=;
        b=GDd78NkhVZC8uqOnzv7XAPpvzLhInFDp864DZTLnrMzc8PbiYCJYb+zTain/xwWv6at8pD
        mclaru2UTR3mYrBQ==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E92022C141;
        Mon, 22 Aug 2022 08:33:27 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 54059A066D; Mon, 22 Aug 2022 10:33:24 +0200 (CEST)
Date:   Mon, 22 Aug 2022 10:33:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Eric Biggers <ebiggers@kernel.org>,
        Lukas Czerner <lczerner@redhat.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com
Subject: Re: [PATCH v3 2/3] fs: record I_DIRTY_TIME even if inode already has
 I_DIRTY_INODE
Message-ID: <20220822083324.q7qcxtkfji66ho4l@quack3>
References: <20220812123727.46397-1-lczerner@redhat.com>
 <20220812123727.46397-2-lczerner@redhat.com>
 <YvaYC+LRFqQJT0U9@sol.localdomain>
 <20220816112124.taqvli527475gwv4@quack3>
 <YwHNTSUBEQFPgUhL@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwHNTSUBEQFPgUhL@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 20-08-22 23:14:37, Christoph Hellwig wrote:
> On Tue, Aug 16, 2022 at 01:21:24PM +0200, Jan Kara wrote:
> > 2) I_DIRTY_TIME flag passed to ->dirty_inode() callback. This is admittedly
> > bit of a hack. Currently XFS relies on the fact that the only time its
> > ->dirty_inode() callback needs to do anything is when VFS decides it is
> > time to writeback timestamps and XFS detects this situation by checking for
> > I_DIRTY_TIME in inode->i_state. Now to fix the race, we need to first clear
> > I_DIRTY_TIME in inode->i_state and only then call the ->dirty_inode()
> > callback (otherwise timestamp update can get lost). So the solution I've
> > suggested was to propagate the information "timestamp update needed" to XFS
> > through I_DIRTY_TIME in flags passed to ->dirty_inode().
> 
> Maybe we should just add a separate update_lazy_time method to make this
> a little more clear?

Yes, we could do that if people prefer this. Although I'd say that good
documentation at the place in __mark_inode_dirty() where this gets used and
in documentation of .dirty_inode might clear the confusion as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
