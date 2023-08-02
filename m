Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BF376C7D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 10:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjHBICy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 04:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjHBICj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:02:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2985BAC
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 01:02:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAF866181B
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 08:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD5DC433C8;
        Wed,  2 Aug 2023 08:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690963358;
        bh=TCKGC5CkXu6iTQYVRiVKk+euT4LgMsouGP8uJMtTUiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RfnzkcVEUpGNGjLfHIz8L3qiUdSd4tBp74Zkvafl7pAXMuqeuH7YgB2+kAlnmO7Xd
         d7CVZQ8BMztoRMf3sqQEq/SuZgkV2Wo8p/y63YhT2asrrEcCH9CB5K0xByEG6H/HWf
         iW6/GFynP1juZuzIkB+mX4iGLt2DRKKDk8f3HblSZI0ZrsHq3nTIJToMe/YT26v7dK
         +3aAlK8WtPRrVi6GdQdVkeWSmzSoG2+jRhV7JuPk7UzNwS9d0B9BbQMiHBXDpfc3CW
         vf3Hr1HJ4/pQ/jn9dSMEHmgWQOXFbwspts0mTSiBG8viqqfonB2vsMdpAbXeyPasv6
         wDg0L7OaEZlGw==
Date:   Wed, 2 Aug 2023 10:02:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] fs: add vfs_cmd_create()
Message-ID: <20230802-nutzwert-evaluieren-4cb4b1184494@brauner>
References: <20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org>
 <20230801-vfs-super-exclusive-v1-2-1a587e56c9f3@kernel.org>
 <20230801154333.GC12035@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230801154333.GC12035@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 05:43:33PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 01, 2023 at 03:09:01PM +0200, Christian Brauner wrote:
> > Split the steps to create a superblock into a tiny helper. This will
> > make the next patch easier to follow.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/fsopen.c | 45 +++++++++++++++++++++++++++++++--------------
> >  1 file changed, 31 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/fsopen.c b/fs/fsopen.c
> > index fc9d2d9fd234..af2ff05dcee5 100644
> > --- a/fs/fsopen.c
> > +++ b/fs/fsopen.c
> > @@ -209,6 +209,36 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
> >  	return ret;
> >  }
> >  
> > +static int vfs_cmd_create(struct fs_context *fc)
> > +{
> > +	struct super_block *sb;
> > +	int ret;
> > +
> > +	if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
> > +		return -EBUSY;
> > +
> > +	if (!mount_capable(fc))
> > +		return -EPERM;
> > +
> > +	fc->phase = FS_CONTEXT_CREATING;
> > +
> > +	ret = vfs_get_tree(fc);
> > +	if (ret)
> > +		return ret;
> 
> The error handling here now fails to set FS_CONTEXT_FAILED.
> 
> Also at a very minimum I'd also want a helper for the reconfigure
> case to mirror this one.  But I think the whole sys_fsconfig and

That's acceptable.
