Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9021A6E4244
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 10:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjDQIMe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 04:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjDQIMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:12:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8CC46AF;
        Mon, 17 Apr 2023 01:12:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70B5B62001;
        Mon, 17 Apr 2023 08:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3519AC433D2;
        Mon, 17 Apr 2023 08:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681719103;
        bh=8MiZRL2DhtFX41sGqGhRmX2BDJeuPZ5YL+edsTjESe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xfzb7kUNo5mLEiE/9fXLQ1n4Bds+EODxkboUCgWtJX+kwncJH8zeoo9ohDNMLpsJp
         w2yfEobVpl04zTjNnfzSaPqv83e5QwJ3d/p7maLcpPa/aXvPh6GLVbVT0+cTl6n5/a
         w7gcU/Z15G97bLYbnIDFt2tRZmrscMeq7S4w2OCLkvvv3KU1NaXhl28o5uxExde4zg
         3u8lbfPao9AHuEmulusYNBZZpRNQZiVMT2Ur73mHNR6ytdFn0XwzhcF/ORypiRMJJB
         z3O+5vsWOk6+/p12FC8yY2QUXGzpt8JPLvC797hd8M6l1sSs0WpSpyQaz4xP/yjulF
         L6MhgJy5Ukx1Q==
Date:   Mon, 17 Apr 2023 10:11:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Paul Moore <paul@paul-moore.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after
 writes
Message-ID: <20230417-umlaufen-chirurgisch-a60642cd34e9@brauner>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
 <e2455c0e-5a17-7fc1-95e3-5f2aca2eb409@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2455c0e-5a17-7fc1-95e3-5f2aca2eb409@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 16, 2023 at 09:57:10PM -0400, Stefan Berger wrote:
> 
> 
> On 4/7/23 09:29, Jeff Layton wrote:
> > > > > > 
> > > > > > I would ditch the original proposal in favor of this 2-line patch shown here:
> > > > > > 
> > > > > > https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468-ecbde3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
> > > 
> > > We should cool it with the quick hacks to fix things. :)
> > > 
> > 
> > Yeah. It might fix this specific testcase, but I think the way it uses
> > the i_version is "gameable" in other situations. Then again, I don't
> > know a lot about IMA in this regard.
> > 
> > When is it expected to remeasure? If it's only expected to remeasure on
> > a close(), then that's one thing. That would be a weird design though.
> 
> IMA should remeasure the file when it has visibly changed for another thread or process.
> 
> 
> > > > -----------------------8<---------------------------
> > > > 
> > > > [PATCH] IMA: use vfs_getattr_nosec to get the i_version
> > > > 
> > > > IMA currently accesses the i_version out of the inode directly when it
> > > > does a measurement. This is fine for most simple filesystems, but can be
> > > > problematic with more complex setups (e.g. overlayfs).
> > > > 
> > > > Make IMA instead call vfs_getattr_nosec to get this info. This allows
> > > > the filesystem to determine whether and how to report the i_version, and
> > > > should allow IMA to work properly with a broader class of filesystems in
> > > > the future.
> > > > 
> > > > Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > 
> > > So, I think we want both; we want the ovl_copyattr() and the
> > > vfs_getattr_nosec() change:
> > > 
> > > (1) overlayfs should copy up the inode version in ovl_copyattr(). That
> > >      is in line what we do with all other inode attributes. IOW, the
> > >      overlayfs inode's i_version counter should aim to mirror the
> > >      relevant layer's i_version counter. I wouldn't know why that
> > >      shouldn't be the case. Asking the other way around there doesn't
> > >      seem to be any use for overlayfs inodes to have an i_version that
> > >      isn't just mirroring the relevant layer's i_version.
> > 
> > It's less than ideal to do this IMO, particularly with an IS_I_VERSION
> > inode.
> > 
> > You can't just copy up the value from the upper. You'll need to call
> > inode_query_iversion(upper_inode), which will flag the upper inode for a
> > logged i_version update on the next write. IOW, this could create some
> > (probably minor) metadata write amplification in the upper layer inode
> > with IS_I_VERSION inodes.
> > 
> > 
> > > (2) Jeff's changes for ima to make it rely on vfs_getattr_nosec().
> > >      Currently, ima assumes that it will get the correct i_version from
> > >      an inode but that just doesn't hold for stacking filesystem.
> > > 
> > > While (1) would likely just fix the immediate bug (2) is correct and
> > > _robust_. If we change how attributes are handled vfs_*() helpers will
> > > get updated and ima with it. Poking at raw inodes without using
> > > appropriate helpers is much more likely to get ima into trouble.
> > 
> > This will fix it the right way, I think (assuming it actually works),
> > and should open the door for IMA to work properly with networked
> > filesystems that support i_version as well.
> > 
> > Note that there Stephen is correct that calling getattr is probably
> > going to be less efficient here since we're going to end up calling
> > generic_fillattr unnecessarily, but I still think it's the right thing
> > to do.
> 
> I was wondering whether to use the existing inode_eq_iversion() for all
> other filesystems than overlayfs, nfs, and possibly other ones (which ones?)
> where we would use the vfs_getattr_nosec() via a case on inode->i_sb->s_magic?
> If so, would this function be generic enough to be a public function for libfs.c?

That's just an invitation for bugs and maintenance headaches. Just call
vfs_getattr_nosec() directly and measure the performance impact before
trying to optimize this. If you see performance impact that is worth
mentioning then we can explore other options such as allowing
->getattr() to only query for i_version and nothing else.
