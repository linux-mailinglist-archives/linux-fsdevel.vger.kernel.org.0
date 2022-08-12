Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F4E591568
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 20:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbiHLSUl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 14:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiHLSUj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:20:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B26B4D807;
        Fri, 12 Aug 2022 11:20:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEE3B61765;
        Fri, 12 Aug 2022 18:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188F4C433D6;
        Fri, 12 Aug 2022 18:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660328438;
        bh=X2PIlKbqhvmZj4CcZUAZ/aUM7rnGwIsXQ2MW7MrU+3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BhhOufxLdINCLlR2giV5zCFghE8qbNuq+q4c1jluGot6825qvTk+D9TL3D+2mocJC
         LCfXBbR+w/vhBV+SXg92M591/OTjMlu9DbkGkvpxYgnIm+ZQYOpRXlVJH9+Hj4eB/y
         WU3qpOV/U7PuMTYduVZPlV0w/XWmmHFNzyecM2rehws0DQ3KdE+DDbPhNwvFpT27ly
         ts9MipYg0mVN22L1RJXCrXSYjgsbPHQVh86QMr5vXqoOosWIzetzQOLXNhPnqwul2b
         QeDdn9bBczEErdx/fKf8cQTGSST0poaBJ1r5YFxVWoVLkqLTz5yrs6+e2zHletW0MS
         6giM6GyUqlRMg==
Date:   Fri, 12 Aug 2022 11:20:36 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, jlayton@kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 2/3] fs: record I_DIRTY_TIME even if inode already has
 I_DIRTY_INODE
Message-ID: <YvaZ9Jwq5Awu9tl3@sol.localdomain>
References: <20220803105340.17377-1-lczerner@redhat.com>
 <20220803105340.17377-2-lczerner@redhat.com>
 <YuzPWfCuVNkmar2n@sol.localdomain>
 <20220805122306.anavrrmt6lqwd2yt@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805122306.anavrrmt6lqwd2yt@fedora>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 02:23:06PM +0200, Lukas Czerner wrote:
> > 
> > Also what is the precise meaning of the flags argument to ->dirty_inode now?
> > 
> > 	sb->s_op->dirty_inode(inode,
> > 			flags & (I_DIRTY_INODE | I_DIRTY_TIME));
> > 
> > Note that dirty_inode is documented in Documentation/filesystems/vfs.rst.
> 
> Don't know. It alredy don't mention I_DIRTY_SYNC that can be there as
> well.

Well, it didn't really need to because there were only two possibilities:
datasync and not datasync.  This patch changes that.

> Additionaly it can have I_DIRTY_TIME to inform the fs we have a
> dirty timestamp as well (in case of lazytime).

This is introduced by this patch.

- Eric
