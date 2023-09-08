Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0E3798671
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 13:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbjIHL2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 07:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjIHL2D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 07:28:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE31173B
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 04:27:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864D6C433C9;
        Fri,  8 Sep 2023 11:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694172479;
        bh=BtLelc3q2oPNmjzinHoYSpk7xou8GNDMnj0H2p2R/bE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0RgsCkabn75V0qj7fvNKBuBlvweUo3msG5+LwJ1pNa1pGmonNqx8qZ0DWRI+7Kvg
         mO2Oj7+OvoQa4gfcFrq/w1hmV2cpxdIpfrSe1aL9HpA+dkHJfXmquRe1Uv1AoxmSCg
         S6TfMdPpQipyiNIYC5ZMqm5oZd7Jsr7+ZjHUXFt/QFhbwjuxzLoLwjU1G+KloWYfEB
         bfZfVA0o2i6CNW9VsxZlFz6iFNoucSgCJuJDQVD3Xks/zS8JaaGrWDePy7aSqTMIbJ
         boeIuxeNpAgHCwgrElrD2v1rV5rlJP+zJUBl0Ecb+uQo5j1Cdd+AYG//0ww9fvzMob
         mHRgF3M+TvXAQ==
Date:   Fri, 8 Sep 2023 13:27:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Guenter Roeck <linux@roeck-us.net>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev
Subject: Re: [PATCH] ntfs3: drop inode references in ntfs_put_super()
Message-ID: <20230908-grundlos-morgig-e055946fde44@brauner>
References: <20230907-vfs-ntfs3-kill_sb-v1-1-ef4397dd941d@kernel.org>
 <20230908081213.GA8240@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230908081213.GA8240@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 08, 2023 at 10:12:13AM +0200, Christoph Hellwig wrote:
> On Thu, Sep 07, 2023 at 06:03:40PM +0200, Christian Brauner wrote:
> > Recently we moved most cleanup from ntfs_put_super() into
> > ntfs3_kill_sb() as part of a bigger cleanup. This accidently also moved
> > dropping inode references stashed in ntfs3's sb->s_fs_info from
> > @sb->put_super() to @sb->kill_sb(). But generic_shutdown_super()
> > verifies that there are no busy inodes past sb->put_super(). Fix this
> > and disentangle dropping inode references from freeing @sb->s_fs_info.
> 
> Sorry for the delay, I've been travelling.  Wouldn't it make more
> sense to just free it in ->kill_sb before calling kill_block_super?

ntfs3 has ntfs_evict_inodes() which might depend on the info in
sbi->s_fs_info to be valid. So calling it before kill_block_super()
risks putting resources that ntfs_evict_inodes() might depend on. Doing
it in ntfs_put_super() will prevent this from becoming an issue without
having to wade through all callchains. And since we can't get rid of
ntfs_put_super() anyway why bother risking that.
