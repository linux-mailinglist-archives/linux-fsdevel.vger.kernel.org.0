Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A494A758848
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 00:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjGRWKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 18:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjGRWKq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:10:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF521998;
        Tue, 18 Jul 2023 15:10:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 792276122C;
        Tue, 18 Jul 2023 22:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B545C433C7;
        Tue, 18 Jul 2023 22:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689718242;
        bh=N9VprbmcyfsUGUzo3F8QagSXSUpuZxEJLOZz4+DJsd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PuNa0R7001LENL2JRD37XvuwidpUxdIf0B9ioJPshgsa+WiqpKDW8R8g1hBEBdfUM
         RCbwjD5W5l9Bd6m6m5o3cAAxyasl5fSYIxdJQZL5mJUzfagFbBqj1/Y7HzbnPDrSq/
         cEK7/MtSWLIVrQGIC/nrl6B+z1nkQuEdi4grmH8cpnJzueVs4xGkFY/sATd5KLCmbD
         FsT+XS6j1Imo1VbpTY0FRpthfugptFReBBQQ/d0IyXtYPUjfTRG8+3pY/DJH6nlvxB
         RQFHii7kFOTxMEUNlcHv8m9+/AUy6aN/uACsh6es5Yd4+n4X92i6Z7CVoSfRj2UCX9
         rt8gq3dXyjOGw==
Date:   Tue, 18 Jul 2023 15:10:40 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 4/7] libfs: Support revalidation of encrypted
 case-insensitive dentries
Message-ID: <20230718221040.GA1005@sol.localdomain>
References: <20230422000310.1802-1-krisman@suse.de>
 <20230422000310.1802-5-krisman@suse.de>
 <20230714053135.GD913@sol.localdomain>
 <87h6q1580a.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6q1580a.fsf@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 18, 2023 at 03:34:13PM -0400, Gabriel Krisman Bertazi wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > On Fri, Apr 21, 2023 at 08:03:07PM -0400, Gabriel Krisman Bertazi wrote:
> >> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> >> 
> >> Preserve the existing behavior for encrypted directories, by rejecting
> >> negative dentries of encrypted+casefolded directories.  This allows
> >> generic_ci_d_revalidate to be used by filesystems with both features
> >> enabled, as long as the directory is either casefolded or encrypted, but
> >> not both at the same time.
> >> 
> >> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >> ---
> >>  fs/libfs.c | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/fs/libfs.c b/fs/libfs.c
> >> index f8881e29c5d5..0886044db593 100644
> >> --- a/fs/libfs.c
> >> +++ b/fs/libfs.c
> >> @@ -1478,6 +1478,9 @@ static inline int generic_ci_d_revalidate(struct dentry *dentry,
> >>  		const struct inode *dir = READ_ONCE(parent->d_inode);
> >>  
> >>  		if (dir && needs_casefold(dir)) {
> >> +			if (IS_ENCRYPTED(dir))
> >> +				return 0;
> >> +
> >
> > Why not allow negative dentries in case-insensitive encrypted directories?
> > I can't think any reason why it wouldn't just work.
> 
> TBH, I'm not familiar with the details of combined encrypted+casefold
> support to be confident it works.This patch preserves the current
> behavior of disabling them for encrypted+casefold directories.

Not allowing that combination reduces the usefulness of this patchset.
Note that Android's use of casefold is always combined with encryption.

> I suspect it might require extra work that I'm not focusing on this
> patchset.  For instance, what should be the order of
> fscrypt_d_revalidate and the checks I'm adding here?

Why would order matter?  If either "feature" wants the dentry to be invalidated,
then the dentry gets invalidated.

> Note we will start creating negative dentries in casefold directories after
> patch 6/7, so unless we disable it here, we will start calling
> fscrypt_d_revalidate for negative+casefold.

fscrypt_d_revalidate() only cares about the DCACHE_NOKEY_NAME flag, so that's
not a problem.

> 
> Should I just drop this hunk?  Unless you are confident it works as is, I
> prefer to add this support in stages and keep negative dentries of
> encrypted+casefold directories disabled for now.

Unless I'm missing something, I think you're overcomplicating it.  It should
just work if you don't go out of your way to prohibit this case.  I.e., just
don't add the IS_ENCRYPTED(dir) check to generic_ci_d_revalidate().

- Eric
