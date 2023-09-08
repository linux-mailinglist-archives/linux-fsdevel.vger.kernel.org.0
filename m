Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34BA7983C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 10:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238779AbjIHIMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 04:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbjIHIMU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:12:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC811BD3
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 01:12:17 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CD94068B05; Fri,  8 Sep 2023 10:12:13 +0200 (CEST)
Date:   Fri, 8 Sep 2023 10:12:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev
Subject: Re: [PATCH] ntfs3: drop inode references in ntfs_put_super()
Message-ID: <20230908081213.GA8240@lst.de>
References: <20230907-vfs-ntfs3-kill_sb-v1-1-ef4397dd941d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907-vfs-ntfs3-kill_sb-v1-1-ef4397dd941d@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 07, 2023 at 06:03:40PM +0200, Christian Brauner wrote:
> Recently we moved most cleanup from ntfs_put_super() into
> ntfs3_kill_sb() as part of a bigger cleanup. This accidently also moved
> dropping inode references stashed in ntfs3's sb->s_fs_info from
> @sb->put_super() to @sb->kill_sb(). But generic_shutdown_super()
> verifies that there are no busy inodes past sb->put_super(). Fix this
> and disentangle dropping inode references from freeing @sb->s_fs_info.

Sorry for the delay, I've been travelling.  Wouldn't it make more
sense to just free it in ->kill_sb before calling kill_block_super?

Either way the fix looks good, and as Linus has already applied it
it's probably not worth arguing..

