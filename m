Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2447591592
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 20:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbiHLSm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 14:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiHLSm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:42:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD31EAE9D1;
        Fri, 12 Aug 2022 11:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3063FB8233E;
        Fri, 12 Aug 2022 18:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D397C433C1;
        Fri, 12 Aug 2022 18:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660329743;
        bh=o3ElHzRdSZcCSXwS1Nf8yiNyuMgIgtGAtTgoix6Cnpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RdQQOP92JQJoO/K+b+Zrcm3aFdiaW1IMd8giHFNgFNhUVhqaMwV3K/gmSxAerry3F
         2V9NKEJVxRIGm5ebIQ5/0Dw0gDJazJ2s8h1LsepnMTlegOtK3Bxdu4w81W/rdWgjQC
         bsIJbqEyzuxPR2eOskZqPY5AgsCXdaXiE+czFIfKU9+EMv1f0axyiQ2sH8ZYkywn9Y
         abbCNppx1ycWy+TRIn8T63UxvQuBeirNZZ+1UtEb/3ZXlkia8jLZa5asbfrUlMfM6d
         Q8F3OmWL6gPbyAYaoj4w97OkPA3kglx5eXfjFdE5YTZStvv13NHgBLZhznNrF6ESz5
         kF8KsuqrjFQPg==
Date:   Fri, 12 Aug 2022 11:42:21 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jlayton@kernel.org,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 2/3] fs: record I_DIRTY_TIME even if inode already has
 I_DIRTY_INODE
Message-ID: <YvafDTI544HpvpWu@sol.localdomain>
References: <20220812123727.46397-1-lczerner@redhat.com>
 <20220812123727.46397-2-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812123727.46397-2-lczerner@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 12, 2022 at 02:37:26PM +0200, Lukas Czerner wrote:
> Currently the I_DIRTY_TIME will never get set if the inode already has
> I_DIRTY_INODE with assumption that it supersedes I_DIRTY_TIME.  That's
> true, however ext4 will only update the on-disk inode in
> ->dirty_inode(), not on actual writeback. As a result if the inode
> already has I_DIRTY_INODE state by the time we get to
> __mark_inode_dirty() only with I_DIRTY_TIME, the time was already filled
> into on-disk inode and will not get updated until the next I_DIRTY_INODE
> update, which might never come if we crash or get a power failure.
> 
> The problem can be reproduced on ext4 by running xfstest generic/622
> with -o iversion mount option.
> 
> Fix it by allowing I_DIRTY_TIME to be set even if the inode already has
> I_DIRTY_INODE. Also make sure that the case is properly handled in
> writeback_single_inode() as well. Additionally changes in
> xfs_fs_dirty_inode() was made to accommodate for I_DIRTY_TIME in flag.
> 
> Thanks Jan Kara for suggestions on how to make this work properly.
> 
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Sorry for so many separate emails.  One more thought: isn't there a much more
straightforward fix to this bug that wouldn't require changing the semantics of
the inode flags: on __mark_inode_dirty(I_DIRTY_TIME), if the inode already has
i_state & I_DIRTY_INODE, just call ->dirty_inode with i_state & I_DIRTY_INODE?
That would fix the bug by making the filesystem update the on-disk inode.

Perhaps you aren't doing that in order to strictly maintain the semantics of
'lazytime', where timestamp updates are only persisted at certain times?  Is
this useful even in the short window of time that an inode is dirty?

- Eric
